/// @function generate_cube()
/// @description Creates and returns a vertex buffer containing the vertex data for a cube.
/// @param {Real} cube_size Width, length and height of the cube (50 by default)
/// @param {Real} cube_color Color of the cube (c_white by default)
/// @returns {Id.VertexBuffer}
function generate_cube(_cube_size = 50, _cube_color = c_white){
	
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
	
	// Add data for the top side of the cube 
	var _point1 = new Vector3(-_cube_size, -_cube_size*2, _cube_size);
	var _point2 = new Vector3( _cube_size, -_cube_size*2, _cube_size);
	var _point3 = new Vector3( _cube_size, -_cube_size*2, -_cube_size);
	var _point4 = new Vector3(-_cube_size, -_cube_size*2, -_cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);

	// Add data for the front side of the cube
	_point1 = new Vector3(-_cube_size, 0, _cube_size);
	_point2 = new Vector3( _cube_size, 0, _cube_size);
	_point3 = new Vector3( _cube_size, -_cube_size*2,  _cube_size);
	_point4 = new Vector3(-_cube_size, -_cube_size*2,  _cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);

	// Add data for the right side of the cube
	_point1 = new Vector3(-_cube_size, 0, -_cube_size);
	_point2 = new Vector3(-_cube_size, 0, _cube_size);
	_point3 = new Vector3(-_cube_size, -_cube_size*2, _cube_size);
	_point4 = new Vector3(-_cube_size, -_cube_size*2, -_cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);

	// Add data for the back side of the cube
	_point1 = new Vector3( _cube_size, 0, -_cube_size);
	_point2 = new Vector3(-_cube_size, 0, -_cube_size);
	_point3 = new Vector3(-_cube_size, -_cube_size*2, -_cube_size);
	_point4 = new Vector3( _cube_size, -_cube_size*2, -_cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);
	
	// Add data for the left side of the cube
	_point1 = new Vector3( _cube_size, 0, _cube_size);
	_point2 = new Vector3( _cube_size, 0, -_cube_size);
	_point3 = new Vector3( _cube_size, -_cube_size*2, -_cube_size);
	_point4 = new Vector3( _cube_size, -_cube_size*2,  _cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);
	
	// Add data for the bottom side of the cube
	_point1 = new Vector3(-_cube_size, 0, _cube_size);
	_point2 = new Vector3(-_cube_size, 0, -_cube_size);
	_point3 = new Vector3( _cube_size, 0, -_cube_size);
	_point4 = new Vector3( _cube_size, 0, _cube_size);
	vertex_quad_3d_color(_buffer, _cube_color, _point1, _point2, _point3, _point4);
	
	// Finish writing data to the vertex buffer and freeze it
	vertex_end(_buffer);
	vertex_freeze(_buffer);
	
	// Return the buffer
	return _buffer;
}