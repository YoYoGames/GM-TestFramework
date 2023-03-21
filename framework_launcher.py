import re
import argparse
import subprocess
import time
import logging
import requests
import zipfile
import io
import random
import os
import winreg
import json
import shutil
import yaml
import socket

# DON'T CHANGE THESE (use external config file instead)
DEFAULT_CONFIG = {
    "Launcher.accessKey": None,
    "Launcher.userFolder": None,
    "Launcher.runtimeVersion": None,
    "Launcher.html5Runner": None,

    "Launcher.runners": [ "vm" ],
    "Launcher.platforms": [ "windows" ],
    "Launcher.feed": "https://gms.yoyogames.com/Zeus-Runtime-Nocturnus-I.rss",
    "Launcher.project": "projects\\xUnit\\xUnit.yyp",

    "Logger.level": 10,
    
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests",

    "$$parameters$$.isSandboxed": True
}

REDACTED_WORDS = ['-ak=', 'accessKey']
REDACTED_MESSAGE = "<redacted to prevent expesure of private content>"

FAIL_MESSAGE = '[ERROR] Not all unit tests succeeded.'

ARGS_PLATFORMS = ['windows', 'mac', 'linux', 'android', 'ios', 'ipad', 'tvos', 'html5']
ARGS_RUNNERS = ['vm', 'yyc']

IGOR_URL = 'https://gms.yoyogames.com/igor_win-x64.zip'

DRIVER_DETECT_BASE_URL = 'https://chromedriver.storage.googleapis.com/LATEST_RELEASE_'
DRIVER_DOWNLOAD_BASE_URL = 'https://chromedriver.storage.googleapis.com/'

ROOT_DIR = os.path.abspath('.')

USER_DIR = os.path.join(ROOT_DIR, 'user')
DEFAULTS_DIR = os.path.join(ROOT_DIR, 'defaults')
PROJECTS_DIR = os.path.join(ROOT_DIR, 'projects')
WORKSPACE_DIR = os.path.join(ROOT_DIR, 'workspace')

IGOR_DIR = os.path.join(WORKSPACE_DIR, 'igor')
CACHE_DIR = os.path.join(WORKSPACE_DIR, 'cache')
OUTPUT_DIR = os.path.join(WORKSPACE_DIR, 'output', 'test.win')
RUNTIME_DIR = os.path.join(WORKSPACE_DIR, 'runtime')

FAIL_PATH = os.path.join(WORKSPACE_DIR, '.fail')
META_PATH = os.path.join(WORKSPACE_DIR, '.meta')

DEFAULT_CONFIG_PATH = os.path.join(DEFAULTS_DIR, 'config.json')

LOG_PATH = os.path.join(WORKSPACE_DIR, 'test_0.log')
RESULTS_PATH = os.path.join(WORKSPACE_DIR, 'results.json')

IGOR_PATH = os.path.join(IGOR_DIR, 'igor.exe')

VERSION_REGEX = re.compile(r'Version (\d+\.\d+\.\d+\.\d+)')
SANDBOXED_PLATFORMS = ['windows', 'mac', 'linux']

def configure_logging(level=logging.INFO, format='%(asctime)s [%(levelname)s]: %(message)s', datefmt='%Y-%m-%d %H:%M:%S'):

    # Remove all handlers associated with the root logger object.
    for handler in logging.root.handlers[:]:
        logging.root.removeHandler(handler)

    class MaskSensitiveInfoFilter(logging.Filter):
        def filter(self, record):
            # Check if the log record contains sensitive information
            if any(key in record.getMessage() for key in REDACTED_WORDS):
                # If it does, redact the password
                record.msg = record.msg.replace(record.getMessage(), '<redacted>')
            return True

   # Create a console handler and add it to the root logger
    console_handler = logging.StreamHandler()
    logging.getLogger().addHandler(console_handler)

    # Set the log level to DEBUG
    logging.getLogger().setLevel(level)

    # Apply settings
    # logging.basicConfig(level=level, format=format, datefmt=datefmt)
    formatter = logging.Formatter(format, datefmt)
    console_handler.setFormatter(formatter)

    # Add the filter to the console handler
    console_handler.addFilter(MaskSensitiveInfoFilter())

def generate_random_number():
    return random.randint(111111111, 999999999)

def escape_path_for_json(path):
    return path.replace("\\", "\\\\\\\\")

