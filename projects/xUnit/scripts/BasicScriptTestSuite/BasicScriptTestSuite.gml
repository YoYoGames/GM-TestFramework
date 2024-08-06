/// @function addArguments()
/// @description This function will add together all arguments passed into it and return the result
/// @returns {Real}
function addArguments() 
{
    var _result = 0;
    
    for (var _n = argument_count - 1; _n>=0; --_n) {
        _result += argument[_n];
    }
    return _result;
}

function BasicScriptTestSuite() : TestSuite() constructor {

	addFact("script_execute_ext_test #1", function() {
			
		var _array = [ 10, 20, 30, 40, 50, 60];
        
        // Execute addArguments and check that it correctly sums the inputted array
		var _result = script_execute_ext(addArguments, _array);
		assert_equals( _result, 210, "test basic script_execute_ext");
        
	});
    
    addFact("script_execute_ext_test #2", function() {
        
        var _array = [ 10, 20, 30, 40, 50, 60];
        
        // Execute addArguments and check that it correctly sums the inputted array with an offset of 2
        var _result = script_execute_ext(addArguments, _array, 2);
        assert_equals( _result, 180, "test basic script_execute_ext with offset");
        
    });
    
    addFact("script_execute_ext_test #3", function() {
        
        var _array = [ 10, 20, 30, 40, 50, 60];
        
        // Execute addArguments and check that it correctly sums the inputted array with an offset and count of 2
        var _result = script_execute_ext(addArguments, _array, 2, 2);
        assert_equals( _result, 70, "test basic script_execute_ext with offset and count");
        
    });
	
}

