/// @description Insert description here
// You can write your code in this editor

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
	
	testFileName = testName
	testFailMessage = failMessage
	
	// Create a surface to draw the tile onto
	testSurface = surface_create(room_width, room_height);
	if (!surface_exists(testSurface))
	{
		assert_true(false, "surface_create(), failed to create a surface");
		return;
	}
			
	// Draw the tilemap
	surface_set_target(testSurface);
}

/// @function EndDrawComparison()
/// @description Stops drawing to the surface and saves it to a buffer, then checks the buffer against a saved expected buffer. (Also saves the resulting buffer and surface image as files for checking manually, or to be used as a new expected buffer.) To be used in conjunction with StartDrawComparison.
function EndDrawComparison() {
	
	// Check that a test surface and test name have been defined.
	if (testSurface == undefined)
	{
		assert_true(false, "EndDrawComparison(), testSurface hasn't been set, likely forgot to call StartDrawComparison()");
		return;
	}
	
	surface_reset_target();
	
	if (testFileName == "")
	{
		assert_true(false, "EndDrawComparison(), testName hasn't been set, likely forgot to call StartDrawComparison()");
		surface_free(testSurface)
		return;
	}
	
	
	// Create a buffer and store the data from the surface in it
	var testBuffer = buffer_create(room_width * room_height * 4, buffer_fixed, 1);
	if (!buffer_exists(testBuffer))
	{
		assert_true(false, "buffer_create(), failed to create a buffer");
		surface_free(testSurface)
		return;
	}
	buffer_get_surface(testBuffer, testSurface, 0);
			
	// Save the buffer data and surface image to a file for manual checking
	buffer_save(testBuffer, testFileName + "ResultBuffer");
	surface_save(testSurface,  testFileName + "Result.png");
			
	// Check the test result buffer data against the expected buffer data
	if (file_exists(testFileName + "ExpectedBuffer"))
	{
		var expectedBuffer = buffer_load(testFileName + "ExpectedBuffer");
		
		assert_buffer_equals(testBuffer, expectedBuffer, testFailMessage);
	}
	else
	{
		assert_true(false, "EndDrawComparison(), couldn't find expected file \"" + testName + "ExpectedBuffer\"");
	}
	
	// Delete the buffer and surface
	buffer_delete(testBuffer)
	surface_free(testSurface)
	return;
	
}

test_init();

test_run_event("ev_create");