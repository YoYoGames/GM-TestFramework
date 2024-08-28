import asyncio
import sys

from classes.utils.logging_utils import LOGGER

import asyncio

async def run_exe(exe_path, args) -> asyncio.subprocess.Process:

    LOGGER.info(f'Running {exe_path} with arguments {args}')

    process = await asyncio.create_subprocess_exec(
        exe_path,
        *args,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT
    )
    return process

async def run_and_monitor_exe(exe_path: str, args: list[str], stop_event: asyncio.Event, restart_delay: float = 0.5):
    """
    Continuously run an executable, restarting it if it closes or crashes,
    unless the stop_event is set.

    Args:
        exe_path (str): The path to the executable.
        args (list[str]): A list of arguments to pass to the executable.
        stop_event (asyncio.Event): An event to signal when to stop restarting the executable.
        restart_delay (float): The delay in seconds before restarting the executable if it exits. Default is 0.5 seconds.

    This function will start the executable and continuously monitor its output. If the executable
    exits, it will be restarted after the specified delay unless the stop_event is set. The function
    will terminate the monitoring loop when the stop_event is set, allowing for a clean shutdown.
    """
    
    while not stop_event.is_set():
        LOGGER.info(f"Starting executable: {exe_path} with arguments: {args}")

        # Start the subprocess
        process = await run_exe(exe_path, args)

        # Capture the output and monitor the process
        try:
            while True:
                # Read process output
                output = await process.stdout.readline()
                if output:
                    print(f"Process output: {output.decode('utf-8').strip()}")
                else:
                    break  # No more output, the process has likely exited

            # Wait for the process to exit
            await process.wait()

            LOGGER.info(f"Executable {exe_path} exited with return code {process.returncode}")

        except Exception as e:
            LOGGER.error(f"An error occurred: {str(e)}")

        # Optionally, add a delay before restarting
        await asyncio.sleep(restart_delay)

        if stop_event.is_set():
            LOGGER.info("Stop event set, terminating the monitoring loop.")
            break

        LOGGER.info("Restarting the executable...")

    LOGGER.info("Monitoring loop terminated.")

async def capture_output(process: asyncio.subprocess.Process):
    stdout_output = ''

    while True:
        stdout_line = await process.stdout.readline()
        if not stdout_line:
            break
        stripped_output = stdout_line.decode('utf-8').strip()
        if stripped_output:
            stdout_output += stripped_output + '\n'
            print(stripped_output)

    return stdout_output

async def wait_for_space_key(stop_event: asyncio.Event = None):
    async def check_keypress_unix():
        import termios, tty
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
        try:
            tty.setcbreak(fd)
            loop = asyncio.get_running_loop()
            while True:
                if stop_event and stop_event.is_set():
                    break
                await loop.run_in_executor(None, sys.stdin.read, 1)
                if sys.stdin.read(1) == ' ':
                    print("Space key pressed. Stopping server.")
                    if stop_event:
                        stop_event.set()  # Signal to stop the server
                    break
        finally:
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

    async def check_keypress_win():
        import msvcrt
        while True:
            if stop_event and stop_event.is_set():
                break
            await asyncio.sleep(0.1)
            if msvcrt.kbhit() and msvcrt.getch() == b' ':
                print("Space key pressed. Stopping server.")
                if stop_event:
                    stop_event.set()  # Signal to stop the server
                break

    print("Press the space key to stop the server...")
    if sys.platform == 'win32':
        await check_keypress_win()
    else:
        await check_keypress_unix()

async def run_exe_and_capture(exe_path: str, args: list[str]):
    LOGGER.info(f'Running {exe_path} with arguments {args}')
    
    # Start the subprocess
    process = await run_exe(exe_path, args, LOGGER)
    
    stdout_output = await capture_output(process)
    
    await process.wait()  # Wait for the subprocess to exit

    LOGGER.info(f'Process completed')
    return stdout_output


