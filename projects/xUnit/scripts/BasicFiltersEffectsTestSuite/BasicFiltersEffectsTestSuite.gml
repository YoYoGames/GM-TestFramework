

function BasicFiltersEffectsTestSuite() : TestSuite() constructor {

	// FX CREATE TESTS

	addFact("fx_create_test #1", function() {

		var output;

		// ### VALID ###
		
		output = fx_create("_filter_colourise");
		assert_not_equals(output, -1, "fx_create('_filter_colourise'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_colourise'), failed to return correct value type");
		
	});

	addFact("fx_create_test #2", function() {

		var output;

		// ### VALID ###
			
		output = fx_create("_filter_edgedetect");
		assert_not_equals(output, -1, "fx_create('_filter_edgedetect'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_edgedetect'), failed to return correct value type");
		
	});

	addFact("fx_create_test #3", function() {

		var output;

		// ### VALID ###
			
		output = fx_create("_filter_greyscale");
		assert_not_equals(output, -1, "fx_create('_filter_greyscale'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_greyscale'), failed to return correct value type");
		
	});

	addFact("fx_create_test #4", function() {

		var output;

		// ### VALID ###
				
		output = fx_create("_filter_large_blur");
		assert_not_equals(output, -1, "fx_create('_filter_large_blur'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_large_blur'), failed to return correct value type");
		
	});

	addFact("fx_create_test #5", function() {

		var output;

		// ### VALID ###
				
		output = fx_create("_filter_pixelate");
		assert_not_equals(output, -1, "fx_create('_filter_pixelate'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_pixelate'), failed to return correct value type");
		
	});

	addFact("fx_create_test #6", function() {

		var output;

		// ### VALID ###
				
		output = fx_create("_filter_posterise");
		assert_not_equals(output, -1, "fx_create('_filter_posterise'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_posterise'), failed to return correct value type");
		
	});

	addFact("fx_create_test #7", function() {

		var output;

		// ### VALID ###
				
		output = fx_create("_filter_screenshake");
		assert_not_equals(output, -1, "fx_create('_filter_screenshake'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_screenshake'), failed to return correct value type");
		
	});

	addFact("fx_create_test #8", function() {

		var output;

		// ### VALID ###
				
		output = fx_create("_filter_tintfilter");
		assert_not_equals(output, -1, "fx_create('_filter_tintfilter'), failed to create builtin effect");
		assert_typeof(output, "struct", "fx_create('_filter_tintfilter'), failed to return correct value type");
			
	});
	
	// FX GET SET TESTS
		
	addFact("fx_get_set_test #1", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
		
		assert_not_equals(effect, -1, "fx_create('_filter_colourise'), failed to create builtin effect");
		assert_typeof(effect, "struct", "fx_create('_filter_colourise'), failed to return correct value type");
			
	});
		
	addFact("fx_get_set_test #2", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
		
		output = variable_struct_get_names(effect);
		assert_array_empty(output, "variable_struct_get_names(effect), failed to hide the properties");
			
	});
		
	addFact("fx_get_set_test #3", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		output = fx_get_parameter_names(effect);
		assert_typeof(output, "array", "fx_get_parameter_names(effect), failed to return the correct type");
			
	});
		
	addFact("fx_get_set_test #4", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameter(effect, "g_Intensity");
		assert_typeof(output, "number", "fx_get_parameter(effect, param), failed to return the correct type");
			
	});
		
	addFact("fx_get_set_test #5", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameter(effect, "g_Intensity");
		assert_equals(output, 1, "fx_get_parameter(effect, param), failed to return the correct value");
			
	});
		
	addFact("fx_get_set_test #6", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameter(effect, "g_TintCol");
		assert_typeof(output, "array", "fx_get_parameter(effect, param), failed to return the correct type");
			
	});
		
	addFact("fx_get_set_test #7", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameter(effect, "g_TintCol");
		assert_array_equals(output, [1, .5, .2, 1], "fx_get_parameter(effect, param), failed to return the correct value");
			
	});
		
	addFact("fx_get_set_test #8", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameters(effect);
		assert_typeof(output, "struct", "fx_get_parameters(effect), failed to return the correct type");
			
	});
		
	addFact("fx_get_set_test #9", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameters(effect);
		assert_equals(output.g_Intensity, 1, "fx_get_parameters(effect), failed to return the correct data");
			
	});
		
	addFact("fx_get_set_test #10", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameters(effect);
		assert_array_equals(output.g_TintCol, [1, .5, .2, 1], "fx_get_parameters(effect), failed to return the correct data");
			
	});
		
	addFact("fx_get_set_test #11", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// SHOULD NOT WORK
			
		input = .4;
		effect.g_Intensity = input;
		output = fx_get_parameter(effect, "g_Intensity");
		assert_not_equals(output, input, "fx_set_parameter(effect, param), changed real parameter using struct accessor");
			
	});
		
	addFact("fx_get_set_test #12", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// SHOULD NOT WORK
			
		input = [0, 0, 0, .4];
		effect.g_TintCol = input;
		output = fx_get_parameter(effect, "g_TintCol");
		assert_false(array_equals(output, input), "fx_set_parameter(effect, param), changed array parameter using struct accessor");
			
	});
		
	addFact("fx_get_set_test #13", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// SHOULD WORK

		input = .4;
		fx_set_parameter(effect, "g_Intensity", input);
		output = fx_get_parameter(effect, "g_Intensity");
		assert_equals(output, input, "fx_set_parameter(effect, param), failed to set real parameter");
			
	});
		
	addFact("fx_get_set_test #14", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// SHOULD WORK
			
		input = [0, 0, 0, .4];
		fx_set_parameter(effect, "g_TintCol", input);
		output = fx_get_parameter(effect, "g_TintCol");
		assert_array_equals(output, input, "fx_set_parameter(effect, param), failed to set array parameter");
			
	});
		
	addFact("fx_get_set_test #15", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  false
		//

		output = fx_get_single_layer(effect);
		assert_false(output, "fx_get_single_layer(effect), failed to return the correct value");
			
	});
		
	addFact("fx_get_set_test #16", function() {
		
		var effect, input, output;
		effect = fx_create("_filter_colourise");
			
		// ### DEFAULTS ###
		//
		//  false
		//
			
		fx_set_single_layer(effect, true);
		output = fx_get_single_layer(effect);
		assert_true(output, "fx_set_single_layer(effect), failed to set the correct value");

	})
		
}


