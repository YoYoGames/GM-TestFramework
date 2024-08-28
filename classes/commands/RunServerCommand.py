
import argparse
from classes.commands import RunTestsRemote
from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils import async_utils, network_utils
from classes.utils.FileUtils import FileUtils

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
            local_ip_address = network_utils.get_local_ip()
            server_config = {
                **DEFAULT_CONFIG, 
                'HttpPublisher.ip': local_ip_address,
                '$$parameters$$.serverAddress': local_ip_address,

                '$$parameters$$.remote_server': True,
                '$$parameters$$.remote_server_address': local_ip_address,
                '$$parameters$$.remote_server_port': 8000
            }
            FileUtils.save_data_as_json(server_config, project_config_file)

        remote = RunTestsRemote.RunTestsRemote(RunTestsRemote.Mode.MANUAL)
        await manage_server(lambda: remote.serve_or_wait_for_space('C:/Users/Francisco Dias/Desktop/xUnit/xUnit.exe', []))
        return 

        # Manage server: start, wait for user action (space key), then stop
        await manage_server(async_utils.wait_for_space_key)