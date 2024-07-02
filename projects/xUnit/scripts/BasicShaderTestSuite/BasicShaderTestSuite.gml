// Utility function for picking which shader to use based on the current platform the test is being run on
function pick_shader_for_platform(_glsl_shader, _hlsl_shader, _glsles_shader) { // PROGRESS STATE - Needs function description stuff (also maybe make this test for multiple shaders where compatible?)
	// If OS is linux or mac, return the GLSL shader
	if(os_type == os_linux || os_type == os_macosx){
		return _glsl_shader;
	}
	// If OS is windows or xbox, return the HLSL shader
	//else if(os_type == os_uwp || os_type == os_windows || os_type == os_xboxone){
	//	return _hlsl_shader;
	//}
	// If OS is anything else, return the GLSLES shader
	else {
		return _glsles_shader;
	}
}

// Asserts and ends the current test early if the shader has not been compiled 
function verify_shader_compiled(_shader) { // PROGRESS STATE - Needs function description stuff
	// Check that the shader has been compiled
	var _is_compiled = assert_true(shader_is_compiled(_shader), test_current().name + ", failed to compile shader necessary for test");
	if (!_is_compiled)
	{
		// End test early if it hasn't, as the test will not run correctly
		test_end();
	}
}

function create_vertex_shader_test_shape(_square_size = 10, _square_amount = 10) // PROGRESS STATE - Needs comments and function description stuff (might be removed if unused)
{
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_color();
	var _format = vertex_format_end();

	var _buffer = vertex_create_buffer();
	vertex_begin(_buffer, _format);
	
	var _vertex_count = 0;
	for (i = 0; i < _square_amount; i++)
	{
		var _pos_x = i * _square_size
		vertex_position(_buffer, _pos_x, 0);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
		vertex_position(_buffer, _pos_x + _square_size, 0);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
		vertex_position(_buffer, _pos_x, _square_size);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
		vertex_position(_buffer, _pos_x + _square_size, 0);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
		vertex_position(_buffer, _pos_x, _square_size);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
		vertex_position(_buffer, _pos_x + _square_size, _square_size);
		vertex_color(_buffer, _vertex_count, 1);
		_vertex_count++;
	}
	
	vertex_end(_buffer);
	vertex_freeze(_buffer);
	
	return _buffer;
}

