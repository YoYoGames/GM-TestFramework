function TestAudioListenerPosition(listenerCount, expectedX, expectedY, expectedZ) {
	
	for (var i = 0; i < listenerCount; i++) {
				
		// Get listener info
		var info = audio_get_listener_info(i);
		assert_not_null(info, "audio_get_listener_info should not return null");
		
		// Get listener data
		var data = audio_listener_get_data(info[? "index"]);
		
		// Test position
		var posX = data[? "x"];
		var posY = data[? "y"];
		var posZ = data[? "z"];
		
		assert_equals(posX, expectedX, "audio_listener_get_data should be able to get the correct X positional data");
		assert_equals(posY, expectedY, "audio_listener_get_data should be able to get the correct Y positional data");
		assert_equals(posZ, expectedZ, "audio_listener_get_data should be able to get the correct Z positional data");
		
		ds_map_destroy(info);
		ds_map_destroy(data);
	}
	
}

function TestAudioListenerVelocity(listenerCount, expectedX, expectedY, expectedZ) {
	
	for (var i = 0; i < listenerCount; i++) {
				
		// Get listener info
		var info = audio_get_listener_info(i);
		assert_not_null(info, "audio_get_listener_info should not return null");
		
		// Get listener data
		var data = audio_listener_get_data(info[? "index"]);

		// Test velocity
		var velX = data[? "vx"];
		var velY = data[? "vy"];
		var velZ = data[? "vz"];
		
		assert_equals(velX, expectedX, "audio_listener_get_data should be able to get the correct X velocity data");
		assert_equals(velY, expectedY, "audio_listener_get_data should be able to get the correct Y velocity data");
		assert_equals(velZ, expectedZ, "audio_listener_get_data should be able to get the correct Z velocity data");
		
		ds_map_destroy(info);
		ds_map_destroy(data);
	}
	
}

function TestAudioListenerLookAtVector(listenerCount, expectedX, expectedY, expectedZ) {
	
	for (var i = 0; i < listenerCount; i++) {
				
		// Get listener info
		var info = audio_get_listener_info(i);
		assert_not_null(info, "audio_get_listener_info should not return null");
		
		// Get listener data
		var data = audio_listener_get_data(info[? "index"]);
		
		// Test look at vector
		var lookAtX = data[? "lookat_x"];
		var lookAtY = data[? "lookat_y"];
		var lookAtZ = data[? "lookat_z"];
		
		assert_equals(lookAtX, expectedX, "audio_listener_get_data should be able to get the correct X LookAt vector data");
		assert_equals(lookAtY, expectedY, "audio_listener_get_data should be able to get the correct Y LookAt vector data");
		assert_equals(lookAtZ, expectedZ, "audio_listener_get_data should be able to get the correct Z LookAt vector data");
		
		ds_map_destroy(info);
		ds_map_destroy(data);
	}
	
}

function TestAudioListenerUpVector(listenerCount, expectedX, expectedY, expectedZ) {
	
	for (var i = 0; i < listenerCount; i++) {
				
		// Get listener info
		var info = audio_get_listener_info(i);
		assert_not_null(info, "audio_get_listener_info should not return null");
		
		// Get listener data
		var data = audio_listener_get_data(info[? "index"]);
		
		// Test up vector
		var upX = data[? "up_x"];
		var upY = data[? "up_y"];
		var upZ = data[? "up_z"];
		
		assert_equals(upX, expectedX, "audio_listener_get_data should be able to get the correct X UpVector data");
		assert_equals(upY, expectedY, "audio_listener_get_data should be able to get the correct Y UpVector data");
		assert_equals(upZ, expectedZ, "audio_listener_get_data should be able to get the correct Z UpVector data");
		
		ds_map_destroy(info);
		ds_map_destroy(data);
	}
	
}

function ResourceAudioListenersTestSuite() : TestSuite() constructor {
		
		addFact("audio_get_listener_count test #1", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			assert_greater_or_equal(listenerCount, 1, "audio_get_listener_count should return greater or equal to 1");
			
		});
		
		addFact("audio_listener_set_position test #1", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Set data
				// Position
				audio_listener_set_position(i, room_width, room_height, 10);
			
			}
			
			// Test listener data
			TestAudioListenerPosition(listenerCount, room_width, room_height, 10);
			
		});
		
		addFact("audio_listener_set_velocity test #1", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Set data
				// Velocity
				audio_listener_set_velocity(i, 5, 10, 15);
			
			}
			
			// Test listener data
			TestAudioListenerVelocity(listenerCount, 5, 10, 15);
			
		});
		
		addFact("audio_listener_set_orientation test #1", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Set data
				// Orientation
				audio_listener_set_orientation(i, 20, 25, 30, 0, 0, 1);
			
			}
			
			// Test listener data
			TestAudioListenerLookAtVector(listenerCount, 20, 25, 30);
			
		});
		
		addFact("audio_listener_set_orientation test #2", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Set data
				// Orientation
				audio_listener_set_orientation(i, 20, 25, 30, 0, 0, 1);
			
			}
			
			// Test listener data
			TestAudioListenerUpVector(listenerCount, 0, 0, 1);
			
		});
		
		addFact("Listener mask test #1", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Test listener mask
				audio_set_listener_mask(i);
				
				var mask = audio_get_listener_mask();
				assert_equals(mask, i, "audio_get_listener_mask should return " + string(i));
				
			}
			
		});
		
}