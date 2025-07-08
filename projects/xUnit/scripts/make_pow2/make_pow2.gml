/// @function make_pow2(value)
/// @description Snaps given number to the closest greater power-of-two value.
/// @param {Real} value The value to snap to the closest greater power-of-two value.
/// @returns {Real}
function make_pow2(_value) {
	gml_pragma("forceinline");
	return power(2, ceil(log2(_value)));
}
