

function ResourceSequenceTestSuite() : TestSuite() constructor {

		// SEQUENCES

		addFact("sequence.length_test", function() {
		
			math_set_epsilon(0.001);
			
			var _elmID, _seqInst, _seq, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			
			//#1 get sequence.length
			_output = _seq.length;
			assert_equals(_output, 60, "#1 sequence.length, failed to return the correct length");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			
			//#2 get sequence.length
			_output = _seq.length;
			assert_equals(_output, 50, "#2 sequence.length, failed to return the correct length");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequence.loopmode_test", function() {
			
			var _elmID, _seqInst, _seq, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
	
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			
			//#1 get/set sequence.loopmode - built-in const seqplay_oneshot
			_seq.loopmode = seqplay_oneshot;
			_output = _seq.loopmode;
			assert_equals(_output, seqplay_oneshot, "#1 get/set sequence.loopmode, failed to set to 'seqplay_oneshot'");
			
			//#2 get/set sequence.loopmode - built-in const seqplay_loop
			_seq.loopmode = seqplay_loop;
			_output = _seq.loopmode;
			assert_equals(_output, seqplay_loop, "#2 get/set sequence.loopmode, failed to set to 'seqplay_loop'");
			
			//#3 get/set sequence.loopmode - built-in const seqplay_pingpong
			_seq.loopmode = seqplay_pingpong;
			_output = _seq.loopmode;
			assert_equals(_output, seqplay_pingpong, "#3 get/set sequence.loopmode, failed to set to 'seqplay_pingpong'");
			
			
			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ "0.6",			"string" ],
				[ 2,				"number" ],
				[ int32(1),			"int32" ],
				[ int64(0),			"int64" ] ];  

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.loopmode = _value;
				_output = _seq.loopmode;
				_expected = floor(real(_value));
				
				assert_equals(_output, _expected, "#4 get/set sequence.loopmode ["+_details+"], failed to set the correct value");
			}
			
			// Set loopmode to 'oneshot'
			_seq.loopmode = seqplay_oneshot;

			_valueDetails = [
				[ "19.6",			"string" ],
				[ 233,				"number" ],
				[ int32(100),		"int32" ],
				[ int64(0x123),		"int64" ], 
				[ infinity,			"infinity" ],
				[ NaN,				"nan" ],
				[ "-12.6",			"(-) string" ],
				[ -233,				"(-) number" ],
				[ int32(-100),		"(-) int32" ],
				[ int64(-23),		"(-) int64" ], 
				[ -infinity,		"(-) infinity" ] ];  

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.loopmode = _value;
				_output = _seq.loopmode;
				assert_equals(_output, seqplay_oneshot, "#5 get/set sequence.loopmode ["+_details+"], out of bounds (should not have changed)");
			}
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})

		addFact("sequence.messageEventKeyframes_test", function() {

			var _elmID, _seq1Inst, _seq1, _seq1messageEventKeyframes, _seq2Inst, _seq2, _seq2messageEventKeyframes, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seq1Inst = layer_sequence_get_instance(_elmID);
			_seq1 = _seq1Inst.sequence;
			_seq1messageEventKeyframes = _seq1.messageEventKeyframes;
			
			// Clean up
			layer_sequence_destroy(_elmID);
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seq2Inst = layer_sequence_get_instance(_elmID);
			_seq2 = _seq2Inst.sequence;
			_seq2messageEventKeyframes = _seq2.messageEventKeyframes;
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
			
			//#1 get sequence.messageEventKeyframes - is array
			assert_typeof(_seq1messageEventKeyframes, "array", "#1 get sequence.messageEventKeyframes, should be of type array");
			
			//#2 get sequence.messageEventKeyframes - is array
			assert_typeof(_seq2messageEventKeyframes, "array", "#2 get sequence.messageEventKeyframes, should be of type array");
			
			//#3 get/set sequence.messageEventKeyframes
			_seq1.messageEventKeyframes = _seq2messageEventKeyframes;
			_output = _seq1.messageEventKeyframes;
			assert_array_equals(_output, _seq2messageEventKeyframes, "#3 get/set sequence.messageEventKeyframes, failed to set/get messageEventKeyframes");			
			
			//#4 get/set sequence.messageEventKeyframes
			_seq2.messageEventKeyframes = _seq1messageEventKeyframes;
			_output = _seq2.messageEventKeyframes;
			assert_array_equals(_output, _seq1messageEventKeyframes, "#4 get/set sequence.messageEventKeyframes, failed to set/get messageEventKeyframes");
			
		})

		addFact("sequence.name_test", function() {

			var _elmID, _seqInst, _seq, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ "hello",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000), "int64" ],
				[ true,				"bool" ],
				[ NaN,				"nan" ],
				[ infinity,			"infinity" ],
				[ {},				"struct" ],
				[ function() {},	"method"] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.name = _value;
				_output = _seq.name;
				_expected = string(_value);
				
				assert_equals(_output, _expected, "#4 get/set sequence.name ["+_details+"], failed to set the correct value");
			}
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequence.playbackSpeed_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _seq, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.playbackSpeed = _value;
				_output = _seq.playbackSpeed;
				
				assert_equals(_output, _value, "#1 get/set sequence.playbackSpeed ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequence.playbackSpeedType_test", function() {

			var _elmID, _seqInst, _seq, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			
			//#1 get/set sequence.loopmode - built-in const seqplay_oneshot
			_seq.playbackSpeedType = spritespeed_framespersecond;
			_output = _seq.playbackSpeedType;
			assert_equals(_output, spritespeed_framespersecond, "#1 get/set sequence.playbackSpeedType, failed to set to 'spritespeed_framespersecond'");
			
			//#2 get/set sequence.playbackSpeedType - built-in const seqplay_loop
			_seq.playbackSpeedType = spritespeed_framespergameframe;
			_output = _seq.playbackSpeedType;
			assert_equals(_output, spritespeed_framespergameframe, "#2 get/set sequence.playbackSpeedType, failed to set to 'spritespeed_framespergameframe'");
			
			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ "0.6",			"string" ],
				[ 1.4,				"number" ],
				[ int32(1),			"int32" ],
				[ int64(0),			"int64" ] ];  

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.playbackSpeedType = _value;
				_output = _seq.playbackSpeedType;
				_expected = floor(real(_value));
				
				assert_equals(_output, _expected, "#3 get/set sequence.playbackSpeedType ["+_details+"], failed to set the correct value");
			}
			
			// Set playbackSpeedType to 'framespergameframe'
			_seq.playbackSpeedType = spritespeed_framespergameframe;

			_valueDetails = [
				[ "19.6",			"string" ],
				[ 233,				"number" ],
				[ int32(100),		"int32" ],
				[ int64(0x123),		"int64" ], 
				[ infinity,			"infinity" ],
				[ NaN,				"nan" ],
				[ "-12.6",			"(-) string" ],
				[ -233,				"(-) number" ],
				[ int32(-100),		"(-) int32" ],
				[ int64(-23),		"(-) int64" ], 
				[ -infinity,		"(-) infinity" ] ];

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.playbackSpeedType = _value;
				_output = _seq.playbackSpeedType;
				assert_equals(_output, spritespeed_framespergameframe, "#4 get/set sequence.playbackSpeedType ["+_details+"], out of bounds (should not have changed)");
			}
			
			// Clean up
			layer_sequence_destroy(_elmID);		
			layer_destroy(_testLayer)

		})

		addFact("sequence.tracks_test", function() {

			var _elmID, _seq1Inst, _seq1, _seq1Tracks, _seq2Inst, _seq2, _seq2Tracks, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seq1Inst = layer_sequence_get_instance(_elmID);
			_seq1 = _seq1Inst.sequence;
			_seq1Tracks = _seq1.tracks;
			
			// Clean up
			layer_sequence_destroy(_elmID);
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seq2Inst = layer_sequence_get_instance(_elmID);
			_seq2 = _seq2Inst.sequence;
			_seq2Tracks = _seq2.tracks;
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
			
			//#1 get sequence.tracks - is array
			assert_typeof(_seq1Tracks, "array", "#1 get sequence.tracks, should be of type array");
			
			//#2 get sequence.tracks - is array
			assert_typeof(_seq2Tracks, "array", "#2 get sequence.tracks, should be of type array");
			
			//#3 get/set sequence.tracks
			_seq1.tracks = _seq2Tracks;
			_output = _seq1.tracks;
			assert_array_equals(_output, _seq2Tracks, "#3 get/set sequence.tracks, failed to set/get tracks");
			
			//#4 get/set sequence.tracks
			_seq2.tracks = _seq1Tracks;
			_output = _seq2.tracks;
			assert_array_equals(_output, _seq1Tracks, "#4 get/set sequence.tracks, failed to set/get tracks");

		})

		addFact("sequence.volume_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _seq, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			// #### POSITIVE VALUES ####
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "0.3",			"string" ],
				[ 0.9,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.volume = _value;
				_output = _seq.volume;
				
				assert_equals(_output, _value, "#1 get/set sequence.volume ["+_details+"], failed to set the correct value");
			}	
			
			// #### NEGATIVE VALUES ####
			
			_valueDetails = [
				[ "-0.3",			"string" ],
				[ -0.5,				"number" ],
				[ int32(-20),		"int32" ],
				[ int64(-199),		"int64" ],
				[ -infinity,		"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.volume = _value;
				_output = _seq.volume;
				
				assert_equals(_output, 0, "#2 get/set sequence.volume ["+_details+"], failed to set the correct value (negative)");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		addFact("sequence.xorigin_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _seq, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.xorigin = _value;
				_output = _seq.xorigin;
				
				assert_equals(_output, _value, "#4 get/set sequence.xorigin ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequence.yorigin_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _seq, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.yorigin = _value;
				_output = _seq.yorigin;
				
				assert_equals(_output, _value, "#4 get/set sequence.yorigin ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})

		// SEQUENCE INSTANCES

		addFact("sequenceInstance.activeTrack_test", function() {

			//sequenceInstance.activeTracks property test
			var _testLayer = layer_create(100, "testLayer");
			
			var _output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			var _elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			var _seqInst = layer_sequence_get_instance(_elmID);
			
			// #1 get sequenceInstance.activeTracks
			var _activeTrackArray = _seqInst.activeTracks;
			assert_true(is_array(_activeTrackArray), "#1 get sequenceInstance.activeTracks - is_array");
			
			// We would need a way to perform a tick before the active track is populated. For now, we will just comment this check out
			//assert_equals(array_length(_activeTrackArray), 2, "#1 get sequenceInstance.activeTracks - array_length");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})
	
		addTestAsync("sequenceInstance.activeTrack_async_test", objTestAsync, {
			
			ev_create: function() {
				
				testLayer = layer_create(100, "testLayer");
			
				var _output = layer_exists(testLayer);
				assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
				
				// We don't have a layer to work with
				if (_output == false)
				{
					instance_destroy();
					return;
				}
				
				elmID = layer_sequence_create(testLayer, 0, 0, Sequence1);
				seqInst = layer_sequence_get_instance(elmID);
			},
		
			ev_step: function() {
			
				var _activeTrackArray = seqInst.activeTracks;
				
				// We need at least one tick for the active tracks to be populated.
				assert_array_length(_activeTrackArray, 1, "#1 array_length(sequenceInstance.activeTracks), failed to return correct value");
			
				layer_sequence_destroy(elmID);
				layer_destroy(testLayer);
				
				test_end();
			}
			
		});
		
		addFact("sequenceInstance.finished_test", function() {
			
			var _elmID, _seqInst, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seqInst = layer_sequence_get_instance(_elmID);
			
			//#1 get sequenceInstance.finished - just started
			_output = _seqInst.finished;
			assert_false(_output, "#1 get sequenceInstance.finished, failed to return 'not fininshed' after starting");
			
			//#2 get sequenceInstance.finished - head position set after end of sequence, still not finished (only playback sets the finished flag)
			_seqInst.headPosition = 100;
			_output = _seqInst.finished;
			assert_false(_output, "#2 get sequenceInstance.finished, failed to return 'not fininshed' (headposition overflow - only playback should set the finished flag)");
			
			//#3 get sequenceInstance.finished - head position reset to not finished time
			_seqInst.headPosition = 10;
			_output = _seqInst.finished;
			assert_false(_output, "#3 get sequenceInstance.finished, failed to return 'not fininshed' (headposition in range)");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequenceInstance.headDirection_test", function() {

			math_set_epsilon(0.01);

			var _elmID, _seqInst, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			// #### POSITIVE VALUES ####
			
			_valueDetails = [
				[ 0.55,				"number" ],
				[ "0.6",			"string" ],
				[ 0.9,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
				
				_seqInst.headDirection = _value;
				_output = _seqInst.headDirection;
				
				assert_equals(_output, 1, "#1 get/set sequenceInstance.headDirection ["+_details+"], failed to set the correct value");
			}	
			
			// #### NEGATIVE VALUES ####
			
			_valueDetails = [
				[ "-0.3",			"string" ],
				[ -0.5,				"number" ],
				[ int32(-20),		"int32" ],
				[ int64(-199),		"int64" ],
				[ -infinity,		"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seqInst.headDirection = _value;
				_output = _seqInst.headDirection;
				
				assert_equals(_output, -1, "#2 get/set sequenceInstance.headDirection ["+_details+"], failed to set the correct value (negative)");
			}	
			
			// #### ZERO ####
			
			_seqInst.headDirection = 1;
			_seqInst.headDirection = 0;
			_output = _seqInst.headDirection;
				
			assert_equals(_output, 1, "#1 get/set sequenceInstance.headDirection ["+_details+"], failed to keep its value when set to 0 (zero)");
			
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		addFact("sequenceInstance.headPosition_test", function() {

			math_set_epsilon(0.01);

			var _elmID, _seqInst, _seq, _length, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_length = _seq.length;

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 40,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(3),			"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seqInst.headPosition = _value;
				_output = _seqInst.headPosition;
				_expected = clamp(real(_value), 0, _length);
				
				assert_equals(_output, _expected, "#1 get/set sequenceInstance.headPosition ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		addFact("sequenceInstance.paused_test", function() {

			var _elmID, _seqInst, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			
			//#1 get sequenceInstance.paused - not paused
			_output = _seqInst.paused;
			assert_false(_output, "#1 get sequenceInstance.paused, failed to return 'paused', by default a sequence is not paused");
			
			//#2 get sequenceInstance.paused - is paused
			layer_sequence_pause(_elmID);
			_output = _seqInst.paused;
			assert_true(_output, "#2 layer_sequence_pause(), failed to pause the sequence");
			
			//#3 get sequenceInstance.paused - is unpaused
			layer_sequence_play(_elmID);
			_output = _seqInst.paused;
			assert_false(_output, "#2 layer_sequence_play(), failed to resume the sequence");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequenceInstance.sequence_test", function() {

			//sequenceInstance.sequence property test

			var _elmID, _seqInst, _seq, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			
			// #1 get sequenceInstance.sequence
			_seq = _seqInst.sequence;
			assert_not_equals(_seq, -1, "#1 get sequenceInstance.sequence, falied to get a valid sequence");
			
			// #2 set sequenceInstance.sequence
			_seqInst.sequence = Sequence2;
			_output = layer_sequence_get_sequence(_elmID);
			assert_equals(_output.name, "Sequence2", "#2 set sequenceInstance.sequence, failed to get a switched sequenced value");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("sequenceInstance.speedScale_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seqInst.speedScale = _value;
				_output = _seqInst.speedScale;
				
				assert_equals(_output, _value, "#1 get/set sequenceInstance.speedScale ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		addFact("sequenceInstance.volume_test", function() {

			math_set_epsilon(0.001);

			var _elmID, _seqInst, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			// #### POSITIVE VALUES ####
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "0.3",			"string" ],
				[ 0.9,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seqInst.volume = _value;
				_output = _seqInst.volume;
				
				assert_equals(_output, _value, "#1 get/set sequenceInstance.volume ["+_details+"], failed to set the correct value");
			}	
			
			// #### NEGATIVE VALUES ####
			
			_valueDetails = [
				[ "-0.3",			"string" ],
				[ -0.5,				"number" ],
				[ int32(-20),		"int32" ],
				[ int64(-199),		"int64" ],
				[ -infinity,		"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seqInst.volume = _value;
				_output = _seqInst.volume;
				
				assert_equals(_output, 0, "#2 get/set sequenceInstance.volume ["+_details+"], failed to set the correct value (negative)");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		// TRACKS

		addFact("track.enabled_test", function() {

			var _elmID, _seqInst, _seq, _track, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_track = _seq.tracks[0];

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			// #### POSITIVE VALUES ####
			
			_valueDetails = [
				[ true,				"bool" ],
				[ 0.55,				"number" ],
				[ "0.6",			"string" ],
				[ 0.9,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
				
				_track.enabled = _value;
				_output = _track.enabled;
				
				assert_true(_output, "#1 get/set sequence.enabled ["+_details+"], failed to set the correct value");
			}	
			
			// #### NEGATIVE VALUES ####
			
			_valueDetails = [
				[ false,			"bool" ],
				[ "-0.3",			"string" ],
				[ -0.5,				"number" ],
				[ int32(-20),		"int32" ],
				[ int64(-199),		"int64" ],
				[ -infinity,		"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_track.enabled = _value;
				_output = _track.enabled;
				
				assert_false(_output, "#2 get/set sequence.enabled ["+_details+"], failed to set the correct value (negative)");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})

		addFact("track.interpolation_test", function() {

			var _elmID, _seqInst, _seq, _assetTrack, _track, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_assetTrack = _seq.tracks[0];
			_track = _assetTrack.tracks[0];
			
			//#1 get/set track.interpolation - built-in const seqinterpolation_assign
			_track.interpolation = seqinterpolation_assign;
			_output = _track.interpolation;
			assert_equals(_output, seqinterpolation_assign, "#1 get/set track.interpolation, failed to set to 'seqinterpolation_assign'");
			
			//#2 get/set track.interpolation - built-in const seqinterpolation_lerp
			_track.interpolation = seqinterpolation_lerp;
			_output = _track.interpolation;
			assert_equals(_output, seqinterpolation_lerp, "#2 get/set track.interpolation, failed to set to 'seqinterpolation_lerp'");

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ "1.6",			"string" ],
				[ 0.1,				"number" ],
				[ int32(1),			"int32" ],
				[ int64(0),			"int64" ] ];  

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_track.interpolation = _value;
				_output = _track.interpolation;
				_expected = floor(real(_value));
				
				assert_equals(_output, _expected, "#4 get/set track.interpolation ["+_details+"], failed to set the correct value");
			}
			
			// Set loopmode to 'assign'
			_track.interpolation = seqinterpolation_assign;

			_valueDetails = [
				[ "19.6",			"string" ],
				[ 233,				"number" ],
				[ int32(100),		"int32" ],
				[ int64(0x123),		"int64" ], 
				[ infinity,			"infinity" ],
				[ NaN,				"nan" ],
				[ "-12.6",			"(-) string" ],
				[ -233,				"(-) number" ],
				[ int32(-100),		"(-) int32" ],
				[ int64(-23),		"(-) int64" ], 
				[ -infinity,		"(-) infinity" ] ];  

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_track.interpolation = _value;
				_output = _track.interpolation;
				assert_equals(_output, seqinterpolation_assign, "#5 get/set track.interpolation ["+_details+"], out of bounds (should not have changed)");
			}
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})

		addFact("track.keyframes_test", function() {

			var _elmID, _output;
			var _seq1Inst, _seq1, _seq1Tracks, _seq1Track0Keyframes;
			var _seq2Inst, _seq2, _seq2Tracks, _seq2Track0Keyframes;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seq1Inst = layer_sequence_get_instance(_elmID);
			_seq1 = _seq1Inst.sequence;
			_seq1Tracks = _seq1.tracks;
			_seq1Track0Keyframes = _seq1Tracks[0].keyframes;

			// Clean up
			layer_sequence_destroy(_elmID);
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seq2Inst = layer_sequence_get_instance(_elmID);
			_seq2 = _seq2Inst.sequence;
			_seq2Tracks = _seq2.tracks;
			_seq2Track0Keyframes = _seq2Tracks[0].keyframes;
	
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);


			//#1 get tracks.keyframes - is array
			assert_typeof(_seq1Track0Keyframes, "array", "#1 get tracks.keyframes, should be of type array");
			
			//#2 get tracks.keyframes - is array
			assert_typeof(_seq2Track0Keyframes, "array", "#2 get tracks.keyframes, should be of type array");
			
			//#3 get/set tracks.keyframes
			_seq1Tracks[0].keyframes = _seq2Track0Keyframes;
			_output = _seq1Tracks[0].keyframes;
			assert_array_equals(_output, _seq2Track0Keyframes, "#3 get/set tracks.keyframes, failed to set/get keyframes");
			
			//#4 get/set tracks.keyframes
			_seq2Tracks[0].keyframes = _seq1Track0Keyframes;
			_output = _seq2Tracks[0].keyframes;
			assert_array_equals(_output, _seq1Track0Keyframes, "#4 get/set tracks.keyframes, failed to set/get keyframes");

		})

		addFact("track.name_test", function() {

			var _elmID, _seqInst, _seq, _track, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_track = _seq.tracks[0];

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ "hello",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000), "int64" ],
				[ true,				"bool" ],
				[ NaN,				"nan" ],
				[ infinity,			"infinity" ],
				[ {},				"struct" ],
				[ function() {},	"method"] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_track.name = _value;
				_output = _track.name;
				_expected = string(_value);
				
				assert_equals(_output, _expected, "#4 get/set track.name ["+_details+"], failed to set the correct value");
			}
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})

		addFact("track.tracks_test", function() {

			var _elmID, _output;
			var _seq1Inst, _seq1, _seq1Tracks, _seq1Track0Tracks;
			var _seq2Inst, _seq2, _seq2Tracks, _seq2Track0Tracks;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seq1Inst = layer_sequence_get_instance(_elmID);
			_seq1 = _seq1Inst.sequence;
			_seq1Tracks = _seq1.tracks;
			_seq1Track0Tracks = _seq1Tracks[0].tracks;

			// Clean up
			layer_sequence_destroy(_elmID);
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence2);
			_seq2Inst = layer_sequence_get_instance(_elmID);
			_seq2 = _seq2Inst.sequence;
			_seq2Tracks = _seq2.tracks;
			_seq2Track0Tracks = _seq2Tracks[0].tracks;
	
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);


			//#1 get tracks.tracks - is array
			assert_typeof(_seq1Track0Tracks, "array", "#1 get tracks.tracks, should be of type array");
			
			//#2 get tracks.tracks - is array
			assert_typeof(_seq2Track0Tracks, "array", "#2 get tracks.tracks, should be of type array");
			
			//#3 get/set tracks.tracks
			_seq1Tracks[0].tracks = _seq2Track0Tracks;
			_output = _seq1Tracks[0].tracks;
			assert_array_equals(_output, _seq2Track0Tracks, "#3 get/set tracks.tracks, failed to set/get tracks");
			
			//#4 get/set tracks.tracks
			_seq2Tracks[0].tracks = _seq1Track0Tracks;
			_output = _seq2Tracks[0].tracks;
			assert_array_equals(_output, _seq1Track0Tracks, "#4 get/set tracks.tracks, failed to set/get tracks");
			
		})

		addFact("track.traits_test", function() {

			var _elmID, _seqInst, _seq, _track, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_track = _seq.tracks[0];

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			_valueDetails = [
				[ 0,				"zero" ],
				[ "12.3",			"string" ],
				[ 1000,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ],
				[ "-131.3",			"(-) string" ],
				[ -990,				"(-) number" ],
				[ int32(-20),		"(-) int32" ],
				[ int64(-199),		"(-) int64" ],
				[ -infinity,		"(-) infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_seq.traits = _value;
				_output = _seq.traits;
				
				assert_equals(_output, _value, "#1 get/set track.traits ["+_details+"], failed to set the correct value");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);

		})

		addFact("track.type_test", function() {

			//track.type property test
			
			var _elmID, _seqInst, _seq, _track, _output;
			
			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with
			
			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_track = _seq.tracks[0];
			
			_output = _track.type;
			
			//#1 get track.type - correct value
			assert_equals(_output, seqtracktype_graphic, "#1 get track.type, failed to return the correct value");
			
			//#2 get track.type - incorrect value
			assert_not_equals(_output, seqtracktype_real, "#2 get track.type, failed to return the correct value");
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
		})

		addFact("track.visible_test", function() {

			var _elmID, _seqInst, _seq, _track, _output;

			var _testLayer = layer_create(100, "testLayer");
			
			_output = layer_exists(_testLayer);
			assert_true(_output, "#0 layer_create(), failed to create a layer (exiting)");
			
			if (_output == false) return; // We don't have a layer to work with

			_elmID = layer_sequence_create(_testLayer, 0, 0, Sequence1);
			_seqInst = layer_sequence_get_instance(_elmID);
			_seq = _seqInst.sequence;
			_track = _seq.tracks[0];

			var _valueDetails, _valueDetailsCount, _valueType, _value, _details, _expected;
			
			// #### POSITIVE VALUES ####
			
			_valueDetails = [
				[ true,				"bool" ],
				[ 0.55,				"number" ],
				[ "0.6",			"string" ],
				[ 0.9,				"number" ],
				[ int32(1000),		"int32" ],
				[ int64(0x1000000),	"int64" ],
				[ infinity,			"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
				
				_track.visible = _value;
				_output = _track.visible;
				
				assert_true(_output, "#1 get/set track.visible ["+_details+"], failed to set the correct value");
			}	
			
			// #### NEGATIVE VALUES ####
			
			_valueDetails = [
				[ false,			"bool" ],
				[ "-0.3",			"string" ],
				[ -0.5,				"number" ],
				[ int32(-20),		"int32" ],
				[ int64(-199),		"int64" ],
				[ -infinity,		"infinity" ] ]; 

			
			_valueDetailsCount = array_length(_valueDetails);
			for (var _j = 0; _j < _valueDetailsCount; _j++) {
				
				_valueType = _valueDetails[_j];
				_value = _valueType[0];
				_details = _valueType[1];
					
				_track.visible = _value;
				_output = _track.visible;
				
				assert_false(_output, "#2 get/set track.visible ["+_details+"], failed to set the correct value (negative)");
			}	
			
			// Clean up
			layer_sequence_destroy(_elmID);
			layer_destroy(_testLayer);
			
		})
	
}

