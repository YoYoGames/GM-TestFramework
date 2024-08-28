
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

	 
	/// @func getTestPaths 
	/// @desc Recursively retrieves and returns a list of test paths within a test suite. Each path represents the hierarchical structure of the tests, with the option to include the root path of the current suite. If a test is itself a test suite, the function will recursively retrieve the paths for all contained tests. 
	/// @param {Bool} _include_root Whether to include the current suite's name as part of the path. 
	/// @param {String} [_parent_path] The parent path to be prepended to the test names in the returned list. If not provided, the current suite's name is used. 
	/// @returns {Array<String>} An array of strings representing the full paths of each test in the suite. 
	static getTestPaths = function(_include_root, _parent_path = undefined) { 
		var _paths = []; 
		var _current_path = _include_root ? 
			(is_undefined(_parent_path) ? getName() : $"{_parent_path}@{getName()}") :  
			undefined; 
 
		var _tests = tests; 
		var _count = array_length(_tests); 
		for (var _i = 0; _i < _count; _i++) { 
			var _test = _tests[_i]; 
			if (is_instanceof(_test, TestBatch)) { 
				_paths = array_concat(_paths, _test.getTestPaths(true, _current_path)); 
			} else { 
				array_push(_paths, $"{_current_path}@{_test.getName()}"); 
			} 
		} 
 
		return _paths; 
	} 
	 
	/// @func findTestByPath 
	/// @desc Searches for and returns a test in the suite by its full path. The path is a string representing the hierarchical location of the test within the suite, separated by "@" symbols. If the path leads to a test suite, the function will recursively search within that suite. 
	/// @param {String} _path The full path of the test to be found, represented as a string with "@" separating the hierarchy levels. 
	/// @returns {Struct.Test|undefined} The test found at the specified path, or `undefined` if no test is found. 
	static findTestByPath = function(_path) { 
		var _parts = string_split(_path, "@", true, 1); 
		var _current_part = _parts[0]; 
 
		var _tests = tests; 
		var _count = array_length(_tests); 
		for (var _i = 0; _i < _count; _i++) { 
			var _test = _tests[_i]; 
			var _test_name = _test.getName(); 
			if (_test_name == _current_part) { 
				if (array_length(_parts) == 1) { 
					return _test; 
				} 
				if (is_instanceof(_test, TestBatch)) { 
					return _test.findTestByPath(_parts[1]); 
				} 
			} 
		} 
		return undefined; 
	} 

}

