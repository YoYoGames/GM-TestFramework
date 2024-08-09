
// Define macros
#macro kInt_1_RandomRangeTest 24
#macro kInt_2_RandomRangeTest 42
#macro kInt64_1_RandomRangeTest int64(5000)
#macro kInt64_2_RandomRangeTest int64(10000)
#macro kReal_1_RandomRangeTest 24.5
#macro kReal_2_RandomRangeTest 42.5

#macro kInt_RandomTest 42
#macro kInt64_RandomTest int64(5000)
#macro kReal_RandomTest 42.5

function BasicRandomTestSuite()  : TestSuite() constructor {

	addFact("choose_test #1", function() {

		var _input, _output;

		//#1 choose ( pointer )
		_input = ptr({});
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( pointer:local ), should return the input");
		assert_typeof(_output, "ptr", "choose ( pointer:local ), failed to return the correct type");
		
	});

	addFact("choose_test #2", function() {

		var _input, _output;
			
		//#2 choose ( pointer_invalid )
		_input = pointer_invalid;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( pointer_invalid:local ), should return the input");
		assert_typeof(_output, "ptr", "choose ( pointer_invalid:local ), failed to return the correct type");
		
	});

	addFact("choose_test #3", function() {

		var _input, _output;
			
		//#3 choose ( pointer_null )
		_input = pointer_null;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( pointer_null:local ), should return the input");
		assert_typeof(_output, "ptr", "choose ( pointer_null:local ), failed to return the correct type");
		
	});

	addFact("choose_test #4", function() {

		var _input, _output;
			
		//#4 choose ( real )
		_input = 32.33;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( real:local ), should return the input");
		assert_typeof(_output, "number", "choose ( real:local ), failed to return the correct type");
		
	});

	addFact("choose_test #5", function() {

		var _input, _output;
			
		//#5 choose ( int32 )
		_input = int32(22);
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( int32:local ), should return the input");
		
		var _type = platform_not_browser() ? "int32" : "number";
		assert_typeof(_output, _type, "choose ( int32:local ), failed to return the correct type");
		
	});

	addFact("choose_test #6", function() {

		var _input, _output;

		//#6 choose ( int64 )
		_input = int64(12);
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( int64:local ), should return the input");
		assert_typeof(_output, "int64", "choose ( int64:local ), failed to return the correct type");
		
	});

	addFact("choose_test #7", function() {

		var _input, _output;
						
		//#7 choose ( string )
		_input = "-21233.223";
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( string:local ), should return the input");
		assert_typeof(_output, "string", "choose ( string:local ), failed to return the correct type");
		
	});

	addFact("choose_test #8", function() {

		var _input, _output;

		//#8 choose ( bool )
		_input = true;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( bool:local ), should return the input");
		assert_typeof(_output, "bool", "choose ( bool:local ), failed to return the correct type");
		
	});

	addFact("choose_test #9", function() {

		var _input, _output;

		//#9 choose ( nan )
		_input = NaN;
		_output = choose(_input);
		assert_nan(_output, "choose ( NaN:local ), should return the input");
		assert_typeof(_output, "number", "choose ( NaN:local ), failed to return the correct type");
		
	});

	addFact("choose_test #10", function() {

		var _input, _output;
			
		//#10 choose ( infinity )
		_input = infinity;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( infinity:local ), should return the input");
		assert_typeof(_output, "number", "choose ( infinity:local ), failed to return the correct type");
		
	});

	addFact("choose_test #11", function() {

		var _input, _output;
			
		//#11 choose ( undefined )
		_input = undefined;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( undefined:local ), should return the input");
		assert_typeof(_output, "undefined", "choose ( undefined:local ), failed to return the correct type");
		
	});

	addFact("choose_test #12", function() {

		var _input, _output;

		//#12 choose ( struct )
		_input = { key: "value" };
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( struct:local ), should return the input");
		assert_typeof(_output, "struct", "choose ( struct:local ), failed to return the correct type");
		
	});

	addFact("choose_test #13", function() {

		var _input, _output;

		//#13 choose ( array )
		_input = [];
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( array:local ), should return the input");
		assert_typeof(_output, "array", "choose ( array:local ), failed to return the correct type");
		
	});

	addFact("choose_test #14", function() {

		var _input, _output;
			
		//#14 choose ( method )
		_input = function() {};
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( method:local ), should return the input");
		assert_typeof(_output, "method", "choose ( method:local ), failed to return the correct type");
		
	});

	addFact("choose_test #15", function() {

		var _input, _output;
			
		//#15 choose ( function )
		_input = get_timer;
		_output = choose(_input);
		assert_equals(_output, _input, "choose ( function:local ), should return the input");
		
		var _type = platform_not_browser() ? "number" : "method";
		assert_typeof(_output, _type, "choose ( function:local ), failed to return the correct type");
		
	});

	addFact("choose_test #16", function() {

		var _output;
			
		//#16 choose()
		_output = choose();
		assert_equals(_output, 0, "choose ( empty ), should return 0");	
		
	});

	addFact("choose_test #17", function() {

		var _output;
		
		//#17 choose( real const , real const , real const , real const )
		_output = choose(0.5, 1.1, 2.0, 99.9);
		assert_any_of(_output, [0.5, 1.1, 2.0, 99.9], "choose ( real,... ), the result should be one of the provided");
		assert_typeof(_output, "number", "choose ( real,... ), failed to return the correct type");
		
	});

	addFact("choose_test #18", function() {

		var _output;
			
		//#18 choose( int64 const , int64 const , int64 const , int64 const )
		_output = choose(0x1122334455667788, 0x8877665544332211, 0x7FFFFFFFFFFFFFFF, 0x5566778811223344);
		assert_any_of(_output, [0x1122334455667788, 0x8877665544332211, 0x7FFFFFFFFFFFFFFF, 0x5566778811223344], "choose ( int64,... ), the result should be one of the provided");
		assert_typeof(_output, "int64", "choose ( int64,... ), failed to return the correct type");
		
	});

	addFact("choose_test #19", function() {

		var _output;
			
		//#19 choose( string const , string const , string const , string const )
		_output = choose("one", "two", "three", "four");
		assert_any_of(_output, ["one", "two", "three", "four"], "choose ( string,... ), the result should be one of the provided");
		assert_typeof(_output, "string", "choose ( string,... ), failed to return the correct type");
		
	});

	addFact("choose_test #20", function() {

		var _input, _output;
			
		//#20 choose( string const , real const , real const , int64 const )
		_output = choose("one", 2.0, int32(3), int64(0x0004));
		assert_any_of(_output, ["one", 2.0, int32(3), int64(0x0004)], "choose( string, real, int32, int64 ), the result should be one of the provided");
		assert_any_of(typeof(_output), ["string", "number", "int32", "int64"], "choose( string, real, int32, int64 ), failed to return the correct type");
		
	});

	addFact("choose_test #21", function() {

		var _input, _output;
			
		// Tests for non-identical results (this tests could legitimitely fail but is unlikely to)
		//#21 choose( x1, x2, x3, ... ) - non-identical test
		var _iterations = 100;
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _choice1 = choose(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100);
			var _choice2 = choose(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100);
				
			// count number of identical results
			if(_choice1 == _choice2)
			{
				_identicalCount++;
			}
		}
		assert_not_equals(_iterations, _identicalCount, "choose( x1, x2, x3, ... ), returned always the same output");
			
	});
	
	// IRANDOM RANGE TESTS
	
	addFact("irandom_range_test # #1", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#1 irandom_range ( 10, 20 )
			_output = irandom_range(10, 20);
			assert_true( _output >= 10 && _output <= 20 , "irandom_range ( 10, 20 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #2", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#2 irandom_range ( 20, 10 )
			_output = irandom_range(20, 10);
			assert_true( _output >= 10 && _output <= 20 , "irandom_range ( 20, 10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #3", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#3 irandom_range ( 10, 10 )
			_output = irandom_range(10, 10);
			assert_true( _output == 10 , "irandom_range ( 10, 10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #4", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
						
			//#4 irandom_range ( -20 , -10 )
			_output = irandom_range(-20, -10);
			assert_true( _output >= -20 && _output <= -10 , "irandom_range ( -20 , -10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #5", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#5 irandom_range ( -10 , -20 )
			_output = irandom_range(-10, -20);
			assert_true( _output >= -20 && _output <= -10 , "irandom_range ( -10 , -20 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #6", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#6 irandom_range ( -10 , -10 )
			_output = irandom_range(-10, -10);
			assert_true( _output == -10 , "irandom_range ( -10 , -10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #7", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#7 irandom_range ( -10 , 10 )
			_output = irandom_range(-10, 10);
			assert_true( _output >= -10 && _output <= 10 , "irandom_range ( -10 , 10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #8", function() {

		var _output, _iterations = 1000;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#8 irandom_range ( 10 , -10 )
			_output = irandom_range(10, -10);
			assert_true( _output >= -10 && _output <= 10 , "irandom_range ( 10 , -10 ), failed to return a number within range");
			
		}
		
	});

	addFact("irandom_range_test # #9", function() {

		var _output, _iterations = 1000;
			
		var _int32_1 = int32(2);
		var _int32_2 = int32(10);
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#9 irandom_range ( int32, int32 )
			_output = irandom_range( _int32_1 , _int32_2 );
			assert_true( _output >= _int32_1 && _output <= _int32_2 , "irandom_range ( int32 , int32 ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_range_test # #10", function() {

		var _output, _iterations = 1000;
			
		var _int32_1 = int32(2);
		var _int32_2 = int32(10);
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#10 irandom_range ( -int32 , -int32 )
			_output = irandom_range(-_int32_1, -_int32_2);
			assert_true( _output >= -_int32_2 && _output <= -_int32_1 , "irandom_range ( int32 , int32 ), failed to return a number within range (negative)" );
			
		}
		
	});

	addFact("irandom_range_test # #11", function() {

		var _output, _iterations = 1000;
		
		var _int64_1 = int64(12);
		var _int64_2 = int64(70);
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#11 irandom_range ( int64, int64 )
			_output = irandom_range( _int64_1 , _int64_2 );
			assert_true( _output >= _int64_1 && _output <= _int64_2 , "irandom_range ( int64 , int64 ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_range_test # #12", function() {

		var _output, _iterations = 1000;
		
		var _int64_1 = int64(12);
		var _int64_2 = int64(70);
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//#12 irandom_range ( -int64 , -int64 )
			_output = irandom_range(-_int64_1, -_int64_2);
			assert_true( _output >= -_int64_2 && _output <= -_int64_1 , "irandom_range ( int64 , int64 ), failed to return a number within range (negative)" );
			
		}
		
	});
			
	// test for non-identical results (this could legitimitely fail but is unlikely to)

	addFact("irandom_range_test # #13", function() {

		var _output, _iterations = 1000;
			
		// #14 irandom_range( int const , int const ) - non-identical test
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = irandom_range(500, 99999);
			var _res2 = irandom_range(500, 99999);
				
			// count number of identical results
			if(_res1 == _res2)
			{
				_identicalCount++;
			}
		}
		
		assert_not_equals(_identicalCount, _iterations, "irandom_range( x1, x2 ), returned always the same output");
		
	});

	addFact("irandom_range_test # #14", function() {
			
		assert_throw(function() {
			// feather ignore once GM1041
			return irandom_range([], []);
		}, "irandom_range( array, array ), should throw an error");
		
	});

	addFact("irandom_range_test # #15", function() {
			
		assert_throw(function() {
			// feather ignore once GM1041
			return irandom_range(undefined, undefined);
		}, "irandom_range( undefined, undefined ), should throw an error");
		
	});
	
	// IRANDOM TESTS
	
	addFact("irandom_test #1", function() {
			
		var _output, _iterations = 1000;
		var _failed = false;
		
		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#1 irandom ( real )
			_output = irandom(42);
			_failed |= !assert_true( _output >= 0 && _output <= 42 , "irandom ( real ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_test #2", function() {
			
		var _output, _iterations = 1000;		
		var _failed = false;
		
		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#2 irandom ( -real )
			_output = irandom(-42);
			_failed |= !assert_true( _output >= -42 && _output <= 0 , "irandom ( -real ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_test #3", function() {
			
		var _output, _iterations = 1000;	
		var _failed = false;
		
		var _int32_1 = int32(2);
		
		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#3 irandom ( int32 )
			_output = irandom(_int32_1);
			_failed |= !assert_true( _output >= 0 && _output <= _int32_1 , "irandom ( int32 ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_test #4", function() {
			
		var _output, _iterations = 1000;
		var _failed = false;
		
		var _int32_1 = int32(2);
		
		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#4 irandom ( int32 )
			_output = irandom(-_int32_1);
			_failed |= !assert_true( _output >= -42 && _output <= 0 , "irandom ( -int32 ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_test #5", function() {
			
		var _output, _iterations = 1000;
		var _failed = false;		
		
		var _int64_1 = int64(12);	

		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#5 irandom ( int64 )
			_output = irandom(_int64_1);
			_failed |= !assert_true( _output >= 0 && _output <= _int64_1 , "irandom ( int64 ), failed to return a number within range" );
			
		}
		
	});

	addFact("irandom_test #6", function() {
			
		var _output, _iterations = 1000;
		var _failed = false;		
		
		var _int64_1 = int64(12);	

		for(var _iter = 0; _iter < _iterations && !_failed; ++_iter)
		{
			//tests for positive int types
			
			//#6 irandom ( -int64 )
			_output = irandom(-_int64_1);
			_failed |= !assert_true( _output >= -_int64_1 && _output <= 0 , "irandom ( -int64 ), failed to return a number within range" );
		}
		
	});

	addFact("irandom_test #7", function() {
			
		var _output, _iterations = 1000;
			
		// #7 irandom( int const ) - non-identical test
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = irandom(99999);
			var _res2 = irandom(99999);
				
			// count number of identical results
			if(_res1 == _res2) _identicalCount++;
		}
		assert_not_equals(_identicalCount, _iterations, "irandom( int const ), returned always the same output");
			
	});
	
	// RANDOMISE TESTS
	
	addFact("randomise_test #1", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
			
		var seed_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			var _seed1 = randomise();
			
			// Since the generated seed when calling randomise() is based on the milliseconds since the game began, this value may not always be different
			// if randomise is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomise();
			
			//#1 randomise() - non-identical seed test
			if(_seed1 == _seed2) seed_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
			
		assert_less_or_equal(seed_TestFailCount, minFails, "randomise(), collisions are greater than 25%");
			
	});

	addFact("randomise_test #2", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
		
		var random_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomise();
			
			// Since the generated seed when calling randomise() is based on the milliseconds since the game began, this value may not always be different
			// if randomise is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomise();
				
			var randomValue = random(9999);
				
			//#2 random() - non-identical random() value test
			if(randomValue == random(9999)) random_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
			
		assert_less_or_equal(random_TestFailCount, minFails, "random(), collisions are greater than 25%");
			
	});

	addFact("randomise_test #3", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;

		var irandom_TestFailCount = 0;

		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomise();
			
			// Since the generated seed when calling randomise() is based on the milliseconds since the game began, this value may not always be different
			// if randomise is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomise();
			
			var irandomValue = irandom(9999);
				
			//#3 irandom() - non-identical irandom() value test
			if(irandomValue == irandom(9999)) irandom_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(irandom_TestFailCount, minFails, "irandom(), collisions are greater than 25%");
			
	});

	addFact("randomise_test #4", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
		
		var random_range_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomise();
			
			// Since the generated seed when calling randomise() is based on the milliseconds since the game began, this value may not always be different
			// if randomise is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomise();
			
			var random_rangeValue = random_range(100, 9999);
			
			//#4 random_range() - non-identical random_range() value test
			if(random_rangeValue == random_range(100, 9999)) random_range_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(random_range_TestFailCount, minFails, "random_range(), collisions are greater than 25%");
			
	});

	addFact("randomise_test #5", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
			
		var irandom_range_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomise();
			
			// Since the generated seed when calling randomise() is based on the milliseconds since the game began, this value may not always be different
			// if randomise is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomise();
				
			var irandom_rangeValue = irandom_range(100, 9999);
				
			//#5 random_range() - non-identical random_range() value test
			if(irandom_rangeValue == irandom_range(100, 9999)) irandom_range_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(irandom_range_TestFailCount, minFails, "irandom_range(), collisions are greater than 25%");
			
	});
	
	// RANDOMIZE TESTS (different to randomise)
	
	addFact("randomize_test #1", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
			
		var seed_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			var _seed1 = randomize();
			
			// Since the generated seed when calling randomize() is based on the milliseconds since the game began, this value may not always be different
			// if randomize is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomize();
			
			//#1 randomize() - non-identical seed test
			if(_seed1 == _seed2) seed_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
			
		assert_less_or_equal(seed_TestFailCount, minFails, "randomize(), collisions are greater than 25%");
			
	});

	addFact("randomize_test #2", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
		
		var random_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomize();
			
			// Since the generated seed when calling randomize() is based on the milliseconds since the game began, this value may not always be different
			// if randomize is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomize();
				
			var randomValue = random(9999);
				
			//#2 random() - non-identical random() value test
			if(randomValue == random(9999)) random_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
			
		assert_less_or_equal(random_TestFailCount, minFails, "random(), collisions are greater than 25%");
			
	});

	addFact("randomize_test #3", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;

		var irandom_TestFailCount = 0;

		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomize();
			
			// Since the generated seed when calling randomize() is based on the milliseconds since the game began, this value may not always be different
			// if randomize is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomize();
			
			var irandomValue = irandom(9999);
				
			//#3 irandom() - non-identical irandom() value test
			if(irandomValue == irandom(9999)) irandom_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(irandom_TestFailCount, minFails, "irandom(), collisions are greater than 25%");
			
	});

	addFact("randomize_test #4", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
		
		var random_range_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomize();
			
			// Since the generated seed when calling randomize() is based on the milliseconds since the game began, this value may not always be different
			// if randomize is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomize();
			
			var random_rangeValue = random_range(100, 9999);
			
			//#4 random_range() - non-identical random_range() value test
			if(random_rangeValue == random_range(100, 9999)) random_range_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(random_range_TestFailCount, minFails, "random_range(), collisions are greater than 25%");
			
	});

	addFact("randomize_test #5", function() {

		// tests for non-identical seed and returned random function values
		// (these could legitimitely fail but are very unlikely to)
		var _iterations = 1000;
			
		var irandom_range_TestFailCount = 0;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
				
			var _seed1 = randomize();
			
			// Since the generated seed when calling randomize() is based on the milliseconds since the game began, this value may not always be different
			// if randomize is called in quick succession. To ensure the test still succeeds in this case, we wait here until the current time changes.
			var timeBeforeContinue = current_time + 1;
			while (current_time < timeBeforeContinue) {}
			
			var _seed2 = randomize();
				
			var irandom_rangeValue = irandom_range(100, 9999);
				
			//#5 random_range() - non-identical random_range() value test
			if(irandom_rangeValue == irandom_range(100, 9999)) irandom_range_TestFailCount++;
		}
			
		var minFails = _iterations*.25;
		
		assert_less_or_equal(irandom_range_TestFailCount, minFails, "irandom_range(), collisions are greater than 25%");
			
	});

	// RANDOM GET SEED TESTS
	
	addFact("random_get_seed_test #1", function() {
		
		var _arrayLength = 100;
			
		var _output, _input = 42;
		var seed = 42;
			
		//#1 random_get_seed ( real local )
		random_set_seed(_input);
		_output = random_get_seed();
		assert_equals(_output , _input, "random_get_seed ( real local ), failed to set/get the correct seed" );
		
	});

	addFact("random_get_seed_test #2", function() {
		
		var _arrayLength = 100;
		var seed = 42;
		var _output1, _output2;
			
		//#2 random_set_seed ( real local )
		// Note: Since seed can be internally cast as an unsigned int, the value returned by random_get_seed may not be the same as the original value.
		// However, the outcome of setting this value as the seed and using random should result in the same values returned.
			
		random_set_seed(-seed);
		seed = random_get_seed();
		
		for(var _i = 0; _i < _arrayLength; ++_i) _output1[_i] = random(99999);

		random_set_seed(seed);
		for(var _i = 0; _i < _arrayLength; ++_i) _output2[_i] = random(99999);

			
		assert_array_equals(_output1, _output2, "random_set_seed ( real local ), failed to produce the same output (using same seed)");

	});
	
	// RANDOM RANGE TESTS
	
	addFact("random_range_test #1", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{

			//tests for positive range (real const)
			
			//#1 random_range ( 10, 20 )
			_res = random_range(10, 20);
			assert_true( _res >= 10 && _res <= 20 , "random_range ( 10, 20 )");
			
		}
		
	});

	addFact("random_range_test #2", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{

			//tests for positive range (real const)
			
			//#2 random_range ( 20, 10 )
			_res = random_range(20, 10);
			assert_true( _res >= 10 && _res <= 20 , "random_range ( 20, 10 )");
			
		}
		
	});

	addFact("random_range_test #3", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{

			//tests for positive range (real const)
			
			//#3 random_range ( 10, 10 )
			_res = random_range(10, 10);
			assert_true( _res == 10 , "random_range ( 10, 10 )");
			
		}
		
	});

	addFact("random_range_test #4", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
				
			//tests for negative range (real const)
			
			//#4 random_range ( -20 , -10 )
			_res = random_range(-20, -10);
			assert_true( _res >= -20 && _res <= -10 , "random_range ( -20 , -10 )");
			
		}
		
	});

	addFact("random_range_test #5", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
				
			//tests for negative range (real const)
			
			//#5 random_range ( -10 , -20 )
			_res = random_range(-10, -20);
			assert_true( _res >= -20 && _res <= -10 , "random_range ( -10 , -20 )");
			
		}
		
	});

	addFact("random_range_test #6", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
				
			//tests for negative range (real const)
			
			//#6 random_range ( -10 , -10 )
			_res = random_range(-10, -10);
			assert_true( _res == -10 , "random_range ( -10 , -10 )");
			
		}
		
	});

	addFact("random_range_test #7", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive to negative range (real const)
			
			//#7 random_range ( -10 , 10 )
			_res = random_range(-10, 10);
			assert_true( _res >= -10 && _res <= 10 , "random_range ( -10 , 10 )");
			
		}
		
	});

	addFact("random_range_test #8", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive to negative range (real const)
			
			//#8 random_range ( 10 , -10 )
			_res = random_range(10, -10);
			assert_true( _res >= -10 && _res <= 10 , "random_range ( 10 , -10 )");
			
		}
		
	});

	addFact("random_range_test #9", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive int types
			
			//#9 random_range ( int local , int local )
			_res = random_range( _vInt1 , _vInt2 );
			assert_true( _res >= _vInt1 && _res <= _vInt2, "random_range ( int local , int local )" );
			
		}
		
	});

	addFact("random_range_test #10", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive int types
			
			//#10 random_range ( int const , int const )
			_res = random_range( 24 , 42 );
			assert_true( _res >= 24 && _res <= 42 , "random_range ( int const , int const )" );
			
		}
		
	});

	addFact("random_range_test #11", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive int types
			
			//#11 random_range ( int macro , int macro )
			_res = random_range( kInt_1_RandomRangeTest , kInt_2_RandomRangeTest );
			assert_true( _res >= kInt_1_RandomRangeTest && _res <= kInt_2_RandomRangeTest, "random_range ( int macro , int macro )" );
			
		}
		
	});

	addFact("random_range_test #12", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		// Global Vals
		global.gInt1 = _vInt1;
		global.gInt2 = _vInt2;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive int types
			
			//#12 random_range ( int global , int global )
			_res = random_range( global.gInt1 , global.gInt2 );
			assert_true( _res >= global.gInt1 && _res <= global.gInt2, "random_range ( int global , int global )" );
			
		}
		
	});

	addFact("random_range_test #13", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt1 = _vInt1;
		_objTest.oInt2 = _vInt2;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive int types
			
			//#13 random_range ( instance int , instance int )
			with( _objTest ) {
				_res = random_range ( oInt1, oInt2 );
			}
			assert_true( _res >= _objTest.oInt1 && _res <= _objTest.oInt2, "random_range ( instance int , instance int )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #14", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
			
			//tests for negative int types
			
			//#14 random_range ( int local , int local )
			_res = random_range(-_vInt1, -_vInt2);
			assert_true( _res >= -_vInt2 && _res <= -_vInt1 , "random_range ( int local , int local )" );
			
		}
		
	});

	addFact("random_range_test #15", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
			
			//tests for negative int types
			
			//#15 random_range ( int const , int const )
			_res = random_range(-24, -42);
			assert_true( _res >= -42 && _res <= -24 , "random_range ( int const , int const )" );
			
		}
		
	});

	addFact("random_range_test #16", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
			
			//tests for negative int types
			
			//#16 random_range ( int macro , int macro )
			_res = random_range(-kInt_1_RandomRangeTest, -kInt_2_RandomRangeTest);
			assert_true( _res >= -kInt_2_RandomRangeTest && _res <= -kInt_1_RandomRangeTest, "random_range ( int macro , int macro )" );
			
		}
		
	});

	addFact("random_range_test #17", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		// Global Vals
		global.gInt1 = _vInt1;
		global.gInt2 = _vInt2;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
			
			//tests for negative int types
			
			//#17 random_range ( int global , int global )
			_res = random_range( -global.gInt1, -global.gInt2);
			assert_true( _res >= -global.gInt2 && _res <= -global.gInt1, "random_range ( int global , int global )" );
			
		}
		
	});

	addFact("random_range_test #18", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt1 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		_buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x22345678);
		var _vInt2 = buffer_peek(_buff, 0, buffer_s32);
			
		// Clean up
		buffer_delete(_buff);
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt1 = _vInt1;
		_objTest.oInt2 = _vInt2;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
			
			//tests for negative int types
			
			//#18 random_range_range ( instance int , instance int )
			with( _objTest ) {
				_res = random_range ( -oInt1, -oInt2 );
			}
			assert_true( _res >= -_objTest.oInt2 && _res <= -_objTest.oInt1, "random_range ( instance int , instance int )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #19", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
			
		// Local Vals
		var _vInt64_1 = int64(5000);
		var _vInt64_2 = int64(10000);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
				
			//tests for positive int64 types
			
			//#19 random_range ( int64 local , int64 local )
			_res = random_range( _vInt64_1 , _vInt64_2 );
			assert_true( _res >= _vInt64_1 && _res <= _vInt64_2 , "random_range ( int64 local , int64 local )" );
			
		}
		
	});

	addFact("random_range_test #20", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
				
			//tests for positive int64 types
			
			//#20 random_range ( int64 const , int64 const )
			_res = random_range( 24 , 42 );
			assert_true( _res >= 24 && _res <= 42 , "random_range ( int64 const , int64 const )" );
			
		}
		
	});

	addFact("random_range_test #21", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
				
			//tests for positive int64 types
			
			//#21 random_range ( int64 macro , int64 macro )
			_res = random_range( kInt64_1_RandomRangeTest , kInt64_2_RandomRangeTest );
			assert_true( _res >= kInt64_1_RandomRangeTest && _res <= kInt64_2_RandomRangeTest, "random_range ( int64 macro , int64 macro )" );
			
		}
		
	});

	addFact("random_range_test #22", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gInt64_1 = int64(5000);
		global.gInt64_2 = int64(10000);
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
				
			//tests for positive int64 types
			
			//#22 random_range ( int64 global , int64 global )
			_res = random_range( global.gInt64_1 , global.gInt64_2 );
			assert_true( _res >= global.gInt64_1 && _res <= global.gInt64_2, "random_range ( int64 global , int64 global )" );
			
		}
		
	});

	addFact("random_range_test #23", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt64_1 = int64(5000);
		_objTest.oInt64_2 = int64(10000);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{			
				
			//tests for positive int64 types
			
			//#23 random_range ( instance int64 , instance int64 )
			with( _objTest ) {
				_res = random_range ( oInt64_1, oInt64_2 );
			}
			assert_true( _res >= _objTest.oInt64_1 && _res <= _objTest.oInt64_2, "random_range ( instance int64 , instance int64 )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #24", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		var _vInt64_1 = int64(5000);
		var _vInt64_2 = int64(10000);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for negative int64 types
			
			//#24 random_range ( int64 local , int64 local )
			_res = random_range(-_vInt64_1, -_vInt64_2);
			assert_true( _res >= -_vInt64_2 && _res <= -_vInt64_1 , "random_range ( int64 local , int64 local )" );
			
		}
		
	});

	addFact("random_range_test #25", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for negative int64 types
			
			//#25 random_range ( int64 const , int64 const )
			_res = random_range(-24, -42);
			assert_true( _res >= -42 && _res <= -24 , "random_range ( int64 const , int64 const )" );
			
		}
		
	});

	addFact("random_range_test #26", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for negative int64 types
			
			//#26 random_range ( int64 macro , int64 macro )
			_res = random_range(-kInt64_1_RandomRangeTest, -kInt64_2_RandomRangeTest);
			assert_true( _res >= -kInt64_2_RandomRangeTest && _res <= -kInt64_1_RandomRangeTest, "random_range ( int64 macro , int64 macro )" );
			
		}
		
	});

	addFact("random_range_test #27", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gInt64_1 = int64(5000);
		global.gInt64_2 = int64(10000);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for negative int64 types
			
			//#27 random_range ( int64 global , int64 global )
			_res = random_range( -global.gInt64_1, -global.gInt64_2);
			assert_true( _res >= -global.gInt64_2 && _res <= -global.gInt64_1, "random_range ( int64 global , int64 global )" );
			
		}
		
	});

	addFact("random_range_test #28", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt64_1 = int64(5000);
		_objTest.oInt64_2 = int64(10000);
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for negative int64 types
			
			//#28 random_range_range ( instance int64 , instance int64 )
			with( _objTest ) {
				_res = random_range ( -oInt64_1, -oInt64_2 );
			}
			assert_true( _res >= -_objTest.oInt64_2 && _res <= -_objTest.oInt64_1, "random_range ( instance int64 , instance int64 )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #29", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;

		var _vReal1 = 24.5;
		var _vReal2 = 42.5;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive real types
			
			//#29 random_range ( real local , real local )
			_res = random_range( _vReal1 , _vReal2 );
			assert_true( _res >= _vReal1 && _res <= _vReal2 , "random_range ( real local , real local )" );
			
		}
		
	});

	addFact("random_range_test #30", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive real types
			
			//#30 random_range ( real const , real const )
			_res = random_range( 24 , 42 );
			assert_true( _res >= 24 && _res <= 42 , "random_range ( real const , real const )" );
			
		}
		
	});

	addFact("random_range_test #31", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive real types
			
			//#31 random_range ( real macro , real macro )
			_res = random_range( kReal_1_RandomRangeTest , kReal_2_RandomRangeTest );
			assert_true( _res >= kReal_1_RandomRangeTest && _res <= kReal_2_RandomRangeTest, "random_range ( real macro , real macro )" );
			
		}
		
	});

	addFact("random_range_test #32", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gReal1 = 24.5;
		global.gReal2 = 42.5;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive real types
			
			//#32 random_range ( real global , real global )
			_res = random_range( global.gReal1 , global.gReal2 );
			assert_true( _res >= global.gReal1 && _res <= global.gReal2, "random_range ( real global , real global )" );
			
		}
		
	});

	addFact("random_range_test #33", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oReal1 = 24.5;
		_objTest.oReal2 = 42.5;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for positive real types
			
			//#33 random_range ( instance real , instance real )
			with( _objTest ) {
				_res = random_range ( oReal1, oReal2 );
			}
			assert_true( _res >= _objTest.oReal1 && _res <= _objTest.oReal2, "random_range ( instance real , instance real )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #34", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;

		var _vReal1 = 24.5;
		var _vReal2 = 42.5;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#34 random_range ( real local , real local )
			_res = random_range(-_vReal1, -_vReal2);
			assert_true( _res >= -_vReal2 && _res <= -_vReal1 , "random_range ( real local , real local )" );
			
		}
		
	});

	addFact("random_range_test #35", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#35 random_range ( real const , real const )
			_res = random_range(-24, -42);
			assert_true( _res >= -42 && _res <= -24 , "random_range ( real const , real const )" );
			
		}
		
	});

	addFact("random_range_test #36", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#36 random_range ( real macro , real macro )
			_res = random_range(-kReal_1_RandomRangeTest, -kReal_2_RandomRangeTest);
			assert_true( _res >= -kReal_2_RandomRangeTest && _res <= -kReal_1_RandomRangeTest, "random_range ( real macro , real macro )" );
			
		}
		
	});

	addFact("random_range_test #37", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gReal1 = 24.5;
		global.gReal2 = 42.5;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#37 random_range ( real global , real global )
			_res = random_range( -global.gReal1, -global.gReal2);
			assert_true( _res >= -global.gReal2 && _res <= -global.gReal1, "random_range ( real global , real global )" );
			
		}
		
	});

	addFact("random_range_test #38", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oReal1 = 24.5;
		_objTest.oReal2 = 42.5;
			
			
		var _res;
			
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#38 random_range_range ( instance real , instance real )
			with( _objTest ) {
				_res = random_range ( -oReal1, -oReal2 );
			}
			assert_true( _res >= -_objTest.oReal2 && _res <= -_objTest.oReal1, "random_range ( instance real , instance real )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});

	addFact("random_range_test #39", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		// tests for non-identical results (these could legitimitely fail but is unlikely to)
			
		// #39 random_range( int const , int const ) - non-identical test
		_iterations = 1000;
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = random_range(500, 99999);
			var _res2 = random_range(500, 99999);
				
			// count number of identical results
			if(_res1 == _res2)
			{
				_identicalCount++;
			}
		}
		assert_not_equals(_identicalCount, _iterations, "random_range( int const , int const ) - non-identical test");
		
	});

	addFact("random_range_test #40", function() {

		//random_range test
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
			
		// tests for non-identical results (these could legitimitely fail but is unlikely to)
			
		// #40 random_range( real const , real const ) - non-identical test
		_iterations = 1000;
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = random_range(1.0, 2.0);
			var _res2 = random_range(1.0, 2.0);
				
			// count number of identical results
			if(_res1 == _res2)
			{
				_identicalCount++;
			}
		}
		assert_not_equals(_identicalCount, _iterations, "random_range( real const , real const ) - non-identical test");
		
	});
	
	// RANDOM SET SEED TESTS
	
	addFact("random_set_seed_test #1", function() {

		var _arrayLength = 100;
			
		var _seed1 = 42, _seed2 = 84;
		var _output1, _output2, _output3;
			
		//#1 random_set_seed - random consistency test (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - random consistency test" );
		
	});

	addFact("random_set_seed_test #2", function() {

		var _arrayLength = 100;
			
		var _seed1 = 42, _seed2 = 84;
		var _output1, _output2, _output3;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}

		var _passed = false;
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - random consistency test");
		
	});

	addFact("random_set_seed_test #3", function() {

		var _arrayLength = 100;
			
		var _seed1 = -42, _seed2 = -84;
		var _output1, _output2, _output3;
			
		//#2 random_set_seed - random consistency test - negative seed values (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}

		assert_array_equals(_output1, _output3 , "random_set_seed - random consistency test (negative seed)" );
		
	});

	addFact("random_set_seed_test #4", function() {

		var _arrayLength = 100;
			
		var _seed1 = -42, _seed2 = -84;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - random consistency test (negative seed)");
		
	});

	addFact("random_set_seed_test #5", function() {

		var _arrayLength = 100;
			
		var _seed1 = 99, _seed2 = 305;
		var _output1, _output2, _output3;
			
		//#3 random_set_seed - irandom consistency test (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = irandom(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = irandom(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = irandom(99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - irandom consistency test" );
		
	});

	addFact("random_set_seed_test #6", function() {

		var _arrayLength = 100;
			
		var _seed1 = 99, _seed2 = 305;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - irandom consistency test");
		
	});

	addFact("random_set_seed_test #7", function() {

		var _arrayLength = 100;
			
		var _seed1 = -99, _seed2 = -305;
		var _output1, _output2, _output3;
			
		//#4 random_set_seed - irandom consistency test - negative seed values (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = irandom(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = irandom(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = irandom(99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - irandom consistency test (negative seed)" );
		
	});

	addFact("random_set_seed_test #8", function() {

		var _arrayLength = 100;
			
		var _seed1 = -99, _seed2 = -305;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - irandom consistency test (negative seed)");
		
	});

	addFact("random_set_seed_test #9", function() {

		var _arrayLength = 100;
			
		var _seed1 = 42, _seed2 = 84;
		var _output1, _output2, _output3;
			
		//#5 random_set_seed - random_range consistency test (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random_range(500, 99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random_range(500, 99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random_range(500, 99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - random_range consistency test" );
		
	});

	addFact("random_set_seed_test #10", function() {

		var _arrayLength = 100;
			
		var _seed1 = 42, _seed2 = 84;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - random_range consistency test");
		
	});

	addFact("random_set_seed_test #11", function() {

		var _arrayLength = 100;
			
		var _seed1 = -42, _seed2 = -84;
		var _output1, _output2, _output3;
			
		//#6 random_set_seed - random_range consistency test - negative seed values (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random_range(500, 99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random_range(500, 99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random_range(500, 99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - random_range consistency test (negative seed)" );
		
	});

	addFact("random_set_seed_test #12", function() {

		var _arrayLength = 100;
			
		var _seed1 = -42, _seed2 = -84;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - random_range consistency test (negative seed)");
		
	});

	addFact("random_set_seed_test #13", function() {

		var _arrayLength = 100;
			
		var _seed1 = 99, _seed2 = 305;
		var _output1, _output2, _output3;
			
		//#7 random_set_seed - irandom_range consistency test (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = irandom_range(500, 99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = irandom_range(500, 99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = irandom_range(500, 99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - irandom_range consistency test" );
		
	});

	addFact("random_set_seed_test #14", function() {

		var _arrayLength = 100;
			
		var _seed1 = 99, _seed2 = 305;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - irandom_range consistency test");
		
	});

	addFact("random_set_seed_test #15", function() {

		var _arrayLength = 100;
			
		var _seed1 = -99, _seed2 = -305;
		var _output1, _output2, _output3;
			
		//#8 random_set_seed - irandom_range consistency test - negative seed values (this could legitimitely fail but is unlikely to)
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = irandom_range(500, 99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = irandom_range(500, 99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = irandom_range(500, 99999);
		}
			
		assert_array_equals(_output1, _output3 , "random_set_seed - irandom_range consistency test (negative seed)" );
		
	});

	addFact("random_set_seed_test #16", function() {

		var _arrayLength = 100;
			
		var _seed1 = 99, _seed2 = 305;
		var _output1, _output2, _output3;
			
		var _passed = false;
		
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output1[_i] = random(99999);
		}
			
		random_set_seed(_seed2);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output2[_i] = random(99999);
		}
			
		random_set_seed(_seed1);
		for(var _i = 0; _i < _arrayLength; ++_i)
		{
			_output3[_i] = random(99999);
		}
		
		for(var _i = 0; _i < _arrayLength && !_passed; ++_i)
		{
			if (_output1[_i] != _output2[_i]) _passed = true;
		}
		assert_true(_passed, "random_set_seed - irandom_range consistency test (negative seed)");
				
	});
	
	// RANDOM TESTS
	
	addFact("random_test #1", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
	
			//tests for positive int types
			
			//#1 random ( int local )
			_res = random(_vInt);
			assert_true( _res >= 0 && _res <= _vInt , "random ( int local )" );
			
		}
		
	});
	
	addFact("random_test #2", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
	
			//tests for positive int types
			
			//#2 random ( int const )
			_res = random(42);
			assert_true( _res >= 0 && _res <= 42 , "random ( int const )" );
			
		}
		
	});
	
	addFact("random_test #3", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
	
			//tests for positive int types
			
			//#3 random ( int macro )
			_res = random( kInt_RandomTest );
			assert_true( _res >= 0 && _res <= kInt_RandomTest, "random ( int macro )" );
			
		}
		
	});
	
	addFact("random_test #4", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
			
		// Global Vals
		global.gInt = _vInt;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
	
			//tests for positive int types
			
			//#4 random ( int global )
			_res = random( global.gInt );
			assert_true( _res >= 0 && _res <= global.gInt, "random ( int global )" );
			
		}
		
	});
	
	addFact("random_test #5", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
		buffer_delete(_buff);
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt = _vInt;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
	
			//tests for positive int types
			
			//#5 random ( instance int )
			with( _objTest ) {
				_res = random ( oInt );
			}
			assert_true( _res >= 0 && _res <= _objTest.oInt, "random ( instance int )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});
	
	addFact("random_test #6", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
		buffer_delete(_buff);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int types
			
			//#6 random ( int local )
			_res = random(-_vInt);
			assert_true( _res >= -_vInt && _res <= 0 , "random ( int local )" );
			
		}
		
	});
	
	addFact("random_test #7", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int types
			
			//#7 random ( int const )
			_res = random(-42);
			assert_true( _res >= -42 && _res <= 0 , "random ( int const )" );
			
		}
		
	});
	
	addFact("random_test #8", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int types
			
			//#8 random ( int macro )
			_res = random(-kInt_RandomTest);
			assert_true( _res >= -kInt_RandomTest && _res <= 0, "random ( int macro )" );
			
		}
		
	});
	
	addFact("random_test #9", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
		buffer_delete(_buff);
			
		// Global Vals
		global.gInt = _vInt;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int types
			
			//#9 random ( int global )
			_res = random( -global.gInt );
			assert_true( _res >= -global.gInt && _res <= 0, "random ( int global )" );
			
		}
		
	});
	
	addFact("random_test #10", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		// The only way to generate an int32 is to read it from a buffer
		var _buff = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buff, buffer_s32, 0x12345678);
		var _vInt = buffer_peek(_buff, 0, buffer_s32);
		buffer_delete(_buff);
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt = _vInt;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int types
			
			//#10 random ( instance int )
			with( _objTest ) {
				_res = random ( -oInt );
			}
			assert_true( _res >= -_objTest.oInt && _res <= 0, "random ( instance int )" );
			
		}			
		
		// Clean up
		instance_destroy(_objTest);
		
	});
	
	addFact("random_test #11", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		var _vInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for positive int64 types
			
			//#11 random ( int64 local )
			_res = random(_vInt64);
			assert_true( _res >= 0 && _res <= _vInt64 , "random ( int64 local )" );
			
		}			
		
	});
	
	addFact("random_test #12", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for positive int64 types
			
			//#12 random ( int64 const )
			_res = random(int64(5000));
			assert_true( _res >= 0 && _res <= int64(5000) , "random ( int64 const )" );
			
		}			
		
	});
	
	addFact("random_test #13", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for positive int64 types
			
			//#13 random ( int64 macro )
			_res = random( kInt64_RandomTest );
			assert_true( _res >= 0 && _res <= kInt64_RandomTest, "random ( int64 macro )" );
			
		}			
		
	});
	
	addFact("random_test #14", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for positive int64 types
			
			//#14 random ( int64 global )
			_res = random( global.gInt64 );
			assert_true( _res >= 0 && _res <= global.gInt64, "random ( int64 global )" );
			
		}			
		
	});
	
	addFact("random_test #15", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			
			//tests for positive int64 types
			
			//#15 random ( instance int64 )
			with( _objTest ) {
				_res = random ( oInt64 );
			}
			assert_true( _res >= 0 && _res <= _objTest.oInt64, "random ( instance int64 )" );
			
		}	
			
		// Clean up
		instance_destroy(_objTest);		
		
	});
	
	addFact("random_test #16", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		var _vInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int64 types
			
			//#16 random ( int64 local )
			_res = random(-_vInt64);
			assert_true( _res >= -_vInt64 && _res <= 0 , "random ( int64 local )" );
			
		}	
		
	});
	
	addFact("random_test #17", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int64 types
			
			//#17 random ( int64 const )
			_res = random(0xdeadc0deabcdefed);
			assert_true( _res >= 0xdeadc0deabcdefed && _res <= 0 , "random ( int64 const )" );
			
		}	
		
	});
	
	addFact("random_test #18", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int64 types
			
			//#18 random ( int64 macro )
			_res = random( -kInt64_RandomTest );
			assert_true( _res >= -kInt64_RandomTest && _res <= 0, "random ( int64 macro )" );
			
		}	
		
	});
	
	addFact("random_test #19", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int64 types
			
			//#19 random ( int64 global )
			_res = random( -global.gInt64 );
			assert_true( _res >= -global.gInt64 && _res <= 0, "random ( int64 global )" );
			
		}	
		
	});
	
	addFact("random_test #20", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
		
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oInt64 = int64(5000);
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative int64 types
			
			//#20 random ( instance int64 )
			with( _objTest ) {
				_res = random ( -oInt64 );
			}
			assert_true( _res >= -_objTest.oInt64 && _res <= 0, "random ( instance int64 )" );
			
		}
			
		// Clean up
		instance_destroy(_objTest);	
		
	});
	
	addFact("random_test #21", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		var _vReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	

			//tests for positive real types

			//#21 random ( real local )
			_res = random(_vReal);
			assert_true( _res >= 0 && _res <= _vReal , "random ( real local )" );
			
		}
		
	});
	
	addFact("random_test #22", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	

			//tests for positive real types
			
			//#22 random ( real const )
			_res = random(42.5);
			assert_true( _res >= 0 && _res <= 42.5 , "random ( real const )" );
			
		}
		
	});
	
	addFact("random_test #23", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	

			//tests for positive real types

			//#23 random ( real macro ) // test includes value because if epsilon amount
			_res = random( kReal_RandomTest );
			assert_true( _res >= 0 && _res <= kReal_RandomTest, "random ( real macro )" );
			
		}
		
	});
	
	addFact("random_test #24", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	

			//tests for positive real types

			//#24 random ( real global )
			_res = random( global.gReal );
			assert_true( _res >= 0 && _res <= global.gReal, "random ( real global )" );
			
		}
		
	});
	
	addFact("random_test #25", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	

			//tests for positive real types
			
			//#25 random ( instance real )
			with( _objTest ) {
				_res = random ( oReal );
			}
			assert_true( _res >= 0 && _res <= _objTest.oReal, "random ( instance real )" );
			
		}
		
		// Clean up
		instance_destroy(_objTest);
		
	});
	
	addFact("random_test #26", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Local Vals
		var _vReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#26 random ( real local )
			_res = random(-_vReal);
			assert_true( _res >= -_vReal && _res <= 0 , "random ( real local )" );
			
		}
		
	});
	
	addFact("random_test #27", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#27 random ( real const )
			_res = random(-42.5);
			assert_true( _res >= -42.5 && _res <= 0 , "random ( real const )" );
			
		}
		
	});
	
	addFact("random_test #28", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#28 random ( real macro ) // test includes value because if epsilon amount
			_res = random( -kReal_RandomTest );
			assert_true( _res >= -kReal_RandomTest && _res <= 0, "random ( real macro )" );
			
		}
		
	});
	
	addFact("random_test #29", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Global Vals
		global.gReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#29 random ( real global ) // test includes value because if epsilon amount
			_res = random( -global.gReal );
			assert_true( _res >= -global.gReal && _res <= 0, "random ( real global )" );
			
		}
		
	});
	
	addFact("random_test #30", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// Object Vals
		var _objTest = instance_create_depth(0,0,0,oTest);
		_objTest.oReal = 42.5;
			
		var _res;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{	
			
			//tests for negative real types
			
			//#30 random ( instance real ) // test includes value because if epsilon amount
			with( _objTest ) {
				_res = random ( -oReal );
			}
			assert_true( _res >= -_objTest.oReal && _res <= 0, "random ( instance real )" );
		}
			
		// Clean up
		instance_destroy(_objTest);
		
	});
	
	addFact("random_test #31", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// tests for non-identical results (these could legitimitely fail but is unlikely to)
			
		// #31 random( int const ) - non-identical test
		_iterations = 1000;
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = random(99999);
			var _res2 = random(99999);
				
			// count number of identical results
			if(_res1 == _res2)
			{
				_identicalCount++;
			}
		}
		assert_not_equals(_identicalCount, _iterations, "random( int const ) - non-identical test");
		
	});
	
	addFact("random_test #32", function() {

		//random tes
			
		// Iterations - Since this test runs on a randomised function, a larger number of _iterations can be set to better test the function.
		var _iterations = 1000;
			
		// tests for non-identical results (these could legitimitely fail but is unlikely to)
			
		// #32 random( real const ) - non-identical test
		_iterations = 1000;
		var _identicalCount = 0;
		for(var _iter = 0; _iter < _iterations; ++_iter)
		{
			var _res1 = random(1.0);
			var _res2 = random(1.0);
				
			// count number of identical results
			if(_res1 == _res2)
			{
				_identicalCount++;
			}
		}
		assert_not_equals(_identicalCount, _iterations, "random( real const ) - non-identical test");
		
	});
		
}