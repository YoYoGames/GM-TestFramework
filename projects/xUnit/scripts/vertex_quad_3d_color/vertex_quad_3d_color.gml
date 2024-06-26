// Adds a coloured quad to a vector buffer
function vertex_quad_3d_color(_v_buffer, _color, _p1, _p2, _p3, _p4) {

	vertex_triangle_3d_color(_v_buffer, _color, _p1, _p2, _p3);
	vertex_triangle_3d_color(_v_buffer, _color, _p1, _p3, _p4);

}