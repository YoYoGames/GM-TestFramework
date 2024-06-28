
function TestAudioListenerData(listenerCount, startingTestNumber) {
	
	for (var i = 0; i < listenerCount; i++) {
				
		// Get listener info
		var info = audio_get_listener_info(i);
		assert_not_null(info, "#" + string(startingTestNumber) + " audio listener info should not be null");
		
		// Get listener data
		var data = audio_listener_get_data(info[? "index"]);
		
		// Test position
		var posX = data[? "x"];
		var posY = data[? "y"];
		var posZ = data[? "z"];
		
		assert_equals(posX, room_width, "#" + string(startingTestNumber + 1) + ".1 position X should be equal to room width");
		assert_equals(posY, room_height, "#" + string(startingTestNumber + 1) + ".2 position Y should be equal to room height");
		assert_equals(posZ, 10, "#" + string(startingTestNumber + 1) + ".3 position Z should be equal to 10");
		
		// Test velocity
		var velX = data[? "vx"];
		var velY = data[? "vy"];
		var velZ = data[? "vz"];
		
		assert_equals(velX, 5, "#" + string(startingTestNumber + 2) + ".1 velocity X should be 5");
		assert_equals(velY, 10, "#" + string(startingTestNumber + 2) + ".2 velocity Y should be 10");
		assert_equals(velZ, 15, "#" + string(startingTestNumber + 2) + ".3 velocity Z should be 15");
		
		// Test look at vector
		var lookAtX = data[? "lookat_x"];
		var lookAtY = data[? "lookat_y"];
		var lookAtZ = data[? "lookat_z"];
		
		assert_equals(lookAtX, 20, "#" + string(startingTestNumber + 3) + ".1 lookAt X should be 20");
		assert_equals(lookAtY, 25, "#" + string(startingTestNumber + 3) + ".2 lookAt Y should be 25");
		assert_equals(lookAtZ, 30, "#" + string(startingTestNumber + 3) + ".3 lookAt Z should be 30");
		
		// Test up vector
		var upX = data[? "up_x"];
		var upY = data[? "up_y"];
		var upZ = data[? "up_z"];
		
		assert_equals(upX, 0, "#" + string(startingTestNumber + 4) + ".1 up X should be 0");
		assert_equals(upY, 0, "#" + string(startingTestNumber + 4) + ".2 up Y should be 0");
		assert_equals(upZ, 1, "#" + string(startingTestNumber + 4) + ".3 up Z should be 1");
		
		ds_map_destroy(info);
		ds_map_destroy(data);
				
	}
}

function ResourceAudioListenersTestSuite() : TestSuite() constructor {
		
		addFact("Data setting and getting for one listener", function() {
			
			// Set data
			// Position
			audio_listener_position(room_width, room_height, 10);
			// Velocity
			audio_listener_velocity(5, 10, 15);
			// Orientation
			audio_listener_orientation(20, 25, 30, 0, 0, 1);
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			assert_greater_or_equal(listenerCount, 1, "#1 listener count should be greater or equal to 1");
			
			// Test listener data
			TestAudioListenerData(listenerCount, 2);
		
		});
		
		addFact("Data setting and getting for multiple listeners", function() {
			
			// Get listener count
			var listenerCount = audio_get_listener_count();
			assert_greater_or_equal(listenerCount, 1, "#1 listener count should be greater or equal to 1");
			
			for (var i = 0; i < listenerCount; i++) {
				
				// Set data
				// Position
				audio_listener_set_position(i, room_width, room_height, 10);
				// Velocity
				audio_listener_set_velocity(i, 5, 10, 15);
				// Orientation
				audio_listener_set_orientation(i, 20, 25, 30, 0, 0, 1);
			
			}
			
			// Test listener data
			TestAudioListenerData(listenerCount, 2);
			
		});
		
}