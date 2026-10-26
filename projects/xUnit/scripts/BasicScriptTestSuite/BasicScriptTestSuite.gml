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

/// @function setArguments()
/// @description Writes to argument0 and argument1 and returns [argument_count, argument0, argument1]
/// @returns {Array}
function setArguments()
{
	argument0 = 5;
	argument1 = 6;
	return [argument_count, argument0, argument1];
}

/// @function setDeclaredArgument(_a)
/// @description Writes to argument0 which is always available as it is a declared parameter
/// @returns {Array}
function setDeclaredArgument(_a)
{
	argument0 = 7;
	return [argument_count, _a, argument0];
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
    
    addFact("argument_set_test #1", function() {
        
        // Writing to arguments that were passed to the function
        var _result = setArguments(1, 2);
        assert_array_equals(_result, [2, 5, 6], "writing to passed arguments should update them");
        
    });
    
    addFact("argument_set_test #2", function() {
        
        // Declared parameters are always available even if the caller does not pass them
        var _result = setDeclaredArgument();
        assert_array_equals(_result, [1, 7, 7], "writing to a declared parameter that was not passed should update it");
        
    });
    
    addFact("argument_set_test #3", function() {
        
        // Writing to arguments that were not passed to the function should throw
        assert_throw(function() { return setArguments(); }, "writing to argument0 when no arguments are passed should throw");
        assert_throw(function() { return setArguments(1); }, "writing to argument1 when one argument is passed should throw");
        
    });
    
    addFact("argument_set_test #4", function() {
        
        // Writing to arguments that were not passed should not corrupt the caller (GameMaker-Bugs#15992 the repeat loop never ended)
        var _loops = 0;
        repeat 3 {
            ++_loops;
            if (_loops > 3) break;
            try { setArguments(); } catch (_e) { }
        }
        assert_equals(_loops, 3, "repeat loop should run the correct number of times");
        assert_true(is_undefined(undefined), "undefined should still be undefined");
        
    });
	
}

