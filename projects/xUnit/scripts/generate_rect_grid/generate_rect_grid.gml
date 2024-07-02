function generate_rect_grid(_rect_width, _rect_height, _grid_width, _grid_height) {
	
	var _rects = [];
	
	for (var i = 0; i < _grid_width * _grid_height; i++)
	{
		var _x_pos = (i mod _grid_width) * _rect_width;
		var _y_pos = (i div _grid_width) * _rect_height;
		var _rect = new Rect(_x_pos, _y_pos, _x_pos + _rect_width, _y_pos + _rect_height)
		array_push(_rects, _rect);
	}
	
	return _rects;
}