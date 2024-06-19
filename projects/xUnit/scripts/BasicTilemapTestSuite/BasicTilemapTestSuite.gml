/// @function CreateTestLayer()
/// @description Creates a new layer for testing. Returns undefined and fails the test if the layer has not been created correctly.
/// @return {Id.layer}
function CreateTestLayer()
{
	var testLayer, output;
	
	// Create layer at depth 100
	testLayer = layer_create(100, "testLayer");
	
	// Check it's been created successfully
	output = layer_exists(testLayer);
	assert_true(output, "layer_create(), failed to create a layer");
			
	// Early exit (we don't have a layer to work with)
	if (!output) return undefined;
	
	return testLayer;
}

/// @function CreateTestTilemap(testLayer, tileset, width, height)
/// @description Creates a new tilemap on the specified layer, optionally with a specific a tileSet and size. Returns undefined and fails the test if the tilemap has not been created correctly.
/// @param {Id.layer} testLayer The layer to create the tilemap on.
/// @param {Asset.GMTileSet} tileSet The tileset to use for the tilemap. defaults to tilesAuto.
/// @param {Real} width Width of the tilemap in cells. defaults to 10.
/// @param {Real} height Height of the tilemap in cells. defaults to 10.
/// @return {Id.tilemap} 
function CreateTestTilemap(testLayer, tileSet = tilesAuto, width = 10, height = 10)
{
	var layerTilemap, output;
	
	// Create tilemap
	layerTilemap = layer_tilemap_create(testLayer, 0, 0, tileSet, width, height);
	
	// Check it's been created successfully
	output = layer_tilemap_exists(testLayer, layerTilemap);
	assert_true(output, "layer_tilemap_create(), failed to create a new tilemap element");
				
	// Early exit (we don't have a tilemap to work with)
	if (!output) return undefined;
	
	return layerTilemap;
}

/// @function DestroyTestLayer(testLayer)
/// @description Destroys the specified layer, checking it's been destroyed successfully
/// @param {Id.layer} testLayer The layer to destroy.
function DestroyTestLayer(testLayer)
{
	var output;
	
	// Destroy layer
	layer_destroy(testLayer);
	
	// Check it's been destroyed successfully
	output = layer_exists(testLayer);
	assert_false(output, "layer_destroy(), failed to destroy the given layer");
}

/// @function DestroyTestTilemap(testLayer, layerTilemap)
/// @description Destroys the specified tilemap, checking it's been destroyed successfully
/// @param {Id.layer} testLayer The layer to destroy.
/// @param {Id.tilemap} layerTilemap The tilemap to destroy.
function DestroyTestTilemap(testLayer, layerTilemap)
{
	var output;
	
	// Destroy tilemap
	layer_tilemap_destroy(layerTilemap);
	
	// Check it's been destroyed successfully
	output = layer_tilemap_exists(testLayer, layerTilemap);
	assert_false(output, "layer_tilemap_destroy(), failed to destroy the given layer tilemap element");
}

// Possible invalid function argument types, used for the TestInvalidArgs function below.
enum ARG_TYPE
{
	PTR,
	PTR_NULL,
	PTR_INVALID,
	STRING,
	UNDEFINED,
	ARRAY,
	STRUCT,
	METHOD
}

/// @function TestInvalidArgs(func, numArgs, validArgTypes)
/// @description This function will run the given function with all possible invalid argument types, checking that the function sees them as invalid.
/// @param {function} func The function to run invaild arguments on
/// @param {int32} numArgs The number of arguments that the function has
/// @param {array[ARG_TYPE]} validArgTypes The types of arguments (as ARG_TYPEs) to exclude from the test, as they would be considered valid
function TestInvalidArgs(func, numArgs = 1, validArgTypes = [])
{
	if (TEST_INVALID_ARGS) {
		// Set values and descriptions for invalid args
		var invalidArgs = [ 
			[ ptr({}),		"ptr" ],
			[ pointer_null,		"ptrNull" ],
			[ pointer_invalid,	"ptrInvalid" ],
			[ "hello",			"string" ],
			[ undefined,		"undefined" ],
			[ [],				"array" ], //];
			[ {},				"struct" ],
			[ function() {},	"method" ] ]; 
	
		// Get rid of any args that are in validArgTypes
		for (var i = array_length(validArgTypes); i > 0; i--) {
		
			array_delete(invalidArgs, validArgTypes[i-1], 1);
		}
		
		// Get the name of the function to be used in the assert
		var funcDesc = script_get_name(func);
	
		// For each invaild arg..
		var invalidArgsCount = array_length(invalidArgs);
		for (var i = 0; i < invalidArgsCount; i++) {
			
			var invalidArg = invalidArgs[i];
			
			// Set the description of the current invalid arg to be used in the assert
			var details = invalidArg[1];
			
			// Create an array of values to be put into the function, filling it with the current invalid arg
			var values = []
			for (var j = 0; j < numArgs; j++) {
				values[j] = invalidArg[0];
			}
		
			// Put the function with the invalid args into an assert_throw to make sure it throws an exception as expected
			assert_throw(method({targetFunc: func, args: values}, function() {
					
				method_call(targetFunc, args);

			}), funcDesc+"("+ details +"):, failed to detect invalid arguments");
		}
	}
}


