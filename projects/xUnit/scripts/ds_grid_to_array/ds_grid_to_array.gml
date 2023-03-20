
// feather ignore GM2017

/// @function ds_grid_to_array(grid)
/// @param {Id.DsGrid} grid The grid to be converted into an array.
/// @returns {Array<Array>}
/// @pure
function ds_grid_to_array(_grid) {

	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	var _output = array_create(_width);
	
	for (var _i = 0; _i < _width; _i++)
	{
		var _column = array_create(_height);
		_output[_i] = _column;
		for (var _j = 0; _j < _height; _j++)
		{
			_column[_j] = _grid[# _i, _j];
		}
	}	
	return _output;
}

