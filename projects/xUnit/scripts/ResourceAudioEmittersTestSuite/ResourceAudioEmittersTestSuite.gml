// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResourceAudioEmittersTestSuite() : TestSuite() constructor {
	
	addFact("Basic emitter test", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// check that emitter exists
		var exists = audio_emitter_exists(emit);
		assert_true(exists, "#1 Audio emitter should exist");
		
		// check that emitter gets assigned to the main bus correctly
		var currentBus = audio_emitter_get_bus(emit);
		assert_equals(currentBus, audio_bus_main, "#2 emitter should be linked to the main audio bus by default");
		
		// create bus and link emitter to it
		var bus = audio_bus_create();
		audio_emitter_bus(emit, bus);
		
		// check that emitter has been correctly linked to the bus
		currentBus = audio_emitter_get_bus(emit);
		assert_equals(currentBus, bus, "#3 emitter should be correctly linked to the bus");
		
		// set position and check if it is correct
		audio_emitter_position(emit, room_width, room_height, 10);
		
		var posX = audio_emitter_get_x(emit);
		var posY = audio_emitter_get_y(emit);
		var posZ = audio_emitter_get_z(emit);
		
		assert_equals(posX, room_width, "#4.1 X position should be equal to room width");
		assert_equals(posY, room_height, "#4.2 Y position should be equal to room height");
		assert_equals(posZ, 10, "#4.3 Z position should be equal to 10");
		
		// set velocity and check if it is correct
		audio_emitter_velocity(emit, 5, 10, 15);
		
		var velX = audio_emitter_get_vx(emit);
		var velY = audio_emitter_get_vy(emit);
		var velZ = audio_emitter_get_vz(emit);
		
		assert_equals(velX, 5, "#5.1 X velocity should be equal to 5");
		assert_equals(velY, 10, "#5.2 Y velocity should be equal to 10");
		assert_equals(velZ, 15, "#5.3 Z velocity should be equal to 15");
		
		// test gain
		audio_emitter_gain(emit, 0.5);
		var gain = audio_emitter_get_gain(emit);
		
		assert_equals(gain, 0.5, "#6 gain should be 0.5");
		
		// test pitch
		audio_emitter_pitch(emit, 1.5);
		var pitch = audio_emitter_get_pitch(emit);
		
		assert_equals(pitch, 1.5, "#7 pitch should be 1.5");
		
		// test listener mask
		audio_emitter_set_listener_mask(emit, 1980);
		var listenerMask = audio_emitter_get_listener_mask(emit);
		
		assert_equals(listenerMask, 1980, "#8 listener mask should be 1980");
		
		// test removing emitter from memory
		
		// check that emitter is on the array of emitters of the bus
		var emitterArray = audio_bus_get_emitters(bus)
		var contains = array_contains(emitterArray, emit); 
		assert_true(contains, "#9.1 emitter should be on the array of emitters of the bus");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
		// check that emitter is no longer on the array of emitters of the bus
		emitterArray = audio_bus_get_emitters(bus)
		contains = array_contains(emitterArray, emit); 
		assert_false(contains, "#9.2 emitter should NOT be on the array of emitters of the bus after removing it from memory");
		
		// check that emitter doesn't exist anymore
		exists = audio_emitter_exists(emit);
		assert_false(exists, "#9.3 emitter should not exist anymore after removing it from memory");
		
		// test setting falloff model
		assert_not_throws( function() {
			
			// create emitter
			var emit = audio_emitter_create();
			// set falloff model
			audio_emitter_falloff(emit, audio_falloff_linear_distance, 10, 10);
			// remove emitter from memory
			audio_emitter_free(emit);
			
		}, "#10 setting falloff model should not throw error");
		
	});
	
	addFact("Audio playback on emitter test", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// play sound on emitter
		var sound = audio_play_sound_on(emit, handle_testSound, false, 1);
		
		// check that sound is playing
		assert_not_null(sound, "#1 sound should not be null");
		var isPlaying = audio_is_playing(sound);
		assert_true(isPlaying, "#2 sound should be playing");
		
		// stop audio and remove emitter from memory
		audio_stop_all();
		audio_emitter_free(emit);
		
	});
	
}