def replace_placeholders(file_path, placeholders, output_path):
    logging.info(f'Updating placeholders in file: {file_path}')
    with open(file_path, 'r') as file:
        content = file.read()

    for placeholder, value in placeholders.items():
        logging.info(f"Replacing placeholder '{placeholder}' with value '{value}'")
        content = re.sub(re.escape(placeholder), re.escape(value), content)

    with open(output_path, 'w') as file:
        logging.info(f'Saving updated content to disk')
        file.write(content)

def copy_file(src, dst):
    try:
        logging.info(f'Copying file from {src} to {dst}')
        shutil.copy2(src, dst)
        logging.info(f'File copied successfully')
    except Exception as e:
        logging.error(f'An error occurred while copying the file: {e}')
    
    return dst

def copy_folder(src, dest, contents_only=False):
    if not os.path.exists(src):
        logging.error(f"Source folder '{src}' does not exist or is not accessible.")
        return

    if not os.path.isdir(src):
        logging.error(f"Source '{src}' is not a folder.")
        return

    # Make sure the destination folder exists
    os.makedirs(dest, exist_ok=True)

    try:
        if contents_only:
            # Copy only the contents of the source folder
            for item in os.listdir(src):
                item_path = os.path.join(src, item)
                if os.path.isdir(item_path):
                    shutil.copytree(item_path, os.path.join(dest, item), dirs_exist_ok=True)
                else:
                    shutil.copy2(item_path, dest)
        else:
            # Copy the folder and its content
            shutil.copytree(src, os.path.join(dest, os.path.basename(src)), dirs_exist_ok=True)

        logging.info(f"Copied {'contents of' if contents_only else 'folder'} '{src}' to '{dest}'.")
    except Exception as e:
        logging.error(f"Failed to copy {'contents of' if contents_only else 'folder'} '{src}' to '{dest}': {e}")
    
    return dest

def remove_directory(directory):
    if os.path.exists(directory):
        try:
            shutil.rmtree(directory)
            logging.info(f'Successfully removed directory: {directory}')
        except OSError as e:
            logging.error(f'Error removing directory: {directory}')
            logging.error(e)
    else:
        logging.warning(f'Directory does not exist: {directory}')

def ensure_directories_exist(directories):
    for directory in directories:
        if not os.path.exists(directory):
            logging.info(f'Creating directory: {directory}')
            os.makedirs(directory)
        else:
            logging.info(f'Directory already exists: {directory}')

def change_directory(path):
    logging.info(f'Changing directory to {path}')
    try:
        os.chdir(path)
        logging.info(f'Successfully changed directory to {os.getcwd()}')
    except Exception as e:
        logging.error(f'Failed to change directory: {e}')

def download_and_extract(url, extract_path):
    # Download the file
    logging.info('Downloading file from URL: %s', url)
    response = requests.get(url)
    logging.info('Download complete')

    # Open the file in memory
    with zipfile.ZipFile(io.BytesIO(response.content)) as zf:
        # Extract the file to the specified path
        logging.info('Extracting file to: %s', extract_path)
        zf.extractall(extract_path)
        logging.info('Extraction complete')

