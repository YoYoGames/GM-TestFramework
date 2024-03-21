from pathlib import Path
import xml.etree.ElementTree as ElementTree
from aiohttp import web
import json
import logging
import struct

from classes.model.TestFrameworkResult import TestFrameworkResult
from classes.utils.FileUtils import FileUtils

# Define the asynchronous function to manage the server
async def manage_server(task_func: callable):
    """
    Starts the echo server, executes the provided asynchronous task, 
    and then stops the server.

    Args:
    - task_func (callable): An asynchronous function to execute while the server is running.
    """
    server = TestFrameworkServer()
    
    # Start the server
    await server.start()
    
    try:
        # Ensure task_func is awaited
        await task_func()
        
    finally:
        # Stop the server
        await server.stop()

class TestFrameworkServer:
    def __init__(self):
        # Initializing the aiohttp application
        self.app = web.Application()

        # Used for unit tests
        self.app.add_routes([web.post('/echo', self.http_echo_handler)])
        self.app.add_routes([web.get('/gm_websocket', self.gm_websocket_handler)])
        self.app.add_routes([web.get('/raw_websocket', self.raw_websocket_handler)])

        # Used for results
        self.app.add_routes([web.post('/tests', self.http_result_handler)])

        # Runner and site will be used to control the server's lifecycle
        self.runner = None
        self.site = None

    @staticmethod
    async def http_echo_handler(request: web.Request):
        """HTTP handler that echoes back the binary data received."""
        data = await request.read()  # Read the request body as bytes

        # Using structured logging instead of print
        logging.info(f"Received HTTP binary data of length {len(data)}")

        # Echoing back the received binary data
        return web.Response(body=data, content_type='application/octet-stream')

    @staticmethod
    async def gm_websocket_handler(request: web.Request):
        """WebSocket handler that performs a handshake with the client and echoes back the binary data received."""
        logging.info("New gm websocket connection initiated")

        ws = web.WebSocketResponse()
        await ws.prepare(request)

        # Handshake is initially required
        requires_handshake = True

        async for msg in ws:
            if requires_handshake:
                if not msg.data or msg.type != web.WSMsgType.BINARY:
                    await ws.close()
                    logging.warning("Connection terminated due to non-binary data or empty message during handshake.")
                    break

                if len(msg.data) != 16:
                    await ws.close()
                    logging.warning("Connection terminated due to incorrect data length during handshake.")
                    break

                # Unpacking data assuming it's structured as per your logic
                try:
                    magic1, magic2, magic3, gameid = struct.unpack('<IIIi', msg.data)
                except struct.error as e:
                    await ws.close()
                    logging.error(f"Connection terminated due to unpacking error: {e}")
                    break

                if (magic1 != 0xCAFEBABE or magic2 != 0xDEADB00B or magic3 != 16):
                    await ws.close()
                    logging.warning("Connection terminated due to failed handshake validation.")
                    break

                # Construct and send response
                res = struct.pack('<III', 0xDEAFBEAD, 0xF00DBEEB, 12)
                await ws.send_bytes(res)
                requires_handshake = False
                logging.info(f"Handshake succeeded (gameid = {gameid}). Starting Echo.")
            else:
                await ws.send_bytes(msg.data)
                logging.debug("Echoed binary data back to client.")

        logging.info("WebSocket handler completed.")
        return ws

    @staticmethod
    async def raw_websocket_handler(request: web.Request):
        """WebSocket handler that echoes back the binary data received."""
        logging.info("New raw websocket connection initiated")

        ws = web.WebSocketResponse()
        await ws.prepare(request)

        logging.info("WebSocket connection established. Starting Echo.")

        async for msg in ws:
            if msg.type == web.WSMsgType.BINARY:
                await ws.send_bytes(msg.data)
                logging.debug(f"Echoed binary data of length {len(msg.data)} bytes")
            elif msg.type == web.WSMsgType.TEXT:
                # Optionally handle text messages differently
                logging.warning("Received text message on raw binary echo service")
                await ws.send_str(msg.data)
            elif msg.type == web.WSMsgType.CLOSE:
                logging.info("WebSocket connection closed by client.")
            else:
                logging.warning(f"Unhandled message type: {msg.type}")

        logging.info("WebSocket handler completed.")
        return ws

    @staticmethod
    async def http_result_handler(request: web.Request):
        logging.info("Received request to save JSON data")

        try:
            # Parse JSON body
            body = await request.json()
            logging.info(f"JSON data parsed successfully: {body}")

            run_name: str = body["data"]["name"]
            filename = f'testFramework_{run_name.replace(":", "_")}'
            output_path = Path('./output')

            # Save to a file (example: 'output.json')
            FileUtils.save_data_as_json(body, output_path / f'{filename}.json')

            result = TestFrameworkResult(**body["data"])
            element = result.to_xml()

            # Create an ElementTree object from the root element
            tree = ElementTree.ElementTree(element)
            tree.write(output_path / f'{filename}.xml', encoding='UTF-8', xml_declaration=True)

            # Respond to indicate success
            return web.Response(text="JSON saved successfully")

        except json.JSONDecodeError as e:
            # Log and respond to indicate a JSON parsing error
            logging.error(f"Error parsing JSON from request: {e}")
            return web.Response(status=400, text="Invalid JSON data")

        except Exception as e:
            # Log and respond to indicate a generic error
            logging.error(f"An error occurred: {e}")
            return web.Response(status=500, text="Internal server error")

    async def start(self, host='localhost', port=8080):
        """Start the server."""
        logging.info(f"Starting server on {host}:{port}")

        # Initialize the runner, set it up, then create a site to bind to an address
        self.runner = web.AppRunner(self.app)
        await self.runner.setup()
        self.site = web.TCPSite(self.runner, host, port)
        await self.site.start()

        logging.info("Server started successfully.")

    async def stop(self):
        """Stop the server."""
        logging.info("Stopping server...")
        if self.site:
            await self.site.stop()
            await self.runner.cleanup()

        logging.info("Server stopped successfully.")