
import argparse
from pathlib import Path
from typing import Any

from classes.utils import file_utils
from classes.utils import network_utils

DEFAULT_CONFIG = {
    "Logger.level": 10,

    "HttpPublisher.ip": "127.0.0.1",
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests",

    "$$parameters$$.isSandboxed": True,
    "$$parameters$$.runName": "xUnit Tests",
    "$$parameters$$.serverAddress": "127.0.0.1",
}

class BaseCommand:
    def __init__(self, options: argparse.Namespace):
        self.options = options

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        pass

    def get_argument(self, name) -> str:
        return getattr(self.options, name)

    async def execute(self):
        raise NotImplementedError()

    def get_root_folder(self) -> Path:
        return self.options.base_folder

    def project_set_config(self, data) -> dict[str, Any]:
        local_ip = network_utils.get_local_ip()

        data = dict(**data)
        data['HttpPublisher.ip'] = local_ip
        data['$$parameters$$.runName'] = self.get_argument("run_name")
        data['$$parameters$$.serverAddress'] = local_ip
        return data

    def project_write_config(self, data: dict[str, Any]):
        yyp_file = self.get_argument("project_path")
        yyp_folder = Path(yyp_file).parent

        config_file = yyp_folder / 'datafiles' / 'config.json'
        file_utils.save_data_as_json(data, config_file)