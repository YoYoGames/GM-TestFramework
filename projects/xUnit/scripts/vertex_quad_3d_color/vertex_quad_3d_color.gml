/// @function vertex_quad_3d_color()
/// @description Adds the data for a 3d colored quad to the specified vertex buffer
/// @param {Id.VertexBuffer} v_buffer Vertex buffer to write quad data to
/// @param {Real} color Color of the quad
/// @param {Struct.Vector3} p1 First point of the quad
/// @param {Struct.Vector3} p2 Second point of the quad
/// @param {Struct.Vector3} p3 Third point of the quad
/// @param {Struct.Vector3} p4 Fourth point of the quad
function vertex_quad_3d_color(_v_buffer, _color, _p1, _p2, _p3, _p4) {
	
	// Add quad as two triangles
	vertex_triangle_3d_color(_v_buffer, _color, _p1, _p2, _p3);
	vertex_triangle_3d_color(_v_buffer, _color, _p1, _p3, _p4);

}