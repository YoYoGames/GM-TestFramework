import random
import socket
import requests

from utils.logging_utils import LOGGER

def get_random_available_port():
    while True:
        port = random.randint(49152, 65535)
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            try:
                s.bind(("", port))
                return port  # Return the port if it is available
            except OSError:
                continue  # If the port is in use, try another one

def get_local_ip() -> str:
    try:
        # Create a temporary UDP socket to determine the local IP address
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as temp_socket:
            # Connect to a remote server (IP and port) that is reachable and doesn't block UDP packets
            # The following IP address (8.8.8.8) is a Google DNS server, and the port (80) is for HTTP
            temp_socket.connect(('8.8.8.8', 80))
            local_ip = temp_socket.getsockname()[0]
    except Exception:
        local_ip = '127.0.0.1'
    return local_ip

def query_url(url: str) -> str:
    LOGGER.info(f'Querying URL: {url}')
    try:
        response = requests.get(url)
        if response.status_code == 200:
            return response.text
        else:
            LOGGER.error(f'Error querying URL {url}: {response.status_code}')
    except Exception as e:
        LOGGER.error(f'Error querying URL {url}: {str(e)}')
    return None