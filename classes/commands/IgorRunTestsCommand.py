
from functools import partial
from pathlib import Path
import re
import argparse
import subprocess
import time
from typing import Any, Optional, Tuple
import requests
import zipfile
import io
import random
import os
import shutil
import platform

from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.RemoteControlServer import (RemoteControlServer, ExecutionMode)
from classes.server.TestFrameworkServer import manage_server
from utils import async_utils, file_utils, logging_utils, network_utils
from utils.logging_utils import LOGGER

REDACTED_WORDS = ['-ak=', 'access-key']
REDACTED_MESSAGE = "<redacted to prevent exposure of sensitive data>"

VALID_PLATFORMS = ['windows', 'mac', 'linux', 'android', 'ios', 'ipad', 'tvos', 'HTML5', 'ps4', 'ps5']
VALID_RUNNERS = ['vm', 'yyc']

FAILURE_MESSAGE = '[ERROR] Not all unit tests succeeded.'
FATAL_ERROR = '[ERROR] Test framework didn\'t produce any results.'

IGOR_URL = 'https://gms.yoyogames.com/igor_win-x64.zip'

DRIVER_DETECT_BASE_URL = 'https://chromedriver.storage.googleapis.com/LATEST_RELEASE_'
DRIVER_DOWNLOAD_BASE_URL = 'https://chromedriver.storage.googleapis.com/'

ROOT_DIR = Path('.').absolute()

USER_DIR = ROOT_DIR / 'user'
PROJECTS_DIR = ROOT_DIR / 'projects'
WORKSPACE_DIR = ROOT_DIR / 'workspace'

PROJECT_SCRIPT_PATH = PROJECTS_DIR / 'upgrade_project.bat'

IGOR_DIR = WORKSPACE_DIR / 'igor'
CACHE_DIR = WORKSPACE_DIR / 'cache'
TEMP_DIR = WORKSPACE_DIR / 'temp'
OUTPUT_DIR = WORKSPACE_DIR / 'output'
TEMP_FILE = OUTPUT_DIR / 'xUnit.win'
TARGET_FILE = OUTPUT_DIR / 'xUnit.zip'
RUNTIME_DIR = WORKSPACE_DIR / 'runtime'

IGOR_PATH = IGOR_DIR / 'igor.exe'

SANDBOXED_PLATFORMS = ['windows', 'mac', 'linux']