def run_exe(exe_path, args):
    logging.info(f'Running {exe_path} with arguments {args}')
    process = subprocess.Popen([exe_path] + args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    stdout_output = ''

    # Don't print the level
    configure_logging(format='%(asctime)s %(message)s')
    while True:
        stdout_line = process.stdout.readline().decode('utf-8')
        if not stdout_line and process.poll() is not None:
            break
        stripped_output = stdout_line.strip()
        if stripped_output != '':
            stdout_output += stdout_line
            logging.info(stripped_output)
    
    # Return logger to default configuration
    configure_logging()
    logging.info(f'Process completed')
    return stdout_output

def query_url(url):
    logging.info(f'Querying URL: {url}')
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text
        else:
            logging.error(f'Error querying URL {url}: {response.status_code}')
    except Exception as e:
        logging.error(f'Error querying URL {url}: {str(e)}')
    return None

def load_json_file(file_path):
    logging.info(f'Loading JSON file: {file_path}')
    try:
        with open(file_path, 'r') as file:
            data = yaml.safe_load(file.read())
            logging.info(f'JSON file loaded successfully')
            return data
    except FileNotFoundError:
        logging.error(f'JSON file not found: {file_path}')
    except json.JSONDecodeError as error:
        logging.error(f'Error decoding JSON file: {error}')
    return None

def save_to_json_file(obj, file_path):
    logging.info(f'Saving object to {file_path}')
    try:
        with open(file_path, 'w') as f:
            json.dump(obj, f, indent=4)
        logging.info(f'Object saved successfully to {file_path}')
    except Exception as e:
        logging.error(f'Error while saving object to {file_path}: {e}')

def merge_dict(new, base):
    output = base.copy()
    for key, value in new.items():
        if key in base:
            logging.info(f'Overriding value for key {key}: {base[key]} -> {value}')
        output[key] = value
    return output

def valid_version(version):
    pattern = re.compile(r'^\d+\.\d+\.\d+\.\d+$')
    if not pattern.match(version):
        raise argparse.ArgumentTypeError('Invalid version format. Use <Major>.<Minor>.<Build>.<Revision>')
    return version

def valid_path(path):    
    resolved_path = os.path.abspath(path)
    if not os.path.exists(resolved_path):
        raise argparse.ArgumentTypeError(f'Invalid path provided. This path can be relative or absolute but must exist.')
    return resolved_path

def array_contains_any(arr1, arr2):
    return any(x in arr1 for x in arr2)

def parse_arguments(defaults):
    parser = argparse.ArgumentParser(description='Run hybrid framework')

    default_platforms = defaults['Launcher.platforms']
    default_runners = defaults['Launcher.runners']
    default_feed = defaults['Launcher.feed']

    # Required
    parser.add_argument('-p', '--platforms', type=str, required=False, choices=ARGS_PLATFORMS, nargs='+', help=f'Platform(s) to run the test on (defaults <{default_platforms}>)')
    parser.add_argument('-r', '--runners', type=str, required=False, choices=ARGS_RUNNERS, nargs='+', help=f'Runner(s) to run the test on (defaults <{default_runners}>)')
    parser.add_argument('-f', '--feed', type=str, required=False, help=f'RSS feed to use (defaults to <{default_feed}>)')
    parser.add_argument('-uf', '--userFolder', type=valid_path, required=False, help='The path to the GameMaker\' user folder')
    parser.add_argument('-ak', '--accessKey', type=str, required=False, help='The access key to download GameMaker\'s license')

    # Optional
    parser.add_argument('-cf', '--configFile', type=valid_path, required=False, help='The config file to be used by the launcher')
    parser.add_argument('-rv', '--runtimeVersion', type=valid_version, default=None, help='Runner version to use (defaults to <latest>)')

    # Custom Runners
    parser.add_argument('-h5r', '--html5Runner', type=valid_path, required=False, help='A custom HTML5 runner to use instead of the runtime one')

    parsed_args = parser.parse_args()

    # Arguments are considered the default to beging with
    args = defaults.copy()

    # Load data from config file (if there is one)
    if parsed_args.configFile:
        config = load_json_file(parsed_args.configFile)
        args = merge_dict(config, defaults)

    # Auxiliary function that will make sure the arg exists (either from command line or from config file)
    def args_ensure_exists(args, path, parsed_args, name, param):
        if not args[path]:
            if not getattr(parsed_args, name):
                parser.error(f"argument -{param}/--{param} is required or should be passed from config file (-cf/--cf) as: '{path}'")
            args[path] = getattr(parsed_args, name)

    args_ensure_exists(args, 'Launcher.platforms', parsed_args, 'platforms', 'p')
    args_ensure_exists(args, 'Launcher.runners', parsed_args, 'runners', 'r')
    args_ensure_exists(args, 'Launcher.feed', parsed_args, 'feed', 'f')
    args_ensure_exists(args, 'Launcher.userFolder', parsed_args, 'userFolder', 'uf')
    args_ensure_exists(args, 'Launcher.accessKey', parsed_args, 'accessKey', 'ak')

    return args

def check_file_exists(file_path):
    if os.path.exists(file_path):
        logging.info(f"File '{file_path}' exists")
        return True
    else:
        logging.warning(f"File '{file_path}' does not exist")
        return False

def build_target(platform, devices_data):

    devices = devices_data[ platform.lower() ]
    device = "Local" if not devices else next(iter(devices))

    return f'{platform}|{device}'

def get_local_ip_address():
    # Get the hostname
    hostname = socket.gethostname()

    # Get the IP address for the hostname
    try:
        ip_address = socket.gethostbyname(hostname)
        logging.info(f"Local IP address: {ip_address}")
        return ip_address
    except socket.gaierror:
        logging.error("Failed to retrieve local IP address")
        return None

# Igor

def igor_get_license(access_key, output_path):
    run_exe(IGOR_PATH, [f'-ak={access_key}', f'-of={output_path}', 'Runtime', 'FetchLicense'])

def igor_get_runtime_version(user_folder, feed, version):
    cacheBust = generate_random_number()
    args = [f'/uf={user_folder}', f'/ru={feed}?cachebust={cacheBust}', 'Runtime', 'Info']
    if version:
        args.append(version)
    result = run_exe(IGOR_PATH, args)

    match = VERSION_REGEX.search(result)
    if match:
        version = match.group(1)
        return version
    else:
        return None

def igor_install_runtime(user_folder, feed, version, platforms):

    cacheBust = generate_random_number()
    modules = ','.join(platforms).lower()

    args = [f'/uf={user_folder}', f'/ru={feed}?cachebust={cacheBust}', f'/rp={RUNTIME_DIR}', f'/m={modules}', 'Runtime', 'Install', version]
    run_exe(IGOR_PATH, args)

    return os.path.join(RUNTIME_DIR, f'runtime-{version}')

def igor_run_tests(igor_path, project_file, user_folder, runtime_path, targets, runner = None, verbosity_level = 4):

    args = []
    for _ in range(verbosity_level):
        args.append('/v')
    
    args += [f'/uf={user_folder}', f'/rp={runtime_path}', f'/cache={CACHE_DIR}', f'/of={OUTPUT_DIR}', f'/target={targets}']
    if runner != None:
        args += [f'/r={runner}']
    
    args += ['Tests', 'RunTests', project_file]

    os.chdir(WORKSPACE_DIR)
    run_exe(igor_path, args)
    os.chdir(ROOT_DIR)

# HTML5 Specific

def download_chrome_driver(runtime_path):

    # Get Chrome version
    try:
        key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, 'SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Google Chrome')
        chrome_version = winreg.QueryValueEx(key, 'Version')[0]
    except:
        logging.error(f'Unable to find Chrome version')
        return None

    # Compute relevate version (extract W.X.Y from W.X.Y.Z)
    relevant_version = chrome_version
    match = re.search(r'\d+\.\d+\.\d+', chrome_version)
    if match:
        relevant_version = match.group()
        logging.info(f'Relevant Chrome version: {relevant_version}')
    else:
        logging.error(f'Could not extract relevat Chrome version from {chrome_version}')
        return None

    # Get Chrome driver version
    driver_version_url = f'{DRIVER_DETECT_BASE_URL}{relevant_version}'
    driver_version = query_url(driver_version_url)

    if driver_version == None:
        return None
    
    # Build download link
    version_url = f'{driver_version}/chromedriver_win32.zip'
    download_url = DRIVER_DOWNLOAD_BASE_URL + version_url

    # Download and extract the driver
    extract_path = os.path.join(runtime_path, 'bin', 'igor', 'windows', 'x64')
    download_and_extract(download_url, extract_path)

    # Return 'chromedriver.exe' path
    return os.path.join(extract_path, 'chromedriver.exe')

