

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
	timeoutHandle = undefined;

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
		
		startTimestamp = get_timer();
		
		// Create the test handler
		var _handler = instance_create_depth(0, 0, 0, object);
		
		// If the test is still running (actual async test)
		if (test_current() != undefined) {		
			timeoutHandle = call_later(timeoutMillis / 1000, time_source_units_seconds, method(_handler, function() {
				test_end(TestResult.Expired);
			}), false);
		}
	};
	/// @ignore
	postRunFunc = function() {
		
		// Cancel the timeout handle (this is required in case it has already finished)
		if (!is_undefined(timeoutHandle)) {
			call_cancel(timeoutHandle);
		}
		
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


