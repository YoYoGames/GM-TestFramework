
function BasicAudioTestSuite() : TestSuite() constructor {
	
	addFact("Audio initialized", function(){
		
		// Check if audio system is available
		var output = audio_system_is_available();
		assert_true(output, "#1 audio_system_is_available should return true");
		
		// Check if audio system is initialised
		output = audio_system_is_initialised();
		assert_true(output, "#2 audio_system_is_initialised should return true");
		
	});
	
	addFact("Audio basics", function() {
		
		// tests for functions that reference Asset.GMSound
		
		// test audio name
		var audioName = audio_get_name(snd_coinpickup_MP3);
		assert_string_contains(audioName, "snd_coinpickup_MP3", "#1 audio name should be 'snd_coinpickup_MP3'");
		
		// test if audio exists
		var audioExists = audio_exists(snd_coinpickup_MP3);
		assert_true(audioExists, "#2 'snd_coinpickup' should exist");
		
		// test audio type
		var audioType = audio_get_type(snd_coinpickup_MP3);
		assert_greater_or_equal(audioType, 0, "#3 'snd_coinpickup' audio type should be greater or equal to 0");
		
		// test audio length
		var length = audio_sound_length(snd_coinpickup_MP3);
		assert_equals(length, 0.77, "#4 'snd_coinpickup' should have a length of 0.44 seconds");
		
		// test audio playability
		var playable = audio_sound_is_playable(snd_coinpickup_MP3);
		assert_true(playable, "#5 'snd_coinpickup' should be playable");
		
		// test audio sound asset
		var sound = audio_play_sound(snd_coinpickup_MP3, 1, false);
		var soundAsset = audio_sound_get_asset(sound);
		assert_equals(soundAsset, snd_coinpickup_MP3, "#6 sound asset should be 'snd_coinpickup'");
		audio_stop_sound(snd_coinpickup_MP3);
		
		// tests for multiple sounds with index Id.Sound
					
		var soundsToTest = array_create(6, [
			snd_coinpickup_MP3,
			snd_coinpickup_OGG,
			snd_coinpickup_WAV,
			snd_jump_MP3,
			snd_jump_OGG,
			snd_jump_WAV
			]);
		
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			
			// test audio name
			audioName = audio_get_name(i);
			assert_not_null(audioName, "#7." + string(i) + " audio name should not be null");
			
			// test if audio exists
			audioExists = audio_exists(i);
			assert_true(audioExists, "#8." + string(i) + " audio should exist");
			
			// test audio type
			audioType = audio_get_type(i);
			assert_greater_or_equal(audioType, 0, "#9." + string(i) + "audio type should be greater or equal to 0");
			
			// test audio length
			length = audio_sound_length(i);
			assert_greater(length, 0, "#10." + string(i) + "audio length should be greater than 0");
			
			// test audio playability
			playable = audio_sound_is_playable(i);
			assert_true(playable, "#11." + string(i) + "audio sound should be playable");
			
			// test audio sound asset
			sound = audio_play_sound(i, 1, false);
			soundAsset = audio_sound_get_asset(sound);
			assert_not_null(soundAsset, "#12." + string(i) + " audio sound asset should not be null");
			audio_stop_sound(i);
			
		}
		
	});
	
	addFact("Single audio playback functions", function() {
		
		var soundsToTest = array_create(6, [
			snd_coinpickup_MP3,
			snd_coinpickup_OGG,
			snd_coinpickup_WAV,
			snd_jump_MP3,
			snd_jump_OGG,
			snd_jump_WAV
			]);
		
		// test audio playback functions that handle single sound
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			
			// check if audio is playable
			var playable = audio_sound_is_playable(i);
			assert_true(playable, "#1 audio should be playable");
			
			// check that audio is currently NOT playing
			var isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#2" + string(i) + " audio should not be playing");
			
			// play audio and check if it is playing and not paused
			audio_play_sound(i, 1, false);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#3.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_false(isPaused, "#3.2." + string(i) + " audio should not be paused");
			
			// pause audio and check if it is not playing, and is paused
			audio_pause_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#4.1." + string(i) + " audio should be playing");
			isPaused = audio_is_paused(i);
			assert_true(isPaused, "#4.2." + string(i) + " audio should be paused");
			
			// resume the audio and check if it is playing and not paused
			audio_resume_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#5.1." + string(i) + " audio should be playing");
			isPaused = audio_is_paused(i);
			assert_false(isPaused, "#5.2." + string(i) + " audio should not be paused");
			
			// stop the audio and check if it is paused
			audio_stop_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#6" + string(i) + " audio should not be playing");
			
			// play sound at position of object and check if it is playing
			audio_play_sound_at(i, x, y, 0, 100, 300, 1, false, 1);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#7" + string(i) + " audio should be playing");
			audio_stop_sound(i);
			
			// test audio_play_sound_ext with different paramenters
			//#1
			audio_play_sound_ext({
				sound: i
			});
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#8.1." + string(i) + " audio should be playing");
			audio_stop_sound(i);
			
			//#2
			var audioEmitter = audio_emitter_create();
			audio_emitter_position(audioEmitter, 100, 100, 0);
			
			var _sound_params =
			{
			    sound: i,
			    priority: 20,
			    gain: 1.2,
			    pitch: 2,
			    emitter: audioEmitter
			};
			audio_play_sound_ext(_sound_params);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#8.2." + string(i) + " audio should be playing");
			audio_stop_sound(i);
			
			//#3
			var _sound_params =
			{
			    sound: i,
			    pitch: 1.1,
			    position:
			    {
			        x: 100,
			        y: 100,
			        z: 20
			    }
			};
			audio_play_sound_ext(_sound_params);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#8.3." + string(i) + " audio should be playing");
			audio_stop_sound(i);
			
		}
		
	});
	
	addFact("Multiple audio playback functions", function() {
		
		var soundsToTest = array_create(6, [
			snd_coinpickup_MP3,
			snd_coinpickup_OGG,
			snd_coinpickup_WAV,
			snd_jump_MP3,
			snd_jump_OGG,
			snd_jump_WAV
			]);
		
		// test audio playback functions that handle multiple sounds
		
		// start all sounds and check if they are all playing
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			audio_play_sound(i, 1, false);
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#1." + string(i) + " audio should be playing");
		}
		
		// pause all audio and check that they are paused
		audio_pause_all();
		
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#2.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_true(isPaused, "#2.2." + string(i) + " audio should be paused");
		}
		
		// resume all audio and check that they are playing
		audio_resume_all();
		
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#3.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_false(isPaused, "#3.2." + string(i) + " audio should not be paused");
		}
		
		// stop all audio and check that they have stopped playing
		audio_stop_all();
		
		for (var i = 0; i <= array_length(soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#4." + string(i) + " audio should not be playing");
		}
		
	});
	
}