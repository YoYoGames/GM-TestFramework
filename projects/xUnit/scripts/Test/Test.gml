
// feather ignore GM2017
// feather ignore GM1042

/// @function Test(name)
/// @description This class represents a synchronous test.
/// @param {String} name The name/description of the current test.
/// @param {Struct} options The options be used by the test.
function Test(_name = undefined) : Task() constructor {

	#macro test_timeout_millis timeoutMillis
	#macro test_filter platformFilter
	#macro test_start_hook startHook
	#macro test_end_hook endHook
	
	enum TestResult { Unset = 0, Passed, Failed, Skipped, Bailed, Expired };
	
	static resultStrings = [ "Unset", "Passed", "Failed", "Skipped", "Bailed", "Expired" ];
	
	/// @ignore
	startHook = addProperty("startHook", undefined, is_callable);
	/// @ignore
	endHook = addProperty("endHook", undefined, is_callable);
	/// @ignore
	timeoutMillis = addProperty("timeoutMillis", 60000, is_real);
	/// @ignore
	platformFilter = addProperty("platformFilter", undefined, is_callable);
	
	/// @ignore
	name = _name;
	
	/// @ignore
	preRunFunc = function() {
		
		callStartHook();

		startTimestamp = get_timer();
		
		// Check if test needs to be skipped (ie.: platform specific)
		if (!shouldRun()) {
			result = TestResult.Skipped;
			return postRunFunc();
		}
		runFunc();
	};
	/// @ignore
	runFunc = function() {
		// Does nothing just skip to the post run
		postRunFunc();
	}	
	/// @ignore
	postRunFunc = function() {
		
		endTimestamp = get_timer();
		
		// If we don't have a state yet (there was no forced state, ie.: Skipped, Bailed, Expired)
		if (result == TestResult.Unset) result = hasDiagnostics() ? TestResult.Failed : TestResult.Passed;
		
		callEndHook();
		
		// Execute finishing logic
		doFinish();
	};
	/// @ignore
	callbackFunc = undefined;

	// Used for internal purposes (should use getters) 
	/// @ignore 
	result = TestResult.Unset;
	/// @ignore
	startTimestamp = 0;
	/// @ignore
	endTimestamp = 0;	
	/// @ignore
	resultBag = undefined;

	static run_Task = run;
	/// @function run(callbackFunc, resultBag)
	/// @description Runs the current test.
	/// @param {Function} callbackFunc The function to be called at the end of execution.
	/// @param {Any} resultBag The result collector that is carried along between nested tests.
	static run = function(_callbackFunc = undefined, _resultBag = undefined) {
		resultBag = _resultBag;
		run_Task(_callbackFunc);
	}

	/// @function getResult()
	/// @description Gets the test result value.
	/// @returns {Real}
	static getResult = function() {
		return result;
	}
	
	/// @function getResultString()
	/// @description Gets the test result string value.
	/// @returns {String}
	static getResultString = function() {
		return resultStrings[result];
	}
		
	/// @function getDuration()
	/// @description Gets the test duration (micros)
	/// @returns {Real}
	static getDuration = function() {
		return endTimestamp - startTimestamp;
	}
	
	/// @function getName()
	/// @description Gets the test name.
	/// @returns {String}
	static getName = function() {
		name ??= instanceof(self);
		return name;
	}

	/// @function getResultData()
	/// @description Provides a summary of the test result.
	/// @returns {Struct}
	static getResultData = function() {
	
		var _summary = {
			name: getName(),
			result: getResultString(),
		}
		
		switch (result) {
			
			case TestResult.Passed:
			case TestResult.Bailed:
				_summary.duration = getDuration();
				break;
			
			case TestResult.Expired:
			case TestResult.Failed:
				_summary.duration = getDuration();
				_summary.errors = getDiagnostics("error") ?? [];
				_summary.exceptions = getDiagnostics("exception") ?? [];
				break;
				
			case TestResult.Skipped:
				break;
		}
		
		return _summary;	
	}

	/// @function getParams()
	/// @description Returns the input paremeters of the test if any.
	/// @returns {Array}
	static getParams = function() {
		return undefined;
	}

	/// @function shouldRun()
	/// @description Returns whether or not the test should run based on the current platform.
	/// @returns {Bool}
	static shouldRun = function() {
		if (is_callable(platformFilter))
			return platformFilter();
		return true;
	}
	
	/// @function callStartHook()
	/// @description Calls the hook function assigned to the start of the execution.
	static callStartHook = function() {
		if (is_callable(startHook)) startHook(self, resultBag);
	}
	
	/// @function callEndHook()
	/// @description Calls the hook function assigned to the end of the execution.
	static callEndHook = function() {
		if (is_callable(endHook)) endHook(self, resultBag);
	}

	/// @function hasExpired()
	/// @description Returns whether or not this test should timeout.
	/// @returns {Bool}
	static hasExpired = function() {
		return isRunning() && ((get_timer() - startTimestamp) > timeoutMillis*1000);
	}
	
	/// @function hasFailed()
	/// @description Returns whether or not this test has failed.
	/// @returns {Bool}
	static hasFailed = function() {
		return result == TestResult.Failed || result == TestResult.Expired;
	}
	
	config(config_get(self));

}

