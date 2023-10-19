

function ResourceEventsTestSuite() : TestSuite() constructor {

	addFact("event_perform_object_test", function() {

		var events, subEvents, event, subEvent, func = "#1 event_perform_object()";
	
		var instance = instance_create_depth(0, 0, 0, oEvents);
		with (instance) {
	
			var contextObj = object_index;
	
			// ### CREATE ###
			
			event = ev_create;
			subEvent = 0;
					
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform_object(oEvents, event, subEvent);
			
			// ### STEP ###
			
			events = [ ev_step ];
			subEvents = [ ev_step_begin, ev_step_end, ev_step_normal ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}

			// ### ALARM ###
			
			events = [ ev_alarm ];
			subEvents = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}

			// ### KEYBOARD ###
			
			events = [ ev_keyboard, ev_keypress, ev_keyrelease ];
			subEvents = [ vk_left, vk_right, vk_up, vk_down, vk_control, vk_alt, vk_shift, vk_space, vk_enter,
							vk_numpad0, vk_numpad1, vk_numpad2, vk_numpad3, vk_numpad4, vk_numpad5, vk_numpad6, vk_numpad7, vk_numpad8, vk_numpad9,
							vk_divide, vk_multiply, vk_subtract, vk_add, vk_decimal,
							ord("0"), ord("1"), ord("2"), ord("3"), ord("4"), ord("5"), ord("6"), ord("7"), ord("8"), ord("9"),
							ord("A"), ord("B"), ord("C"), ord("D"), ord("E"), ord("F"), ord("G"), ord("H"), ord("I"), ord("J"),
							ord("K"), ord("L"), ord("M"), ord("N"), ord("O"), ord("P"), ord("Q"), ord("R"), ord("S"), ord("T"),
							ord("U"), ord("V"), ord("W"), ord("X"), ord("Y"), ord("Z"),
							vk_f1, vk_f2, vk_f3, vk_f4, vk_f5, vk_f6, vk_f7, vk_f8, vk_f9, vk_f10, vk_f11, vk_f12,
							vk_backspace, vk_tab, vk_escape, vk_home, vk_end, vk_pageup, vk_pagedown, vk_delete, vk_insert,
							vk_nokey, vk_anykey ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}

			// ### MOUSE ###
			
			events = [ ev_mouse ];
			subEvents = [ ev_global_left_button, ev_global_left_press, ev_global_left_release,
							ev_global_middle_button, ev_global_middle_press, ev_global_middle_release,
							ev_global_right_button, ev_global_right_press, ev_global_right_release,
							ev_left_button, ev_left_press, ev_left_release, ev_middle_button, ev_middle_press,
							ev_middle_release, ev_mouse_enter, ev_mouse_leave, ev_mouse_wheel_down, ev_mouse_wheel_up,
							ev_no_button, ev_right_button, ev_right_press, ev_right_release ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}

			// ### GESTURE ###
			
			events = [ ev_gesture ];
			subEvents = [ ev_gesture_double_tap, ev_gesture_drag_end, ev_gesture_drag_start, ev_gesture_dragging, ev_gesture_flick,
							ev_gesture_pinch_end, ev_gesture_pinch_in, ev_gesture_pinch_out, ev_gesture_pinch_start,
							ev_gesture_rotate_end, ev_gesture_rotate_start, ev_gesture_rotating, ev_gesture_tap, ev_global_gesture_double_tap,
							ev_global_gesture_drag_end, ev_global_gesture_drag_start, ev_global_gesture_dragging,
							ev_global_gesture_flick,
							ev_global_gesture_pinch_end, ev_global_gesture_pinch_in, ev_global_gesture_pinch_out, ev_global_gesture_pinch_start,
							ev_global_gesture_rotate_end, ev_global_gesture_rotate_start, ev_global_gesture_rotating, ev_global_gesture_tap ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}

			// ### COLLISION ###
			
			events = [ ev_collision ];
			subEvents = [ oTest, oOther ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}
			
			// ### OTHER ###
			
			events = [ ev_other ];
			subEvents = [ ev_outside, ev_boundary, ev_game_start, ev_game_end, ev_room_start, ev_room_end,
							ev_no_more_lives, ev_no_more_health, ev_animation_end, ev_end_of_path, ev_user0,
							ev_user1, ev_user2, ev_user3, ev_user4, ev_user5, ev_user6, ev_user7, ev_user8, ev_user9,
							ev_user10, ev_user11, ev_user12, ev_user13, ev_user14, ev_user15 ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}


			// ### DRAW ###
			
			events = [ ev_draw ];
			subEvents = [ ev_draw_begin, ev_draw_end, ev_draw_post, ev_draw_pre, ev_gui, ev_gui_begin, ev_gui_end ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform_object(oEvents, event, subEvent);
				}
			}
			
			// ### CLEANUP ###
			
			event = ev_cleanup;
			subEvent = 0;
			
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform_object(oEvents, event, subEvent);
			
			// ### DESTROY ###
			
			event = ev_destroy;
			subEvent = 0;
			
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform_object(oEvents, event, subEvent);
		}
			
		variable_struct_remove(global, "eventData");
			
		instance_destroy(instance);
			
		// ### FAILURES ###
		
		if (TEST_INVALID_ARGS) {

			var valueType, value, details;
				
			var valueDetails = [ 
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ]; 

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				assert_throw(method({input: value}, function() {
					
					event_perform_object(oEvents, ev_draw, input);

				}), "#2.1 event_perform_object("+ details +"):, failed to detect invalid arguemnts");

				
				assert_throw(method({input: value}, function() {
					
					event_perform_object(oEvents, input, input);

				}), "#2.2 event_perform_object("+ details +"):, failed to detect invalid arguemnts");

				
				assert_throw(method({input: value}, function() {
					
					event_perform_object(input, input, input);

				}), "#2.3 event_perform_object("+ details +"):, failed to detect invalid arguemnts");
			}
		
		}

	})

	addFact("event_perform_test", function() {

		var events, subEvents, event, subEvent, func = "#1 event_perform()";
	
		var instance = instance_create_depth(0, 0, 0, oEvents);
		with (instance) {
	
			var contextObj = object_index;
	
			// ### CREATE ###
			
			event = ev_create;
			subEvent = 0;
					
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform(event, subEvent);
			
			// ### STEP ###
			
			events = [ ev_step ];
			subEvents = [ ev_step_begin, ev_step_end, ev_step_normal ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}

			// ### ALARM ###
			
			events = [ ev_alarm ];
			subEvents = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}

			// ### KEYBOARD ###
			
			events = [ ev_keyboard, ev_keypress, ev_keyrelease ];
			subEvents = [ vk_left, vk_right, vk_up, vk_down, vk_control, vk_alt, vk_shift, vk_space, vk_enter,
							vk_numpad0, vk_numpad1, vk_numpad2, vk_numpad3, vk_numpad4, vk_numpad5, vk_numpad6, vk_numpad7, vk_numpad8, vk_numpad9,
							vk_divide, vk_multiply, vk_subtract, vk_add, vk_decimal,
							ord("0"), ord("1"), ord("2"), ord("3"), ord("4"), ord("5"), ord("6"), ord("7"), ord("8"), ord("9"),
							ord("A"), ord("B"), ord("C"), ord("D"), ord("E"), ord("F"), ord("G"), ord("H"), ord("I"), ord("J"),
							ord("K"), ord("L"), ord("M"), ord("N"), ord("O"), ord("P"), ord("Q"), ord("R"), ord("S"), ord("T"),
							ord("U"), ord("V"), ord("W"), ord("X"), ord("Y"), ord("Z"),
							vk_f1, vk_f2, vk_f3, vk_f4, vk_f5, vk_f6, vk_f7, vk_f8, vk_f9, vk_f10, vk_f11, vk_f12,
							vk_backspace, vk_tab, vk_escape, vk_home, vk_end, vk_pageup, vk_pagedown, vk_delete, vk_insert,
							vk_nokey, vk_anykey ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}

			// ### MOUSE ###
			
			events = [ ev_mouse ];
			subEvents = [ ev_global_left_button, ev_global_left_press, ev_global_left_release,
							ev_global_middle_button, ev_global_middle_press, ev_global_middle_release,
							ev_global_right_button, ev_global_right_press, ev_global_right_release,
							ev_left_button, ev_left_press, ev_left_release, ev_middle_button, ev_middle_press,
							ev_middle_release, ev_mouse_enter, ev_mouse_leave, ev_mouse_wheel_down, ev_mouse_wheel_up,
							ev_no_button, ev_right_button, ev_right_press, ev_right_release ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}

			// ### GESTURE ###
			
			events = [ ev_gesture ];
			subEvents = [ ev_gesture_double_tap, ev_gesture_drag_end, ev_gesture_drag_start, ev_gesture_dragging, ev_gesture_flick,
							ev_gesture_pinch_end, ev_gesture_pinch_in, ev_gesture_pinch_out, ev_gesture_pinch_start,
							ev_gesture_rotate_end, ev_gesture_rotate_start, ev_gesture_rotating, ev_gesture_tap, ev_global_gesture_double_tap,
							ev_global_gesture_drag_end, ev_global_gesture_drag_start, ev_global_gesture_dragging,
							ev_global_gesture_flick,
							ev_global_gesture_pinch_end, ev_global_gesture_pinch_in, ev_global_gesture_pinch_out, ev_global_gesture_pinch_start,
							ev_global_gesture_rotate_end, ev_global_gesture_rotate_start, ev_global_gesture_rotating, ev_global_gesture_tap ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}

			// ### COLLISION ###
			
			events = [ ev_collision ];
			subEvents = [ oTest, oOther ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}
			
			// ### OTHER ###
			
			events = [ ev_other ];
			subEvents = [ ev_outside, ev_boundary, ev_game_start, ev_game_end, ev_room_start, ev_room_end,
							ev_no_more_lives, ev_no_more_health, ev_animation_end, ev_end_of_path, ev_user0,
							ev_user1, ev_user2, ev_user3, ev_user4, ev_user5, ev_user6, ev_user7, ev_user8, ev_user9,
							ev_user10, ev_user11, ev_user12, ev_user13, ev_user14, ev_user15 ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}


			// ### DRAW ###
			
			events = [ ev_draw ];
			subEvents = [ ev_draw_begin, ev_draw_end, ev_draw_post, ev_draw_pre, ev_gui, ev_gui_begin, ev_gui_end ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_perform(event, subEvent);
				}
			}
			
			// ### CLEANUP ###
			
			event = ev_cleanup;
			subEvent = 0;
			
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform(event, subEvent);
			
			// ### DESTROY ###
			
			event = ev_destroy;
			subEvent = 0;
			
			global.eventData = [ func, contextObj, event, subEvent ];
			event_perform(event, subEvent);
		}
			
		variable_struct_remove(global, "eventData");
			
		instance_destroy(instance);
			
		// ### FAILURES ###

		if (TEST_INVALID_ARGS) {

			var valueType, value, details;
				
			var valueDetails = [ 
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ]; 

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				assert_throw(method({input: value}, function() {
					
					event_perform(oEvents, input);

				}), "#2.1 event_perform("+ details +"):, failed to detect invalid arguemnts");
				
				assert_throw(method({input: value}, function() {
					
					event_perform(input, input);

				}), "#2.2 event_perform("+ details +"):, failed to detect invalid arguemnts");
			}
		
		}
	})

	addFact("event_user_test", function() {

		var events, subEvents, event, subEvent, func = "#1 event_user()";

		var instance = instance_create_depth(0, 0, 0, oEvents);
		with (instance) {
	
			var contextObj = object_index;
			
			// ### USER ###
			
			events = [ ev_other ];
			subEvents = [ ev_user0, ev_user1, ev_user2, ev_user3, ev_user4, ev_user5,
							ev_user6, ev_user7, ev_user8, ev_user9, ev_user10, ev_user11,
							ev_user12, ev_user13, ev_user14, ev_user15 ];
			
			for (var i = 0; i < array_length(events); i++) {
				for (var j = 0; j < array_length(subEvents); j++) {
					
					event = events[i];
					subEvent = subEvents[j];
					
					global.eventData = [ func, contextObj, event, subEvent ];
					event_user(j);
				}
			}
		}

		variable_struct_remove(global, "eventData");

		instance_destroy(instance);

		// ### FAILURES ###

		if (TEST_INVALID_ARGS) {

			instance = instance_create_depth(0, 0, 0, oEvents);

			var valueType, value, details;
				
			var valueDetails = [ 
				[ ptr({}),		"ptr" ],
				[ pointer_null,		"ptrNull" ],
				[ pointer_invalid,	"ptrInvalid" ],
				[ "hello",			"string" ],
				[ undefined,		"undefined" ],
				[ [],				"array" ],
				[ {},				"struct" ],
				[ function() {},	"method" ] ]; 

			var valueDetailsCount = array_length(valueDetails);
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				assert_throw(method({ context: instance, input: value }, function() {
					
					var value = input;
					with(context) event_user(value);

				}), "#2 event_user("+ details +"):, failed to detect invalid arguemnt");
				
			}

			instance_destroy(instance);
		
		}
			
	})

}

