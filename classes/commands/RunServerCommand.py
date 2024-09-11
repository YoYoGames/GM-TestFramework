
import argparse
from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from utils import (async_utils, file_utils)

class RunServerCommand(BaseCommand):
    """
    Command class for running the test servers. This is useful for executing tests 
    directly from an IDE or other environments where the server needs to be accessed.
    """

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        """
        Registers the 'runServer' command with the argument parser.

        Args:
            subparsers (argparse._SubParsersAction): The subparsers action from argparse to add the command to.
        """
        parser: argparse.ArgumentParser = subparsers.add_parser('runServer', help='Runs the test servers (useful for IDE execution)')
        parser.add_argument('-pcf', '--proj-config-file', type=str, required=False, help='The path to the project config file (config.json)')
        parser.set_defaults(command_class=cls)

    async def execute(self): 
        """
        Executes the command to run the server. If a project configuration file is provided, 
        it adds server information to the configuration and saves it. Then, it manages the server's 
        lifecycle, waiting for user input to stop the server.
        """
        project_config_file: str = self.get_argument('proj_config_file')
        
        # If a project configuration file is provided, update it with server information
        if project_config_file:
            data = {
                **DEFAULT_CONFIG,
                "$$parameters$$.remote_server": False
            }
            file_utils.save_data_as_json(data, project_config_file)

        # Manage server: start, wait for user action (space key), then stop
        await manage_server(async_utils.wait_for_space_key)