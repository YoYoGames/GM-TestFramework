function generate_regular_polygon(_x_pos = 0, _y_pos = 0, _radius = 100, _sides = 6, _color = c_white){
	
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	var _format = vertex_format_end();

	var _buffer = vertex_create_buffer();
	vertex_begin(_buffer, _format);
	
	var _point = new Vector2();
	var _prev_point = new Vector2();
	var _centre = new Vector2(_x_pos, _y_pos);
	
	var _uv = new Vector2()
	var _prev_uv = new Vector2()
	var _centre_uv = new Vector2(0.5,0.5)
	for (i = 0; i < _sides+1; i++)
	{

		_prev_point.x = _point.x;
		_prev_point.y = _point.y;
		_prev_uv.x = _uv.x
		_prev_uv.y = _uv.y
		
		_point.x = ( cos( i / _sides * 2 * pi ) * _radius ) + _centre.x;
		_point.y = ( sin( i / _sides * 2 * pi ) * _radius ) + _centre.y;
		_uv.x =  (cos( i / _sides * 2 * pi )/2)+0.5;
		_uv.y =  (sin( i / _sides * 2 * pi )/2)+0.5;
		
		if (i > 0)
		{
			vertex_triangle_texture(_buffer, _color, _prev_point, _point, _centre, _prev_uv, _uv, _centre_uv);
		}
		
	}
	
	vertex_end(_buffer);
	vertex_freeze(_buffer);
	
	return _buffer;
}