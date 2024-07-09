/// @function generate_3d_camera()
/// @description Creates and returns the ID of a 3D perspective camera, with a specific position and point to look at.
/// @param {Real} pos_x x position of the camera (-200 by default)
/// @param {Real} pos_y y position of the camera (-200 by default)
/// @param {Real} pos_z z position of the camera (-300 by default)
/// @param {Real} look_x x position that the camera will look at (0 by default)
/// @param {Real} look_y y position that the camera will look at (-50 by default)
/// @param {Real} look_z z position that the camera will look at (0 by default)
/// @returns {Id.Camera}
function generate_3d_camera(_pos_x = -200, _pos_y = -200, _pos_z = -300, _look_x = 0, _look_y = -50, _look_z = 0){
	
	// Create camera
	var _camera = camera_create();

	// Get the center of the window
	var _center_x = window_get_width()  / 2;
	var	_center_y = window_get_height() / 2;
	
	// Build a projection matrix with the same aspect ratio as the window and set the camera to use it
	var _projmat = matrix_build_projection_perspective_fov(-60, _center_x/_center_y, 1, 32000);
	camera_set_proj_mat(_camera, _projmat);
	
	// Build a lookat matrix using the provided position and lookat point and set the camera to use it
	var _viewmat = matrix_build_lookat(
		_pos_x, _pos_y, _pos_z,
		_look_x, _look_y, _look_z,  
		0, -1, 0);
	camera_set_view_mat(_camera, _viewmat);
	
	// Return the camera
	return _camera;
}