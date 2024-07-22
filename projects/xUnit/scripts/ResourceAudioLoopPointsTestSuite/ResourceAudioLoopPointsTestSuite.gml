function ResourceAudioLoopPointsTestSuite() : TestSuite() constructor {
	
	addFact("Audio loop point getters / setters test", function() {
		
		// Create play sound and set it to loop
		sound = audio_play_sound(snd_compressed, 1, false);
		audio_sound_loop(sound, true);
		
		// Check if it has been set correctly
		var looped = audio_sound_get_loop(sound);
		assert_true(looped, "Audio should loop");
		
		// Test setting loop start
		audio_sound_loop_start(sound, 0);
		var loopStart = audio_sound_get_loop_start(sound);
		assert_equals(loopStart, 0, "Audio loop cycle start should be at 0 seconds");
		
		// Test setting loop end
		audio_sound_loop_end(sound, 2);
		var loopEnd = audio_sound_get_loop_end(sound);
		assert_equals(loopEnd, 2, "Audio loop cycle end should be at 2 seconds");
		
		audio_stop_all();
		
	});
	
}