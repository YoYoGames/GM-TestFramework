
import argparse
from pathlib import Path
from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.AsyncUtils import AsyncUtils
from classes.utils.FileUtils import FileUtils
from classes.utils.NetworkUtils import NetworkUtils

class RunServerCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        parser: argparse.ArgumentParser = subparsers.add_parser('runServer', help='Runs the test servers (useful for IDE execution)')
        parser.add_argument('-yyp', '--project-path', type=str, required=True, help='The path to the project file (.yyp)')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')
        parser.set_defaults(command_class=cls)

    async def execute(self):
        self.project_set_config(DEFAULT_CONFIG)

        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(AsyncUtils.wait_for_space_key)

