// Draws a rectangle to the screen with the dimentions of the inputted rect
function draw_rect(_rect, _colour = c_white, _alpha = 1.0){
	// Begin drawing primitive
	draw_primitive_begin(pr_trianglestrip);
	// Draw a vertex at each of the corners of the rect, with the specified colour and alpha values
	draw_vertex_color(_rect.left, _rect.top, _colour, _alpha);
	draw_vertex_color(_rect.right, _rect.top, _colour, _alpha);
	draw_vertex_color(_rect.left, _rect.bottom, _colour, _alpha);
	draw_vertex_color(_rect.right, _rect.bottom, _colour, _alpha);
	// Finish drawing primitive
	draw_primitive_end();
}