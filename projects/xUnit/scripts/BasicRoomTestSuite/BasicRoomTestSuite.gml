

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
		
		var _info = room_get_info(rmVariables, false, true, false, false, false);
		var _instances = _info.instances;
		assert_equals(array_length(_instances), 4, "room_get_info should return every instance in the room");
		
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
		
		// Object without any variable definitions
		_vars = _instances[3].variables;
		assert_true(is_struct(_vars), "variables should always be a struct");
		assert_equals(array_length(struct_get_names(_vars)), 0, "variables should be empty for an object without variable definitions");
	});
}
