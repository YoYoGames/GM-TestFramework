function BasicMatrixTestSuite() : TestSuite() constructor {

	addFact("matrix_build_test", function() {

		math_set_epsilon(0.01);

		var _output;
			
		_output = matrix_build_identity();
		assert_array_equals(_output, [1, 0, 0, 0,
										0, 1, 0, 0,
										0, 0, 1, 0,
										0, 0, 0, 1], "#1 matrix_build_identity(), failed to build matrix correctly");
			
		_output = matrix_build(1, 1, 1, 90, -90, 180, 0.5, 1, 1.5);
		assert_array_equals(_output, [0, 1, 0, 0,
										0, 0, -1.50, 0,
										-0.50, 0, 0, 0,
										1, 1, 1, 1], "#2 matrix_build(), failed to build matrix correctly");
			
		_output = matrix_build_lookat(-1, -1, -1, 1, 1, 1, 0, 1, 0);
		assert_array_equals(_output, [0.71, -0.41, 0.58, 0,
										0, 0.82, 0.58, 0, 
										-0.71, -0.41, 0.58, 0,
										0, 0, 1.73, 1 ], "#3 matrix_build_lookat(), failed to build matrix correctly");
			
		_output = matrix_build_projection_ortho(1920, 1080, -1, 1);
		assert_array_equals(_output, [0.00, 0, 0, 0,
										0, 0.00, 0, 0,
										0, 0, 0.50, 0,
										0, 0, 0.50, 1], "#4 matrix_build_projection_ortho(), failed to build matrix correctly");
			
		_output = matrix_build_projection_perspective(1920, 1080, -1, -1);
		assert_array_equals(_output, [1, 0, 0, 0,
										0, 1, 0, 0,
										0, 0, 1, 0,
										0, 0, 0, 1], "#5 matrix_build_projection_perspective(), failed to build matrix correctly");
			
		_output = matrix_build_projection_perspective_fov(-90, -(640 / 480), 1.0, 10000.0);
		assert_array_equals(_output, [0.75, 0, 0, 0,
										0, -1, 0, 0,
										0, 0, 1.00, 1,
										0, 0, -1.00, 0], "#6 matrix_build_projection_perspective_fov(), failed to build matrix correctly");
			
	})

	addFact("matrix_multiply_test", function() {
			
		math_set_epsilon(0.01);
			
		var input1 = [ 1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1 ];
			
		var input2 = [ 1, 2, 3, 4, 
						-2, -2, -2, -2, 
						1, 2, 3, 4, 
						0.2, 0.2, 0.2, 0.2 ];
			
		var _output = matrix_multiply(input1, input2);
		assert_array_equals(_output, [0.20, 2.20, 4.20, 6.20,
										0.20, 2.20, 4.20, 6.20,
										0.20, 2.20, 4.20, 6.20,
										0.20, 2.20, 4.20, 6.20 ], "#1 matrix_multiply (...), failed to multiply matrices");
			
	});
		
	addFact("matrix_transform_vertex_test", function() {
			
		math_set_epsilon(0.01);
			
		var _input = [ 1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1 ];
			
		var _output = matrix_transform_vertex(_input, 10, 20, 30);
		assert_array_equals(_output, [61, 61, 61], "#1 matrix_transform_vertex(...), failed to transform matrix correctly");
			
	})

	addFact("matrix_get_set_test", function() {

		math_set_epsilon(0.01);
			
		var _defaultProjection = matrix_get(matrix_projection);
		var _defaultWorld = matrix_get(matrix_world);
		var _defaultView = matrix_get(matrix_view);
			
		var _input, _output;
				
		_input = matrix_build_projection_perspective_fov(-90, -(view_get_wport(0) / view_get_hport(0)), 1.0, 10000.0);
		matrix_set(matrix_projection, _input);
		_output = matrix_get(matrix_projection);
		assert_array_equals(_output, _input, "#1 matrix_set ( matrix_projection, ...), failed to correctly set projection matrix");
			
		_input = [0.71, 0, 0.71, 0, 0, 1, 0, 0, -0.71, 0, 0.71, 0, 0, 50, 200, 1];
		matrix_set(matrix_world, _input);
		_output = matrix_get(matrix_world);
		assert_array_equals(_output, _input, "#2 matrix_set ( matrix_world, ...), failed to correctly set world matrix");
			
		_input = matrix_build_lookat(0, 50, -100, -0.225473261323277, 50.262600124007065, -100.93819135427475, 0, 1, 0);
		matrix_set(matrix_view, _input);
		_output = matrix_get(matrix_view);
		assert_array_equals(_output, _input, "#3 matrix_set ( matrix_view, ...), failed to correctly set view matrix");
			
		matrix_set(matrix_projection, _defaultProjection);
		matrix_set(matrix_world, _defaultWorld);
		matrix_set(matrix_view, _defaultView);
			
	})

	addFact("matrix_stack_test", function() {
			
		math_set_epsilon(0.01);
			
		var _input, _output;
			
		_input = matrix_build(10, 10, 10, 0, 0, 0, 1, 1, 1);
			
		matrix_stack_push(_input);
		_output = matrix_stack_top();
		assert_array_equals(_output, _input, "#1 matrix_stack_push( matrix:local ), failed to push to stack correctly.");
			
		_input = [ 1,   2,   3,   4,
					-2,   -2,  -2,  -2, 
					1,   2,   3,   4, 
					0.2, 0.2, 0.2, 0.2 ];
			
		matrix_stack_set(_input);
		_output = matrix_stack_pop();
		assert_array_equals(_output, _input, "#2 matrix_stack_pop(), failed to correctly set/pop from the stack");
			
		matrix_stack_clear();
		_output = matrix_stack_is_empty();
		assert_true(_output, "#3 matrix_stack_clear(), failed to clear the stack correctly");
			
	})
	
}