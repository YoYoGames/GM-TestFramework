
import argparse
from pathlib import Path

class BaseCommand:
    def __init__(self, options: argparse.Namespace):
        self.options = options

    def get_root_folder(self) -> Path:
        return self.options.base_folder
