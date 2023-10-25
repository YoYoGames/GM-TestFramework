/*

function BasicFiltersEffectsTestSuite() : TestSuite() constructor {

	addFact("fx_create_test", function() {

		var output;

		// ### VALID ###
		
		output = fx_create("_filter_colourise");
		assert_not_equals(output, -1, "#1 fx_create('_filter_colourise'), failed to create builtin effect");
		assert_typeof(output, "struct", "#1.1 fx_create('_filter_colourise'), failed to return correct value type");
			
		output = fx_create("_filter_edgedetect");
		assert_not_equals(output, -1, "#2 fx_create('_filter_edgedetect'), failed to create builtin effect");
		assert_typeof(output, "struct", "#2.1 fx_create('_filter_edgedetect'), failed to return correct value type");
			
		output = fx_create("_filter_greyscale");
		assert_not_equals(output, -1, "#3 fx_create('_filter_greyscale'), failed to create builtin effect");
		assert_typeof(output, "struct", "#3.1 fx_create('_filter_greyscale'), failed to return correct value type");
				
		output = fx_create("_filter_large_blur");
		assert_not_equals(output, -1, "#4 fx_create('_filter_large_blur'), failed to create builtin effect");
		assert_typeof(output, "struct", "#4.1 fx_create('_filter_large_blur'), failed to return correct value type");
				
		output = fx_create("_filter_pixelate");
		assert_not_equals(output, -1, "#5 fx_create('_filter_pixelate'), failed to create builtin effect");
		assert_typeof(output, "struct", "#5.1 fx_create('_filter_pixelate'), failed to return correct value type");
				
		output = fx_create("_filter_posterise");
		assert_not_equals(output, -1, "#6 fx_create('_filter_posterise'), failed to create builtin effect");
		assert_typeof(output, "struct", "#6.1 fx_create('_filter_posterise'), failed to return correct value type");
				
		output = fx_create("_filter_screenshake");
		assert_not_equals(output, -1, "#7 fx_create('_filter_screenshake'), failed to create builtin effect");
		assert_typeof(output, "struct", "#7.1 fx_create('_filter_screenshake'), failed to return correct value type");
				
		output = fx_create("_filter_tintfilter");
		assert_not_equals(output, -1, "#8 fx_create('_filter_tintfilter'), failed to create builtin effect");
		assert_typeof(output, "struct", "#8.1 fx_create('_filter_tintfilter'), failed to return correct value type");
			
	})
		
	addFact("fx_get_set_test", function() {
		
		var effect, input, output;
			
		effect = fx_create("_filter_colourise");
		assert_not_equals(effect, -1, "#1 fx_create('_filter_colourise'), failed to create builtin effect");
		assert_typeof(effect, "struct", "#1.1 fx_create('_filter_colourise'), failed to return correct value type");
		
		output = variable_struct_get_names(effect);
		assert_array_empty(output, "#2 variable_struct_get_names(effect), failed to hide the properties");
			
		output = fx_get_parameter_names(effect);
		assert_typeof(output, "array", "#3 fx_get_parameter_names(effect), failed to return the correct type");
			
		// ### DEFAULTS ###
		//
		//  g_Intensity: 1
		//  g_TintCol: [1, .5, .2, 1]
		//
			
		output = fx_get_parameter(effect, "g_Intensity");
		assert_typeof(output, "number", "#4.1 fx_get_parameter(effect, param), failed to return the correct type");
		assert_equals(output, 1, "#4.1.1 fx_get_parameter(effect, param), failed to return the correct value");
			
		output = fx_get_parameter(effect, "g_TintCol");
		assert_typeof(output, "array", "#4.2 fx_get_parameter(effect, param), failed to return the correct type");
		assert_array_equals(output, [1, .5, .2, 1], "#4.2.1 fx_get_parameter(effect, param), failed to return the correct value");
			
		output = fx_get_parameters(effect);
		assert_typeof(output, "struct", "#4.1 fx_get_parameters(effect), failed to return the correct type");
		assert_equals(output.g_Intensity, 1, "#4.1.1 fx_get_parameters(effect), failed to return the correct data");
		assert_array_equals(output.g_TintCol, [1, .5, .2, 1], "#4.1.1 fx_get_parameters(effect), failed to return the correct data");
			
		// SHOULD NOT WORK
			
		input = .4;
		effect.g_Intensity = input;
		output = fx_get_parameter(effect, "g_Intensity");
		assert_not_equals(output, input, "#5.1 fx_set_parameter(effect, param), changed real parameter using struct accessor");
			
		input = [0, 0, 0, .4];
		effect.g_TintCol = input;
		output = fx_get_parameter(effect, "g_TintCol");
		assert_false(array_equals(output, input), "#5.2 fx_set_parameter(effect, param), changed array parameter using struct accessor");
			
		// SHOULD WORK

		input = .4;
		fx_set_parameter(effect, "g_Intensity", input);
		output = fx_get_parameter(effect, "g_Intensity");
		assert_equals(output, input, "#6.1 fx_set_parameter(effect, param), failed to set real parameter");
			
		input = [0, 0, 0, .4];
		fx_set_parameter(effect, "g_TintCol", input);
		output = fx_get_parameter(effect, "g_TintCol");
		assert_array_equals(output, input, "#6.2 fx_set_parameter(effect, param), failed to set array parameter");
			
		// ### DEFAULTS ###
		//
		//  false
		//

		output = fx_get_single_layer(effect);
		assert_false(output, "#7 fx_get_single_layer(effect), failed to return the correct value");
			
		fx_set_single_layer(effect, true);
		output = fx_get_single_layer(effect);
		assert_true(output, "#7 fx_set_single_layer(effect), failed to set the correct value");

	})
		
}


