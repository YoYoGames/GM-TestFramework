
// feather ignore GM2017

/// @function TestBatch()
/// @description This abstract class represents a batch of tests (allows grouping).
function TestBatch() : Test() constructor {
	
	/// @ignore
	bailOnFail = addProperty("bailOnFail", false, is_numeric);
	/// @ignore
	delaySeconds = addProperty("delaySeconds", 0.002, is_numeric);

	/// @ignore
	tests = [];
	/// @ignore
	count = array_length(tests);
	/// @ignore
	index = -1;

	/// @ignore
	localResultBag = {};

	/// @ignore
	runFunc = function(_test) {
		
		// If bail-on-fail and the state was fail (stop iteration)
		if (!is_undefined(_test) && _test.hasFailed() && shouldBailOnFail()) {
			result = TestResult.Bailed;
			postRunFunc();
		}
		// If there is a next test
		else if (next()) {
			// Delay test execution (allows spacing tests in time).
			return call_later(getDelaySeconds(), time_source_units_seconds, function() { current().run(runFunc, localResultBag); });
		}
		// There are no more tests
		else {
			postRunFunc();
		}
	}
	
	/// @function callEndHook()
	/// @description Calls the hook function assigned to the end of the execution.
	static callEndHook = function() {
		if (is_callable(endHook)) endHook(self, resultBag, localResultBag);
	}
	
	/// @function doReset()
	/// @description Internal reset logic for the test.
	/// @ignore
	static doReset = function() {
		
		// Call base function
		var _base = static_get(Test)
		var _baseDoReset = _base.doReset;
		_baseDoReset();
		
		// Also reset count and index
		count = array_length(tests);
		index = -1;
	}
	
	/// @function add(test)
	/// @description Adds a new Test to the test batch.
	/// @param {Struct.Test} test The test to be added to the batch.
	static add = function(_test) {
		
		if (!is_instanceof(_test, Test)) {
			throw log_error("add :: trying to add an element that is not a Test to '{0}'.", instanceof(self));
		}
		
		array_push(tests, _test);
		count += 1;
	}

	/// @function next()
	/// @description Goes to next index, returns false if there are no more tests
	/// @returns {Bool}
	/// @ignore
	static next = function() {
		index++;
		return index < count;
	}
	
	/// @function current()
	/// @description Returns current test from list
	/// @returns {Any}
	/// @ignore
	static current = function() {
		return index == -1 ? undefined : tests[index];
	}

	/// @function shouldBailOnFail()
	/// @description Returns whether or not the execution should bail after a failed test.
	/// @returns {Bool}
	static shouldBailOnFail = function() {
		return bailOnFail;
	}

	/// @function getDelaySeconds()
	/// @description Returns the delay between each test in the collection. This is the number of seconds TestBatch waits after finishing a test, but before starting the next one.
	/// @returns {Real}
	static getDelaySeconds = function() {
		return delaySeconds;
	}

}

