function ResourceAudioLoopPointsTestSuite() : TestSuite() constructor {
	
	addFact("Audio loop point getters / setters test #1", function() {
		
		// Create play sound and set it to loop
		var sound = audio_play_sound(snd_compressed, 1, false);
		audio_sound_loop(sound, true);
		
		// Check if it has been set correctly
		var looped = audio_sound_get_loop(sound);
		assert_true(looped, "audio_sound_loop should set audio's loop accordingly");
		
		audio_stop_all();
		
	});

	addFact("Audio loop point getters / setters test #2", function() {
		
		// Create play sound and set it to loop
		var sound = audio_play_sound(snd_compressed, 1, false);
		audio_sound_loop(sound, true);
		
		// Test setting loop start
		audio_sound_loop_start(sound, 0);
		var loopStart = audio_sound_get_loop_start(sound);
		assert_equals(loopStart, 0, "audio_sound_loop_start should set the loop start accordingly");
		
		audio_stop_all();
		
	});

	addFact("Audio loop point getters / setters test #3", function() {
		
		// Create play sound and set it to loop
		var sound = audio_play_sound(snd_compressed, 1, false);
		audio_sound_loop(sound, true);
		
		// Test setting loop end
		audio_sound_loop_end(sound, 2);
		var loopEnd = audio_sound_get_loop_end(sound);
		assert_equals(loopEnd, 2, "audio_sound_loop_end should set the loop end accordingly");
		
		audio_stop_all();
		
	});
	
	addTestAsync("Audio track position with loop points", objTestAsync, {
		
		ev_create: function() {
			loop_start = 0.1
            loop_end = 0.2
            
			// Create loop points, then play the audio
			audio_sound_loop_start(snd_compressed, loop_start);
			audio_sound_loop_end(snd_compressed, loop_end);
			
			sound = audio_play_sound(snd_compressed, 1, true);
			
			startTime = get_timer() / 1000000; // microseconds --> seconds
		},
		
		ev_step: function() {
			
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			// After 1 second, the audio should be somewhere in the loop section
			if (timeSpent >= 1) {
				
				var trackPos = audio_sound_get_track_position(sound);
				
				assert_less_or_equal(trackPos, loop_end, "Track position is not in the loop section");
				assert_greater_or_equal(trackPos, loop_start, "Track position is not in the loop section");
				
				test_end();
			}
			
		},
		
		ev_cleanup: function() {
			audio_stop_all();
		}
	});
	
}