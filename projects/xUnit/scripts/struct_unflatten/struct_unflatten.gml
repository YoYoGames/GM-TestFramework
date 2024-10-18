
/// @function struct_unflatten(struct)
/// @description Converts a flattened object into a nested object.
/// @param {Struct} struct The flattened struct to convert.
/// @returns {Struct}
function struct_unflatten(_struct) {
	var _result = {};
	var _keys = variable_struct_get_names(_struct);
	var _keys_count = array_length(_keys);
	for (var _i = 0; _i < _keys_count; _i++) {
		var _key = _keys[_i];
		var _parts = string_split(_key, ".");
		var _obj = _result;
		
		var _parts_count = array_length(_parts);
		for (var _j = 0; _j < _parts_count - 1; _j++) {
			var _part = _parts[_j];
			
			
			if (!variable_struct_exists(_obj, _part)) _obj[$ _part] = {};			
			_obj = _obj[$ _part];
		}
		
		var _nested_key = _parts[_parts_count - 1];
		var _value = _struct[$ _key];
		
		_obj[$ _nested_key] = _value;
	}
	return _result;
}