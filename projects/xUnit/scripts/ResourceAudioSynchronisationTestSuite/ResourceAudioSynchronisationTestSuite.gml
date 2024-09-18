// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResourceAudioSynchronisationTestSuite() : TestSuite() constructor {

	addFact("Sync group creation and playback #1", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		assert_greater_or_equal(syncGroup, 0, "audio_create_sync_group should return 0 or greater");
		
		audio_destroy_sync_group(syncGroup);
		
	});

	addFact("Sync group creation and playback #2", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		assert_equals(sound1, 0, "audio_play_in_sync_group should place sound in sync group correctly (1)");
		assert_equals(sound2, 1, "audio_play_in_sync_group should place sound in sync group correctly (2)");
		
		audio_destroy_sync_group(syncGroup);
		
	});

	addFact("Sync group creation and playback #3", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		// Play audio sync group
		audio_start_sync_group(syncGroup);
		var playing = audio_sync_group_is_playing(syncGroup);
		assert_true(playing, "audio_start_sync_group should start playing sync group");
		
		audio_stop_sync_group(syncGroup);
		
		audio_destroy_sync_group(syncGroup);
		
	});

	addFact("Sync group creation and playback #4", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		// Play audio sync group
		audio_start_sync_group(syncGroup);
		
		// Pause audio sync group
		audio_pause_sync_group(syncGroup);
		var paused = audio_sync_group_is_paused(syncGroup);
		assert_true(paused, "audio_pause_sync_group should pause sync group");
		
		audio_stop_sync_group(syncGroup);
		
		audio_destroy_sync_group(syncGroup);
		
	});

	addFact("Sync group creation and playback #5", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		// Play audio sync group
		audio_start_sync_group(syncGroup);
		
		// Pause audio sync group
		audio_pause_sync_group(syncGroup);
		
		// Resume audio sync group
		audio_resume_sync_group(syncGroup);
		var playing = audio_sync_group_is_playing(syncGroup);
		var paused = audio_sync_group_is_paused(syncGroup);
		assert_true(playing, "audio_resume_sync_group should start playing the sync group again");
		assert_false(paused, "audio_resume_sync_group should make sync group NOT paused");
		
		audio_stop_sync_group(syncGroup);
		
		audio_destroy_sync_group(syncGroup);
		
	});

	addFact("Sync group creation and playback #6", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		// Play audio sync group
		audio_start_sync_group(syncGroup);
		
		// Stop sync group
		audio_stop_sync_group(syncGroup);
		var playing = audio_sync_group_is_playing(syncGroup);
		assert_false(playing, "audio_stop_sync_group should stop the audio sync group");
		
		audio_destroy_sync_group(syncGroup);
		
	});
	
	addTestAsync("Audio sync group track position test #1", objTestAsync, {
		
		ev_create: function() {
			
			// Create the sync group
			syncGroup = audio_create_sync_group(false);
			assert_greater_or_equal(syncGroup, 0, "audio_create_sync_group should return 0 or greater");
			
			if (!audio_exists(snd_compressed)) {
				show_debug_message("Error: Sound resources are not loaded correctly.");
				test_end(TestResult.Skipped);
			}
			
			// Add sounds into the sync group
			var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
			
			// Play audio sync group and start a timer
			audio_start_sync_group(syncGroup);
			
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
		},
		
		ev_step: function() {
		
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			if (timeSpent >= 0.5) {
				
				var trackPos = audio_sync_group_get_track_pos(syncGroup);
                
				assert_greater(trackPos, 0, "audio_sync_group_get_track_pos should have a non-zero track position");
				
				audio_stop_sync_group(syncGroup);
				
				test_end();
			}
		
		},
		
		ev_cleanup: function() {
			
			audio_destroy_sync_group(syncGroup);
			
		}
		
	});
	
}