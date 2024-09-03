import asyncio
import sys
import psutil
import signal

from utils.logging_utils import LOGGER

import asyncio

def kill_process_tree(pid: int, sig=signal.SIGTERM):
    """
    Kills a process and all its subprocesses.
    
    Args:
        pid (int): The process ID of the main process to kill.
        sig: The signal to send to the processes. Default is SIGTERM.
    """
    try:
        parent = psutil.Process(pid)
        children = parent.children(recursive=True)
        
        # Terminate child processes
        for child in children:
            try:
                child.send_signal(sig)
            except psutil.NoSuchProcess:
                pass  # The process is already terminated
        
        # Terminate the parent process
        parent.send_signal(sig)
    except psutil.NoSuchProcess:
        pass  # The parent process is already terminated

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
            # Run the output capture concurrently with the monitoring logic
            capture_task = asyncio.create_task(capture_output(process, stop_event))

            while True:
                if stop_event.is_set():
                    LOGGER.info("Stop event detected. Terminating the process.")
                    process.terminate()
                    await process.wait()
                    break

                if reboot_event.is_set():
                    LOGGER.info("Reboot event detected. Terminating the process.")
                    kill_process_tree(process.pid)
                    process.terminate()  # Terminate the process first
                    await process.wait()

                    LOGGER.info("Canceling capture task due to reboot.")
                    capture_task.cancel()

                    # Wait for the capture task to finish handling the cancellation
                    await asyncio.gather(capture_task, return_exceptions=True)

                    reboot_event.clear()
                    break

                await asyncio.sleep(0.1)  # Sleep briefly to prevent busy-waiting

            LOGGER.info(f"Executable {exe_path} exited with return code {process.returncode}")

        except Exception as e:
            LOGGER.error(f"An error occurred: {str(e)}")

        await asyncio.sleep(restart_delay)

        if stop_event.is_set():
            LOGGER.info("Stop event set, terminating the monitoring loop.")
            break

        LOGGER.info("Restarting the executable...")

    LOGGER.info("Monitoring loop terminated.")

async def capture_output(process: asyncio.subprocess.Process, stop_event: asyncio.Event):
    stdout_output = ''

    while True:
        try:
            # Read a chunk of data (e.g., 4096 bytes)
            stdout_chunk = await process.stdout.read(4096)
            if not stdout_chunk:
                break

            # Decode and handle the chunk of output
            decoded_output = stdout_chunk.decode('utf-8')
            stdout_output += decoded_output
            print(decoded_output, end='')
            sys.stdout.flush()  # Ensure the output is flushed immediately

            # Check if the stop event is set and break the loop if so
            if stop_event.is_set():
                break

        except Exception as e:
            LOGGER.error(f"Error while capturing output: {e}")
            break

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

async def run_and_capture(exe_path: str, args: list[str]):
    # Create a stop event for capturing output
    stop_event = asyncio.Event()

    # Start the subprocess
    process = await run_exe(exe_path, args)

    # Capture the output
    stdout_output = await capture_output(process, stop_event)

    # Wait for the subprocess to exit
    await process.wait()

    # Ensure the stop event is set to clean up the capture task
    stop_event.set()

    LOGGER.info(f'Process completed')
    return stdout_output

