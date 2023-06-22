
// feather ignore GM2017

/// @function assert_get_singleton()
/// @description This function returns a singleton to the default Assert class.
/// @returns {Struct.Assert}
function assert_get_singleton() {

	static framework = new Assert();

	return framework;

}

#region Value Asserts

/// @functions assert_equals(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_equals(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.equals(_value, _expected, _description);
}

/// @functions assert_not_equals(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_equals(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.notEquals(_value, _expected, _description);
}

/// @functions assert_greater(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_greater(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.greaterThan(_value, _expected, _description);
}

/// @functions assert_greater_or_equal(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_greater_or_equal(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.greaterOrEqual(_value, _expected, _description);
}

/// @functions assert_less(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_less(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.lessThan(_value, _expected, _description);
}

/// @functions assert_less_or_equal(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_less_or_equal(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.lessOrEqual(_value, _expected, _description);
}

/// @functions assert_any_of(value, array, description)
/// @param {Any} value The value to be tested.
/// @param {Array} expected The array that should contain the value.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_any_of(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.any_of(_value, _expected, _description);	
}

/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
function assert_nan(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNaN(_value, _description);
}

/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
function assert_not_nan(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNotNaN(_value, _description);
}

#endregion

#region Array Asserts

/// @function assert_array_contains(array, expected, description)
/// @param {Array} array The array to be tested.
/// @param {Any} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_contains(_array, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.arrayContains(_array, _expected, _description);
}

/// @function assert_array_contains_all(array, expected, description)
/// @param {Array} array The array to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_contains_all(_array, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.arrayContainsAll(_array, _expected, _description);
}

/// @function assert_array_contains_any(array, expected, description)
/// @param {Array} array The array to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_contains_any(_array, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.arrayContainsAny(_array, _expected, _description);
}

/// @function assert_array_empty(array, description)
/// @param {Array} array The array to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_empty(_array, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.arrayEmpty(_array, _description);
}

/// @function assert_array_equals(array, expected, description)
/// @param {Array} array The array to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_equals(_array, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.arrayEquals(_array, _expected, _description);
}

/// @function assert_array_length(array, expected, description)
/// @param {Array} array The array to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_length(_array, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.arrayLength(_array, _expected, _description);
}

/// @function assert_array_not_empty(array, description)
/// @param {Array} array The array to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_array_not_empty(_array, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.arrayNotEmpty(_array, _description);
}

#endregion

#region Buffer Asserts

/// @function assert_buffer_alignment(buffer, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_alignment(_buffer, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.bufferAlignment(_buffer, _expected, _description);
}

/// @function assert_buffer_equals(buffer, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested.
/// @param {Id.Buffer} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_equals(_buffer, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.bufferEquals(_buffer, _expected, _description);
}

/// @function assert_buffer_size(buffer, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_size(_buffer, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.bufferSize(_buffer, _expected, _description);
}

/// @function assert_buffer_type(buffer, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested.
/// @param {Constant.BufferType} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_type(_buffer, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.bufferType(_buffer, _expected, _description);
}

/// @function assert_buffer_channel_equals(buffer, buffer_channel, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
/// @param {Real} buffer_channel The channel to be tested.
/// @param {Real} expected  The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_channel_equals(_buffer, _channel, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.bufferChannelEquals(_buffer, _channel, _expected, _description);
}

/// @function assert_buffer_channel_less(buffer, buffer_channel, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
/// @param {Real} buffer_channel The channel to be tested.
/// @param {Real} expected  The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_channel_less(_buffer, _channel, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.bufferChannelLessThan(_buffer, _channel, _expected, _description);
}

/// @function assert_buffer_channel_less_or_equal(buffer, buffer_channel, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
/// @param {Real} buffer_channel The channel to be tested.
/// @param {Real} expected  The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_channel_less_or_equal(_buffer, _channel, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.bufferChannelLessOrEqual(_buffer, _channel, _expected, _description);
}

/// @function assert_buffer_channel_greater(buffer, buffer_channel, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
/// @param {Real} buffer_channel The channel to be tested.
/// @param {Real} expected  The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_channel_greater(_buffer, _channel, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.bufferChannelGreaterThan(_buffer, _channel, _expected, _description);
}

/// @function assert_buffer_channel_greater_or_equal(buffer, buffer_channel, expected, description)
/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
/// @param {Real} buffer_channel The channel to be tested.
/// @param {Real} expected  The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_buffer_channel_greater_or_equal(_buffer, _channel, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.bufferChannelGreaterOrEqual(_buffer, _channel, _expected, _description);
}

#endregion

#region Surface Asserts

