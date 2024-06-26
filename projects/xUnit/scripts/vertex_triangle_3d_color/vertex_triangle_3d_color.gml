// Adds a coloured triangle to a vector buffer
function vertex_triangle_3d_color(_v_buffer, _color, _p1, _p2, _p3) {

	// Get the normal of the triangle
	var _normal = new Vector3();
	var	_p12 = new Vector3(_p2.x-_p1.x, _p2.y-_p1.y, _p2.z-_p1.z);
	var	_p13 = new Vector3(_p3.x-_p1.x, _p3.y-_p1.y, _p3.z-_p1.z);
	_normal = cross_product(_p13, _p12);
	_normal = normalize(_normal);
	
	// Set data for point 1
	vertex_position_3d(_v_buffer, _p1.x, _p1.y, _p1.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
	// Set data for point 2
	vertex_position_3d(_v_buffer, _p2.x, _p2.y, _p2.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
	// Set data for point 3
	vertex_position_3d(_v_buffer, _p3.x, _p3.y, _p3.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
}

// Adds a coloured triangle to a vector buffer with texture coordinates
function vertex_triangle_3d_texture(_v_buffer, _color, _p1, _p2, _p3, _uv1, _uv2, _uv3) {

	// Get the normal of the triangle
	var _normal = new Vector3();
	var	_p12 = new Vector3(_p2.x-_p1.x, _p2.y-_p1.y, _p2.z-_p1.z);
	var	_p13 = new Vector3(_p3.x-_p1.x, _p3.y-_p1.y, _p3.z-_p1.z);
	_normal = cross_product(_p13, _p12);
	_normal = normalize(_normal);
	
	// Set data for point 1
	vertex_position_3d(_v_buffer, _p1.x, _p1.y, _p1.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv1.x, _uv1.y);
	
	// Set data for point 2
	vertex_position_3d(_v_buffer, _p2.x, _p2.y, _p2.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv2.x, _uv2.y);
	
	// Set data for point 3
	vertex_position_3d(_v_buffer, _p3.x, _p3.y, _p3.z);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv3.x, _uv3.y);
	
}