/// @function RoomGetInfoFindInstance(instances, id)
/// @description The entry for an instance id in a room_get_info instances array, undefined if it isn't there.
/// @param {Array<Struct>} instances The instances array from room_get_info.
/// @param {Id.Instance} id The instance id to look for.
/// @return {Struct|Undefined}
function RoomGetInfoFindInstance(_instances, _id) {
	for (var _i = 0; _i < array_length(_instances); ++_i) {
		if (_instances[_i].id == _id) return _instances[_i];
	}
	return undefined;
}



function BasicRoomTestSuite() : TestSuite() constructor {

	addTestAsync("room_goto_test", objTestAsyncRoomChange, {
		
		ev_create: function() {
			
			// At this point in time the room is ALWAYS 'rmEmpty'
			// This is an internal room where all the tests start
			
			// Create your object (make sure it is persistent)
			
			room_goto(room0);
		},
		
		ev_room_start: function() {
			
			show_debug_message(room);
			show_debug_message(room0);
			
			assert_true(room == room0, "The room didn't change!");
			
			// Check if your object exists (it should if it is persistent)
			
			// The test only ends when you call this
			test_end(); // Be sure to call this
		},
		
		ev_room_end: function() {
			
			// You can add code here too!
			
		},
	}, {
		// Make sure we give this test a timeout (1 second is enough for this test)
		test_timeout_millis: 1000 
	});
	
	addFact("room_get_info_variables_test", function() {
		
		// views, instances, layers, layer_elements, tilemap_data, live, variables
		var _info = room_get_info(rmVariables, false, true, false, false, false, false, true);
		var _instances = _info.instances;
		assert_equals(array_length(_instances), 5, "room_get_info should return every instance in the room");
		
		// No overrides, variables should hold the object defaults
		var _vars = _instances[0].variables;
		assert_struct_equals(_vars, { hp : 10, label : "parent", ratio : 2.5 }, "variables should contain the object variable defaults");
		
		// Instance override, the remaining defaults should still be there
		_vars = _instances[1].variables;
		assert_equals(_vars.hp, 50, "variables should contain the instance override");
		assert_equals(_vars.label, "parent", "variables should contain the defaults that were not overridden");
		
		// Child object, inherited defaults + object override + instance override
		_vars = _instances[2].variables;
		assert_equals(_vars.hp, 10, "variables should contain the inherited defaults");
		assert_equals(_vars.label, "child", "variables should contain the child object override");
		assert_equals(_vars.armour, 7, "variables should contain the instance override of the child variable");
		
		// Object without any variable definitions or pre creation code
		assert_true(struct_exists(_instances[3], "variables"), "variables should always be present");
		assert_undefined(_instances[3].variables, "variables should be undefined for an object without variable definitions");
		
		// Child object with no definitions of its own, everything comes from the parent
		_vars = _instances[4].variables;
		assert_struct_equals(_vars, { hp : 10, label : "parent", ratio : 2.5 }, "variables should contain the defaults inherited from the parent");
	});
	
	addFact("room_get_info_variables_off_test", function() {
		
		// variables defaults to false, every instance gets an undefined variables (even the ones with definitions)
		var _instances = room_get_info(rmVariables, false, true, false, false, false).instances;
		assert_equals(array_length(_instances), 5, "room_get_info should return every instance in the room");
		for (var _i = 0; _i < array_length(_instances); ++_i) {
			assert_true(struct_exists(_instances[_i], "variables"), "variables should always be present");
			assert_undefined(_instances[_i].variables, "variables should be undefined when it is not asked for");
		}
		
		// the same when it is explicitly false
		_instances = room_get_info(rmVariables, false, true, false, false, false, false, false).instances;
		for (var _i = 0; _i < array_length(_instances); ++_i) {
			assert_undefined(_instances[_i].variables, "variables should be undefined when it is false");
		}
	});

	// The live argument (GameMaker-Bugs#16349): for the current room, and a persistent room that has been visited,
	// room_get_info reports the instances as they are now - moved, created, destroyed and deactivated - instead of
	// as they were laid out in the room editor. rmRoomGetInfo is persistent and has three instances placed in it:
	// oEmpty at (64,64) with creation code, oEmpty at (128,64) and oVarParent at (192,64).
	addTestAsync("room_get_info_live_instances_test", objTestAsyncRoomChange, {

		ev_create: function() {
			stage = 0;
			room_goto(rmRoomGetInfo);
		},

		ev_room_start: function() {

			if (room == rmRoomGetInfo && stage == 0) {

				// views, instances, layers, layer_elements, tilemap_data, live
				var _static = room_get_info(rmRoomGetInfo, false, true, false, false, false, false).instances;
				assert_equals(array_length(_static), 3, "room_get_info (not live) should return the placed instances");

				inst_moved = _static[0].id;
				inst_destroyed = _static[1].id;
				inst_var = _static[2].id;
				placed_creation_code = _static[0].creation_code;
				assert_not_equals(placed_creation_code, -1, "the first placed instance should have creation code");

				// change the room: move one (and change how it is drawn), destroy one, create one, create and deactivate one
				with (inst_moved) {
					x = 200;
					y = 150;
					image_xscale = 2;
					image_alpha = 0.5;
					image_blend = c_red;
				}
				instance_destroy(inst_destroyed);
				inst_created = instance_create_layer(300, 300, "Instances", oEmpty);
				inst_deactivated = instance_create_layer(400, 400, "Instances", oEmpty);
				instance_deactivate_object(inst_deactivated);

				stage = 1;
			}
			else if (room == room1 && stage == 3) {

				// rmRoomGetInfo is persistent and has been visited, so live still reports it as it was left
				var _live = room_get_info(rmRoomGetInfo, false, true, false, false, false, true).instances;
				var _moved = RoomGetInfoFindInstance(_live, inst_moved);
				assert_not_undefined(_moved, "live room_get_info of a visited persistent room should have the moved instance");
				if (!is_undefined(_moved)) {
					assert_equals(_moved.x, 200, "live room_get_info of a visited persistent room should have the moved x");
					assert_equals(_moved.y, 150, "live room_get_info of a visited persistent room should have the moved y");
				}
				assert_undefined(RoomGetInfoFindInstance(_live, inst_destroyed), "live room_get_info of a visited persistent room should not have the destroyed instance");
				assert_not_undefined(RoomGetInfoFindInstance(_live, inst_created), "live room_get_info of a visited persistent room should have the created instance");
				assert_not_undefined(RoomGetInfoFindInstance(_live, inst_deactivated), "live room_get_info of a visited persistent room should have the deactivated instance");
				assert_undefined(RoomGetInfoFindInstance(_live, id), "live room_get_info of a visited persistent room should not have the persistent test instance, it left with us");

				test_end();
			}
		},

		ev_step: function() {

			// a step after the changes, so the destroy and deactivate have been processed
			if (stage == 1) {
				stage = 2;
				return;
			}
			if (stage != 2) return;

			// move on first, so if anything below throws the test fails once and times out instead of repeating every step
			stage = 3;

			var _live = room_get_info(room, false, true, false, false, false, true).instances;

			var _moved = RoomGetInfoFindInstance(_live, inst_moved);
			assert_not_undefined(_moved, "live room_get_info should have the moved instance");
			if (!is_undefined(_moved)) {
				assert_equals(_moved.x, 200, "live room_get_info should report the current x");
				assert_equals(_moved.y, 150, "live room_get_info should report the current y");
				assert_equals(_moved.xscale, 2, "live room_get_info should report the current image_xscale");
				assert_equals(_moved.object_index, "oEmpty", "live room_get_info should report the object name");
				assert_equals(_moved.colour, (128 << 24) | c_red, "live room_get_info should report the current image_blend and image_alpha as the colour");
				assert_equals(_moved.creation_code, placed_creation_code, "live room_get_info should keep the creation code of a placed instance");
			}

			assert_undefined(RoomGetInfoFindInstance(_live, inst_destroyed), "live room_get_info should not have a destroyed instance");

			var _created = RoomGetInfoFindInstance(_live, inst_created);
			assert_not_undefined(_created, "live room_get_info should have an instance created at runtime");
			if (!is_undefined(_created)) {
				assert_equals(_created.x, 300, "live room_get_info should report the created instance's x");
				assert_equals(_created.creation_code, -1, "an instance created at runtime has no creation code");
				assert_equals(_created.pre_creation_code, -1, "an instance created at runtime has no pre creation code");
			}

			assert_not_undefined(RoomGetInfoFindInstance(_live, inst_deactivated), "live room_get_info should have a deactivated instance");
			assert_not_undefined(RoomGetInfoFindInstance(_live, id), "live room_get_info should have the test instance (it is in this room)");

			// the variable definitions are still reported for live instances
			var _withVars = room_get_info(room, false, true, false, false, false, true, true).instances;
			var _var = RoomGetInfoFindInstance(_withVars, inst_var);
			assert_not_undefined(_var, "live room_get_info should have the placed oVarParent instance");
			if (!is_undefined(_var)) {
				assert_struct_equals(_var.variables, { hp : 10, label : "parent", ratio : 2.5 }, "live room_get_info should report the variable definitions");
			}

			// not live is unchanged: the room as laid out in the room editor
			var _static = room_get_info(room, false, true, false, false, false, false).instances;
			assert_equals(array_length(_static), 3, "room_get_info (not live) should still return only the placed instances");
			if (array_length(_static) == 3) {
				assert_equals(_static[0].x, 64, "room_get_info (not live) should still return the placed x");
				assert_equals(_static[0].y, 64, "room_get_info (not live) should still return the placed y");
				assert_not_undefined(RoomGetInfoFindInstance(_static, inst_destroyed), "room_get_info (not live) should still return a destroyed placed instance");
			}

			// live for a room that isn't running (not current, not a visited persistent room) is the room editor layout
			assert_equals(array_length(room_get_info(rmVariables, false, true, false, false, false, true).instances), 5,
				"live room_get_info of a room that isn't running should return the placed instances");

			room_goto(room1);
		},
	}, {
		test_timeout_millis: 3000
	});

	addFact("room_get_info_live_layers_test", function() {

		var _layer = layer_create(-500, "rgi_live_layer");
		layer_x(_layer, 7);
		var _tilemap = layer_tilemap_create(_layer, 16, 32, tilesAuto, 4, 3);
		tilemap_set(_tilemap, 5, 1, 1);
		var _sprite = layer_sprite_create(_layer, 10, 20, sprSquare);
		layer_sprite_xscale(_sprite, 3);
		layer_sprite_blend(_sprite, c_red);
		var _background = layer_background_create(_layer, sprSquare);
		layer_background_blend(_background, c_orange);

		// views, instances, layers, layer_elements, tilemap_data, live
		var _info = room_get_info(room, true, false, true, true, true, true);
		assert_true(is_array(_info.views), "live room_get_info should return the views");

		var _found = undefined;
		for (var _i = 0; _i < array_length(_info.layers); ++_i) {
			if (_info.layers[_i].name == "rgi_live_layer") _found = _info.layers[_i];
		}
		assert_not_undefined(_found, "live room_get_info should have a layer created at runtime");

		if (!is_undefined(_found)) {
			assert_equals(_found.xoffset, 7, "live room_get_info should report the layer's current x offset");

			var _tm = undefined, _spr = undefined, _back = undefined;
			for (var _i = 0; _i < array_length(_found.elements); ++_i) {
				var _el = _found.elements[_i];
				if (_el.type == layerelementtype_tilemap) _tm = _el;
				if (_el.type == layerelementtype_sprite) _spr = _el;
				if (_el.type == layerelementtype_background) _back = _el;
			}

			assert_not_undefined(_tm, "live room_get_info should have the tilemap element");
			if (!is_undefined(_tm)) {
				assert_equals(_tm.x, 16, "live room_get_info should report the tilemap x");
				assert_equals(_tm.y, 32, "live room_get_info should report the tilemap y");
				assert_equals(_tm.width, 4, "live room_get_info should report the tilemap width");
				assert_equals(_tm.height, 3, "live room_get_info should report the tilemap height");
				assert_equals(array_length(_tm.tiles), 12, "live room_get_info should return every tile");
				if (array_length(_tm.tiles) == 12) {
					assert_equals(tile_get_index(_tm.tiles[1 * 4 + 1]), 5, "live room_get_info should report the tile that was set");
					assert_equals(tile_get_index(_tm.tiles[0]), 0, "live room_get_info should report the empty tiles");
				}
			}

			assert_not_undefined(_spr, "live room_get_info should have the sprite element");
			if (!is_undefined(_spr)) {
				assert_equals(_spr.x, 10, "live room_get_info should report the sprite element x");
				assert_equals(_spr.y, 20, "live room_get_info should report the sprite element y");
				assert_equals(_spr.image_xscale, 3, "live room_get_info should report the sprite element's current x scale");
				assert_equals(_spr.sprite_index, sprSquare, "live room_get_info should report the sprite element's sprite");
				assert_equals(_spr.image_blend, c_red, "live room_get_info should report the sprite element's blend colour");
			}

			// c_orange has different red and blue, so a swapped colour would not match
			assert_not_undefined(_back, "live room_get_info should have the background element");
			if (!is_undefined(_back)) {
				assert_equals(_back.blendColour, c_orange, "live room_get_info should report the background element's blend colour");
			}
		}

		// not live is the room as laid out in the room editor, without the layer created at runtime
		var _static = room_get_info(room, false, false, true, false, false, false);
		for (var _i = 0; _i < array_length(_static.layers); ++_i) {
			assert_not_equals(_static.layers[_i].name, "rgi_live_layer", "room_get_info (not live) should not have a layer created at runtime");
		}

		layer_destroy(_layer);
	});
}
