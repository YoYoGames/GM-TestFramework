// Utility functions for testing draw functions

/// @function start_draw_comparison()
/// @description Creates a surface and sets it as the current draw target, capturing the resulting image of any subsequent draw calls. Returns a reference to the surface to pass into end_draw_comparison once finished drawing. 
/// @param {Real} _width The width of the surface to create for the comparison
/// @param {Real} _height The height of the surface to create for the comparison
/// @return {Id.Surface|Undefined} The created surface, to be used in end_draw_comparison()
function start_draw_comparison(_width = room_width, _height = room_height) {
	
	// Create a surface to draw the tile onto
	var _test_surface = surface_create(_width, _height);
	// Check it has been created successfully
	if (!surface_exists(_test_surface))
	{
		// End the comparison here if not, since we don't have a surface to work with
		assert_true(false, test_current().name + ", failed to create a surface for comparison");
		// Return undefined to tell end_draw_comparison that the test surface wasn't created
		return undefined;
	}
			
	// Start drawing to the surface
	surface_set_target(_test_surface);
	// Returns the surface to be used in end_draw_comparison()
	return _test_surface;
}

/// @function start_draw_comparison_ext()
/// @description Creates a surface and sets it as one of the current MRT draw targets, capturing the resulting image of any subsequent draw calls. Returns a reference to the surface to pass into end_draw_comparison_ext once finished drawing. 
/// @param {Real} _index The render target index to use (from 0 to 3).
/// @param {Real} _width The width of the surface to create for the comparison
/// @param {Real} _height The height of the surface to create for the comparison
/// @return {Id.Surface|Undefined} The created surface, to be used in end_draw_comparison_ext()
function start_draw_comparison_ext(_index, _width = room_width, _height = room_height) {
	
	// Create a surface to draw the tile onto
	var _test_surface = surface_create(_width, _height);
	// Check it has been created successfully
	if (!surface_exists(_test_surface))
	{
		// End the comparison here if not, since we don't have a surface to work with
		assert_true(false, test_current().name + ", failed to create a surface for comparison");
		// Return undefined to tell end_draw_comparison that the test surface wasn't created
		return undefined;
	}
			
	// Start drawing to the surface
	surface_set_target_ext(_index, _test_surface);
	// Returns the surface to be used in end_draw_comparison()
	return _test_surface;
}

