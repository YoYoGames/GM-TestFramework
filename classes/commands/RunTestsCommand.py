import argparse
import os
from pathlib import Path
import subprocess
from typing import Any
from classes.server.RemoteControlServer import (RemoteControlServer, ExecutionMode)
from classes.commands.BaseCommand import DEFAULT_CONFIG, HTTP_PORT, TCP_PORT, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from utils import async_utils, file_utils
from utils.path_utils import ROOT_DIR

PROJECTS_DIR = ROOT_DIR / 'projects'
NODE_MODULES_DIR = ROOT_DIR / 'node_modules'

PROGRAM_FILES = Path(os.environ.get("ProgramFiles"))
NODEJS_NPM_PATH = PROGRAM_FILES / 'nodejs' / 'npm.cmd'

PROJECT_SCRIPT_PATH = PROJECTS_DIR / 'upgrade_project.bat'

class RunTestsCommand(BaseCommand):
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
        parser: argparse.ArgumentParser = subparsers.add_parser('runTests', help='Runs the test servers (useful for IDE execution)')
        parser.add_argument('-gmrt', '--gmrt-path', type=str, required=True, help='The path to GMRT folder')
        parser.add_argument('-yyp', '--project-path', type=str, required=True, help='The path to the project file (.yyp)')
        parser.add_argument('-o', '--output-folder', type=str, required=True, help='The path to the output folder')
        parser.add_argument('-bg', '--build-graph', type=str, required=True, help='The build graph file to be used')
        parser.add_argument('-bj', '--build-jobs', type=str, required=True, help='The build jobs to be ran from the build graph')
        parser.add_argument('-bt', '--build-type', choices=['Debug', 'Release'], default='Debug', help='The type of build (Debug|Release)')
        parser.add_argument('-sbt', '--script-build-type', choices=['Debug', 'Release'], default='Debug', help='The type of script build (Debug|Release)')
        parser.add_argument('-v', '--verbose', action='store_true', help="Enables verbose output")
        parser.add_argument('-rn', '--run-name', default='xUnit', help='The name to be given to the test run')
        parser.set_defaults(command_class=cls)

    async def execute(self):

        """
        Executes the command to run the server. If a project configuration file is provided, 
        it adds server information to the configuration and saves it. Then, it manages the server's 
        lifecycle, waiting for user input to stop the server.
        """       
        self.project_write_config()

        run_name = self.get_argument('run_name')

        # Clean results folder
        file_utils.clean_directory(ROOT_DIR / 'results')

        # This is the root folder from GMRT
        GMRT_PATH = Path(self.get_argument("gmrt_path"))
        BUILD_TYPE: str = self.get_argument("build_type")

        # The path to the gmrt executable
        gmrt_exe = GMRT_PATH / BUILD_TYPE / "bin" / ('gmrt.exe' if BUILD_TYPE.lower() == 'release' else 'gmrtd.exe')
        assert(gmrt_exe.exists())

        # Execute ProjectTool to ensure correct project format
        core_resources_path = GMRT_PATH / BUILD_TYPE / "bin" / "CoreResources.dll"
        assert(core_resources_path.exists())

        # Locally install the ProjectTool utility
        await async_utils.run_and_capture(NODEJS_NPM_PATH, ["install", "--reg=https://gmpm.gamemaker.io/", "@gm-tools/project-tool-win-x64", "--no-save"])
        project_tool_path = NODE_MODULES_DIR / '@gm-tools' / 'project-tool-win-x64' / 'ProjectTool.exe'
        assert(project_tool_path.exists())

        # Run the ProjecTool to downgrade of upgrade the project ot the correct version
        os.environ['PROJECTTOOL'] = str(project_tool_path)
        os.environ['CORERESOURCES_DLL'] = str(core_resources_path)
        subprocess.run([PROJECT_SCRIPT_PATH])

        # Base arguments
        args = [
            self.get_argument("project_path"), 
            '-o', self.get_argument("output_folder"),
            f'-bg={self.get_argument("build_graph")}',
            f'-bj={self.get_argument("build_jobs")}',
            f'--build-type={self.get_argument("build_type")}',
            f'--script-build-type={self.get_argument("script_build_type")}',
            '--cache-dir=C:/Users/xdgam/Documents/GameMaker/Cache'
            ]

        # Make the output verbose
        if self.get_argument("verbose"):
            args.append('-vv')

        # THIS SHOULD BE JUST THE RUN STEP
        remote = RemoteControlServer(ExecutionMode.MANUAL, run_name=run_name)
        await manage_server(lambda:  remote.serve_or_wait_for_space(gmrt_exe, args, port=TCP_PORT), port=HTTP_PORT)

    def project_write_config(self):
        project_path = self.get_argument("project_path")
        project_config = self.get_argument("project_config")
        yyp_folder = Path(project_path).absolute().parent

        config_data = {
            **DEFAULT_CONFIG,
            **project_config,
            '$$parameters$$.remote_server': True,
        }

        config_file = yyp_folder / 'datafiles' / 'config.json'
        file_utils.save_data_as_json(config_data, config_file)