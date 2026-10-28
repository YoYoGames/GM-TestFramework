/// @function draw_texture_rect()
/// @description Draws a rectangle primitive to the screen with  the dimentions of the inputted rect
/// @param {Struct.Rect} rect The dimentions of the rectangle, as a Rect
/// @param {Array} uvs The UV coordinates of the rectangle, as an array of floats
/// @param {Real} color The Color of the rectangle (c_white by default)
/// @param {Real} alpha The Alpha of the rectangle (1.0 by default)
function draw_texture_rect(_rect, _uvs, _colour = c_white, _alpha = 1.0) {	
	// Begin drawing primitive
	draw_primitive_begin(pr_trianglestrip);
	// Draw a vertex at each of the corners of the rect, with the specified colour and alpha values
	draw_vertex_texture_color(_rect.left, _rect.top, _uvs[0], _uvs[1], _colour, _alpha);
	draw_vertex_texture_color(_rect.right, _rect.top, _uvs[2], _uvs[1], _colour, _alpha);
	draw_vertex_texture_color(_rect.left, _rect.bottom, _uvs[0], _uvs[3], _colour, _alpha);
	draw_vertex_texture_color(_rect.right, _rect.bottom, _uvs[2], _uvs[3], _colour, _alpha);
	// Finish drawing primitive
	draw_primitive_end();
}