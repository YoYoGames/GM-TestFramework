
// feather ignore GM2017

function Assert(_configuration = undefined) : PropertyHolder() constructor {

	#macro assert_fail_hook failHook
	#macro assert_pass_hook passHook
	#macro assert_stack_base_depth stackBaseDepth
	#macro assert_stack_depth stackDepth

	/// @ignore
	failHook = addProperty("failHook", undefined, is_callable);
	/// @ignore
	passHook = addProperty("passHook", undefined, is_callable);
	/// @ignore
	stackBaseDepth = addProperty("stackBaseDepth", 4, is_numeric);
	/// @ignore
	stackDepth = addProperty("stackDepth", 0, is_numeric);
	
	/// @ignore
	assertionsCount = 0;
	/// @ignore
	assertDepth = 0;
	/// @ignore
	userData = undefined;
	
	/// @function setUserData(data)
	/// @description Allows to set some 'userData' that will be carried over and passed to the 'passHook' and 'failHook' functions.
	/// @param {Any} data
	static setUserData = function(_data) {
		assertionsCount = 0;
		userData = _data;
	}
	
	/// @function reset()
	/// @description Resets the current assert session including 'assertDepth' and 'userData'.
	static reset = function() {
		assertDepth = 0;
		userData = undefined;
	}
	
	/// @function getAssertionsCount()
	/// @description Returns the total number of assertions performed during this session.
	static getAssertCount = function() {
		return assertionsCount;
	}
	
	/// @function getCallStack(depth)
	/// @param {real} depth The depth of the requested callstack.
	/// @description Gets the callstack in the moment of the assertion call.
	static getCallStack = function(_depth = stackDepth) {
		// Select only the stack portion we want
		var _stack = debug_get_callstack(stackBaseDepth + _depth + 2);
		array_delete(_stack, 0, stackBaseDepth + 1);
		return _stack;
	}
	
	#region Basic Asserts
	
	/// @function fail(type, value, description, expected)
	/// @description Handles the assert_true failing logic.
	/// @param {String} information The information of assert_true being made.
	/// @param {String} description The optional assert_true description.
	/// @param {Any} value The actual result used on the assertion.
	/// @param {Any} expected The optional expected value for the assertion.
	/// @returns {Bool}
	static fail = function(_title, _description, _value = undefined, _expected = undefined) {
		
		++assertionsCount;
		if (assertDepth != 0 || !is_callable(failHook)) return false;
		
				
		failHook(self, _title, _description, _value, _expected, userData);
		
		return false;
	}
	
	/// @function pass(type, description)
	/// @description Handles the assert_true passing logic.
	/// @param {String} information The information of assert_true being made.
	/// @param {String} description The optional assert_true description.
	/// @param {Any} value The actual result used on the assertion.
	/// @param {Any} expected The optional expected value for the assertion.
	/// @returns {Bool}
	static pass = function(_title, _description, _value = undefined, _expected = undefined) {

		++assertionsCount;
		if (assertDepth != 0 || !is_callable(passHook)) return true;

		passHook(self, _title, _description, _value, _expected, userData);
		
		return true;
	}

	#endregion

	#region Value Asserts

	/// @function equals(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static equals = function(_value, _expected, _description = undefined) {
	
		static assertTitle = "Assert values to be equal";

		var _resolver = (_value == _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function notEquals(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static notEquals = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert values to not be equal";

		var _resolver = (_value != _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function greaterThan(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static greaterThan = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert value to be greater than";

		var _resolver = (_value > _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function greaterOrEqual(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static greaterOrEqual = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert value to be greater than or equal to";

		var _resolver = (_value >= _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function lessThan(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static lessThan = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert value to be less than";

		var _resolver = (_value < _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function lessOrEqual(value, expected, description)
	/// @param {Any} value The value to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static lessOrEqual = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert value to be less than or equal to";
		
		var _resolver = (_value <= _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function any_of(value, array, description)
	/// @param {Any} value The value to be tested.
	/// @param {Array} expected The array that should contain the value.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static any_of = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be any of the values in the array";
	
		if (!is_array(_expected)) throw log_error("any_of :: argument 'expected' must be of type {Array}");
		
		var _resolver = array_contains(_expected, _value) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function isNaN(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	static isNaN = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be NaN";

		var _resolver = is_nan(_value) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isNotNaN(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	static isNotNaN = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to not be NaN";

		var _resolver = !is_nan(_value) ? pass : fail;
		
		return _resolver(assertTitle, _description, _value);
	}

	#endregion

	#region Array Asserts

	/// @function arrayContains(array, expected, description)
	/// @param {Array} array The array to be tested.
	/// @param {Any} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayContains = function(_array, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Expected array to contain value";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;
	
		var _resolver = array_contains(_array, _expected) ? pass : fail;
		
		return _resolver(assertTitle, _description, _array, _expected);
	}

	/// @function arrayContainsAll(array, expected, description)
	/// @param {Array} array The array to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayContainsAll = function(_array, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Expected array to contain all values";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;
		if (!is_array(_expected)) throw log_error("arrayContainsAll :: argument 'expected' must be of type {Array}");
	
		var _resolver = array_contains_ext(_array, _expected, true) ? pass : fail;
		
		return _resolver(assertTitle, _description, _array, _expected);
	}

	/// @function arrayContainsAny(array, expected, description)
	/// @param {Array} array The array to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayContainsAny = function(_array, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert array to contain any value";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;
		if (!is_array(_expected)) throw log_error("arrayContainsAny :: argument 'expected' must be of type {Array}");
	
		var _resolver = array_contains_ext(_array, _expected, false) ? pass : fail;
		
		return _resolver(assertTitle, _description, _array, _expected);
	}

	/// @function arrayEmpty(array, description)
	/// @param {Array} array The array to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayEmpty = function(_array, _description = undefined) {

		// Assert type
		static assertTitle = "Assert array to be empty";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;
	
		// Logical operation
		var _result = array_length(_array);
		var _resolver = _result == 0 ? pass : fail;
		
		return _resolver(assertTitle, _description, _array);
	}

	/// @function arrayEquals(array, expected, description)
	/// @param {Array} array The array to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayEquals = function(_array, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Assert two arrays to be equal";

		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;
		if (!is_array(_expected)) throw log_error("arrayEquals :: argument 'expected' must be of type {Array}");

		// Define temporary passed variable.
		var _passed = true;
	
		// If array size mismtach fail.
		var _size = array_length(_array);
		if (_size != array_length(_expected)) _passed = false;

		// Loop through all elements until test fails
		for (var _i = 0; _i < _size && _passed; _i++) {
		
			// Test array entry
			var _current = _array[_i];
		
			if (is_struct(_current)) {
				assertDepth++;
				_passed = structEquals(_current, _expected[_i], _description);
				assertDepth--;
			}
			else if (is_array(_current)) {
				assertDepth++;	
				_passed = arrayEquals(_current, _expected[_i], _description);
				assertDepth--;
			}
			else if (_current != _expected[_i]) {
				_passed = false;
			}
		}

		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, _array, _expected);
	}

	/// @function arrayLength(array, expected, description)
	/// @param {Array} array The array to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayLength = function(_array, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert array length to be exactly";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;

		var _result = array_length(_array);
		var _resolver = _result == _expected ? pass : fail;
		
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function arrayNotEmpty(array, description)
	/// @param {Array} array The array to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static arrayNotEmpty = function(_array, _description = undefined) {

		// Assert type
		static assertTitle = "Assert array to not be empty";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_array(_array)) return false;

		var _result = array_length(_array);
		var _resolver = _result != 0 ? pass : fail;
		
		return _resolver(assertTitle, _description, _array);
	}

	#endregion

	#region Buffer Asserts

	/// @function bufferAlignment(buffer, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static bufferAlignment = function(_buffer, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert buffer alignment to match";
	
		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Assertion logic
		var _result = buffer_get_alignment(_buffer);
		var _resolver = (_result == _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function bufferEquals(buffer, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested.
	/// @param {Id.Buffer} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static bufferEquals = function(_buffer1, _buffer2, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert buffers to be equal (MD5 hash)";
	
		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer1)) return false;
		if (!buffer_exists(_buffer2)) throw log_error("bufferEquals :: argument 'expected' must be of type {Id.Buffer}");

		// Check if buffers are equal using MD5
		var _result = buffer_md5(_buffer1, 0, buffer_get_size(_buffer1));
		var _expected = buffer_md5(_buffer2, 0, buffer_get_size(_buffer2));
	
		// Assertion resolving
		var _resolver = (_result == _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function bufferSize(buffer, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static bufferSize = function(_buffer, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert buffer size to match";
	
		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Assertion logic
		var _result = buffer_get_size(_buffer);
		var _resolver = (_result == _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function bufferType(buffer, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested.
	/// @param {Constant.BufferType} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static bufferType = function(_buffer, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Assert buffer type to match";
	
		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Assertion logic
		var _result = buffer_get_type(_buffer);
		var _resolver = (_result == _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	#macro buffer_channel_red 0
	#macro buffer_channel_green 1
	#macro buffer_channel_blue 2
	#macro buffer_channel_alpha 3

	/// @function bufferChannelEquals(buffer, buffer_channel, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
	/// @param {Real} buffer_channel The channel to be tested.
	/// @param {Real} expected  The expected value to test against.
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	static bufferChannelEquals = function(_buffer, _channel, _expected, _description = undefined) {

		static assertTitle = "Assert surface buffer {0} channel data to equal";

		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Store old position for reset
		var _old_pos = buffer_tell(_buffer);
		buffer_seek(_buffer, buffer_seek_start, 0);

		// Apply mask to the value
		_expected = (_expected & 0xff) << (_channel * 8);
		var _mask = 0xff << (_channel * 8);

		var _resolver = pass;
		var _value = 0;
		var _size = buffer_get_size(_buffer);
		
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if ((_value & _mask) != _expected) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_seek(_buffer, buffer_seek_start, _old_pos);
	
		return _resolver(string(assertTitle, channel_get_name(_channel)), _description, _value);
	}
	
	/// @function bufferChannelLessThan(buffer, buffer_channel, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
	/// @param {Real} buffer_channel The channel to be tested.
	/// @param {Real} expected  The expected value to test against.
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	static bufferChannelLessThan = function(_buffer, _channel, _expected, _description = undefined) {

		static assertTitle = "Assert surface buffer {0} channel data to be less than";

		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Store old position for reset
		var _old_pos = buffer_tell(_buffer);
		buffer_seek(_buffer, buffer_seek_start, 0);

		// Apply mask to the value
		_expected = (_expected & 0xff) << (_channel * 8);
		var _mask = 0xff << (_channel * 8);

		var _resolver = pass;
		var _value = 0;
		var _size = buffer_get_size(_buffer);
		
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if ((_value & _mask) != _expected) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_seek(_buffer, buffer_seek_start, _old_pos);
	
		return _resolver(string(assertTitle, channel_get_name(_channel)), _description, _value);
	}

	/// @function bufferChannelLessOrEqual(buffer, buffer_channel, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
	/// @param {Real} buffer_channel The channel to be tested.
	/// @param {Real} expected  The expected value to test against.
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	static bufferChannelLessOrEqual = function(_buffer, _channel, _expected, _description = undefined) {

		static assertTitle = "Assert surface buffer {0} channel data to be less or equal to";

		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Store old position for reset
		var _old_pos = buffer_tell(_buffer);
		buffer_seek(_buffer, buffer_seek_start, 0);

		// Apply mask to the value
		_expected = (_expected & 0xff) << (_channel * 8);
		var _mask = 0xff << (_channel * 8);

		var _resolver = pass;
		var _value = 0;
		var _size = buffer_get_size(_buffer);
		
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if ((_value & _mask) != _expected) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_seek(_buffer, buffer_seek_start, _old_pos);
	
		return _resolver(string(assertTitle, channel_get_name(_channel)), _description, _value);
	}
	
	/// @function bufferChannelGreaterThan(buffer, buffer_channel, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
	/// @param {Real} buffer_channel The channel to be tested.
	/// @param {Real} expected  The expected value to test against.
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	static bufferChannelGreaterThan = function(_buffer, _channel, _expected, _description = undefined) {

		static assertTitle = "Assert surface buffer {0} channel data to be greater than";

		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Store old position for reset
		var _old_pos = buffer_tell(_buffer);
		buffer_seek(_buffer, buffer_seek_start, 0);

		// Apply mask to the value
		_expected = (_expected & 0xff) << (_channel * 8);
		var _mask = 0xff << (_channel * 8);

		var _resolver = pass;
		var _value = 0;
		var _size = buffer_get_size(_buffer);
		
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if ((_value & _mask) > _expected) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_seek(_buffer, buffer_seek_start, _old_pos);
	
		return _resolver(string(assertTitle, channel_get_name(_channel)), _description, _value);
	}
	
	/// @function bufferChannelGreaterOrEqual(buffer, buffer_channel, expected, description)
	/// @param {Id.Buffer} buffer The buffer to be tested (converted from a surface).
	/// @param {Real} buffer_channel The channel to be tested.
	/// @param {Real} expected  The expected value to test against.
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	static bufferChannelGreaterOrEqual = function(_buffer, _channel, _expected, _description = undefined) {

		static assertTitle = "Assert surface buffer {0} channel data to greater of equal to";

		// If no buffer exists for this index then exit (but don't fail)
		if (!buffer_exists(_buffer)) return false;

		// Store old position for reset
		var _old_pos = buffer_tell(_buffer);
		buffer_seek(_buffer, buffer_seek_start, 0);

		// Apply mask to the value
		_expected = (_expected & 0xff) << (_channel * 8);
		var _mask = 0xff << (_channel * 8);

		var _resolver = pass;
		var _value = 0;
		var _size = buffer_get_size(_buffer);
		
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if ((_value & _mask) >= _expected) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_seek(_buffer, buffer_seek_start, _old_pos);
	
		return _resolver(string(assertTitle, channel_get_name(_channel)), _description, _value);
	}
	
	#endregion

	#region Surface Asserts
	
	/// @function surfaceAll(surface, func, description)
	/// @param {Id.Surface} surface The surface to be tested.
	/// @param {Method} func The predicate function use as test (per pixel).
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	surfaceAll = function(_surface, _func, _description = undefined) {
		
		// Assert type
		static assertTitle = "Assert surface data to match a predicate";
	
		// If no surface exists for this index then exit (but don't fail)
		if (!surface_exists(_surface)) return false;

		// Only 'surface_rgba8unorm' format is supported
		if (surface_get_format(_surface) != surface_rgba8unorm) {
			return log_warning("Trying to run assert_surface_foreach with an incompatible format (only supports 'surface_rgba8unorm')")
		}

		// Get width and height of the surface
		var surf_width = surface_get_width(_surface);
		var surf_height = surface_get_height(_surface);

		// Cache into a buffer
		var _buffer = buffer_create(surf_width * surf_height * 4, buffer_fixed, 1);
		buffer_get_surface(_buffer, _surface, 0);

		var _size = buffer_get_size(_buffer);
		
		var _resolver = pass;
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if (!_func(_value)) {
				_resolver = fail;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_delete(_buffer);
	
		return _resolver(assertTitle, _description);
	}
	
	/// @function surfaceAny(surface, func, description)
	/// @param {Id.Surface} surface The surface to be tested.
	/// @param {Method} func The predicate function use as test (per pixel).
	/// @param {String} [description] An optional description for this assert.
	/// @returns {Bool}
	surfaceAny = function(_surface, _func, _description = undefined) {
		
		// Assert type
		static assertTitle = "Assert surface data to match a predicate";
	
		// If no surface exists for this index then exit (but don't fail)
		if (!surface_exists(_surface)) return false;

		// Only 'surface_rgba8unorm' format is supported
		if (surface_get_format(_surface) != surface_rgba8unorm) {
			return log_warning("Trying to run assert_surface_foreach with an incompatible format (only supports 'surface_rgba8unorm')")
		}

		// Get width and height of the surface
		var surf_width = surface_get_width(_surface);
		var surf_height = surface_get_height(_surface);

		// Cache into a buffer
		var _buffer = buffer_create(surf_width * surf_height * 4, buffer_fixed, 1);
		buffer_get_surface(_buffer, _surface, 0);

		var _size = buffer_get_size(_buffer);
		
		var _resolver = fail;
		while (buffer_tell(_buffer) < _size) {
			var _value = buffer_read(_buffer, buffer_u32);
			if (_func(_value)) {
				_resolver = pass;
				break;
			}
		}
		
		// Delete aux buffer
		buffer_delete(_buffer);
	
		return _resolver(assertTitle, _description);
	}
	
	#endregion

	#region Grid Asserts

	/// @function gridEqualsArray(grid, expected, description)
	/// @param {Id.DsGrid} grid The grid to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static gridEqualsArray = function(_grid, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_grid to be similar to array";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_grid, ds_type_grid) == false) return false;

		if (!is_array(_expected)) throw log_error("gridEqualsArray :: argument 'expected' must be of type {Array}");
	
		var _width = ds_grid_width(_grid);
		var _height = ds_grid_height(_grid);
	
		var _length = array_length(_expected);
		
		var _passed = true;
		
		if (_length != _width*_height) {
			_passed = false;
		}
	
		for (var _i = 0; _i < _length && _passed; _i++) {
			if (_grid[# _i % _width, _i div _width] != _expected[_i]) {	
				_passed = false;
				break;
			}
		}
		
		// Assertion logic
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_grid_to_array(_grid), _expected);
	}

	/// @function gridEquals(grid, expected, description)
	/// @param {Id.DsGrid} grid The grid to be tested.
	/// @param {Id.DsGrid} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static gridEquals = function(_value, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted two ds_grids to be equal to each other";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_value, ds_type_grid) == false) return false;

		if (ds_exists(_expected, ds_type_grid) == false)
			throw log_error("gridEquals :: argument 'expected' must be of type {grid}");
	
		var _width = ds_grid_width(_value);
		var _height = ds_grid_height(_value);
	
		var _passed = true;
	
		if (_width !=  ds_grid_width(_expected) || _height !=  ds_grid_height(_expected)) {
			_passed = false;
		}
	
		for (var _i = 0; _i < _width && _passed; _i++)
		{
			for (var _j = 0; _j < _height && _passed; _j++)
			{
				if (_value[# _i, _j] != _expected[# _i, _j]) _passed = false;
			}
		}
		
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_grid_to_array(_value), ds_grid_to_array(_expected));
	}

	/// @function gridNotEquals(grid, expected, description)
	/// @param {Id.DsGrid} grid The grid to be tested.
	/// @param {Id.DsGrid} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static gridNotEquals = function(_value, _expected, _description = undefined) {

		// Assert type 
		static assertTitle = "Asserted two ds_grids to NOT be equal to each other";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_value, ds_type_grid) == false) return false;

		if (ds_exists(_expected, ds_type_grid) == false)
			throw log_error("gridNotEquals :: argument 'expected' must be of type {grid}");

		assertDepth++;
		var _passed = gridEquals(_value, _expected, _description);
		assertDepth--;
	
		var _resolver = !_passed ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_grid_to_array(_value), ds_grid_to_array(_expected));
	}

	#endregion

	#region List Asserts

	/// @function listSize(list, expected, description)
	/// @param {Id.DsList} list The list to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static listSize = function(_list, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_list size to be equal to";
	
		// If no ds_list of this index exists then exit (but don't fail)
		if (ds_exists(_list, ds_type_list) == false) return false;

		var _result = ds_list_size(_list);
		if (_result == _expected) return pass(assertTitle, _description);

		return fail(assertTitle, _result, _description, _expected);
	}

	/// @function listEmpty(list, description)
	/// @param {Id.DsList} list The list to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static listEmpty = function(_list, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_list to be empty";
	
		// If no ds_list of this index exists then exit (but don't fail)
		if (ds_exists(_list, ds_type_list) == false) return false;

		var _resolver = ds_list_empty(_list) ? pass : fail;

		return _resolver(assertTitle, _description, ds_list_to_array(_list));
	}

	/// @function listEquals(list, expected, description)
	/// @param {Id.DsList} list The list to be tested.
	/// @param {Id.DsList} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static listEquals = function(_list, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted two ds_lists to be equal to each other";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_list, ds_type_list) == false) return false;

		if (ds_exists(_expected, ds_type_list) == false) throw log_error("listEquals :: argument 'expected' must be of type {list}");

		// Assume the assertion passes
		var _passed = true;
	
		// Early fail if size doesn't match
		var _size = ds_list_size(_list);
		if (_size != ds_list_size(_expected)) _passed = false;
	
		// Loop through all elements while test is passing
		for (var _i = 0; _i < _size && _passed; _i++) {
		
			var _current = _list[| _i];
		
			if (ds_list_is_map(_list, _i)) {
				assertDepth++;
				_passed = mapEquals(_list[| _i], _expected[| _i], _description);
				assertDepth--;
			}
			else if (ds_list_is_list(_list, _i)) {
				assertDepth++;
				_passed = listEquals(_list[| _i], _expected[| _i], _description);
				assertDepth--;
			}
			else if (is_array(_current)) {
				assertDepth++;
				_passed = arrayEquals(_current, _expected[|_i], _description);
				assertDepth--;
			}
			else if (is_struct(_current)) {
				assertDepth++;
				_passed = structEquals(_current, _expected[|_i], _description);
				assertDepth--;
			}
			else if (_current != _expected[| _i]) {
				_passed = false;
			}
		}
	
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, ds_list_to_array(_list), ds_list_to_array(_expected));
	}

	/// @function listEqualsArray(list, expected, description)
	/// @param {Id.DsList} list The list to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static listEqualsArray = function(_list, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_list to be similar to array";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_list, ds_type_list) == false) return false;
		if (!is_array(_expected)) throw log_error("listEqualsArray :: argument 'expected' must be of type {Array}");

		var _passed = true;

		// Early fail if sizes don't match
		var _length = array_length(_expected);
		if (_length != ds_list_size(_list)) _passed = false;
	
		// Loop through every element in the list
		for (var _i = 0; _i < _length && _passed; _i++) {
			if (_list[| _i] != _expected[_i]) {
				_passed = false;
				break;
			}
		}
	
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, ds_list_to_array(_list), _description, _expected);
	}

	/// @function listNotEmpty(list, description)
	/// @param {Id.DsList} list The list to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static listNotEmpty = function(_list, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_list to not be empty";
	
		// If no ds_list of this index exists then exit (but don't fail)
		if (ds_exists(_list, ds_type_list) == false) return false;
		
		var _resolver = !ds_list_empty(_list) ? pass : fail;

		return _resolver(assertTitle, _description, ds_list_to_array(_list));
	}

	#endregion

	#region Map Asserts

	/// @function mapSize(map, expected, description)
	/// @param {Id.DsMap} map The map to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static mapSize = function(_map, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_map size to be";
	
		// If no ds_map of this index exists then exit (but don't fail)
		if (ds_exists(_map, ds_type_map) == false) return false;

		// Assertion logic
		var _result = ds_map_size(_map);
		var _resolver = _result == _expected ? pass : fail;
	
		// Assertion failed
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function mapEmpty(map, description)
	/// @param {Id.DsMap} map The map to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static mapEmpty = function(_map, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_map to be empty";
	
		// If no ds_map of this index exists then exit (but don't fail)
		if (ds_exists(_map, ds_type_map) == false) return false;

		// Assertion logic
		var _resolver = ds_map_empty(_map) ? pass : fail;
	
		// Assertion failed
		return _resolver(assertTitle, _description, ds_map_keys_to_array(_map));
	}

	/// @function mapEquals(map, expected, description)
	/// @param {Id.DsMap} map The map to be tested.
	/// @param {Id.DsMap} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static mapEquals = function(_map, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted two ds_maps to be equal to each other";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_map, ds_type_map) == false) return false;
		if (ds_exists(_expected, ds_type_map) == false) throw log_error("mapEquals :: argument 'expected' must be of type {Id.DsMap}");
	
		// Assume the assertion passes
		var _passed = true;
	
		// Fail on size mismatch
		var _size = ds_map_size(_map);
		if (_size != ds_map_size(_expected)) _passed = false;
	
		// Loop through all the entries and compare them (while passes)
		var _keys = ds_map_keys_to_array(_expected);
		for (var _i = 0; _i < _size && _passed; _i++) {
		
			var _key = _keys[_i];
			var _current = _map[? _key];
		
			// Resolve nested maps
			if (ds_map_is_map(_map, _key)) {
				assertDepth++;
				_passed = mapEquals(_map[? _key], _expected[? _key], _description);
				assertDepth--;
			}
			// Resolve nested lists
			else if (ds_map_is_list(_map, _key)) {
				assertDepth++;
				_passed = listEquals(_map[? _key], _expected[? _key], _description);
				assertDepth--;
			}
			else if (is_array(_current)) {
				assertDepth++;
				_passed = arrayEquals(_map[? _key], _expected[? _key], _description);
				assertDepth--;
			}
			else if (is_struct(_current)) {
				assertDepth++;
				_passed = structEquals(_map[? _key], _expected[? _key], _description);
				assertDepth--;
			}
			// Compare values
			else if (_map[? _key] != _expected[? _key]) {	
				_passed = false;
			}
		}
	
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, json_encode(_map), json_encode(_expected));
	
	}

	/// @function mapEqualsArray(map, expected, description)
	/// @param {Id.DsMap} map The map to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static mapEqualsArray = function(_map, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_map to be similar to array";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_map, ds_type_map) == false) return false;
		if (!is_array(_expected)) throw log_error("mapEqualsArray :: argument 'expected' must be of type {Array}");

		// Assume the assertion passes.
		var _passed = true;
	
		// Fail on size mismatch
		var _length = array_length(_expected);
		if (_length != ds_map_size(_map) * 2) _passed = false;
	
		// Loop through all the entries on the map (while passing)
		for (var _i = 0; _i < _length && _passed; _i+=2) {
			if (_map[? _expected[_i]] != _expected[_i+1]) {
				_passed = false;
			}
		}
	
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, ds_map_to_array(_map), _expected);
	}

	/// @function mapNotEmpty(map, expected, description)
	/// @param {Id.DsMap} map The map to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static mapNotEmpty = function(_map, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_map to not be empty";
	
		// If no ds_map of this index exists then exit (but don't fail)
		if (ds_exists(_map, ds_type_map) == false) return false;

		// Assertion logic
		var _resolver = ds_map_empty(_map) ? pass : fail;
	
		// Assertion failed
		return _resolver(assertTitle, _description, ds_map_keys_to_array(_map));
	}

	#endregion

	#region Queue Asserts

	/// @function queueSize(queue, expected, description)
	/// @param {Id.DsQueue} queue The queue to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static queueSize = function(_queue, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_queue size to match";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_queue, ds_type_queue) == false) return false;

		var _result = ds_queue_size(_queue);
		var _resolver = _result == _expected ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function queueEmpty(queue, description)
	/// @param {Id.DsQueue} queue The queue to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static queueEmpty = function(_queue, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_queue to be empty";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_queue, ds_type_queue) == false) return false;

		var _resolver = ds_queue_empty(_queue) ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_queue_to_array(_queue));
	}

	/// @function queueEquals(queue, expected, description)
	/// @param {Id.DsQueue} queue The queue to be tested.
	/// @param {Id.DsQueue} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static queueEquals = function(_queue, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted two ds_queues to be equal to each other";
	
		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_queue, ds_type_queue) == false) return false;
		if (ds_exists(_expected, ds_type_queue) == false) throw log_error("queueEquals :: argument 'expected' must be of type {Id.DsQueue}");

		// Assume the assertion passes
		var _passed = true;

		// Fail if there is a size mismatch
		var _length = ds_queue_size(_queue);
		if (_length != ds_queue_size(_expected)) _passed = false;
	
		// If it hasn't failed already
		if (_passed) {
			repeat (_length) {

				// Take out of the queue
				var _next1 = ds_queue_dequeue(_queue);
				var _next2 = ds_queue_dequeue(_expected);

				// Jump over heavy process branch if already failed
				if (_passed) {
					if (is_struct(_next1)) {
						assertDepth++;
						_passed = structEquals(_next1, _next2, _description);
						assertDepth--;
					}
					else if (is_array(_next1)) {
						assertDepth++;
						_passed = arrayEquals(_next1, _next2, _description);
						assertDepth--;
					}
					else if (_next1 != _next2) _passed = false;
				}

				// Add to the queue again
				ds_queue_enqueue(_queue, _next1);
				ds_queue_enqueue(_expected, _next2);
			}
		}
	
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_queue_to_array(_queue), ds_queue_to_array(_expected));
	}

	/// @function queueEqualsArray(queue, expected, description)
	/// @param {Id.DsQueue} queue The queue to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static queueEqualsArray = function(_queue, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_queue to be equal to array";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_queue, ds_type_queue) == false) return false;
		if (!is_array(_expected)) throw log_error("queueEqualsArray :: argument 'expected' must be of type {Array}");
	
		// Assume the assertion passes
		var _passed = true;
	
		// Fail if the size mismatch
		var _length = array_length(_expected);
		if (_length != ds_queue_size(_queue)) _passed = false;
	
		// If it hasn't failed already
		if (_passed) {
			for (var _i = 0; _i < _length; _i++) {
		
				var _next1 = ds_queue_dequeue(_queue);
				var _next2 = _expected[_i];
		
				// Jump over heavy process branch if already failed
				if (_passed) {
					if (is_struct(_next1)) {
						assertDepth++;
						_passed = structEquals(_next1, _next2, _description);
						assertDepth--;
					}
					else if (is_array(_next1)) {
						assertDepth++;
						_passed = arrayEquals(_next1, _next2, _description);
						assertDepth--;
					}
					else if (_next1 != _next2) _passed = false;
				}
		
				ds_queue_enqueue(_queue, _next1);
			}
		}
	
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_queue_to_array(_queue), _expected);	
	}

	/// @function queueNotEmpty(queue, description)
	/// @param {Id.DsQueue} queue The queue to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static queueNotEmpty = function(_queue, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_queue to not be empty";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_queue, ds_type_queue) == false) return false;

		var _resolver = !ds_queue_empty(_queue) ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_queue_to_array(_queue));
	}

	#endregion

	#region Stack Asserts

	/// @function stackSize(stack, expected, description)
	/// @param {Id.DsStack} stack The stack to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stackSize = function(_stack, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_stack size to match";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_stack, ds_type_queue) == false) return false;

		var _result = ds_stack_size(_stack);
		var _resolver = _result == _expected ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function stackEmpty(stack, expected, description)
	/// @param {Id.DsStack} stack The stack to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stackEmpty = function(_stack, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_stack to be empty";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_stack, ds_type_queue) == false) return false;

		var _resolver = ds_stack_empty(_stack) ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_stack_to_array(_stack));
	}

	/// @function stackEquals(stack, expected, description)
	/// @param {Id.DsStack} stack The stack to be tested.
	/// @param {Id.DsStack} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stackEquals = function(_stack, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted two ds_stacks to be equal to each other";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_stack, ds_type_stack) == false) return false;
		if (ds_exists(_expected, ds_type_stack) == false) throw log_error("stackEquals :: argument 'expected' must be of type {Id.DsStack}");
	
		// Assume the assertion passes
		var _passed = true;
	
		// Fail if there is a size mismatch
		var _length = ds_stack_size(_expected);
		if (_length != ds_stack_size(_stack)) _passed = false;

		// Loop through all the elements on the stack
		var _i = 0, _temp = array_create(_length * 2);
		for (var _j = 0; _j < _length && _passed; { _j++; _i+=2 }) {
		
			var _value1 = ds_stack_pop(_stack);
			var _value2 = ds_stack_pop(_expected);
		
			_temp[_i] = _value1;
			_temp[_i + 1] = _value2;
		
			if (is_struct(_value1)) {
				assertDepth++;
				_passed = structEquals(_value1, _value2, _description);
				assertDepth--;
			}
			else if (is_array(_value1)) {
				assertDepth++;
				_passed = arrayEquals(_value1, _value2, _description);
				assertDepth--;
			}
			if (_value1 != _value2) _passed = false;
		
		}

		// Push all the data into the stack again
		repeat (_i * .5) {
			ds_stack_push(_expected, _temp[--_i]);
			ds_stack_push(_stack, _temp[--_i]);
		}
	
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, ds_stack_to_array(_stack), ds_stack_to_array(_expected));

	}

	/// @function stackEqualsArray(stack, expected, description)
	/// @param {Id.DsStack} stack The stack to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stackEqualsArray = function(_stack, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted ds_stack to be similar to array";

		// If this isn't a grid then exit (but don't fail)
		if (ds_exists(_stack, ds_type_stack) == false) return false;
		if (!is_array(_expected)) throw log_error("stackEqualsArray :: argument 'expected' must be of type {Array}");
	
		// Assume the assertion passed
		var _passed = true;
	
		// Fail on size mismatch
		var _length = array_length(_expected);
		if (_length != ds_stack_size(_stack)) _passed = false;
	
		// Loop through all the elements on the stack
		var _i = 0, _temp = array_create(_length);
		for (; _i < _length && _passed; _i++) {
		
			var _next = ds_stack_pop(_stack);
			_temp[_i] = _next;
		
			if (is_struct(_next)) {
				assertDepth++;
				_passed = structEquals(_next, _expected[_i], _description);
				assertDepth--;
			}
			else if (is_array(_next)) {
				assertDepth++;
				_passed = arrayEquals(_next, _expected[_i], _description);
				assertDepth--;
			}
			else if (_next != _expected[_i]) _passed = false;
		}

		// Push the popped data back into the stack again
		repeat (_i) {
			--_i;
			ds_stack_push(_stack, _temp[_i]);
		}
	
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, ds_stack_to_array(_stack), _expected);
	}

	/// @function stackNotEmpty(stack, expected, description)
	/// @param {Id.DsStack} stack The stack to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stackNotEmpty = function(_stack, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted ds_stack size to not be empty";
	
		// If no ds_queue of this index exists then exit (but don't fail)
		if (ds_exists(_stack, ds_type_queue) == false) return false;

		var _resolver = ds_stack_empty(_stack) ? pass : fail;
	
		return _resolver(assertTitle, _description, ds_stack_to_array(_stack));
	}

	#endregion

	#region Struct Asserts

	/// @function structSize(struct, expected, description)
	/// @param {Struct} struct The struct to be tested.
	/// @param {Real} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static structSize = function(_struct, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted struct length to match";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_struct(_struct)) return false;

		var _result = variable_struct_names_count(_struct);
		var _resolver = _result == _expected ? pass : fail;
	
		return _resolver(assertTitle, _description, _result, _expected);
	}

	/// @function structEmpty(struct, description)
	/// @param {Struct} struct The struct to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static structEmpty = function(_struct, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted struct to be empty";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_struct(_struct)) return false;

		var _result = variable_struct_names_count(_struct);
		var _resolver = _result == 0 ? pass : fail;
	
		return _resolver(assertTitle, _description, variable_struct_get_names(_struct));
	}

	/// @function structEquals(struct, expected, description)
	/// @param {Struct} struct The struct to be tested.
	/// @param {Struct} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static structEquals = function(_struct, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted two structs to be equal";

		// If this isn't an array then exit (but don't fail)
		if (!is_struct(_struct)) return false;
		if (!is_struct(_expected)) throw log_error("structEquals :: argument 'expected' must be of type {Struct}");

		// Assume the assertion passed
		var _passed = true;
	
		// Fail if sizes mismatch
		var _size = variable_struct_names_count(_struct);
		if (_size != variable_struct_names_count(_expected)) _passed = false;
	
		// Loop through all the struct elements
		var _names = variable_struct_get_names(_expected);
		for (var _i = 0; _i < _size && _passed; _i++) {
		
			var _name = _names[_i];			
			var _current = _struct[$ _name];
		
			// Resolve nested structs
			if (is_struct(_current)) {
				assertDepth++;
				_passed = structEquals(_current, _expected[$ _name], _description);
				assertDepth--;
			}
			// Resolve nested lists
			else if (is_array(_current)) {
				assertDepth++;
				_passed = arrayEquals(_current, _expected[$ _name], _description);
				assertDepth--;
			}
			// Compare values
			else if (_current != _expected[$ _name]) {	
				_passed = false;
			}
		}
	
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, _struct, _expected);
	
	}

	/// @function structNotEmpty(struct, description)
	/// @param {Struct} struct The struct to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static structNotEmpty = function(_struct, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted struct to not be empty";
	
		// If this isn't an array then exit (but don't fail)
		if (!is_struct(_struct)) return false;

		var _result = variable_struct_names_count(_struct);
		var _resolver = _result != 0 ? pass : fail;
	
		return _resolver(assertTitle, _description, variable_struct_get_names(_struct));
	}

	#endregion

	#region Exception Asserts

	/// @function notThrows(func, description)
	/// @param {Function} func The function to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static notThrows = function(_func, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted function call to not throw an error";
		
		// If this isn't a method then exit (but don't fail)
		if (!is_method(_func)) return false;
		
		var _passed = true;
		try {
			_func();
		}
		catch (_error) {
			_passed = false;
		}
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description);
	}

	/// @function throws(func, description)
	/// @param {Function} func The function to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static throws = function(_func, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted function call to throw an error";
		
		// If this isn't a method then exit (but don't fail)
		if (!is_method(_func)) return false;
	
		var _passed = true;
		try {
			var _return = _func();
			_passed = false;
		}
		catch (_error) { }
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description);
	}

	#endregion

	#region String Asserts

	/// @function stringContains(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringContains = function(_string, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted string to contain a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringContains :: argument 'expected' must be of type {String}");
	
		// Try to find the position of the substring inside the string
		var _pos = string_pos(_expected, _string);
	
		var _resolver = _pos > 0 ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringContainsAll(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringContainsAll = function(_string, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted string to contain all substrings";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_array(_expected)) throw log_error("stringContainsAll :: argument 'expected' must be of type {Array}");
	
		var _found = 0, _length = array_length(_expected);
		for (var _i = 0; _i < _length; _i++) {
			var _pos = string_pos(_expected[_i], _string);
			if (_pos > 0) _found++;
		}
	
		var _resolver = _found == _length ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringContainsAny(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringContainsAny = function(_string, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted string to contain any substrings";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_array(_expected)) throw log_error("stringContainsAny :: argument 'expected' must be of type {Array}");
	
		var _passed = false;
	
		var _length = array_length(_expected);
		for (var _i = 0; _i < _length; _i++) {
			var _pos = string_pos(_expected[_i], _string);
			if (_pos > 0) {
				_passed = true;
				break;
			}
		}
		
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringEndsWith(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringEndsWith = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to end with a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringEndsWith :: argument 'expected' must be of type {String}");
	
		var _resolver = string_ends_with(_string, _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	
	}

	/// @function stringEndsWithAny(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringEndsWithAny = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to end with any of the substrings";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_array(_expected)) throw log_error("stringEndsWithAny :: argument 'expected' must be of type {Array}");
	
		var _passed = false;
	
		// Go for each entry in the input array
		var _length = array_length(_expected);
		for (var _i = 0; _i < _length; _i++) {
			if (string_ends_with(_string, _expected[_i])) {
				_passed = true;
				break;
			}
		}
	
		var _resolver = _passed ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringEqualsIgnoreCase(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringEqualsIgnoreCase = function(_string, _expected, _description) {
	
		// Assert type
		static assertTitle = "Asserted two strings to equal (ignoring case)";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringEqualsIgnoreCase :: argument 'expected' must be of type {String}");

		var _resolver = (string_lower(_string) == string_lower(_expected)) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringNotContains(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringNotContains = function(_string, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted string to not to contain a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringNotContains :: argument 'expected' must be of type {String}");
	
		// Try to find the position of the substring inside the string
		var _pos = string_pos(_expected, _string);
	
		var _resolver = _pos <= 0 ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	}

	/// @function stringNotEndsWith(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringNotEndsWith = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to not end with a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringNotEndsWith :: argument 'expected' must be of type {String}");
	
		// Try to find the position of the substring inside the string
		var _resolver = !string_ends_with(_string, _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	
	}

	/// @function stringNotEqualsIgnoreCase(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringNotEqualsIgnoreCase = function(_string, _expected, _description) {
	
		// Assert type
		static assertTitle = "Asserted two strings to equal (ignoring case)";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringNotEqualsIgnoreCase :: argument 'expected' must be of type {String}");
	
		var _resolver = (string_lower(_string) != string_lower(_expected)) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);

	}

	/// @function stringNotStartsWith(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringNotStartsWith = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to not start with a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringNotStartsWith :: argument 'expected' must be of type {String}");
	
		// Try to find the position of the substring inside the string
		var _resolver = !string_starts_with(_string, _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	
	}

	/// @function stringStartsWith(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {String} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringStartsWith = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to start with a substring";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_string(_expected)) throw log_error("stringStartsWith :: argument 'expected' must be of type {String}");
	
		// Try to find the position of the substring inside the string
		var _resolver = string_starts_with(_string, _expected) ? pass : fail;
	
		return _resolver(assertTitle, _description, _string, _expected);
	
	}

	/// @function stringStartsWithAny(string, expected description)
	/// @param {String} str The string to be tested.
	/// @param {Array} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static stringStartsWithAny = function(_string, _expected, _description) {

		// Assert type
		static assertTitle = "Asserted string to start with any of the substrings";

		// If this isn't an array then exit (but don't fail)
		if (!is_string(_string)) return false;
		if (!is_array(_expected)) throw log_error("stringStartsWithAny :: argument 'expected' must be of type {Array}");
	
		var _passed = false;
	
		// Go for each entry in the input array
		var _length = array_length(_expected);
		for (var _i = 0; _i < _length; _i++) {
			if (string_starts_with(_string, _expected[_i])) {
				_passed = true;
				break;
			};
		}
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, _string, _expected);
	}

	#endregion

	#region Type Asserts

	/// @function isTypeOf(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isTypeOf = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be of a given type";

		var _resolver = typeof(_value) == _expected ? pass : fail;
	
		if (_resolver == fail) {
			show_debug_message($"{_value} :: {typeof(_value)} != {_expected}");
		}
	
		return _resolver(assertTitle, _description, typeof(_value), _expected);
	}

	/// @function isFalse(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isFalse = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be false";

		var _resolver = _value == false ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isNotNull(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNotNull = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to not be null";

		var _resolver = _value != pointer_null ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isNotTypeOf(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNotTypeOf = function(_value, _expected, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to not be of a given type";

		var _resolver = typeof(_value) != _expected ? pass : fail;
	
		return _resolver(assertTitle, _description, _value, _expected);
	}

	/// @function isNotUndefined(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNotUndefined = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to not be undefined";

		var _resolver = _value != undefined ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isNull(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNull = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be null";

		var _resolver = _value == pointer_null ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isUndefined(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isUndefined = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to not be undefined";

		var _resolver = _value == undefined ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);
	}

	/// @function isTrue(value, description)
	/// @param {Any} value The value to be tested.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isTrue = function(_value, _description = undefined) {
	
		// Assert type
		static assertTitle = "Asserted value to be true";

		var _resolver = _value == true ? pass : fail;
	
		return _resolver(assertTitle, _description, _value);	
	}

	#endregion

	#region Object Asserts

	/// @function isChildOf(instance, expected, description)
	/// @param {Id.Instance} value The value to be tested.
	/// @param {Asset.GMObject} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isChildOf = function(_instance, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted instance to be a child of";

		// If argument0 is not an instance then fail
		if (!instance_exists(_instance)) throw log_error("isChildOf :: argument 'value' must be of type {Id.Instance}");

		// If argument1 is not an object ID then fail
		if (!object_exists(_expected)) throw log_error("isChildOf :: argument 'expected' must be of type {Asset.GMObject}");

		var _passed = true;

		var _childObj = _instance.object_index;
		if (_childObj == _expected || !object_is_ancestor(_childObj, _expected))		
			_passed = false;
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, object_get_name(_childObj), object_get_name(_expected));
	}

	/// @function isInstanceOf(instance, expected, description)
	/// @param {Id.Instance} value The value to be tested.
	/// @param {Asset.GMObject} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isInstanceOf = function(_instance, _expected, _description = undefined) {
							
		// Assert type
		static assertTitle = "Asserted value to be an instance of";

		// If argument0 is not an instance then fail
		if (!instance_exists(_instance)) throw log_error("isInstanceOf :: argument 'value' must be of type {Id.Instance}");

		// If argument1 is not an object ID then fail
		if (!object_exists(_expected)) throw log_error("isInstanceOf :: argument 'expected' must be of type {Asset.GMObject}");

		var _passed = true;
		
		var _childObj = _instance.object_index;
		if (_childObj != _expected) 
			_passed = false;	
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, object_get_name(_childObj), object_get_name(_expected));
	}

	/// @function isNotChildOf(instance, expected, description)
	/// @param {Id.Instance} value The value to be tested.
	/// @param {Asset.GMObject} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNotChildOf = function(_instance, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted instance to not be a child of";

		// If argument0 is not an instance then fail
		if (!instance_exists(_instance)) throw log_error("isNotChildOf :: argument 'value' must be of type {Id.Instance}");

		// If argument1 is not an object ID then fail
		if (!object_exists(_expected)) throw log_error("isNotChildOf :: argument 'expected' must be of type {Asset.GMObject}");
		
		var _passed = true;

		var _childObj = _instance.object_index;
		if (object_is_ancestor(_childObj, _expected))		
			_passed = false;
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, object_get_name(_childObj), object_get_name(_expected));
		
	}

	/// @function isNotInstanceOf(instance, expected, description)
	/// @param {Id.Instance} value The value to be tested.
	/// @param {Asset.GMObject} expected The expected value to test against.
	/// @param {String} [description] An optional description for this assert_true.
	/// @returns {Bool}
	static isNotInstanceOf = function(_instance, _expected, _description = undefined) {

		// Assert type
		static assertTitle = "Asserted value to not be an instance of";

		// If argument0 is not an instance then fail
		if (!instance_exists(_instance)) throw log_error("isNotInstanceOf :: argument 'value' must be of type {Id.Instance}");

		// If argument1 is not an object ID then fail
		if (!object_exists(_expected)) throw log_error("isNotInstanceOf :: argument 'expected' must be of type {Asset.GMObject}");

		var _passed = true;
		
		var _childObj = _instance.object_index;
		if (_childObj == _expected) 
			_passed = false;	
		
		var _resolver = _passed ? pass : fail;
		
		return _resolver(assertTitle, _description, object_get_name(_childObj), object_get_name(_expected));
	}

	#endregion

	// Apply default configuration
	config(config_get(self));
	
	// Apply configuration
	config(_configuration);
	
}

