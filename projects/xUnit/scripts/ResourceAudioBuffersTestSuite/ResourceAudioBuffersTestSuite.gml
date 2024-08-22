
function GetInterpolatedPitchAudioBuffer(initialHertz, finalHertz, rate, duration, returnSoundId) {
   // Calculate total samples
   var totalSamples = rate * duration;

	// Create buffer and go to start of it
    var bufferId = buffer_create(totalSamples, buffer_fast, 1);
    buffer_seek(bufferId, buffer_seek_start, 0);

    for (var t = 0; t < totalSamples; t++) {
        // Linearly interpolate the frequency from initialHertz to finalHertz over the duration
        var hertz = initialHertz + (finalHertz - initialHertz) * (t / totalSamples);
        var sample = sin(2 * pi * hertz * (t / rate));
        var val_to_write = floor((sample + 1) * 127.5); // Convert from [-1, 1] to [0, 255]
        buffer_write(bufferId, buffer_u8, val_to_write);
    }
	
	// Either return a sound created from the buffer, or just return the buffer itself
	if (returnSoundId) {

		var soundId = audio_create_buffer_sound(bufferId, buffer_u8, rate, 0, totalSamples, audio_mono);

		return soundId;
	}
	else { 
		return bufferId; 
	}
	
}

function ResourceAudioBuffersTestSuite() : TestSuite() constructor {
	
	addFact("Audio buffer creation test #1", function() {
		
		// Create sound with increasing pitch and test that he buffer is not null
		var bufferSoundId = GetInterpolatedPitchAudioBuffer(220, 880, 44800, 1, false);
		
		var soundId = audio_create_buffer_sound(bufferSoundId, buffer_u8, 44800, 0, 44800, audio_mono);
		
		assert_not_null(soundId, "audio_create_buffer_sound should not return null");
		audio_free_buffer_sound(soundId);
		
	});
	
	addFact("Audio buffer freeing test #1", function() {
		
		// Free the buffer and test that it cannot play the sound afterwards
		assert_throw(function() {
			
			var bufferSoundId = GetInterpolatedPitchAudioBuffer(220, 880, 44800, 1, false);
		
			var soundId = audio_create_buffer_sound(bufferSoundId, buffer_u8, 44800, 0, 44800, audio_mono);
			
			audio_free_buffer_sound(soundId);
			
			audio_play_sound(soundId, 1, false);
			
		}, "audio_free_buffer_sound should make audio buffer unplayable");
		
	});
	
	addTestAsync("Playing audio buffer test #1", objTestAsyncAudioPlaybackEnded, {
		
		ev_create: function() {
			
			// Create audio buffer and start playing it
			bufferSoundId = GetInterpolatedPitchAudioBuffer(0, 1000, 48000, 1, true);
			
			audio_play_sound(bufferSoundId, 1, false);
			
		},
		
		ev_async_audio_playback_ended: function() {
			
			// If end of playback event gets triggered, audio has played successfully
			audio_free_buffer_sound(bufferSoundId);
		
			test_end();
		
		}
		
	});
	
		
	addTestAsync("Queueing sounds test #1", objTestAsyncAudioPlayback, {
		
		ev_create: function() {
			
			// Create audio queue and put an audio buffer into it
			audioQueue = audio_create_play_queue(buffer_u8, 48000, audio_mono);
			buffer = GetInterpolatedPitchAudioBuffer(0, 1000, 48000, 1, false);
			var bufferLength = buffer_get_size(buffer);
			audio_queue_sound(audioQueue, buffer, 0, bufferLength);
			
			// Play queue
			sound = audio_play_sound(audioQueue, 1, false);
			
		},
		
		ev_async_audio_playback: function() {
			
			// Check DS map values after playback
			
			var queueId = ds_map_find_value(async_load, "queue_id");
			assert_not_null(queueId, "Queue id should not be null");
			
			var bufferId = ds_map_find_value(async_load, "buffer_id");
			assert_not_null(bufferId, "Buffer id should not be null");
			
			var queueShutdown = ds_map_find_value(async_load, "queue_shutdown");
			assert_equals(queueShutdown, 0, "Queue shutdown should be 0 when audio isn't stopped by freeing the queue"); // Known issue https://github.com/YoYoGames/GameMaker-Bugs/issues/7390
			
			audio_free_play_queue(audioQueue);
			
			test_end();
			
		}
		
	});
	
	addTestAsync("Freeing audio play queue test #1", objTestAsyncAudioPlayback, {
		
		ev_create: function() {
			
			// Create audio queue and put an audio buffer into it
			audioQueue = audio_create_play_queue(buffer_u8, 48000, audio_mono);
			buffer = GetInterpolatedPitchAudioBuffer(0, 1000, 48000, 1, false);
			var bufferLength = buffer_get_size(buffer);
			audio_queue_sound(audioQueue, buffer, 0, bufferLength);
			
			// Play queue and start a timer
			sound = audio_play_sound(audioQueue, 1, false);
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
		},
		
		ev_step: function() {
			
			// After 0.25 seconds, free the queue
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			if (timeSpent > 0.25) {
				
				audio_free_play_queue(audioQueue);
				
			}
			
		},
		
		ev_async_audio_playback: function() {
			
			// When audio is stopped by freeing the queue, 'queue_shutdown' should be 1
			var queueShutdown = ds_map_find_value(async_load, "queue_shutdown");
			assert_equals(queueShutdown, 1, "queue shutdown should be 1 when audio is stopped by freeing the queue");
			
			test_end();
			
		}
		
	});
	
	addTestAsync("Async audio playback event test #1", objTestAsyncAudioPlayback, {
		
		ev_create: function() {
			
			// Create audio queue and place two audio buffers in it
			audioQueue = audio_create_play_queue(buffer_u8, 48000, audio_mono);
			buffer = GetInterpolatedPitchAudioBuffer(0, 1000, 48000, 1, false);
			var bufferLength = buffer_get_size(buffer);
			
			audio_queue_sound(audioQueue, buffer, 0, bufferLength);
			audio_queue_sound(audioQueue, buffer, 0, bufferLength);
			
			// Play the sound and keep track of how many times the event gets triggered
			sound = audio_play_sound(audioQueue, 1, false);
			
			eventTriggered = 0;
			
		},
		
		ev_async_audio_playback: function() {
			
			// The event should be triggered twice
			eventTriggered++;
			
			if (eventTriggered == 2) { test_end(); }
			
		},
		
		ev_cleanup: function() {
			
			// Clean up buffers
			buffer_delete(buffer);
			
		}
		
	});
	
	addFact("Audio recorder info test #1", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			assert_not_null(recorder_info, "Audio recorder info should not be null");
			
		}
		
	});
	
	addFact("Audio recorder info test #2", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			
			var name = ds_map_find_value(recorder_info, "name");
			show_debug_message("audio recorder " + string(i) + " name: " + string(name));
			assert_not_null(name, "Audio recorder name should not be null");
			
		}
		
	});
	
	addFact("Audio recorder info test #3", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			
			var index = ds_map_find_value(recorder_info, "index");
			show_debug_message("audio recorder " + string(i) + " index: " + string(index));
			assert_typeof(index, "number", "Audio recorder index should be a number");
			
		}
		
	});
	
	addFact("Audio recorder info test #4", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			
			// As of Runtime v2024.800.633, only buffer_s16 is supported (according to the manual)
			var data_format = ds_map_find_value(recorder_info, "data_format");
			show_debug_message("audio recorder " + string(i) + " data format: " + string(data_format));
			assert_equals(data_format, buffer_s16, "Audio recorder data format should be buffer_s16");
			
		}
		
	});
	
	addFact("Audio recorder info test #5", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			
			// As of Runtime v2024.800.633, sample rate is clamped to 16000 (according to the manual)
			var sample_rate = ds_map_find_value(recorder_info, "sample_rate");
			show_debug_message("audio recorder " + string(i) + " sample rate: " + string(sample_rate));
			assert_less_or_equal(sample_rate, 16000, "Audio recorder sample rate should be clamped to 16000hz");
			
		}
		
	});
	
	addFact("Audio recorder info test #6", function() {
		
		// Test audio recorder count
		var count = audio_get_recorder_count();
		assert_greater_or_equal(count, 0, "audio_get_recorder_count should return greater or equal to 0");
		
		// Test audio recorder infos
		
		for (var i = 0; i < count; i++) {
			
			var recorder_info = audio_get_recorder_info(i);
			
			// As of Runtime v2024.800.633, recorder channels can only be audio_mono (according to the manual)
			var channels = ds_map_find_value(recorder_info, "channels");
			show_debug_message("audio recorder " + string(i) + " channels: " + string(channels));
			assert_equals(channels, audio_mono, "Audio recorder channel should be audio_mono");
			
		}
		
	});
	
	addTestAsync("Audio recording test #1", objTestAsyncAudioRecording, {

		ev_create: function() {
		    
			// Get recorder count
			var count = audio_get_recorder_count();
			
			// If there are any audio recorders present, start recording on the 1st one,
			// otherwise, skip the test
			if (count >= 0) {
			    
				var recorderInfo = audio_get_recorder_info(0);
				recorderSampleRate = ds_map_find_value(recorderInfo, "sample_rate");
				
			    channelIndex = audio_start_recording(0);
			    show_debug_message("Started recording on channel " + string(channelIndex));
			    
			    audioBuffer = buffer_create(0, buffer_grow, 1);
				
			    show_debug_message("Created audio buffer with id " + string(audioBuffer));
			    
			} else {
			    show_debug_message("No audio recorders available.");
				
				test_end(TestResult.Skipped);
			}
			
			// Start a timer
			startTime = get_timer() / 1000000; // microseconds --> seconds
			
			played = false;
			
			soundId = 0;
		},
		
		ev_async_audio_recording: function() {
			
			// On each event, add the recorded buffer to the growing buffer
			var channel = async_load[? "channel_index"];
			
			// Channel should match the channel index created in the create event,
			// if not, end the test
			if (channel == channelIndex) {
			    
				// Get data length
			    var len = async_load[? "data_len"];
			    
				// Get the temporary buffer and copy it into the growing audio buffer
			    if (len > 0) {
			        var bufferId = async_load[? "buffer_id"];
			        if (buffer_exists(bufferId)) {
			            var currentSize = buffer_get_size(audioBuffer);
						buffer_copy(bufferId, 0, len, audioBuffer, currentSize);
						show_debug_message("Buffer copied to audioBuffer. Current buffer size: " + string(buffer_get_size(audioBuffer)));
			
			        } else {
			            show_debug_message("Buffer ID does not exist.");
			        }
			    } else {
			        show_debug_message("No data to copy.");
			    }
			}
			else {
				
				test_end(TestResult.Failed);
				
			}
			
			// Stop recording after 5 seconds
			var timeSpent = (get_timer() / 1000000) - startTime; // in seconds
			
			if (timeSpent >= 5 && !played) {
			    
			    audio_stop_recording(channelIndex);
			    
			    show_debug_message("Audio stopped recording");
			    
				// Get length and copy the audio buffer into a fixed size buffer,
				// as creating a sound from a growing buffer is not supported
			    var length = buffer_get_size(audioBuffer);
			    
			    if (length > 0) {
					
					// Copy growing buffer into fixed buffer
					var fixed_audio_buffer = buffer_create(length, buffer_fast, 1);
					buffer_copy(audioBuffer, 0, length, fixed_audio_buffer, 0);
					
					// Create sound with fixed buffer
			        soundId = audio_create_buffer_sound(fixed_audio_buffer, buffer_s16, recorderSampleRate, 0, length, audio_mono);
					
					show_debug_message("soundId: " + string(soundId));
			        
					// Play sound
			        if (soundId >= 0) {
			            show_debug_message("Playing sound!!!");
			            audio_play_sound(soundId, 1, false);
			        } else {
			            show_debug_message("Failed to create sound from buffer.");
						test_end(TestResult.Failed);
			        }
			    } else {
			        show_debug_message("Buffer is empty.");
					test_end(TestResult.Failed);
			    }
			    
			    played = true;
			}
		},
		
		ev_step: function() {
			
			// If playback has reached the end after some time,
			// the test has passed
			if (played && !audio_is_playing(soundId)){
				
				show_debug_message("audio ended, ending test now!!");
				
				test_end();
				
			}
			
		},
		
		ev_cleanup: function() {
			
			// Cleanup buffers
			audio_free_buffer_sound(soundId);
			buffer_delete(audioBuffer);
			
		}
		
	});
	
}
