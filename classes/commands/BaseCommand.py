
import argparse
from pathlib import Path

class BaseCommand:
    def __init__(self, options: argparse.Namespace):
        self.options = options

    @classmethod
    def register_command(cls, subparsers: argparse._SubParsersAction):
        pass

    async def execute(self):
        raise NotImplementedError()

    def get_root_folder(self) -> Path:
        return self.options.base_folder
