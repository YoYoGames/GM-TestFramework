// Utility functions for testing draw functions

/// @function start_draw_comparison()
/// @description Creates a surface and sets it as the current draw target, capturing the resulting image of any subsequent draw calls. Returns a reference to the surface to pass into end_draw_comparison once finished drawing. 
/// @param {Real} width The width of the surface to create for the comparison
/// @param {Real} height The height of the surface to create for the comparison
/// @return {Id.Surface} The created surface, to be used in end_draw_comparison()
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
/// @param {Real} index The render target index to use (from 0 to 3).
/// @param {Real} width The width of the surface to create for the comparison
/// @param {Real} height The height of the surface to create for the comparison
/// @return {Id.Surface} The created surface, to be used in end_draw_comparison_ext()
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
/// @param {Id.Surface} test_surface The surface created for the test, returned from start_draw_comparison()
/// @param {String} test_name The test name to use as a prefix for any saved/loaded files during the test. ("TestName" would read "TestNameExpectedBuffer")
/// @param {String} fail_message The message to be shown in the assert if the test fails.
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
	surface_save(_test_surface,  _test_name + "Result.png");
	
	// Create a buffer to store the surface data in
	var _test_buffer = buffer_create(surface_get_width(_test_surface) * surface_get_height(_test_surface) * 4, buffer_fixed, 1);
	// Check it has been created successfully
	if (!buffer_exists(_test_buffer))
	{
		// End the comparison here if not, since we don't have a buffer to work with
		_result = assert_true(false, test_current().name + ", failed to create a buffer for comparison");
		surface_free(_test_surface);
		return _result;
	}
	// store the data from the surface in it
	buffer_get_surface(_test_buffer, _test_surface, 0);
			
	// Save the buffer data to a file (for manual checking, or to be used as a new expected buffer)
	buffer_save(_test_buffer, _test_name + "ResultBuffer");
			
	// Check that an expected buffer exists for this test
	if (file_exists(_test_name + "ExpectedBuffer"))
	{
		// check the test buffer against the expected buffer (showing the fail message in the assert if they don't match)
		var _expected_buffer = buffer_load(_test_name + "ExpectedBuffer");
		if (assert_buffer_equals(_test_buffer, _expected_buffer, _fail_message))
		{
			_result = false;
		}
	}
	else
	{
		_result = assert_true(false, test_current().name + ", failed to find expected buffer file (should be at xUnit/datafiles/" + _test_name + "ExpectedBuffer)");
	}
	
	// Delete the buffer and surface
	buffer_delete(_test_buffer);
	surface_free(_test_surface);
	return _result;
	
}

/// @function end_draw_comparison_ext()
/// @description Stops drawing to the surfaces and saves each of them to a buffer, checking each buffer against a saved expected buffer. (Also saves the resulting buffers and surface images as files for checking manually, or to be used as new expected buffers.) Should only ever be called after one or more start_draw_comparison_ext() calls.
/// @param {Id.Surface[]} test_surfaces The surfaces created for the test, returned from start_draw_comparison_ext()
/// @param {String} test_name The test name to use as a prefix for any saved/loaded files during the test. ("TestName" would read "TestNameExpectedBuffer")
/// @param {String} fail_message The message to be shown in the assert if the test fails.
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
		surface_save(_test_surfaces[i],  _test_name + "Result" + string(i) + ".png");
	
		// Create a buffer to store the surface data in
		var _test_buffer = buffer_create(surface_get_width(_test_surfaces[i]) * surface_get_height(_test_surfaces[i]) * 4, buffer_fixed, 1);
		// Check it has been created successfully
		if (!buffer_exists(_test_buffer))
		{
			// End the comparison here if not, since we don't have a buffer to work with
			_result = assert_true(false, test_current().name + ", failed to create a buffer for comparison");
			surface_free(_test_surfaces[i]);
			return _result;
		}
		// store the data from the surface in it
		buffer_get_surface(_test_buffer, _test_surfaces[i], 0);
			
		// Save the buffer data to a file (for manual checking, or to be used as a new expected buffer)
		buffer_save(_test_buffer, _test_name + "ResultBuffer" + string(i));
			
		// Check that an expected buffer exists for this test
		if (file_exists(_test_name + "ExpectedBuffer" + string(i)))
		{
			// check the test buffer against the expected buffer (showing the fail message in the assert if they don't match)
			var _expected_buffer = buffer_load(_test_name + "ExpectedBuffer" + string(i));
			if (assert_buffer_equals(_test_buffer, _expected_buffer, _fail_message))
			{
				_result = false;
			}
		}
		else
		{
			_result = assert_true(false, test_current().name + ", failed to find expected buffer file (should be at xUnit/datafiles/" + _test_name + "ExpectedBuffer" + string(i) + ")");
		}
	
		// Delete the buffer and surface
		buffer_delete(_test_buffer);
		surface_free(_test_surfaces[i]);
	}
	
	return _result;
	
}