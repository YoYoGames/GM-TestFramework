#macro SHADER_TEST_DEFAULT_SIZE 64


/// @function pick_shader_for_platform()
/// @description Will determine which shader to use based on the current platform the test is being run on
/// @param {Asset.GMShader} glsl_shader GLSL version of the shader
/// @param {Asset.GMShader} hlsl_shader HLSL version of the shader
/// @param {Asset.GMShader} glsles_shader GLSL ES version of the shader
/// @returns {Asset.GMShader}
function pick_shader_for_platform(_glsl_shader, _hlsl_shader, _glsles_shader) {
	// If OS is linux or mac, return the GLSL shader
	if(os_type == os_linux || os_type == os_macosx){
		return _glsl_shader;
	}
	// If OS is windows or xbox, return the HLSL shader
	else if(os_type == os_uwp || os_type == os_windows || os_type == os_xboxone){
		return _hlsl_shader;
	}
	// If OS is anything else, return the GLSLES shader
	else {
		return _glsles_shader;
	}
}

/// @function verify_shader_compiled()
/// @description Utility function to Assert and ends the current test early if the shader has not been compiled 
/// @param {Asset.GMShader} shader Shader to check
function verify_shader_compiled(_shader) {
	// Check that the shader has been compiled
	var _is_compiled = assert_true(shader_is_compiled(_shader), test_current().name + ", failed to compile shader necessary for test");
	if (!_is_compiled)
	{
		// End test early if it hasn't, as the test will not run correctly
		test_end();
	}
}

/// @function compare_render_target(surface, test_path, target_index, fail_message)
/// @description Compares a single render target surface (one of several produced by a multi-target draw) against its own indexed expected image. Mirrors end_draw_comparison_ext()'s per-surface logic, but for exactly one target at a time, so that a multi-target draw can report one result per target. Should only be called after start_draw_comparison_ext() has been called for every target and the draw has finished.
/// @param {Id.Surface} surface The surface to compare (this function frees it)
/// @param {String} test_path The shared test path prefix (e.g. "ShaderTests/FragData/")
/// @param {Real} target_index Which render target this surface corresponds to (used to find "...ExpectedN.png")
/// @param {String} fail_message The message to be shown in the assert if the test fails
/// @return {Bool} True if the comparison passed
function compare_render_target(_surface, _test_path, _target_index, _fail_message) {

	var _result = true;

	if (!surface_exists(_surface))
	{
		_result = assert_true(false, test_current().name + ", non-existant test surface in compare_render_target()");
		return _result;
	}

	// Save the surface to a .png file (for manual checking)
	var _path_surface = game_save_id + _test_path + "Result" + string(_target_index) + ".png";
	surface_save(_surface, _path_surface);
	log_debug("Saving " + _path_surface);

	// Make a temporary sprite out of the surface so we can use our function for comparing sprites
	var _test_sprite = sprite_create_from_surface(
		_surface, 0, 0,
		surface_get_width(_surface), surface_get_height(_surface),
		false, false, 0, 0);

	// Check that an expected sprite exists for this render target
	var _expected_fname = _test_path + "Expected" + string(_target_index) + ".png";

	if (file_exists(_expected_fname))
	{
		var _expected_sprite = sprite_add(_expected_fname, 1, false, false, 0, 0);
		if (!assert_sprite_equals(_test_sprite, _expected_sprite, 0.5, _fail_message)) // Allow for 0.5% error
		{
			_result = false;
		}
		sprite_delete(_expected_sprite);
	}
	else
	{
		_result = assert_true(false, test_current().name + ", failed to find expected sprite file (should be at xUnit/datafiles/" + _expected_fname + ")");
	}

	sprite_delete(_test_sprite);
	surface_free(_surface);
	return _result;
}


