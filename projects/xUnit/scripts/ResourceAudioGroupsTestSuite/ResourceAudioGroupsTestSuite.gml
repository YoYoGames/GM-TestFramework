	
function getGroupSoundsToTest() {
	
	return [
		handle_testSound,
		snd_MP3,
		snd_OGG,
		snd_WAV
		];
	
}

function getAudioGroups() {
	
	return [
		audiogroup_default,
		audiogroup_MP3,
		audiogroup_OGG,
		audiogroup_WAV
		];
	
}
	
function ResourceAudioGroupsTestSuite() : TestSuite() constructor {
	
	addTestAsync("Audio groups loading", objTestAsync, {
		
		ev_create: function() {
			
			// Start loading audio groups
			audioGroups = getAudioGroups();
			
			for (var i = 0; i < array_length(audioGroups); i++){
				var group = audioGroups[i];
				audio_group_load(group);
			}
			
		},
		
		ev_step: function() {
			
			var loadedNum = 0;
			
			// Check if audio groups have been loaded
			for (var i = 0; i < array_length(audioGroups); i++) {
				
				var group = audioGroups[i];
				
				if (audio_group_is_loaded(group)) {
					loadedNum++;
				}
				
			}
			
			// If all audi groups have been loaded, end test
			if (loadedNum == array_length(audioGroups)) {
				
				// Check that loading progress is at 100%
				for (var i = 0; i < array_length(audioGroups); i++) {
					
					var group = audioGroups[i];
					var loadProgress = audio_group_load_progress(group);
					assert_equals(loadProgress, 100, "Load progress should be at 100% after loading in");
					
				}
				
				test_end();
			}
			
		},
		
	});
	
	addFact("Sounds' associated audio group test", function() {
		
		// Get sounds that should be tested
		var soundsToTest = getGroupSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			// Get current sound
			var sound = soundsToTest[i];
			
			// Get sound's audio group
			var audioGroupID = audio_sound_get_audio_group(sound);
			
			// Test if the audio group is the correct one
			switch (sound) {
				
				case handle_testSound:
					assert_equals(audioGroupID, audiogroup_default, "handle_testSound should be in the default audiogroup");
					break;
					
				case snd_MP3:
					assert_equals(audioGroupID, audiogroup_MP3, "MP3 sound should be in audio group 1");
					break;
					
				case snd_OGG:
					assert_equals(audioGroupID, audiogroup_OGG, "OGG sound should be in audio group 2");
					break;
					
				case snd_WAV:
					assert_equals(audioGroupID, audiogroup_WAV, "WAV sound should be in audio group 3");
					break;
					
				default:
					break;
				
			}
			
		}
		
	});
	
	addFact("Audio groups' assets test", function() {
		
		// Get audio groups that should be tested
		var groupsToTest = getAudioGroups();
		
		for (var i = 0 ; i < array_length(groupsToTest); i++) {
			
			// Get current group
			var group = groupsToTest[i];
			
			// Get assets from current group
			var audioAssets = audio_group_get_assets(group);
			
			// Test if assets are the correct ones
			switch (group) {
				
				case audiogroup_default:
					// Although this group has many sounds, I think in this case it makes sense to just test the first one.
					// This is because if there are more sound assets added to the framework later on,
					// they would need to be added to this test as well to pass.
					var sound = audioAssets[0];
					assert_array_equals(sound, handle_testSound, "default audiogroup's first member should be 'handle_testSound'");
					break;
					
				case audiogroup_MP3:
					assert_array_equals(audioAssets, [snd_MP3], "audiogroup_MP3 should contain the MP3 sound");
					break;
				
				case audiogroup_OGG:
					assert_array_equals(audioAssets, [snd_OGG], "audiogroup_OGG should contain the OGG sound");
					break;
					
				case audiogroup_WAV:
					assert_array_equals(audioAssets, [snd_WAV], "audiogroup_WAV should contain the WAV sound");
					break;
					
				default:
					break;
				
			}
			
		}
		
	});

	addFact("Audio group names test", function() {
		
		var groupsToTest = getAudioGroups();
		
		for (var i = 0; i < array_length(groupsToTest); i++) {
			
			var group = groupsToTest[i];
			
			var groupName = audio_group_name(group);
			
			switch (group) {
				
				case audiogroup_default:
					assert_equals(groupName, "audiogroup_default", "audiogroup_default's name should match the variable name");
					break;
					
				case audiogroup_MP3:
					assert_equals(groupName, "audiogroup_MP3", "audiogroup_MP3's name should match the variable name");
					break;
					
				case audiogroup_OGG:
					assert_equals(groupName, "audiogroup_OGG", "audiogroup_OGG's name should match the variable name");
					break;
					
				case audiogroup_WAV:
					assert_equals(groupName, "audiogroup_WAV", "audiogroup_WAV's name should match the variable name");
					break;
					
			}
			
		}
		
	});
	
	addFact("Audiogroup stop sounds", function() {
		
		// Start playing sound from audiogroup_OGG
		var sound = audio_play_sound(snd_OGG, 1, false);
		// Check if it is playing
		var isPlaying = audio_is_playing(sound);
		assert_true(isPlaying, "Sound should be playing");
		
		// Stop all sounds in audiogroup_OGG
		audio_group_stop_all(audiogroup_OGG);
		// Check that sound has stopped playing
		isPlaying = audio_is_playing(sound);
		assert_false(isPlaying, "Sound should not be playing");
		
	});
	
	addFact("Audiogroup gain instant", function() {
		
		// Get gain of audiogroup and test that it's 1 by default
		var gain = audio_group_get_gain(audiogroup_OGG);
		assert_equals(gain, 1, "The gain of audiogroups should be 1 by default");
		
		// Set gain of audiogroup to 0.1 and test if it has been set correctly
		audio_group_set_gain(audiogroup_OGG, 0.1, 0);
		gain = audio_group_get_gain(audiogroup_OGG);
		assert_equals(gain, 0.1, "Gain should be 0.1");
		
		// Set gain back to 1
		audio_group_set_gain(audiogroup_OGG, 1, 0);
		
	});
	
	addTestAsync("Audiogroup gain over time", objTestAsync, {
		
		ev_create: function() {
			
			// Set gain of auio group to 1
			audio_group_set_gain(audiogroup_OGG, 1, 0);
			
			gain = audio_group_get_gain(audiogroup_OGG);
			assert_equals(gain, 1, "Gain should be 1 before test starts");
			
			// Set audio group's gain to 0.1 over 0.25 seconds and start a timer
			audio_group_set_gain(audiogroup_OGG, 0.1, 0.25);
			
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
		},
		
		ev_step: function() {
			
			// After 0.25 seconds, check if the gain is the expected value
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			if (timeSpent >= 0.25) {
				
				gain = audio_group_get_gain(audiogroup_OGG);
				
				assert_equals(gain, 0.1, "Gain should be 0.1 after 0.25 seconds");
				
				test_end();
				
			}
			
		}
		
	});
	
	addTestAsync("Audio group unloading", objTestAsync, {
		
		ev_create: function() {
			
			// Start unloading audio groups
			audioGroups = getAudioGroups();
			
			// Remove default audio group from the array as we don't want to unload that
			array_delete(audioGroups, 0, 1);
			
			for (var i = 0; i < array_length(audioGroups); i++){
				var group = audioGroups[i];
				audio_group_unload(group);
			}
			
		},
		
		ev_step: function() {
			
			var unloadedNum = 0;
			
			// Check if audio groups have been unloaded
			for (var i = 0; i < array_length(audioGroups); i++) {
				
				var group = audioGroups[i];
				
				if (!audio_group_is_loaded(group)) {
					unloadedNum++;
				}
				
			}
			
			// If all audio groups have been unloaded, end test
			if (unloadedNum == array_length(audioGroups)) {
				
				// Check that loading progress is at 0% for unloaded audiogroups
				for (var i = 0; i < array_length(audioGroups); i++) {
					
					var group = audioGroups[i];
					var loadProgress = audio_group_load_progress(group);
					assert_equals(loadProgress, 0, "Load progress should be at 0% after loading in");
					
				}
				
				test_end();
			}
			
		},
		
	});
	
}