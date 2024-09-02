
// ###################### CONTROL FLAGS ######################

#macro TEST_INVALID_ARGS false

// ################# EXTERNAL CONFIGURATIONS #################

// [IMPORTANT] Don't change this line!!

// Loads external configuration file
config_manager_load("config.json");

// ################# INTERNAL CONFIGURATIONS #################

// [INFORMATION] The following can be tweaked.

// This call sets the default configuration for the 'Test' class.
// Configurable properties:
//		- test_end_hook {Function} Hook function that will be executed at the end of the test.
//		- test_start_hook {Function} Hook function that will be executed at the start of the test.
//		- test_filter {Function} Predicate function that determines whether the test should run or not.
//		- test_timeout_millis {Function} The number of millis to wait until the test timesout.
//
config_set("Test", {

	test_start_hook: function(_test, _resultBag) {
				
		#region [WARNING] Don't change this block!
		
		static assertSingleton = assert_get_singleton();
		
		assertSingleton.setUserData(_test);
		assertSingleton.resetAssertionCount();
		
		// place this inside the resultbag to be used later on test end
		_resultBag.unix_timestamp = time_get_unix_timestamp();
		
		#endregion
		
		// Do any extra required logging here (test is an instance of Test)
		log_info("Running '{0}'", _test.getName());
	},
	
	test_end_hook: function(_test, _resultBag) {
				
		// Do any extra required logging or logic here (test is an instance of Test)
		
		#region [WARNING] Changing this block might break the way the framwork runs from command line!
		
		static resultToCategory = [ "unset", "passed", "failed", "skipped", "bailed", "expired" ];
		static assertSingleton = assert_get_singleton();
		static usingRemoteServer = objRunner.using_remote_server;
		
		var _category = resultToCategory[_test.result];
		var _resultData = _test.getResultData();
		
		_resultData.assertions = assertSingleton.getAssertionCount();

		// Add a new 
		if (!variable_struct_exists(_resultBag, _category)) {
			_resultBag[$ _category] = [];
		}

		array_push(_resultBag[$ _category], _resultData);
		
		_test.doReset(); // Free some memory usage
		
		var _data = {
			details: _resultData,
			timestamp: _resultBag.unix_timestamp
		}
		
		// This is for the remote control stuff (if enabled)
		if (usingRemoteServer) {
			with (objRunner) {
				
				var _path_parts = string_split(_resultBag.path, "@", 1);
				_data.suite = _path_parts[0];
				
				buffer_seek(network_buffer, buffer_seek_start, 0); 
				buffer_write(network_buffer, buffer_string, json_stringify(_data)); 
				network_send_raw(socket, network_buffer, buffer_tell(network_buffer)); 
			}
		}
		// This is the data to publish to the http server
		else {
			_data.suite = _resultBag.suite;
			array_push(_resultBag.results_to_publish, _data);
		}
		
		struct_remove(_resultBag, "unix_timestamp");
		
		#endregion
	}

});

// This call sets the default configuration for the 'TestSuite' class.
// Configurable properties:
//		- suite_end_hook {Function} Hook function that will be executed at the end of the suite.
//		- suite_start_hook {Function} Hook function that will be executed at the start of the suite.
//		- suite_filter {Function} Predicate function that determines whether the suite should run or not.
//		- suite_timeout_millis {Function} The number of millis to wait until the suite timesout.
//		- suite_bail_on_fail {Bool} Should the suite bail execution after the first failed suite.
//		- suite_delay_seconds {Real} The number of seconds to wait between tests.
//
config_set("TestSuite", {
	
	suite_start_hook: function(_testSuite, _resultBag) { 
		// Do any extra required logging and logic here (_testSuite is an instance of TestSuite)
		log_info("Test suite '{0}' started", _testSuite.getName());
		_resultBag.suite = _testSuite.getName();
	},
	
	suite_end_hook: function(_testSuite, _resultBag) {
		// Do any extra required logging and logic here (_testSuite is an instance of TestSuite)
		log_info("Test suite '{0}' ended", _testSuite.getName());
		struct_remove(_resultBag, "suite");
	}

});

// This call sets the default configuration for the 'TestFrameworkRun' class.
// Configurable properties:
//		- framework_end_hook {Function} Hook function that will be executed at the end of the framework.
//		- framework_start_hook {Function} Hook function that will be executed at the start of the framework.
//		- framework_filter {Function} Predicate function that determines whether the framework should run or not.
//		- framework_timeout_millis {Function} The number of millis to wait until the framework timesout.
//		- framework_bail_on_fail {Bool} Should the suite bail execution after the first failed framework.
//		- framework_delay_seconds {Real} The number of seconds to wait between suites.
//
config_set("TestFrameworkRun", {
	
	framework_start_hook: function(_test, _resultBag) {
		
		// Do any extra required logging and logic here (_testSuite is an instance of TestFrameworkRun)
		log_info("TestFramework started");
		
		_resultBag.results_to_publish = [];
		
	},
	
	framework_end_hook: function(_test, _resultBag) {
				
		#region [WARNING] Changing this block might break the way the framwork runs from command line!
				
		var _data = {
			results: _resultBag.results_to_publish,
			run_name: config_get_param("run_name")
		}

		// Get a new publisher of type 'HttpPublisher' and register it with name '$$default$$'.
		var _resultPublisher = http_publisher_get("$$default$$")
		
		// Publish the results
		_resultPublisher.publish(_data);
		
		struct_remove(_resultBag, "results_to_publish");
		
		#endregion 
		
		// Do any extra required logging and logic here (_testSuite is an instance of TestFrameworkRun)
		log_info("TestFramework ended");
		
		// Create tallies
		var _tallies = {};
		var _resultTypes = variable_struct_get_names(_resultBag);
		var _count = array_length(_resultTypes);
		for (var _i = 0; _i < _count; _i++) {
			var _type = _resultTypes[_i];
			_tallies[$ _type] = array_length(_resultBag[$ _type]);
		}
		
		// Log failures and tallies
		log_info(_tallies);
		
		if (is_array(_resultBag[$ "failed"])) {
			array_foreach(_resultBag[$ "failed"], function(_failure) {
				log_info($"FAILED: {_failure}");
			});
		}
		
		if (is_array(_resultBag[$ "expired"])) {
			array_foreach(_resultBag[$ "expired"], function(_failure) {
				log_info($"EXPIRED: {_failure}");
			});
		}
	}

});

// This call sets the default configuration for the 'Assert' class.
// Configurable properties:
//		- assert_failed_hook {Function} Hook function that will be executed on every failed assertion.
//		- assert_passed_hook {Function} Hook function that will be executed on every passed assertion.
//
config_set("Assert", {
	
	// assert_pass_hook: function(_result, _userData) { log_info("Assert passed"); }, 
	assert_fail_hook: function(_title, _description, _value, _expected, _stack, _userData) {
		
		#region [WARNING] Don't change this block!
		
		var _result = {
			title: _title,
			description: _description,
			actual: json_stringify(_value),			// stringify value
			expected: json_stringify(_expected),	// stringify value
			stack: _stack[0]
		}
		
		// Add params if they exist (useful for data driven tests)
		var _params = _userData.getParams();
		if (!is_undefined(_params)) {
			_result.params = _params;
		}
		
		_userData.pushDiagnostic(_result, "error");
		
		#endregion
		
		// Do any extra required logging and logic here (_userData is an instance of the running Test)
		
	}

});

