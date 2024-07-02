
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
			
			loaded = array_create(array_length(audioGroups));
			
			for (var i = 0; i < array_length(audioGroups); i++){
				loaded[i] = false;
				audio_group_load(i);
			}
			
			frame = 0;
			
		},
		
		ev_step: function() {
			
			// Check if audio groups have been loaded
			for (var i = 0; i < array_length(audioGroups); i++) {
				
				loaded[i] = audio_group_is_loaded(i);
				
				var progress = audio_group_load_progress(i);
				
				show_debug_message("audio group " + string(i) + ", frame " + string(frame) + ", load progress " + string(progress) + "%");
				
			}
			
			// If all audio groups have been loaded, end the test
			var loadedNum = 0;
			
			for (var i = 0; i < array_length(loaded); i++) {
				if (loaded[i]) {
					loadedNum++;
				}
			}
			
			if (loadedNum == array_length(loaded)) {
				test_end();
			}
			else {
				frame++;
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

	
}