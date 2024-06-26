function generate_centred_rect(_width, _height) {
	// The centre of the room
	var _room_center_x = room_width / 2;
	var _room_center_y = room_height / 2;

	// The origin of the rect, in this case in it's center
	var _rect_origin_x = _width / 2;
	var _rect_origin_y = _height / 2;

	rect = new Rect();
	// The positions of each of the corners of the rect after centering it in the room
	rect.left = _room_center_x - _rect_origin_x;
	rect.right = _room_center_x - _rect_origin_x + _width;
	rect.top = _room_center_y - _rect_origin_y;
	rect.bottom = _room_center_y - _rect_origin_y + _height;
	
	return rect;
}