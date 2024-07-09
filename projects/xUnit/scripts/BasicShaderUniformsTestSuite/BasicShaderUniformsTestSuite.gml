
// Test suite for testing all gamemaker-specific built-in shader uniforms
function BasicShaderUniformsTestSuite() : TestSuite() constructor {
	
	addTestAsync("alpha_test", objTestAsyncDraw, { // PROGRESS STATE - Needs comments & tidying
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_alpha_test_glsles, sh_alpha_test_hlsl, sh_alpha_test_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			u_expected_alpha_test_enabled = shader_get_uniform(test_shader, "u_expected_alpha_test_enabled");
			u_expected_alpha_ref_value = shader_get_uniform(test_shader, "u_expected_alpha_ref_value");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/AlphaTest/Off";
			var _test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing off";
			var _alpha_test = false
			
			switch (draw_frame)
			{
				case 1:
					_test_path = "ShaderUniformTests/AlphaTest/On";
					_test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing on";
					_alpha_test = true
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
			
				if (_alpha_test == true)
				{
					gpu_set_alphatestenable(true);
					gpu_set_alphatestref(254);
				}
				
				shader_set_uniform_i(u_expected_alpha_test_enabled, gpu_get_alphatestenable());
				shader_set_uniform_i(u_expected_alpha_ref_value, gpu_get_alphatestref());
				
				draw_sprite(sprSquare, 0, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2)
				draw_sprite(sprAlphaTest, 0, 0, 0)
				
				
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
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
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
			
			var _test_path = "ShaderUniformTests/MatrixView/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
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
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
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
			
			var _test_path = "ShaderUniformTests/MatrixProjection/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
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
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
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
			
			var _test_path = "ShaderUniformTests/MatrixWorld/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
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
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
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
			
			var _test_path = "ShaderUniformTests/MatrixWorldView/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
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
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
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
			
			var _test_path = "ShaderUniformTests/MatrixWorldViewProjection/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
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
	
	addTestAsync("matrix_max", objTestAsyncDraw, { // PROGRESS STATE - needs more specific comments
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_max_glsles, sh_passthrough_hlsl, sh_matrix_max_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
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
			end_draw_comparison(_test_surface, "ShaderUniformTests/MatrixMax/", test_current().name +", failed draw buffer comparison");
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
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_vs_fog_enabled_glsles, sh_passthrough_hlsl, sh_vs_fog_enabled_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/VSFogEnabled/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ps_fog_enabled_glsles, sh_passthrough_hlsl, sh_ps_fog_enabled_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/PSFogEnabled/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_colour_glsles, sh_passthrough_hlsl, sh_fog_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/FogColour/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_start_glsles, sh_passthrough_hlsl, sh_fog_start_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/FogStart/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_rcp_fog_range_glsles, sh_passthrough_hlsl, sh_rcp_fog_range_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/RcpFogRange/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
	
	addTestAsync("max_vs_lights", objTestAsyncDraw, { // PROGRESS STATE - needs more specific comments
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_vs_lights_glsles, sh_passthrough_hlsl, sh_max_vs_lights_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
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
			end_draw_comparison(_test_surface, "ShaderUniformTests/MaxVSLights/", test_current().name +", failed draw buffer comparison");
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
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_colour_glsles, sh_passthrough_hlsl, sh_lights_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/LightingEnabled/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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
	
	addTestAsync("gm_lights_direction", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_direction_glsles, sh_passthrough_hlsl, sh_lights_direction_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/LightsDirection/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
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
	
	addTestAsync("gm_lights_pos_range", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_pos_range_glsles, sh_passthrough_hlsl, sh_lights_pos_range_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/LightsPosRange/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
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
	
	addTestAsync("gm_lights_colour", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_colour_glsles, sh_passthrough_hlsl, sh_lights_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/LightsColour/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
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
	
	addTestAsync("gm_ambient_colour", objTestAsyncDraw, { // PROGRESS STATE - Needs HLSL, comments & tidying
		
		ev_create: function() {
			// Generate rect data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ambient_colour_glsles, sh_passthrough_hlsl, sh_ambient_colour_glsles);

			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			
			var _test_path = "ShaderUniformTests/AmbientColour/";
			
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
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
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