/// @function assert_surface_all(surface, func, description)
/// @param {Id.Surface} surface The surface to be tested.
/// @param {Method} func The predicate function use as test (per pixel).
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_surface_all(_surface, _func, _description = undefined) {
	static framework = assert_get_singleton();
	return framework.surfaceForeach(_surface, _func, _description);
}

/// @function assert_surface_any(surface, func, description)
/// @param {Id.Surface} surface The surface to be tested.
/// @param {Method} func The predicate function use as test (per pixel).
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_surface_any(_surface, _func, _description = undefined) {
	static framework = assert_get_singleton();
	return framework.surfaceForeach(_surface, _func, _description);
}

#endregion

#region Grid Asserts

/// @function assert_grid_equals_array(grid, expected, description)
/// @param {Id.DsGrid} grid The grid to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_grid_equals_array(_grid, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.gridEqualsArray(_grid, _expected, _description);
}

/// @function assert_grid_equals(grid, expected, description)
/// @param {Id.DsGrid} grid The grid to be tested.
/// @param {Id.DsGrid} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_grid_equals(_grid, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.gridEquals(_grid, _expected, _description);
}

/// @function assert_grid_not_equals(grid, expected, description)
/// @param {Id.DsGrid} grid The grid to be tested.
/// @param {Id.DsGrid} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_grid_not_equals(_grid, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.gridNotEquals(_grid, _expected, _description);
}

#endregion

#region List Asserts

/// @function assert_list_size(list, expected, description)
/// @param {Id.DsList} list The list to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_list_size(_list, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.listSize(_list, _expected, _description);
}

/// @function assert_list_empty(list, description)
/// @param {Id.DsList} list The list to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_list_empty(_list, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.listEmpty(_list, _description);
}

/// @function assert_list_equals(list, expected, description)
/// @param {Id.DsList} list The list to be tested.
/// @param {Id.DsList} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_list_equals(_list, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.listEquals(_list, _expected, _description);
}

/// @function assert_list_equals_array(list, expected, description)
/// @param {Id.DsList} list The list to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_list_equals_array(_list, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.listEqualsArray(_list, _expected, _description);
}

/// @function assert_list_not_empty(list, description)
/// @param {Id.DsList} list The list to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_list_not_empty(_list, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.listNotEmpty(_list, _description);
}

#endregion

#region Map Asserts

/// @function assert_map_size(map, expected, description)
/// @param {Id.DsMap} map The map to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_map_size(_map, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.mapSize(_map, _expected, _description);
}

/// @function assert_map_empty(map, description)
/// @param {Id.DsMap} map The map to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_map_empty(_map, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.mapEmpty(_map, _description);
}

/// @function assert_map_equals(map, expected, description)
/// @param {Id.DsMap} map The map to be tested.
/// @param {Id.DsMap} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_map_equals(_map, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.mapEquals(_map, _expected, _description);
}

/// @function assert_map_equals_array(map, expected, description)
/// @param {Id.DsMap} map The map to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_map_equals_array(_map, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.mapEqualsArray(_map, _expected, _description);
}

/// @function assert_map_not_empty(map, expected, description)
/// @param {Id.DsMap} map The map to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_map_not_empty(_map, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.mapNotEmpty(_map, _description);
}

#endregion

#region Queue Asserts

/// @function assert_queue_size(queue, expected, description)
/// @param {Id.DsQueue} queue The queue to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_queue_size(_queue, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.queueSize(_queue, _expected, _description);
}

/// @function assert_queue_empty(queue, description)
/// @param {Id.DsQueue} queue The queue to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_queue_empty(_queue, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.queueEmpty(_queue, _description);
}

/// @function assert_queue_equals(queue, expected, description)
/// @param {Id.DsQueue} queue The queue to be tested.
/// @param {Id.DsQueue} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_queue_equals(_queue, _expected, _description) {

	static framework = assert_get_singleton();
	return framework.queueEquals(_queue, _expected, _description);
}

/// @function assert_queue_equals_array(queue, expected, description)
/// @param {Id.DsQueue} queue The queue to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_queue_equals_array(_queue, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.queueEqualsArray(_queue, _expected, _description);	
}

/// @function assert_queue_not_empty(queue, description)
/// @param {Id.DsQueue} queue The queue to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_queue_not_empty(_queue, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.queueNotEmpty(_queue, _description);
}

#endregion

#region Stack Asserts

/// @function assert_stack_size(stack, expected, description)
/// @param {Id.DsStack} stack The stack to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_stack_size(_stack, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stackSize(_stack, _expected, _description);
}

