
// feather ignore GM2017

/// @function TestFrameworkRun(configuration)
/// @description This class represents an entire framework run (collection of suites).
function TestFrameworkRun() : TestBatch() constructor {

	#macro framework_start_hook startHook
	#macro framework_end_hook endHook
	#macro framework_timeout_millis timeoutMillis
	#macro framework_filter platformFilter
	#macro framework_bail_on_fail bailOnFail
	#macro framework_delay_seconds delaySeconds

	/// @function addSuite(suite)
	/// @description Adds a new test suite to the FrameworkRun process.
	/// @param {Function} suite
	static addSuite = function(_suite) {
		add(new _suite());
	}

	/// @function addWithName(name)
	/// @description Adds a new test suite to the FrameworkRun process, given its name.
	static addWithName = function(_name) {
		var _suite = variable_global_get(_name);
		addSuite(_suite);
	}
	
	config(config_get(self));
}

