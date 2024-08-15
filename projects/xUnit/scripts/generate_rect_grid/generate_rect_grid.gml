/// @function generate_rect_grid()
/// @description Creates and returns an array of Rects arranged in a grid
/// @param {Real} rect_width The width of each rect in the grid
/// @param {Real} rect_height The height of each rect in the grid
/// @param {Real} grid_width The number of rects in the grid horizontally
/// @param {Real} grid_height The number of rects in the grid vertically
function generate_rect_grid(_rect_width, _rect_height, _grid_width, _grid_height) {
	
	// Array to store rects
	var _rects = [];
	
	// For each rect in the grid..
	for (var i = 0; i < _grid_width * _grid_height; i++)
	{
		// Get the current row and column in the grid by finding the remainder (mod) and integer quotient (div) when dividing by the grid width
		var _col = i mod _grid_width;
		var _row = i div _grid_width;
		// Get the rect's position in the grid by multiplying the row and column with the rect width and height
		var _x_pos = _col * _rect_width;
		var _y_pos = _row * _rect_height;
		// Create the rect with the top left point at that position, and the bottom right point the rect width and height away from it
		var _rect = new Rect(_x_pos, _y_pos, _x_pos + _rect_width, _y_pos + _rect_height)
		// Add the rect to the array
		array_push(_rects, _rect);
	}
	
	// Return the array
	return _rects;
}