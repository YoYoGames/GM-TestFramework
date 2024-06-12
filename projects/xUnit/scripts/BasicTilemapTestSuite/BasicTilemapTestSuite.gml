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
/// @param {int32} width Width of the tilemap. defaults to 10.
/// @param {int32} height Height of the tilemap. defaults to 10.
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
/// @description Destroys the specified layer
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
/// @description Destroys the specified tilemap.
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
	
		var funcDesc = script_get_name(func);
		var invalidArgsCount = array_length(invalidArgs);
	
		// For each invaild arg
		for (var i = 0; i < invalidArgsCount; i++) {
		
			var invalidArg = invalidArgs[i];
			var values = []
			var details = invalidArg[1];
		
			for (var j = 0; j < numArgs; j++) {
				values[j] = invalidArg[0];
			}
		
			// Test the function with all args as the invaild arg
			assert_throw(method({targetFunc: func, args: values}, function() {
					
				method_call(targetFunc, args)

			}), funcDesc+"("+ details +"):, failed to detect invalid arguments");
		}
	}
}


function BasicTilemapTestSuite() : TestSuite() constructor {
	
	
	addFact("tilemap_create_exists_destroy", function() {
		
		var testLayer, layerTilemap, output;
		
		// Create layer and tilemap
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
	
	addFact("layer_tilemap_get_id", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = layer_tilemap_get_id(testLayer);
		assert_equals(output, layerTilemap, "#layer_tilemap_get_id(), failed to get the correct value");
		
		output = layer_tilemap_get_id("testLayer");
		assert_equals(output, layerTilemap, "#layer_tilemap_get_id(), failed to get the correct value");
		
		TestInvalidArgs(layer_tilemap_get_id, 1, [ARG_TYPE.STRING]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_mask", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_mask(layerTilemap);
		assert_equals(output, 2147483647, "#tilemap_get_mask(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_mask, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 1879572479;
		tilemap_set_mask(layerTilemap, input);
		output = tilemap_get_mask(layerTilemap);
		assert_equals(output, input, "#tilemap_set_mask(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set_mask, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_global_mask", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_global_mask();
		assert_equals(output, 2147483647, "#tilemap_get_global_mask(), failed to get the correct value");
		
		// Test Setter
		input = 1879572479;
		tilemap_set_global_mask(input);
		output = tilemap_get_global_mask();
		assert_equals(output, input, "tilemap_set_global_mask(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set_global_mask, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_tileset", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_tileset(layerTilemap);
		assert_equals(output, tilesAuto, "#tilemap_get_tileset(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_tileset, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = tilesAutoReplacement;
		tilemap_tileset(layerTilemap, input);
		output = tilemap_get_tileset(layerTilemap);
		assert_equals(output, input, "#tilemap_tileset(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_tileset, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addTestAsync("tilemap_get_frame", objTestAsync, {
		
		ev_create: function() {
		
			var testLayer, layerTilemap, input, output;
		
			// Create layer and tilemap for testing (using the tilesAutoAnimated tileset)
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			layerTilemap = CreateTestTilemap(testLayer, tilesAutoAnimated);
			if (is_undefined(layerTilemap)) test_end();
			
			// Set tile at (0,0) to an animated tile (index 1) 
			tilemap_set(layerTilemap, 1, 0, 0);
			output = tilemap_get(layerTilemap, 0, 0);
			assert_equals(output, 1, "#tilemap_set(), failed to set the correct value");
			
			// Early exit (we don't have an animated tile to work with)
			if (output != 1) test_end();
			
			// Test for first frame
			output = tilemap_get_frame(layerTilemap);
			assert_equals(output, 0, "#tilemap_get_frame(), failed to get the correct value on first frame");
	
			TestInvalidArgs(tilemap_get_frame)
			
		},
		ev_step: function() {
			
			var testLayer, layerTilemap, output;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test for second frame
			output = tilemap_get_frame(layerTilemap);
			if (output != 0)
			{
				assert_not_equals(output, 0, "tilemap_get_frame(), failed to get the correct value on second frame")
				test_end();
			}
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
	
	addFact("tilemap_get_tile_width", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_tile_width(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_tile_width(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_tile_width, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_get_tile_height", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_tile_height(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_tile_height(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_tile_height, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_width", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_width(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_width(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_width, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 15;
		tilemap_set_width(layerTilemap, input);
		output = tilemap_get_width(layerTilemap);
		assert_equals(output, input, "#tilemap_set_width(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set_width, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_height", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_height(layerTilemap);
		assert_equals(output, 10, "#tilemap_get_height(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_height, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 15;
		tilemap_set_height(layerTilemap, input);
		output = tilemap_get_height(layerTilemap);
		assert_equals(output, input, "#tilemap_set_height(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set_height, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_x", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_x(layerTilemap);
		assert_equals(output, 0, "#tilemap_get_x(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_x, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 1;
		tilemap_x(layerTilemap, input);
		output = tilemap_get_x(layerTilemap);
		assert_equals(output, input, "#tilemap_x(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_x, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_y", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_y(layerTilemap);
		assert_equals(output, 0, "#tilemap_get_y(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_y, 1, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 1;
		tilemap_y(layerTilemap, input);
		output = tilemap_get_y(layerTilemap);
		assert_equals(output, input, "#tilemap_y(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_y, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get(layerTilemap, 0, 0);
		assert_equals(output, 0, "#tilemap_get(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 2;
		tilemap_set(layerTilemap, input, 0, 0);
		output = tilemap_get(layerTilemap, 0, 0);
		assert_equals(output, input, "#tilemap_set(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set, 4, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_set_get_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_at_pixel(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Test Setter
		input = 2;
		tilemap_set_at_pixel(layerTilemap, input, 1, 1);
		output = tilemap_get_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, input, "tilemap_set_at_pixel(), failed to set the correct value");
		
		TestInvalidArgs(tilemap_set_at_pixel, 4, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_get_cell_x_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_cell_x_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_cell_x_at_pixel(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_cell_x_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_get_cell_y_at_pixel", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		output = tilemap_get_cell_y_at_pixel(layerTilemap, 1, 1);
		assert_equals(output, 0, "#tilemap_get_cell_y_at_pixel(), failed to get the correct value");
		
		TestInvalidArgs(tilemap_get_cell_y_at_pixel, 3, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tilemap_clear", function() {
		
		var testLayer, layerTilemap, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test function
		input = 1;
		tilemap_clear(layerTilemap, input);
		// Loop through every tile on the X axis
		for (var i = 0; i < 10; i += 1)
		{
			// Loop through them all on the Y axis
		    for (var j = 0; j < 10; j += 1)
		    {
				output = tilemap_get(layerTilemap, i, j);
				assert_equals(output, input, "tilemap_clear(), failed to set the correct value");
			}
		}
		
		TestInvalidArgs(tilemap_clear, 2, [ARG_TYPE.STRUCT, ARG_TYPE.METHOD]);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addTestAsync("draw_tilemap", objTestAsyncDraw, {
		
		ev_create: function() {
			
			var testLayer, layerTilemap;
			
			// Create layer and tilemap for testing (using the tilesAutoAnimated tileset)
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			layerTilemap = CreateTestTilemap(testLayer, tilesAuto, 14, 4);
			if (is_undefined(layerTilemap)) test_end();
			
			// Place every tile from the tileset into the tilemap, as they are arranged on the tileset
			var tilesetInfo = tileset_get_info(tilesAuto);
			var tileCount = tilesetInfo.tile_count;
			for (i = 0; i < tileCount; i++)
			{
				tilemap_set(layerTilemap,i, i mod 14, i div 14);
			}
			
		},
		ev_draw: function() {
			
			var testLayer, layerTilemap, testSurface, testBuffer, expectedBuffer, output;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test function
			StartDrawComparison("drawTilemapTest", "draw_tilemap(), failed to draw tilemap correctly");
			draw_tilemap(layerTilemap, 0, 0);
			EndDrawComparison();
			
			TestInvalidArgs(draw_tilemap, 3)
			
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
	
	addFact("tile_set_get_empty", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		// set tile at cell 0,0 to index 1 for testing
		tilemap_set(layerTilemap, 1, 1, 0)
		
		// Test Getter
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_empty(testTile);
		assert_true(output, "#tile_get_empty(), failed to get the correct value for empty tile");
		
		testTile = tilemap_get(layerTilemap, 1, 0)
		output = tile_get_empty(testTile);
		assert_false(output, "#tile_get_empty(), failed to get the correct value for non-empty tile");
		
		TestInvalidArgs(tile_get_empty);
		
		// Test Setter
		testTile = tilemap_get(layerTilemap, 1, 0)
		testTile = tile_set_empty(testTile);
		output = tile_get_empty(testTile);
		assert_true(output, "#tile_set_empty(), failed to set the correct value");
		
		TestInvalidArgs(tile_set_empty);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tile_set_get_index", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_index(testTile);
		assert_equals(output, 0, "#tile_get_index(), failed to get the correct value");
		
		TestInvalidArgs(tile_get_index);
		
		// Test Setter
		input = 1
		testTile = tile_set_index(testTile, input);
		output = tile_get_index(testTile);
		assert_equals(output, input, "tilemap_set_index(), failed to set the correct value");
		
		TestInvalidArgs(tile_set_index, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tile_set_get_flip", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_flip(testTile);
		assert_equals(output, 0, "#tile_get_flip(), failed to get the correct value");
		
		TestInvalidArgs(tile_get_flip);
		
		// Test Setter
		input = true
		testTile = tile_set_flip(testTile, input);
		output = tile_get_flip(testTile);
		assert_equals(output, input, "#tilemap_set_flip(), failed to set the correct value");
		
		TestInvalidArgs(tile_set_flip, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tile_set_get_mirror", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_mirror(testTile);
		assert_equals(output, 0, "#tile_get_mirror(), failed to get the correct value");
		
		TestInvalidArgs(tile_get_mirror);
		
		// Test Setter
		input = true
		testTile = tile_set_flip(testTile, input);
		output = tile_get_flip(testTile);
		assert_equals(output, input, "#tilemap_set_flip(), failed to set the correct value");
		
		TestInvalidArgs(tile_set_mirror, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addFact("tile_set_get_rotate", function() {
		
		var testLayer, layerTilemap, testTile, input, output;
		
		// Create layer and tilemap for testing
		testLayer = CreateTestLayer();
		if (is_undefined(testLayer)) return;
		layerTilemap = CreateTestTilemap(testLayer);
		if (is_undefined(layerTilemap))
		{
			DestroyTestLayer(testLayer);
			return;
		}
		
		// Test Getter
		testTile = tilemap_get(layerTilemap, 0, 0)
		output = tile_get_rotate(testTile);
		assert_equals(output, 0, "#tile_get_rotate(), failed to get the correct value");
		
		TestInvalidArgs(tile_get_rotate);
		
		// Test Setter
		input = true
		testTile = tile_set_rotate(testTile, input);
		output = tile_get_rotate(testTile);
		assert_equals(output, input, "#tilemap_set_rotate(), failed to set the correct value");
		
		TestInvalidArgs(tile_set_rotate, 2);
		
		// Destroy layer and tilemap
		DestroyTestTilemap(testLayer, layerTilemap);
		DestroyTestLayer(testLayer);
	});
	
	addTestAsync("draw_tile", objTestAsyncDraw, {
		
		ev_create: function() {
		
			var testLayer, layerTilemap;
			
			// Create layer and tilemap for testing (using the tilesAutoAnimated tileset)
			testLayer = CreateTestLayer();
			if (is_undefined(testLayer)) test_end();
			layerTilemap = CreateTestTilemap(testLayer, tilesAuto, 14, 4);
			if (is_undefined(layerTilemap)) test_end();
			
		},
		ev_draw: function() {
			
			var testLayer, layerTilemap, testSurface, output;
			
			// Find layer and tilemap
			testLayer = layer_get_id("testLayer");
			layerTilemap = layer_tilemap_get_id(testLayer);
			
			// Test function
			StartDrawComparison("drawTileTest", "draw_tile(), failed to draw tile correctly");
			draw_tile(tilesAuto, 1, 0, 0, 0);
			EndDrawComparison();
			
			TestInvalidArgs(draw_tile, 5)
			
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