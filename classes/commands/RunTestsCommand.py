
import argparse
from pathlib import Path

from classes.commands.BaseCommand import BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.FileUtils import FileUtils

class RunTestsCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        parser: argparse.ArgumentParser = subparsers.add_parser('runTests', help='Runs the testframework and collects all results')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')
        parser.add_argument('-p', '--platform', choices=['windows', 'mac', 'linux', 'android', 'ios', 'ipad', 'tvos', 'ps4', 'ps5'], default='windows', help=f'The target platform to build to')
        parser.set_defaults(command_class=cls)

    async def execute(self):
        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(self.build_and_run)

    async def build_and_run(self):
        # Here we want to run the yypc to build our project
        # await AsyncUtils.run_exe('yypc', ['arg1', 'arg2'])
        return

    def project_set_config(self, data, project_path: Path, ip_address: str):

        data['$$parameters$$.serverAddress'] = ip_address

        config_file = project_path / 'datafiles' / 'config.json'
        FileUtils.save_data_as_json(data, config_file)
