
// feather ignore GM2017

/// @function ds_stack_to_array(stack)
/// @param {Id.DsStack} stack The stack to be converted into an array.
/// @returns {Array<Any>}
/// @pure
function ds_stack_to_array(_stack) {

	var _i = 0;
	var _output = [];
	repeat (ds_stack_size(_stack)) {
		_output[_i++] = ds_stack_pop(_stack);
	}
	
	repeat(_i) {
		ds_stack_push(_stack, _output[--_i]);
	}
	
	return _output;
}