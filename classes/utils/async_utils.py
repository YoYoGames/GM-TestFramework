import asyncio
import logging
import sys
from typing import Callable, Optional

from classes.utils.LoggingUtils import LoggingUtils

import asyncio
import logging

async def run_exe(exe_path, args, logger: Optional[logging.Logger] = None) -> asyncio.subprocess.Process:

    if not logger:
        logger = logging.getLogger()

    logger.info(f'Running {exe_path} with arguments {args}')

    process = await asyncio.create_subprocess_exec(
        exe_path,
        *args,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.STDOUT
    )
    return process

async def run_and_monitor_exe(exe_path: str, args: list[str], stop_event: asyncio.Event, logger: Optional[logging.Logger] = None, restart_delay: float = 0.5):
    """
    Continuously run an executable, restarting it if it closes or crashes,
    unless the stop_event is set.

    Args:
        exe_path (str): The path to the executable.
        args (list[str]): A list of arguments to pass to the executable.
        stop_event (asyncio.Event): An event to signal when to stop restarting the executable.
        logger (Optional[logging.Logger]): A logger to log messages. If None, the root logger will be used.
        restart_delay (float): The delay in seconds before restarting the executable if it exits. Default is 0.5 seconds.

    This function will start the executable and continuously monitor its output. If the executable
    exits, it will be restarted after the specified delay unless the stop_event is set. The function
    will terminate the monitoring loop when the stop_event is set, allowing for a clean shutdown.
    """
    
    if not logger:
        logger = logging.getLogger()

    while not stop_event.is_set():
        logger.info(f"Starting executable: {exe_path} with arguments: {args}")

        # Start the subprocess
        process = await run_exe(exe_path, args)

        # Capture the output and monitor the process
        try:
            while True:
                # Read process output
                output = await process.stdout.readline()
                if output:
                    logger.log(logging.NOTSET, f"Process output: {output.decode().strip()}")
                else:
                    break  # No more output, the process has likely exited

            # Wait for the process to exit
            await process.wait()

            logger.info(f"Executable {exe_path} exited with return code {process.returncode}")

        except Exception as e:
            logger.error(f"An error occurred: {str(e)}")

        # Optionally, add a delay before restarting
        await asyncio.sleep(restart_delay)

        if stop_event.is_set():
            logger.info("Stop event set, terminating the monitoring loop.")
            break

        logger.info("Restarting the executable...")

    logger.info("Monitoring loop terminated.")

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

async def run_exe_and_capture(exe_path: str, args: list[str], logger: Optional[logging.Logger] = None):
    logging.info(f'Running {exe_path} with arguments {args}')
    
    # Start the subprocess
    process = await run_exe(exe_path, args, logger)
    
    stdout_output = await capture_output(process)
    
    await process.wait()  # Wait for the subprocess to exit

    logging.info(f'Process completed')
    return stdout_output

