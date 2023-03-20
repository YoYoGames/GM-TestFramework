
// feather ignore GM2017

/// @function TestSuite()
/// @description This class represents a collection of unit tests.
function TestSuite() : TestBatch() constructor {
	
	#macro suite_start_hook startHook
	#macro suite_end_hook endHook
	#macro suite_timeout_millis timeoutMillis
	#macro suite_filter platformFilter
	#macro suite_bail_on_fail bailOnFail
	#macro suite_delay_seconds delaySeconds
	
	/// @function addFact(name, testFunc, [options])
	/// @param {String} name The name/description of the current test.
	/// @param {Function} testFunc The test function to be used during testing.
	/// @param {Struct} [options] The options be used by the test.
	static addFact = function(_name, _testFunc, _options = undefined) {
		var _fact = new Fact(_name, _testFunc, _options);
		
		add(_fact)
		
		return _fact;
	}

	/// @function addTheory(name, data, testFunc, [options])
	/// @param {String} name The name/description of the current test.
	/// @param {Array<Array>} data The dataset passed to the test function during testing.
	/// @param {Function} testFunc The test function to be used during testing.
	/// @param {Struct} [options] The options be used by the test.
	static addTheory = function(_name, _data, _testFunc, _options = undefined) {
		
		var _theory = new Theory(_name, _data, _testFunc, _options);
		
		add(_theory);
		
		return _theory;
	}
	
	/// @function addTestAsync(name, object, events, [options])
	/// @param {String} name The name/description of the current test.
	/// @param {Asset.GMObject} object The object that will handle the test execution.
	/// @param {Struct} events A struct with events to logic mappings.
	/// @param {Struct} [options] The options be used by the test.
	static addTestAsync = function(_name, _object, _events, _options = undefined) {
	
		var _testAsync = new TestAsync(_name, _object, _events, _options);
		
		add(_testAsync);
		
		return _testAsync;
	}
	
	config(config_get(self));
	
}

