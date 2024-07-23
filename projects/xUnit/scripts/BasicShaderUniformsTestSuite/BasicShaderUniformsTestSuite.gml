// View each tests' corresponding shaders for further information on how they work.
// Expected test result image and buffer files can be found in [project directory]/xUnit/datafiles

// Test suite for testing all gamemaker-specific built-in shader uniforms
function BasicShaderUniformsTestSuite() : TestSuite() constructor {
	
	addTestAsync("alpha_test", objTestAsyncDraw, {
		
		ev_create: function() {
			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_alpha_test_glsl, sh_alpha_test_hlsl, sh_alpha_test_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/AlphaTest/Off";
			var _test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing off";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, enable alpha testing and set the reference value to 254
				case 1:
					_test_path = "ShaderUniformTests/AlphaTest/On";
					_test_fail_message = test_current().name +", failed draw buffer comparison with alpha testing on";
					gpu_set_alphatestenable(true);
					gpu_set_alphatestref(254);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw background sprite
				draw_sprite(sprSquare, 0, SHADER_TEST_DEFAULT_SIZE/2, SHADER_TEST_DEFAULT_SIZE/2)
				// Draw alpha test sprite
				draw_sprite(sprAlphaTest, 0, 0, 0)
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path, _test_fail_message);
			
			// Disable alpha testing and set reference value back to 0
			gpu_set_alphatestenable(false);
			gpu_set_alphatestref(0);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_view", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_view_glsl, sh_matrix_view_hlsl, sh_matrix_view_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rectangles to display matrix data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
			// Get uniform handles for the expected matrix value and initial world view projection matrix value 
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the matrix should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/MatrixView/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the matrix's value to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
			// Start using shader
			shader_set(test_shader);
				
				// Set uniform for initial world view projection matrix
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				
				// Set uniform for expected matrix
				var _expected_matrix = matrix_get(matrix_view);
				if (_set_value)
				{
					// If it should be set this frame, build a new matrix to set it as
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0]
					matrix_set(matrix_view, _expected_matrix);
				}
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				
				// Draw grid of rectangles
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_projection", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_projection_glsl, sh_matrix_projection_hlsl, sh_matrix_projection_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rectangles to display matrix data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
			// Get uniform handles for the expected matrix value and initial world view projection matrix value 
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the matrix should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/MatrixProjection/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the matrix's value to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
			// Start using shader
			shader_set(test_shader);
				
				// Set uniform for initial world view projection matrix
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				
				// Set uniform for expected matrix
				var _expected_matrix = matrix_get(matrix_projection);
				if (_set_value)
				{
					// If it should be set this frame, build a new matrix to set it as
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_projection, _expected_matrix);
				}
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				
				// Draw grid of rectangles
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_world", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_glsl, sh_matrix_world_hlsl, sh_matrix_world_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rectangles to display matrix data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
			// Get uniform handles for the expected matrix value and initial world view projection matrix value 
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the matrix should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/MatrixWorld/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the matrix's value to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
			// Start using shader
			shader_set(test_shader);
				
				// Set uniform for initial world view projection matrix
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				
				// Set uniform for expected matrix
				var _expected_matrix = matrix_get(matrix_world);
				if (_set_value)
				{
					// If it should be set this frame, build a new matrix to set it as
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_world, _expected_matrix);
				}
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				
				// Draw grid of rectangles
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_world_view", objTestAsyncDraw, {
		
		ev_create: function() {		
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_view_glsl, sh_matrix_world_view_hlsl, sh_matrix_world_view_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
			// Get uniform handles for the expected matrix value and initial world view projection matrix value 
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the matrix should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/MatrixWorldView/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the matrix's value to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
			// Start using shader
			shader_set(test_shader);
				
				// Set uniform for initial world view projection matrix
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				
				// Set uniform for expected matrix
				var _expected_matrix = matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view));
				if (_set_value)
				{
					// If it should be set this frame, build a new matrix to set it as
					_expected_matrix = [ 1, 0, 1, 0,
										 0, 0, 0, 1,
										 0, 0, 0, 1,
										 1, 0, 1, 0 ]
					matrix_set(matrix_world, _expected_matrix);
					matrix_set(matrix_view, _expected_matrix);
					_expected_matrix = matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view))
				}
				shader_set_uniform_matrix_array(u_expected_matrix, _expected_matrix);
				
				// Draw grid of rectangles
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_matrix_world_view_projection", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_world_view_projection_glsl, sh_matrix_world_view_projection_hlsl, sh_matrix_world_view_projection_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rects to display matrix data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 4);
			
			// Get uniform handles for the expected matrix value and initial world view projection matrix value 
			u_expected_matrix = shader_get_uniform(test_shader, "u_expected_matrix");
			u_initial_matrix_world_view_projection = shader_get_uniform(test_shader, "u_initial_matrix_world_view_projection");
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the matrix should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/MatrixWorldViewProjection/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default unchanged value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the matrix's value to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with changed value";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
				
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 4);
			
			// Start using shader
			shader_set(test_shader);
			
				// Set uniform for initial world view projection matrix
				var _world_view_projection = matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				shader_set_uniform_matrix_array(u_initial_matrix_world_view_projection, _world_view_projection);
				
				// Set uniform for expected matrix
				var _expected_matrix =  matrix_multiply(matrix_multiply(matrix_get(matrix_world), matrix_get(matrix_view)), matrix_get(matrix_projection));
				if (_set_value)
				{
					// If it should be set this frame, build a new matrix to set it as
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
				
				// Draw grid of rectangles
				for (i = 0; i < 16; i++)
				{
					draw_rect(rects[i], i, 1);
				}
				
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("matrix_max", objTestAsyncDraw, {
		
		ev_create: function() {		
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_matrix_max_glsl, sh_matrix_max_hlsl, sh_matrix_max_glsles);
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
			end_draw_comparison(_test_surface, "ShaderUniformTests/MatrixMax/", test_current().name +", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_vs_fog_enabled", objTestAsyncDraw, {
		
		ev_create: function() {		
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_vs_fog_enabled_glsl, sh_vs_fog_enabled_hlsl, sh_vs_fog_enabled_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/VSFogEnabled/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set fog to be enabled, with a colour of black and a start to end distance of 0-1
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with fog enabled";
					gpu_set_fog(true, c_black, 0, 1);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert fog to default values
			gpu_set_fog(false, c_black, 0, 1);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_ps_fog_enabled", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ps_fog_enabled_glsl, sh_ps_fog_enabled_hlsl, sh_ps_fog_enabled_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/PSFogEnabled/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set fog to be enabled, with a colour of black and a start to end distance of 0-1
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with fog enabled";
					gpu_set_fog(true, c_black, 0, 1);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert fog to default values
			gpu_set_fog(false, c_black, 0, 1);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_fog_colour", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_colour_glsl, sh_fog_colour_hlsl, sh_fog_colour_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/FogColour/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of c_black";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set fog to be enabled, with a colour of white and a start to end distance of 0-1
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of c_white";
					gpu_set_fog(true, c_white, 0, 1);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert fog to default values
			gpu_set_fog(false, c_black, 0, 1);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_fog_start", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_fog_start_glsl, sh_fog_start_hlsl, sh_fog_start_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/FogStart/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of 0";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set fog to be enabled, with a colour of black and a start to end distance of 10-100
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of 10";
					gpu_set_fog(true, c_black, 10, 100);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				// Draw rect
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert fog to default values
			gpu_set_fog(false, c_black, 0, 1);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_rcp_fog_range", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_rcp_fog_range_glsl, sh_rcp_fog_range_hlsl, sh_rcp_fog_range_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/RcpFogRange/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of 1";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set fog to be enabled, with a colour of black and a start to end distance of 10-100
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with set value of 100";
					gpu_set_fog(true, c_black, 10, 100);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader - which will set the colour of anything rendered to the fog colour
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert fog to default values
			gpu_set_fog(false, c_black, 0, 1);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("max_vs_lights", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_max_vs_lights_glsl, sh_max_vs_lights_hlsl, sh_max_vs_lights_glsles);
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
			end_draw_comparison(_test_surface, "ShaderUniformTests/MaxVSLights/", test_current().name +", failed draw buffer comparison");
			// End test at end of first draw frame
			test_end();
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	addTestAsync("gm_lighting_enabled", objTestAsyncDraw, {
		
		ev_create: function() {	
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lighting_enabled_glsl, sh_lighting_enabled_hlsl, sh_lighting_enabled_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0,0,SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
			
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/LightingEnabled/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value of disabled";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set lighting to be enabled
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with lighting enabled";
					draw_set_lighting(true);
					break;
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Revert lighting back to being disabled
			draw_set_lighting(false);
			
			// Increment frame counter
			draw_frame++;
			
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	// (broken code in HLSL shader is commented out to avoid messing up subsequent tests - should be uncommented once fixed)
	addTestAsync("gm_lights_direction", objTestAsyncDraw, {
		
		ev_create: function() {			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_direction_glsl, sh_lights_direction_hlsl, sh_lights_direction_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rects to display light data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the lights should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/LightsDirection/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the lights' values to check they can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 directional lights set";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
			// If lights should be set this frame, set them all to directional lights with different values
			if (_set_value == true)
			{
				draw_light_define_direction(0, 1, 0, 0, c_white);
				draw_light_define_direction(1, 0, 1, 0, c_white);
				draw_light_define_direction(2, 0, 0, 1, c_white);
				draw_light_define_direction(3, 0.3, 0.3, 0.3, c_white);
				// Set the light at index 3 to be disabled, to test how that effects the shader results
				draw_light_enable(3, false)
				draw_light_define_direction(4, -1, 0, 0, c_white);
				draw_light_define_direction(5, 0, -1, 0, c_white);
				draw_light_define_direction(6, 0, 0, -1, c_white);
				draw_light_define_direction(7, -0.3, -0.3, -0.3, c_white);
			}
			
			// Start using shader
			shader_set(test_shader);
				// Draw grid of rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	// (broken code in HLSL shader is commented out to avoid messing up subsequent tests - should be uncommented once fixed)
	addTestAsync("gm_lights_pos_range", objTestAsyncDraw, {
		
		ev_create: function() {			
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_pos_range_glsl, sh_lights_pos_range_hlsl, sh_lights_pos_range_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rects to display light data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the lights should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/LightsPosRange/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the lights' values to check they can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 point lights set";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
		
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
			// If lights should be set this frame, set them all to point lights with different values
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
				// Set the light at index 7 to be disabled, to test how that effects the shader results
				draw_light_enable(7, false)
			}
			
			// Start using shader
			shader_set(test_shader);
				// Draw grid of rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	// (broken code in HLSL shader is commented out to avoid messing up subsequent tests - should be uncommented once fixed)
	addTestAsync("gm_lights_colour", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_lights_colour_glsl, sh_lights_colour_hlsl, sh_lights_colour_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate a grid of rects to display light data
			rects = generate_rect_grid(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE, 4, 2);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise variable to indicate whether the lights should be set this frame
			var _set_value = false;
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/LightsColour/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with no lights set";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the lights' values to check they can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with 8 lights set";
					_set_value = true;
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
		
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE * 4, SHADER_TEST_DEFAULT_SIZE * 2);
			
			// If lights should be set this frame, set them all to point and directional lights with different values
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
				// Draw grid of rectangles
				for (i = 0; i < 8; i++)
				{
					draw_rect(rects[i], i, 1);
				}
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;
		}
	},
	{ 
		test_timeout_millis: 3000
	});
	
	// (broken code in HLSL shader is commented out to avoid messing up subsequent tests - should be uncommented once fixed)
	addTestAsync("gm_ambient_colour", objTestAsyncDraw, {
		
		ev_create: function() {
			// Set shader to use depending on platform
			test_shader = pick_shader_for_platform(sh_ambient_colour_glsl, sh_ambient_colour_hlsl, sh_ambient_colour_glsles);
			// Check that the shader has been compiled
			verify_shader_compiled(test_shader);
			
			// Generate rectangle data to draw
			rect = new Rect(0, 0, SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Stores which frame of the draw event we're on
			draw_frame = 0;
		},
		ev_draw: function() {
			// Initialise test name and fail message to use in buffer comparison
			var _test_path = "ShaderUniformTests/AmbientColour/";
			var _test_prefix = "Unset";
			var _test_fail_message = test_current().name + ", failed draw buffer comparison with default value";
			
			// Set test variables based on which draw frame we're on
			switch (draw_frame)
			{
				// On the second frame, set the ambient light colour to to check it can be modified correctly
				case 1:
					_test_prefix = "Set";
					_test_fail_message = test_current().name + ", failed draw buffer comparison with a value of $FFFF00FF (magenta)";
					draw_light_define_ambient($FFFF00FF);
					break;
				// On the third frame, end the test
				case 2:
					test_end();
					return;
			}
			
			// Start draw buffer comparison
			var _test_surface = start_draw_comparison(SHADER_TEST_DEFAULT_SIZE, SHADER_TEST_DEFAULT_SIZE);
			
			// Start using shader
			shader_set(test_shader);
				// Draw rectangle
				draw_rect(rect);
			// Stop using shader
			shader_reset();
			
			// End draw buffer comparison
			end_draw_comparison(_test_surface, _test_path + _test_prefix, _test_fail_message);
			
			// Increment frame counter
			draw_frame++;	
		}
	},
	{ 
		test_timeout_millis: 3000
	});
}