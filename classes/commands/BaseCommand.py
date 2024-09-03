
import argparse
from pathlib import Path
from typing import Any

from utils import network_utils

LOCAL_IP = network_utils.get_local_ip()
TCP_PORT = network_utils.get_random_available_port()

DEFAULT_CONFIG = {

    # Configuration Injection
    "Logger.level": 10,

    "HttpPublisher.ip": LOCAL_IP,
    "HttpPublisher.port": 8080,
    "HttpPublisher.endpoint": "tests",

    # Internal
    "$$parameters$$.run_name": "xUnit Tests",

    "$$parameters$$.remote_server": False,
    "$$parameters$$.remote_server_address": LOCAL_IP,
    "$$parameters$$.remote_server_port": TCP_PORT,

    "$$parameters$$.test_server_address": LOCAL_IP,
    "$$parameters$$.test_server_port": 8080,
}

class BaseCommand:
    def __init__(self, args: argparse.Namespace):
        self.args = args

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        pass

    def get_argument(self, name) -> Any:
        return getattr(self.args, name)

    async def execute(self):
        raise NotImplementedError()

    def get_root_folder(self) -> Path:
        return self.args.base_folder
