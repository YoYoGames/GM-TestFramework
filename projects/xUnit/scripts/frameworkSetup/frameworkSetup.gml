
// ###################### CONTROL FLAGS ######################

#macro TEST_INVALID_ARGS false

// ################# EXTERNAL CONFIGURATIONS #################

// [IMPORTANT] Don't change this line!!

// Loads external configuration file
config_manager_load("config.json");

// ################# LOGGER CONFIGURATIONS #################

// [INFORMATION] The following can be tweaked.

// Loads external configuration file
var _default_logger = logger_get("$$default$$");
_default_logger.config({ messageFormat: "[xUNIT] [{level}]: {message}" });


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

	test_start_hook: function(_test) {
				
		#region [WARNING] Don't change this block!
		
		static assertSingleton = assert_get_singleton();
		
		assertSingleton.setUserData(_test);
		
		#endregion
		
		// Do any extra required logging here (test is an instance of Test)
		log_info("Running '{0}'", _test.getName());
	},
	
	test_end_hook: function(_test, _resultBag) {
				
		// Do any extra required logging or logic here (test is an instance of Test)
		
		#region [WARNING] Changing this block might break the way the framwork runs from command line!

		// Add a new 
		if (!variable_struct_exists(_resultBag, "tests")) {
			_resultBag.tests = [];
		}
		array_push(_resultBag.tests, _test.getResultData());
		
		_test.doReset(); // Free some memory usage
		
		#endregion
	}

});

// This call sets the default configuration for the 'TestSuite' class.
// Configurable properties:
//		- suite_end_hook {Function} Hook function that will be executed at the end of the suite.
//		- suite_start_hook {Function} Hook function that will be executed at the start of the suite.
//		- suite_filter {Function} Predicate function that determines whether the suite should run or not.
//		- suite_timeout_millis {Function} The number of millis to wait until the suite timesout.
//		- suite_bail_on_fail {Bool} Should the suite bail execution after the first failed test.
//		- suite_delay_seconds {Real} The number of seconds to wait between tests.
//
config_set("TestSuite", {
	
	// Uncomment the following line to bail on first failed test
	//suite_bail_on_fail: true,
	
	suite_start_hook: function(_testSuite) {
		
		_testSuite.timestamp = time_get_unix_timestamp();
		
		// Do any extra required logging and logic here (_testSuite is an instance of TestSuite)
		log_info("Test suite '{0}' started", _testSuite.getName());
	},
	
	suite_end_hook: function(_testSuite, _resultBag, _localResultBag) {
		// Do any extra required logging and logic here (_testSuite is an instance of TestSuite)
		log_info("Test suite '{0}' ended", _testSuite.getName()); 
	
		// Add a new 
		if (!variable_struct_exists(_resultBag, "testsuites")) {
			_resultBag.testsuites = [];
		}

		_localResultBag.name = _testSuite.getName();
		_localResultBag.timestamp = _testSuite.timestamp;
		
		array_push(_resultBag.testsuites, _localResultBag);
	}

});

// This call sets the default configuration for the 'TestFrameworkRun' class.
// Configurable properties:
//		- framework_end_hook {Function} Hook function that will be executed at the end of the framework.
//		- framework_start_hook {Function} Hook function that will be executed at the start of the framework.
//		- framework_filter {Function} Predicate function that determines whether the framework should run or not.
//		- framework_timeout_millis {Function} The number of millis to wait until the framework timesout.
//		- framework_bail_on_fail {Bool} Should the framework bail execution after the first failed suite.
//		- framework_delay_seconds {Real} The number of seconds to wait between suites.
//
config_set("TestFrameworkRun", {
	
	// Uncomment the following line to bail on first failed suite
	//framework_bail_on_fail: true,
	
	framework_start_hook: function(_framework) {
		
		_framework.timestamp = time_get_unix_timestamp();
		// Do any extra required logging and logic here (_testSuite is an instance of TestFrameworkRun)
		log_info("TestFramework started");
	},
	
	framework_end_hook: function(_framework, _resultBag, _localResultBag) {
				
		#region [WARNING] Changing this block might break the way the framwork runs from command line!
				
		var _data = _localResultBag;
		_data.name = config_get_param("runName");
		_data.timestamp = _framework.timestamp;

		// Get a new publisher of type 'HttpPublisher' and register it with name '$$default$$'.
		var _resultPublisher = http_publisher_get("$$default$$");
		_resultPublisher.config({
			ip: config_get_param("serverAddress") ?? "127.0.0.1",
			port: config_get_param("serverPort") ?? 8080,
			endpoint: config_get_param("serverEndpoint") ?? "tests",
		})
		
		// Publish the results
		_resultPublisher.publish(_data);
				
		#endregion
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
		_userData.assertions++;
	},
	
	assert_pass_hook : function(_title, _description, _value, _expected, _stack, _userData) {
		_userData.assertions++;
	}

});

