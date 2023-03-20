
function event_to_string(_type) {

	switch(_type) {
		
		// ### MAIN ###
		
		case ev_create: return "ev_create";
		case ev_alarm: return "ev_alarm";
		case ev_step: return "ev_step";
		case ev_keyboard: return "ev_keyboard";
		case ev_keypress: return "ev_keypress";
		case ev_keyrelease: return "ev_keyrelease";
		case ev_mouse: return "ev_mouse";
		case ev_gesture: return "ev_gesture";
		case ev_collision: return "ev_collision";
		case ev_other: return "ev_other";
		case ev_draw: return "ev_draw";
		case ev_cleanup: return "ev_cleanup";
		case ev_destroy: return "ev_destroy";
		
		// ### SUBTYPES ###
		/*
		case ev_draw_begin: return "ev_draw_begin";
		case ev_draw_end: return "ev_draw_end";
		case ev_draw_post: return "ev_draw_post";
		case ev_draw_pre: return "ev_draw_pre";
		
		case ev_gui: return "ev_gui";
		case ev_gui_begin: return "ev_gui_begin";
		case ev_gui_end: return "ev_gui_end";

		case ev_step_begin: return "ev_step_begin";
		case ev_step_end: return "ev_step_end";
		case ev_step_normal: return "ev_step_normal";
		
		case ev_outside: return "ev_outside";
		case ev_boundary: return "ev_boundary";
		case ev_game_start: return "ev_game_start";
		case ev_game_end: return "ev_game_end";
		case ev_room_start: return "ev_room_start";
		case ev_room_end: return "ev_room_end";
		
		case ev_no_more_lives: return "ev_no_more_lives";
		case ev_no_more_health: return "ev_no_more_health";
		case ev_animation_end: return "ev_animation_end";
		case ev_end_of_path: return "ev_end_of_path";
		
		case ev_user0: return "ev_user0";
		case ev_user1: return "ev_user1";
		case ev_user2: return "ev_user2";
		case ev_user3: return "ev_user3";
		case ev_user4: return "ev_user4";
		case ev_user5: return "ev_user5";
		case ev_user6: return "ev_user6";
		case ev_user7: return "ev_user7";
		case ev_user8: return "ev_user8";
		case ev_user9: return "ev_user9";
		case ev_user10: return "ev_user10";
		case ev_user11: return "ev_user11";
		case ev_user12: return "ev_user12";
		case ev_user13: return "ev_user13";
		case ev_user14: return "ev_user14";
		case ev_user15: return "ev_user15";
		
		case ev_gesture_double_tap: return "ev_gesture_double_tap";
		case ev_gesture_drag_end: return "ev_gesture_drag_end";
		case ev_gesture_drag_start: return "ev_gesture_drag_start";
		case ev_gesture_dragging: return "ev_gesture_dragging";
		case ev_gesture_flick: return "ev_gesture_flick";
		case ev_gesture_pinch_end: return "ev_gesture_pinch_end";
		case ev_gesture_pinch_in: return "ev_gesture_pinch_in";
		case ev_gesture_pinch_out: return "ev_gesture_pinch_out";
		case ev_gesture_pinch_start: return "ev_gesture_pinch_start";
		case ev_gesture_rotate_end: return "ev_gesture_rotate_end";
		case ev_gesture_rotate_start: return "ev_gesture_rotate_start";
		case ev_gesture_rotating: return "ev_gesture_rotating";
		case ev_gesture_tap: return "ev_gesture_tap";
		case ev_global_gesture_double_tap: return "ev_global_gesture_double_tap";
		case ev_global_gesture_drag_end: return "ev_global_gesture_drag_end";
		case ev_global_gesture_drag_start: return "ev_global_gesture_drag_start";
		case ev_global_gesture_dragging: return "ev_global_gesture_dragging";
		case ev_global_gesture_flick: return "ev_global_gesture_flick";
		case ev_global_gesture_pinch_end: return "ev_global_gesture_pinch_end";
		case ev_global_gesture_pinch_in: return "ev_global_gesture_pinch_in";
		case ev_global_gesture_pinch_out: return "ev_global_gesture_pinch_out";
		case ev_global_gesture_pinch_start: return "ev_global_gesture_pinch_start";
		case ev_global_gesture_rotate_end: return "ev_global_gesture_rotate_end";
		case ev_global_gesture_rotate_start: return "ev_global_gesture_rotate_start";
		case ev_global_gesture_rotating: return "ev_global_gesture_rotating";
		case ev_global_gesture_tap: return "ev_global_gesture_tap";
		
		case ev_global_left_button: return "ev_global_left_button";
		case ev_global_left_press: return "ev_global_left_press";
		case ev_global_left_release: return "ev_global_left_release";
		case ev_global_middle_button: return "ev_global_middle_button";
		case ev_global_middle_press: return "ev_global_middle_press";
		case ev_global_middle_release: return "ev_global_middle_release";
		case ev_global_right_button: return "ev_global_right_button";
		case ev_global_right_press: return "ev_global_right_press";
		case ev_global_right_release: return "ev_global_right_release";
		case ev_left_button: return "ev_left_button";
		case ev_left_press: return "ev_left_press";
		case ev_left_release: return "ev_left_release";
		case ev_middle_button: return "ev_middle_button";
		case ev_middle_press: return "ev_middle_press";
		case ev_middle_release: return "ev_middle_release";
		case ev_mouse_enter: return "ev_mouse_enter";
		case ev_mouse_leave: return "ev_mouse_leave";
		case ev_mouse_wheel_down: return "ev_mouse_wheel_down";
		case ev_mouse_wheel_up: return "ev_mouse_wheel_up";
		case ev_no_button: return "ev_no_button";
		case ev_right_button: return "ev_right_button";
		case ev_right_press: return "ev_right_press";
		case ev_right_release: return "ev_right_release";
		*/
		
		default: return string(_type);
		
	}

}