/// @function end_draw_comparison()
/// @description Stops drawing to the surface and saves it to a buffer, then checks that buffer against a saved expected buffer. (Also saves the resulting buffer and surface image as files for checking manually, or to be used as a new expected buffer.) Should only ever be called after start_draw_comparison() has been called.
/// @param {Id.Surface} _test_surface The surface created for the test, returned from start_draw_comparison()
/// @param {String} _test_name The test name to use as a prefix for any saved/loaded files during the test. ("TestName" would read "TestNameExpectedBuffer")
/// @param {String} _fail_message The message to be shown in the assert if the test fails.
/// @return {bool} True if test was successful, false if any asserts were triggered
function end_draw_comparison(_test_surface, _test_name, _fail_message) {
	
	var _result = true;
	
	// Check that a test surface has been created
	
	if (!surface_exists(_test_surface))
	{
		// End the comparison here if so, since we don't have a surface to work with
		_result = assert_true(false, test_current().name + ", non-existant test surface in end_draw_comparison(), likely forgot to call start_draw_comparison()");
		return _result;
	}
	
	// Stop drawing to the surface
	surface_reset_target();
	
	// Check that a file name has been set
	if (_test_name == "")
	{
		// Delete the surface and end the comparison here if so, since we don't have a file name to save to/load from
		_result = assert_true(false, test_current().name + ", invalid test name in end_draw_comparison()");
		surface_free(_test_surface);
		return _result;
	}
	
	// Save the surface to a .png file (for manual checking)
	var _path_surface = game_save_id + _test_name + "Result.png";
	surface_save(_test_surface, _path_surface);
	log_debug("Saving " + _path_surface);

	// Save the surface as buffer (for manual checking)
	var _buffer = buffer_create(
		surface_get_width(_test_surface) * surface_get_height(_test_surface) * 4 * buffer_sizeof(buffer_u8),
		buffer_fast, 1);
	buffer_get_surface(_buffer, _test_surface, 0);
	var _path_buffer = game_save_id + _test_name + "ResultBuffer";
	buffer_save(_buffer, _path_buffer);
	log_debug("Saving " + _path_buffer);
	buffer_delete(_buffer);

	// Make a temporary sprite out of the surface so we can use our function for comparing sprites
	var _test_sprite = sprite_create_from_surface(
		_test_surface, 0, 0,
		surface_get_width(_test_surface), surface_get_height(_test_surface),
		false, false, 0, 0);

	// Check that an expected sprite exists for this test
	var _expected_fname = _test_name + "Expected.png";
	var _expected_file = file_bin_open(_expected_fname, 2);
	var _expected_size = file_bin_size(_expected_file);
	file_bin_close(_expected_file);

	if (file_exists(_expected_fname))
	{
		// check the test sprite against the expected sprite (showing the fail message in the assert if they don't match)
		log_debug($"end_draw_comparison :: adding sprite \"{_expected_fname}\", size {_expected_size} bytes");
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
	
	// Delete created resources
	sprite_delete(_test_sprite);
	surface_free(_test_surface);
	return _result;
	
}

/// @function end_draw_comparison_ext()
/// @description Stops drawing to the surfaces and saves each of them to a buffer, checking each buffer against a saved expected buffer. (Also saves the resulting buffers and surface images as files for checking manually, or to be used as new expected buffers.) Should only ever be called after one or more start_draw_comparison_ext() calls.
/// @param {Array<Id.Surface>} _test_surfaces The surfaces created for the test, returned from start_draw_comparison_ext()
/// @param {String} _test_name The test name to use as a prefix for any saved/loaded files during the test. ("TestName" would read "TestNameExpectedBuffer")
/// @param {String} _fail_message The message to be shown in the assert if the test fails.
/// @return {bool} True if test was successful, false if any asserts were triggered
function end_draw_comparison_ext(_test_surfaces, _test_name, _fail_message) {
	
	var _result = true;
	
	// Check that all the test surfaces exist
	for (i = 0; i < array_length(_test_surfaces); i++)
	{
		if (!surface_exists(_test_surfaces[i]))
		{
			// End the comparison here if so, since we don't have a surface to work with
			_result = assert_true(false, test_current().name + ", non-existant test surface in end_draw_comparison_ext(), likely forgot to call start_draw_comparison()");
			return _result;
		}
	}
	
	// Stop drawing to the surfaces
	surface_reset_target();
	
	// For each surface..
	for (i = 0; i < array_length(_test_surfaces); i++)
	{
		// Check that a file name has been set
		if (_test_name == "")
		{
			// Delete the surface and end the comparison here if so, since we don't have a file name to save to/load from
			_result = assert_true(false, test_current().name + ", invalid test name in end_draw_comparison_ext()");
			surface_free(_test_surfaces[i]);
			return _result;
		}
	
		// Save the surface to a .png file (for manual checking)
		var _path_surface = game_save_id + _test_name + "Result" + string(i) + ".png";
		surface_save(_test_surfaces[i], _path_surface);
		log_debug("Saving " + _path_surface);
		
		// Save the surface as buffer (for manual checking)
		var _buffer = buffer_create(
			surface_get_width(_test_surfaces[i]) * surface_get_height(_test_surfaces[i]) * 4 * buffer_sizeof(buffer_u8),
			buffer_fast, 1);
		buffer_get_surface(_buffer, _test_surfaces[i], 0);
		var _path_buffer = game_save_id + _test_name + "ResultBuffer" + string(i);
		buffer_save(_buffer, _path_buffer);
		log_debug("Saving " + _path_buffer);
		buffer_delete(_buffer);

		// Make a temporary sprite out of the surface so we can use our function for comparing sprites
		var _test_sprite = sprite_create_from_surface(
			_test_surfaces[i], 0, 0,
			surface_get_width(_test_surfaces[i]), surface_get_height(_test_surfaces[i]),
			false, false, 0, 0);

		// Check that an expected sprite exists for this test
		var _expected_fname = _test_name + "Expected" + string(i) + ".png";
		var _expected_file = file_bin_open(_expected_fname, 2);
		var _expected_size = file_bin_size(_expected_file);
		file_bin_close(_expected_file);

		if (file_exists(_expected_fname))
		{
			// check the test sprite against the expected sprite (showing the fail message in the assert if they don't match)
			log_debug($"end_draw_comparison :: adding sprite \"{_expected_fname}\", size {_expected_size} bytes");
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
	
		// Delete created resources
		sprite_delete(_test_sprite);
		surface_free(_test_surfaces[i]);
	}
	
	return _result;
	
}

