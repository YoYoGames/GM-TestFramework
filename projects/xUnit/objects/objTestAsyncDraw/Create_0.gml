/// @description Begin running test, and declare some variables and functions for draw buffer comparisons
// The test name to use as a prefix for any saved/loaded files during the test.
testFileName = ""
// The message to be shown in the assert if the test fails.
testFailMessage = "objTestAsyncDraw, no fail message set."
// The surface used for the test.
testSurface = undefined;

/// @function StartDrawComparison(testName, failMessage)
/// @description Creates a surface for the test and sets it as the current draw target. To be used in conjunction with EndDrawComparison to compare what's been drawn on screen with a saved buffer.
/// @param {String} testName The test name to use as a prefix for any saved/loaded files during the test.
/// @param {String} failMessage The message to be shown in the assert if the test fails.
function StartDrawComparison(testName, failMessage) {
	
	// Set the test name and fail message
	testFileName = testName
	testFailMessage = failMessage
	
	// Create a surface to draw the tile onto
	testSurface = surface_create(room_width, room_height);
	// Check it has been created successfully
	if (!surface_exists(testSurface))
	{
		// End the comparison here if not, since we don't have a surface to work with
		assert_true(false, "surface_create(), failed to create a surface");
		return;
	}
			
	// Start drawing to the surface
	surface_set_target(testSurface);
}

/// @function EndDrawComparison()
/// @description Stops drawing to the surface and saves it to a buffer, then checks that buffer against a saved expected buffer. (Also saves the resulting buffer and surface image as files for checking manually, or to be used as a new expected buffer.) To be used in conjunction with StartDrawComparison.
function EndDrawComparison() {
	
	// Check that a test surface has been created
	if (testSurface == undefined)
	{
		// End the comparison here if so, since we don't have a surface to work with
		assert_true(false, "EndDrawComparison(), testSurface hasn't been set, likely forgot to call StartDrawComparison()");
		return;
	}
	
	// Stop drawing to the surface
	surface_reset_target();
	
	// Check that a file name has been set
	if (testFileName == "")
	{
		// Delete the surface and end the comparison here if so, since we don't have a file name to save to/load from
		assert_true(false, "EndDrawComparison(), testName hasn't been set, likely forgot to call StartDrawComparison()");
		surface_free(testSurface)
		return;
	}
	
	// Save the surface to a .png file (for manual checking)
	surface_save(testSurface,  testFileName + "Result.png");
	
	// Create a buffer to store the surface data in
	var testBuffer = buffer_create(room_width * room_height * 4, buffer_fixed, 1);
	// Check it has been created successfully
	if (!buffer_exists(testBuffer))
	{
		// End the comparison here if not, since we don't have a buffer to work with
		assert_true(false, "buffer_create(), failed to create a buffer");
		surface_free(testSurface)
		return;
	}
	// store the data from the surface in it
	buffer_get_surface(testBuffer, testSurface, 0);
			
	// Save the buffer data to a file (for manual checking, or to be used as a new expected buffer)
	buffer_save(testBuffer, testFileName + "ResultBuffer");
			
	// Check that an expected buffer exists for this test
	if (file_exists(testFileName + "ExpectedBuffer"))
	{
		// check the test buffer against the expected buffer (showing the fail message in the assert if they don't match)
		var expectedBuffer = buffer_load(testFileName + "ExpectedBuffer");
		assert_buffer_equals(testBuffer, expectedBuffer, testFailMessage);
	}
	else
	{
		assert_true(false, "EndDrawComparison(), couldn't find expected buffer file");
	}
	
	// Delete the buffer and surface
	buffer_delete(testBuffer)
	surface_free(testSurface)
	return;
	
}

test_init();

test_run_event("ev_create");