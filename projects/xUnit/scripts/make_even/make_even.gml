/// @function make_even(value)
/// @description Snaps given number to the closest greater even value.
/// @param {Real} value The value to snap to the closest greater even value.
/// @returns {Real}
function make_even(_value) {
	gml_pragma("forceinline");
	return (_value % 2 == 0) ? _value : _value + 1;
}
