
// feather ignore GM2017

#macro FRAMEWORK_DEBUG true

// ################################### INTERNAL API ####################################
// These function are used internally inside the objAsyncTask* objects to handle test
// execution. They should not be called from within tests, with the exception of the
// function 'test_end' this function should be called to finish an async test.
// #####################################################################################

global.gCurrentTest = undefined;

/// @function test_init()
/// @description Initializes a test, handles execution context bindings.
function test_init() {
	
	/// @function applyContext(events, context)
	/// @description Auxiliar function to help changing the test execution context
	/// @param {Struct} events A struct that maps events to functions
	/// @param {Id.Instance|Struct} context The context to be used during execution.
	/// @ignore
	static applyContext = function(_events, _context) {
		var _names = variable_struct_get_names(_events);
		var _length = array_length(_names);
		for (var _i = 0; _i < _length; _i++) {
			var _name = _names[_i];
			_events[$ _name] = method(_context, _events[$ _name]);
		}
	}
	
	// Apply the context to the test
	var _test = global.gCurrentTest;
	
	applyContext(_test.events, self);
	
	// Overwrite the timestamp (tighter timings)
	_test.startTimestamp = get_timer();
}

/// @function test_push()
/// @description Pushes a test to global context (only one test can be active at a time).
/// @param {Struct.Test} test The test to be pushed into global context.
function test_push(_test) {
	
	if (!is_undefined(global.gCurrentTest))
		throw log_error("test_push :: trying to run a test while another is still runnig");
		
	global.gCurrentTest = _test;
}

/// @function test_pop()
/// @description Pops a test from global context (a test can only be popped if not running anymore).
function test_pop() {
	
	var _test = global.gCurrentTest;
	
	if (is_undefined(_test))
		throw log_error("test_pop :: there is no test to pop from global scope");
	
	global.gCurrentTest = undefined;
	return _test;
}

/// @function test_current()
/// @description Returns a reference to the current running test.
/// @returns {Struct.Test}
function test_current() {
	// feather ignore GM1045
	return global.gCurrentTest;
}

/// @function test_run_event()
/// @description Runs the given event of the current test (doesn't throw)
function test_run_event(_eventName) {
	
	var _test = global.gCurrentTest;
	if (is_undefined(_test)) return;
	
	// Execute the method for the given event (if there is one)
	var _func = _test.events[$ _eventName];
	
	if (!is_callable(_func)) return;
	
	try {
		_func();
	}
	catch (_error) {
		_test.pushDiagnostic(_error, "exception");
		test_end();
	}
}

/// @function test_has_expired()
/// @description Returns true if the test has timed out, false otherwise.
/// @returns {Bool}
function test_has_expired() {

	var _test = global.gCurrentTest;
	if (is_undefined(_test)) return false;

	return _test.hasExpired();

}

/// @function test_end(forcedState)
/// @description Ends a test (used for TestAsync). Can be passed a forced result value.
/// @param {Enum.TestResult} forcedState The optional forced state value.
function test_end(_forcedResult = TestResult.Unset) {

	// Get timestamp first (tighter timings)
	var _timestamp = get_timer();
	var _test = global.gCurrentTest;
	
	_test.result = _forcedResult;
	_test.endTimestamp = _timestamp;
	
	// Run the 'ev_cleanup' in-place (if there is one)
	test_run_event("ev_cleanup");
	instance_destroy(self, true);
	
	_test.postRunFunc();
}

