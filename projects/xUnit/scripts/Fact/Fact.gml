
/// @function Fact(name, testFunc, options)
/// @description This class represents a basic test handled by a  object (SYNC).
/// @param {String} name The name/description of the current test.
/// @param {Function} testFunc The test function to be used during testing.
/// @param {Struct} options The options be used by the test.
function Fact(_name, _testFunc, _options = undefined) : TestAsync(_name, objTest) constructor {
	
	// Pre-bake the event structure (this allows for un-intrusive implementation)
	/// @ignore
	events = { ev_create: _testFunc };
	
	config(_options);
	
}