// Test suite for all basic shader functionality
function BasicShaderTestSuite() : TestSuite() constructor {
	
	addTestAsync("primitive_drawing", objTestAsyncDraw, { // PROGRESS STATE - Finished (crop draw tests)
		
		ev_create: function() {
			// Generate rect data to draw
			rect = generate_centred_rect(200, 200);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_is_compiled", objTestAsyncDraw, { // PROGRESS STATE - Finished (crop draw tests)
		
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
				//show_debug_message(shaders[i]);
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
	
	
	addFact("shader_get_name", function() { // PROGRESS STATE - Needs comments
		
		var _output;
		_output = shader_get_name(sh_passthrough_glsles);
		assert_equals(_output, "sh_passthrough_glsles", test_current().name +", failed to get name of shader" );
	});
	
	addFact("shaders_are_supported", function() { // PROGRESS STATE - Not implemented
		
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
	
	
	addTestAsync("shader_current", objTestAsyncDraw, { // PROGRESS STATE - Finished (crop draw tests)
		
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
	
	
	addTestAsync("passthrough_shader", objTestAsyncDraw, { // PROGRESS STATE - Finished (crop draw tests)
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_passthrough_glsles, sh_passthrough_hlsl, sh_passthrough_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rect data to draw
			rect = generate_centred_rect(200, 200);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_get/set_uniform_f", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_uniform_f_glsles, sh_uniform_f_hlsl, sh_uniform_f_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rect data to draw
			rect = generate_centred_rect(200, 200);
			
			// Get color uniform handle
			uni_color = shader_get_uniform(test_shader, "color");
			assert_typeof(uni_color, "number", test_current().name +", failed to get a valid uniform handle")
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// initialise variables to be set to color uniform
			var _red = 1;
			var _green = 1;
			var _blue = 1;
			var _alpha = 1;
			// initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderTests/SetUniformF/Control";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Set test variables based on step
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/SetUniformF/SetRGB";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing rgb value";
					_red = 0;
					_green = 0;
					_blue = 0;
					break;
				case 2:
					_test_path = "ShaderTests/SetUniformF/SetAlpha";
					_test_fail_message = test_current().name +", failed draw buffer comparison after changing alpha value";
					_alpha = 0;
					break;
				case 3:
					test_end();
					break;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
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
			
			draw_frame++;
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("shader_set_uniform_f_array", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_set_uniform_f_buffer", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_set_uniform_i", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	addTestAsync("shader_set_uniform_i_array", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	addTestAsync("shader_get_sampler_index", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_set_uniform_matrix", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_set_uniform_matrix_array", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
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
			var _test_surface = start_draw_comparison();
			
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
	
	
	addTestAsync("shader_enable_corner_id", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
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
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
				draw_sprite(sprSquare, 0, (room_width / 2) - 32, (room_height / 2) - 32)
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
	
	addTestAsync("gl_frag_coord", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (doesn't cover gl_fragCoord.z or gl_FragCoord.w - not sure if these are implemented in GM?)
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, window_get_width(), window_get_height());
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_frag_coord_glsles, sh_enable_corner_id_hlsl, sh_frag_coord_glsles);

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
	
	addTestAsync("gl_max_draw_buffers", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, 200, 200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_draw_buffers_glsles, sh_passthrough_hlsl, sh_max_draw_buffers_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MaxDrawBuffers/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(200, 200);
			
			
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
		test_timeout_millis: 3000
	});
	
	addTestAsync("gl_frag_data", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate data for rect
			rect = new Rect(0, 0, 64, 64);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_frag_data_glsles, sh_passthrough_hlsl, sh_frag_data_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FragData/";
			var _test_fail_message = test_current().name +", failed draw buffer comparison";
			
			// Start draw buffer comparison
			var _test_surfaces = [];
			array_resize(_test_surfaces, 4);
			_test_surfaces[0] = start_draw_comparison_ext(0, 64, 64);
			_test_surfaces[1] = start_draw_comparison_ext(1, 64, 64);
			_test_surfaces[2] = start_draw_comparison_ext(2, 64, 64);
			_test_surfaces[3] = start_draw_comparison_ext(3, 64, 64);
			
			
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
	
	addTestAsync("alpha_test", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			// Generate data for rect
			rect = generate_centred_rect(200, 200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_alpha_test_glsles, sh_passthrough_hlsl, sh_alpha_test_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			u_expected_alpha_test_enabled = shader_get_uniform(test_shader, "u_expected_alpha_test_enabled");
			u_expected_alpha_ref_value = shader_get_uniform(test_shader, "u_expected_alpha_ref_value");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/AlphaTest/Off";
			var _test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing off";
			var _alpha_test = false
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderTests/AlphaTest/On";
					_test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing on";
					_alpha_test = true
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison();
			
			// Start using shader
			shader_set(test_shader);
			
				if (_alpha_test == true)
				{
					gpu_set_alphatestenable(true);
					gpu_set_alphatestref(254);
				}
				
				shader_set_uniform_i(u_expected_alpha_test_enabled, gpu_get_alphatestenable());
				shader_set_uniform_i(u_expected_alpha_ref_value, gpu_get_alphatestref());
				
				draw_sprite(sprSquare, 0, (room_width / 2), (room_height / 2))
				draw_sprite(sprAlphaTest, 0, (room_width / 2) - 32, (room_height / 2) - 32)
				
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			gpu_set_alphatestenable(false);
			gpu_set_alphatestref(0);
			
			draw_frame++;
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_view", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(100, 100, 4, 4);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_view_glsles, sh_enable_corner_id_hlsl, sh_matrix_view_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// get shader uniforms
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MatrixView/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 400);
			
			// Start using shader
			shader_set(test_shader);
				
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				var _expected_matrix = matrix_get(matrix_view);
				
				if (_set_value)
				{
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0]
					matrix_set(matrix_view, _expected_matrix);
				}
				
				
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				// Draw rects
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_projection", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(100, 100, 4, 4);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_projection_glsles, sh_enable_corner_id_hlsl, sh_matrix_projection_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// get shader uniforms
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MatrixProjection/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 400);
			
			// Start using shader
			shader_set(test_shader);
				
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				var _expected_matrix = matrix_get(matrix_projection);
				
				if (_set_value)
				{
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_projection, _expected_matrix);
				}
				
				
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				// Draw rect
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_world", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(100, 100, 4, 4);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_glsles, sh_enable_corner_id_hlsl, sh_matrix_world_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// get shader uniforms
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MatrixWorld/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 400);
			
			// Start using shader
			shader_set(test_shader);
				
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				var _expected_matrix = matrix_get(matrix_world);
				
				if (_set_value)
				{
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_world, _expected_matrix);
				}
				
				
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				// Draw rect
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	
	addTestAsync("gm_matrix_world_view", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(100, 100, 4, 4);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_view_glsles, sh_enable_corner_id_hlsl, sh_matrix_world_view_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// get shader uniforms
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MatrixWorldView/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 400);
			
			// Start using shader
			shader_set(test_shader);
				
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				var _expected_matrix = matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view));
				
				if (_set_value)
				{
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_world, _expected_matrix);
					matrix_set(matrix_view, _expected_matrix);
					_expected_matrix = matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view))
				}
				
				
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				// Draw rect
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_world_view_projection", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(100, 100, 4, 4);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_view_projection_glsles, sh_enable_corner_id_hlsl, sh_matrix_world_view_projection_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// get shader uniforms
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/MatrixWorldViewProjection/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 400);
			
			// Start using shader
			shader_set(test_shader);
				
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				var _expected_matrix =  matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				
				if (_set_value)
				{
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_world, _expected_matrix);
					matrix_set(matrix_view, _expected_matrix);
					matrix_set(matrix_projection, _expected_matrix);
					_expected_matrix = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				}
				
				
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				// Draw rect
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("matrix_max", objTestAsyncDraw, { // PROGRESS STATE - needs more specific comments (crop draw tests)
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, 64, 64);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_max_glsles, sh_passthrough_hlsl, sh_matrix_max_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(64, 64);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/MatrixMax/", test_current().name +", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_vs_fog_enabled", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying 
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_vs_fog_enabled_glsles, sh_passthrough_hlsl, sh_vs_fog_enabled_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/VSFogEnabled/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			var _set_value = false;
			var _input = true;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with fog enabled";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader
			shader_set(test_shader);
			
				// Enable fog if _fog_enabled is set
				if (_set_value == true)
				{
					gpu_set_fog(_input, c_black, 0, 1);
				}
			
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			gpu_set_fog(false, c_black, 0, 1);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_ps_fog_enabled", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ps_fog_enabled_glsles, sh_passthrough_hlsl, sh_ps_fog_enabled_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/PSFogEnabled/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			var _set_value = false;
			var _input = true;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with fog enabled";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader
			shader_set(test_shader);
			
				// Enable fog if _fog_enabled is set
				if (_set_value == true)
				{
					gpu_set_fog(_input, c_black, 0, 1);
				}
			
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			gpu_set_fog(false, c_black, 0, 1);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_fog_colour", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_colour_glsles, sh_passthrough_hlsl, sh_fog_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FogColour/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of c_black";
			var _set_value = false;
			var _input = c_white;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of c_white";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				
				if (_set_value == true)
				{
					// Set fog to be enabled and coloured white
					gpu_set_fog(true, _input, 0, 1);
				}
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			gpu_set_fog(false, c_black, 0, 1);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_fog_start", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_start_glsles, sh_passthrough_hlsl, sh_fog_start_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/FogStart/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of 0";
			var _set_value = false;
			var _input = 10;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of 10";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				
				if (_set_value == true)
				{
					// Set fog to be enabled and coloured white
					gpu_set_fog(true, c_black, _input, 100);
				}
			
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			gpu_set_fog(false, c_black, 0, 1);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_rcp_fog_range", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_rcp_fog_range_glsles, sh_passthrough_hlsl, sh_rcp_fog_range_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/RcpFogRange/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of 1";
			var _set_value = false;
			var _input = 100;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of 100";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				
				if (_set_value == true)
				{
					// Set fog to be enabled and coloured white
					gpu_set_fog(true, c_black, 0, _input);
				}
			
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			gpu_set_fog(false, c_black, 0, 1);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});

	addTestAsync("3d_rendering", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
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
	
	addTestAsync("normals_test", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_normals_glsles, sh_passthrough_hlsl,  sh_normals_glsles);
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
	
	addTestAsync("gl_front_facing", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (& crop draw tests)
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_front_facing_glsles, sh_passthrough_hlsl,  sh_front_facing_glsles);
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
	
	addTestAsync("max_vs_lights", objTestAsyncDraw, { // PROGRESS STATE - needs more specific comments (crop draw tests)
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, 64, 64);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_vs_lights_glsles, sh_passthrough_hlsl, sh_max_vs_lights_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
		},
		ev_draw: function() {
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(64, 64);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, "ShaderTests/MaxVSLights/", test_current().name +", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		},
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_lighting_enabled", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying 
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0,0,200,200);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lighting_enabled_glsles, sh_passthrough_hlsl, sh_lighting_enabled_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/LightingEnabled/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			var _set_value = false;
			var _input = true;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with lighting enabled";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			// Enable lighting if _set_value is set
			if (_set_value == true)
			{
				draw_set_lighting(true);
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(rect.right, rect.bottom);
			
			// Start using shader
			shader_set(test_shader);
			
				// Enable lighting if _set_value is set
				//if (_set_value == true)
				//{
				//	draw_set_lighting(true);
				//}
			
				// Draw rect
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
			draw_set_lighting(false);
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_lights_direction", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (seems to invert directions? and w component doesn't seem to work)
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(100, 100, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_direction_glsles, sh_passthrough_hlsl, sh_lights_direction_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/LightsDirection/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 directional lights set";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
		
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 200);
			
			if (_set_value == true)
			{
				draw_light_define_direction(0, 1, 0, 0, c_white);
				draw_light_define_direction(1, 0, 1, 0, c_white);
				draw_light_define_direction(2, 0, 0, 1, c_white);
				draw_light_define_direction(3, 0.3, 0.3, 0.3, c_white);
				draw_light_define_direction(4, -1, 0, 0, c_white);
				draw_light_define_direction(5, 0, -1, 0, c_white);
				draw_light_define_direction(6, 0, 0, -1, c_white);
				draw_light_define_direction(7, -0.3, -0.3, -0.3, c_white);
				draw_light_enable(7, false)
			}
			
			// Start using shader
			shader_set(test_shader);
				
				
				// Draw rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_lights_pos_range", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (docs say w is 0 when disabled, but this is untrue)
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(100, 100, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_pos_range_glsles, sh_passthrough_hlsl, sh_lights_pos_range_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/LightsPosRange/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 point lights set";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
		
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 200);
			
			if (_set_value == true)
			{
				draw_light_define_point(0, 1, 0, 0, 1, c_white);
				draw_light_define_point(1, 0, 1, 0, 1, c_white);
				draw_light_define_point(2, 0, 0, 1, 1, c_white);
				draw_light_define_point(3, 1, 1, 1, 1, c_white);
				draw_light_define_point(4, -1, 0, 0, 0.7, c_white);
				draw_light_define_point(5, 0, -1, 0, 0.7, c_white);
				draw_light_define_point(6, 0, 0, -1, 0.7, c_white);
				draw_light_define_point(7, -1, -1, -1, 1, c_white);
				draw_light_enable(7, false)
			}
			
			// Start using shader
			shader_set(test_shader);
				
				
				// Draw rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_lights_colour", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (docs are missing a [] and this doesn't work at all)
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(100, 100, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_colour_glsles, sh_passthrough_hlsl, sh_lights_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/LightsColour/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 lights set";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
		
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(400, 200);
			
			if (_set_value == true)
			{
				draw_set_lighting(true)
				draw_light_define_point(0, 0, 0, 0, 1, $FF0000FF);
				draw_light_define_point(1, 0, 0, 0, 1, $FF00FF00);
				draw_light_define_point(2, 0, 0, 0, 1, $FFFF0000);
				draw_light_define_point(3, 0, 0, 0, 1, $77FFFFFF);
				draw_light_define_direction(4, 1, 0, 0, $FFFFFF00);
				draw_light_define_direction(5, 1, 0, 0, $FFFF00FF);
				draw_light_define_direction(6, 1, 0, 0, $FF00FFFF);
				draw_light_define_direction(7, 1, 0, 0, $FF000000);
			}
			
			// Start using shader
			shader_set(test_shader);
				
				
				// Draw rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i * 16, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_ambient_colour", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying (uses $AABBGGRR, but docs don't mention this)
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, 64, 64);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ambient_colour_glsles, sh_passthrough_hlsl, sh_ambient_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderTests/AmbientColour/";
			
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value";
			var _set_value = false;
			
			switch (draw_frame)
			{
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with a value of $FFFF00FF (magenta)";
					_set_value = true;
					break;
				case 2:
					test_end();
					return;
			}
			
			if (_set_value == true)
			{
				draw_light_define_ambient($FFFF00FF);
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(64, 64);
			
			// Start using shader
			shader_set(test_shader);
				
				draw_rect(rect);
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			// Update frame counter
			draw_frame++;
			
		},
		ev_cleanup: function() {
		}
	
	},
	{ 
		test_timeout_millis: 3000
	});

}