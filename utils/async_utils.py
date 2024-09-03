import asyncio
import subprocess
import sys
import threading
import time

from utils.logging_utils import LOGGER

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

async def run_and_monitor_exe(exe_path: str, args: list[str], stop_event: asyncio.Event, reboot_event: asyncio.Event, restart_delay: float = 0.5):
    while not stop_event.is_set():
        LOGGER.info(f"Starting executable: {exe_path} with arguments: {args}")

        # Start the subprocess
        process = await run_exe(exe_path, args)

        # Capture the output and monitor the process
        try:
            while True:
                try:
                    # Read the output line by line
                    stdout_line = await asyncio.wait_for(process.stdout.readline(), timeout=0.1)
                    if stdout_line:
                        stripped_output = stdout_line.decode('utf-8').strip()
                        print(stripped_output)
                        sys.stdout.flush()  # Ensure the output is flushed immediately

                except asyncio.TimeoutError:
                    pass

                if stop_event.is_set():
                    LOGGER.info("Stop event detected. Terminating the process.")
                    process.terminate()
                    await process.wait()
                    break

                if reboot_event.is_set():
                    LOGGER.info("Reboot event detected. Terminating the process.")
                    process.terminate()
                    await process.wait()
                    reboot_event.clear()
                    break

            await process.wait()
            LOGGER.info(f"Executable {exe_path} exited with return code {process.returncode}")

        except Exception as e:
            LOGGER.error(f"An error occurred: {str(e)}")

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
            sys.stdout.flush()  # Ensure the output is flushed immediately

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
    
    # Start the subprocess
    process = await run_exe(exe_path, args)
    
    stdout_output = await capture_output(process)
    
    await process.wait()  # Wait for the subprocess to exit

    LOGGER.info(f'Process completed')
    return stdout_output


    # Start the subprocess
    process = run_exe_sync(exe_path, args)
    
    stdout_output = capture_output_sync(process)
    
    process.wait()  # Wait for the subprocess to exit

    LOGGER.info(f'Process completed')
    return stdout_output