
function getSoundsToTest() {
	
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
	
}