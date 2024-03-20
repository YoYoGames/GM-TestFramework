
import argparse
from pathlib import Path

from classes.commands.BaseCommand import BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.AsyncUtils import AsyncUtils
from classes.utils.FileUtils import FileUtils
from classes.utils.NetworkUtils import NetworkUtils

# DON'T CHANGE THESE (use external config file instead)
DEFAULT_CONFIG = {
    "Logger.level": 10,

    "HttpPublisher.ip": "127.0.0.1",
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests",

    "$$parameters$$.isSandboxed": True,
    "$$parameters$$.runName": "xUnit Tests",
}

class RunTestsCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        parser: argparse.ArgumentParser = subparsers.add_parser('runTests', help='Runs the testframework and collects all results')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')
        parser.add_argument('-p', '--platform', choices=['windows', 'mac', 'linux', 'android', 'ios', 'ipad', 'tvos', 'ps4', 'ps5'], default='windows', help=f'The target platform to build to')
        parser.add_argument('-of', '--output-folder', type=str, required=True, help='The path to the output folder')
        parser.add_argument('-yypc', '--yypc-path', type=str, required=True, help='The path to the project compiler')
        parser.add_argument('-yyp', '--yyp-file', type=str, required=True, help='The path to the project file (.yyp)')
        parser.add_argument('-cm', '--compile-mode', choices=['build-run', 'build-only'], default='build-run', help='The mode to be used during compilation')
        parser.add_argument('-ct', '--cmake-template', type=str, required=True, help='The mode to be used during compilation')
        parser.add_argument('-l', '--gmrt-libraries', type=str, required=True, help='The location of the GMRT libraries')
        parser.set_defaults(command_class=cls)

    def get_run_name(self):
        return getattr(self.options, 'run-name')

    def get_yypc_path(self):
        return getattr(self.options, 'yypc-path')
    
    def get_yyp_file(self):
        return getattr(self.options, 'yyp-file')

    def get_compile_mode(self):
        return getattr(self.options, 'compile-mode')

    def get_output_folder(self):
        return getattr(self.options, 'output-folder')
    
    def get_cmake_template(self):
        return getattr(self.options, 'cmake-template')

    def get_gmrt_libraries(self):
        return getattr(self.options, 'gmrt-libraries')

    async def execute(self):
        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(self.build_and_run)

    async def build_and_run(self):
        # Here we want to run the yypc to build our project
        yypc_path = self.get_yypc_path()
        yyp_file = self.get_yyp_file()
        output_folder = self.get_output_folder()
        cmake_template = self.get_cmake_template()
        compile_mode = self.get_compile_mode()
        gmrt_libraries = self.get_gmrt_libraries()
        yyp_folder = Path(yyp_file).parent

        # Setup the project
        self.project_set_config(DEFAULT_CONFIG, yyp_folder, NetworkUtils.get_local_ip())

        await AsyncUtils.run_exe(yypc_path, [yyp_file, '-o', output_folder, '-t', cmake_template, f'-mode={compile_mode}', '-l', gmrt_libraries , '-v'])

    def project_set_config(self, data, project_path: Path, ip_address: str):

        data['HttpPublisher.ip'] = ip_address
        data['$$parameters$$.runName'] = self.get_run_name()

        config_file = project_path / 'datafiles' / 'config.json'
        FileUtils.save_data_as_json(data, config_file)
