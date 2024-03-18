
import argparse
from classes.commands.BaseCommand import BaseCommand
from classes.server.TestFrameworkServer import manage_server
from classes.utils.AsyncUtils import AsyncUtils

class RunServerCommand(BaseCommand):
    def __init__(self, options: argparse.Namespace):
        BaseCommand.__init__(self, options)

    async def execute(self):
        # Run our server management function (start server, wait for user action, stop server)
        await manage_server(AsyncUtils.wait_for_space_key)
