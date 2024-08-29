import argparse
from classes.server.RemoteControlServer import (RemoteControlServer, ExecutionMode)
from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils import (network_utils, file_utils)

class RunRemoteCommand(BaseCommand):
    """
    Command class for running the test servers. This is useful for executing tests 
    directly from an IDE or other environments where the server needs to be accessed.
    """

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        """
        Registers the 'runRemote' command with the argument parser.

        Args:
            subparsers (argparse._SubParsersAction): The subparsers action from argparse to add the command to.
        """
        parser: argparse.ArgumentParser = subparsers.add_parser('runRemote', help='Runs the test servers (useful for IDE execution)')
        parser.add_argument('-rm', '--run-mode', default='automatic', type=str, required=False, choices=['automatic', 'manual'], help='The remote mode to be used')
        parser.add_argument('-abin', '--app-bin', type=str, required=False, help='The path to the executable')
        parser.add_argument('-aargs', '--app-args', default=[], type=list[str], required=False, help='The arguments to be passed to the executable')
        parser.add_argument('-acfg', '--app-config', type=str, required=False, help='The path to the project config file (config.json)')
        parser.set_defaults(command_class=cls)

    async def execute(self):

        """
        Executes the command to run the server. If a project configuration file is provided, 
        it adds server information to the configuration and saves it. Then, it manages the server's 
        lifecycle, waiting for user input to stop the server.
        """
        project_config_file: str = self.get_argument('app_config')
        
        
        # If a project configuration file is provided, update it with server information
        if project_config_file:
            local_ip_address = network_utils.get_local_ip()
            server_config = {
                **DEFAULT_CONFIG, 
                'HttpPublisher.ip': local_ip_address,
                '$$parameters$$.test_server_address': local_ip_address,

                '$$parameters$$.remote_server': True,
                '$$parameters$$.remote_server_address': local_ip_address,
                '$$parameters$$.remote_server_port': 8000
            }
            file_utils.save_data_as_json(server_config, project_config_file)

        mode = ExecutionMode(self.get_argument('run_mode'))
        remote = RemoteControlServer(mode)

        project_executable: str = self.get_argument('app_bin')
        project_arguments: list[str] = self.get_argument('app_args')
        await manage_server(lambda: remote.serve_or_wait_for_space(project_executable, project_arguments))
