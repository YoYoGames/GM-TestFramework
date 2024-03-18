import asyncio
import logging
import sys

from classes.utils.LoggingUtils import LoggingUtils

class AsyncUtils:

    @staticmethod
    async def run_exe(exe_path, args):
        logging.info(f'Running {exe_path} with arguments {args}')
        
        # Start the subprocess
        process = await asyncio.create_subprocess_exec(
            exe_path,
            *args,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.STDOUT
        )
        
        stdout_output = ''

        # Don't print the level in the logger for this function
        LoggingUtils.config_logger(format='%(asctime)s %(message)s')
        
        # Read output line by line as it becomes available
        while True:
            stdout_line = await process.stdout.readline()
            if not stdout_line and process.returncode is not None:
                break
            stripped_output = stdout_line.decode('utf-8').strip()
            if stripped_output != '':
                stdout_output += stripped_output + '\n'
                logging.info(stripped_output)
        
        await process.wait()  # Wait for the subprocess to exit
        # Return logger to default configuration if needed
        LoggingUtils.config_logger()

        logging.info(f'Process completed')
        return stdout_output

    @staticmethod
    async def wait_for_space_key():

        async def check_keypress_unix():
            import termios, tty
            fd = sys.stdin.fileno()
            old_settings = termios.tcgetattr(fd)
            try:
                tty.setcbreak(fd)
                loop = asyncio.get_running_loop()
                while True:
                    # Wait for input to be available
                    await loop.run_in_executor(None, sys.stdin.read, 1)
                    if sys.stdin.read(1) == ' ':
                        print("Space key pressed. Stopping server.")
                        break
            finally:
                termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

        async def check_keypress_win():
            import msvcrt
            while True:
                await asyncio.sleep(0.1)  # Small delay to yield control
                if msvcrt.kbhit() and msvcrt.getch() == b' ':
                    print("Space key pressed. Stopping server.")
                    break

        print("Press the space key to stop the server...")
        if sys.platform == 'win32':
            await check_keypress_win()
        else:
            await check_keypress_unix()