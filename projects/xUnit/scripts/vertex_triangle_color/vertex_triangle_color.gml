/// @function vertex_triangle_color()
/// @description Adds the data for a colored triangle to the specified vertex buffer
/// @param {Id.VertexBuffer} v_buffer Vertex buffer to write triangle data to
/// @param {Real} color Color of the triangle
/// @param {Struct.Vector2} p1 First point of the triangle
/// @param {Struct.Vector2} p2 Second point of the triangle
/// @param {Struct.Vector2} p3 Third point of the triangle
function vertex_triangle_color(_v_buffer, _color, _p1, _p2, _p3) {

	// Set the normal of the triangle
	var _normal = new Vector3(0, 0, 1)
	
	// Set data for point 1
	vertex_position(_v_buffer, _p1.x, _p1.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
	// Set data for point 2
	vertex_position(_v_buffer, _p2.x, _p2.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
	// Set data for point 3
	vertex_position(_v_buffer, _p3.x, _p3.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, 0, 0);
	
}

/// @function vertex_triangle_texture()
/// @description Adds the data for a colored triangle with texture coordinates to the specified vertex buffer
/// @param {Id.VertexBuffer} v_buffer Vertex buffer to write triangle data to
/// @param {Real} color Color of the triangle
/// @param {Struct.Vector2} p1 First point of the triangle
/// @param {Struct.Vector2} p2 Second point of the triangle
/// @param {Struct.Vector2} p3 Third point of the triangle
/// @param {Struct.Vector2} uv1 First UV coordinate of the triangle
/// @param {Struct.Vector2} uv2 Second UV coordinate of the triangle
/// @param {Struct.Vector2} uv3 Third UV coordinate of the triangle
function vertex_triangle_texture(_v_buffer, _color, _p1, _p2, _p3, _uv1, _uv2, _uv3) {

	// Set the normal of the triangle
	var _normal = new Vector3(0, 0, 1)
	
	// Set data for point 1
	vertex_position(_v_buffer, _p1.x, _p1.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv1.x, _uv1.y);
	
	// Set data for point 2
	vertex_position(_v_buffer, _p2.x, _p2.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv2.x, _uv2.y);
	
	// Set data for point 3
	vertex_position(_v_buffer, _p3.x, _p3.y);
	vertex_normal(_v_buffer, _normal.x, _normal.y, _normal.z);
	vertex_color(_v_buffer, _color, 1);
	vertex_texcoord(_v_buffer, _uv3.x, _uv3.y);
}