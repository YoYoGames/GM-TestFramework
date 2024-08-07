
function TestAudioEffectMembers(audioEffectType, membersArray) {
	
	// Loop through all members of audio effect and check if it exists
	for (var i = 0; i < array_length(membersArray); i++) {
		
		var output = variable_struct_exists(audioEffectType, membersArray[i]);
		assert_true(output, string(audioEffectType) + " should contain " + string(membersArray[i]) + " as a member");
		
	}
	
}

function ResourceAudioEffectsTestSuite() : TestSuite() constructor {
	
	addFact("Audio bus test #1", function() {
		// Checks the members of the built-in bus struct audio_bus_main and a user-created bus
		var _buses = [ 
			audio_bus_main, 
			audio_bus_create() 
		];
		
		// Both should have the same members
		array_foreach(_buses, function(_value, _index) {
			assert_true(variable_struct_exists(_value, "bypass"), string(_value) + " should cotain bypass as a member");
			assert_true(variable_struct_exists(_value, "gain"), string(_value) + " should cotain gain as a member");
			assert_true(variable_struct_exists(_value, "effects"), string(_value) + " should cotain effects as a member");
		});
	});
	
	addFact("Bitcrusher test #1", function() {
		
		var members = ["type", "bypass", "gain", "factor", "resolution", "mix"];
		
		var effect = audio_effect_create(AudioEffectType.Bitcrusher);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Delay test #1", function() {
		
		var members = ["type", "bypass", "time", "feedback", "mix"];
		
		var effect = audio_effect_create(AudioEffectType.Delay);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Gain test #1", function() {
		
		var members = ["type", "bypass", "gain"];
		
		var effect = audio_effect_create(AudioEffectType.Gain);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("HPF2 test #1", function() {
		
		var members = ["type", "bypass", "cutoff", "q"];
		
		var effect = audio_effect_create(AudioEffectType.HPF2);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("LPF2 test #1", function() {
		
		var members = ["type", "bypass", "cutoff", "q"];
		
		var effect = audio_effect_create(AudioEffectType.LPF2);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Reverb1 test #1", function() {
		
		var members = ["type", "bypass", "size", "damp", "mix"];
		
		var effect = audio_effect_create(AudioEffectType.Reverb1);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Tremolo test #1", function() {
		
		var members = ["type", "bypass", "rate", "intensity", "offset", "shape"];
		
		var effect = audio_effect_create(AudioEffectType.Tremolo);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("EQ test #1", function() {
		
		var members = ["type", "bypass", "locut", "loshelf", "eq1", "eq2", "eq3", "eq4", "hishelf", "hicut"];
		
		var effect = audio_effect_create(AudioEffectType.EQ);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("PeakEQ test #1", function() {
		
		var members = ["type", "bypass", "freq", "q", "gain"];
		
		var effect = audio_effect_create(AudioEffectType.PeakEQ);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("HiShelf test #1", function() {
		
		var members = ["type", "bypass", "freq", "q", "gain"];
		
		var effect = audio_effect_create(AudioEffectType.HiShelf);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("LoShelf test #1", function() {
		
		var members = ["type", "bypass", "freq", "q", "gain"];
		
		var effect = audio_effect_create(AudioEffectType.LoShelf);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Compressor test #1", function() {
		
		var members = ["type", "bypass", "ingain", "threshold", "ratio", "attack", "release", "outgain"];
		
		var effect = audio_effect_create(AudioEffectType.Compressor);
		
		TestAudioEffectMembers(effect, members);
		
	});
	
	addFact("Audio effects bus linking test #1", function() {
		// Checks that emitters and buses link together correctly.
		// Use the main bus and three user-created buses
		var _buses = [
			audio_bus_main,
			audio_bus_create(),
			audio_bus_create(),
			audio_bus_create()
		];
		
		// Add some variation (for all buses are created equal)
		for (var _i = 0; _i < array_length(_buses); ++_i) {
			// Give each bus a random gain and bypass state
			_buses[_i].gain = random_range(0.0, 1.0);
			_buses[_i].bypass = choose(false, true);
		}

		// Create four emitters
		var _emitters = [
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create()
		];

		// Link one emitter to each bus
		// Emitters should link to the main bus by default,
		// we can test that by not explicitly linking one to it.
		for (var _i = 1; _i < array_length(_emitters); ++_i)
			audio_emitter_bus(_emitters[_i], _buses[_i]);
			
		// Verify that the retrieved bus is the same as the one we linked each emitter to
		for (var _i = 0; _i < array_length(_buses); ++_i)
			assert_equals(_buses[_i], audio_emitter_get_bus(_emitters[_i]));
			
		// Clean up the emitters
		for (var _i = 0; _i < array_length(_emitters); ++_i)
			audio_emitter_free(_emitters[_i]);
		
	});
	
	addFact("Audio effects bus linking test #2", function() {
		// Checks that emitters and buses link together correctly.
		// Use the main bus and three user-created buses
		var _buses = [
			audio_bus_main,
			audio_bus_create(),
			audio_bus_create(),
			audio_bus_create()
		];
		
		// Add some variation (for all buses are created equal)
		for (var _i = 0; _i < array_length(_buses); ++_i) {
			// Give each bus a random gain and bypass state
			_buses[_i].gain = random_range(0.0, 1.0);
			_buses[_i].bypass = choose(false, true);
		}

		// Create four emitters
		var _emitters = [
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create()
		];

		// Link one emitter to each bus
		// Emitters should link to the main bus by default,
		// we can test that by not explicitly linking one to it.
		for (var _i = 1; _i < array_length(_emitters); ++_i)
			audio_emitter_bus(_emitters[_i], _buses[_i]);
		
		// Verify that the retrieved emitter is the same one as the one we linked to the bus
		for (var _i = 0; _i < array_length(_emitters); _i++)
			assert_equals(_emitters[_i], audio_bus_get_emitters(_buses[_i])[0]);
			
		// Clean up the emitters
		for (var _i = 0; _i < array_length(_emitters); ++_i)
			audio_emitter_free(_emitters[_i]);
		
	});
	
	addFact("Audio effects bus linking test #3", function() {
		// Checks that emitters and buses link together correctly.
		// Use the main bus and three user-created buses
		var _buses = [
			audio_bus_main,
			audio_bus_create(),
			audio_bus_create(),
			audio_bus_create()
		];
		
		// Add some variation (for all buses are created equal)
		for (var _i = 0; _i < array_length(_buses); ++_i) {
			// Give each bus a random gain and bypass state
			_buses[_i].gain = random_range(0.0, 1.0);
			_buses[_i].bypass = choose(false, true);
		}

		// Create four emitters
		var _emitters = [
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create(),
			audio_emitter_create()
		];

		// Link one emitter to each bus
		// Emitters should link to the main bus by default,
		// we can test that by not explicitly linking one to it.
		for (var _i = 1; _i < array_length(_emitters); ++_i)
			audio_emitter_bus(_emitters[_i], _buses[_i]);
			
		// Clear emitters from each bus and verify the emitters are relinked to the main bus
		for (var _i = 0; _i < array_length(_buses); _i++)
			audio_bus_clear_emitters(_buses[_i]);
		// All 4 emitters should be linked to the main bus now
		assert_equals(array_length(audio_bus_get_emitters(audio_bus_main)), 4);
			
		// Clean up the emitters
		for (var _i = 0; _i < array_length(_emitters); ++_i)
			audio_emitter_free(_emitters[_i]);
			
	});
}
