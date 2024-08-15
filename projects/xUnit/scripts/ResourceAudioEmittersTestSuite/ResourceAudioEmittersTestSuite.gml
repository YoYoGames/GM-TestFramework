// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResourceAudioEmittersTestSuite() : TestSuite() constructor {
	
	addFact("Audio emitter creation test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// check that emitter exists
		var exists = audio_emitter_exists(emit);
		assert_true(exists, "audio_emitter_create should sucessfully create emitter");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio bus test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// check that emitter gets assigned to the main bus correctly
		var currentBus = audio_emitter_get_bus(emit);
		assert_equals(currentBus, audio_bus_main, "audio_emitter_get_bus should return the main audio bus by default");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio bus test #2", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// create bus and link emitter to it
		var bus = audio_bus_create();
		audio_emitter_bus(emit, bus);
		
		// check that emitter has been correctly linked to the bus
		var currentBus = audio_emitter_get_bus(emit);
		assert_equals(currentBus, bus, "audio_emitter_bus should link the emitter to a bus correctly");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio bus test #3", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// create bus and link emitter to it
		var bus = audio_bus_create();
		audio_emitter_bus(emit, bus);
		
		// check that emitter is on the array of emitters of the bus
		var emitterArray = audio_bus_get_emitters(bus)
		var contains = array_contains(emitterArray, emit); 
		assert_true(contains, "audio_bus_get_emitters should get the correct array of emitters");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter position test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// set position and check if it is correct
		audio_emitter_position(emit, room_width, room_height, 10);
		
		var posX = audio_emitter_get_x(emit);
		var posY = audio_emitter_get_y(emit);
		var posZ = audio_emitter_get_z(emit);
		
		assert_equals(posX, room_width, "audio_emitter_position should correctly set the X position");
		assert_equals(posY, room_height, "audio_emitter_position should correctly set the Y position");
		assert_equals(posZ, 10, "audio_emitter_position should correctly set the Z position");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter velocity test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// set velocity and check if it is correct
		audio_emitter_velocity(emit, 5, 10, 15);
		
		var velX = audio_emitter_get_vx(emit);
		var velY = audio_emitter_get_vy(emit);
		var velZ = audio_emitter_get_vz(emit);
		
		assert_equals(velX, 5, "audio_emitter_velocity should correctly set the X velocity");
		assert_equals(velY, 10, "audio_emitter_velocity should correctly set the Y velocity");
		assert_equals(velZ, 15, "audio_emitter_velocity should correctly set the Z velocity");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter gain test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// test gain
		audio_emitter_gain(emit, 0.5);
		var gain = audio_emitter_get_gain(emit);
		
		assert_equals(gain, 0.5, "audio_emitter_gain should correctly set the gain");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter pitch test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// test pitch
		audio_emitter_pitch(emit, 1.5);
		var pitch = audio_emitter_get_pitch(emit);
		
		assert_equals(pitch, 1.5, "audio_emitter_pitch should correctly set the pitch");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter listener mask test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// test listener mask
		audio_emitter_set_listener_mask(emit, 1980);
		var listenerMask = audio_emitter_get_listener_mask(emit);
		
		assert_equals(listenerMask, 1980, "audio_emitter_set_listener_mask should correctly set the listener mask");
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio emitter freeing test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// create bus and link emitter to it
		var bus = audio_bus_create();
		audio_emitter_bus(emit, bus);
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
		// check that emitter is no longer on the array of emitters of the bus
		var emitterArray = audio_bus_get_emitters(bus)
		var contains = array_contains(emitterArray, emit); 
		assert_false(contains, "audio_emitter_free should remove the emitter from the array of emitters on the bus");
		
	});
	
	addFact("Audio emitter freeing test #2", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// test removing emitter from memory
		
		// remove emitter from memory
		audio_emitter_free(emit);
		
		// check that emitter doesn't exist anymore
		var exists = audio_emitter_exists(emit);
		assert_false(exists, "audio_emitter_free should free the emitter from the memory");
		
	});
	
	addFact("Audio emitter falloff test #1", function() {
		
		// test setting falloff model
		assert_not_throws( function() {
			
			// create emitter
			var emit = audio_emitter_create();
			// set falloff model
			audio_emitter_falloff(emit, audio_falloff_linear_distance, 10, 10);
			// remove emitter from memory
			audio_emitter_free(emit);
			
		}, "audio_emitter_falloff should not throw error");
		
	});
	
	addFact("Audio playback on emitter test #1", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// play sound on emitter
		var sound = audio_play_sound_on(emit, handle_testSound, false, 1);
		
		// check that sound is not null
		assert_not_null(sound, "audio_play_sound_on should not return null");
		
		// stop audio and remove emitter from memory
		audio_stop_all();
		audio_emitter_free(emit);
		
	});
	
	addFact("Audio playback on emitter test #2", function() {
		
		// create emitter
		var emit = audio_emitter_create();
		
		// play sound on emitter
		var sound = audio_play_sound_on(emit, handle_testSound, false, 1);
		
		// check that sound is playing
		var isPlaying = audio_is_playing(sound);
		assert_true(isPlaying, "audio_play_sound_on should start playing the sound");
		
		// stop audio and remove emitter from memory
		audio_stop_all();
		audio_emitter_free(emit);
		
	});
	
}