/// @function assert_stack_empty(stack, expected, description)
/// @param {Id.DsStack} stack The stack to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_stack_empty(_stack, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stackEmpty(_stack, _description);
}

/// @function assert_stack_equals(stack, expected, description)
/// @param {Id.DsStack} stack The stack to be tested.
/// @param {Id.DsStack} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_stack_equals(_stack, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stackEquals(_stack, _expected, _description);
}

/// @function assert_stack_equals_array(stack, expected, description)
/// @param {Id.DsStack} stack The stack to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_stack_equals_array(_stack, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stackEqualsArray(_stack, _expected, _description);
}

/// @function assert_stack_not_empty(stack, expected, description)
/// @param {Id.DsStack} stack The stack to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_stack_not_empty(_stack, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stackNotEmpty(_stack, _description);
}

#endregion

#region Struct Asserts

/// @function assert_struct_size(struct, expected, description)
/// @param {Struct} struct The struct to be tested.
/// @param {Real} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_struct_size(_struct, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.structSize(_struct, _expected, _description);
}

/// @function assert_struct_empty(struct, description)
/// @param {Struct} struct The struct to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_struct_empty(_struct, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.structEmpty(_struct, _expected, _description);
}

/// @function assert_struct_equals(struct, expected, description)
/// @param {Struct} struct The struct to be tested.
/// @param {Struct} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_struct_equals(_struct, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.structEquals(_struct, _expected, _description);
}

/// @function assert_struct_not_empty(struct, description)
/// @param {Struct} struct The struct to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_struct_not_empty(_struct, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.structNotEmpty(_struct, _description);
}

#endregion

#region Exception Asserts

/// @function assert_not_throws(func, description)
/// @param {Function} func The function to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_throws(_func, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.notThrows(_func, _description);
}

/// @function assert_throw(func, description)
/// @param {Function} func The function to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_throw(_func, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.throws(_func, _description);
}

#endregion

#region String Asserts

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_contains(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringContains(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_contains_all(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringContainsAll(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_contains_any(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringContainsAny(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_ends_with(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringEndsWith(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_ends_with_any(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringEndsWithAny(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_equals_ignore_case(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringEqualsIgnoreCase(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_not_contains(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringNotContains(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_not_ends_with(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringNotEndsWith(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_not_equals_ignore_case(_string, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.stringNotEqualsIgnoreCase(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_not_starts_with(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringNotStartsWith(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {String} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_starts_with(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringStartsWith(_string, _expected, _description);
}

/// @param {String} str The string to be tested.
/// @param {Array} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_string_starts_with_any(_string, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.stringStartsWithAny(_string, _expected, _description);
}

#endregion

#region Type Asserts

/// @function assert_typeof(value, expected, description)
/// @param {Any} value The value to be tested.
/// @param {String} expected The expected 'typeof' result.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_typeof(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isTypeOf(_value, _expected, _description);
}

/// @function assert_false(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_false(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isFalse(_value, _description);	
}

/// @function assert_not_null(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_null(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNotNull(_value, _description);	
}

/// @function assert_not_typeof(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_typeof(_value, _expected, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNotTypeOf(_value, _description);	
}

/// @function assert_not_undefined(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_undefined(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNotUndefined(_value, _description);	
}

/// @function assert_null(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_null(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isNull(_value, _description);	
}

/// @function assert_undefined(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_undefined(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isUndefined(_value, _description);	
}

/// @function assert_true(value, description)
/// @param {Any} value The value to be tested.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_true(_value, _description = undefined) {
	
	static framework = assert_get_singleton();
	return framework.isTrue(_value, _description);	
}

#endregion

#region Object Asserts

/// @param {Id.Instance} value The value to be tested.
/// @param {Asset.GMObject} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_child_of(_instance, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.isChildOf(_instance, _expected, _description);
}

/// @param {Id.Instance} value The value to be tested.
/// @param {Asset.GMObject} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_instance_of(_instance, _expected, _description = undefined) {
							
	static framework = assert_get_singleton();
	return framework.isInstanceOf(_instance, _expected, _description);
}

/// @param {Id.Instance} value The value to be tested.
/// @param {Asset.GMObject} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_child_of(_instance, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.isNotChildOf(_instance, _expected, _description);
}

/// @param {Id.Instance} value The value to be tested.
/// @param {Asset.GMObject} expected The expected value to test against.
/// @param {String} [description] An optional description for this assert.
/// @returns {Bool}
function assert_not_instance_of(_instance, _expected, _description = undefined) {

	static framework = assert_get_singleton();
	return framework.isNotInstanceOf(_instance, _expected, _description);
}

#endregion

