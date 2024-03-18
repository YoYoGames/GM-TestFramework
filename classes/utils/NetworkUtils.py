import socket

class NetworkUtils:

    @staticmethod
    def get_local_ip():
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