class IgorRunTestsCommand(BaseCommand):
    
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        parser: argparse.ArgumentParser = subparsers.add_parser('igorRunTests', help='Runs the testframework and collects all results')

        # Auxiliary function that validates a list of targets (platform|device,platform|device,...)
        def validate_targets(input) -> str:
            # Regular expression pattern to match the input string format
            pattern = r'^(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s.-_%@&()\[\]]+(,(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s.-_%@&()\[\]]+)*$'
            # Check if the input string matches the pattern
            match = re.match(pattern, input)
            if not match:
                raise argparse.ArgumentTypeError(f'Invalid -t/--t format (follow the format "<PLATFORM>|<DEVICE>,<PLATFORM>|<DEVICE>,..." supported platforms: {VALID_PLATFORMS})')
            
            # Split each key-value pair by the pipe character "|" to separate the key and value
            return input

        # Auxiliary function that validates a list of runners (runner,runner,...)
        def validate_runners(input) -> str:
            # Regular expression pattern to match the input string format
            pattern = r'^(' + '|'.join(VALID_RUNNERS) + r')(,(' + '|'.join(VALID_RUNNERS) + r'))*$'
            # Check if the input string matches the pattern
            match = re.match(pattern, input)
            if not match:
                raise argparse.ArgumentTypeError(f'Invalid -r/--r format (follow the format "<RUNNER>,<RUNNER>,..." supported runners are: {VALID_RUNNERS})')
            
            # Split each key-value pair by the pipe character "|" to separate the key and value
            return input

        # Auxiliary function that validates a runtime version
        def validate_version(input) -> str:
            pattern = re.compile(r'^\d+\.\d+\.\d+\.\d+$')
            if not pattern.match(input):
                raise argparse.ArgumentTypeError('Invalid version format. Use <Major>.<Minor>.<Build>.<Revision>')
            return input

        # Auxiliary function that validates an existing path
        def validate_path(input, arg) -> Path:
            resolved_path = Path(input).absolute()
            if not resolved_path.exists():
                raise argparse.ArgumentTypeError(f"Invalid path provided for '{arg}' with value '{resolved_path}'. This path can be relative or absolute but must exist.")
            return resolved_path

        # Auxiliary function that validates a path to a yyp
        def validate_yyp(input) -> Path:
            resolved_path = Path(input).absolute()
            if not resolved_path.exists() or resolved_path.is_dir() or not resolved_path.as_posix().endswith('.yyp'):
                raise argparse.ArgumentTypeError(f"Invalid project path provided. This path can be relative or absolute but must exist.")
            return resolved_path

        parser.add_argument('-p', '--project-path', type=validate_yyp, required=True, help=f'The path to the project to be executed (.yyp).')
        parser.add_argument('-t', '--targets', type=validate_targets, required=False, default='windows|Local', help=f'A comma separated list of "platform|config" pairs to run the framework on (default: windows|local)')
        parser.add_argument('-r', '--runners', type=validate_runners, required=False, default='vm', help=f'Runner(s) to run the test on (default: vm)')
        parser.add_argument('-f', '--feed', type=str, required=False, default='https://gms.yoyogames.com/Zeus-Runtime-NuBeta.rss', help=f'RSS feed to use (default: Beta)')
        parser.add_argument('-uf', '--user-folder', type=partial(validate_path, arg='--user-folder'), required=True, help='The path to the GameMaker\' user folder')
        parser.add_argument('-ak', '--access-key', type=str, required=True, help='The access key to download GameMaker\'s license')
        parser.add_argument('-rv', '--runtime-version', type=validate_version, default=None, help='Runner version to use (default: <latest>)')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')
        parser.add_argument('-h5r', '--html5-runner', type=partial(validate_path, arg='--html5-runner'), required=False, help='A custom HTML5 runner to use instead of the runtime one')

        parser.set_defaults(command_class=cls)

    def get_runners(self, ) -> list[str]:
        runners = self.get_argument('runners')
        # Create a list by splitting each runner
        return list(map(str.upper, runners.split(',')))

    def get_targets(self) -> dict[str, str]:
        # Execute igor to install the requested runtime version
        targets: str = self.get_argument('targets')
        # Split the string into key-value pairs
        pairs = targets.split(',')
        # Create a dictionary by splitting each pair into a key and a value
        return dict(pair.split('|') for pair in pairs)

    async def execute(self):

        # Configure logging
        logging_utils.config_logger()

        # Clean workspace
        self.remove_directory(USER_DIR)
        self.remove_directory(WORKSPACE_DIR)

        self.ensure_directories_exist([ CACHE_DIR, OUTPUT_DIR ])

        # Download and extract igor
        self.download_and_extract(IGOR_URL, IGOR_DIR)
        assert(IGOR_PATH.exists())

        # Copy user folder locally (cache the local copy path)
        user_folder: Path = self.get_argument('user_folder')
        user_folder = file_utils.copy_folder(user_folder, USER_DIR, True)
        assert(user_folder.exists())

        # Execute igor to get license file
        access_key: str = self.get_argument('access_key')
        license_path = user_folder / 'licence.plist'
        await self.igor_get_license(access_key, license_path)
        assert(license_path.exists())

        # Exectute igor to get the latest runtime version
        runtime_version: str = self.get_argument('runtime_version')
        rss_feed = self.get_argument('feed')
        runtime_version = await self.igor_get_runtime_version(user_folder, rss_feed, runtime_version)
        assert(runtime_version is not None)

        # Execute igor to install the requested runtime version
        targets = self.get_targets()

        platforms = targets.keys()
        runtime_path = await self.igor_install_runtime(user_folder, rss_feed, runtime_version, platforms)
        assert(runtime_path.exists())

        # Execute ProjectTool to ensure correct project format
        project_tool_path = runtime_path / 'bin' / 'projecttool' / 'windows' / 'x64' / 'ProjectTool.exe'
        assert(project_tool_path.exists())
        os.environ['PROJECTTOOL'] = str(project_tool_path)
        subprocess.run([PROJECT_SCRIPT_PATH])

        # Load settings
        settings_path = user_folder / 'local_settings.json'
        settings = file_utils.read_from_file(settings_path)

        # Prepare for HTML5
        if 'HTML5' in platforms:
            # Download and install the correct version of ChromeDriver
            driver_path = self.download_chrome_driver(runtime_path)
            assert(driver_path.exists())

            # Set custom HTML5 runner (scripts folder)
            html5_runner: Path = self.get_argument('html5_runner')
            if html5_runner:
                settings = self.update_html5_runner_path(settings, html5_runner)

        android_emulator_running = False
        android_sdk_location = None

        # Prepare the Android emulator
        if 'android' in platforms:
            # Update debug runner path (command line will always run debug runner)
            settings = self.update_android_runner(settings)
            
            # Retrieve the AndroidSDK path from settings
            android_sdk_location, _, _ = self.check_android_paths(settings)

            android_emulator_running = self.start_android_emulator(android_sdk_location)

        # Save 'local_settings.json' to workspace and local user (just to be on the safe side)
        file_utils.save_data_as_json(settings, settings_path)

        # Get the igor runner path
        igor_path = runtime_path / 'bin' / 'igor' / 'windows' / 'x64' / 'igor.exe'
        
        # Get local IP address
        ip_address = network_utils.get_local_ip()
        assert(ip_address is not None)
        
        # Configure project
        project_yyp: Path = self.get_argument('project_path')
        project_folder = project_yyp.parent
        self.project_set_config(DEFAULT_CONFIG, project_folder, ip_address)

        # For all except HTML5
        runners = self.get_runners()

        for platform, device in targets.items():
            # Determine whether sandbox tests are needed
            is_sandboxed = platform in SANDBOXED_PLATFORMS

            # Run the tests with and without sandbox if necessary
            for sandbox in [False, True] if is_sandboxed else [None]:
                sandbox_part = '_sandboxed' if sandbox else ''

                if sandbox is not None:
                    self.project_set_sandbox(project_folder, platform, sandbox)
                
                # Select runners based on the platform
                platform_runners = runners if platform != 'HTML5' else [None]
                
                for runner in platform_runners:
                    runner_part = f'_{runner}' if runner else ''
                    
                    file_utils.clean_directory(OUTPUT_DIR)
                    
                    run_name = f"{self.get_argument('run_name')}_{platform}{runner_part}{sandbox_part}"
                    await self.igor_run_tests(igor_path, project_yyp, user_folder, runtime_path, platform, device, runner, run_name)

        # Close Android emulator
        if android_emulator_running:
            self.stop_android_emulator(android_sdk_location)

    def remove_directory(self, directory: Path):
        if os.path.exists(directory):
            try:
                shutil.rmtree(directory)
                LOGGER.info(f'Successfully removed directory: {directory}')
            except OSError as e:
                LOGGER.error(f'Error removing directory: {directory}')
                LOGGER.error(e)
        else:
            LOGGER.warning(f'Directory does not exist: {directory}')

    def ensure_directories_exist(self, directories: list[Path]):
        for directory in directories:
            if not directory.exists():
                LOGGER.info(f'Creating directory: {directory}')
                os.makedirs(directory)
            else:
                LOGGER.info(f'Directory already exists: {directory}')

    def change_directory(self, path: Path):
        LOGGER.info(f'Changing directory to {path}')
        try:
            os.chdir(path)
            LOGGER.info(f'Successfully changed directory to {os.getcwd()}')
        except Exception as e:
            LOGGER.error(f'Failed to change directory: {e}')

    def download_and_extract(self, url, extract_path: Path):
        # Download the file
        LOGGER.info('Downloading file from URL: %s', url)
        response = requests.get(url)
        LOGGER.info('Download complete')

        # Open the file in memory
        with zipfile.ZipFile(io.BytesIO(response.content)) as zf:
            # Extract the file to the specified path
            LOGGER.info('Extracting file to: %s', extract_path)
            zf.extractall(extract_path)
            LOGGER.info('Extraction complete')

    # Igor

    async def igor_get_license(self, access_key: str, output_path: Path):
        await async_utils.run_exe_and_capture(IGOR_PATH, [f'-ak={access_key}', f'-of={output_path}', 'Runtime', 'FetchLicense'])

    async def igor_get_runtime_version(self, user_folder: Path, feed: str, version: str):
        # This will prevent browser cache
        cacheBust = random.randint(111111111, 999999999)
        # Setup arguments
        args = [f'/uf={user_folder}', f'/ru={feed}?cachebust={cacheBust}', 'Runtime', 'Info']
        if version:
            args.append(version)
        
        # Execute command
        result = await async_utils.run_exe_and_capture(IGOR_PATH, args)

        pattern = re.compile(r'Version (\d+\.\d+\.\d+\.\d+)')
        match = pattern.search(result)
        if match:
            version = match.group(1)
            return version
        else:
            return None

    async def igor_install_runtime(self, user_folder: Path, feed: str, version: str, platforms: list[str]):

        # This will prevent browser cache
        cacheBust = random.randint(111111111, 999999999)
        # Prepare modules string
        t = platforms
        modules = ','.join(t).lower()
        # Setup arguments
        args = [f'/uf={user_folder}', f'/ru={feed}?cachebust={cacheBust}', f'/rp={RUNTIME_DIR}', f'/m={modules}', 'Runtime', 'Install', version]
        
        # Execute command
        await async_utils.run_exe_and_capture(IGOR_PATH, args)

        return RUNTIME_DIR / f'runtime-{version}'

    async def igor_run_tests(self, igor_path: Path, project_file: Path, user_folder: Path, runtime_path: Path, platform: str, device: str, runner: Optional[str] = None, run_name = 'xUnit', verbosity_level: Optional[int] = 4):

        # Setup verbosity level
        args_base = ['/v' for _ in range(verbosity_level)]

        # Setup arguments
        args_base += [
            f'/uf={user_folder}',
            f'/rp={runtime_path}',
            f'/project={project_file}',
            f'/cache={CACHE_DIR}',
            f'/temp={TEMP_DIR}',
            f'/of={TEMP_FILE}',
            f'/tf={TARGET_FILE}',
            f'/device={device}',
        ]

        # Optionally add the runner argument
        if runner is not None:
            args_base += [f'/runtime={runner}']
        
        args_base += ['--', platform]

        # Execute command (change working directory)
        self.change_directory(WORKSPACE_DIR)

        package_args = args_base + ['PackageZip']
        await async_utils.run_exe_and_capture(igor_path, package_args)

        run_args = args_base + ['Run']
        remote_server = RemoteControlServer(ExecutionMode.AUTOMATIC, run_name=run_name)
        await manage_server(lambda: remote_server.serve_or_wait_for_space(igor_path, run_args))
 
        self.change_directory(ROOT_DIR)

    # HTML5 Specific

    def get_installed_chrome_version(self) -> str:
        if platform.system() == 'Windows':
            process = subprocess.Popen(
                ['reg', 'query', 'HKEY_CURRENT_USER\\SOFTWARE\\Google\\Chrome\\BLBeacon', '/v', 'version'],
                stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL)
            return process.communicate()[0].decode('UTF-8').split()[-1]

        elif platform.system() == 'Linux':
            process = subprocess.Popen(
                ['google-chrome', '--version'],
                stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL)
            return process.communicate()[0].decode('UTF-8').split()[-1]

        elif platform.system() == 'Darwin':
            process = subprocess.Popen(
                ['/Applications/Google Chrome.app/Contents/MacOS/Google Chrome', '--version'],
                stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL)
            return process.communicate()[0].decode('UTF-8').split()[-1]

    def download_chrome_driver(self, runtime_path : Path) -> Path:

        # Get Chrome version
        chrome_version = self.get_installed_chrome_version()
        assert(chrome_version is not None)

        # Compute relevate version (extract W.X.Y from W.X.Y.Z)
        relevant_version = chrome_version
        match = re.search(r'\d+\.\d+\.\d+', chrome_version)
        if match:
            relevant_version = match.group()
            LOGGER.info(f'Relevant Chrome version: {relevant_version}')
        else:
            LOGGER.error(f'Could not extract relevat Chrome version from {chrome_version}')
            return None

        # Get Chrome driver version
        driver_version_url = f'{DRIVER_DETECT_BASE_URL}{relevant_version}'
        driver_version = network_utils.query_url(driver_version_url)

        if driver_version == None:
            return None
        
        # Build download link
        version_url = f'{driver_version}/chromedriver_win32.zip'
        download_url = DRIVER_DOWNLOAD_BASE_URL + version_url

        # Download and extract the driver
        extract_path = runtime_path / 'bin' / 'igor' / 'windows' / 'x64'
        self.download_and_extract(download_url, extract_path)

        # Return 'chromedriver.exe' path
        return extract_path / 'chromedriver.exe'

    def update_html5_runner_path(self, contents: str, html5_runner_path: Path) -> str:
        # Construct the regex pattern to match the runner_path entry
        pattern = re.compile(r'"machine\.Platform Settings\.HTML5\.runner_path":\s*".*?",')

        # The replacement string
        replacement = f'"machine.Platform Settings.HTML5.runner_path": "{html5_runner_path}",'

        # Replace the matching pattern with the new path
        return re.sub(pattern, replacement, contents)

    # Android Specific

    def update_android_runner(self, contents: str) -> str:
        # Construct the regex pattern to match the use_debug_runner entry
        pattern = re.compile(r'"machine\.Platform Settings\.Android\.debug\.use_debug_runner":\s*".*?",')

        # The replacement string
        replacement = f'"machine.Platform Settings.Android.debug.use_debug_runner": false,'

        # Replace the matching pattern with the new path
        return re.sub(pattern, replacement, contents)

    def check_android_paths(self, contents: str) -> Tuple[Path, Path, Path]:
        # Define the regex patterns to match each path
        sdk_pattern = re.compile(r'"machine\.Platform Settings\.Android\.Paths\.sdk_location":\s*"(.*?)",')
        ndk_pattern = re.compile(r'"machine\.Platform Settings\.Android\.Paths\.ndk_location":\s*"(.*?)",')
        jdk_pattern = re.compile(r'"machine\.Platform Settings\.Android\.Paths\.jdk_location":\s*"(.*?)",')

        # Initialize variables to hold the paths
        sdk_location = None
        ndk_location = None
        jdk_location = None

        # Extract paths using the regex patterns
        sdk_match = re.search(sdk_pattern, contents)
        if sdk_match:
            sdk_location = Path(sdk_match.group(1))
            assert(sdk_location.exists())

        ndk_match = re.search(ndk_pattern, contents)
        if ndk_match:
            ndk_location = Path(ndk_match.group(1))
            assert(ndk_location.exists())

        jdk_match = re.search(jdk_pattern, contents)
        if jdk_match:
            jdk_location = Path(jdk_match.group(1))
            assert(jdk_location.exists())

        return sdk_location, ndk_location, jdk_location

    def start_android_emulator(self, sdk_path: Path) -> str:
        emulator_path = sdk_path / 'emulator' / 'emulator.exe'
        adb_path = sdk_path / 'platform-tools' / 'adb.exe'

        avd_list = subprocess.run([emulator_path, '-list-avds'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        avds = avd_list.stdout.decode().strip().splitlines()

        if len(avds) == 0:
            LOGGER.error('No Android Virtual Devices found.')
            return None

        emulator_name = avds[0]
        LOGGER.info(f"Starting AVD: {emulator_name}")
        with open(os.devnull, "w") as f:
            subprocess.Popen([emulator_path, '-avd', emulator_name], stdout=f, stderr=f)
        LOGGER.info('Emulator started')

        # Wait for the emulator to appear in the adb devices list
        LOGGER.info('Waiting for emulator to connect to ADB')
        while True:
            result = subprocess.run([adb_path, 'devices'], capture_output=True, text=True)
            lines = result.stdout.strip().split("\n")[1:]
            emulators = [line.split("\t")[0] for line in lines if "emulator" in line]
            if len(emulators) > 0:
                break
            time.sleep(1)

        emulator_id = emulators[0]
        LOGGER.info(f'Connected emulator id: {emulator_id}')

        # Wait for the emulator to fully boot
        LOGGER.info('Waiting for emulator to fully boot')
        counter = 0
        while True:
            boot_check = subprocess.run([adb_path, '-s', emulator_id, 'shell', 'am', 'broadcast', '-a', 'android.intent.action.MAIN', '-n', 'com.android.internal.util.WithFramework/com.android.internal.util.FrameworkInitializer'], capture_output=True, text=True)
            
            if "result=0" in boot_check.stdout:
                break

            LOGGER.info('Boot check: %s', boot_check.stdout.strip())
            counter += 1
            if counter > 120:  # Timeout after 120 seconds
                LOGGER.error('Timeout waiting for emulator to fully boot')
                break

            time.sleep(1)

        if "result=0" in boot_check.stdout:
            LOGGER.info('Emulator is fully booted')

        return emulator_id

    def stop_android_emulator(self, sdk_path: Path):
        # Stop the emulator
        adb_path = sdk_path / 'platform-tools' / 'adb.exe'

        LOGGER.info('Stopping Android emulator')
        subprocess.run([adb_path, 'emu', 'kill'])
        LOGGER.info('Emulator stopped')

    # Project Configuration

    def project_set_config(self, data: dict[str, Any], project_path : Path, ip_address: str):

        data = dict(data)
        data['HttpPublisher.ip'] = ip_address
        data['HttpPublisher.port'] = 8080
        data['$$parameters$$.remote_server'] = True
        data['$$parameters$$.remote_server_address'] = ip_address
        data['$$parameters$$.remote_server_port'] = 8000

        config_file = project_path / 'datafiles' / 'config.json'
        file_utils.save_data_as_json(data, config_file)

    def project_set_sandbox(self, project_path: Path, platform, active):
        new_value = 'false' if active else 'true'
        
        # Construct the regex pattern dynamically based on the platform
        pattern = re.compile(rf'f"option_{platform}_disable_sandbox":(true|false),')

        options_file = project_path / 'options' / platform / f'options_{platform}.yy'
        content = file_utils.read_from_file(options_file)
        assert(content)

        updated_content = re.sub(pattern, f'f"option_{platform}_disable_sandbox":{new_value},', content)

        file_utils.save_to_file(updated_content, options_file)
