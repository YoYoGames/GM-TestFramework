	
function GetSoundsToTest() {
	
	return [
		snd_coinpickup_MP3,
		snd_coinpickup_OGG,
		snd_coinpickup_WAV,
		snd_jump_MP3,
		snd_jump_OGG,
		snd_jump_WAV
		];
	
}

function BasicAudioTestSuite() : TestSuite() constructor {

	// AUDIO SYSTEM INITIALIZATION TESTS
	
	addFact("Audio initialized test #1", function(){
		
		// Check if audio system is available
		var output = audio_system_is_available();
		assert_true(output, "audio_system_is_available should return true");
		
	});
	
	addFact("Audio initialized #2", function(){
		
		// Check if audio system is initialised
		var output = audio_system_is_initialised();
		assert_true(output, "audio_system_is_initialised should return true");
		
	});
	
	addFact("Audio basics test #1", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio name
			var audioName = audio_get_name(_sound);
			assert_not_null(audioName, "Audio #" + string(i) + " - audio_get_name should not return null");
			
		}
		
	});
	
	addFact("Audio basics test #2", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test if audio exists
			var audioExists = audio_exists(_sound);
			assert_true(audioExists, "Audio #" + string(i) + " - audio_exist should return true");
			
		}
		
	});
	
	addFact("Audio basics test #3", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio type
			var audioType = audio_get_type(_sound);
			assert_greater_or_equal(audioType, 0, "Audio #" + string(i) + " - audio_get_type should return greater or equal to 0");
			
		}
		
	});
	
	addFact("Audio basics test #4", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio length
			var length = audio_sound_length(_sound);
			assert_greater(length, 0, "Audio #" + string(i) + " - audio_sound_length should return greater than 0");
			
		}
		
	});
	
	addFact("Audio basics test #5", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio playability
			var playable = audio_sound_is_playable(_sound);
			assert_true(playable, "Audio #" + string(i) + " - audio_sound_is_playable should return true");
			
		}
		
	});
	
	addFact("Audio basics test #6", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio sound asset
			var playedSound = audio_play_sound(_sound, 1, false);
			var soundAsset = audio_sound_get_asset(playedSound);
			assert_not_null(soundAsset, "Audio #" + string(i) + " - audio_sound_get_asset should not return null");
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Audio basics test #7", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test default audio gain
			var gain = audio_sound_get_gain(_sound);
			assert_equals(gain, 1, "Audio #" + string(i) + " - audio_sound_get_gain should return 1 by default");
			
		}
		
	});
	
	addFact("Audio basics test #8", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test setting audio gain instantly
			audio_sound_gain(_sound, 0.1, 0); // set gain to 0.1
			var gain = audio_sound_get_gain(_sound);
			assert_equals(gain, 0.1, "Audio #" + string(i) + " - audio_sound_gain should set gain correctly");
			
		}
		
	});
	
	addFact("Audio basics test #9", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			audio_sound_gain(_sound, 1, 0); // set gain back to 1
			var gain = audio_sound_get_gain(_sound);
			assert_equals(gain, 1, "Audio #" + string(i) + " - audio_sound_gain should set gain correctly");
			
		}
		
	});
	
	addFact("Audio basics test #10", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test default pitch
			var pitch = audio_sound_get_pitch(_sound);
			assert_equals(pitch, 1, "Audio #" + string(i) + " - audio_sound_get_pitch should return 1 by default");
			
		}
		
	});
	
	addFact("Audio basics test #11", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test pitch changing
			audio_sound_pitch(_sound, 0.5);
			var pitch = audio_sound_get_pitch(_sound);
			assert_equals(pitch, 0.5, "Audio #" + string(i) + " - audio_sound_pitch should set pitch correctly");
			
		}
		
	});
	
	addFact("Audio basics test #12", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// change pitch back to default
			audio_sound_pitch(_sound, 1);
			var pitch = audio_sound_get_pitch(_sound);
			assert_equals(pitch, 1, "Audio #" + string(i) + " - audio_sound_pitch should set pitch correctly");
			
		}
		
	});
	
	addFact("Audio basics test #13", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test track position
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// check that track position is 0 by default
			var trackPosition = audio_sound_get_track_position(playedSound);
			assert_equals(trackPosition, 0, "Audio #" + string(i) + " - audio_sound_get_track_position should return 0 by default (start of track)");
			
			// stop the sound
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Audio basics test #14", function() {
		
		// tests for multiple sound formats
		
		// get sounds to test
		var soundsToTest = GetSoundsToTest();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test track position
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// set it to something else and check if its correct
			audio_sound_set_track_position(playedSound, 0.1);
			var trackPosition = audio_sound_get_track_position(playedSound);
			assert_equals(trackPosition, 0.1, "Audio #" + string(i) + " - audio_sound_set_track_position should set the track position correctly");
			
			// stop the sound
			audio_stop_sound(playedSound);

		}
		
	});
	
	// MASTER GAIN TESTS
	
	addFact("Master gain test #1", function() {
					
		// test master gain
		var num = audio_get_listener_count();
		for(var i = 0; i < num; ++i;)
		{
		    var info = audio_get_listener_info(i);
		    var ind = info[? "index"];
			
			var gain = audio_get_master_gain(ind);
			
			assert_equals(gain, 1, "audio_get_master_gain should return 1 by default");
			
		    ds_map_destroy(info);

		}
		
	});
	
	addFact("Master gain test #2", function() {
					
		// test master gain
		var num = audio_get_listener_count();
		for(var i = 0; i < num; ++i;)
		{
		    var info = audio_get_listener_info(i);
		    var ind = info[? "index"];
			
			audio_set_master_gain(ind, 0.75);
			
			var gain = audio_get_master_gain(ind);
			assert_equals(gain, 0.75, "audio_set_master_gain should set the gain correctly");
			
			audio_set_master_gain(ind, 1);
			
		    ds_map_destroy(info);
		}
		
	});
	
	// SINGLE AUDIO PLAYBACK TESTS
	
	addFact("Single audio playback functions test #1", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// check if audio is playable
			var playable = audio_sound_is_playable(_sound);
			assert_true(playable, "audio_sound_is_playable should return true");
		}
		
	});
	
	addFact("Single audio playback functions test #2", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// check that audio is currently NOT playing
			var isPlaying = audio_is_playing(_sound);
			assert_false(isPlaying, "Audio #" + string(i) + " - audio_is_playing should return false on audio that is not playing");
		}
		
	});
	
	addFact("Single audio playback functions test #3", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio and check if it is playing and not paused
			var playedSound = audio_play_sound(_sound, 1, false);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_is_playing should return true on audio that is playing");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #4", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio and check if it is playing and not paused
			var playedSound = audio_play_sound(_sound, 1, false);
			
			var isPaused = audio_is_paused(playedSound);
			assert_false(isPaused, "Audio #" + string(i) + " - audio_is_paused should return false on audio that is not paused");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #5", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio 
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// pause audio and check if it is still playing, and is paused
			audio_pause_sound(playedSound);
			
			var isPaused = audio_is_paused(playedSound);
			assert_true(isPaused, "Audio #" + string(i) + " - audio_pause_sound should pause a currently playing audio");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #6", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio 
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// pause audio and check if it is still playing, and is paused
			audio_pause_sound(playedSound);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_is_playing should return true on audio that is playing, but is paused");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #7", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio 
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// pause audio
			audio_pause_sound(playedSound);
			
			// resume the audio and check if it is playing and not paused
			audio_resume_sound(playedSound);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_resume_sound should resume a paused audio");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #8", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio 
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// pause audio
			audio_pause_sound(playedSound);
			
			// resume the audio and check if it is playing and not paused
			audio_resume_sound(playedSound);
			
			var isPaused = audio_is_paused(playedSound);
			assert_false(isPaused, "Audio #" + string(i) + " - audio_is_paused should return false once an audio has been resumed");
			
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Single audio playback functions test #9", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// play audio 
			var playedSound = audio_play_sound(_sound, 1, false);
			
			// pause audio
			audio_pause_sound(playedSound);
			
			// resume the audio
			audio_resume_sound(playedSound);
			
			// stop the audio and check if it is not playing
			audio_stop_sound(playedSound);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_false(isPlaying, "Audio #" + string(i) + " - audio_stop_sound should stop audio playback");
			
		}
		
	});
	
	// Audio_play_sound_ext TESTS
	
	addFact("Audio_play_sound_ext test #1", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio_play_sound_ext with different paramenters
			//#1
			var playedSound = audio_play_sound_ext({
				sound: _sound
			});
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_play_sound_ext should start playing audio");
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	addFact("Audio_play_sound_ext test #2", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio_play_sound_ext with different paramenters
			
			//#2
			var audioEmitter = audio_emitter_create();
			audio_emitter_position(audioEmitter, 100, 100, 0);
			
			var _sound_params =
			{
			    sound: _sound,
			    priority: 20,
			    gain: 1.2,
			    pitch: 2,
			    emitter: audioEmitter
			};
			var playedSound = audio_play_sound_ext(_sound_params);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_play_sound_ext should start playing audio");
			audio_stop_sound(playedSound);
			
			audio_emitter_free(audioEmitter);
			
		}
		
	});

	addFact("Audio_play_sound_ext test #3", function() {
		
		var soundsToTest = GetSoundsToTest();
		
		// test audio playback functions that handle single sound
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			// test audio_play_sound_ext with different paramenters
			
			//#3
			var _sound_params =
			{
			    sound: _sound,
			    pitch: 1.1,
			    position:
			    {
			        x: 100,
			        y: 100,
			        z: 20
			    }
			};
			var playedSound = audio_play_sound_ext(_sound_params);
			
			var isPlaying = audio_is_playing(playedSound);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_play_sound_ext should start playing audio");
			audio_stop_sound(playedSound);
			
		}
		
	});
	
	// STREAMED SOUND TESTS
	
	addFact("streamed sound test #1", function() {
		
		// test creating streamed sounds
		var streamedSound = audio_create_stream("StreamedSound.ogg");
		audio_play_sound(streamedSound, 0, false);
		
		var isPlaying = audio_is_playing(streamedSound);
		assert_true(isPlaying, "audio_create_stream should create a sound that can be played");
		
		audio_stop_sound(streamedSound);
		audio_destroy_stream(streamedSound);
		
	});
	
	addFact("streamed sound test #2", function() {
		
		// test creating streamed sounds
		var streamedSound = audio_create_stream("StreamedSound.ogg");
		
		// test destroying streamed sounds
		var destroyed = audio_destroy_stream(streamedSound);
		assert_true(destroyed, "audio_destroy_stream should return true when destroying streamed sound");
		
	});
	
	// MULTIPLE AUDIO PLAYBACK FUNCTION TESTS
	
	addFact("Multiple audio playback functions test #1", function() {
		
		// test audio playback functions that handle multiple sounds
		
		var soundsToTest = GetSoundsToTest();
		
		var playedSounds = array_create(array_length(soundsToTest));
		
		// start all sounds
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			playedSounds[i] = audio_play_sound(_sound, 1, false);
		}
		
		// pause all audio and check that they are still playing (but paused)
		audio_pause_all();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var isPaused = audio_is_paused(playedSounds[i]);
			assert_true(isPaused, "Audio #" + string(i) + " - audio_pause_all should pause all sounds");
		}
		
	});	

	addFact("Multiple audio playback functions test #2", function() {
		
		// test audio playback functions that handle multiple sounds
		
		var soundsToTest = GetSoundsToTest();
		
		var playedSounds = array_create(array_length(soundsToTest));
		
		// start all sounds
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			playedSounds[i] = audio_play_sound(_sound, 1, false);
		}
		
		// pause all audio and check that they are still playing and are paused
		audio_pause_all();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var isPlaying = audio_is_playing(playedSounds[i]);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_is_playing should return false on all souds once they have been paused ");
		}
		
		audio_stop_all();
		
	});
	
	addFact("Multiple audio playback functions test #3", function() {
		
		// test audio playback functions that handle multiple sounds
		
		var soundsToTest = GetSoundsToTest();
		
		var playedSounds = array_create(array_length(soundsToTest));
		
		// start all sounds
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			playedSounds[i] = audio_play_sound(_sound, 1, false);
		}
		
		// pause all audio
		audio_pause_all();
		
		// resume all audio and check that they are playing
		audio_resume_all();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var isPaused = audio_is_paused(playedSounds[i]);
			assert_false(isPaused, "Audio #" + string(i) + " - audio_resume_all should resume all paused sounds");
		}
		
		// stop all audio
		audio_stop_all();
		
	});
	
	addFact("Multiple audio playback functions test #4", function() {
		
		// test audio playback functions that handle multiple sounds
		
		var soundsToTest = GetSoundsToTest();
		
		var playedSounds = array_create(array_length(soundsToTest));
		
		// start all sounds
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			playedSounds[i] = audio_play_sound(_sound, 1, false);
		}
		
		// pause all audio
		audio_pause_all();
		
		// resume all audio and check that they are not paused
		audio_resume_all();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var isPlaying = audio_is_playing(playedSounds[i]);
			assert_true(isPlaying, "Audio #" + string(i) + " - audio_is_playing should return true on all audio once they have been resumed");
		}
		
		// stop all audio
		audio_stop_all();
		
	});
	
	addFact("Multiple audio playback functions test #5", function() {
		
		// test audio playback functions that handle multiple sounds
		
		var soundsToTest = GetSoundsToTest();
		
		var playedSounds = array_create(array_length(soundsToTest));
		
		// start all sounds
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var _sound = soundsToTest[i];
			
			playedSounds[i] = audio_play_sound(_sound, 1, false);
		}
		
		// pause all audio
		audio_pause_all();
		
		// resume all audio
		audio_resume_all();
		
		// stop all audio and check that they have stopped playing
		audio_stop_all();
		
		for (var i = 0; i < array_length(soundsToTest); i++) {
			
			var isPlaying = audio_is_playing(playedSounds[i]);
			assert_false(isPlaying, "Audio #" + string(i) + " - audio_stop_all should stop all sounds");
		}
		
	});
	
	addTestAsync("Audio gain over time test #1", objTestAsync, {
		
		ev_create: function() {
			// play sound at full gain then decrease to 0 over 0.5 seconds
			sound = audio_play_sound(snd_coinpickup_OGG, 1, false);
			audio_sound_gain(sound, 0, 500);
			
			startTime = get_timer() / 1000000; // microseconds --> seconds
		},
		
		ev_step: function() {
			// finish test when 0.6 second has passed (to give some leeway)
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds

			if (timeSpent > 0.6){
				
				// check if audio gain has decreased over time
				var gain = audio_sound_get_gain(sound);
				assert_equals(gain, 0, "audio_sound_gain should change the gain over time");
				audio_sound_gain(sound, 1, 0);
				
				audio_stop_all();
				
				// end test
				test_end();
			}
		},
		
	});
	
	addTestAsync("Audio track position over time test #1", objTestAsync, {
		
		ev_create: function() {
			// play audio
			sound = audio_play_sound(snd_coinpickup_OGG, 1, false);
			// start a timer
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
			testEnded = false;
			
		},
		
		ev_step: function() {
			
			// we shouldn't end the test on the same frame the audio is stopped,
			// otherwise 'ev_async_audio_playback_ended' will trigger on the first frame
			// of the next test and it will not work as intended.
			if (testEnded){
				
				test_end();
				
			}
			
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			// after 0.25 seconds, check if track position is correct
			if (timeSpent >= 0.25) {
				
				var trackPos = audio_sound_get_track_position(sound);
				// need to give some leeway to the asserts here,
				// due to how often ev_step occurs, it might not check
				// exactly at 0.25 seconds
				assert_less_or_equal(trackPos, 0.27, "audio_sound_get_track_position should return ~0.25");
				assert_greater_or_equal(trackPos, 0.24, "audio_sound_get_track_position should return ~0.25");
				
				audio_stop_sound(sound);
				
				testEnded = true;
			}
			
		},
		
	});
	
	addTestAsync("Async end-of-playback functionality test #1", objTestAsyncAudioPlaybackEnded, {
		
		ev_create: function() {
			// play sound
			sound = audio_play_sound(snd_jump_OGG, 1, false);
			
		},
		
		ev_async_audio_playback_ended: function() {
			// when 'playback ended' is triggered, check if audio has stopped playing
			var isPlaying = audio_is_playing(sound);
			assert_false(isPlaying, "ev_async_audio_playback_ended should trigger when a sound has stopped playing");
			
			test_end();
			
		},
		
	});

}