# Android Specific

def start_android_emulator(sdk_path):

    # Get 'emulator' and 'adb' paths
    emulator_path = os.path.join(sdk_path, 'emulator', 'emulator.exe')
    adb_path = os.path.join(sdk_path, 'platform-tools', 'adb.exe')

    # Get emulators list
    avd_list = subprocess.run([emulator_path, '-list-avds'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    avds = avd_list.stdout.decode().strip().splitlines()

    if len(avds) == 0:
        logging.error('No Android Virtual Devices found.')
        return None

    # Start running the first emulator available
    emulator_name = avds[0]
    logging.info(f"Starting AVD: {emulator_name}")
    with open(os.devnull, "w") as f:
        subprocess.Popen([emulator_path, '-avd', emulator_name], stdout=f, stderr=f)
    logging.info('Emulator started')

    # Wait for the emulator to fully boot
    logging.info('Waiting for emulator to fully boot')
    boot_check = subprocess.run([adb_path, 'shell', 'getprop', 'sys.boot_completed'], capture_output=True)
    while boot_check.stdout.strip() != b'1':
        time.sleep(1)
        boot_check = subprocess.run([adb_path, 'shell', 'getprop', 'sys.boot_completed'], capture_output=True)
    logging.info('Emulator is fully booted')

    #Return the emulator id number
    result = subprocess.check_output([adb_path, 'devices'], shell=True).decode("utf-8")
    lines = result.strip().split("\n")[1:]
    emulators = [line.split("\t")[0] for line in lines if "emulator" in line]
    if len(emulators) == 0:
        logging.error('No running emulators found.')
        return None
    else:
        emulator_id = emulators[0]
        logging.info(f'Running emulator id: {emulator_id}')
        return emulator_id

def stop_android_emulator(sdk_path):
    # Stop the emulator
    adb_path = os.path.join(sdk_path, 'platform-tools', 'adb.exe')

    logging.info('Stopping Android emulator')
    subprocess.run([adb_path, 'emu', 'kill'])
    logging.info('Emulator stopped')

# Servers

def start_servers(runtime_version, http_port):
    try:
        serverProcess = subprocess.Popen(["node", "servers/servers.js", runtime_version, str(http_port)])
        logging.info(f"Server running on port {http_port}")
        return serverProcess
    except Exception as e:
        logging.error(f"Error starting the server: {e}")
        return None

def stop_servers(serverProcess):
    try:
        serverProcess.terminate()
        logging.info(f"Servers stopped")
    except Exception as e:
        logging.error(f"Error stopping the servers")

# Project Configuration

def project_set_config(data, project_path, ip_address):

    data['HttpPublisher.ip'] = ip_address

    config_file = os.path.join(project_path, 'datafiles', 'config.json')
    save_to_json_file(data, config_file)

def project_set_sandbox(project_path, platform, active):

    options_file = os.path.join(project_path, 'options', platform, f'options_{platform}.yy')
    data = load_json_file(options_file)
    data[f'option_{platform}_disable_sandbox'] = not active
    save_to_json_file(data, options_file)
    
    config_file = os.path.join(project_path, 'datafiles', 'config.json')
    data = load_json_file(config_file)
    data['$$parameters$$.isSandboxed'] = active
    save_to_json_file(data, config_file)

# Results

def results_update(meta_path, log_path, summary_path):

    metadata = load_json_file(meta_path)

    # Copy log to results folder
    log_dest_path = os.path.join(metadata['folder'], f'{metadata["file"]}.log')
    copy_file(log_path, log_dest_path)

    # Add summary to the results file
    results_path = os.path.join(metadata['folder'], f'{metadata["file"]}.json')

    results = load_json_file(results_path)
    sumary = load_json_file(summary_path)
    results['summary'] = sumary
    save_to_json_file(results, results_path)

def results_create_summary(runtime_version, results_path):
    # Initialize summary dictionary
    summary = {'version': runtime_version, 'results': {}}

    # Loop through all the files in the results directory
    for filename in os.listdir(results_path):
        # Check if the file has a .json extension
        if filename.endswith('.json'):
            # Load the JSON data from the file
            json_data = load_json_file(os.path.join(results_path, filename))

            # Extract the target name from the filename (without extension)
            target_name = os.path.splitext(filename)[0]

            # Determine the target status based on the tallies in the JSON data
            tallies = json_data['data']['tallies']
            if 'failed' in tallies or 'expired' in tallies:
                status = 'FAILED'
            else:
                status = 'PASSED'

            # Removed passed details
            data = json_data['data']
            data['details'].pop('passed', None)

            # Update the summary dictionary with the target status and data
            summary['results'][target_name] = {'status': status, 'data': data}

    # Save the summary dictionary to a JSON file
    summary_path = os.path.join(WORKSPACE_DIR, 'summary.json')
    save_to_json_file(summary, summary_path)

# Execution

def main():

    # Configure logging
    configure_logging()

    # Clean workspace
    remove_directory(USER_DIR)
    remove_directory(WORKSPACE_DIR)

    ensure_directories_exist([ CACHE_DIR, OUTPUT_DIR ])

    # Get arguments
    args = parse_arguments(DEFAULT_CONFIG)

    # Download and extract igor
    download_and_extract(IGOR_URL, IGOR_DIR)
    assert(os.path.exists(IGOR_PATH))

    # Copy user folder localy
    original_user_folder = args['Launcher.userFolder']
    user_folder = copy_folder(original_user_folder, USER_DIR, True)
    assert(os.path.exists(user_folder))

    # Execute igor to get license file
    access_key = args['Launcher.accessKey']
    license_path = os.path.join(user_folder, 'licence.plist')
    igor_get_license(access_key, license_path)
    assert(os.path.exists(license_path))

    # Exectute igor to get the latest runtime version
    rss_feed = args['Launcher.feed']
    runtime_version = args['Launcher.runtimeVersion']
    version = igor_get_runtime_version(user_folder, rss_feed, runtime_version)
    assert(version != None)

    # Execute igor to install the requested runtime version
    platforms = args['Launcher.platforms']
    runtime_path = igor_install_runtime(user_folder, rss_feed, version, platforms)
    assert(os.path.exists(runtime_path))

    # Load settings
    settings_path = os.path.join(user_folder, 'local_settings.json')
    settings = load_json_file(settings_path)

    # Set custom HTML5 runner (scripts folder)
    html5_runner = args['Launcher.html5Runner']
    if "html5" in platforms and html5_runner:
        html5_runner_path = os.path.abspath(html5_runner)
        settings['machine.Platform Settings.HTML5.runner_path'] = html5_runner_path

    # Prepare the Android emulator
    if "android" in platforms:
        # Retrieve the AndroidSDK path from settings
        android_sdk = settings['machine.Platform Settings.Android.Paths.sdk_location']
        emulator_id = start_android_emulator(android_sdk)
        assert(emulator_id != None)

    # Save 'local_settings.json' to workspace and local user (just to be on the safe side)
    # save_to_json_file(settings, os.path.join(WORKSPACE_DIR, 'local_settings.json'))
    save_to_json_file(settings, settings_path)

    # Get the igor runner path
    igor_path = os.path.join(runtime_path, 'bin', 'igor', 'windows', 'x64', 'igor.exe')
    
    # Get local IP address
    ip_address = get_local_ip_address()
    assert(ip_address != None)
    
    # Configure project
    project_file = os.path.abspath(args['Launcher.project'])
    project_folder = os.path.dirname(project_file)
    project_set_config(args, project_folder, ip_address)

    # Starts the servers
    server_port = args['HttpPublisher.port']
    servers = start_servers(version, server_port)
    assert(servers != None)

    # Build targets from platforms and devices file
    devices_path = os.path.join(user_folder, 'devices.json')
    devices_data = load_json_file(devices_path)

    # For all except HTML5 (ensure runners are uppercase)
    runners = args['Launcher.runners']
    runners = [s.upper() for s in runners]
    for platform in [x for x in platforms if x != "html5"]:

        target = build_target(platform, devices_data)

        # If we are on a desktop platform
        if platform in SANDBOXED_PLATFORMS:
            
            # Run test on target (with sandbox OFF)
            project_set_sandbox(project_folder, platform, False)
            for runner in runners:
                igor_run_tests(igor_path, project_file, user_folder, runtime_path, target, runner)

                # For each test update results according to metadata
                if check_file_exists(META_PATH):
                    results_update(META_PATH, LOG_PATH, RESULTS_PATH)

            # Run test on target (with sandbox ON)
            project_set_sandbox(project_folder, platform, True)

        for runner in runners:
            igor_run_tests(igor_path, project_file, user_folder, runtime_path, target, runner)

            # For each test update results according to metadata
            if check_file_exists(META_PATH):
                results_update(META_PATH, LOG_PATH, RESULTS_PATH)

    # Test for HTML5 (slightly different, there is not VM/YYC)
    if "html5" in platforms:
        # Download and install the correct verion od ChromeDriver
        driver_path = download_chrome_driver(runtime_path)
        assert(os.path.exists(driver_path))

        # Run project on HTML5
        igor_run_tests(igor_path, user_folder, runtime_path, "HTML5|selenium:chrome")

        # For each test update results according to metadata
        results_update(META_PATH, LOG_PATH, RESULTS_PATH)

    # Close Android emulator
    if "android" in platforms:
        android_sdk = settings['machine.Platform Settings.Android.Paths.sdk_location']
        stop_android_emulator(android_sdk)

    # Stop the servers
    stop_servers(servers)

    # Write summary file
    results_path = os.path.join(WORKSPACE_DIR, 'results', 'tests', version)
    results_create_summary(version, results_path)

    # Check if we should fail the job
    if (check_file_exists(FAIL_PATH)):
        raise Exception(FAIL_MESSAGE)

if __name__ == '__main__':
    main()