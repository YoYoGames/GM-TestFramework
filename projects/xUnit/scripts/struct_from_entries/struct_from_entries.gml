
// feather ignore GM2017

/// @function struct_from_entries(entries)
/// @description This function returns a new struct from a collection of key-value arrays.
/// @param {Array<Array>} entries
/// @returns {Struct}
function struct_from_entries(_entries) {
	
	var _output = {};
	var _count = array_length(_entries);
	
	for (var _i = 0; _i < _count; ++_i) {
		_output[$ _entries[_i][0]] = _entries[_i][1];
	}
	
	return _output;
}
