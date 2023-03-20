
// feather ignore GM2017

/// @function ds_map_to_array(map)
/// @param {Id.DsMap} map The map to be converted into an array.
/// @returns {Array<Any>}
/// @pure
function ds_map_to_array(_map) {
		
	var _output = array_create(ds_map_size(_map));
	var _keys = ds_map_keys_to_array(_map);

	var _length = array_length(_keys);
	for (var _i = 0, _j = 0; _i < _length; _i++) {
		
		var _key = _keys[_i];
		_output[_j*2] = _key;
		_output[_j*2 + 1] = _map[? _key];
	}
	
	return _output;
}

