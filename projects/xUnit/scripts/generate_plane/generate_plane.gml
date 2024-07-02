function generate_plane(_plane_size = 100, _plane_color = c_white){
	
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	var _format = vertex_format_end();

	var _buffer = vertex_create_buffer();
	vertex_begin(_buffer, _format);
	
	// Top
	var _point1 = new Vector3(-_plane_size, 0, _plane_size);
	var _point2 = new Vector3( _plane_size, 0, _plane_size);
	var _point3 = new Vector3( _plane_size, 0, -_plane_size);
	var _point4 = new Vector3(-_plane_size, 0, -_plane_size);
	vertex_quad_3d_color(_buffer, _plane_color, _point1, _point2, _point3, _point4);
	
	vertex_end(_buffer);
	vertex_freeze(_buffer);
	
	return _buffer;
}