class AsyncUtils:

    @staticmethod
    async def _run_exe(exe_path: str, args: list[str]) -> asyncio.subprocess.Process:
        # Start the subprocess
        process = await asyncio.create_subprocess_exec(
            exe_path,
            *args,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.STDOUT
        )
        return process
    
    @staticmethod
    async def _capture_output(process: asyncio.subprocess.Process):
        
        stdout_output = ''

        # Don't print the level in the logger for this function
        LoggingUtils.config_logger(format='%(asctime)s %(message)s')
        
        # Read output line by line as it becomes available
        while True:
            stdout_line = await process.stdout.readline()
            if not stdout_line:
                break
            stripped_output = stdout_line.decode('utf-8').strip()
            if stripped_output != '':
                stdout_output += stripped_output + '\n'
                logging.info(stripped_output)

        # Return logger to default configuration if needed
        LoggingUtils.config_logger()

        return stdout_output
    
    @staticmethod
    async def run_exe_and_capture(exe_path: str, args: list[str]):
        logging.info(f'Running {exe_path} with arguments {args}')
        
        # Start the subprocess
        process = await AsyncUtils._run_exe(exe_path, args)
        
        stdout_output = await AsyncUtils._capture_output(process)
        
        await process.wait()  # Wait for the subprocess to exit

        logging.info(f'Process completed')
        return stdout_output

    @staticmethod
    async def _handle_client(reader: asyncio.StreamReader, writer: asyncio.StreamWriter, stop_event: asyncio.Event, timeout: int):
        """
        Handles communication with a single connected client.
        """
        addr = writer.get_extra_info('peername')
        print(f"Client connected: {addr}")

        try:
            while True:
                command = input("Enter command and args: ")

                if await AsyncUtils._send_command(writer, command):
                    break

                if command.strip().lower() in ['exit', 'quit']:
                    logging.info("Waiting for client to disconnect...")
                    break

                if not await AsyncUtils._receive_response(reader, timeout):
                    break

        except asyncio.CancelledError:
            logging.info("Connection closed.")
        except ConnectionResetError:
            logging.error(f"Connection forcibly closed.")
        finally:
            await AsyncUtils._cleanup(writer, stop_event)

    @staticmethod
    async def _send_command(writer: asyncio.StreamWriter, command: str) -> bool:
        """
        Sends a command to the client and drains the writer.
        Returns True if the connection should be closed, False otherwise.
        """
        try:
            writer.write(command.encode() + b'\0')
            await writer.drain()
            logging.info(f"Sent: {command}")
        except (ConnectionResetError, BrokenPipeError):
            logging.error("Connection lost while sending data to client.")
            return True
        return False

    @staticmethod
    async def _receive_response(reader: asyncio.StreamReader, timeout: int) -> bool:
        """
        Receives a response from the client.
        Returns False if the client disconnected or timed out, True otherwise.
        """
        try:
            data = await asyncio.wait_for(reader.read(1024), timeout=timeout * 60)
            if not data:
                logging.info("Client disconnected.")
                return False
            logging.info(f"Received: {data.decode().strip()}")
        except asyncio.TimeoutError:
            logging.error(f"Client did not respond within {timeout} minutes.")
            return False
        except ConnectionResetError:
            logging.error("Connection lost while reading data from client.")
            return False

        return True

    @staticmethod
    async def _cleanup(writer: asyncio.StreamWriter, stop_event: asyncio.Event):
        """
        Cleans up the writer and sets the stop event.
        """
        try:
            writer.close()
            await writer.wait_closed()
        except Exception as e:
            logging.error(f"Error during cleanup: {e}")
        finally:
            stop_event.set()
    
    @staticmethod
    async def serve(host: str, port: int, timeout: int, stop_event: Optional[asyncio.Event] = None):

        if stop_event == None:
            stop_event = asyncio.Event()

        server = await asyncio.start_server(lambda r, w: AsyncUtils._handle_client(r, w, stop_event, timeout), host, port)
        addr = server.sockets[0].getsockname()
        logging.info(f'Serving on {addr}')

        await stop_event.wait()  # Wait until the client disconnects
        server.close()
        await server.wait_closed()

        logging.info("Server has stopped.")

    @staticmethod
    async def run_exe_and_serve(exe_path: str, args: list[str], host: str = '127.0.0.1', port: int = 8000, timeout: int = 2):
        logging.info(f'Running {exe_path} with arguments {args}')

        # Start the subprocess
        process = await AsyncUtils._run_exe(exe_path, args)

        stop_event = asyncio.Event()

        await AsyncUtils.serve(host, port, timeout, stop_event)

        await process.wait()  # Wait for the subprocess to exit
        logging.info(f'Process completed')

    @staticmethod
    async def run_exe_serve_and_capture(exe_path: str, args: list[str], host: str ='127.0.0.1', port: int = 8000, timeout: int = 2):
        """
        Runs an executable, serves it over TCP, and captures the output.
        """
        logging.info(f'Running {exe_path} with arguments {args}')

        # Start the subprocess
        process = await AsyncUtils._run_exe(exe_path, args)

        stop_event = asyncio.Event()

        # Capture output concurrently while serving the client
        await asyncio.gather(
            AsyncUtils.serve(host, port, timeout, stop_event),
            AsyncUtils._capture_output(process)
        )

        await process.wait()  # Wait for the subprocess to exit
        logging.info(f'Process completed')

    @staticmethod
    async def wait_for_space_key(stop_event: Optional[asyncio.Event] = None):

        if stop_event == None:
            stop_event = asyncio.Event()

        async def check_keypress_unix():
            import termios, tty
            fd = sys.stdin.fileno()
            old_settings = termios.tcgetattr(fd)
            try:
                tty.setcbreak(fd)
                loop = asyncio.get_running_loop()
                while True:
                    if stop_event.is_set():
                        break
                    # Wait for input to be available
                    await loop.run_in_executor(None, sys.stdin.read, 1)
                    if sys.stdin.read(1) == ' ':
                        print("Space key pressed. Stopping server.")
                        stop_event.set()
                        break
            finally:
                termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

        async def check_keypress_win():
            import msvcrt
            while True:
                if stop_event.is_set():
                    break
                await asyncio.sleep(0.1)  # Small delay to yield control
                if msvcrt.kbhit() and msvcrt.getch() == b' ':
                    print("Space key pressed. Stopping server.")
                    stop_event.set()
                    break

        print("Press the space key to stop the server...")
        if sys.platform == 'win32':
            await check_keypress_win()
        else:
            await check_keypress_unix()

