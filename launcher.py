import asyncio
import json
from pathlib import Path
import argparse
import subprocess
import sys
from dotenv import load_dotenv

from classes.model.TestFrameworkResult import TestFrameworkResult
from utils import (data_utils, file_utils, logging_utils)
from utils.logging_utils import LOGGER
from classes.commands.IgorRunTestsCommand import IgorRunTestsCommand
from classes.commands.RunTestsCommand import RunTestsCommand
from classes.commands.RunServerCommand import RunServerCommand
from utils.path_utils import ROOT_DIR

def install_dependencies():
    launcher_folder = Path(__file__).parent
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", launcher_folder / "requirements.txt"])

def check_xml_json_pairs_and_failures(directory):
    # Convert the directory to a Path object
    directory = Path(directory)
    
    # Get lists of XML and JSON files in the directory
    xml_files = set(f.stem for f in directory.glob('*.xml'))
    json_files = set(f.stem for f in directory.glob('*.json'))
    
    # Check if there are no XML or JSON files
    if not xml_files and not json_files:
        raise FileNotFoundError("No XML or JSON files found in the directory.")
    
    # Find files that are missing pairs
    missing_pairs = xml_files.symmetric_difference(json_files)
    
    if missing_pairs:
        raise ValueError(f"Missing pairs for the following files: {', '.join(missing_pairs)}")
    
    # Now check each JSON file for failures or expired tests
    failed = False
    full_summary = {}
    for json_file in directory.glob('*.json'):
        with open(json_file) as f:
            data: dict = json.load(f)
            result = TestFrameworkResult(**data)
            key = json_file.stem.lower().replace(' ', '_')
            summary = result.to_summary()
            full_summary[key] = summary
            if summary.get('status') == 'failed':
                failed = True
    
    print(data_utils.json_stringify(full_summary))

    if failed:
        raise ValueError(f"Failed or Expired tests found!")
    else:
        print("All tests passed successfully, no Failed or Expired tests found.")

# Execution
async def main():

    # Get the current working directory
    current_working_directory = Path.cwd()

    # Get the directory where the script is located
    script_directory = Path(__file__).resolve().parent

    # Check if the script is being run from its actual directory
    if current_working_directory != script_directory:
        print(f"Error: The script is being run from {current_working_directory}, but it must be run from {script_directory}.")
        sys.exit(1)  # Exit the script with a non-zero status code
    else:
        print("Script is being run from the correct directory.")

    # Configure our logger
    logging_utils.config_logger()
  
    # Initial parser for the --config-file
    config_parser = argparse.ArgumentParser(add_help=False)
    config_parser.add_argument('--config-file', type=str, help='Path to configuration file.')
    config_parser.add_argument('--install', action='store_true', help='Should install dependencies.')
    args, remaining_argv = config_parser.parse_known_args()

    # Check if a config file was provided and load it
    if args.config_file:
        config_args: dict = file_utils.read_data_from_json(args.config_file)
        # Convert config args to command line args format
        # Assumes flat JSON structure: {"arg1": "value1", "arg2": "value2"}
        config_argv = [f'--{k}={v}' for k, v in config_args.items()]
        remaining_argv += config_argv
    if args.install:
        install_dependencies()

    # Load .env it it exists
    load_dotenv()
    
    parser = argparse.ArgumentParser(description='TestFramework Tools')
    subparsers = parser.add_subparsers(dest='command', required=True)
    
    # Register commands with the parser
    IgorRunTestsCommand.register_command(subparsers)
    RunTestsCommand.register_command(subparsers)
    RunServerCommand.register_command(subparsers)

    args = parser.parse_args(remaining_argv)
    args.base_folder = Path(__file__).parent

    # Check if it is a valid command
    if hasattr(args, 'command_class'):
        cmd = args.command_class(args)
        await cmd.execute()
    else:
        LOGGER.error("Unknown command. Please use a registered command.")
        exit(1)

    # Check if we need to fail execution
    #if args.command_class in [IgorRunTestsCommand, RunTestsCommand]:
    directory = ROOT_DIR / 'output' / 'results'
    check_xml_json_pairs_and_failures(directory)

if __name__ == "__main__":
    asyncio.run(main())
