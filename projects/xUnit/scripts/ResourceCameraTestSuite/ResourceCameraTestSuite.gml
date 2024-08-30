function ResourceCameraTestSuite() : TestSuite() constructor {

	addFact("camera_matrix_test #1", function() {

		math_set_epsilon(0.01);
			
		var _output;
			
		var _camera = camera_create();
			
		_output = camera_get_default();
		assert_not_equals(_output, _camera, "camera_get_default(), returned camera before being made default");
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #2", function() {

		math_set_epsilon(0.01);
			
		var _output;
			
		var _camera = camera_create();
			
		camera_set_default(_camera);
		_output = camera_get_default();
		assert_equals(_output, _camera, "camera_get_default(), failed to detect default camera");
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #3", function() {

		math_set_epsilon(0.01);
			
		var _output;
			
		var _camera = camera_create();
			
		camera_set_default(_camera);
			
		_output = camera_get_active()
		assert_not_equals(_output, _camera, "camera_get_active(), returned camera before being made active"); 
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #4", function() {

		math_set_epsilon(0.01);
			
		var _output;
			
		var _camera = camera_create();
			
		camera_set_default(_camera);			
		
		camera_apply(_camera);
		_output = camera_get_active()
		assert_not_equals(_output, _camera, "camera_get_active(), failed to detect active camera"); 
		
		camera_destroy(_camera);	
		
	});

	addFact("camera_matrix_test #5", function() {

		math_set_epsilon(0.01);
			
		var _output;

		var _orthoProjMatrix = matrix_build_projection_ortho(1920, 1080, -100, 100);
			
		var _camera = camera_create();
			
		camera_set_proj_mat(_camera, _orthoProjMatrix);			// [ 0.00,0,0,0,0,0.00,0,0,0,0,0.00,0,0,0,0.50,1 ]
		_output = camera_get_proj_mat(_camera);					// [ 0.00,0,0,0,0,-0.00,0,0,0,0,0.00,0,0,0,0.50,1 ]
		_output[5] *= -1;										// Flip the y axis (this is necessary for textures to no be drawn upside down)
		assert_array_equals(_output, _orthoProjMatrix, "Camera projection matrix matches the orthographic projection matrix");
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #6", function() {

		math_set_epsilon(0.01);
			
		var _output;
		
		var _perspsectiveProjMatrix = matrix_build_projection_perspective(1920, 1080, -100, 100);
			
		var _camera = camera_create();
			
		camera_set_proj_mat(_camera, _perspsectiveProjMatrix);	// [ -0.10,0,0,0,0,-0.19,0,0,0,0,0.50,1,0,0,50,0 ]
		_output = camera_get_proj_mat(_camera);					// [ -0.10,0,0,0,0,0.19,0,0,0,0,0.50,1,0,0,50,0 ]
		_output[5] *= -1;										// Flip the y axis (this is necessary for textures to no be drawn upside down)
		assert_array_equals(_output, _perspsectiveProjMatrix, "Camera projection matrix matches the perspective projection matrix");
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #7", function() {

		math_set_epsilon(0.01);
			
		var _output;
		
		var _perspectiveFOVProjMatrix = matrix_build_projection_perspective_fov(-90, -(1920 / 1080), 1, 10000);
			
		var _camera = camera_create();
			
		camera_set_proj_mat(_camera, _perspectiveFOVProjMatrix);	// [ 0.56,0,0,0,0,-1,0,0,0,0,1.00,1,0,0,-1.00,0 ]
		_output = camera_get_proj_mat(_camera);					// [ 0.56,0,0,0,0,1,0,0,0,0,1.00,1,0,0,-1.00,0 ]
		_output[5] *= -1;										// Flip the y axis (this is necessary for textures to no be drawn upside down)
		assert_array_equals(_output, _perspectiveFOVProjMatrix, "Camera projection matrix matches the perspective FOV projection matrix");
		
		camera_destroy(_camera);
		
	});

	addFact("camera_matrix_test #8", function() {

		math_set_epsilon(0.01);
			
		var _output;
			
		var _viewMatrix = matrix_build_lookat(0, 50, -100, 0, 0, 0, 0, 0, 1);
			
		var _camera = camera_create();
			
		camera_set_view_mat(_camera, _viewMatrix);
		_output = camera_get_view_mat(_camera);
		assert_array_equals(_output, _viewMatrix, "Camera view matrix matches the view lookat matrix");
		
		camera_destroy(_camera);
	});
	
	// CAMERA SCRIPT TESTS

	addFact("camera_script_test (unset) #1", function() {

		var _output;
			
		var _camera = camera_create();
		
		// ### UNSET ###
		
		_output = camera_get_begin_script(_camera);
		assert_equals(_output, -1, "camera_get_begin_script(), fail to return -1 when no script is attached");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (unset) #2", function() {

		var _output;
			
		var _camera = camera_create();
		
		// ### UNSET ###
		
		_output = camera_get_end_script(_camera);
		assert_equals(_output, -1, "camera_get_end_script(), fail to return -1 when no script is attached");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (unset) #3", function() {

		var _output;
			
		var _camera = camera_create();
		
		// ### UNSET ###
		
		_output = camera_get_update_script(_camera);
		assert_equals(_output, -1, "camera_get_update_script(), fail to return -1 when no script is attached");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (set) #4", function() {

		var _beginScript, _output;
			
		_beginScript = function() {};
			
		var _camera = camera_create();
		
		// ### SET ###
		
		camera_set_begin_script(_camera, _beginScript);
		_output = camera_get_begin_script(_camera);
		assert_equals(_output, _beginScript, "camera_set_begin_script(), fail to set the currect script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (set) #5", function() {

		var _updateScript, _output;
		
		_updateScript = function() {};
			
		var _camera = camera_create();
		
		// ### SET ###
		
		camera_set_update_script(_camera, _updateScript);
		_output = camera_get_update_script(_camera);
		assert_equals(_output, _updateScript, "camera_set_update_script(), fail to set the currect script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (set) #6", function() {

		var _endScript, _output;
		
		_endScript = function() {};
			
		var _camera = camera_create();
		
		// ### SET ###
		
		camera_set_end_script(_camera, _endScript);
		_output = camera_get_end_script(_camera);
		assert_equals(_output, _endScript, "camera_set_end_script(), fail to set the currect script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (reset) #7", function() {

		var _beginScript, _output;
			
		_beginScript = function() {};
			
		var _camera = camera_create();

		// ### UNSET ###
		
		camera_set_begin_script(_camera, _beginScript);
		camera_set_begin_script(_camera, -1);
		_output = camera_get_begin_script(_camera);
		assert_equals(_output, -1, "camera_set_begin_script(), fail remove the current script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (reset) #8", function() {

		var _updateScript, _output;
			
		_updateScript = function() {};
			
		var _camera = camera_create();

		// ### UNSET ###
		
		camera_set_update_script(_camera, _updateScript);
		camera_set_update_script(_camera, -1);
		_output = camera_get_update_script(_camera);
		assert_equals(_output, -1, "camera_set_update_script(), fail remove the current script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (reset) #9", function() {

		var _endScript, _output;

		_endScript = function() {};
			
		var _camera = camera_create();

		// ### UNSET ###
		
		camera_set_end_script(_camera, _endScript);
		camera_set_end_script(_camera, -1);
		_output = camera_get_end_script(_camera);
		assert_equals(_output, -1, "camera_set_end_script(), fail remove the current script");

		// Clean up
		camera_destroy(_camera);
		
	});

	addFact("camera_script_test (invalid args) #10", function() {
			
		var _camera = camera_create();
		
		// ### FAILURES ###

		var _valueType, _value, _details;
				
		var _valueDetails = [ 
			[ ptr({}),			"ptr" ],
			[ pointer_null,		"ptrNull" ],
			[ pointer_invalid,	"ptrInvalid" ],
			[ "hello",			"string" ],
			[ undefined,		"undefined" ],
			[ [],				"array" ]
		]; 
			
			
		var _valueDetailsCount = array_length(_valueDetails);
		for (var j = 0; j < _valueDetailsCount; j++) {
				
			_valueType = _valueDetails[j];
			_value = _valueType[0];
			_details = _valueType[1];
				
			assert_throw(method({cam: _camera, input: _value}, function() {
					
				camera_set_begin_script(cam, input);
				
			}), string("camera_set_begin_script({0}):, failed to detect invalid arguemnt", _details));
			
		}

		// Clean up
		camera_destroy(_camera);
	});

	addFact("camera_script_test (invalid args) #11", function() {
			
		var _camera = camera_create();
		
		// ### FAILURES ###

		var _valueType, _value, _details;
				
		var _valueDetails = [ 
			[ ptr({}),			"ptr" ],
			[ pointer_null,		"ptrNull" ],
			[ pointer_invalid,	"ptrInvalid" ],
			[ "hello",			"string" ],
			[ undefined,		"undefined" ],
			[ [],				"array" ]
		]; 
			
			
		var _valueDetailsCount = array_length(_valueDetails);
		for (var j = 0; j < _valueDetailsCount; j++) {
				
			_valueType = _valueDetails[j];
			_value = _valueType[0];
			_details = _valueType[1];
				
			assert_throw(method({cam: _camera, input: _value}, function() {
				
				camera_set_end_script(cam, input);
				
			}), string("camera_set_begin_script({0}):, failed to detect invalid arguemnt", _details));
			
		}

		// Clean up
		camera_destroy(_camera);
	});

	addFact("camera_script_test (invalid args) #12", function() {
			
		var _camera = camera_create();
		
		// ### FAILURES ###

		var _valueType, _value, _details;
				
		var _valueDetails = [ 
			[ ptr({}),			"ptr" ],
			[ pointer_null,		"ptrNull" ],
			[ pointer_invalid,	"ptrInvalid" ],
			[ "hello",			"string" ],
			[ undefined,		"undefined" ],
			[ [],				"array" ]
		]; 
			
			
		var _valueDetailsCount = array_length(_valueDetails);
		for (var j = 0; j < _valueDetailsCount; j++) {
				
			_valueType = _valueDetails[j];
			_value = _valueType[0];
			_details = _valueType[1];
				
			assert_throw(method({cam: _camera, input: _value}, function() {
				
				camera_set_update_script(cam, input);
				
			}), string("camera_set_begin_script({0}):, failed to detect invalid arguemnt", _details));
				
		}

		// Clean up
		camera_destroy(_camera);
	});

	addFact("camera_view_test (create view) #1", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_angle(_camera);
		assert_equals(_output, 90, "camera_create_view(), fail to set right value (angle)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #2", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_border_x(_camera);
		assert_equals(_output, 500, "camera_create_view(), fail to set right value (border_x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #3", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_border_y(_camera);
		assert_equals(_output, 500, "camera_create_view(), fail to set right value (border_y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #4", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_x(_camera);
		assert_equals(_output, 0, "camera_create_view(), fail to set right value (x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #5", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_y(_camera);
		assert_equals(_output, 0, "camera_create_view(), fail to set right value (y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #6", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_width(_camera);
		assert_equals(_output, 1920, "camera_create_view(), fail to set right value (width)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #7", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_height(_camera);
		assert_equals(_output, 1080, "camera_create_view(), fail to set right value (height)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #8", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);

		_output = camera_get_view_speed_x(_camera);
		assert_equals(_output, 10, "camera_create_view(), fail to set right value (speed_x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #9", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);
		
		_output = camera_get_view_speed_y(_camera);
		assert_equals(_output, 10, "camera_create_view(), fail to set right value (speed_y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (create view) #10", function() {
			
		var _output;

		// #### CREATE FUNCTION ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);			
		var _camera = camera_create_view(0,0, 1920, 1080, 90, _instance, 10, 10, 500, 500);
			
		_output = camera_get_view_target(_camera);
		assert_equals(_output, _instance, "camera_create_view(), fail to set right value (target)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #11", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_angle(_camera, 45);
		_output = camera_get_view_angle(_camera);
		assert_equals(_output, 45, "camera_set_view_angle(), failed to set the right value");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #12", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_border(_camera, 200, 200);
		_output = camera_get_view_border_x(_camera);
		assert_equals(_output, 200, "camera_set_view_border(), failed to set the right value (x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #13", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_border(_camera, 200, 200);
		_output = camera_get_view_border_y(_camera);
		assert_equals(_output, 200, "camera_set_view_border(), failed to set the right value (y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #14", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_pos(_camera, 400, 400);
		_output = camera_get_view_x(_camera);
		assert_equals(_output, 400, "camera_set_view_pos(), failed to set the right value (x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #15", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_pos(_camera, 400, 400);
		_output = camera_get_view_y(_camera);
		assert_equals(_output, 400, "camera_set_view_pos(), failed to set the right value (y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #16", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_size(_camera, 1024, 768);
		_output = camera_get_view_width(_camera);
		assert_equals(_output, 1024, "camera_set_view_size(), failed to set the right value (width)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #17", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_size(_camera, 1024, 768);
		_output = camera_get_view_height(_camera);
		assert_equals(_output, 768, "camera_set_view_size(), failed to set the right value (height)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #18", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);

		camera_set_view_speed(_camera, 5, 5);
		_output = camera_get_view_speed_x(_camera);
		assert_equals(_output, 5, "camera_set_view_speed(), failed to set the right value (x)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #19", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);

		camera_set_view_speed(_camera, 5, 5);
		_output = camera_get_view_speed_y(_camera);
		assert_equals(_output, 5, "camera_set_view_speed(), failed to set the right value (y)");

		camera_destroy(_camera);
		instance_destroy(_instance);
		
	});

	addFact("camera_view_test (getters and setters) #20", function() {
			
		var _output;

		// #### SETTERS & GETTERS ####

		var _instance = instance_create_depth(0, 0, 0, oEmpty);
		var _camera = camera_create_view(0,0, 1920, 1080);

		camera_apply(_camera);
			
		camera_set_view_target(_camera, _instance);
		_output = camera_get_view_target(_camera);
		assert_equals(_output, _instance, "camera_set_view_target(), failed to set the right value");

		camera_destroy(_camera);
		instance_destroy(_instance);

	});
	
}