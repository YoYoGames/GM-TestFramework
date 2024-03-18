import asyncio
from pathlib import Path
import re
import argparse
import logging
import os
import subprocess
import sys
from dotenv import load_dotenv

from classes.utils.LoggingUtils import LoggingUtils
from classes.commands.RunServerCommand import RunServerCommand
from classes.commands.RunTestsCommand import RunTestsCommand

# DON'T CHANGE THESE (use external config file instead)
DEFAULT_CONFIG = {
    "Logger.level": 10,

    "HttpPublisher.ip": "127.0.0.1",
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests",

    "$$parameters$$.isSandboxed": True,
    "$$parameters$$.runName": "xUnit Tests",
}

def parse_arguments(defaults):

    VALID_PLATFORMS = ['windows', 'mac', 'linux', 'android', 'ios', 'ipad', 'tvos', 'ps4', 'ps5']

    def merge_dictionaries(new, base):
        output = base.copy()
        for key, value in new.items():
            if key in base:
                logging.info(f'Overriding value for key {key}: {base[key]} -> {value}')
            output[key] = value
        return output

    # Auxiliary function that validates a list of targets (platform|device,platform|device,...)
    def validate_targets(input):
        # Regular expression pattern to match the input string format
        pattern = r'^(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s\.\-_%@& ]+(,(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s\.\-_%@& ]+)*$'
        pattern = r'^(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s.-_%@&()\[\]]+(,(' + '|'.join(VALID_PLATFORMS) + r')\|[\w\s.-_%@&()\[\]]+)*$'
        # Check if the input string matches the pattern
        match = re.match(pattern, input)
        if not match:
            raise argparse.ArgumentTypeError(f'Invalid -t/--t format (follow the format "<PLATFORM>|<DEVICE>,<PLATFORM>|<DEVICE>,..." supported platforms: {VALID_PLATFORMS})')
        
        # Split each key-value pair by the pipe character "|" to separate the key and value
        return [(pair.split('|')[0], pair.split('|')[1]) for pair in input.split(',')]

    # Auxiliary function that validates a runtime version
    def validate_version(input):
        pattern = re.compile(r'^\d+\.\d+\.\d+\.\d+$')
        if not pattern.match(input):
            raise argparse.ArgumentTypeError('Invalid version format. Use <Major>.<Minor>.<Build>.<Revision>')
        return input

    # Auxiliary function that validates an existing path
    def validate_path(input):    
        resolved_path = os.path.abspath(input)
        if not os.path.exists(resolved_path):
            raise argparse.ArgumentTypeError(f'Invalid path provided. This path can be relative or absolute but must exist.')
        return resolved_path

    # Auxiliary function that will make sure the arg exists (either from command line or from config file)
    def ensure_argument(args, path, parsed_args, name, param, validator = None):
        if not args[path]:
            if not getattr(parsed_args, name):
                parser.error(f"argument -{param}/--{param} is required or should be passed from config file (-cf/--cf) as: '{path}'")
            value = getattr(parsed_args, name)
            args[path] = value
        if validator:
            args[path] = validator(args[path])

    parser = argparse.ArgumentParser(description='Run hybrid framework')

    default_targets = defaults['Launcher.targets']

    parser.add_argument('-t', '--targets', type=validate_targets, required=False, help=f'A comma separated list of "platform|config" pairs to run the framework on (defaults <{default_targets}>)')
    parser.add_argument('-uf', '--user-folder', type=validate_path, required=False, help='The path to the GameMaker\' user folder')
    parser.add_argument('-cf', '--config', type=validate_path, required=False, help='The config file to be used by the launcher')
    parser.add_argument('-rn', '--run-name', type=str, required=False, help='Name of the TestFramework run')

    parsed_args = parser.parse_args()

    # Arguments are considered the default to beging with
    args = defaults.copy()

    # Load data from config file (if there is one)
    if parsed_args.configFile:
        config = load_json_file(parsed_args.configFile)
        args = merge_dictionaries(config, defaults)

    ensure_argument(args, 'Launcher.targets', parsed_args, 'targets', 't', validate_targets)
    ensure_argument(args, 'Launcher.userFolder', parsed_args, 'user-folder', 'uf', validate_path)
    ensure_argument(args, '$$parameters$$.runName', parsed_args, 'run-name', 'rn')

    return args

def install_dependencies():
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])

# Execution
async def main():

    LoggingUtils.config_logger()
  
    parser = argparse.ArgumentParser(description='TestFramework Tools')
    subparsers = parser.add_subparsers(dest='command', required=True)

    # Define subparser for runServer
    run_server = subparsers.add_parser('runServer', help='Runs the test servers (useful for IDE execution)')

    # Define subparser for runTests
    run_tests = subparsers.add_parser('runTests', help='Runs the testframework and collects all results')
    run_tests.add_argument('-rn', '--run-name', required=True, help='The name to be given to the test run')

    args = parser.parse_args()
    args.base_folder = Path(__file__).parent

    match(args.command):
        case 'runServer':
            cmd = RunServerCommand(args)
        case 'runTests':
            cmd = RunTestsCommand(args)
        case _:
            logging.error("Unknown command. Please use 'runServer' or 'runTests'.")
            exit(1)
    
    await cmd.execute()

if __name__ == "__main__":
    install_dependencies()
    load_dotenv()
    asyncio.run(main())
