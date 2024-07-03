
global.soundsToTest = array_create(6, [
	snd_coinpickup_MP3,
	snd_coinpickup_OGG,
	snd_coinpickup_WAV,
	snd_jump_MP3,
	snd_jump_OGG,
	snd_jump_WAV
	]);

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
		
		// tests for multiple sound formats
		
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			
			// test audio name
			var audioName = audio_get_name(i);
			assert_not_null(audioName, "#1." + string(i) + " audio name should not be null");
			
			// test if audio exists
			var audioExists = audio_exists(i);
			assert_true(audioExists, "#2." + string(i) + " audio should exist");
			
			// test audio type
			var audioType = audio_get_type(i);
			assert_greater_or_equal(audioType, 0, "#3." + string(i) + "audio type should be greater or equal to 0");
			
			// test audio length
			var length = audio_sound_length(i);
			assert_greater(length, 0, "#4." + string(i) + "audio length should be greater than 0");
			
			// test audio playability
			var playable = audio_sound_is_playable(i);
			assert_true(playable, "#5." + string(i) + "audio sound should be playable");
			
			// test audio sound asset
			sound = audio_play_sound(i, 1, false);
			var soundAsset = audio_sound_get_asset(sound);
			assert_not_null(soundAsset, "#6." + string(i) + " audio sound asset should not be null");
			audio_stop_sound(i);
			
			// test default audio gain
			var gain = audio_sound_get_gain(i);
			assert_equals(gain, 1, "#7.1." + string(i) + " audio gain should be 1 by default");
			
			// test setting audio gain instantly
			audio_sound_gain(i, 0.1, 0); // set gain to 0.1
			gain = audio_sound_get_gain(i);
			assert_equals(gain, 0.1, "#7.2." + string(i) + " audio gain should be 0.1");
			
			audio_sound_gain(i, 1, 0); // set gain back to 1
			gain = audio_sound_get_gain(i);
			assert_equals(gain, 1, "#7.3." + string(i) + " audio gain should be 1");
			
			// test default pitch
			var pitch = audio_sound_get_pitch(i);
			assert_equals(pitch, 1, "#8.1." + string(i) + " audio pitch should be 1 by default");
			
			// test pitch changing
			audio_sound_pitch(i, 0.5);
			pitch = audio_sound_get_pitch(i);
			assert_equals(pitch, 0.5, "#8.2." + string(i) + " audio pitch should be 0.5");
			
			// change pitch back to default
			audio_sound_pitch(i, 1);
			pitch = audio_sound_get_pitch(i);
			assert_equals(pitch, 1, "#8.3." + string(i) + " audio pitch should be 1");
			
			// test track position
			var sound = audio_play_sound(i, 1, false);
			
			// check that track position is 0 by default
			var trackPosition = audio_sound_get_track_position(sound);
			assert_equals(trackPosition, 0, "#9.1." + string(i) + " audio track position should be 0 by default");
			
			// set it to something else and check if its correct
			audio_sound_set_track_position(sound, 0.1);
			trackPosition = audio_sound_get_track_position(sound);
			assert_equals(trackPosition, 0.1, "#9.2." + string(i) + " audio track position should be 0.1");
			
			// stop the sound
			audio_stop_sound(sound);

		}
		
					
		// test master gain
		var num = audio_get_listener_count();
		for(var i = 0; i < num; ++i;)
		{
		    var info = audio_get_listener_info(i);
		    var ind = info[? "index"];
			
			var gain = audio_get_master_gain(ind);
			
			assert_equals(gain, 1, "#10.1 audio master gain should be 1 by default");
			
			audio_set_master_gain(ind, 0.75);
			
			gain = audio_get_master_gain(ind);
			assert_equals(gain, 0.75, "#10.2 audio master gain should be 0.75");
			
			audio_set_master_gain(ind, 1);
			
		    ds_map_destroy(info);
		}
		
	});
	
	addFact("Single audio playback functions", function() {
		
		// test audio playback functions that handle single sound
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			
			// check if audio is playable
			var playable = audio_sound_is_playable(i);
			assert_true(playable, "#1 audio should be playable");
			
			// check that audio is currently NOT playing
			var isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#2." + string(i) + " audio should not be playing");
			
			// play audio and check if it is playing and not paused
			audio_play_sound(i, 1, false);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#3.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_false(isPaused, "#3.2." + string(i) + " audio should not be paused");
			
			// pause audio and check if it is still playing, and is paused
			audio_pause_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#4.1." + string(i) + " audio should still be playing");
			isPaused = audio_is_paused(i);
			assert_true(isPaused, "#4.2." + string(i) + " audio should be paused");
			
			// resume the audio and check if it is playing and not paused
			audio_resume_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#5.1." + string(i) + " audio should be playing");
			isPaused = audio_is_paused(i);
			assert_false(isPaused, "#5.2." + string(i) + " audio should not be paused");
			
			// stop the audio and check if it is not playing
			audio_stop_sound(i);
			
			isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#6" + string(i) + " audio should not be playing");
			
			// test positional audio
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
			
			audio_emitter_free(audioEmitter);
			
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
		
		
		// test creating streamed sounds
		var sound = audio_create_stream("StreamedSound.ogg");
		audio_play_sound(sound, 0, false);
		
		isPlaying = audio_is_playing(sound);
		assert_true(isPlaying, "#9.1 streamed audio should be playing");
		
		audio_stop_sound(sound);
		
		// test destroying streamed sounds
		var destroyed = audio_destroy_stream(sound);
		assert_true(destroyed, "#9.2 audio_destroy_stream should return true when destroying streamed sound");
		
	});
	
	addFact("Multiple audio playback functions", function() {
		
		// test audio playback functions that handle multiple sounds
		
		// start all sounds and check if they are all playing
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			audio_play_sound(i, 1, false);
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#1." + string(i) + " audio should be playing");
		}
		
		// pause all audio and check that they are still playing and are paused
		audio_pause_all();
		
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#2.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_true(isPaused, "#2.2." + string(i) + " audio should be paused");
		}
		
		// resume all audio and check that they are playing and are not paused
		audio_resume_all();
		
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_true(isPlaying, "#3.1." + string(i) + " audio should be playing");
			var isPaused = audio_is_paused(i);
			assert_false(isPaused, "#3.2." + string(i) + " audio should not be paused");
		}
		
		// stop all audio and check that they have stopped playing
		audio_stop_all();
		
		for (var i = 0; i <= array_length(global.soundsToTest); i++) {
			var isPlaying = audio_is_playing(i);
			assert_false(isPlaying, "#4." + string(i) + " audio should not be playing");
		}
		
	});
	
	addTestAsync("Audio gain over time test", objTestAsync, {
		
		ev_create: function() {
			// play sound at full gain then decrease to 0 over 0.5 seconds
			sound = audio_play_sound(snd_coinpickup_OGG, 1, false);
			audio_sound_gain(sound, 0, 500)
		},
		
		ev_step: function() {
			// when audio has stopped playing, finish test
			if (!audio_is_playing(sound)){
				
				// check if audio gain has decreased over time
				var gain = audio_sound_get_gain(sound);
				assert_equals(gain, 0, "#1 audio gain should be decreased to 0 over 0.5 seconds");
				audio_sound_gain(sound, 1, 0)
				
				// end test
				test_end();
			}
		},
		
	});
	
	addTestAsync("Audio track position over time test", objTestAsync, {
		
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
				assert_less_or_equal(trackPos, 0.27, "#1.1 audio position should be ~0.25");
				assert_greater_or_equal(trackPos, 0.24, "#1.2 audio position should be ~0.25");
				
				audio_stop_sound(sound);
				
				testEnded = true;
			}
			
		},
		
	});
	
	addTestAsync("Async end-of-playback functionality test", objTestAsyncAudioPlaybackEnded, {
		
		ev_create: function() {
			// play sound
			sound = audio_play_sound(snd_jump_OGG, 1, false);
			
		},
		
		ev_async_audio_playback_ended: function() {
			// when 'playback ended' is triggered, check if audio has stopped playing
			var isPlaying = audio_is_playing(sound);
			assert_false(isPlaying, "#1 audio playback should have ended when 'playback ended' event has triggered");
			
			test_end();
			
		},
		
	});

}