/// @function generate_plane()
/// @description Creates and returns a vertex buffer containing the vertex data for a plane.
/// @param {Real} plane_size Width and length of the plane (100 by default)
/// @param {Real} plane_color Color of the cube (c_white by default)
/// @returns {Id.VertexBuffer}
function generate_plane(_plane_size = 100, _plane_color = c_white){
	
	// Define the vertex format to use for the vertex buffer
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	var _format = vertex_format_end();
	
	// Create the vertex buffer and begin writing to it
	var _buffer = vertex_create_buffer();
	vertex_begin(_buffer, _format);
	
	// Add data for the plane
	var _point1 = new Vector3(-_plane_size, 0, _plane_size);
	var _point2 = new Vector3( _plane_size, 0, _plane_size);
	var _point3 = new Vector3( _plane_size, 0, -_plane_size);
	var _point4 = new Vector3(-_plane_size, 0, -_plane_size);
	vertex_quad_3d_color(_buffer, _plane_color, _point1, _point2, _point3, _point4);
	
	// Finish writing data to the vertex buffer and freeze it
	vertex_end(_buffer);
	vertex_freeze(_buffer);
	
	// Return the buffer
	return _buffer;
}