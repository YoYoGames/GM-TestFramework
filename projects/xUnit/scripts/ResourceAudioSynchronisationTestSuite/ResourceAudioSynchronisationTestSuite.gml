// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResourceAudioSynchronisationTestSuite() : TestSuite() constructor {
	
	addFact("Sync group creation and playback", function() {
		
		// Create the sync group
		var syncGroup = audio_create_sync_group(false);
		assert_greater_or_equal(syncGroup, 0, "Sync group id should be 0 or greater");
		
		if (!audio_exists(snd_compressed)) {
			show_debug_message("Error: Sound resources are not loaded correctly. Skipping test.");
			audio_destroy_sync_group(syncGroup);
			test_end(TestResult.Skipped);
		}
		
		// Add sounds into the sync group
		var sound1 = audio_play_in_sync_group(syncGroup, snd_compressed);
		var sound2 = audio_play_in_sync_group(syncGroup, snd_compressed);
		
		assert_equals(sound1, 0, "'sound1' should be first in the sync group's sound order");
		assert_equals(sound2, 1, "'sound2' should be second in the sync group's sound order");
		
		// Play audio sync group
		audio_start_sync_group(syncGroup);
		var playing = audio_sync_group_is_playing(syncGroup);
		assert_true(playing, "Audio sync group should be playing");
		
		// Pause audio sync group
		audio_pause_sync_group(syncGroup);
		var paused = audio_sync_group_is_paused(syncGroup);
		assert_true(paused, "Audio sync group should be paused");
		
		// Resume audio syc group
		audio_resume_sync_group(syncGroup);
		playing = audio_sync_group_is_playing(syncGroup);
		paused = audio_sync_group_is_paused(syncGroup);
		assert_true(playing, "Audio sync group should be playing");
		assert_false(paused, "Audio sync group should NOT be paused");
		
		audio_stop_sync_group(syncGroup);
		playing = audio_sync_group_is_playing(syncGroup);
		assert_false(playing, "Audio sync group should NOT be playing");
		
		audio_destroy_sync_group(syncGroup);
		
	});
	
	addTestAsync("Audio sync group track position test", objTestAsync, {
		
		ev_create: function() {
			
			// Create the sync group
			syncGroup = audio_create_sync_group(false);
			assert_greater_or_equal(syncGroup, 0, "Sync group id should be 0 or greater");
			
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
			
			if (timeSpent >= 0.25) {
				
				var trackPos = audio_sync_group_get_track_pos(syncGroup);
				// need to give some leeway to the asserts here,
				// due to how often ev_step occurs, it might not check
				// exactly at 0.25 seconds
				assert_less_or_equal(trackPos, 0.27, "#1.1 Audio sync group track position should be ~0.25");
				assert_greater_or_equal(trackPos, 0.24, "#1.2 Audio sync group track position should be ~0.25");
				
				audio_stop_sync_group(syncGroup);
				
				test_end();
			}
		
		},
		
		ev_cleanup: function() {
			
			audio_destroy_sync_group(syncGroup);
			
		}
		
	});
	
}