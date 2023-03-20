
function BasicScriptTestSuite() : TestSuite() constructor {

	addFact("script_execute_ext_test", function() {

		function addArguments()
		{
			var _result = 0;
			
			for (var _n = argument_count - 1; _n>=0; --_n) {
				_result += argument[_n];
			}
			return _result;
		}
			
		var _array = [ 10, 20, 30, 40, 50, 60];
		var _result = script_execute_ext(addArguments, _array);
		assert_equals( _result, 210, "#1.0 - test basic script_execute_ext");
		
		_result = script_execute_ext(addArguments, _array, 2);
		assert_equals( _result, 180, "#1.1 - test basic script_execute_ext with offset");
		
		_result = script_execute_ext(addArguments, _array, 2, 2);
		assert_equals( _result, 70, "#1.2 - test basic script_execute_ext with offset and count");
	})
	
}

