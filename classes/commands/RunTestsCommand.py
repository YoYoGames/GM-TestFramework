
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

        parser.add_argument('-yypc', '--yypc-path', type=str, required=True, help='The path to the project compiler')
        parser.add_argument('-yyp', '--project-path', type=str, required=True, help='The path to the project file (.yyp)')
        parser.add_argument('-o', '--output-folder', type=str, required=True, help='The path to the output folder')
        parser.add_argument('-t', '--template-folder', type=str, required=True, help='The mode to be used during compilation')
        parser.add_argument('-tc', '--toolchain-folder', type=str, required=True, help='The path to the GMRT toolchain')
        parser.add_argument('-tt', '--target-triple', choices=['x86_64-pc-windows-msvc'], default='x86_64-pc-windows-msvc', help=f'The target platform to build to')
        parser.add_argument('-ac', '--asset-compiler-path', type=str, required=True, help='The location of the GMRT asset compiler')
        parser.add_argument('-m', '--mode', choices=['build-run', 'build-only'], default='build-run', help='The mode to be used during compilation')
        parser.add_argument('-bt', '--build-type', choices=['Debug', 'Release'], default='Debug', help='The type of build (Debug|Release)')
        parser.add_argument('-sbt', '--script-build-type', choices=['Debug', 'Release'], default='Debug', help='The type of script build (Debug|Release)')
        parser.add_argument('-rn', '--run-name', default='xUnit TestFramework', help='The name to be given to the test run')

        parser.set_defaults(command_class=cls)

    def get_argument(self, name) -> str:
        return getattr(self.options, name)

    async def execute(self):
        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(self.build_and_run)

    async def build_and_run(self):
        # Here we want to run the yypc to build our project
        yypc_path = self.get_argument("yypc_path")
        yyp_file = self.get_argument("project_path")
        yyp_folder = Path(yyp_file).parent

        # Setup the project
        self.project_set_config(DEFAULT_CONFIG, yyp_folder, NetworkUtils.get_local_ip())

        await AsyncUtils.run_exe(yypc_path, [
            yyp_file, 
            '-o', self.get_argument("output_folder"),
            '-t', self.get_argument("template_folder"),
            f'-toolchain={self.get_argument("toolchain_folder")}',
            f'-target-triple={self.get_argument("target_triple")}',
            f'-asset-compiler={self.get_argument("asset_compiler_path")}',
            f'-build-type={self.get_argument("build_type")}',
            f'-script-build-type={self.get_argument("script_build_type")}',
            f'-mode={self.get_argument("mode")}',
            '-v'])

    def project_set_config(self, data, project_path: Path, ip_address: str):

        data['HttpPublisher.ip'] = ip_address
        data['$$parameters$$.runName'] = self.get_argument("run_name")

        config_file = project_path / 'datafiles' / 'config.json'
        FileUtils.save_data_as_json(data, config_file)

