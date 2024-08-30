/// @description Insert description here
// You can write your code in this editor
 
#macro NETWORK_CMD_TESTS "TESTS" 
#macro NETWORK_CMD_RUN "RUN" 
#macro NETWORK_CMD_EXIT "EXIT" 
#macro NETWORK_CMD_QUIT "QUIT" 
 
if (async_load[? "id"] != socket) return; 
 
var _type = async_load[? "type"]; 
 
switch (_type) { 
 
	case network_type_non_blocking_connect: 
		// If the connection didn't succeed don't do anything 
		if (!async_load[? "succeeded"]) { 
			log_debug("NETWORK: Failed to connect!"); 
			using_remote_server = false; 
			testFramework.run(undefined, {}); 
			return; 
		} 
		 
		log_info("NETWORK: Connected"); 
		break; 
		 
	case network_type_data: 
		log_debug("NETWORK: network_type_data"); 
		var _incoming = buffer_read(async_load[? "buffer"], buffer_string); 
		 
		// Split command from arguments 
		var _parts = string_split(_incoming, " ", true, 1); 
		 
		// Command if the first part (make upper case) 
		var _message, _command = string_upper(_parts[0]); 
		 
		// Switch on the available commands 
		switch (_command) { 
			// Return a line break separated list of all tests (ie.: formatted as '<suite>@<test>') 
			case NETWORK_CMD_TESTS: 
				var _tests = testFramework.getTestPaths(false); 
				_message = string_join_ext("\n", _tests); 
				break; 
								 
			// Runs a test or suite (arguments should be the test name of suite name) 
			case NETWORK_CMD_RUN: 
				// Theck if there are arguments 
				if (array_length(_parts) != 2) { 
					_message = "Run command was incorrectly formatted: RUN <TEST|SUITE>"; 
					break; 
				} 
				 
				// Get the test name 
				var _test_name = _parts[1]; 
				var _test = testFramework.findTestByPath(_test_name); 
				_test.run(undefined, {
					path: _test_name, 
				}); 
				return; 
				 
			// Quits the runner 
			case NETWORK_CMD_EXIT: 
			case NETWORK_CMD_QUIT: 
				network_destroy(socket); 
				game_end(0); 
				return; 
				 
			// Invalid format 
			default: 
				_message = $"Unknown command: '{_command}'"; 
				break; 
		} 
		buffer_seek(network_buffer, buffer_seek_start, 0); 
		buffer_write(network_buffer, buffer_string, _message); 
		network_send_raw(socket, network_buffer, buffer_tell(network_buffer)); 
		break; 
}

