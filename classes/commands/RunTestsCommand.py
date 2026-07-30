import argparse
import asyncio
from pathlib import Path

from classes.server.RemoteControlServer import (RemoteControlServer, ExecutionMode)
from classes.commands.BaseCommand import DEFAULT_CONFIG, HTTP_PORT, TCP_PORT, BaseCommand
from classes.server.TestFrameworkServer import manage_server
from utils import async_utils, file_utils
from utils.logging_utils import LOGGER
from utils.path_utils import ROOT_DIR

WORKSPACE_DIR = ROOT_DIR / 'workspace'

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
        # The GMRT filepath
        parser.add_argument('-gmrt', '--gmrt-path', type=str, required=True, help='The path to GMRT folder')
        # The GMRT arguments
        parser.add_argument('-pf', '--prefab-dir', type=str, required=True, help='The path to prefabs folder')
        parser.add_argument('-yyp', '--project-path', type=str, required=True, help='The path to the project file (.yyp)')
        parser.add_argument('-o', '--output-folder', type=str, required=True, help='The path to the output folder')
        parser.add_argument('-bg', '--build-graph', type=str, required=True, help='The build graph file to be used')
        parser.add_argument('-bj', '--build-jobs', type=str, required=True, help='The build jobs to be ran from the build graph')
        parser.add_argument('-bt', '--build-type', choices=['Debug', 'Release'], default='Debug', help='The type of build (Debug|Release)')
        parser.add_argument('-sbt', '--script-build-type', choices=['Debug', 'Release'], default='Debug', help='The type of script build (Debug|Release)')
        # The GMRT optional arguments
        parser.add_argument('-cd', '--cache-dir', type=str, required=False, help='The cache directory to be used')
        parser.add_argument('-v', '--verbose', action='store_true', help="Enables verbose output")
        # TestFramework arguments
        parser.add_argument('-rn', '--run-name', default='xUnit', help='The name to be given to the test run')
        parser.add_argument(
            '--skip-tests',
            action='append',
            default=[],
            help='Exact Suite@Test path to skip; may be specified more than once',
        )
        parser.set_defaults(command_class=cls)

    async def execute(self) -> None:
        """
        Executes the command to run the server. Manages configuration, cleans up directories, 
        ensures project compatibility, and launches the server lifecycle.
        """
        # Clean workspace
        file_utils.remove_directory(WORKSPACE_DIR)
        file_utils.create_directory(WORKSPACE_DIR)

        self.project_write_config()
        run_name = self.get_argument("run_name")
        
        # Prepare environment and paths
        self._clean_results_directory()
        gmrt_exe = self._prepare_gmrt_path()
        
        try:
            build_job, run_job = self.get_argument("build_jobs").split(";")
        except ValueError:
            LOGGER.error(f"Invalid build jobs format: {self.get_argument('build_jobs')}. Expected format: <build_job>;<run_job>")
            return

        if Path(self.get_argument("output_folder")).exists() and any(Path(self.get_argument("output_folder")).iterdir()):
            LOGGER.warning(f"Output folder '{self.get_argument('output_folder')}' is not empty. Previous results may affect the test run.")
            LOGGER.warning("Consider cleaning the output folder before running tests or specifying a different folder.")

        # Build the project first
        build_args = self._build_gmrt_arguments(build_job)
        build_process = await async_utils.run_exe(gmrt_exe, build_args)
        build_output = await async_utils.capture_output(build_process, asyncio.Event())
        await build_process.wait()
        if build_process.returncode != 0:
            LOGGER.error(f"Build job failed (exit code {build_process.returncode}). Aborting test run.")
            LOGGER.error(f"Build output:\n{build_output}")
            return
        
        # Now we can start the remote control server to run tests.
        # This two-step approach prevents rebuilding the project on restarts (test timeout, crash, ...)
        args = self._build_gmrt_arguments(run_job)
        remote = RemoteControlServer(
            ExecutionMode.AUTOMATIC,
            run_name=run_name,
            skip_tests=self.get_argument('skip_tests'),
        )
        await manage_server(
            lambda: remote.serve_or_wait_for_space(gmrt_exe, args, port=TCP_PORT), 
            port=HTTP_PORT
        )


    def _clean_results_directory(self) -> None:
        """Cleans the results directory."""
        results_dir = ROOT_DIR / "results"
        file_utils.create_directory(results_dir)
        file_utils.clean_directory(ROOT_DIR / "results")

    def _prepare_gmrt_path(self) -> Path:
        """Prepares and validates the GMRT executable path."""
        gmrt_path = Path(self.get_argument("gmrt_path"))
        build_type = self.get_argument("build_type").lower()

        gmrt_exe = gmrt_path / build_type / "bin" / ("gmrt.exe" if build_type == "release" else "gmrtd.exe")
        
        assert gmrt_exe.exists(), f"GMRT executable not found: {gmrt_exe}"
        
        return gmrt_exe

    def _build_gmrt_arguments(self, build_jobs: str) -> list[str]:
        """Builds the argument list for the server."""
        args = [
            self.get_argument("project_path"),
            "-o", self.get_argument("output_folder"),
            f"-bg={self.get_argument('build_graph')}",
            f"-bj={build_jobs}",
            f"--build-type={self.get_argument('build_type')}",
            f"--script-build-type={self.get_argument('script_build_type')}",
            f"--prefab-dir={self.get_argument('prefab_dir')}",
        ]

        cache_dir = self.get_argument("cache_dir")
        if cache_dir:
            args.append(f"--cache-dir={cache_dir}")

        if self.get_argument("verbose"):
            args.append("-vv")

        return args

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
