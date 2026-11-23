/// @description Draw after everything else in the room, then begin running the test

// The view_set_viewport tests fill the view with a colour in their Draw event, so this instance must draw last
depth = -15000;

event_inherited();
