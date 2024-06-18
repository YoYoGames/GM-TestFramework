function BasicAudioTestSuite() : TestSuite() constructor {
	
	addFact("Audio initialized", function(){
		
		// Check if audio system is available
		var output = audio_system_is_available();
		assert_true(output, "audio_system_is_available should return true");
		
		// Check if audio system is initialised
		output = audio_system_is_initialised();
		assert_true(output, "audio_system_is_initialised should return true");
		
	});
	
	addFact("Audio basics", function() {
		
		// tests for functions that reference Asset.GMSound
		
		var audioName = audio_get_name(snd_coinpickup_MP3);
		assert_string_contains(audioName, "snd_coinpickup_MP3", "audio name should be 'snd_coinpickup'");
		
		var audioExists = audio_exists(snd_coinpickup_MP3);
		assert_true(audioExists, "'snd_coinpickup' should exist");
		
		var audioType = audio_get_type(snd_coinpickup_MP3);
		assert_greater_or_equal(audioType, 0, "'snd_coinpickup' audio type should be greater or equal to 0");
		
		var length = audio_sound_length(snd_coinpickup_MP3);
		assert_equals(length, 0.77, "'snd_coinpickup' should have a length of 0.44 seconds");
		
		var playable = audio_sound_is_playable(snd_coinpickup_MP3);
		assert_true(playable, "'snd_coinpickup' should be playable");
		
		var sound = audio_play_sound(snd_coinpickup_MP3, 1, false);
		var soundAsset = audio_sound_get_asset(sound);
		assert_equals(soundAsset, snd_coinpickup_MP3, "sound asset should be 'snd_coinpickup'");
		audio_stop_sound(snd_coinpickup_MP3);
		
		// tests for multiple sounds with index Id.Sound
		
		var totalSounds = 6;
		
		for (var i = 0; i < totalSounds; i++) {
			
			audioName = audio_get_name(i);
			assert_not_null(audioName, "audio name should not be null");
			
			audioExists = audio_exists(i);
			assert_true(audioExists, "'" + audioName + "' audio should exist");
			
			audioType = audio_get_type(i);
			assert_greater_or_equal(audioType, 0, audioName + "audio type should be greater or equal to 0");
			
			length = audio_sound_length(i);
			assert_greater(length, 0, audioName + "audio length should be greater than 0");
			
			playable = audio_sound_is_playable(i);
			assert_true(playable, audioName + "audio sound should be playable");
			
			sound = audio_play_sound(i, 1, false);
			soundAsset = audio_sound_get_asset(sound);
			assert_not_null(soundAsset, "audio sound asset should not be null");
			audio_stop_sound(i);
			
		}
		
	});
	
}