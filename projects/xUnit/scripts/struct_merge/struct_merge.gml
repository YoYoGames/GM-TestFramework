
// feather ignore GM2017
// feather ignore GM1042

/// @function struct_merge(src, dest, add)
/// @description Merges a source struct into a destination one. 
/// @param {Struct} src The source struct to be used for merging.
/// @param {Struct} dest The destination struct to be used for merging.
/// @param {Bool} add Whether or not new members should be added to the destination struct.
function struct_merge(_src, _dest, _add = true) {

	var _names = variable_struct_get_names(_src);
	var _count = array_length(_names);
	for (var _i = 0; _i < _count; _i++) {
		var _name = _names[_i];
		
		// If the variable name exists on destination (or '_add' is true)
		if (variable_struct_exists(_dest, _name) || _add) {
			_dest[$ _name] = _src[$ _name];
		}		
	}
}
