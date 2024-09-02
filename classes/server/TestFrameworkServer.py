import asyncio
from pathlib import Path
from typing import Optional
import xml.etree.ElementTree as ElementTree
from aiohttp import web
import json
import struct

from classes.model.TestFrameworkResult import TestFrameworkResult
from classes.model.TestResult import TestResult
from classes.model.TestSuiteResult import TestSuiteResult
from utils import (network_utils, file_utils)
from utils.logging_utils import LOGGER
from utils.path_utils import ROOT_DIR

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
    local_ip = network_utils.get_local_ip()
    await server.start(local_ip)
    
    try:
        # Create a task for the provided function so it can run concurrently with the server
        task = asyncio.create_task(task_func())
        
        # Wait for the task to complete while the server is running
        await task
        
    finally:
        # Stop the server
        await server.stop()

class TestFrameworkServer:
    
    def __init__(self):
        # Initializing the aiohttp application
        self.app = web.Application(middlewares=[TestFrameworkServer.cors_middleware])

        # Http
        self.app.add_routes([web.post('/echo', self.http_echo_handler)])
        self.app.add_routes([web.get('/status/{status}', self.http_status)])

        # Websockets
        self.app.add_routes([web.get('/gm_websocket', self.gm_websocket_handler)])
        self.app.add_routes([web.get('/raw_websocket', self.raw_websocket_handler)])
        
        # Used for results
        self.app.add_routes([web.post('/tests', self.http_result_handler)])

        # Runner and site will be used to control the server's lifecycle
        self.runner = None
        self.site = None

    # Middleware to add CORS headers
    @staticmethod
    async def cors_middleware(app, handler):
        async def cors_handler(request):
            response = await handler(request)
            response.headers['Access-Control-Allow-Origin'] = '*'
            return response
        return cors_handler

    @staticmethod
    async def http_echo_handler(request: web.Request):
        """HTTP handler that echoes back the binary data received."""
        data = await request.read()  # Read the request body as bytes

        # Using structured LOGGER instead of print
        LOGGER.info(f"Received HTTP binary data of length {len(data)}")

        # Echoing back the received binary data
        return web.Response(body=data, content_type='application/octet-stream')

    @staticmethod
    async def http_status(request: web.Request):
        """HTTP handler that returns a JSON response with dynamic status."""
        status_code = request.match_info.get('status', "200")  # Default to 200 if not provided
        try:
            status_code = int(status_code)  # Convert to integer
        except ValueError:
            return web.json_response({"error": "Invalid status code"}, status=400)

        LOGGER.info(f"Received HTTP access with status {status_code}")

        # Preparing the dynamic JSON message
        message = {"message": f"This is a status {status_code} test operation."}

        # Returning the response with the dynamic status and message
        return web.json_response(data=message, status=status_code)

    @staticmethod
    async def gm_websocket_handler(request: web.Request):
        """WebSocket handler that performs a handshake with the client and echoes back the binary data received."""
        LOGGER.info("New gm websocket connection initiated")

        ws = web.WebSocketResponse()
        await ws.prepare(request)

        # Handshake is initially required
        requires_handshake = True

        # Server needs to start the handshake by sending a banner
        await ws.send_bytes(bytes("GM:Studio-Connect", "ascii") + b"\x00")

        async for msg in ws:
            if requires_handshake:
                if not msg.data or msg.type != web.WSMsgType.BINARY:
                    await ws.close()
                    LOGGER.warning("Connection terminated due to non-binary data or empty message during handshake.")
                    break

                if len(msg.data) != 16:
                    await ws.close()
                    LOGGER.warning("Connection terminated due to incorrect data length during handshake.")
                    break

                # Unpacking data assuming it's structured as per your logic
                try:
                    magic1, magic2, magic3, gameid = struct.unpack('<IIIi', msg.data)
                except struct.error as e:
                    await ws.close()
                    LOGGER.error(f"Connection terminated due to unpacking error: {e}")
                    break

                if (magic1 != 0xCAFEBABE or magic2 != 0xDEADB00B or magic3 != 16):
                    await ws.close()
                    LOGGER.warning("Connection terminated due to failed handshake validation.")
                    break

                # Construct and send response
                res = struct.pack('<III', 0xDEAFBEAD, 0xF00DBEEB, 12)
                await ws.send_bytes(res)
                requires_handshake = False
                LOGGER.info(f"Handshake succeeded (gameid = {gameid}). Starting Echo.")
            else:
                await ws.send_bytes(msg.data)
                LOGGER.debug("Echoed binary data back to client.")

        LOGGER.info("WebSocket handler completed.")
        return ws

    @staticmethod
    async def raw_websocket_handler(request: web.Request):
        """WebSocket handler that echoes back the binary data received."""
        LOGGER.info("New raw websocket connection initiated")

        ws = web.WebSocketResponse()
        await ws.prepare(request)

        LOGGER.info("WebSocket connection established. Starting Echo.")

        async for msg in ws:
            if msg.type == web.WSMsgType.BINARY:
                await ws.send_bytes(msg.data)
                LOGGER.debug(f"Echoed binary data of length {len(msg.data)} bytes")
            elif msg.type == web.WSMsgType.TEXT:
                # Optionally handle text messages differently
                LOGGER.warning("Received text message on raw binary echo service")
                await ws.send_str(msg.data)
            elif msg.type == web.WSMsgType.CLOSE:
                LOGGER.info("WebSocket connection closed by client.")
            else:
                LOGGER.warning(f"Unhandled message type: {msg.type}")

        LOGGER.info("WebSocket handler completed.")
        return ws
    
    @staticmethod
    async def http_result_handler(request: web.Request):
        LOGGER.info("Received request to save JSON|XML data")

        try:
            # Parse JSON body
            body: dict = await request.json()
            LOGGER.debug(f"JSON data parsed successfully: {body}")
        
            run_name: str = body["data"]["run_name"]
            results: list[dict] = body["data"]["results"]

            framework_result: Optional[TestFrameworkResult] = None
            suite_results: dict[str, TestSuiteResult] = {}

            for result in results:

                # Extract necessary fields from the parsed JSON
                result_data: Optional[dict] = result.get('details')
                suite: Optional[str] = result.get('suite')
                timestamp: Optional[float] = result.get('timestamp')

                # Initialize framework result if not already set
                if not framework_result:
                    framework_result = TestFrameworkResult(name=run_name, timestamp=timestamp)
                    LOGGER.debug(f"Initialized framework result: {framework_result.name} at {timestamp}")

                # Initialize suite result or switch to a new suite if necessary
                if not suite in suite_results:
                    suite_result = TestSuiteResult(name=suite, timestamp=timestamp)
                    framework_result.testsuites.append(suite_result)
                    suite_results[suite] = suite_result
                    LOGGER.debug(f"Initialized new test suite result: {suite} at {timestamp}")

                # Add the test result to the current suite
                result = TestResult(**result_data)
                suite_results[suite].tests.append(result)
                LOGGER.debug(f"Added test result: {result_data['name']} with status {result_data['result']}")

            filename = f'testFramework_{run_name.replace(":", "_")}'
            output_path = ROOT_DIR / 'output' / 'results'
            output_path.mkdir(parents=True, exist_ok=True)

            ## Save to a json file
            file_utils.save_data_as_json(framework_result.to_dict(), output_path / f'{filename}.json')

            element = framework_result.to_xml()         

            ## Create an ElementTree object from the root element
            tree = ElementTree.ElementTree(element)
            tree.write(output_path / f'{filename}.xml', encoding='UTF-8', xml_declaration=True)

            # Respond to indicate success
            return web.Response(text="JSON saved successfully")

        except json.JSONDecodeError as e:
            # Log and respond to indicate a JSON parsing error
            LOGGER.error(f"Error parsing JSON from request: {e}")
            return web.Response(status=400, text="Invalid JSON data")

        except Exception as e:
            # Log and respond to indicate a generic error
            LOGGER.error(f"An error occurred: {e}")
            return web.Response(status=500, text="Internal server error")

    async def start(self, host='localhost', port=8080):
        """Start the server."""
        LOGGER.info(f"Starting server on {host}:{port}")

        # Initialize the runner, set it up, then create a site to bind to an address
        self.runner = web.AppRunner(self.app)
        await self.runner.setup()
        self.site = web.TCPSite(self.runner, host, port)
        await self.site.start()

        LOGGER.info("Server started successfully.")

    async def stop(self):
        """Stop the server."""
        LOGGER.info("Stopping server...")
        if self.site:
            await self.site.stop()
            await self.runner.cleanup()

        LOGGER.info("Server stopped successfully.")