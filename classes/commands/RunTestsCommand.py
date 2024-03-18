
import argparse
from pathlib import Path

from classes.commands.BaseCommand import BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.AsyncUtils import AsyncUtils
from classes.utils.FileUtils import FileUtils

class RunTestsCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    async def execute(self):
        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(self.build_and_run)

    async def build_and_run():
        await AsyncUtils.run_exe('yypc', ['arg1', 'arg2'])

    def project_set_config(data, project_path: Path, ip_address: str):

        data['$$parameters$$.serverAddress'] = ip_address

        config_file = project_path / 'datafiles' / 'config.json'
        FileUtils.save_json(data, config_file)
