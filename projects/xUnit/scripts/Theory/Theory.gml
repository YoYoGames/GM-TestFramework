
/// @function Theory(name, data, testFunc, options)
/// @description This class represents a data-driven test handled by a  object (SYNC)
/// @param {String} name The name/description of the current test.
/// @param {Array<Array>} data The dataset passed to the test function during testing.
/// @param {Function} testFunc The test function to be used during testing.
/// @param {Struct} options The options be used by the test.
function Theory(_name, _data, _testFunc, _options = undefined) : TestAsync(_name, objTest) constructor {
		
	/// @ignore
	data = _data;
	/// @ignore
	testFunc = method(undefined, _testFunc);
	/// @ignore
	iteration = 0;

	// Pre-bake the event structure (this allows for un-intrusive implementation)
	/// @ignore
	events = {
		ev_create: function() {
			var _test = test_current();
			var _data = _test.data;
			var _testFunc = _test.testFunc;
			var _dataLength = array_length(_data);
			
			// Run the test for all the available data in the data set
			for (var _it = 0;_it < _dataLength;_it++) {
				_test.iteration = _it;
				method_call(_testFunc, _data[_it]);
			}
			_test.iteration = 0;
		}
	}
	
	/// @function getParams()
	/// @description Returns the input paremeters of the test if any.
	/// @returns {Array}
	static getParams = function() {
		return data[iteration];
	}
	
	config(_options);
	
}

