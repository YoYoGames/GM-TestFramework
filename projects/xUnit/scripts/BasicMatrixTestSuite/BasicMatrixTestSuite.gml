function BasicMatrixTestSuite() : TestSuite() constructor {
    
    addFact("matrix_build_identity_test", function() { 
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build_identity() returns the expected value
        var _output = matrix_build_identity();
        assert_array_equals(_output, [1, 0, 0, 0,
                                      0, 1, 0, 0,
                                      0, 0, 1, 0, 
                                      0, 0, 0, 1], "matrix_build_identity(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_build_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build() returns the expected value when given standard inputs
        var _output = matrix_build(1, 1, 1, 90, -90, 180, 0.5, 1, 1.5);
        assert_array_equals(_output, [0, 1, 0, 0,
                                      0, 0, -1.50, 0,
                                      -0.50, 0, 0, 0,
                                      1, 1, 1, 1], "matrix_build(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_build_lookat_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build_lookat() returns the expected value when given standard inputs
        var _output = matrix_build_lookat(-1, -1, -1, 1, 1, 1, 0, 1, 0);
        assert_array_equals(_output, [0.71, -0.41, 0.58, 0,
                                      0, 0.82, 0.58, 0, 
                                      -0.71, -0.41, 0.58, 0,
                                      0, 0, 1.73, 1 ], "matrix_build_lookat(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_build_projection_ortho", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build_projection_ortho() returns the expected value when given standard inputs
        var _output = matrix_build_projection_ortho(1920, 1080, -1, 1);
        assert_array_equals(_output, [0.00, 0, 0, 0,
                                      0, 0.00, 0, 0,
                                      0, 0, 0.50, 0, 
                                      0, 0, 0.50, 1], "matrix_build_projection_ortho(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_build_projection_perspective", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build_projection_perspective() returns the expected value when given standard inputs
        var _output = matrix_build_projection_perspective(1920, 1080, -1, -1);
        assert_array_equals(_output, [1, 0, 0, 0,
                                      0, 1, 0, 0,
                                      0, 0, 1, 0,
                                      0, 0, 0, 1], "matrix_build_projection_perspective(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_build_projection_perspective_fov", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_build_projection_perspective_fov() returns the expected value when given standard inputs
        var _output = matrix_build_projection_perspective_fov(-90, -(640 / 480), 1.0, 10000.0);
        assert_array_equals(_output, [0.75, 0, 0, 0,
                                      0, -1, 0, 0,
                                      0, 0, 1.00, 1,
                                      0, 0, -1.00, 0], "matrix_build_projection_perspective_fov(), failed to build matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });

	addFact("matrix_multiply_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
		math_set_epsilon(0.01);
		
		var _input1 = [ 1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1, 
						1, 1, 1, 1 ];
        
		var _input2 = [ 1, 2, 3, 4, 
						-2, -2, -2, -2, 
						1, 2, 3, 4, 
						0.2, 0.2, 0.2, 0.2 ];
		
        // Check that matrix_multiply() returns the expected value when given standard inputs
		var _output = matrix_multiply(_input1, _input2);
		assert_array_equals(_output, [0.20, 2.20, 4.20, 6.20,
                                      0.20, 2.20, 4.20, 6.20,
								      0.20, 2.20, 4.20, 6.20,
								      0.20, 2.20, 4.20, 6.20 ], "matrix_multiply (...), failed to multiply matrices");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
	});
		
	addFact("matrix_transform_vertex_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
		math_set_epsilon(0.01);
			
		var _input = [ 1, 1, 1, 1,
                       1, 1, 1, 1, 
                       1, 1, 1, 1, 
                       1, 1, 1, 1 ];
        
        // Check that matrix_transform_vertex() returns the expected value when given standard inputs
		var _output = matrix_transform_vertex(_input, 10, 20, 30);
		assert_array_equals(_output, [61, 61, 61], "matrix_transform_vertex(...), failed to transform matrix correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
	})
    
    addFact("matrix_get_set_test #1", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        // Store default projection matrix
        var _defaultProjection = matrix_get(matrix_projection);
        
        // Check that matrix_set() correctly sets the projection matrix to the value provided
        var _input = matrix_build_projection_perspective_fov(-90, -(view_get_wport(0) / view_get_hport(0)), 1.0, 10000.0);
        matrix_set(matrix_projection, _input);
        var _output = matrix_get(matrix_projection);
        assert_array_equals(_output, _input, "matrix_set ( matrix_projection, ...), failed to correctly set projection matrix");
        
        // Reset the projection matrix back to its default value
        matrix_set(matrix_projection, _defaultProjection);
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_get_set_test #2", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        // Store default world matrix
        var _defaultWorld = matrix_get(matrix_world);
        
        // Check that matrix_set() correctly sets the world matrix to the value provided
        var _input = [0.71, 0, 0.71, 0, 0, 1, 0, 0, -0.71, 0, 0.71, 0, 0, 50, 200, 1];
        matrix_set(matrix_world, _input);
        var _output = matrix_get(matrix_world);
        assert_array_equals(_output, _input, "matrix_set ( matrix_world, ...), failed to correctly set world matrix");
        
        // Reset the world matrix back to its default value
        matrix_set(matrix_world, _defaultWorld);
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_get_set_test #3", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        // Store default view matrix
        var _defaultView = matrix_get(matrix_view);
        
        // Check that matrix_set() correctly sets the view matrix to the value provided
        var _input = matrix_build_lookat(0, 50, -100, -0.225473261323277, 50.262600124007065, -100.93819135427475, 0, 1, 0);
        matrix_set(matrix_view, _input);
        var _output = matrix_get(matrix_view);
        assert_array_equals(_output, _input, "matrix_set ( matrix_view, ...), failed to correctly set view matrix");
        
        // Reset the view matrix back to its default value
        matrix_set(matrix_view, _defaultView);
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_stack_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_stack_push() correctly pushes the value provided onto the matrix stack
        var _input = matrix_build(10, 10, 10, 0, 0, 0, 1, 1, 1);
        matrix_stack_push(_input);
        var _output = matrix_stack_top();
        assert_array_equals(_output, _input, "matrix_stack_push( matrix:local ), failed to push to stack correctly.");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_stack_pop_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        
        var _input = [ 1,   2,   3,   4,
                       -2,   -2,  -2,  -2, 
                       1,   2,   3,   4, 
                       0.2, 0.2, 0.2, 0.2 ];
        
        // Check that matrix_stack_pop() returns the value the matrix stack was set to
        matrix_stack_set(_input);
        var _output = matrix_stack_pop();
        assert_array_equals(_output, _input, "matrix_stack_pop(), failed to correctly set/pop from the stack");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
    
    addFact("matrix_stack_clear_test", function() {
        // Set epsilon to avoid rounding errors causing incorrect test results
        math_set_epsilon(0.01);
        
        // Check that matrix_stack_clear() clears the stack
        matrix_stack_clear();
        var _output = matrix_stack_is_empty();
        assert_true(_output, "matrix_stack_clear(), failed to clear the stack correctly");
        
        // Reset epsilon back to its default value
        math_set_epsilon(0.00001);
    });
	
}