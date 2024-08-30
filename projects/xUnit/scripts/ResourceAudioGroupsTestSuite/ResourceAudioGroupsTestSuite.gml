	
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
		audiogroup_MP3,
		audiogroup_OGG,
		audiogroup_WAV
		];
	
}
	
function ResourceAudioGroupsTestSuite() : TestSuite() constructor {
	
	addFact("Default audio group test #1", function() { // Known issue https://github.com/YoYoGames/GameMaker-Bugs/issues/7371
		
		var loaded = audio_group_is_loaded(audiogroup_default);
		assert_true(loaded, "Default audiogroup should be loaded by default");
		
	});

	addFact("Default audio group test #2", function() {
		
		var loadProgress = audio_group_load_progress(audiogroup_default);
		assert_equals(loadProgress, 100, "Default audiogroup's load progress should be at 100, as it should be loaded in by default");
		
	});
	
	addTestAsync("Audio groups loading test #1", objTestAsync, {
		
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
			
			show_debug_message("audio group numbers: " + string(array_length(audioGroups)));
			show_debug_message("loaded groups : " + string(loadedNum));
			
			// If all audi groups have been loaded, end test
			if (loadedNum == array_length(audioGroups)) {
				
				// Check that loading progress is at 100%
				for (var i = 0; i < array_length(audioGroups); i++) {
					
					var group = audioGroups[i];
					var loadProgress = audio_group_load_progress(group);
					assert_equals(loadProgress, 100, "audio_group_load_progress should return 100% after loading in");
					
				}
				
				test_end();
			}
			
		},
		
	});
	
	addFact("Sounds' associated audio group test #1", function() {
		
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
					assert_equals(audioGroupID, audiogroup_MP3, "MP3 sound should be in audiogroup_MP3");
					break;
					
				case snd_OGG:
					assert_equals(audioGroupID, audiogroup_OGG, "OGG sound should be in audiogroup_OGG");
					break;
					
				case snd_WAV:
					assert_equals(audioGroupID, audiogroup_WAV, "WAV sound should be in audiogroup_WAV");
					break;
					
				default:
					break;
				
			}
			
		}
		
	});
	
	addFact("Audio groups' assets test #1", function() {
		
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
					// Test just the frst sound in the default audio group
					var sound = audioAssets[0];
					assert_array_equals(sound, handle_testSound, "audio_group_get_assets should get the correct audio asset from audiogroup_default");
					break;
					
				case audiogroup_MP3:
					assert_array_equals(audioAssets, [snd_MP3], "audio_group_get_assets should get the correct audio assets from audiogroup_MP3");
					break;
				
				case audiogroup_OGG:
					assert_array_equals(audioAssets, [snd_OGG], "audio_group_get_assets should get the correct audio assets from audiogroup_OGG");
					break;
					
				case audiogroup_WAV:
					assert_array_equals(audioAssets, [snd_WAV], "audio_group_get_assets should get the correct audio assets from audiogroup_WAV");
					break;
					
				default:
					break;
				
			}
			
		}
		
	});

	addFact("Audio group names test #1", function() {
		
		var groupsToTest = getAudioGroups();
		
		for (var i = 0; i < array_length(groupsToTest); i++) {
			
			var group = groupsToTest[i];
			
			var groupName = audio_group_name(group);
			
			switch (group) {
				
				case audiogroup_default:
					assert_equals(groupName, "audiogroup_default", "audio_group_name should return the correct audio group name from audiogroup_default");
					break;
					
				case audiogroup_MP3:
					assert_equals(groupName, "audiogroup_MP3", "audio_group_name should return the correct audio group name from audiogroup_MP3");
					break;
					
				case audiogroup_OGG:
					assert_equals(groupName, "audiogroup_OGG", "audio_group_name should return the correct audio group name from audiogroup_OGG");
					break;
					
				case audiogroup_WAV:
					assert_equals(groupName, "audiogroup_WAV", "audio_group_name should return the correct audio group name from audiogroup_WAV");
					break;
					
			}
			
		}
		
	});
	
	addFact("audio_group_stop_all test #1", function() {
		
		// Start playing sound from audiogroup_OGG
		var sound = audio_play_sound(snd_OGG, 1, false);
		
		// Stop all sounds in audiogroup_OGG
		audio_group_stop_all(audiogroup_OGG);
		// Check that sound has stopped playing
		var isPlaying = audio_is_playing(sound);
		assert_false(isPlaying, "audio_group_stop_all should stop sounds from specified audio group");
		
	});
	
	addFact("Audiogroup gain test #1", function() {
		
		// Get gain of audiogroup and test that it's 1 by default
		var gain = audio_group_get_gain(audiogroup_OGG);
		assert_equals(gain, 1, "audio_group_get_gain should return 1 by default");
		
	});
	
	addFact("Audiogroup gain test #2", function() {
		
		// Set gain of audiogroup to 0.1 and test if it has been set correctly
		audio_group_set_gain(audiogroup_OGG, 0.1, 0);
		var gain = audio_group_get_gain(audiogroup_OGG);
		assert_equals(gain, 0.1, "audio_group_set_gain should set the gain correctly");
		
		// Set gain back to 1
		audio_group_set_gain(audiogroup_OGG, 1, 0);
		
	});
	
	addTestAsync("Audiogroup gain test #3", objTestAsync, {
		
		ev_create: function() {
			
			// Set gain of auio group to 1
			audio_group_set_gain(audiogroup_OGG, 1, 0);
			
			gain = audio_group_get_gain(audiogroup_OGG);
			assert_equals(gain, 1, "audio_group_get_gain should return 1 by default");
			
			// Set audio group's gain to 0.1 over 0.25 seconds and start a timer
			audio_group_set_gain(audiogroup_OGG, 0.1, 0.25);
			
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
		},
		
		ev_step: function() {
			
			// After 0.25 seconds, check if the gain is the expected value
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			if (timeSpent >= 0.25) {
				
				gain = audio_group_get_gain(audiogroup_OGG);
				
				assert_equals(gain, 0.1, "audio_group_set_gain should set gain correctly over time");
				
				test_end();
				
			}
			
		}
		
	});
	
	addTestAsync("Audio group unloading test #1", objTestAsync, {
		
		ev_create: function() {
			
			// Start unloading audio groups
			audioGroups = getAudioGroups();
			
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
					assert_equals(loadProgress, 0, "audio_group_load_progress should return 0% once the audio group has been unloaded");
					
				}
				
				test_end();
			}
			
		},
		
	});
	
}