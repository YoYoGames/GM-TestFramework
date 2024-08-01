
function BasicArrayTestSuite() : TestSuite() constructor {

	// ARRAY COPYING TESTS
	
	addFact("array_copy test #1", function() {
		
		//#1 array_copy, copy fully into start of empty array
		var _largeArrayDimensions = 32000;
		var _array1dToCopyLarge = array_create(_largeArrayDimensions, "hello");
		var _destArray = [];
		
		array_copy(_destArray, 0, _array1dToCopyLarge, 0, array_length(_array1dToCopyLarge));
		assert_array_equals(_destArray, _array1dToCopyLarge, "Copying fully into start of empty array");
		
	});
	
	addFact("array_copy test #2", function() { 
		
		//#2 array_copy, fully into out of range index of empty array
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [];
		var _expected = [0, 0, 0, 0, "one", "two", "three", "four", "five"];
		
		array_copy(_destArray, 4, _array1dToCopySmall, 0, array_length(_array1dToCopySmall));
		assert_array_equals(_destArray, _expected, "Copying fully past the end of empty array");
		
	});
	
	addFact("array_copy test #3", function() {
		
		//#3 array_copy, partially (from start) into out of range index of empty array
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [];
		var _expected = [0, 0, 0, 0, "one", "two", "three", "four"];
		array_copy(_destArray, 4, _array1dToCopySmall, 0, 4);
		assert_array_equals(_destArray, _expected, "Copy partially (from start) past the end of empty array");
		
	});
	
	addFact("array_copy test #4", function() {
		
		//#4 array_copy, copy partially (from middle) into out of range index of empty array"
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [];
		var _expected = [0, 0, 0, 0, "three"];
		array_copy(_destArray, 4, _array1dToCopySmall, 2, 1);
		assert_array_equals(_destArray, _expected, "Copy partially (from middle) past the end of empty array");
		
	});
	
	addFact("array_copy test #5", function() {
		
		//#5 array_copy, copy partially (from middle) into array with existing elements
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, 98, 97, "three", "four"];
		array_copy(_destArray, 3, _array1dToCopySmall, 2, 2);
		assert_array_equals(_destArray, _expected, "copy partially (from middle) into array with existing elements");
		
	});
	
	addFact("array_copy test #6", function() {
			
		//#6 array_copy, copy partially (from middle) past end of source array
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, 98, 97, "three", "four", "five"];
		array_copy(_destArray, 3, _array1dToCopySmall, 2, 10);
		assert_array_equals(_destArray, _expected, "copy partially (from middle) past the end of the source array");
		
	});
	
	addFact("array_copy test #7", function() {
			
		//#7 array_copy, copy partially (from middle) into the middle of the target array
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, "three", "four", "five", 95];
		array_copy(_destArray, 1, _array1dToCopySmall, 2, array_length(_array1dToCopySmall));
		assert_array_equals(_destArray, _expected, "copy partially (from middle) into the middle of the target array");
		
	});
	
	addFact("array_copy test #8", function() {
			
		//#8 array_copy, with negative source index
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, "four", "five", 96, 95];
		array_copy(_destArray, 1, _array1dToCopySmall, -2, array_length(_array1dToCopySmall));
		assert_array_equals(_destArray, _expected, "copy with negative source index");
		
	});
	
	addFact("array_copy test #9", function() {
			
		//#9 array_copy, with negative length
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, "three", "two", "one", 95];
		array_copy(_destArray, 1, _array1dToCopySmall, 2, -array_length(_array1dToCopySmall));
		assert_array_equals(_destArray, _expected, "copy with negative length");
		
	});
	
	addFact("array_copy test #10", function() {
			
		//#10 array_copy, copy partially (from middle) past the end of array with existing elements
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"];
		var _destArray = [99, 98, 97, 96, 95];
		var _expected = [99, 98, 97, 96, 95, 0, 0, 0, 0, 0, "three", "four"];
		array_copy(_destArray, 10, _array1dToCopySmall, 2, 2);
		assert_array_equals(_destArray, _expected, "copy partially (from middle) past the end of array with existing elements");
		
	});
	
	addFact("array_copy test #11", function() {
			
		//#11 array_copy, copy empty array into target array
		var _srcArray = [];
		var _destArray = ["hello"];
		var _expected = ["hello"];
		array_copy(_destArray, 0, _srcArray, 0, 100);
		var _result = array_equals(_destArray, _expected);
		assert_array_equals(_destArray, _expected, "copy empty source array into target array");
		
	});
	
	addFact("array_copy test #12", function() {

		//#12 array_copy ( array 1d local , int const , array 1d local , int const , int const )
		var _srcArray = ["world"];
		var _destArray = ["hello"];
		var _expected = ["hello"];
		array_copy(_destArray, 0, _srcArray, 0, 0);
		assert_array_equals(_destArray, _expected, "copy zero elements from source array into target array");
		
	});
	
	addFact("array_copy test #13", function() {

		//#13 array_copy, using new negative offset and out-of-bounds length
		var array = [1, 2, 3, 4];
		var output = ["a", "b", "c"];
		array_copy(output, -1, array, -2, infinity);
		assert_array_equals(output, ["a", "b", 3, 4], "copy using new negative offset and out-of-bounds length");
		
	});
	
	addFact("array_copy test #14", function() {

		//#14 array_copy, using and out-of-bounds destination index
		var array = [1, 2, 3, 4];
		var output = ["a", "b", "c"];
		array_copy(output, 8, array, -2, infinity);
		assert_array_equals(output, ["a", "b", "c", 0, 0, 0, 0, 0, 3, 4], "copy using and out-of-bounds destination index");
		
	});

	addFact("array_copy test #15", function() {

		//#15 array_copy, using negative out-of-bounds destination index
		var array = [1, 2, 3, 4];
		var output = ["a", "b", "c"];
		array_copy(output, -infinity, array, -2, infinity);
		assert_array_equals(output, [3, 4, "c"], "copy using negative out-of-bounds destination index");

	});
	
	// ARRAY CREATION TESTS
	
	addFact("array_create test #1", function() {
		
		//#1 array_create ( 0 )
		var _result = array_create(0);
		assert_not_undefined(_result, "array_create ( 0 ), returning undefined") 
		
	});
	
	addFact("array_create test #2", function() {
		
		//#2 array_create ( int local )
		var _vInt32 = int32(0x00000100);
		var _result = array_create(_vInt32);
		assert_array_length(_result, _vInt32, "array_create ( int32:local ), not returning the correct number of elements");
		
	});
	
	addFact("array_create test #3", function() {
		
		//#3 array_create ( int64 local )
		var _vInt64 = int64(567);
		var _result = array_create(_vInt64);
		assert_array_length(_result, _vInt64, "array_create ( int64:local ), not returning the correct number of elements");
		
	});
	
	addFact("array_create test #4", function() {
		
		//#4 array_create ( real local )
		var _vReal = 42.5;
		var _result = array_create(_vReal);
		assert_array_length(_result, floor(_vReal), "array_create ( real:local ), not returning the correct number of elements");
		
	});
	
	addFact("array_create test #5", function() {

		//#5 array_create ( int macro, int32 local ) NOTE: int32 type doesn't exist on HTML5
		var _vInt32 = int32(0x00000100);
		var _arraySize = 100;
		var _failed = false;
		if (platform_not_browser()) {
			var _result = array_create(_arraySize, _vInt32);
			for(var _i = 0; _i < _arraySize; ++_i)
			{
				_failed |= !assert_equals(_result[_i], _vInt32, "array_create ( int:local, int32:local ), reading not returning the correct value");
				_failed |= !assert_typeof(_result[_i], "int32", "array_create ( int:local, int32:local ), reading not returning the correct type");
				if (_failed) break;
			}
		}
		
	});
	
	addFact("array_create test #6", function() {

		//#6 array_create ( int macro, int64 local )
		var _vInt64 = int64(567);
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _vInt64);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vInt64, "array_create ( int:local, int64:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "int64", "array_create ( int:local, int64:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #7", function() {
			
		//#7 array_create ( int macro, real local )
		var _vReal = 42.5;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _vReal);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vReal, "array_create ( int:local, real:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "number", "array_create ( int:local, real:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #8", function() {
			
		//#8 array_create ( int macro, string local )
		var _vString = "hello";
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _vString);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vString, "array_create ( int:local, string:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "string", "array_create ( int:local, string:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #9", function() {
			
		//#9 array_create ( int macro, ptr local )
		var _vPtr = ptr(application_surface);
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _vPtr);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vPtr, "array_create ( int:local, ptr:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "ptr", "array_create ( int:local, ptr:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #10", function() {
			
		//#10 array_create ( int macro, bool local )
		var _vBool = true;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _vBool);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vBool, "array_create ( int:local, bool:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "bool", "array_create ( int:local, bool:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #11", function() {
			
		//#11 array_create ( int macro, array1d local )
		var _array1D = array_create(10, 1);
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _array1D);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_array_equals(_result[_i], _array1D, "array_create ( int:local, array:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "array", "array_create ( int:local, array:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #12", function() {
		
		/// @DEPRECATED
		//#12 array_create ( int macro, array2d local )
		var _array2D;
		_array2D[1,2] = 2;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _array2D);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			var _arraysEqual = array_equals(_result[_i], _array2D);
			_failed |= !assert_true(_arraysEqual, "array_create ( int macro, array2d local )");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #13", function() {
		
		//#13 array_create ( int macro, infinity )
		var _infinity = infinity;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _infinity);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _infinity, "array_create ( int:local, infinity:local ), reading not returning the correct value");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #14", function() {

		//#14 array_create ( int macro, NaN )
		var _nan = NaN;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _nan);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_nan(_result[_i], "array_create ( int:local, NaN:local ), reading not returning the correct value");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #15", function() {
			
		//#15 array_create ( int macro, undefined )
		var _undefined = undefined;
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, _undefined);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_undefined(_result[_i], "array_create ( int:local, undefined:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "undefined", "array_create ( int:local, undefined:local ), reading not returning the correct type");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #16", function() {
		
		//#16 array_create ( int macro, enum local )
		var _arraySize = 100;
		var _failed = false;
		var _result = array_create(_arraySize, RainbowColors.Red);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], RainbowColors.Red, "array_create ( int:local, enum ), reading not returning the correct value");
			if (_failed) break;
		}
		
	});
	
	addFact("array_create test #17", function() {
						
		//#17 array_create ( int64 const )
		var _vInt64 = int64(0x7fffffff00000100);
		var _vInt32 = _vInt64 & 0xffffffff;
			
		var _result = array_create(_vInt64);
		assert_array_length(_result, _vInt32, "array_create ( int64:local ), size didn't cap to max int32 (0xffffffff)");
		
	});
	
	addFact("array_create test #18", function() {
			
		//#18 array_create ( int const )
		var _result = array_create(-1);
		assert_equals(array_length(_result), 0, "array_create ( -1 ), didn't create a zero (0) size array");
		
	});

	// ARRAY DELETION TESTS
	
	addFact("array_delete test #1", function() {
	
		//#1 array_delete, array size after deletion doesn't match
		var _array = [1, 2, 3, 4, 5];
		var _deleteIndex = 0;
		var _amountToDelete = 2;
		var _finalLength = array_length(_array) - _amountToDelete;
			
		array_delete(_array, _deleteIndex, _amountToDelete);
		assert_array_length(_array, _finalLength, "array size after deletion should match expected value");
		
	});
	
	addFact("array_delete test #2", function() {
	
		//#2 array_delete, from within array bounds
		var _array = [1, 2, 3];
		var _deleteIndex = 1;
		var _amountToDelete = 2;
		array_delete(_array, _deleteIndex, _amountToDelete);
			
		var _expected = [1];
		assert_array_equals(_array, _expected, "delete from within the array bounds");
		
	});
	
	addFact("array_delete test #3", function() {
			
		//#3 array_delete, past the end of the array bounds
		var _array = [1, 2, 3, 4, 5];
		var _deleteIndex = 2;
		var _amountToDelete = 100;
			
		array_delete(_array, _deleteIndex, _amountToDelete);
			
		var _expected = [1, 2];
		assert_array_equals(_array, _expected, "delete past the end of the array bounds");
		
	});
	
	addFact("array_delete test #4", function() {
			
		//#4 array_delete, with negative delete amount
		var _array = [1, 2, 3, 4, 5];
		var _deleteIndex = 2;
		var _amountToDelete = -2;
		array_delete(_array, _deleteIndex, _amountToDelete);
		
		var _expected = [1, 4, 5];
		assert_array_equals(_array, _expected, "delete with negative delete amount (should delete in backwards direction)");
		
	});
	
	addFact("array_delete test #5", function() {
		
		//#5 array_delete, with negative index and positive length (should delete in backwards direction)
		var _array = [1, 2, 3, 4];
		array_delete(_array, -1, 10);
		
		var _expected = [1, 2, 3];
		assert_array_equals(_array, _expected, "delete with negative index and positive length (should delete in backwards direction)");
		
	});
	
	addFact("array_delete test #6", function() {

		//#6 array_delete, with negative index and negative length (should delete in backwards direction)
		var _array = [1, 2, 3, 4];
		array_delete(_array, -2, -2);
		
		var _expected = [1, 4]
		assert_array_equals(_array, _expected, "delete with negative index and negative length (should delete in backwards direction)");
		
	});

	addFact("array_delete test #7", function() {
		
		//#7 array_delete, with negative index and infinite out-of-bounds length (should delete in backwards direction)
		var _array = [1, 2, 3, 4];
		array_delete(_array, -2, infinity);
		
		var _expected = [1, 2];
		assert_array_equals(_array, _expected, "delete with negative index and infinite out-of-bounds length (should delete in backwards direction)");
		
	});

	// ARRAY EQUALS TESTS
	
	addFact("array_equals test #1", function() {

		var _array1D1 = [];
		var _array1D2 = [];
			
		//#1 array_equals, [] and [] must equal
		var _result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "array_equals, [] and [] must equal");
		
	});
	
	addFact("array_equals test #2", function() {

		var _array1D1 = [];
		_array1D1[0] = 1;
		var _array1D2 = [];
			
		//#2 array_equals, [] and [1] must not equal
		var _result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "array_equals, [] and [1] must not equal");
		
	});
	
	addFact("array_equals test #3", function() {

		var _array1D1 = [];
		_array1D1[0] = 1;
		var _array1D2 = [];
		_array1D2[0] = 1;
			
		//#3 array_equals, [1] and [1] must equal"
		var _result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "array_equals, [1] and [1] must equal");
		
	});
	
	addFact("array_equals test #4", function() {

		var _array1D1 = [];
		_array1D1[0] = 1;
		var _array1D2 = [];
		_array1D2[0] = 999;
			
		//#4 array_equals, [1] and [1 ... ... ... 999] must not equal
		var _result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "array_equals, [1] and [1 ... ... ... 999] must not equal")
		
	});
	
	addFact("array_equals test #5", function() {
		
		var _array1D1 = [];
		var _array1D2 = [];
		var _arraySize = 129;
		
		//#5 array_equals, [0, 1, 2, ... 128] and [0, 1, 2, ... 128] must equal
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_array1D1[_i] = _i;
			_array1D2[_i] = _i;
		}
		var _result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "array_equals, [0, 1, 2, ... 128] and [0, 1, 2, ... 128] must equal");
		
	});
	
	addFact("array_equals test #6", function() {
		
		// 2d Array tests
		var _array2D1 = [];
		var _array2D2 = [];
			
		//#6 array_equals, two empty 2d arrays must equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "array_equals, two empty 2d arrays must equal");
		
	});
	
	addFact("array_equals test #7", function() {
		
		// 2d Array tests
		var _array2D1 = [];
		_array2D1[0, 0] = 1;
		var _array2D2 = [];
			
		//#7 array_equals, two different 2d arrays must not equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "array_equals, two different 2d arrays must not equal");
		
	});
	
	addFact("array_equals test #8", function() {
		
		// 2d Array tests
		var _array2D1 = [];
		_array2D1[0, 0] = 1;
		var _array2D2 = [];
		_array2D2[0, 0] = 1;
			
		//#8 array_equals, two equal 2d arrays must equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "array_equals, two equal 2d arrays must equal");
		
	});
	
	addFact("array_equals test #9", function() {
		
		// 2d Array tests
		var _array2D1 = [];
		_array2D1[0, 0] = 1;
		var _array2D2 = [];
		_array2D2[0, 0] = 999;
			
		//#9 array_equals, two different 2d arrays must not equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "array_equals, two different 2d arrays must not equal");
		
	});
	
	addFact("array_equals test #10", function() {
			
		//#10 array_equals, two equally filled 2d arrays must equal
		var _array2D1 = [];
		var _array2D2 = [];
		var _arraySize = 129;
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			for(var _j = 0; _j < _arraySize; ++_j)
			{
				_array2D1[_i, _j] = _i + (_i*_j);
				_array2D2[_i, _j] = _i + (_i*_j);
			}
		}
		var _result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "array_equals, two equally filled 2d arrays must equal");
		
	});
	
	addFact("array_equals test #11", function() {
			
		var _array2D1 = [];
		_array2D1[5, 0] = 1;
		var _array2D2 = [];
			
		//#11 array_equals, two different 2d arrays (random line) must not equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "array_equals, two different 2d arrays must not equal");
		
	});
	
	addFact("array_equals test #12", function() {
			
		var _array2D1 = [];
		_array2D1[5, 0] = 1;
		var _array2D2 = [];
		_array2D2[5, 0] = 1;
			
			
		//#12 array_equals, two equal 2d arrays must equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "array_equals, two equal 2d arrays must equal");
		
	});
	
	addFact("array_equals test #13", function() {
			
		var _array2D1 = [];
		_array2D1[5, 0] = 1;
		var _array2D2 = [];
		_array2D2[5, 0] = 999;
			
		//#13 array_equals, two different 2d arrays must not equal
		var _result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "array_equals, two different 2d arrays must not equal");
		
	});

	addFact("array_equals test #14", function() {
			
		//#14 array_equals ( [NaN] , [NaN] ), arrays must not equal (NaN != NaN)
		var _array1D1 = [NaN];
		var _array1D2 = [NaN];
		var _result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "array_equals ( [NaN] , [NaN] ), arrays must not equal (NaN != NaN)");
		
	});
	
	addFact("array_equals test #15", function() {
			
		//#15 array_equals ( [undefined] , [undefined] ), arrays must equal
		var _array1D1 = [undefined];
		var _array1D2 = [undefined];
		var _result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "array_equals ( [undefined] , [undefined] ), arrays must equal");
		
	});
	
	addFact("array_equals test #16", function() {
			
		//#16 array_equals ( [infinity] , [infinity] ), arrays must equal
		var _array1D1 = [infinity];
		var _array1D2 = [infinity];
		var _result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "array_equals ( [infinity] , [infinity] ), arrays must equal");
		
	});
	
	// ARRAY LENGTH TESTS
	
	addFact("array_length test #1", function() {
			
		//#1 array_length, empty array must be size zero (1)
		var _array = [];
		var _result = array_length(_array);
		assert_equals(_result, 0, "empty array must be length zero (0)");
		
	});
	
	addFact("array_length test #2", function() {

		var _array = [];
		_array[0] = 42;
			
		//#2 array_length, setting index 0 must grow array to be length one (1)
		var _result = array_length(_array);
		assert_equals(_result, 1, "setting index 0 must grow empty array to be length one (1)");
		
	});
	
	addFact("array_length test #3", function() {
			
		var _array = [];			
		_array[10] = 99;
			
		//#3 array_length, setting index 10 must grow array to be length eleven (11)
		var _result = array_length(_array);
		assert_equals(_result, 11, "setting index 10 must grow array to be length eleven (11)");
		
	});
	
	addFact("array_length test #4", function() {
			
		var _array = [];			
		_array[10] = 99;				
		_array[8] = 123;
			
		//#4 array_length, setting index lower than length-1 shouldn't resize the array
		var _result = array_length(_array);
		assert_equals(_result, 11, "setting index lower than length-1 shouldn't resize the array");
		
	});
	
	addFact("array_length test #5", function() {
			
		var _array = [];			
		_array[10] = 99;
		
		//#5 array_length, copy from last array should keep the same size
		var _arrayRefCopy = _array;
		var _result = array_length(_arrayRefCopy);
		assert_equals(_result, 11, "copy from last array should keep the same size");
		
	});
	
	addFact("array_length test #6", function() {
		
		var _arraySize = 17;
		var _array2D1 = [];
		for(var _i = 0; _i < _arraySize; ++_i)
		{	
			for(var _j = 0; _j < _arraySize - 3; ++_j)
			{
				_array2D1[_i, _j] = _i + (_i*_j);
			}
		}
			
		//#6 array_length, the 1st dimension of a pre-filled 2d array
		var _result = array_length(_array2D1);
		assert_equals(_result, _arraySize, "the 1st dimension of a pre-filled 2d array");
		
	});
	
	addFact("array_length test #7", function() {
		
		var _arraySize = 17;
		var _array2D1 = [];
		for(var _i = 0; _i < _arraySize; ++_i)
		{	
			for(var _j = 0; _j < _arraySize - 3; ++_j)
			{
				_array2D1[_i, _j] = _i + (_i*_j);
			}
		}

			
		//#7 array_length, the 2nd dimension of a pre-filled 2d array
		var _result = array_length(_array2D1[4]);
		assert_equals(_result, _arraySize - 3, "the 2nd dimension of a pre-filled 2d array");
		
	});

	addFact("array_length test #8", function() {
			
		//#8 array_length( not array ), should return 0
		var _tests = [ 22.5, int32(10), int64(20), "hello world", undefined, infinity, NaN, ptr(application_surface) ];
		for (var _i = array_length(_tests) - 1; _i >= 0; _i--) {
			var _result = array_length(_tests[_i]);
			assert_equals(_result, 0, "array_length( not array ), should return 0");
		}

	});
	
	// ARRAY POP TESTS
	
	addFact("array_pop test #1", function() {
			
		//#1 array_pop, must remove and return the last value of the array
		var _array = [12, "string"];
		var _lastElement = _array[array_length(_array) - 1];
			
		var _result = array_pop(_array);
		assert_equals(_result, _lastElement, "array_pop, must remove and return the last value of the array");

	});
	
	addFact("array_pop test #2", function() {
			
		//#2 array_pop, must resize (shrink) the array
		var _array = [12, "string"];
		var _initialLength = array_length(_array);
		array_pop(_array);
		var _finalLength = array_length(_array);
		assert_not_equals(_initialLength, _finalLength, "array_pop, must resize (shrink) the array");

	});
	
	addFact("array_pop test #3", function() {
			
		//#3 array_pop, on empty array must return undefined
		var _array = [];
		var _result = array_pop(_array);
		assert_undefined(_result, "array_pop, on empty array must return undefined");

	});
	
	// ARRAY PUSH TESTS
	
	addFact("array_push test #1", function() {

		var _idx, _dest = [];
		var _vInt = int32(0x00000100);

		//#1 array_push ( array 1d local, int local )
		array_push(_dest, _vInt);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vInt, "array_push ( array:local, int32:local )");

	});
	
	addFact("array_push test #2", function() {

		var _idx, _dest = [];
		var _vInt64 = int64(0xff12345678);
		
		//#2 array_push ( array 1d local, int64 local )
		array_push(_dest, _vInt64);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vInt64, "array_push ( array:local, int64:local )");

	});
	
	addFact("array_push test #3", function() {

		var _idx, _dest = [];
		var _vReal = 42.5;
			
		//#3 array_push ( array 1d local, real local )
		array_push(_dest, _vReal);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vReal, "array_push ( array:local, real:local )");

	});
	
	addFact("array_push test #4", function() {

		var _idx, _dest = [];
		var _vString = "hello";
			
		//#4 array_push ( array 1d local, string local )
		array_push(_dest, _vString);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vString, "array_push ( array:local, string:local )");

	});
	
	addFact("array_push test #5", function() {

		var _idx, _dest = [];
		var _vPtr = ptr(application_surface);
			
		//#5 array_push ( array 1d local, ptr local )
		array_push(_dest, _vPtr);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vPtr, "array_push ( array:local, ptr:local )");

	});
	
	addFact("array_push test #6", function() {

		var _idx, _dest = [];
		var _vBool = bool(true);
			
		//#6 array_push ( array 1d local, bool local )
		array_push(_dest, _vBool);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vBool, "array_push ( array:local, bool:local )");

	});
	
	addFact("array_push test #7", function() {

		var _idx, _dest = [];
		var _array1D = array_create(10, 1);
			
		//#7 array_push ( array 1d local, array1d local )
		array_push(_dest, _array1D);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _array1D, "array_push ( array:local, array1d:local )");

	});
	
	addFact("array_push test #8", function() {

		var _idx, _dest = [];
		var _array2D;
		_array2D[1,2] = 2;
			
		//#8 array_push ( array 1d local, array2d local )
		array_push(_dest, _array2D);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _array2D, "array_push ( array:local, array2d:local )");

	});
	
	addFact("array_push test #9", function() {

		var _idx, _dest = [];
		var _infinity = infinity;
		
		//#9 array_push ( array 1d local, infinity )
		array_push(_dest, _infinity);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _infinity, "array_push ( array:local, infinity )");

	});
	
	addFact("array_push test #10", function() {

		var _idx, _dest = [];
		var _nan = NaN;
			
		//#10 array_push ( array 1d local, NaN )
		array_push(_dest, _nan);
		_idx = array_length(_dest) - 1;
		var _result = is_nan(_dest[_idx]);
		assert_true(_result, "array_push ( array:local, NaN )");

	});
	
	addFact("array_push test #11", function() {

		var _idx, _dest = [];
		var _undefined = undefined;
			
		//#11 array_push ( array 1d local, undefined )
		array_push(_dest, _undefined);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _undefined, "array_push ( array:local, undefined )");

	});

	addFact("array_push test #12", function() {
	
		var _idx, _dest = [];
			
		//#12 array_push ( array 1d local, enum local )
		array_push(_dest, RainbowColors.Red);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], RainbowColors.Red, "array_push ( array:local, enum )");
			
	});

	// ARRAY RESIZE TESTS
	
	addFact("array_resize test #1", function() {

		//#1 array_resize, array must be resized (shrink)
		var _array = [ 1, 2, 3, 4];
		var _newSize = 2
		array_resize(_array, _newSize);
		assert_array_length(_array, _newSize, "array_resize, array must be resized (shrink)" );
			
	});
	
	addFact("array_resize test #2", function() {
			
		//#2 array_resize, array must be resized (expand)
		var _array = array_create(12800);	
		var _newSize = 64000;
		array_resize(_array, _newSize);
		assert_array_length(_array, _newSize, "array_resize, array must be resized (expand)" );
	});

	// ARRAY SORT TESTS
	
	addFact("array_sort test #1", function() {

		var _expected, _array = [4, 3, 2, 1, 5, 6, 7, 8];
		
		//#1 array_sort, basic real array sorting
		array_sort(_array, true);
		_expected = [1, 2, 3, 4, 5, 6, 7, 8];
		assert_array_equals(_array, _expected, "basic real array sorting");
		
	});
	
	addFact("array_sort test #2", function() {

		var _expected, _array = [4, 3, 2, 1, 5, 6, 7, 8];
		
		//#2 array_sort, basic real array sorting (reverse)
		array_sort(_array, false);
		_expected = [8, 7, 6, 5, 4, 3, 2, 1];
		assert_array_equals(_array, _expected, "basic real array sorting (reverse)");
		
	});
	
	addFact("array_sort test #3", function() {
		
		var _expected, _array = ["abc", "abd", "aaa", "abb", "ccc", "zzz", "d", "k"];
			
		//#3 array_sort, basic string array sorting
		array_sort(_array, true);
		_expected = ["aaa", "abb", "abc", "abd", "ccc", "d", "k", "zzz"];
		assert_array_equals(_array, _expected, "basic string array sorting");
		
	});
	
	addFact("array_sort test #4", function() {
		
		var _expected, _array = ["abc", "abd", "aaa", "abb", "ccc", "zzz", "d", "k"];
			
		//#4 array_sort, basic string array sorting (reverse)
		array_sort(_array, false);
		_expected = ["zzz", "k", "d", "ccc", "abd", "abc", "abb", "aaa"];
		assert_array_equals(_array, _expected, "basic string array sorting (reverse)");
		
	});
	
	addFact("array_sort test #5", function() {
		
		var _array = [
			{ value1: "a", value2: 10 },
			{ value1: "bb", value2:9 },
			{ value1: "b", value2: 8 },
			{ value1: "ccd", value2: 7 },
			{ value1: "cc", value2: 6 }
		];
			
		//#5 array_sort, method based struct array sorting (reals)
		array_sort(_array, function(_s1, _s2) {
			return _s1.value2 > _s2.value2 ? 1 : -1;
		})
		
		var _sortedByValue = [];
		for (var _i = array_length(_array) - 1; _i >= 0; _i--) {
			_sortedByValue[_i] = _array[_i].value2;
		}
			
		var _expected = [6, 7, 8, 9, 10];
		assert_array_equals(_sortedByValue, _expected, "method based struct array sorting (reals)");
		
	});

	addFact("array_sort test #6", function() {	
		
		var _array = [
			{ value1: "a", value2: 10 },
			{ value1: "bb", value2:9 },
			{ value1: "b", value2: 8 },
			{ value1: "ccd", value2: 7 },
			{ value1: "cc", value2: 6 }
		];
			
		//#6 array_sort, method based struct array sorting (strings)
		array_sort(_array, function(_s1, _s2) {
			return _s1.value1 > _s2.value1 ? -1 : 1;
		})
			
		var _sortedByValue = [];
		for (var _i = array_length(_array) - 1; _i >= 0; _i--) {
			_sortedByValue[_i] = _array[_i].value1;
		}
			
		var _expected = ["ccd", "cc", "bb", "b", "a"];
		assert_array_equals(_sortedByValue, _expected, "method based struct array sorting (strings)");
	});

	// ARRAY INSERT TESTS
	
	addFact("array_insert test #1", function() {	
				
		var _expected, _array = [];
		
		//#1 array_insert, empty array (real)
		array_insert(_array, 10, 100);
		_expected = [0,0,0,0,0,0,0,0,0,0,100];
		assert_array_equals(_array, _expected, "array_insert, empty array (real)");
	});
	
	addFact("array_insert test #2", function() {	
				
		var _expected, _array = [];
			
		//#2 array_insert, empty array (string)
		array_insert(_array, 10, "abc");
		_expected = [0,0,0,0,0,0,0,0,0,0,"abc"];
		assert_array_equals(_array, _expected, "array_insert, empty array (string)");
	});
	
	addFact("array_insert test #3", function() {	
				
		var _expected, _array = [1, 2, 3];
		
		//#3 array_insert, at begining (real)
		array_insert(_array, 0, 99);
		_expected = [99, 1, 2, 3];
		assert_array_equals(_array, _expected, "array_insert, at begining (real)");
	});
	
	addFact("array_insert test #4", function() {	
				
		var _expected, _array = [1, 2, 3];
			
		//#4 array_insert, at begining (string)
		array_insert(_array, 0, "abc");
		_expected = ["abc", 1, 2, 3];
		assert_array_equals(_array, _expected, "array_insert, at begining (string)");
	});
	
	addFact("array_insert test #5", function() {	
				
		var _expected, _array = [1, 2, 3];
		
		//#5 array_insert, in the middle (real)
		array_insert(_array, 1, 99);
		_expected = [1, 99, 2, 3];
		assert_array_equals(_array, _expected, "array_insert, in the middle (real)");
	});
	
	addFact("array_insert test #6", function() {	
				
		var _expected, _array = [1, 2, 3];
			
		//#6 array_insert, in the middle (string)
		array_insert(_array, 1, "abc");
		_expected = [1, "abc", 2, 3];
		assert_array_equals(_array, _expected, "array_insert, in the middle (string)");
	});
	
	addFact("array_insert test #7", function() {	
				
		var _expected, _array = [1, 2, 3];

		//#7 array_insert, negative index
		array_insert(_array, -1, 99);
		_expected = [1, 2, 99, 3];
		assert_array_equals(_array, _expected, "array_insert, negative index (insert at index counting from end)");
	});

	addFact("array_insert test #8", function() {
		
		var _expected, _array = [1, 2, 3, 4];
		
		//#8 array_insert, negative index multiple values
		array_insert(_array, -1, "a", "b", "c");
		_expected = [1, 2, 3, "a", "b", "c", 4];
		assert_array_equals(_array, _expected, "array_insert, negative index multiple values (insert at index counting from end)");

	});
	
	// ARRAY ALL TESTS

	addFact("array_all test #1", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_all(_array, _even);
		assert_true(_result, "array_all should detect that all members were even");

	});
	
	addFact("array_all test #2", function() {
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
		
		var _result = array_all(_array, _greaterOrEqualsTen);
		assert_false(_result, "array_all should detect that all not all members are greater than 10");

	});
	
	addFact("array_all test #3", function() {
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_all(_array, _greaterOrEqualsTen, 4, 3);
		assert_true(_result, "array_all should use correct range (positive values)");

	});

	addFact("array_all test #4", function() {
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
		
		var _result = array_all(_array, _greaterOrEqualsTen, -4, -4);
		assert_false(_result, "array_all should use correct range (negative values)");
	});
	
	// ARRAY ANY TESTS
	
	addFact("array_any test #1", function() {
	
		var _odd = function(_value, _index) { return _value % 2 != 0; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_any(_array, _odd);
		assert_false(_result, "array_any should detect that no member is odd");
	});
	
	addFact("array_any test #2", function() {
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
		
		var _result = array_any(_array, _greaterOrEqualsTen);
		assert_true(_result, "array_any should detect that some members are greater than 10");
	});
	
	addFact("array_any test #3", function() {
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_any(_array, _greaterOrEqualsTen, 4, 3);
		assert_true(_result, "array_any should use correct range (positive values)");
	});
	
	addFact("array_any test #4", function() {

		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		var _array = [2, 4, 6, 8, 10, 12, 14];
		
		var _result = array_any(_array, _greaterOrEqualsTen, -4, -4);
		assert_false(_result, "array_any should use correct range (negative values)");
	
	});
	
	// ARRAY CONCAT TESTS
	
	addFact("array_concat test #1", function() {
	
		var _array1 = [1, 2, 3, 4, 5, 6];
		var _array2 = ["a", "b", "c", "d", "e", "f"];
	
		var _result = array_concat(_array1, _array2);	
		assert_array_equals(_result, [1, 2, 3, 4, 5, 6, "a", "b", "c", "d", "e", "f"], "array_concat should concat mixed type arrays");
		
	});
	
	addFact("array_concat test #2", function() {
	
		var _array1 = [1, 2, 3, 4, 5, 6];
		var _array2 = ["a", "b", "c", "d", "e", "f"];
	
		var _result = array_concat(_array1, _array2);	
		assert_array_equals(_array1, [1, 2, 3, 4, 5, 6], "array_concat shouldn't mutate input array");
		assert_array_equals(_array2, ["a", "b", "c", "d", "e", "f"], "array_concat shouldn't mutate input array");
		
	});
	
	// ARRAY COPY WHILE TESTS
	
	addFact("array_copy_while test #1", function() {
	
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
	
		var _typeOfNumber = is_numeric;
	
		var _result = array_copy_while(_array, _typeOfNumber);
		assert_array_equals(_result, [1, 2, 3], "array_copy_while should return the correct array (numeric)");
		
	});
	
	addFact("array_copy_while test #2", function() {
	
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
		var _typeOfString = is_string;
		
		var _result = array_copy_while(_array, _typeOfString);
		assert_array_equals(_result, [], "array_copy_while should stop copying after first invalid predicate (string)");
		
	});
	
	addFact("array_copy_while test #3", function() {
	
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
		var _typeOfString = is_string;
	
		var _result = array_copy_while(_array, _typeOfString, 3, 6);
		assert_array_equals(_result, ["a", "b", "c", "d", "e", "f"], "array_copy_while should use correct range (positive values)");
		
	});
	
	addFact("array_copy_while test #4", function() {
	
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
		var _typeOfString = is_string;
	
		var _result = array_copy_while(_array, _typeOfString, -4, -6);
		assert_array_equals(_result, ["f", "e", "d", "c", "b", "a"], "array_copy_while should use correct range/order (positive values)");
		
	});
	
	addFact("array_copy_while test #5", function() {
		
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
		var _typeOfString = is_string;
	
		var _result = array_copy_while(_array, _typeOfString, -4, -6);
		assert_array_equals(_array, [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6], "array_copy_while shouldn't mutate input array");	
	
	});
	
	// ARRAY CREATE EXT TESTS
	
	addFact("array_create_ext test #1", function() {
		
		var _result = array_create_ext(10, function(_index) { return _index });
		assert_array_equals(_result, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], "array_create_ext should return the correct array (numeric)");
	
	});
	
	addFact("array_create_ext test #2", function() {
		
		var _result = array_create_ext(10, function(_index) { return string(_index) });
		assert_array_equals(_result, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], "array_create_ext should return the correct array (numeric)");
	
	});
	
	addFact("array_create_ext test #3", function() {
		
		var _constructor = function() constructor { }
	
		var _result = array_create_ext(10, method( { const: _constructor }, function() { return new const(); }));
		assert_array_length(_result, 10, "array_create_ext should create array with correct size (constructor)");
	
	});
	
	addFact("array_create_ext test #4", function() {
		
		var _constructor = function() constructor { }
	
		var _result = array_create_ext(10, method( { const: _constructor }, function() { return new const(); }));
		assert_false(_result[0] == _result[1], "array_create_ext should create array with distinct elements (constructor)");
	
	});
	
	addFact("array_create_ext test #5", function() {
		
		var _constructor = function() constructor { }
	
		var _result = array_create_ext(10, method( { const: _constructor }, function() { return new const(); }));
		_result = array_all(_result, is_struct);
		assert_true(_result, "array_create_ext should create array with correct element type (constructor)");
	
	});
	
	// ARRAY FILTER TESTS
	
	addFact("array_filter test #1", function() {
		
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter(_array, _even);
		assert_array_equals(_result, [2, 4, 6, 8, 10], "array_filter should filter all the even elements");
	
	});
	
	addFact("array_filter test #2", function() {
		
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_filter(_array, _even, 4, 3);
		assert_array_equals(_result, [6], "array_filter should use correct range (positive values)");
	
	});
	
	addFact("array_filter test #3", function() {
		
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

		var _result = array_filter(_array, _even, -4, -4);
		assert_array_equals(_result, [6, 4], "array_filter should use correct range/order (positive values)");
	
	});
	
	addFact("array_filter test #4", function() {
		
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

		var _result = array_filter(_array, _even, -4, -4);
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "array_filter shouldn't mutate the input array");
	
	});
	
	// ARRAY FILTER EXT TESTS
	
	addFact("array_filter_ext test #", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter_ext(_array, _even);
		assert_equals(_result, 5, "array_filter_ext should return the correct amount of filtered elements");
	
	});
	
	addFact("array_filter_ext test #2", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter_ext(_array, _even);
		assert_false(array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]), "array_filter_ext should mutate the original array");
	
	});
	
	addFact("array_filter_ext test #3", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter_ext(_array, _even);
		assert_array_equals(_array, [2, 4, 6, 8, 10, 6, 7, 8, 9, 10], "array_filter_ext should filter the array correctly");
			
	});
	
	// ARRAY FIND INDEX TESTS
	
	addFact("array_find_index test #1", function() {
	
		var _findFive = function(_value, _index) { return _value == 5; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_find_index(_array, _findFive);
		assert_equals(_result, 4, "array_find_index should return the correct index (existing)");
			
	});
	
	addFact("array_find_index test #2", function() {
	
		var _findTwenty = function(_value, _index) { return _value == 20; }
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_find_index(_array, _findTwenty);
		assert_equals(_result, -1, "array_find_index should return the correct index (non-existing)");
			
	});
	
	// ARRAY FIRST TESTS
	
	addFact("array_first #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_first(_array);
		assert_equals(_result, 1, "array_first should return the correct value (array with elements)");
			
	});
	
	addFact("array_first #2", function() {
	
		var _array = [];
		
		var _result = array_first(_array);
		assert_equals(_result, undefined, "array_first should return the correct value (empty array)");
			
	});
	
	// ARRAY FOREACH TESTS
	
	addFact("array_foreach test #1", function() {
	
		var _array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
		var _context = { 
			sum: 0, 
			func: function(_value, _index) { 
				sum += _value; 
				assert_equals(_value, _index, "array_foreach shouldn't mismatch the value/index");
			}
		};
	
		var _method = method( _context, _context.func );
		
		array_foreach(_array, _method);
		
		assert_equals(_context.sum, 45, "array_foreach should iterate over all the elements");
	
	});
	
	// ARRAY INTERSECTION TESTS
	
	addFact("array_intersection test #1", function() {
		
		var _array1 = [0, "a", 2, "b", 4, "c", 6, "d", 8, "e"];
		var _array2 = [1, 2, "a", 4, 5, "e", 8, 9];
		
		var _result = array_intersection(_array1, _array2);
		assert_array_equals(_result, ["a", 2, 4, 8, "e"], "array_intersection should create the intersection of 2 mixed type arrays");
		assert_array_equals(_array1, [0, "a", 2, "b", 4, "c", 6, "d", 8, "e"], "array_intersection shouldn't mutate input array");	
		assert_array_equals(_array2, [1, 2, "a", 4, 5, "e", 8, 9], "array_intersection shouldn't mutate input array");
	});
	
	// ARRAY LAST TESTS
	
	addFact("array_last test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_last(_array);
		assert_equals(_result, 10, "array_last should the correct value (array with elements)");
	
	});

	addFact("array_last test #2", function() {
		
		var _array = [];
		
		var _result = array_last(_array);
		assert_equals(_result, undefined, "array_last should return the correct value (empty array)");
	
	});

	// ARRAY MAP TESTS

	addFact("array_map test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map(_array, function(_value) { return _value * 2; })
		assert_array_equals(_result, [2, 4, 6, 8, 10, 12, 14, 16, 18, 20], "array_map should produce the correct output");
	
	});
	
	addFact("array_map test #2", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map(_array, function(_value) { return _value * 2; })
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "array_map shouldn't mutate input array");	
	
	});
	
	// ARRAY MAP EXT TESTS

	addFact("array_map_ext test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map_ext(_array, function(_value) { return _value * 2; }, 3, 4)
		assert_equals(_result, 4, "array_map_ext should return the correct number of mutated elements");
	
	});

	addFact("array_map_ext test #2", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map_ext(_array, function(_value) { return _value * 2; }, 3, 4)
		assert_array_equals(_array, [1, 2, 3, 8, 10, 12, 14, 8, 9, 10], "array_map_ext should correctly mutate the array");
	
	});
	
	// ARRAY REDUCE TESTS
	
	addFact("array_reduce test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_reduce(_array, function(_prev, _value, _index) { return _prev + _value; });
		assert_equals(_result, 55, "array_reduce should return the correct value");
	
	});

	// ARRAY REVERSE TESTS

	addFact("array_reverse test #1", function() {
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_reverse(_array);
		assert_array_equals(_result, [14, 12, 10, 8, 6, 4, 2], "array_reverse should return the correct output (full iteration)");
	
	});
	
	addFact("array_reverse test #2", function() {
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_reverse(_array, 2, 3);
		assert_array_equals(_result, [10, 8, 6], "array_reverse should return the correct output (partial, positive)");
	
	});
	
	addFact("array_reverse test #3", function() {
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_reverse(_array, -3, 3);
		assert_array_equals(_result, [14, 12, 10], "array_reverse should return the correct output (partial, negative)");
	
	});
	
	addFact("array_reverse test #4", function() {
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_reverse(_array, -3, 3);
		assert_array_equals(_array, [2, 4, 6, 8, 10, 12, 14], "array_map shouldn't mutate input array");
	
	});
	
	// ARRAY REVERSE EXT TESTS
	
	addFact("array_reverse_ext test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_reverse_ext(_array, 3, 4);
		assert_equals(_result, 4, "array_reverse_ext should return the correct number of mutated elements");
	
	});	

	addFact("array_reverse_ext test #2", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_reverse_ext(_array, 3, 4);
		assert_array_equals(_array, [1, 2, 3, 7, 6, 5, 4, 8, 9, 10], "array_reverse_ext should correctly mutate the array");
	
	});

	// ARRAY SHUFFLE TESTS
	
	addFact("array_shuffle test #", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_shuffle(_array);
		assert_false(array_equals(_array, _result), "array_shuffle should shuffle the initial array");
	
	});
	
	addFact("array_shuffle test #", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_shuffle(_array);
		assert_array_length(_result, 10, "array_shuffle shouldn't return array element number mismatch");
	
	});

	addFact("array_shuffle test #", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_shuffle(_array);
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "array_shuffle shouldn't mutate input array");	
	
	});
	
	// ARRAY SHUFFLE EXT TESTS
	
	addFact("array_shuffle_ext test #1", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		array_shuffle_ext(_array);
		assert_false(array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]), "array_shuffle_ext should mutate initial array");

	});
	
	addFact("array_shuffle_ext test #2", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

		array_shuffle_ext(_array);
		assert_array_length(_array, 10, "array_shuffle_ext shouldn't mutate array element number");

	});

	// ARRAY UNION TESTS

	addFact("array_union test #1", function() {
	
		var _array1 = [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, "e", 7];
		var _array2 = [3, "c", 4, "d", 5, "e", 6, "e", 7, "f", 8, "g", 9];
	
		var _result = array_union(_array1, _array2);
		assert_array_equals(_result, [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, 7, "f", 8, "g", 9], "array_union should return the correct output");

	});
	
	addFact("array_union test #2", function() {
	
		var _array1 = [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, "e", 7];
		var _array2 = [3, "c", 4, "d", 5, "e", 6, "e", 7, "f", 8, "g", 9];
	
		var _result = array_union(_array1, _array2);
		
		assert_array_equals(_array1, [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, "e", 7], "array_union shouldn't mutate input array");
		assert_array_equals(_array2, [3, "c", 4, "d", 5, "e", 6, "e", 7, "f", 8, "g", 9], "array_union shouldn't mutate input array");

	});
	
	// ARRAY UNIQUE TESTS
	
	addFact("array_unique test #1", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c"];
		
		var _result = array_unique(_array);
		assert_array_equals(_result, [1, "a", 2, "b", 3, "c", 4], "array_unique should return the correct output");
		
	});
	
	addFact("array_unique test #2", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c"];
		
		var _result = array_unique(_array);
		assert_array_equals(_array, [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c"], "array_unique shouldn't mutate input array");
		
	});
	
	// ARRAY UNIQUE EXT TESTS
	
	addFact("array_unique_ext test #1", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c", 5, "d"];
		
		var _result = array_unique_ext(_array);
		assert_equals(_result, 9, "array_unique_ext should return the correct number of mutated elements");
	
	});
	
	addFact("array_unique_ext test #2", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c", 5, "d"];
		
		var _result = array_unique_ext(_array);
		assert_array_equals(_array, [1, "a", 2, "b", 3, "c", 4, 5, "d", 2, "b", 3, "c", 5, "d"], "array_reverse_ext should correctly mutate the array");
	
	});

}

