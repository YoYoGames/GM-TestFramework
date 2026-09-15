function ResourceLayersTestSuite() : TestSuite() constructor {

	// LAYER GET/SET TESTS

	addFact("layer_get_set_test #1", function() {

		var output;

		layer_force_draw_depth(true, 0);

		output = layer_get_forced_depth();
		assert_equals(output, 0, "#0.1 layer_force_draw_depth(), failed to force the correct depth value");

	})

	addFact("layer_get_set_test #2", function() {

		var output;

		layer_force_draw_depth(true, 0);

		output = layer_is_draw_depth_forced();
		assert_true(output, "#0.2 layer_force_draw_depth(), failed to enable draw depth force");

	})

	addFact("layer_get_set_test #3", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = 300;
				layer_depth(elementLayer, input);
				output = layer_get_depth(elementLayer);
				assert_equals(output, input, "#1 layer_set/get_depth(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #4", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = shader0;
				layer_shader(elementLayer, input);
				output = layer_get_shader(elementLayer);
				assert_equals(output, input, "#2 layer_set/get_shader(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #5", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = false;
				layer_set_visible(elementLayer, input);
				output = layer_get_visible(elementLayer);
				assert_false(output, "#3 layer_set/get_visible(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #6", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = 5;
				layer_hspeed(elementLayer, input);
				output = layer_get_hspeed(elementLayer);
				assert_equals(output, input, "#4 layer_set/get_hspeed(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #7", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = 2;
				layer_vspeed(elementLayer, input);
				output = layer_get_vspeed(elementLayer);
				assert_equals(output, input, "#5 layer_set/get_vspeed(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #8", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = 100;
				layer_x(elementLayer, input);
				output = layer_get_x(elementLayer);
				assert_equals(output, input, "#6 layer_set/get_x(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	addFact("layer_get_set_test #9", function() {

		var input, output;

		var layers = layer_get_all();

		for (var i = 0; i < array_length(layers); i++) {

			var elements = layer_get_all_elements(layers[i]);

			for (var j = 0; j < array_length(elements); j++) {

				var elementLayer = layer_get_element_layer(elements[j]);
				var elementType = layer_get_element_type(elements[j]);

				var elementTypeString = undefined;
				switch (elementType) {
					case layerelementtype_background: elementTypeString = "background element"; break;
					case layerelementtype_instance: elementTypeString = "instance element"; break;
					case layerelementtype_oldtilemap: elementTypeString = "old tilemap element"; break;
					case layerelementtype_particlesystem: elementTypeString = "particle system element"; break;
					case layerelementtype_sprite: elementTypeString = "sprite element"; break;
					case layerelementtype_tile: elementTypeString = "tile element"; break;
					case layerelementtype_tilemap: elementTypeString = "tilemap element"; break;
					case layerelementtype_sequence: elementTypeString = "sequence element"; break;
					case layerelementtype_undefined: elementTypeString = "undefined element"; break;
				}

				if (elementType == undefined) continue;

				input = 200;
				layer_y(elementLayer, input);
				output = layer_get_y(elementLayer);
				assert_equals(output, input, "#7 layer_set/get_y(), failed to set/get correct value ("+elementTypeString+")");
			}
		}
	})

	// LAYER BACKGROUND TESTS

	addFact("layer_background_test #1", function() {

		var testLayer, output;

		testLayer = layer_create(100, "testLayer");

		output = layer_exists(testLayer);
		assert_true(output, "#1 layer_create(), failed to create a layer");

		layer_destroy(testLayer);

	})

	addFact("layer_background_test #2", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_exists(testLayer, layerBackground);
		assert_true(output, "#2 layer_background_create(), failed to create a new background");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #3", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_alpha(layerBackground);
		assert_equals(output, 1, "#3.1 layer_background_get_alpha(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #4", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_blend(layerBackground);
		assert_equals(output & 0x00ffffff, 0xFFFFFF, "#3.2 layer_background_get_blend(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #5", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_htiled(layerBackground);
		assert_false(output, "#3.3 layer_background_get_htiled(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #6", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_index(layerBackground);
		assert_equals(output, 0, "#3.4 layer_background_get_index(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #7", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_speed(layerBackground);
		assert_equals(output, 1, "#3.5 layer_background_get_speed(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #8", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_sprite(layerBackground);
		assert_equals(output, sprCircle, "#3.6 layer_background_get_sprite(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #9", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_stretch(layerBackground);
		assert_false(output, "#3.7 layer_background_get_stretch(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #10", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_visible(layerBackground);
		assert_true(output, "#3.8 layer_background_get_visible(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #11", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_vtiled(layerBackground);
		assert_false(output, "#3.9 layer_background_get_vtiled(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #12", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_xscale(layerBackground);
		assert_equals(output, 1, "#3.10 layer_background_get_xscale(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #13", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		output = layer_background_get_yscale(layerBackground);
		assert_equals(output, 1, "#3.11 layer_background_get_yscale(), failed to get the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #14", function() {

		// ### GETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_background_get_alpha,
				layer_background_get_blend,
				layer_background_get_htiled,
				layer_background_get_index,
				layer_background_get_speed,
				layer_background_get_sprite,
				layer_background_get_stretch,
				layer_background_get_visible,
				layer_background_get_vtiled,
				layer_background_get_xscale,
				layer_background_get_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args);

					}), "#4 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	})

	addFact("layer_background_test #15", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = 0.5;
		layer_background_alpha(layerBackground, input);
		output = layer_background_get_alpha(layerBackground);
		assert_equals(output, input, "#5.1 layer_background_alpha(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #16", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = c_aqua;
		layer_background_blend(layerBackground, input);
		output = layer_background_get_blend(layerBackground);
		assert_equals(output, input, "#5.2 layer_background_blend(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #17", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = true;
		layer_background_htiled(layerBackground, input);
		output = layer_background_get_htiled(layerBackground);
		assert_true(output, "#5.3 layer_background_htiled(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #18", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = 4;
		layer_background_index(layerBackground, input);
		output = layer_background_get_index(layerBackground);
		assert_equals(output, 0, "#5.4 layer_background_index(), failed to set the correct value (capped)");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #19", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = 5;
		layer_background_speed(layerBackground, input);
		output = layer_background_get_speed(layerBackground);
		assert_equals(output, input, "#5.5 layer_background_speed(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #20", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = sprSquare;
		layer_background_sprite(layerBackground, input);
		output = layer_background_get_sprite(layerBackground);
		assert_equals(output, input, "#5.6 layer_background_sprite(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #21", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		// Move off the creation sprite, so the change below is observable
		layer_background_sprite(layerBackground, sprSquare);

		input = sprCircle;
		layer_background_change(layerBackground, input);
		output = layer_background_get_sprite(layerBackground);
		assert_equals(output, input, "#5.7 layer_background_change(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #22", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = false;
		layer_background_stretch(layerBackground, input);
		output = layer_background_get_stretch(layerBackground);
		assert_false(output, "#5.8 layer_background_stretch(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #23", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = true;
		layer_background_visible(layerBackground, input);
		output = layer_background_get_visible(layerBackground);
		assert_true(output, "#5.9 layer_background_visible(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #24", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = true;
		layer_background_vtiled(layerBackground, input);
		output = layer_background_get_vtiled(layerBackground);
		assert_true(output, "#5.10 layer_background_vtiled(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #25", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = 2;
		layer_background_xscale(layerBackground, input);
		output = layer_background_get_xscale(layerBackground);
		assert_equals(output, input, "#5.11 layer_background_xscale(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #26", function() {

		var testLayer, layerBackground, input, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		input = 0.5;
		layer_background_yscale(layerBackground, input);
		output = layer_background_get_yscale(layerBackground);
		assert_equals(output, input, "#5.12 layer_background_yscale(), failed to set the correct value");

		layer_background_destroy(layerBackground);
		layer_destroy(testLayer);

	})

	addFact("layer_background_test #27", function() {

		// ### SETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_background_alpha,
				layer_background_blend,
				layer_background_htiled,
				layer_background_index,
				layer_background_speed,
				layer_background_sprite,
				layer_background_change,
				layer_background_stretch,
				layer_background_visible,
				layer_background_vtiled,
				layer_background_xscale,
				layer_background_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args, args);

					}), "#6 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	})

	addFact("layer_background_test #28", function() {

		var testLayer, layerBackground, output;

		testLayer = layer_create(100, "testLayer");
		layerBackground = layer_background_create(testLayer, sprCircle);

		layer_background_destroy(layerBackground);
		output = layer_background_exists(testLayer, layerBackground);
		assert_false(output, "#7 layer_background_destroy(), failed to destroy the given layer background");

		layer_destroy(testLayer);

	})

	// LAYER TILE (LEGACY) TESTS

	addFact("layer_tile_test_legacy #1", function() {

		var testLayer, output;

		testLayer = layer_create(100, "testLayer");

		output = layer_exists(testLayer);
		assert_true(output, "#1 layer_create(), failed to create a layer");

		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #2", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_exists(testLayer, layerTile);
		assert_true(output, "#2 layer_tile_create(), failed to create a new tile element");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #3", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_alpha(layerTile);
		assert_equals(output, 1, "#3.1 layer_tile_get_alpha(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #4", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_blend(layerTile);
		assert_equals(output, 0xFFFFFFFF, "#3.2 layer_tile_get_blend(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #5", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_sprite(layerTile);
		assert_equals(output, tilesAuto, "#3.3 layer_tile_get_sprite(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #6", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_region(layerTile);
		assert_array_equals(output, [0, 0, 10, 10], "#3.4 layer_tile_get_region(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #7", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_visible(layerTile);
		assert_true(output, "#3.5 layer_tile_get_visible(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #8", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_x(layerTile);
		assert_equals(output, 100, "#3.6 layer_tile_get_x(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #9", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_xscale(layerTile);
		assert_equals(output, 1, "#3.7 layer_tile_get_xscale(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #10", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_y(layerTile);
		assert_equals(output, 100, "#3.8 layer_tile_get_y(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #11", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		output = layer_tile_get_yscale(layerTile);
		assert_equals(output, 1, "#3.9 layer_tile_get_yscale(), failed to get the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #12", function() {

		// ### GETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_tile_get_alpha,
				layer_tile_get_blend,
				layer_tile_get_sprite,
				layer_tile_get_region,
				layer_tile_get_visible,
				layer_tile_get_x,
				layer_tile_get_xscale,
				layer_tile_get_y,
				layer_tile_get_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args);

					}), "#4 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}
		}

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #13", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = 0.5;
		layer_tile_alpha(layerTile, input);
		output = layer_tile_get_alpha(layerTile);
		assert_equals(output, input, "#5.1 layer_tile_alpha(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #14", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = c_black;
		layer_tile_blend(layerTile, c_black);
		output = layer_tile_get_blend(layerTile);
		assert_equals(output, c_black, "#5.2 layer_tile_blend(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #15", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = sprTilesetReplacement;
		layer_tile_change(layerTile, sprTilesetReplacement);
		output = layer_tile_get_sprite(layerTile);
		assert_equals(output, sprTilesetReplacement, "#5.3 layer_tile_change(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #16", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = [10, 10, 20, 20];
		layer_tile_region(layerTile, input[0], input[1], input[2], input[3]);
		output = layer_tile_get_region(layerTile);
		assert_array_equals(output, [10, 10, 20, 20], "#5.4 layer_tile_region(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #17", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = false;
		layer_tile_visible(layerTile, input);
		output = layer_tile_get_visible(layerTile);
		assert_false(output, "#5.5 layer_tile_visible(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #18", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = 200;
		layer_tile_x(layerTile, input);
		output = layer_tile_get_x(layerTile);
		assert_equals(output, input, "#5.6 layer_tile_x(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #19", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = 2;
		layer_tile_xscale(layerTile, input);
		output = layer_tile_get_xscale(layerTile);
		assert_equals(output, input, "#5.7 layer_tile_xscale(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #20", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = 300;
		layer_tile_y(layerTile, input);
		output = layer_tile_get_y(layerTile);
		assert_equals(output, input, "#5.8 layer_tile_y(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #21", function() {

		var testLayer, layerTile, input, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		input = 5;
		layer_tile_yscale(layerTile, input);
		output = layer_tile_get_yscale(layerTile);
		assert_equals(output, input, "#5.9 layer_tile_yscale(), failed to set the correct value");

		layer_tile_destroy(layerTile);
		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #22", function() {

		// ### SETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_tile_alpha,
				layer_tile_blend,
				layer_tile_change,
				layer_tile_visible,
				layer_tile_x,
				layer_tile_xscale,
				layer_tile_y,
				layer_tile_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args, args);

					}), "#6 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	}, {
		test_filter: runtime_not_gmrt
	})

	addFact("layer_tile_test_legacy #23", function() {

		var testLayer, layerTile, output;

		testLayer = layer_create(100, "testLayer");
		layerTile = layer_tile_create(testLayer, 100, 100, tilesAuto, 0, 0, 10, 10);

		layer_tile_destroy(layerTile);
		output = layer_tile_exists(testLayer, layerTile);
		assert_false(output, "#7 layer_tile_destroy(), failed to destroy the given layer tile element");

		layer_destroy(testLayer);

	}, {
		test_filter: runtime_not_gmrt
	})

	// LAYER INSTANCE TESTS

	addFact("layer_instance_test #1", function() {

		var testLayer, instance, output;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		output = layer_has_instance(testLayer, instance);
		assert_true(output, "#1 layer_add/has_instance(), failed to create/detect the instance in the layer");

		layer_destroy_instances(testLayer);
		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #2", function() {

		var testLayer, instance;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		with (instance) {
			assert_equals(layer, testLayer, "#2 instance.layer, failed to match the specified layer");
		}

		layer_destroy_instances(testLayer);
		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #3", function() {

		var testLayer, instance, elements;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		elements = layer_get_all_elements(testLayer);
		assert_array_length(elements, 1, "#3 layer_get_all_elements(), failed to return the correct number of elements (instances)");

		layer_destroy_instances(testLayer);
		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #4", function() {

		var testLayer, instance, elements, element, output;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		elements = layer_get_all_elements(testLayer);
		element = elements[0];

		output = layer_get_element_type(element);
		assert_equals(output, layerelementtype_instance, "#4 layer_get_element_type(), failed to return the correct element type (instance)");

		layer_destroy_instances(testLayer);
		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #5", function() {

		var testLayer, instance, elements, element, output;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		elements = layer_get_all_elements(testLayer);
		element = elements[0];

		output = layer_instance_get_instance(element);
		assert_equals(output, instance, "#5 layer_instance_get_instance(), failed to return the previously created instance");

		layer_destroy_instances(testLayer);
		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #6", function() {

		var testLayer, instance, output;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		layer_destroy_instances(testLayer);
		output = layer_get_all_elements(testLayer);
		assert_array_length(output, 0, "#6 layer_destroy_instances(), failed destroy the layer elements (instances)");

		layer_destroy(testLayer);

	})

	addFact("layer_instance_test #7", function() {

		var testLayer, instance, output;

		testLayer = layer_create(100, "testInstanceLayer");
		instance = instance_create_depth(10, 10, 400, oTest); // 1 element
		layer_add_instance(testLayer, instance);

		layer_destroy_instances(testLayer);
		output = instance_exists(instance);
		assert_false(output, "#7 layer_destroy_instances(), failed destroy the layer instances");

		layer_destroy(testLayer);

	})

	// LAYER SCRIPT TESTS

	addFact("layer_script_test #1", function() {

		var output, testLayer = layer_create(100, "testLayer");

		output = layer_get_script_begin(testLayer);
		assert_equals(output, -1, "#1.1 layer_get_script_begin(), failed to get the correct script (not set).");

		layer_destroy(testLayer);

	})

	addFact("layer_script_test #2", function() {

		var output, testLayer = layer_create(100, "testLayer");

		output = layer_get_script_end(testLayer);
		assert_equals(output, -1, "#1.2 layer_get_script_end(), failed to get the correct script (not set).");

		layer_destroy(testLayer);

	})

	addFact("layer_script_test #3", function() {

		var input, output, testLayer = layer_create(100, "testLayer");

		input = function() { /* function 1 */ };
		layer_script_begin(testLayer, input);
		output = layer_get_script_begin(testLayer);
		assert_equals(output, input, "#2.1 layer_script_begin(), failed to set the correct script.");

		layer_destroy(testLayer);

	})

	addFact("layer_script_test #4", function() {

		var input, output, testLayer = layer_create(100, "testLayer");

		input = function() { /* function 2 */ };
		layer_script_end(testLayer, input);
		output = layer_get_script_end(testLayer);
		assert_equals(output, input, "#2.2 layer_script_end(), failed to set the correct script.");

		layer_destroy(testLayer);

	})

	addFact("layer_script_test #5", function() {

		// ### FAILURES ###

		if (TEST_INVALID_ARGS) {

			var valueType, value, details;

			var valueDetails = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "testLayer",		"string"],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ] ];

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {

				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];

				assert_throw(method({input: value}, function() {

					layer_script_begin(input, input);

				}), "#3.1 layer_script_begin("+ details +"):, failed to detect invalid arguemnts");
			}

		}

	})

	addFact("layer_script_test #6", function() {

		// ### FAILURES ###

		if (TEST_INVALID_ARGS) {

			var valueType, value, details;

			var valueDetails = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "testLayer",		"string"],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ] ];

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {

				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];

				assert_throw(method({input: value}, function() {

					layer_script_end(input, input);

				}), "#3.2 layer_script_end("+ details +"):, failed to detect invalid arguemnts");
			}

		}

	})

	// LAYER TARGET ROOM TESTS

	addFact("layer_target_room_test #1", function() {

		var output;

		output = layer_get_target_room();
		assert_equals(output, -1, "#1 layer_get_target_room(), failed to return the correct value (room not set)");

	})

	addFact("layer_target_room_test #2", function() {

		var input, output;

		input = room1;
		layer_set_target_room(input);
		output = layer_get_target_room();
		assert_equals(output, input, "#2 layer_set_target_room(), failed to set the correct right value");

		layer_reset_target_room();

	})

	addFact("layer_target_room_test #3", function() {

		var output;

		layer_set_target_room(room1);

		layer_reset_target_room();
		output = layer_get_target_room();
		assert_equals(output, -1, "#3 layer_reset_target_room(), failed to reset target room");

	})

	addFact("layer_target_room_test #4", function() {

		// ### FAILURES ###

		if (TEST_INVALID_ARGS) {

			var valueType, value, details;

			var valueDetails = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "testLayer",		"string"],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ] ];

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {

				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];

				assert_throw(method({input: value}, function() {

					layer_set_target_room(input);

				}), "#4 layer_set_target_room("+ details +"):, failed to detect invalid arguemnts");
			}

			layer_reset_target_room();

		}

	})

	// LAYER SPRITE TESTS

	addFact("layer_sprite_test #1", function() {

		var testLayer, output;

		testLayer = layer_create(100, "testLayer");

		output = layer_exists(testLayer);
		assert_true(output, "#1 layer_create(), failed to create a layer");

		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #2", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_exists(testLayer, layerSprite);
		assert_true(output, "#2 layer_sprite_create(), failed to create a new sprite");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #3", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_x(layerSprite);
		assert_equals(output, 100, "#3.1 layer_sprite_get_x(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #4", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_y(layerSprite);
		assert_equals(output, 100, "#3.2 layer_sprite_get_y(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #5", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_xscale(layerSprite);
		assert_equals(output, 1, "#3.3 layer_sprite_get_xscale(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #6", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_yscale(layerSprite);
		assert_equals(output, 1, "#3.4 layer_sprite_get_yscale(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #7", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_alpha(layerSprite);
		assert_equals(output, 1, "#3.5 layer_sprite_get_alpha(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #8", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_angle(layerSprite);
		assert_equals(output, 0, "#3.6 layer_sprite_get_angle(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #9", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_blend(layerSprite);
		assert_equals(output & 0xffffff, 0xFFFFFF, "#3.7 layer_sprite_get_blend(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #10", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		output = layer_sprite_get_sprite(layerSprite);
		assert_equals(output, sprSquare, "#3.8 layer_sprite_get_sprite(), failed to get the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #11", function() {

		// ### GETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_sprite_get_x,
				layer_sprite_get_y,
				layer_sprite_get_xscale,
				layer_sprite_get_yscale,
				layer_sprite_get_alpha,
				layer_sprite_get_angle,
				layer_sprite_get_blend,
				layer_sprite_get_sprite ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args);

					}), "#4 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	})

	addFact("layer_sprite_test #12", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 0.5;
		layer_sprite_alpha(layerSprite, input);
		output = layer_sprite_get_alpha(layerSprite);
		assert_equals(output, input, "#5.1 layer_sprite_alpha(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #13", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 135;
		layer_sprite_angle(layerSprite, input);
		output = layer_sprite_get_angle(layerSprite);
		assert_equals(output, input, "#5.2 layer_sprite_angle(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #14", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = c_red;
		layer_sprite_blend(layerSprite, input);
		output = layer_sprite_get_blend(layerSprite);
		assert_equals(output, input, "#5.3 layer_sprite_blend(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #15", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = sprCircle;
		layer_sprite_change(layerSprite, input);
		output = layer_sprite_get_sprite(layerSprite);
		assert_equals(output, input, "#5.4 layer_sprite_change(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #16", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 0;
		layer_sprite_index(layerSprite, input);
		output = layer_sprite_get_index(layerSprite);
		assert_equals(output, input, "#5.5 layer_sprite_index(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #17", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 2;
		layer_sprite_speed(layerSprite, input);
		output = layer_sprite_get_speed(layerSprite);
		assert_equals(output, input, "#5.6 layer_sprite_speed(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #18", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 200;
		layer_sprite_x(layerSprite, input);
		output = layer_sprite_get_x(layerSprite);
		assert_equals(output, input, "#5.7 layer_sprite_x(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #19", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 5;
		layer_sprite_xscale(layerSprite, input);
		output = layer_sprite_get_xscale(layerSprite);
		assert_equals(output, input, "#5.8 layer_sprite_xscale(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #20", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 300;
		layer_sprite_y(layerSprite, input);
		output = layer_sprite_get_y(layerSprite);
		assert_equals(output, input, "#5.9 layer_sprite_y(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #21", function() {

		var testLayer, layerSprite, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		input = 2;
		layer_sprite_yscale(layerSprite, input);
		output = layer_sprite_get_yscale(layerSprite);
		assert_equals(output, input, "#5.10 layer_sprite_yscale(), failed to set the correct value");

		layer_sprite_destroy(layerSprite);
		layer_destroy(testLayer);

	})

	addFact("layer_sprite_test #22", function() {

		// ### SETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_sprite_alpha,
				layer_sprite_angle,
				layer_sprite_blend,
				layer_sprite_change,
				layer_sprite_index,
				layer_sprite_speed,
				layer_sprite_x,
				layer_sprite_xscale,
				layer_sprite_y,
				layer_sprite_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args, args);

					}), "#6 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	})

	addFact("layer_sprite_test #23", function() {

		var testLayer, layerSprite, output;

		testLayer = layer_create(100, "testLayer");
		layerSprite = layer_sprite_create(testLayer, 100, 100, sprSquare);

		layer_sprite_destroy(layerSprite);
		output = layer_sprite_exists(testLayer, layerSprite);
		assert_false(output, "#7 layer_sprite_destroy(), failed to destroy the given layer sprite");

		layer_destroy(testLayer);

	})

	// LAYER TILEMAP TESTS

	addFact("layer_tilemap_test #1", function() {

		var testLayer, output;

		testLayer = layer_create(100, "testLayer");

		output = layer_exists(testLayer);
		assert_true(output, "#1 layer_create(), failed to create a layer");

		layer_destroy(testLayer);

	})

	addFact("layer_tilemap_test #2", function() {

		var testLayer, layerTilemap, output;

		testLayer = layer_create(100, "testLayer");
		layerTilemap = layer_tilemap_create(testLayer, 0, 0, tilesAuto, 10, 10);

		output = layer_tilemap_exists(testLayer, layerTilemap);
		assert_true(output, "#2 layer_tilemap_create(), failed to create a new tilemap element");

		layer_tilemap_destroy(layerTilemap);
		layer_destroy(testLayer);

	})

	addFact("layer_tilemap_test #3", function() {

		var testLayer, layerTilemap, output;

		testLayer = layer_create(100, "testLayer");
		layerTilemap = layer_tilemap_create(testLayer, 0, 0, tilesAuto, 10, 10);

		layer_tilemap_destroy(layerTilemap);
		output = layer_tilemap_exists(testLayer, layerTilemap);
		assert_false(output, "#3 layer_tilemap_destroy(), failed to destroy tilemap element");

		layer_destroy(testLayer);

	})

	// LAYER SEQUENCE TESTS

	addFact("layer_sequence_test #1", function() {

		var testLayer, output;

		testLayer = layer_create(100, "testLayer");

		output = layer_exists(testLayer);
		assert_true(output, "#1 layer_create(), failed to create a layer");

		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #2", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_exists(testLayer, layerSequence);
		assert_true(output, "#2 layer_sequence_create(), failed to create a new sequence element");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #3", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_angle(layerSequence);
		assert_equals(output, 0, "#3.1 layer_sequence_get_angle(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #4", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_headdir(layerSequence);
		assert_equals(output, 1, "#3.2 layer_sequence_get_headdir(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #5", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_headpos(layerSequence);
		assert_equals(output, 0, "#3.3 layer_sequence_get_headpos(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #6", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_instance(layerSequence);
		assert_typeof(output, "struct", "#3.4 layer_sequence_get_instance(), failed to get the correct value type (struct)");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #7", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_length(layerSequence);
		assert_equals(output, 60, "#3.5 layer_sequence_get_length(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #8", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_sequence(layerSequence);
		assert_typeof(output, "struct", "#3.6 layer_sequence_get_sequence(), failed to get the correct value type (struct)");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #9", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_speedscale(layerSequence);
		assert_equals(output, 1, "#3.7 layer_sequence_get_speedscale(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #10", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_x(layerSequence);
		assert_equals(output, 10, "#3.8 layer_sequence_get_x(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #11", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_xscale(layerSequence);
		assert_equals(output, 1, "#3.9 layer_sequence_get_xscale(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #12", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_y(layerSequence);
		assert_equals(output, 40, "#3.10 layer_sequence_get_y(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #13", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		output = layer_sequence_get_yscale(layerSequence);
		assert_equals(output, 1, "#3.11 layer_sequence_get_yscale(), failed to get the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #14", function() {

		// ### GETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_sequence_get_angle,
				layer_sequence_get_headdir,
				layer_sequence_get_headpos,
				layer_sequence_get_instance,
				layer_sequence_get_length,
				layer_sequence_get_sequence,
				layer_sequence_get_speedscale,
				layer_sequence_get_x,
				layer_sequence_get_xscale,
				layer_sequence_get_y,
				layer_sequence_get_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args);

					}), "#4 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}
		}

	})

	addFact("layer_sequence_test #15", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 13;
		layer_sequence_angle(layerSequence, input);
		output = layer_sequence_get_angle(layerSequence);
		assert_equals(output, input, "#5.1 layer_sequence_angle(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #16", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = seqdir_left;
		layer_sequence_headdir(layerSequence, input);
		output = layer_sequence_get_headdir(layerSequence);
		assert_equals(output, input, "#5.2 layer_sequence_headdir(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #17", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 30;
		layer_sequence_headpos(layerSequence, input);
		output = layer_sequence_get_headpos(layerSequence);
		assert_equals(output, input, "#5.3 layer_sequence_headpos(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #18", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 3.3;
		layer_sequence_speedscale(layerSequence, input);
		output = layer_sequence_get_speedscale(layerSequence);
		assert_equals(output, input, "#5.4 layer_sequence_speedscale(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #19", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 300;
		layer_sequence_x(layerSequence, input);
		output = layer_sequence_get_x(layerSequence);
		assert_equals(output, input, "#5.5 layer_sequence_x(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #20", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 1.5;
		layer_sequence_xscale(layerSequence, input);
		output = layer_sequence_get_xscale(layerSequence);
		assert_equals(output, input, "#5.6 layer_sequence_xscale(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #21", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 100;
		layer_sequence_y(layerSequence, input);
		output = layer_sequence_get_y(layerSequence);
		assert_equals(output, input, "#5.7 layer_sequence_y(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #22", function() {

		var testLayer, layerSequence, input, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		input = 0.5;
		layer_sequence_yscale(layerSequence, input);
		output = layer_sequence_get_yscale(layerSequence);
		assert_equals(output, input, "#5.8 layer_sequence_yscale(), failed to set the correct value");

		layer_sequence_destroy(layerSequence);
		layer_destroy(testLayer);

	})

	addFact("layer_sequence_test #23", function() {

		// ### SETTERS (FAILURES) ###

		if (TEST_INVALID_ARGS) {

			var invalidArgs = [
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ];

			var funcData = [
				layer_sequence_angle,
				layer_sequence_headdir,
				layer_sequence_headpos,
				layer_sequence_speedscale,
				layer_sequence_x,
				layer_sequence_xscale,
				layer_sequence_y,
				layer_sequence_yscale ];

			var funcDataCount = array_length(funcData);
			for (var i = 0; i < funcDataCount; i++) {

				var func = funcData[i];
				var funcDesc = script_get_name(func);

				var invalidArgsCount = array_length(invalidArgs);
				for (var j = 0; j < invalidArgsCount; j++) {

					var invalidArg = invalidArgs[j];
					var value = invalidArg[0];
					var details = invalidArg[1];

					assert_throw(method({targetFunc: func, args: value}, function() {

						targetFunc(args, args);

					}), "#6 "+funcDesc+"("+ details +"):, failed to detect invalid arguemnts");
				}
			}

		}

	})

	addFact("layer_sequence_test #24", function() {

		var testLayer, layerSequence, output;

		testLayer = layer_create(100, "testLayer");
		layerSequence = layer_sequence_create(testLayer, 10, 40, Sequence1);

		layer_sequence_destroy(layerSequence);
		output = layer_sequence_exists(testLayer, layerSequence);
		assert_false(output, "#7 layer_sequence_destroy(), failed to destroy the given layer sequence element");

		layer_destroy(testLayer);

	});

}