// Test suite for all basic shader functionality
function BasicShaderTestSuite() : TestSuite() constructor {
	
	addTestAsync("primitive_drawing", objTestAsyncDraw, {
		
		ev_create: function() {
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Draw rectangle
			draw_rect(rect);
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/PrimitiveDrawing/", test_current().name + ", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_is_compiled", objTestAsyncDraw, {
		
		ev_create: function() {
			// Create array to store whether or not shaders have been compiled
			shaders = [];
			// Get references to all shaders in the project
			var _shaders = asset_get_ids(asset_shader);
			var _shader_count = array_length(_shaders);
			array_resize(shaders, _shader_count)
			// For each shader..
			for (i = 0; i < _shader_count; i++)
			{
				// Check if it has been compiled
				var _is_compiled = shader_is_compiled(_shaders[i]);
				// Store a struct with a reference to the shader and whether or not it has been compiled in the array
				shaders[i] = {
					reference : _shaders[i],
					is_compiled : _is_compiled
				}
				//show_debug_message(shaders[i]); // Uncomment this to check which shaders have and haven't been considered compiled by shader_is_compiled()
			}
		},
		ev_draw: function() {
			// For each stored shader..
			for (i = 0; i < array_length(shaders); i++)
			{
				// Store a function that sets it as currently being used
				var _shader_set_func = function() {
				shader_set(shaders[i].reference)
				}
				// If it is considered compiled..
				if (shaders[i].is_compiled)
				{
					// Check that the function doesn't throw an exception when set, confirming that it has been compiled
					var _success = assert_not_throws(_shader_set_func, test_current().name + ", shader " + shader_get_name(shaders[i].reference) + " was considered compiled but is unable to be set");
				}
				else
				{
					// Check that the function throws an exception when set, confirming that it has not been compiled
					var _success = assert_throw(_shader_set_func, test_current().name + ", shader " + shader_get_name(shaders[i].reference) + " was considered not compiled but is able to be set");
				}
				if (_success)
				{
					// Make sure to reset shader again afterwards if set
					shader_reset();
				}
			}
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addFact("shader_get_name", function() {
		
		// Check that shader_get_name correctly gets the name of sh_passthrough_glsles
		var _output;
		_output = shader_get_name(sh_passthrough_glsles);
		assert_equals(_output, "sh_passthrough_glsles", test_current().name +", failed to get name of shader" );
	});
	
	addFact("shaders_are_supported", function() {
		
		var _output;
		_output = shaders_are_supported();
		
		// If the function detects the current platform as not supporting shaders..
		if (_output == false)
		{
			// If the current platform is a browser (uses HTML5)..
			if (os_browser != browser_not_a_browser)
			{
				// Check that WebGL is disabled (because only non-WebGL HTML builds should lack shader support)
				assert_false(webgl_enabled, test_current().name +", failed to detect lack of shader support on non-WebGL HTML5 build");
			}
			// If the current platform is android..
			else if (os_type == os_android)
			{
				// Get OS info map
				var _info = os_get_info()
				// If info map contains an entry with information about the platform's supported shader language..
				if (ds_map_exists(_info, "GL_SHADING_LANGUAGE_VERSION"))
				{
					// If the shader language entry has a valid value (not undefined or empty string)
					shader_language = _info[? "GL_SHADING_LANGUAGE_VERSION"];
					if (!is_undefined(shader_language) && shader_language != "")
					{
						// Check that the shader language name doesn't have "GLSL ES" in it (because if it uses any version of GLSL ES then shaders should be supported)
						assert_string_contains(shader_language, "OpenGL ES");
					}
				}
				ds_map_destroy(_info);
			}
		}
		
		// If the current platform is a browser (uses HTML5)..
		if (os_browser != browser_not_a_browser)
		{
			// And if WebGL is disabled..
			if (!webgl_enabled)
			{
				// Shaders should not be supported
				assert_false(_output, test_current().name +", failed to detect lack of shader support on non-WebGL HTML5 build");
				return;
			}
		}

	});
	
	
	addTestAsync("shader_current", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
		},
		ev_draw: function() {
			// Start using shader
			shader_set(test_shader);
				// Test that shader_current() returns the shader we're currently using
				assert_true(shader_current() == test_shader, test_current().name +", failed to get current shader");
			// Stop using shader
			shader_reset();
			
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("passthrough_shader", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/PassthroughShader/", test_current().name +", shader failed to produce expected result");
			
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	

	// FLOAT UNIFORM TESTS

	addFact("shader_get/set_uniform_f: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsl);
		verify_shader_compiled(_test_shader);

		var _uni_color = shader_get_uniform(_test_shader, "colorPS");
		assert_greater_or_equal(_uni_color, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_get/set_uniform_f #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "colorPS");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			draw_clear(c_black);
			gpu_push_state();
			gpu_set_blendenable(false);
			shader_set(test_shader);
				shader_set_uniform_f(uni_color, 1, 1, 1, 1);
				draw_rect(rect);
			gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformF/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_get/set_uniform_f #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "colorPS");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			draw_clear(c_black);
			gpu_push_state();
			gpu_set_blendenable(false);
			shader_set(test_shader);
				// Make RGB values 0 to make sure they can be modified correctly
				shader_set_uniform_f(uni_color, 0, 0, 0, 1);
				draw_rect(rect);
			gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformF/SetRGB", test_current().name + ", failed draw buffer comparison after changing rgb value");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_get/set_uniform_f #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "colorPS");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			draw_clear(c_black);
			gpu_push_state();
			gpu_set_blendenable(false);
			shader_set(test_shader);
				// Make alpha value 0 to make sure it can be modified correctly
				shader_set_uniform_f(uni_color, 0, 0, 0, 0);
				draw_rect(rect);
			gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformF/SetAlpha", test_current().name + ", failed draw buffer comparison after changing alpha value");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addFact("shader_set_uniform_f_array: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
		verify_shader_compiled(_test_shader);

		var _uni_color = shader_get_uniform(_test_shader, "color");
		assert_greater_or_equal(_uni_color, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_f_array #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_f_array(uni_color, [1, 1, 1, 1]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFArray/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_f_array #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make RGB values 0 to make sure they can be modified correctly
				shader_set_uniform_f_array(uni_color, [0, 0, 0, 1]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFArray/SetRGB", test_current().name + ", failed draw buffer comparison after changing rgb values");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_f_array #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make alpha value 0 to make sure it can be modified correctly
				shader_set_uniform_f_array(uni_color, [1, 1, 1, 0]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFArray/SetAlpha", test_current().name + ", failed draw buffer comparison after changing alpha value");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addFact("shader_set_uniform_f_buffer: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
		verify_shader_compiled(_test_shader);

		var _uni_color = shader_get_uniform(_test_shader, "color");
		assert_greater_or_equal(_uni_color, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_f_buffer #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");

			color_buffer = buffer_create(4 * buffer_sizeof(buffer_f32), buffer_fixed, 1);
		},
		ev_draw: function() {
			buffer_seek(color_buffer, buffer_seek_start, 0);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_f_buffer(uni_color, color_buffer, 0, 4);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFBuffer/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		},
		ev_cleanup: function() {
			buffer_delete(color_buffer);
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_f_buffer #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");

			color_buffer = buffer_create(4 * buffer_sizeof(buffer_f32), buffer_fixed, 1);
		},
		ev_draw: function() {
			// Make RGB values 0 to make sure they can be modified correctly
			buffer_seek(color_buffer, buffer_seek_start, 0);
			buffer_write(color_buffer, buffer_f32, 0);
			buffer_write(color_buffer, buffer_f32, 0);
			buffer_write(color_buffer, buffer_f32, 0);
			buffer_write(color_buffer, buffer_f32, 1);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_f_buffer(uni_color, color_buffer, 0, 4);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFBuffer/SetRGB", test_current().name + ", failed draw buffer comparison after changing rgb values");

			test_end();
		},
		ev_cleanup: function() {
			buffer_delete(color_buffer);
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_f_buffer #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");

			color_buffer = buffer_create(4 * buffer_sizeof(buffer_f32), buffer_fixed, 1);
		},
		ev_draw: function() {
			// Make alpha value 0 to make sure it can be modified correctly
			buffer_seek(color_buffer, buffer_seek_start, 0);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 0);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_f_buffer(uni_color, color_buffer, 0, 4);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformFBuffer/SetAlpha", test_current().name + ", failed draw buffer comparison after changing alpha value");

			test_end();
		},
		ev_cleanup: function() {
			buffer_delete(color_buffer);
		}
	},
	{
		test_timeout_millis: 3000
	});

	// INT UNIFORM TESTS

	addFact("shader_set_uniform_i: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_i_glsles, sh_uniform_i_hlsl, sh_uniform_i_glsl);
		verify_shader_compiled(_test_shader);

		var _uni_color = shader_get_uniform(_test_shader, "color");
		assert_greater_or_equal(_uni_color, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_i #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_glsles, sh_uniform_i_hlsl, sh_uniform_i_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_i(uni_color, 1, 1, 1, 1);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformI/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_i #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_glsles, sh_uniform_i_hlsl, sh_uniform_i_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make RGB values 0 to make sure they can be modified correctly
				shader_set_uniform_i(uni_color, 0, 0, 0, 1);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformI/SetRGB", test_current().name + ", failed draw buffer comparison after changing rgb values");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_i #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_glsles, sh_uniform_i_hlsl, sh_uniform_i_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make alpha value 0 to make sure it can be modified correctly
				shader_set_uniform_i(uni_color, 1, 1, 1, 0);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformI/SetAlpha", test_current().name + ", failed draw buffer comparison after changing alpha value");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addFact("shader_set_uniform_i_array: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_i_array_glsles, sh_uniform_i_array_hlsl, sh_uniform_i_array_glsl);
		verify_shader_compiled(_test_shader);

		var _uni_color = shader_get_uniform(_test_shader, "color");
		assert_greater_or_equal(_uni_color, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_i_array #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_array_glsles, sh_uniform_i_array_hlsl, sh_uniform_i_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				shader_set_uniform_i_array(uni_color, [1, 1, 1, 1]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformIArray/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_i_array #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_array_glsles, sh_uniform_i_array_hlsl, sh_uniform_i_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make RGB values 0 to make sure they can be modified correctly
				shader_set_uniform_i_array(uni_color, [0, 0, 0, 1]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformIArray/SetRGB", test_current().name + ", failed draw buffer comparison after changing rgb values");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_set_uniform_i_array #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_i_array_glsles, sh_uniform_i_array_hlsl, sh_uniform_i_array_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			uni_color = shader_get_uniform(test_shader, "color");
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				// Make alpha value 0 to make sure it can be modified correctly
				shader_set_uniform_i_array(uni_color, [1, 1, 1, 0]);
				draw_rect(rect);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformIArray/SetAlpha", test_current().name + ", failed draw buffer comparison after changing alpha value");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	// SAMPLER TESTS

	addFact("shader_get_sampler_index: Get Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_sampler_glsles, sh_sampler_hlsl, sh_sampler_glsl);
		verify_shader_compiled(_test_shader);

		var _sampler = shader_get_sampler_index(_test_shader, "u_samplePS");
		assert_greater_or_equal(_sampler, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_get_sampler_index #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_sampler_glsles, sh_sampler_hlsl, sh_sampler_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			sampler = shader_get_sampler_index(test_shader, "u_samplePS");
		},
		ev_draw: function() {
			var _texture = sprite_get_texture(sprCircle, 0);
			var _uvs = sprite_get_uvs(sprCircle, 0);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				texture_set_stage(sampler, _texture);
				draw_texture_rect(rect, _uvs);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/GetSamplerIndex/Control", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_get_sampler_index #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_sampler_glsles, sh_sampler_hlsl, sh_sampler_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			sampler = shader_get_sampler_index(test_shader, "u_samplePS");
		},
		ev_draw: function() {
			var _texture = sprite_get_texture(sprSquare, 0);
			var _uvs = sprite_get_uvs(sprSquare, 0);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				gpu_push_state();
				gpu_set_blendenable(false);
				texture_set_stage(sampler, _texture);
				draw_texture_rect(rect, _uvs);
				gpu_pop_state();
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/GetSamplerIndex/SetTexture", test_current().name + ", failed draw buffer comparison after changing texture");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	// MATRIX UNIFORM TESTS

	addFact("shader_set_uniform_matrix: Get Sampler Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
		verify_shader_compiled(_test_shader);

		var _sampler = shader_get_sampler_index(_test_shader, "sample");
		assert_greater_or_equal(_sampler, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addFact("shader_set_uniform_matrix: Get Matrix Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
		verify_shader_compiled(_test_shader);

		var _shader_matrix = shader_get_uniform(_test_shader, "u_Matrix");
		assert_greater_or_equal(_shader_matrix, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_matrix", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(SHADER_TEST_DEFAULT_SIZE / 2, SHADER_TEST_DEFAULT_SIZE / 2, SHADER_TEST_DEFAULT_SIZE * 1.5, SHADER_TEST_DEFAULT_SIZE * 1.5);

			sampler = shader_get_sampler_index(test_shader, "sample");
			shader_matrix = shader_get_uniform(test_shader, "u_Matrix");
		},
		ev_draw: function() {
			var _texture = sprite_get_texture(sprCircle, 0);
			var _uvs = sprite_get_uvs(sprCircle, 0);
			var _matrix = matrix_build(0, 0, 0, 0, 0, 0, 2, 2, 2);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 2, SHADER_TEST_DEFAULT_SIZE * 2);

			shader_set(test_shader);
				texture_set_stage(sampler, _texture);
				matrix_set(matrix_world, _matrix);
				shader_set_uniform_matrix(shader_matrix);
				matrix_set(matrix_world, matrix_build_identity());
				draw_texture_rect(rect, _uvs);
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformMatrix/", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addFact("shader_set_uniform_matrix_array: Get Sampler Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
		verify_shader_compiled(_test_shader);

		var _sampler = shader_get_sampler_index(_test_shader, "sample");
		assert_greater_or_equal(_sampler, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addFact("shader_set_uniform_matrix_array: Get Matrix Uniform Handle", function() {
		var _test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
		verify_shader_compiled(_test_shader);

		var _shader_matrix = shader_get_uniform(_test_shader, "u_Matrix");
		assert_greater_or_equal(_shader_matrix, 0, test_current().name + ", failed to get a valid uniform handle");
	});

	addTestAsync("shader_set_uniform_matrix_array", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(SHADER_TEST_DEFAULT_SIZE / 2, SHADER_TEST_DEFAULT_SIZE / 2, SHADER_TEST_DEFAULT_SIZE * 1.5, SHADER_TEST_DEFAULT_SIZE * 1.5);

			sampler = shader_get_sampler_index(test_shader, "sample");
			shader_matrix = shader_get_uniform(test_shader, "u_Matrix");
		},
		ev_draw: function() {
			var _texture = sprite_get_texture(sprCircle, 0);
			var _uvs = sprite_get_uvs(sprCircle, 0);
			var _matrix = matrix_build(0, 0, 0, 0, 0, 0, 2, 2, 2);

			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 2, SHADER_TEST_DEFAULT_SIZE * 2);

			shader_set(test_shader);
				texture_set_stage(sampler, _texture);
				shader_set_uniform_matrix_array(shader_matrix, _matrix);
				draw_texture_rect(rect, _uvs);
			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/SetUniformMatrixArray/", test_current().name + ", failed draw buffer comparison");

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("shader_enable_corner_id", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_enable_corner_id_glsles, sh_enable_corner_id_hlsl, sh_enable_corner_id_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Enable shader corner ids
			shader_enable_corner_id(true);
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/EnableCornerID/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw a sprite (a sprite is used instead of a rectangle because drawn primitives can't have corner ids)
				draw_sprite(sprSquare, 0, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2)
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// End test at end of first draw frame
			test_end();
		},
		ev_cleanup: function() {
			// Disable shader corner ids once the test is done
			shader_enable_corner_id(false);
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_frag_coord/sv_position", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_frag_coord_glsles, sh_sv_position_hlsl, sh_frag_coord_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw, filling the window
			rect = new Rect(0, 0, 256, 256);
			
			// Get window resolution uniform handle
			u_resolution = shader_get_uniform(test_shader, "u_resolutionPS");
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/FragCoord/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader
			shader_set(test_shader);
				// Set the resolution uniform
				shader_set_uniform_f(u_resolution, rect.right, rect.bottom);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_max_draw_buffers", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_draw_buffers_glsles, undefined, sh_max_draw_buffers_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/MaxDrawBuffers/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// End test at end of first draw frame
			test_end();
			
		}	
	},
	{ 
		test_timeout_millis: 3000,
		// gl_max_draw_buffers is only present in glsl, so no need to do this test on platforms that use hlsl
		test_filter: platform_windows,
		test_filter: platform_console
	});

	addTestAsync("gl_frag_data/sv_target #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_sv_target_hlsl, sh_frag_data_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";

			// Start draw buffer comparisons for 4 surfaces, testing drawing to multiple render targets at once
			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[1] = start_draw_comparison_ext(1, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[2] = start_draw_comparison_ext(2, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[3] = start_draw_comparison_ext(3, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();

			surface_reset_target();

			// Only check render target 0 here - the other targets are checked by the sibling facts below
			compare_render_target(_test_surfaces[0], _test_path, 0, _test_fail_message);
			surface_free(_test_surfaces[1]);
			surface_free(_test_surfaces[2]);
			surface_free(_test_surfaces[3]);

			// End test at end of first draw frame
			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("gl_frag_data/sv_target #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_sv_target_hlsl, sh_frag_data_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";

			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[1] = start_draw_comparison_ext(1, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[2] = start_draw_comparison_ext(2, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[3] = start_draw_comparison_ext(3, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				draw_rect(rect);
			shader_reset();

			surface_reset_target();

			// Only check render target 1 here - the other targets are checked by the sibling facts
			surface_free(_test_surfaces[0]);
			compare_render_target(_test_surfaces[1], _test_path, 1, _test_fail_message);
			surface_free(_test_surfaces[2]);
			surface_free(_test_surfaces[3]);

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("gl_frag_data/sv_target #3", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_sv_target_hlsl, sh_frag_data_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";

			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[1] = start_draw_comparison_ext(1, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[2] = start_draw_comparison_ext(2, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[3] = start_draw_comparison_ext(3, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				draw_rect(rect);
			shader_reset();

			surface_reset_target();

			// Only check render target 2 here - the other targets are checked by the sibling facts
			surface_free(_test_surfaces[0]);
			surface_free(_test_surfaces[1]);
			compare_render_target(_test_surfaces[2], _test_path, 2, _test_fail_message);
			surface_free(_test_surfaces[3]);

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("gl_frag_data/sv_target #4", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_sv_target_hlsl, sh_frag_data_glsl);
			verify_shader_compiled(test_shader);

			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";

			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[1] = start_draw_comparison_ext(1, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[2] = start_draw_comparison_ext(2, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[3] = start_draw_comparison_ext(3, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);

			shader_set(test_shader);
				draw_rect(rect);
			shader_reset();

			surface_reset_target();

			// Only check render target 3 here - the other targets are checked by the sibling facts
			surface_free(_test_surfaces[0]);
			surface_free(_test_surfaces[1]);
			surface_free(_test_surfaces[2]);
			compare_render_target(_test_surfaces[3], _test_path, 3, _test_fail_message);

			test_end();
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("3d_rendering", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsl);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate cube data to draw
			cube_mesh = generate_cube();
			// Generate 3D camera, positioned to see the cube
			camera = generate_3d_camera();
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/3DRendering/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
				
				// Enable Z writing and testing for 3D rendering
				gpu_push_state();
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);
				
				// Apply camera settings and clear the surface
				camera_apply(camera)
				draw_clear_alpha(c_black, 0)
				
				// Draw cube
				vertex_submit(cube_mesh, pr_trianglelist, -1);
				
				// Restore Z writing and testing
				gpu_pop_state();
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// End test at end of first draw frame
			test_end();
		},
		ev_cleanup: function() {
			//Distroy camera and cube mesh buffer once the test is done
			camera_destroy(camera);
			vertex_delete_buffer(cube_mesh);
		}
	},
	{ 
		test_timeout_millis: 3000
	});

	addTestAsync("normals_test #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_normals_glsles, sh_normals_hlsl, sh_normals_glsl);
			verify_shader_compiled(test_shader);

			cube_mesh = generate_cube();
			camera = generate_3d_camera();
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison();

			shader_set(test_shader);

				gpu_push_state();
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);

				camera_apply(camera)
				draw_clear_alpha(c_black, 0)

				vertex_submit(cube_mesh, pr_trianglelist, -1);

				gpu_pop_state();

			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/NormalsTest/Angle1", test_current().name + ", failed draw buffer comparison at camera angle 1");

			test_end();
		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(cube_mesh)
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("normals_test #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_normals_glsles, sh_normals_hlsl, sh_normals_glsl);
			verify_shader_compiled(test_shader);

			cube_mesh = generate_cube();
			camera = generate_3d_camera(200, 200, 300);
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison();

			shader_set(test_shader);

				gpu_push_state();
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);

				camera_apply(camera)
				draw_clear_alpha(c_black, 0)

				vertex_submit(cube_mesh, pr_trianglelist, -1);

				gpu_pop_state();

			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/NormalsTest/Angle2", test_current().name + ", failed draw buffer comparison at camera angle 2");

			test_end();
		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(cube_mesh)
		}
	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("gl_front_facing/sv_is_front_face #1", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_front_facing_glsles, sh_is_front_face_hlsl, sh_front_facing_glsl);
			verify_shader_compiled(test_shader);

			plane_mesh = generate_plane();
			camera = generate_3d_camera();
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison();

			shader_set(test_shader);

				gpu_push_state();
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);

				camera_apply(camera)
				draw_clear_alpha(c_black, 0)

				vertex_submit(plane_mesh, pr_trianglelist, -1);

				gpu_pop_state();

			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/FrontFacing/Angle1", test_current().name +", failed draw buffer comparison");

			test_end();

		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(plane_mesh);
		}

	},
	{
		test_timeout_millis: 3000
	});

	addTestAsync("gl_front_facing/sv_is_front_face #2", objTestAsyncDraw, {

		ev_create: function() {
			test_shader = pick_shader_for_platform(sh_front_facing_glsles, sh_is_front_face_hlsl, sh_front_facing_glsl);
			verify_shader_compiled(test_shader);

			plane_mesh = generate_plane();
			camera = generate_3d_camera(200, 200, 300);
		},
		ev_draw: function() {
			var _test_surface = start_draw_comparison();

			shader_set(test_shader);

				gpu_push_state();
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);

				camera_apply(camera)
				draw_clear_alpha(c_black, 0)

				vertex_submit(plane_mesh, pr_trianglelist, -1);

				gpu_pop_state();

			shader_reset();

			end_draw_comparison(_test_surface, "ShaderTests/FrontFacing/Angle2", test_current().name + ", failed draw buffer comparison at camera angle 2");

			test_end();

		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(plane_mesh);
		}

	},
	{
		test_timeout_millis: 3000
	});

}
