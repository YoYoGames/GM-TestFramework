
import argparse
import asyncio
from pathlib import Path
from classes.commands.BaseCommand import DEFAULT_CONFIG, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.AsyncUtils import AsyncUtils
from classes.utils.FileUtils import FileUtils

class RunServerCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        parser: argparse.ArgumentParser = subparsers.add_parser('runServer', help='Runs the test servers (useful for IDE execution)')
        parser.add_argument('-xc', '--xunit-config', type=str, required=False, help='The path to the test framework config file (config.json)')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')
        parser.set_defaults(command_class=cls)

    async def execute(self):
        data = self.project_set_config(DEFAULT_CONFIG)
        FileUtils.save_data_as_json(data, self.get_argument('xunit_config'))

        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(self.serve_or_wait_for_space)

    async def serve_or_wait_for_space(self):
        stop_event = asyncio.Event()
        await asyncio.gather(
            AsyncUtils.serve(None, '127.0.0.1', 8000, timeout = 2, stop_event=stop_event),
            AsyncUtils.wait_for_space_key(stop_event)
        )

