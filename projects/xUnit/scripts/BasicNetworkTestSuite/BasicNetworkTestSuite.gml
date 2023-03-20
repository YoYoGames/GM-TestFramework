

function BasicNetworkTestSuite() : TestSuite() constructor {
	
	// #### SYNC ####

	addFact("network_resolveTest", function() {
			
		var output = network_resolve("www.google.com");
		assert_typeof(output, "string", "#1 network_resolve(), output failed to match the type string");
			
		assert_not_equals(output, "", "#2 network_resolve(), failed to resolve the DNS.");
			
	})

	// #### ASYNC ####
	
	addTestAsync("network_connect_handshake_test", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect(socket, "ws://127.0.0.1/websockets?mode=handshake", 8080);
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			if (_asyncLoad[? "type"] == network_type_non_blocking_connect) {
				assert_true(_asyncLoad[? "succeeded"], "#1 network_connect(), fail to require handshake");
				
				network_destroy(socket);
				

				test_end();
			}
		}
	
	}, { test_timeout_millis: 3000 });
	
	addTestAsync("network_connect_fail", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect(socket, "ws://127.0.0.1/websockets?mode=raw", 8080);	
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			if (_asyncLoad[? "type"] == network_type_non_blocking_connect) {
				assert_false(_asyncLoad[? "succeeded"], "#1 network_connect(), should have required handshake");
				
				network_destroy(socket);
				
				test_end();
			}
		}
	
	}, { test_timeout_millis: 3000 });
		
	addTestAsync("network_connect_raw_test", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect_raw(socket, "ws://127.0.0.1/websockets?mode=raw", 8080);	
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			if (_asyncLoad[? "type"] == network_type_non_blocking_connect) {
				assert_true(_asyncLoad[? "succeeded"], "#1 network_connect(), fail to require handshake");
					
				network_destroy(socket);
				
				test_end();
			}
		}
	
	}, { test_timeout_millis: 3000 });
	
	addTestAsync("network_send_packet_test", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect_raw(socket, "ws://127.0.0.1/websockets?mode=raw", 8080);
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			switch (_asyncLoad[? "type"]) {
				
				case network_type_non_blocking_connect:
				
					assert_true(_asyncLoad[? "succeeded"], "#1 network_connect(), fail to require handshake");

					data = random(1.0);
	
					var buf = buffer_create(32, buffer_grow, 1);
					buffer_write(buf, buffer_f64, data);
	
					var buf_size = buffer_tell(buf);
	
					dataLength = network_send_raw(socket, buf, buf_size);
					buffer_delete(buf);
					
					break;
				
				case network_type_data:
				
					var output, buf = _asyncLoad[? "buffer"];
					
					output = _asyncLoad[? "size"];
					assert_equals(output, dataLength, "#2 network_send_packet(), failed sent/received data size doesn't match");
					
					output = buffer_read(buf, buffer_f64);
					assert_equals(output, data, "#3 network_send_packet(), failed sent/received values don't match");
					
					network_destroy(socket);
					
					test_end();
					
					break;
			}
		}
	
	}, { test_timeout_millis: 3000 });

	addTestAsync("network_send_packet_handshake_test", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect(socket, "ws://127.0.0.1/websockets?mode=handshake", 8080);
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			switch (_asyncLoad[? "type"]) {
				
				case network_type_non_blocking_connect:
				
					assert_true(_asyncLoad[? "succeeded"], "#1 network_connect(), fail to require handshake");

					data = random(1.0);
	
					var buf = buffer_create(32, buffer_grow, 1);
					buffer_write(buf, buffer_f64, data);
	
					var buf_size = buffer_tell(buf);
	
					dataLength = network_send_raw(socket, buf, buf_size);
					buffer_delete(buf);
					
					break;
				
				case network_type_data:
				
					var output, buf = _asyncLoad[? "buffer"];
					
					output = _asyncLoad[? "size"];
					assert_equals(output, dataLength, "#2 network_send_packet(), failed sent/received data size doesn't match");
					
					output = buffer_read(buf, buffer_f64);
					assert_equals(output, data, "#3 network_send_packet(), failed sent/received values don't match");
					
					network_destroy(socket);
					
					test_end();
					
					break;
			}
		}
	
	}, { test_timeout_millis: 3000 });
	
	addTestAsync("network_send_packet_handshake_limit_test", objTestAsyncNetworking, {
		
		ev_create: function() {
		
			network_set_config(network_config_connect_timeout, 2000);
			network_set_config(network_config_use_non_blocking_socket, true);

			socket = network_create_socket(network_socket_ws);
			network_connect(socket, "ws://127.0.0.1/websockets?mode=handshake", 8080);
		
		},
		ev_web_networking: function() {
			
			var _asyncLoad = async_load;
			
			if (_asyncLoad[? "id"] != socket) exit;
			
			switch (_asyncLoad[? "type"]) {
				
				case network_type_non_blocking_connect:
				
					assert_true(_asyncLoad[? "succeeded"], "#1 network_connect(), fail to require handshake");

					var buf_size = 90000;
					var buf = buffer_create(buf_size, buffer_fixed, 1);
					buffer_fill(buf, 0, buffer_u8, 12, buf_size);
	
					dataLength = network_send_raw(socket, buf, buf_size);
					buffer_delete(buf);
					
					break;
				
				case network_type_data:
				
					var output, buf = _asyncLoad[? "buffer"];
					
					output = _asyncLoad[? "size"];
					assert_equals(output, dataLength, "#2 network_send_packet(), failed sent/received data size doesn't match");
										
					network_destroy(socket);
					
					test_end();
					
					break;
			}
		}
	
	}, { test_timeout_millis: 3000 });

}
