function ResourceAudioEffectsTestSuite() : TestSuite() constructor {
	addFact("Audio Effects: Bus Structs", function() {
		// Checks the members of the built-in bus struct audio_bus_main and a user-created bus
		var _buses = [ 
			audio_bus_main, 
			audio_bus_create() 
		];
		
		// Both should have the same members
		array_foreach(_buses, function(_value, _index) {
			assert_true(variable_struct_exists(_value, "bypass"));
			assert_true(variable_struct_exists(_value, "gain"));
			assert_true(variable_struct_exists(_value, "effects"));
		});
	});
	
	addFact("Audio Effects: Effect Structs", function() {
		// Checks the members of the effect structs returned by audio_effect_create
		var _effects = [ 
			audio_effect_create(AudioEffectType.Bitcrusher), 
			audio_effect_create(AudioEffectType.Delay),
			audio_effect_create(AudioEffectType.Gain), 
			audio_effect_create(AudioEffectType.HPF2),
			audio_effect_create(AudioEffectType.LPF2), 
			audio_effect_create(AudioEffectType.Reverb1),
			audio_effect_create(AudioEffectType.Tremolo),
			audio_effect_create(AudioEffectType.EQ),
			audio_effect_create(AudioEffectType.PeakEQ),
			audio_effect_create(AudioEffectType.HiShelf),
			audio_effect_create(AudioEffectType.LoShelf),
			audio_effect_create(AudioEffectType.Compressor)
		];
		
		array_foreach(_effects, function(_value, _index) {
			// All effect structs have these two members
			assert_true(variable_struct_exists(_value, "type"));
			assert_true(variable_struct_exists(_value, "bypass"));
			
			// The other members are dependent on the effect type
			switch(_value.type) {
				case AudioEffectType.Bitcrusher:
					assert_true(variable_struct_exists(_value, "gain"));
					assert_true(variable_struct_exists(_value, "factor"));
					assert_true(variable_struct_exists(_value, "resolution"));
					assert_true(variable_struct_exists(_value, "mix"));
					break;
				case AudioEffectType.Delay:
					assert_true(variable_struct_exists(_value, "time"));
					assert_true(variable_struct_exists(_value, "feedback"));
					assert_true(variable_struct_exists(_value, "mix"));
					break;
				case AudioEffectType.Gain:
					assert_true(variable_struct_exists(_value, "gain"));
					break;
				case AudioEffectType.HPF2:
				case AudioEffectType.LPF2:
					assert_true(variable_struct_exists(_value, "cutoff"));
					assert_true(variable_struct_exists(_value, "q"));
					break;
				case AudioEffectType.Reverb1:
					assert_true(variable_struct_exists(_value, "size"));
					assert_true(variable_struct_exists(_value, "damp"));
					assert_true(variable_struct_exists(_value, "mix"));
					break;
				case AudioEffectType.Tremolo:
					assert_true(variable_struct_exists(_value, "rate"));
					assert_true(variable_struct_exists(_value, "intensity"));
					assert_true(variable_struct_exists(_value, "offset"));
					assert_true(variable_struct_exists(_value, "shape"));
					break;
				case AudioEffectType.EQ:
					assert_true(variable_struct_exists(_value, "locut"));
					assert_true(variable_struct_exists(_value, "loshelf"));
					assert_true(variable_struct_exists(_value, "eq1"));
					assert_true(variable_struct_exists(_value, "eq2"));
					assert_true(variable_struct_exists(_value, "eq3"));
					assert_true(variable_struct_exists(_value, "eq4"));
					assert_true(variable_struct_exists(_value, "hishelf"));
					assert_true(variable_struct_exists(_value, "hicut"));
					break;
				case AudioEffectType.PeakEQ:
					assert_true(variable_struct_exists(_value, "freq"));
					assert_true(variable_struct_exists(_value, "q"));
					assert_true(variable_struct_exists(_value, "gain"));
					break;
				case AudioEffectType.HiShelf:
					assert_true(variable_struct_exists(_value, "freq"));
					assert_true(variable_struct_exists(_value, "q"));
					assert_true(variable_struct_exists(_value, "gain"));
					break;
				case AudioEffectType.LoShelf:
					assert_true(variable_struct_exists(_value, "freq"));
					assert_true(variable_struct_exists(_value, "q"));
					assert_true(variable_struct_exists(_value, "gain"));
					break;
				case AudioEffectType.Compressor:
					assert_true(variable_struct_exists(_value, "ingain"));
					assert_true(variable_struct_exists(_value, "threshold"));
					assert_true(variable_struct_exists(_value, "ratio"));
					assert_true(variable_struct_exists(_value, "attack"));
					assert_true(variable_struct_exists(_value, "release"));
					assert_true(variable_struct_exists(_value, "outgain"));
					break;
				default:
					throw "Error: Unknown audio effect type";
			}
		});
	});
	
	addFact("Audio Effects: Bus Linking", function() {
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
}
