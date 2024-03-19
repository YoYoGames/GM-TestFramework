import asyncio
from pathlib import Path
import argparse
import logging
import subprocess
import sys
from dotenv import load_dotenv

from classes.utils.FileUtils import FileUtils
from classes.utils.LoggingUtils import LoggingUtils
from classes.commands.RunServerCommand import RunServerCommand
from classes.commands.RunTestsCommand import RunTestsCommand

def install_dependencies():
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])

# Execution
async def main():

    LoggingUtils.config_logger()
  
    # Initial parser for the --config-file
    config_parser = argparse.ArgumentParser(add_help=False)
    config_parser.add_argument('--config-file', type=str, help='Path to configuration file.')
    args, remaining_argv = config_parser.parse_known_args()

    # Check if a config file was provided and load it
    if args.config_file:
        config_args: dict = FileUtils.read_data_from_json(args.config_file)
        # Convert config args to command line args format
        # Assumes flat JSON structure: {"arg1": "value1", "arg2": "value2"}
        config_argv = [f'--{k}={v}' for k, v in config_args.items()]
        remaining_argv += config_argv

    parser = argparse.ArgumentParser(description='TestFramework Tools')
    subparsers = parser.add_subparsers(dest='command', required=True)

    # Register commands with the parser
    RunServerCommand.register_command(subparsers)
    RunTestsCommand.register_command(subparsers)

    args = parser.parse_args(remaining_argv)
    args.base_folder = Path(__file__).parent

    # Check if it is a valid command
    if hasattr(args, 'command_class'):
        cmd = args.command_class(args)
        await cmd.execute()
    else:
        logging.error("Unknown command. Please use a registered command.")
        exit(1)

if __name__ == "__main__":
    install_dependencies()
    load_dotenv()
    asyncio.run(main())
