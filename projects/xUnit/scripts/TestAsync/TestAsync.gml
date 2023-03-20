

/// @function TestAsync(name, object, events, options)
/// @description This class represents an asynchronous test handled by a object (ASYNC).
/// @param {String} name The name/description of the current test.
/// @param {Asset.GMObject} object The object that will handle the test execution.
/// @param {Struct} events A struct with events to logic mappings.
/// @param {Struct} options The options be used by the test.
function TestAsync(_name, _object, _events = undefined, _options = undefined) : Test(_name) constructor {
	
	/// @ignore
	object = _object;
	/// @ignore
	events = _events;

	/// @ignore
	preRunFunc = function() {
		
		// Call start hook function
		callStartHook();

		// Push test into global scope
		test_push(self);

		// Check if test collection needs to be skipped (ie.: platform specific)
		if (!shouldRun()) {
			result = TestResult.Skipped;
			return postRunFunc();
		}
		
		// Create the test handler
		instance_create_depth(0, 0, 0, object);
	};
	/// @ignore
	postRunFunc = function() {
		
		// If we don't have a state yet (there was no forced state, ie.: Skipped, Bailed, Expired)
		if (result == TestResult.Unset) result = hasDiagnostics() ? TestResult.Failed : TestResult.Passed;
		
		// Pop test from global scope
		test_pop();

		// Call end hook function
		callEndHook();

		// Execute finishing logic
		doFinish();
		
	};

	config(_options);

}

