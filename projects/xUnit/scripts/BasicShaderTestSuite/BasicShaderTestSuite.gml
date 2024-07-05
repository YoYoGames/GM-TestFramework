#macro SHADER_TEST_DEFAULT_SIZE 64


/// @function pick_shader_for_platform()
/// @description Will determine which shader to use based on the current platform the test is being run on
/// @param {Asset.GMShader} glsl_shader GLSL version of the shader
/// @param {Asset.GMShader} hlsl_shader HLSL version of the shader
/// @param {Asset.GMShader} glsles_shader GLSL ES version of the shader
/// @returns {Asset.GMShader}
function pick_shader_for_platform(_glsl_shader, _hlsl_shader, _glsles_shader) { // PROGRESS STATE - Finished
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
function verify_shader_compiled(_shader) { // PROGRESS STATE - Finished
	// Check that the shader has been compiled
	var _is_compiled = assert_true(shader_is_compiled(_shader), test_current().name + ", failed to compile shader necessary for test");
	if (!_is_compiled)
	{
		// End test early if it hasn't, as the test will not run correctly
		test_end();
	}
}


// Test suite for all basic shader functionality
function BasicShaderTestSuite() : TestSuite() constructor {
	
	addTestAsync("primitive_drawing", objTestAsyncDraw, { // PROGRESS STATE - Finished
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Draw rect
			draw_rect(rect)
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/PrimitiveDrawing/", test_current().name + ", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_is_compiled", objTestAsyncDraw, { // PROGRESS STATE - Finished
		
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
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addFact("shader_get_name", function() { // PROGRESS STATE - Finished
		
		// Check that shader_get_name correctly gets the name of sh_passthrough_glsles
		var _output;
		_output = shader_get_name(sh_passthrough_glsles);
		assert_equals(_output, "sh_passthrough_glsles", test_current().name +", failed to get name of shader" );
	});
	
	addFact("shaders_are_supported", function() { // PROGRESS STATE - Finished
		
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
						assert_string_contains(shader_language, "OpenGL ES")
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
	
	
	addTestAsync("shader_current", objTestAsyncDraw, { // PROGRESS STATE - Finished
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
		},
		ev_draw: function() {
			// Start using shader
			shader_set(test_shader);
				// Test that shader_current() returns the shader we're currently using
				assert_true(shader_current() == test_shader, test_current().name +", failed to get current shader")
			// Stop using shader
			shader_reset();
			
			// End test at end of first draw frame
			test_end();
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("passthrough_shader", objTestAsyncDraw, { // PROGRESS STATE - Finished
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/PassthroughShader/", test_current().name +", shader failed to produce expected result");
			
			// End test at end of first draw frame
			test_end();
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_get/set_uniform_f", objTestAsyncDraw, { // PROGRESS STATE - Finished
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Get color uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle")
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variables to set color uniform with
			var _red = 1;
			var _green = 1;
			var _blue = 1;
			var _alpha = 1;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/SetUniformF/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, make RGB values 0 to make sure they can be modified correctly
				case 1:
					_test_path = "ShaderTests/SetUniformF/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb value";
					_red = 0;
					_green = 0;
					_blue = 0;
					break;
				// On the third frame, make alpha value 0 to make sure it can be modified correctly
				case 2:
					_test_path = "ShaderTests/SetUniformF/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					_alpha = 0;
					break;
				// On the fourth frame, end the test
				case 3:
					test_end();
					break;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				shader_set_uniform_f(uni_color, _red, _green, _blue, _alpha);
				// Draw rect
				draw_rect(rect)
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_f_array", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/SetUniformFArray/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			var _color = [1,1,1,1];
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/SetUniformFArray/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb values";
					_color = [0,0,0,1];
					break;
				case 2:
					_test_path = "ShaderTests/SetUniformFArray/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					_color = [1,1,1,0];
					break;
				case 3:
					test_end();
					break;
			}
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				shader_set_uniform_f_array(uni_color, _color);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_color(rect.left, rect.top, c_white, 1);
				draw_vertex_color(rect.right, rect.top, c_white, 1);
				draw_vertex_color(rect.left, rect.bottom, c_white, 1);
				draw_vertex_color(rect.right, rect.bottom, c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_f_buffer", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_f_array_glsles, sh_uniform_f_array_hlsl, sh_uniform_f_array_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle");
			
			// Create a buffer to store our color value in
			var _values = 4;
			var _size = buffer_sizeof(buffer_f32);
			color_buffer = buffer_create(_values * _size, buffer_fixed, 1);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			buffer_seek(color_buffer, buffer_seek_start, 0);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			buffer_write(color_buffer, buffer_f32, 1);
			var _test_path = "ShaderTests/SetUniformFBuffer/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/SetUniformFBuffer/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb values";
					buffer_seek(color_buffer, buffer_seek_start, 0);
					buffer_write(color_buffer, buffer_f32, 0);
					buffer_write(color_buffer, buffer_f32, 0);
					buffer_write(color_buffer, buffer_f32, 0);
					break;
				case 2:
					_test_path = "ShaderTests/SetUniformFBuffer/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					buffer_seek(color_buffer, buffer_seek_start, 12);
					buffer_write(color_buffer, buffer_f32, 0);
					break;
				case 3:
					test_end();
					break;
			}
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				shader_set_uniform_f_buffer(uni_color, color_buffer, 0, 4);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_color(rect.left, rect.top, c_white, 1);
				draw_vertex_color(rect.right, rect.top, c_white, 1);
				draw_vertex_color(rect.left, rect.bottom, c_white, 1);
				draw_vertex_color(rect.right, rect.bottom, c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_i", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_i_glsles, sh_uniform_i_hlsl, sh_uniform_i_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle")
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _red = 1;
			var _green = 1;
			var _blue = 1;
			var _alpha = 1;
			var _test_path = "ShaderTests/SetUniformI/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/SetUniformI/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb values";
					_red = 0;
					_green = 0;
					_blue = 0;
					break;
				case 2:
					_test_path = "ShaderTests/SetUniformI/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					_alpha = 0;
					break;
				case 3:
					test_end();
					break;
			}
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				shader_set_uniform_i(uni_color, _red, _green, _blue, _alpha);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_color(rect.left, rect.top, c_white, 1);
				draw_vertex_color(rect.right, rect.top, c_white, 1);
				draw_vertex_color(rect.left, rect.bottom, c_white, 1);
				draw_vertex_color(rect.right, rect.bottom, c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("shader_set_uniform_i_array", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_i_array_glsles, sh_uniform_i_array_hlsl, sh_uniform_i_array_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/SetUniformIArray/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			var _color = [1,1,1,1];
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/SetUniformIArray/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb values";
					_color = [0,0,0,1];
					break;
				case 2:
					_test_path = "ShaderTests/SetUniformIArray/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					_color = [1,1,1,0];
					break;
				case 3:
					test_end();
					break;
			}
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				shader_set_uniform_i_array(uni_color, _color);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_color(rect.left, rect.top, c_white, 1);
				draw_vertex_color(rect.right, rect.top, c_white, 1);
				draw_vertex_color(rect.left, rect.bottom, c_white, 1);
				draw_vertex_color(rect.right, rect.bottom, c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("shader_get_sampler_index", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_sampler_glsles, sh_sampler_hlsl, sh_sampler_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get uniform handle
			sampler = shader_get_sampler_index(test_shader, "sample");
			assert_typeof(sampler, "number", test_current().name +", failed to get a valid uniform handle");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/GetSamplerIndex/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			// set texture to use with sampler
			var _texture = sprite_get_texture(sprCircle, 0);
			var _uvs = sprite_get_uvs(sprCircle, 0);
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/GetSamplerIndex/SetTexture";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing texture";
					_texture = sprite_get_texture(sprSquare, 0);
					_uvs = sprite_get_uvs(sprSquare, 0);
					break;
				case 2:
					test_end();
					break;
			}
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			// Set the uniform
				texture_set_stage(sampler, _texture);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_texture_color(rect.left, rect.top, _uvs[0], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.top, _uvs[2], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.left, rect.bottom, _uvs[0], _uvs[3], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.bottom, _uvs[2], _uvs[3], c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_matrix", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE*1.5, SHADER_TEST_DEFAULT_SIZE*1.5);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get sampler uniform handle
			sampler = shader_get_sampler_index(test_shader, "sample");
			assert_typeof(sampler, "number", test_current().name +", failed to get a valid uniform handle");
			// Get matrix uniform handle
			shader_matrix = shader_get_uniform(test_shader, "u_vMatrix");
			assert_typeof(shader_matrix, "number", test_current().name +", failed to get a valid uniform handle");
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/SetUniformMatrix/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			// Get texture to use with sampler
			var _texture = sprite_get_texture(sprCircle, 0);
			// Get texture UVs
			var _uvs = sprite_get_uvs(sprCircle, 0);
			// Build a matrix to scale everything by x2
			var _matrix = matrix_build(0,0,0,0,0,0,2,2,2);
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 2, SHADER_TEST_DEFAULT_SIZE * 2);
			
			// Start using shader
			shader_set(test_shader);
				// Set the texture uniform
				texture_set_stage(sampler, _texture);
				// Set the matrix uniform
				matrix_set(matrix_world, _matrix);
				shader_set_uniform_matrix(shader_matrix);
				matrix_set(matrix_world, matrix_build_identity());
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_texture_color(rect.left, rect.top, _uvs[0], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.top, _uvs[2], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.left, rect.bottom, _uvs[0], _uvs[3], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.bottom, _uvs[2], _uvs[3], c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			test_end();
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_matrix_array", objTestAsyncDraw, { // PROGRESS STATE - Needscomments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE*1.5, SHADER_TEST_DEFAULT_SIZE*1.5);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_matrix_glsles, sh_uniform_matrix_hlsl, sh_uniform_matrix_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Get sampler uniform handle
			sampler = shader_get_sampler_index(test_shader, "sample");
			assert_typeof(sampler, "number", test_current().name +", failed to get a valid uniform handle");
			// Get matrix uniform handle
			shader_matrix = shader_get_uniform(test_shader, "u_vMatrix");
			assert_typeof(shader_matrix, "number", test_current().name +", failed to get a valid uniform handle");
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/SetUniformMatrixArray/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			// Get texture to use with sampler
			var _texture = sprite_get_texture(sprCircle, 0);
			// Get texture UVs
			var _uvs = sprite_get_uvs(sprCircle, 0);
			// Build a matrix to scale everything by x2
			var _matrix = matrix_build(0,0,0,0,0,0,2,2,2);
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 2, SHADER_TEST_DEFAULT_SIZE * 2);
			
			// Start using shader
			shader_set(test_shader);
				// Set the texture uniform
				texture_set_stage(sampler, _texture);
				// Set the matrix uniform
				shader_set_uniform_matrix_array(shader_matrix, _matrix);
				// Draw rect
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex_texture_color(rect.left, rect.top, _uvs[0], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.top, _uvs[2], _uvs[1], c_white, 1);
				draw_vertex_texture_color(rect.left, rect.bottom, _uvs[0], _uvs[3], c_white, 1);
				draw_vertex_texture_color(rect.right, rect.bottom, _uvs[2], _uvs[3], c_white, 1);
				draw_primitive_end();
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			test_end();
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_enable_corner_id", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_enable_corner_id_glsles, sh_enable_corner_id_hlsl, sh_enable_corner_id_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			shader_enable_corner_id(true);
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/EnableCornerID/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				draw_sprite(sprSquare, 0, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2)
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			test_end();
			
		},
		ev_cleanup: function() {
			shader_enable_corner_id(false);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_frag_coord/sv_position", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, window_get_width(), window_get_height());
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_frag_coord_glsles, sh_sv_position_hlsl, sh_frag_coord_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			u_resolution = shader_get_uniform(test_shader, "u_resolution");
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FragCoord/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
				
				shader_set_uniform_f(u_resolution, window_get_width(), window_get_height());
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			test_end();
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_max_draw_buffers", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_draw_buffers_glsles, undefined, sh_max_draw_buffers_glsles);
			
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MaxDrawBuffers/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			
			// Start using shader
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			test_end();
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000,
		// gl_max_draw_buffers is only present in glsl, so no need to do this test on platforms that use hlsl
		test_filter: platform_windows,
		test_filter: platform_console
	});
	
	addTestAsync("gl_frag_data/sv_target", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_sv_target_hlsl, sh_frag_data_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[1] = start_draw_comparison_ext(1, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[2] = start_draw_comparison_ext(2, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			_test_surfaces[3] = start_draw_comparison_ext(3, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			
			// Start using shader
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison_ext(_test_surfaces, _test_path, _test_fail_message);
			
			test_end();
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});

	addTestAsync("3d_rendering", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl,  sh_passthrough_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate cube data to draw
			cube_mesh = generate_cube();
			// Generate 3D camera, positioned to see the cube
			camera = generate_3d_camera();
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/3DRendering/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
			
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);
				
				camera_apply(camera)
				draw_clear_alpha(c_black, 0)
				
				vertex_submit(cube_mesh, pr_trianglelist, -1);
				
				gpu_set_zwriteenable(false);
				gpu_set_ztestenable(false);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
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
	
	addTestAsync("normals_test", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_normals_glsles, sh_normals_hlsl,  sh_normals_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate cube data to draw
			cube_mesh = generate_cube();
			// Generate 3D camera, positioned to see the cube
			camera = generate_3d_camera();
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/NormalsTest/";
			
			var _test_prefix = "Angle1";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison at camera angle 1";
			
			switch (draw_frame)
			{
				case 1:
					// Set prefix and fail message for 2nd part of the test
					_test_prefix = "Angle2";
					_test_fail_message = test_current().name + ", failed draw buffer comparison at camera angle 2";
					
					// destroy current camera and generate a new one viewing the cube from the opposite direction
					camera_destroy(camera);
					camera = generate_3d_camera(new Vector3(200, 200, 300));
					break;
				case 2:
					// End test and return to avoid any further code being run
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
			
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);
				
				camera_apply(camera)
				draw_clear_alpha(c_black, 0)
			
				vertex_submit(cube_mesh, pr_trianglelist, -1);
				
				gpu_set_zwriteenable(false);
				gpu_set_ztestenable(false);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(cube_mesh)
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_front_facing/sv_is_front_face", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_front_facing_glsles, sh_is_front_face_hlsl,  sh_front_facing_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate cube data to draw
			plane_mesh = generate_plane();
			// Generate 3D camera, positioned to see the cube
			camera = generate_3d_camera();
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FrontFacing/";
			
			var _test_prefix = "Angle1";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			switch (draw_frame)
			{
				case 1:
					// Set prefix and fail message for 2nd part of the test
					_test_prefix = "Angle2";
					_test_fail_message = test_current().name + ", failed draw buffer comparison at camera angle 2";
					
					// destroy current camera and generate a new one viewing the cube from the opposite direction
					camera_destroy(camera);
					camera = generate_3d_camera(new Vector3(200, 200, 300));
					break;
				case 2:
					// End test and return to avoid any further code being run
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
			
				gpu_set_zwriteenable(true);
				gpu_set_ztestenable(true);
				
				camera_apply(camera)
				draw_clear_alpha(c_black, 0)
				
				vertex_submit(plane_mesh, pr_trianglelist, -1);
				
				gpu_set_zwriteenable(false);
				gpu_set_ztestenable(false);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			camera_destroy(camera);
			vertex_delete_buffer(plane_mesh)
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});

}