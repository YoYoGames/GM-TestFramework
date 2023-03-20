
// feather ignore GM2017

/// @function ds_list_to_array(list)
/// @param {Id.DsList} list The list to be converted into an array.
/// @returns {Array<Any*>}
/// @pure
function ds_list_to_array(_list) {

	var _output = [];
	var _size = ds_list_size(_list);
	repeat (_size) {
		--_size;
		_output[_size] = _list[| _size];
	}
	
	return _output;
}