function BasicTilemapTestSuite() : TestSuite() constructor {
	
	// Test for layer_tilemap_create(), layer_tilemap_exists(), and layer_tilemap_destroy() (If this fails, most other tests will too)
	addFact("tilemap_create_exists_destroy", function() {
		
		var testLayer, layerTilemap, output;
		
		// Create layer and tilemap, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
		
	});
	
	// Test for layer_tilemap_get_id()
	addFact("layer_tilemap_get_id", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test layer_tilemap_get_id() with Id.layer value
		output = layer_tilemap_get_id(testLayer);
		assert_equals(output, layerTilemap, "#layer_tilemap_get_id(), failed to get the correct value");
		
		// Test layer_tilemap_get_id() with string value
		output = layer_tilemap_get_id("testLayer");
		assert_equals(output, layerTilemap, "#layer_tilemap_get_id(), failed to get the correct value");
		
		// Test layer_tilemap_get_id() with invalid args
		TestInvalidArgs(layer_tilemap_get_id, 1, [ARG_TYPE.STRING]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_mask() and tilemap_set_mask()
	addFact("tilemap_set_get_mask", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_mask() returns an expected value of 2147483647 (01111111111111111111111111111111 in binary - this is the default mask value)
		output = tilemap_get_mask(layerTilemap);
		assert_equals(output, 2147483647, "#tilemap_get_mask(), failed to get the correct value");
		
		// Test tilemap_get_mask() with invalid args
		TestInvalidArgs(tilemap_get_mask, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_set_mask() with a valid input value of 1879572479 (01110000000001111111111111111111 in binary)
		input = 1879572479;
		tilemap_set_mask(layerTilemap, input);
		output = tilemap_get_mask(layerTilemap);
		assert_equals(output, input, "#tilemap_set_mask(), failed to set the correct value");
		
		// Test tilemap_set_mask() with invalid args
		TestInvalidArgs(tilemap_set_mask, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_set_global_mask() and tilemap_get_global_mask()
	addFact("tilemap_set_get_global_mask", function() {
		
		var input, output;
		
		// Test that tilemap_get_global_mask() returns an expected value of 2147483647 (01111111111111111111111111111111 in binary - this is the default mask value)
		output = tilemap_get_global_mask();
		assert_equals(output, 2147483647, "#tilemap_get_global_mask(), failed to get the correct value");
		
		// Test tilemap_set_global_mask() with a valid input value of 1879572479 (01110000000001111111111111111111 in binary)
		input = 1879572479;
		tilemap_set_global_mask(input);
		output = tilemap_get_global_mask();
		assert_equals(output, input, "tilemap_set_global_mask(), failed to set the correct value");
		
		// Test tilemap_set_global_mask() with invalid args
		TestInvalidArgs(tilemap_set_global_mask, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Reset global mask back to default
		tilemap_set_global_mask(2147483647);
	});
	
	// Test for tilemap_tileset() amd tilemap_get_tileset()
	addFact("tilemap_set_get_tileset", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_tileset() outputs an expected value of tilesAuto (the tileset that the tilemap was created with)
		output = tilemap_get_tileset(layerTilemap);
		assert_equals(output, tilesAuto, "#tilemap_get_tileset(), failed to get the correct value");
		
		// Test tilemap_get_tileset() with invalid args
		TestInvalidArgs(tilemap_get_tileset, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_tileset() with a valid input value of tilesAutoReplacement (alternate blue tileset)
		input = tilesAutoReplacement;
		tilemap_tileset(layerTilemap, input);
		output = tilemap_get_tileset(layerTilemap);
		assert_equals(output, input, "#tilemap_tileset(), failed to set the correct value");
		
		// Test tilemap_tileset() with invalid args
		TestInvalidArgs(tilemap_tileset, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_frame()
	addTestAsync("tilemap_get_frame", objTestAsync, {
		
		ev_create: function() {
		
			var testLayer, layerTilemap, input, output;
		
			// Create layer and tilemap for testing, ending the test early if they aren't created successfully
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			// Tilemap is set to use the tilesAutoAnimated tileset
			layerTilemap = CreateTestTilemap(testLayer, tilesAutoAnimated);
			if (is_undefined(layerTilemap)) test_end();
			
			// Set tile at (0,0) to an animated tile (index 1) 
			tilemap_set(layerTilemap, 1, 0, 0);
			output = tilemap_get(layerTilemap, 0, 0);
			assert_equals(output, 1, "#tilemap_set(), failed to set the correct value");
			
			// Early exit (we don't have an animated tile to work with)
			if (output != 1) test_end();
			
			// Test that tilemap_get_frame() returns an expected value of 0 on for first frame
			output = tilemap_get_frame(layerTilemap);
			assert_equals(output, 0, "#tilemap_get_frame(), failed to get the correct value on first frame");
			
			// Test tilemap_get_frame() with invalid args
			TestInvalidArgs(tilemap_get_frame);
			
		},
		// This happens every step event
		ev_step: function() {
			
			var testLayer, layerTilemap, output;
			
			// Find the layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test that tilemap_get_frame() eventually returns a value other than 0, as it should on the second frame or on subsequent frames
			output = tilemap_get_frame(layerTilemap);
			if (output != 0)
			{
				// End the test successfully if so
				test_end();
			}
		},
		ev_cleanup: function() {
			
			var testLayer, layerTilemap;
			
			// If test has timed out, it means that a change in frame was never detected past the first frame
			if (test_has_expired())
			{
				assert_true(false, "tilemap_get_frame(), failed to get the correct value beyond first frame");
			}
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Destroy layer and tilemap
			DestroyTestTilemap(testLayer, layerTilemap);
			DestroyTestLayer(testLayer);
		}
	
	},
	{ 
		// This will end the test if the test runs for 3 seconds without a change in frame being detected
		test_timeout_millis: 3000
	});
	
	// Test for tilemap_get_tile_width()
	addFact("tilemap_get_tile_width", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_tile_width() outputs an expected value of 10 (this is the value set in the tileset asset)
		output = tilemap_get_tile_width(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_tile_width(), failed to get the correct value");
		
		// Test tilemap_get_tile_width() with invalid args
		TestInvalidArgs(tilemap_get_tile_width, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_tile_height()
	addFact("tilemap_get_tile_height", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_tile_height() outputs an expected value of 10 (this is the value set in the tileset asset)
		output = tilemap_get_tile_height(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_tile_height(), failed to get the correct value");
		
		// Test tilemap_get_tile_height() with invalid args
		TestInvalidArgs(tilemap_get_tile_height, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_set_width() and tilemap_get_width()
	addFact("tilemap_set_get_width", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_width() outputs an expected value of 10 (this is the value the tilemap was created with)
		output = tilemap_get_width(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_width(), failed to get the correct value");
		
		// Test tilemap_get_width() with invalid args
		TestInvalidArgs(tilemap_get_width, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_set_width() with a valid input value of 15
		input = 15;
		tilemap_set_width(layerTilemap, input);
		output = tilemap_get_width(layerTilemap);
		assert_equals(output, input, "#tilemap_set_width(), failed to set the correct value");
		
		// Test tilemap_set_width() with invalid args
		TestInvalidArgs(tilemap_set_width, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_set_height() and tilemap_get_height()
	addFact("tilemap_set_get_height", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_height() outputs an expected value of 10 (this is the value the tilemap was created with)
		output = tilemap_get_height(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_height(), failed to get the correct value");
		
		// Test tilemap_get_height() with invalid args
		TestInvalidArgs(tilemap_get_height, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_set_height() with a valid input value of 15
		input = 15;
		tilemap_set_height(layerTilemap, input);
		output = tilemap_get_height(layerTilemap);
		assert_equals(output, input, "#tilemap_set_height(), failed to set the correct value");
		
		// Test tilemap_set_height() with invalid args
		TestInvalidArgs(tilemap_set_height, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test fro tilemap_x() and tilemap_get_x()
	addFact("tilemap_set_get_x", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_x() outputs an expected value of 0 (this is the x position the tilemap was created at)
		output = tilemap_get_x(layerTilemap);
		assert_equals(output, 0, "#tilemap_get_x(), failed to get the correct value");
		
		// Test tilemap_get_x() with invalid args
		TestInvalidArgs(tilemap_get_x, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_x with a valid input value of 1
		input = 1;
		tilemap_x(layerTilemap, input);
		output = tilemap_get_x(layerTilemap);
		assert_equals(output, input, "#tilemap_x(), failed to set the correct value");
		
		// Test tilemap_x() with invalid args
		TestInvalidArgs(tilemap_x, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_y() and tilemap_get_y()
	addFact("tilemap_set_get_y", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_y() outputs an expected value of 0 (this is the y position the tilemap was created at)
		output = tilemap_get_y(layerTilemap);
		assert_equals(output, 0, "#tilemap_get_y(), failed to get the correct value");
		
		// Test tilemap_get_y() with invalid args
		TestInvalidArgs(tilemap_get_y, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_y with a valid input value of 1
		input = 1;
		tilemap_y(layerTilemap, input);
		output = tilemap_get_y(layerTilemap);
		assert_equals(output, input, "#tilemap_y(), failed to set the correct value");
		
		// Test tilemap_y() with invalid args
		TestInvalidArgs(tilemap_y, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_set() and tilemap_get()
	addFact("tilemap_set_get", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get() outputs an expected value of 0 at cell 0,0 (as the tile at 0,0 is empty)
		output = tilemap_get(layerTilemap, 0, 0);
		assert_equals(output, 0, "#tilemap_get(), failed to get the correct value");
		
		// Test tilemap_get() with invalid args
		TestInvalidArgs(tilemap_get, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_set() with a valid input value of 2 (at cell 0,0)
		input = 2;
		tilemap_set(layerTilemap, input, 0, 0);
		output = tilemap_get(layerTilemap, 0, 0);
		assert_equals(output, input, "#tilemap_set(), failed to set the correct value");
		
		// Test tilemap_set() with invalid args
		TestInvalidArgs(tilemap_set, 4, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_at_pixel() and tilemap_set_at_pixel()
	addFact("tilemap_set_get_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_at_pixel() outputs an expected value of 0 at pixel 1,1 (as the tile at pixel 1,1 is empty)
		output = tilemap_get_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_at_pixel(), failed to get the correct value");
		
		// Test tilemap_get_at_pixel() with invalid args
		TestInvalidArgs(tilemap_get_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test tilemap_set_at_pixel() with a valid input value of 2 (at pixel 1,1)
		input = 2;
		tilemap_set_at_pixel(layerTilemap, input, 1, 1);
		output = tilemap_get_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, input, "tilemap_set_at_pixel(), failed to set the correct value");
		
		// Test tilemap_set_at_pixel() with invalid args
		TestInvalidArgs(tilemap_set_at_pixel, 4, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_cell_x_at_pixel()
	addFact("tilemap_get_cell_x_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_cell_x_at_pixel() outputs an expected value of 0 at pixel 1,1 (as pixel 1,1 is in cell 0,0)
		output = tilemap_get_cell_x_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_cell_x_at_pixel(), failed to get the correct value");
		
		// Test tilemap_get_cell_x_at_pixel() with invalid arguments
		TestInvalidArgs(tilemap_get_cell_x_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_get_cell_y_at_pixel()
	addFact("tilemap_get_cell_y_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_get_cell_y_at_pixel() outputs an expected value of 0 at pixel 1,1 (as pixel 1,1 is in cell 0,0)
		output = tilemap_get_cell_y_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_cell_y_at_pixel(), failed to get the correct value");
		
		// Test tilemap_get_cell_y_at_pixel() with invalid arguments
		TestInvalidArgs(tilemap_get_cell_y_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tilemap_clear()
	addFact("tilemap_clear", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tilemap_clear() has set a value of 1 for every cell's tiledata, as expected
		input = 1;
		tilemap_clear(layerTilemap, input);
		// Loop through every tile on the X axis
		for (var i = 0; i < 10; i += 1)
		{
			// Loop through every tile on the Y axis
		    for (var j = 0; j < 10; j += 1)
		    {
				output = tilemap_get(layerTilemap, i, j);
				assert_equals(output, input, "tilemap_clear(), failed to clear all tiles");
			}
		}
		
		// Test tilemap_clear() with invalid args
		TestInvalidArgs(tilemap_clear, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for draw_tilemap()
	addTestAsync("draw_tilemap", objTestAsyncDraw, {
		
		ev_create: function() {
			
			var testLayer, layerTilemap;
			
			// Create layer and tilemap for testing, ending the test early if they aren't created successfully
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			// Tilemap is set to be 14 tiles wide and 4 tiles high, same as the tileset
			layerTilemap = CreateTestTilemap(testLayer, tilesAuto, 14, 4);
			if (is_undefined(layerTilemap)) test_end();
			
			// Get the amount of tiles in the tileset
			var tilesetInfo = tileset_get_info(tilesAuto);
			var tileCount = tilesetInfo.tile_count;
			// For every tile..
			for (i = 0; i < tileCount; i++)
			{
				// Place them onto the tilemap, as they are arranged on the tileset (14 tiles per row)
				// (i mod 14 increments the x coord every loop until 14, then resets)
				var cell_x = i mod 14;
				// (i div 14 increments the y coord every 14th tile)
				var cell_y = i div 14;
				tilemap_set(layerTilemap, i, cell_x, cell_y);
			}
			
		},
		// This happens every draw event
		ev_draw: function() {
			
			var testLayer, layerTilemap, testSurface, testBuffer, expectedBuffer;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test that draw_tilemap() draws the tilemap correctly using the draw comparison functions in objTestAsyncDraw:
			// Start drawing to a test surface
			testSurface = start_draw_comparison();
			// draw the tilemap at 0,0
			draw_tilemap(layerTilemap, 0, 0);
			// Stop drawing to the test surface, store it as a buffer, then compare it against the drawTilemapTestExpectedBuffer file
			end_draw_comparison(testSurface, "drawTilemapTest", "draw_tilemap(), failed draw buffer comparison");
			
			// Test draw_tilemap() with invalid args
			TestInvalidArgs(draw_tilemap, 3);
			
			// End test after first draw event
			test_end();
		},
		ev_cleanup: function() {
			
			var testLayer, layerTilemap;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Destroy layer and tilemap
			DestroyTestTilemap(testLayer, layerTilemap);
			DestroyTestLayer(testLayer);
		}
	
	},
	{ 
		test_timeout_millis: 3000,
	});
	
	// Test for tile_set_empty() and tile_get_empty()
	addFact("tile_set_get_empty", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		// Set tile at cell 1,0 to index 1 for testing
		tilemap_set(layerTilemap, 1, 1, 0);
		
		// Test that tile_get_empty() returns true as expected for the empty tile at 0,0
		testTile = tilemap_get(layerTilemap, 0, 0);
		output = tile_get_empty(testTile);
		assert_true(output, "#tile_get_empty(), failed to get the correct value for empty tile");
		
		// Test that tile_get_empty() returns false as expected for the tile that was set to index 1 at 1,0
		testTile = tilemap_get(layerTilemap, 1, 0);
		output = tile_get_empty(testTile);
		assert_false(output, "#tile_get_empty(), failed to get the correct value for non-empty tile");
		
		// Test tile_get_empty() with invalid args
		TestInvalidArgs(tile_get_empty);
		
		// Test that tile_set_empty() turns the index 1 tile data from 1,0 to an empty tile as expected
		testTile = tilemap_get(layerTilemap, 1, 0);
		testTile = tile_set_empty(testTile);
		output = tile_get_empty(testTile);
		assert_true(output, "#tile_set_empty(), failed to set the correct value");
		
		// Test tile_set_empty() with invalid args
		TestInvalidArgs(tile_set_empty);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tile_get_index() and tile_set_index()
	addFact("tile_set_get_index", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tile_get_index() returns 0 as expected for the empty tile at 0,0
		testTile = tilemap_get(layerTilemap, 0, 0);
		output = tile_get_index(testTile);
		assert_equals(output, 0, "#tile_get_index(), failed to get the correct value");
		
		// Test tile_get_index() with invalid args
		TestInvalidArgs(tile_get_index);
		
		// Test that tile_set_index() sets the empty tile to index 1 as expected
		input = 1
		testTile = tile_set_index(testTile, input);
		output = tile_get_index(testTile);
		assert_equals(output, input, "tilemap_set_index(), failed to set the correct value");
		
		// Test tile_set_index() with invalid args
		TestInvalidArgs(tile_set_index, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tile_set_flip() and tile_get_flip()
	addFact("tile_set_get_flip", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tile_get_flip() returns 0 as expected for the non-flipped tile at 0,0
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_flip(testTile);
		assert_equals(output, 0, "#tile_get_flip(), failed to get the correct value");
		
		// Test tile_get_flip() with invalid args
		TestInvalidArgs(tile_get_flip);
		
		// Test that tile_set_flip() flips the non-flipped tile as expected
		input = true
		testTile = tile_set_flip(testTile, input);
		output = tile_get_flip(testTile);
		assert_equals(output, input, "#tilemap_set_flip(), failed to set the correct value");
		
		// Test tile_set_flip() with invalid args
		TestInvalidArgs(tile_set_flip, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for tile_set_mirror() and tile_set_mirror()
	addFact("tile_set_get_mirror", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tile_get_mirror() returns 0 as expected for the non-mirrored tile at 0,0
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_mirror(testTile);
		assert_equals(output, 0, "#tile_get_mirror(), failed to get the correct value");
		
		// Test tile_get_mirror() with invalid args
		TestInvalidArgs(tile_get_mirror);
		
		// Test that tile_set_mirror() flips the non-mirrored tile as expected
		input = true
		testTile = tile_set_mirror(testTile, input);
		output = tile_get_mirror(testTile);
		assert_equals(output, input, "#tilemap_set_mirror(), failed to set the correct value");
		
		// Test tile_set_mirror() with invalid args
		TestInvalidArgs(tile_set_mirror, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test tile_set_rotate() and tile_get_rotate()
	addFact("tile_set_get_rotate", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing, ending the test early if they aren't created successfully
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test that tile_get_rotate() returns 0 as expected for the non-rotated tile at 0,0
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_rotate(testTile);
		assert_equals(output, 0, "#tile_get_rotate(), failed to get the correct value");
		
		// Test tile_get_rotate() with invalid args
		TestInvalidArgs(tile_get_rotate);
		
		// Test that tile_set_rotate() flips the non-mirrored tile as expected
		input = true
		testTile = tile_set_rotate(testTile, input);
		output = tile_get_rotate(testTile);
		assert_equals(output, input, "#tilemap_set_rotate(), failed to set the correct value");
		
		// Test tile_set_rotate() with invalid args
		TestInvalidArgs(tile_set_rotate, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	// Test for draw_tile()
	addTestAsync("draw_tile", objTestAsyncDraw, {
		
		ev_create: function() {
		
			var testLayer, layerTilemap;
			
			// Create layer and tilemap for testing, ending the test early if they aren't created successfully
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			layerTilemap = CreateTestTilemap(testLayer);
			if (is_undefined(layerTilemap)) test_end();
			
		},
		// This happens every draw event
		ev_draw: function() {
			
			var testLayer, layerTilemap, testSurface = undefined;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test that draw_tile() draws a tile correctly using the draw comparison functions in objTestAsyncDraw:
			// Start drawing to a test surface
			testSurface = start_draw_comparison();
			// draw tile with index 1 from tilesAuto at 0,0
			draw_tile(tilesAuto, 1, 0, 0, 0);
			// Stop drawing to the test surface, store it as a buffer, then compare it against the drawTileTestExpectedBuffer file
			end_draw_comparison(testSurface, "drawTileTest", "draw_tile(), failed draw buffer comparison");
			
			// Test draw_tile() with invalid args
			TestInvalidArgs(draw_tile, 5);
			
			// End test after first draw event
			test_end();
		},
		ev_cleanup: function() {
			
			var testLayer, layerTilemap;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Destroy layer and tilemap
			DestroyTestTilemap(testLayer, layerTilemap);
			DestroyTestLayer(testLayer);
		}
	
	},
	{ 
		test_timeout_millis: 3000,
	});
}
