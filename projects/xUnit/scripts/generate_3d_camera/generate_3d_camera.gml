
function generate_3d_camera(_position = new Vector3(-200, -200, -300), _lookat = new Vector3(0, -50, 0)){
	
	view_enabled = true;
	view_set_visible(0, true);
	
	var _camera = camera_create();
	view_set_camera(0, _camera);

	var _center_x = window_get_width()  / 2;
	var	_center_y = window_get_height() / 2;

	var _projmat = matrix_build_projection_perspective_fov(-60, _center_x/_center_y, 1, 32000);
	camera_set_proj_mat(_camera, _projmat);
	
	var _viewmat = matrix_build_lookat(
		_position.x, _position.y, _position.z,
		_lookat.x, _lookat.y, _lookat.z,  
		0, -1, 0);
	camera_set_view_mat(_camera, _viewmat);
	
	return _camera;
}