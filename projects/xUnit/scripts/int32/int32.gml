
/// @function int32(value)
/// @description This function will attempt to convert a given value into a signed 32-bit integer
/// @param {Real} value The value to attempt convertion on.
/// @returns {Real}
function int32(_value) {

	// The only way to generate an int32 is to read it from a buffer
	var _buffer = buffer_create(16, buffer_fixed, 1);
	
	buffer_write(_buffer, buffer_s32, _value);
	var _int32 = buffer_peek(_buffer, 0, buffer_s32);
	
	buffer_delete(_buffer);
	
	return _int32;
}