
function BasicArrayTestSuite() : TestSuite() constructor {

	addFact("array_copy_test", function() {
		
		var _largeArrayDimensions = 32000;
		var _array1dToCopyLarge = array_create(_largeArrayDimensions, "hello");
		var _array1dToCopySmall = ["one", "two", "three", "four", "five"]
			
		var _result, _srcArray, _destArray, _expected;
			
		// Copy 1d arrays

		//#1 array_copy, copy fully into start of empty array
		_destArray = [];
		array_copy(_destArray, 0, _array1dToCopyLarge, 0, _largeArrayDimensions);
		assert_array_equals(_destArray, _array1dToCopyLarge, "#1 array_copy, copy fully into start of empty array") 
		
		//#2 array_copy, fully into out of range index of empty array
		_destArray = [];
		_expected = [0, 0, 0, 0, "one", "two", "three", "four", "five"];
		array_copy(_destArray, 4, _array1dToCopySmall, 0, 5);
		assert_array_equals(_destArray, _expected, "#2 array_copy, copy fully past the end of empty array");

		//#3 array_copy, partially (from start) into out of range index of empty array
		_destArray = [];
		_expected = [0, 0, 0, 0, "one", "two", "three", "four"];
		array_copy(_destArray, 4, _array1dToCopySmall, 0, 4);
		assert_array_equals(_destArray, _expected, "#3 array_copy, copy partially (from start) past the end of empty array");
			
		//#4 array_copy, copy partially (from middle) into out of range index of empty array"
		_destArray = [];
		_expected = [0, 0, 0, 0, "three"];
		array_copy(_destArray, 4, _array1dToCopySmall, 2, 1);
		assert_array_equals(_destArray, _expected, "#4 array_copy, copy partially (from middle) past the end of empty array");

		//#5 array_copy, copy partially (from middle) into array with existing elements
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, 98, 97, "three", "four"];
		array_copy(_destArray, 3, _array1dToCopySmall, 2, 2);
		assert_array_equals(_destArray, _expected, "#5 array_copy, copy partially (from middle) into array with existing elements");
			
		//#6 array_copy, copy partially (from middle) past end of source array
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, 98, 97, "three", "four", "five"];
		array_copy(_destArray, 3, _array1dToCopySmall, 2, 10);
		assert_array_equals(_destArray, _expected, "#6 array_copy, copy partially (from middle) past the end of the source array");
			
		//#7 array_copy, copy partially (from middle) into the middle of the target array
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, "three", "four", "five", 95];
		array_copy(_destArray, 1, _array1dToCopySmall, 2, 5);
		assert_array_equals(_destArray, _expected, "#7 array_copy, copy partially (from middle) into the middle of the target array");
			
		//#8 array_copy, with negative source index
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, "four", "five", 96, 95];
		array_copy(_destArray, 1, _array1dToCopySmall, -2, 5);
		assert_array_equals(_destArray, _expected, "#8 array_copy, with negative source index");
			
		//#9 array_copy, with negative length
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, "three", "two", "one", 95];
		array_copy(_destArray, 1, _array1dToCopySmall, 2, -5);
		assert_array_equals(_destArray, _expected, "#9 array_copy, with negative length");
			
		//#10 array_copy, copy partially (from middle) past the end of array with existing elements
		_destArray = [99, 98, 97, 96, 95];
		_expected = [99, 98, 97, 96, 95, 0, 0, 0, 0, 0, "three", "four"];
		array_copy(_destArray, 10, _array1dToCopySmall, 2, 2);
		assert_array_equals(_destArray, _expected, "#10 array_copy, copy partially (from middle) past the end of array with existing elements");
			
		//#11 array_copy, copy empty array into target array
		//_srcArray = [];
		//_destArray = ["hello"];
		//_expected = ["hello"];
		//array_copy(_destArray, 0, _srcArray, 0, 100);
		//_result = array_equals(_destArray, _expected);
		//assert_array_equals(_destArray, _expected, "#11 array_copy, copy empty source array into target array");

		//#12 array_copy ( array 1d local , int const , array 1d local , int const , int const )
		_srcArray = ["world"];
		_destArray = ["hello"];
		_expected = ["hello"];
		array_copy(_destArray, 0, _srcArray, 0, 0);
		assert_array_equals(_destArray, _expected, "#12 array_copy, copy zero elements from source array into target array");
		
		//#13 array_copy, using new negative offset and out-of-bounds length
		var array = [1, 2, 3, 4];
		var output = ["a", "b", "c"];
		array_copy(output, -1, array, -2, infinity);
		assert_array_equals(output, ["a", "b", 3, 4], "#13 array_copy, using new negative offset and out-of-bounds length");
		
		//#14 array_copy, using and out-of-bounds destination index
		array = [1, 2, 3, 4];
		output = ["a", "b", "c"];
		array_copy(output, 8, array, -2, infinity);
		assert_array_equals(output, ["a", "b", "c", 0, 0, 0, 0, 0, 3, 4], "#14 array_copy, using and out-of-bounds destination index");

		//#15 array_copy, using negative out-of-bounds destination index
		array = [1, 2, 3, 4];
		output = ["a", "b", "c"];
		array_copy(output, -infinity, array, -2, infinity);
		assert_array_equals(output, [3, 4, "c"], "#15 array_copy, using negative out-of-bounds destination index");

	});

	addFact("array_create_test", function() {

		// Local Vals
		var _vInt32 = int32(0x00000100);
		var _vInt64 = int64(567);
		var _vReal = 42.5;

		var _result;
			
		//#1 array_create ( 0 )
		_result = array_create(0);
		assert_not_undefined(_result, "#1 array_create ( 0 ), returning undefined") 
			
		//#2 array_create ( int local )
		_result = array_create(_vInt32);
		assert_array_length(_result, _vInt32, "#2 array_create ( int32:local ), not returning the correct number of elements");
			
		//#3 array_create ( int64 local )
		_result = array_create(_vInt64);
		assert_array_length(_result, _vInt64, "#3 array_create ( int64:local ), not returning the correct number of elements");
			
		//#4 array_create ( real local )
		_result = array_create(_vReal);
		assert_array_length(_result, floor(_vReal), "#4 array_create ( real:local ), not returning the correct number of elements");

			
		var _arraySize = 100;
			
		var _vPtr = ptr(application_surface);
		var _vString = "hello";
		var _vBool = true;
		var _array1D = array_create(10, 1);
		var _array2D;
		_array2D[1,2] = 2;
		var _infinity = infinity;
		var _nan = NaN;
		var _undefined = undefined;
		var _failed = false;

		//#17 array_create ( int macro, int local ) NOTE: int32 type doesn't exist on HTML5
		if (platform_not_browser()) {
			_result = array_create(_arraySize, _vInt32);
			for(var _i = 0; _i < _arraySize; ++_i)
			{
				_failed |= !assert_equals(_result[_i], _vInt32, "#17 array_create ( int:local, int32:local ), reading not returning the correct value");
				_failed |= !assert_typeof(_result[_i], "int32", "#17.1 array_create ( int:local, int32:local ), reading not returning the correct type");
				if (_failed) break;
			}
		}
			
		//#18 array_create ( int macro, int64 local )
		_failed = false;
		_result = array_create(_arraySize, _vInt64);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vInt64, "#18 array_create ( int:local, int64:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "int64", "#18.1 array_create ( int:local, int64:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#19 array_create ( int macro, real local )
		_failed = false;
		_result = array_create(_arraySize, _vReal);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vReal, "#19 array_create ( int:local, real:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "number", "#19.1 array_create ( int:local, real:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#20 array_create ( int macro, string local )
		_failed = false;
		_result = array_create(_arraySize, _vString);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vString, "#20 array_create ( int:local, string:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "string", "#20.1 array_create ( int:local, string:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#21 array_create ( int macro, ptr local )
		_failed = false;
		_result = array_create(_arraySize, _vPtr);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vPtr, "#21 array_create ( int:local, ptr:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "ptr", "#21.1 array_create ( int:local, ptr:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#22 array_create ( int macro, bool local )
		_failed = false;
		_result = array_create(_arraySize, _vBool);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _vBool, "#22 array_create ( int:local, bool:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "bool", "#22.1 array_create ( int:local, bool:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#23 array_create ( int macro, array1d local )
		_failed = false;
		_result = array_create(_arraySize, _array1D);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_array_equals(_result[_i], _array1D, "#23 array_create ( int:local, array:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "array", "#23.1 array_create ( int:local, array:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		/// @DEPRECATED
		//#24 array_create ( int macro, array2d local )
		_failed = false;
		_result = array_create(_arraySize, _array2D);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			var _arraysEqual = array_equals(_result[_i], _array2D);
			_failed |= !assert_true(_arraysEqual, "#24 array_create ( int macro, array2d local )");
			if (_failed) break;
		}
			
		//#25 array_create ( int macro, infinity )
		_failed = false;
		_result = array_create(_arraySize, _infinity);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], _infinity, "#25 array_create ( int:local, infinity:local ), reading not returning the correct value");
			if (_failed) break;
		}
			
		//#26 array_create ( int macro, NaN )
		_failed = false;
		_result = array_create(_arraySize, _nan);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_nan(_result[_i], "#26 array_create ( int:local, NaN:local ), reading not returning the correct value");
			if (_failed) break;
		}
			
		//#27 array_create ( int macro, undefined )
		_failed = false;
		_result = array_create(_arraySize, _undefined);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_undefined(_result[_i], "#27 array_create ( int:local, undefined:local ), reading not returning the correct value");
			_failed |= !assert_typeof(_result[_i], "undefined", "#27.1 array_create ( int:local, undefined:local ), reading not returning the correct type");
			if (_failed) break;
		}
			
		//#28 array_create ( int macro, enum local )
		_failed = false;
		_result = array_create(_arraySize, RainbowColors.Red);
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_failed |= !assert_equals(_result[_i], RainbowColors.Red, "#28 array_create ( int:local, enum ), reading not returning the correct value");
			if (_failed) break;
		}
						
		//#30 array_create ( int64 const )
		_vInt64 = int64(0x7fffffff00000100);
		_vInt32 = _vInt64 & 0xffffffff;
			
		_result = array_create(_vInt64);
		assert_array_length(_result, _vInt32, "#30 array_create ( int64:local ), size didn't cap to max int32 (0xffffffff)");
			
		//#31 array_create ( int const )
		_result = array_create(-1);
		assert_equals(array_length(_result), 0, "#31 array_create ( -1 ), didn't create a zero (0) size array");
			
	});

	addFact("array_delete_test", function() {
			
		var _arraySize = 10;
	
		//#1 array_delete, array size after deletion doesn't match
		var _expected, _array = [1, 2, 3, 4, 5];
		var _deleteIndex = 0;
		var _amountToDelete = 2;
		var _finalLength = array_length(_array) - _amountToDelete;
			
		array_delete(_array, _deleteIndex, _amountToDelete);
		assert_array_length(_array, _finalLength, "#1 array_delete, array size after deletion doesn't match");
			
		//#2 array_delete, from within array bounds
		_array = [1, 2, 3];
		_deleteIndex = 1;
		_amountToDelete = 2;
		array_delete(_array, _deleteIndex, _amountToDelete);
			
		_expected = [1];
		assert_array_equals(_array, _expected, "#2 array_delete, from within the array bounds")
			
		//#3 array_delete, past the end of the array bounds
		_array = [1, 2, 3, 4, 5];
		_deleteIndex = 2;
		_amountToDelete = 100;
			
		array_delete(_array, _deleteIndex, _amountToDelete);
			
		_expected = [1, 2];
		assert_array_equals(_array, _expected, "#3 array_delete, past the end of the array bounds");
			
		//#4 array_delete, with negative delete amount
		var _array = [1, 2, 3, 4, 5];
		var _deleteIndex = 2;
		var _amountToDelete = -2;
		array_delete(_array, _deleteIndex, _amountToDelete);
		
		_expected = [1, 4, 5]
		assert_array_equals(_array, _expected, "#4 array_delete, with negative delete amount (should delete in backwards direction)");
		
		//#5 array_delete, with negative index and positive length (should delete in backwards direction)
		_array = [1, 2, 3, 4];
		array_delete(_array, -1, 10);
		assert_array_equals(_array, [1, 2, 3], "#5 array_delete, with negative index and positive length (should delete in backwards direction)");

		//#6 array_delete, with negative index and negative length (should delete in backwards direction)
		_array = [1, 2, 3, 4];
		array_delete(_array, -2, -2);
		assert_array_equals(_array, [1, 4], "#6 array_delete, with negative index and negative length (should delete in backwards direction)");

		//#7 array_delete, with negative index and infinite out-of-bounds length (should delete in backwards direction)
		_array = [1, 2, 3, 4];
		array_delete(_array, -2, infinity);
		assert_array_equals(_array, [1, 2 ], "#7 array_delete, with negative index and infinite out-of-bounds length (should delete in backwards direction)");
		
	})

	addFact("array_equals_test", function() {

		var _arraySize = 129;
			
		var _result;
			
		// 1d Array tests
		var _array1D1 = [];
		var _array1D2 = [];
			
		//#1 array_equals, [] and [] must equal
		_result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "#1 array_equals, [] and [] must equal");
			
		_array1D1[0] = 1;
			
		//#2 array_equals, [] and [1] must not equal
		_result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "#2 array_equals, [] and [1] must not equal");
			
		_array1D2[0] = 1;
			
		//#3 array_equals, [1] and [1] must equal"
		_result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "#3 array_equals, [1] and [1] must equal");
			
		_array1D2[0] = 999;
			
		//#4 array_equals, [1] and [1 ... ... ... 999] must not equal
		_result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "#4 array_equals, [1] and [1 ... ... ... 999] must not equal")
			
		//#5 array_equals, [0, 1, 2, ... 128] and [0, 1, 2, ... 128] must equal
		_array1D1 = [];
		_array1D2 = [];
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			_array1D1[_i] = _i;
			_array1D2[_i] = _i;
		}
		_result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "#5 array_equals, [0, 1, 2, ... 128] and [0, 1, 2, ... 128] must equal");
			

		// 2d Array tests
		var _array2D1 = [];
		var _array2D2 = [];
			
		//#6 array_equals, two empty 2d arrays must equal
		_result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "#6 array_equals, two empty 2d arrays must equal");
			
		_array2D1[0, 0] = 1;
			
		//#7 array_equals, two different 2d arrays must not equal
		_result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "#7 array_equals, two different 2d arrays must not equal");
			
		_array2D2[0, 0] = 1;
			
		//#8 array_equals, two equal 2d arrays must equal
		_result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "#8 array_equals, two equal 2d arrays must equal");
			
		_array2D2[0, 0] = 999;
			
		//#9 array_equals, two different 2d arrays must not equal
		_result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "#9 array_equals, two different 2d arrays must not equal");
			
		//#10 array_equals, two equally filled 2d arrays must equal
		_array2D1 = [];
		_array2D2 = [];
		for(var _i = 0; _i < _arraySize; ++_i)
		{
			for(var _j = 0; _j < _arraySize; ++_j)
			{
				_array2D1[_i, _j] = _i + (_i*_j);
				_array2D2[_i, _j] = _i + (_i*_j);
			}
		}
		_result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "#10 array_equals, two equally filled 2d arrays must equal")
			
			
		_array2D1 = [];
		_array2D2 = [];
			
		_array2D1[5, 0] = 1;
			
		//#11 array_equals, two different 2d arrays (random line) must not equal
		_result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "#11 array_equals, two different 2d arrays (random line) must not equal")
			
		_array2D2[5, 0] = 1;
			
		//#12 array_equals, two equal 2d arrays must equal
		_result = array_equals(_array2D1, _array2D2);
		assert_true(_result, "#12 array_equals, two equal 2d arrays must equal")
			
		_array2D2[5, 0] = 999;
			
		//#13 array_equals, two different 2d arrays must not equal
		_result = array_equals(_array2D1, _array2D2);
		assert_false(_result, "#13 array_equals, two different 2d arrays must not equal")
			
		//#15 array_equals ( [NaN] , [NaN] ), arrays must not equal (NaN != NaN)
		_array1D1 = [NaN];
		_array1D2 = [NaN];
		_result = array_equals(_array1D1, _array1D2);
		assert_false(_result, "#15 array_equals ( [NaN] , [NaN] ), arrays must not equal (NaN != NaN)");
			
		//#16 array_equals ( [undefined] , [undefined] ), arrays must equal
		_array1D1 = [undefined];
		_array1D2 = [undefined];
		_result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "#16 array_equals ( [undefined] , [undefined] ), arrays must equal");
			
		//#17 array_equals ( [infinity] , [infinity] ), arrays must equal
		_array1D1 = [infinity];
		_array1D2 = [infinity];
		_result = array_equals(_array1D1, _array1D2);
		assert_true(_result, "#17 array_equals ( [infinity] , [infinity] ), arrays must equal");
			
	})

	addFact("array_length_test", function() {

		//array_length test
		//show_debug_message("start array_length() test");
			
		var _array = [];
		var _result;
			
		//#1 array_length, empty array must be size zero (1)
		_result = array_length(_array);
		assert_equals(_result, 0, "#1 array_length, empty array must be length zero (0)")
			
		_array[0] = 42;
			
		//#2 array_length, setting index 0 must grow array to be length one (1)
		_result = array_length(_array);
		assert_equals(_result, 1, "#2 array_length, setting index 0 must grow array to be length one (1)");
			
		_array[10] = 99;
			
		//#3 array_length, setting index 10 must grow array to be length eleven (11)
		_result = array_length(_array);
		assert_equals(_result, 11, "#3 array_length, setting index 10 must grow array to be length eleven (11)");
			
		_array[8] = 123;
			
		//#4 array_length, setting index lower than length-1 shouldn't resize the array
		_result = array_length(_array);
		assert_equals(_result, 11, "#4 array_length, setting index lower than length-1 shouldn't resize the array");
			
		//#5 array_length, copy from last array should keep the same size
		var _arrayRefCopy = _array;
		_result = array_length(_arrayRefCopy);
		assert_equals(_result, 11, "#5 array_length, copy from last array should keep the same size");


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
		_result = array_length(_array2D1);
		assert_equals(_result, _arraySize, "#6 array_length, the 1st dimension of a pre-filled 2d array");
			
		//#7 array_length, the 2nd dimension of a pre-filled 2d array
		_result = array_length(_array2D1[4]);
		assert_equals(_result, _arraySize - 3, "#7 array_length, the 2nd dimension of a pre-filled 2d array");
			
		//#8 array_length( not array ), should return 0
		var _tests = [ 22.5, int32(10), int64(20), "hello world", undefined, infinity, NaN, ptr(application_surface) ];
		for (var _i = array_length(_tests) - 1; _i >= 0; _i--) {
			_result = array_length(_tests[_i]);
			assert_equals(_result, 0, "#8 array_length( not array ), should return 0");
		}

	})

	addFact("array_pop_test", function() {
			
		var _result, _array;
					
		//#1 array_pop, must remove and return the last value of the array
		_array = [12, "string"];
		var _lastElement = _array[array_length(_array) - 1];
			
		_result = array_pop(_array);
		assert_equals(_result, _lastElement, "#1 array_pop, must remove and return the last value of the array");
			
		//#2 array_pop, must resize (shrink) the array
		_array = [12, "string"];
		var _initialLength = array_length(_array);
		array_pop(_array);
		var _finalLength = array_length(_array);
		assert_not_equals(_initialLength, _finalLength, "#2 array_pop, must resize (shrink) the array");
			
		//#3 array_pop, on empty array must return undefined
		_array = [];
		_result = array_pop(_array);
		assert_undefined(_result, "#3 array_pop, on empty array must return undefined");
			
	})

	addFact("array_push_test", function() {
	
		var _idx, _result, _dest = [];
			
		// Local Vals
		var _vInt = int32(0x00000100);
		var _vInt64 = int64(0xff12345678);
		var _vReal = 42.5;
		var _vString = "hello";
		var _vPtr = ptr(application_surface);
		var _vBool = bool(true);
		var _array1D = array_create(10, 1);
		var _array2D;
		_array2D[1,2] = 2;
		var _infinity = infinity;
		var _nan = NaN;
		var _undefined = undefined;
			
		//#1 array_push ( array 1d local, int local )
		array_push(_dest, _vInt);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vInt, "#1 array_push ( array:local, int32:local )");
			
		//#2 array_push ( array 1d local, int64 local )
		array_push(_dest, _vInt64);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vInt64, "#2 array_push ( array:local, int64:local )");
			
		//#3 array_push ( array 1d local, real local )
		array_push(_dest, _vReal);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vReal, "#3 array_push ( array:local, real:local )");
			
		//#4 array_push ( array 1d local, string local )
		array_push(_dest, _vString);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vString, "#4 array_push ( array:local, string:local )");
			
		//#5 array_push ( array 1d local, ptr local )
		array_push(_dest, _vPtr);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vPtr, "#5 array_push ( array:local, ptr:local )");
			
		//#6 array_push ( array 1d local, bool local )
		array_push(_dest, _vBool);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _vBool, "#6 array_push ( array:local, bool:local )");
			
		//#7 array_push ( array 1d local, array1d local )
		array_push(_dest, _array1D);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _array1D, "#7 array_push ( array:local, array1d:local )");
			
		//#8 array_push ( array 1d local, array2d local )
		array_push(_dest, _array2D);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _array2D, "#8 array_push ( array:local, array2d:local )");
			
		//#9 array_push ( array 1d local, infinity )
		array_push(_dest, _infinity);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _infinity, "#9 array_push ( array:local, infinity )");
			
		//#10 array_push ( array 1d local, NaN )
		array_push(_dest, _nan);
		_idx = array_length(_dest) - 1;
		_result = is_nan(_dest[_idx]);
		assert_true(_result, "#10 array_push ( array:local, NaN )");
			
		//#11 array_push ( array 1d local, undefined )
		array_push(_dest, _undefined);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], _undefined, "#11 array_push ( array:local, undefined )");
			
		//#12 array_push ( array 1d local, enum local )
		array_push(_dest, RainbowColors.Red);
		_idx = array_length(_dest) - 1;
		assert_equals(_dest[_idx], RainbowColors.Red, "#12 array_push ( array:local, enum )");
			
	})

	addFact("array_resize_test", function() {

		//#1 array_resize, array must be resized (shrink)
		var _array = [ 1, 2, 3, 4];
		var _newSize = 2
		array_resize(_array, _newSize);
		assert_array_length(_array, _newSize, "#1 array_resize, array must be resized (shrink)" );
			
		//#2 array_resize, array must be resized (expand)
		_array = array_create(12800);	
		_newSize = 64000;
		array_resize(_array, _newSize);
		assert_array_length(_array, _newSize, "#2 array_resize, array must be resized (expand)" );
	})
	
	addFact("array_sort_test", function() {
		
		//#1 array_sort, basic real array sorting
		var _expected, _array = [4, 3, 2, 1, 5, 6, 7, 8];
		
		//#1.1 array_sort, basic real array sorting
		array_sort(_array, true);
		_expected = [1, 2, 3, 4, 5, 6, 7, 8];
		assert_array_equals(_array, _expected, "#1.1 array_sort, basic real array sorting");
		
		//#1.2 array_sort, basic real array sorting (reverse)
		_array = [1, 2, 3, 4, 8, 7, 6, 5];
		array_sort(_array, false);
		_expected = [8, 7, 6, 5, 4, 3, 2, 1];
		assert_array_equals(_array, _expected, "#1.2 array_sort, basic real array sorting (reverse)");
		
		//#2 array_sort, basic string array sorting
		_array = ["abc", "abd", "aaa", "abb", "ccc", "zzz", "d", "k"];
			
		//#2.1 array_sort, basic string array sorting
		array_sort(_array, true);
		_expected = ["aaa", "abb", "abc", "abd", "ccc", "d", "k", "zzz"];
		assert_array_equals(_array, _expected, "#2.1 array_sort, basic string array sorting");
			
		//#2.2 array_sort, basic string array sorting (reverse)
		array_sort(_array, false);
		_expected = ["zzz", "k", "d", "ccc", "abd", "abc", "abb", "aaa"];
		assert_array_equals(_array, _expected, "#2.2 array_sort, basic string array sorting (reverse)");

		//#3 array_sort, method based struct array sorting
		_array = [
			{ value1: "a", value2: 10 },
			{ value1: "bb", value2:9 },
			{ value1: "b", value2: 8 },
			{ value1: "ccd", value2: 7 },
			{ value1: "cc", value2: 6 }
		];
			
		//#3.1 array_sort, method based struct array sorting (reals)
		array_sort(_array, function(_s1, _s2) {
			return _s1.value2 > _s2.value2 ? 1 : -1;
		})
		
		var _sortedByValue2 = [];
		for (var _i = array_length(_array) - 1; _i >= 0; _i--) {
			_sortedByValue2[_i] = _array[_i].value2;
		}
			
		_expected = [6, 7, 8, 9, 10];
		assert_array_equals(_sortedByValue2, _expected, "#3.1 array_sort, method based struct array sorting (reals)");
			
			
		//#3.2 array_sort, method based struct array sorting (strings)
		array_sort(_array, function(_s1, _s2) {
			return _s1.value1 > _s2.value1 ? -1 : 1;
		})
			
		var _sortedByValue1 = [];
		for (var _i = array_length(_array) - 1; _i >= 0; _i--) {
			_sortedByValue1[_i] = _array[_i].value1;
		}
			
		_expected = ["ccd", "cc", "bb", "b", "a"];
		assert_array_equals(_sortedByValue1, _expected, "#3.2 array_sort, method based struct array sorting (strings)");
	})

	addFact("array_insert_test", function() {
		
		var _expected, _array = [];
		
		//#1.1 array_insert, empty array (real)
		array_insert(_array, 10, 100);
		_expected = [0,0,0,0,0,0,0,0,0,0,100];
		assert_array_equals(_array, _expected, "#1.1 array_insert, empty array (real)");
			
		//#1.2 array_insert, empty array (string)
		_array = [];
		array_insert(_array, 10, "abc");
		_expected = [0,0,0,0,0,0,0,0,0,0,"abc"];
		assert_array_equals(_array, _expected, "#1.2 array_insert, empty array (string)");
			
			
		//#2.1 array_insert, at begining (real)
		_array = [1, 2, 3];
		array_insert(_array, 0, 99);
		_expected = [99, 1, 2, 3];
		assert_array_equals(_array, _expected, "#2.1 array_insert, at begining (real)");
			
		//#2.2 array_insert, at begining (string)
		_array = [1, 2, 3];
		array_insert(_array, 0, "abc");
		_expected = ["abc", 1, 2, 3];
		assert_array_equals(_array, _expected, "#2.2 array_insert, at begining (string)");
			
			
		//#3.1 array_insert, in the middle (real)
		_array = [1, 2, 3];
		array_insert(_array, 1, 99);
		_expected = [1, 99, 2, 3];
		assert_array_equals(_array, _expected, "#3.1 array_insert, in the middle (real)");
			
		//#3.2 array_insert, in the middle (string)
		_array = [1, 2, 3];
		array_insert(_array, 1, "abc");
		_expected = [1, "abc", 2, 3];
		assert_array_equals(_array, _expected, "#3.2 array_insert, in the middle (string)");

		//#4 array_insert, negative index
		var _array = [1, 2, 3];
		array_insert(_array, -1, 99);
		_expected = [1, 2, 99, 3];
		assert_array_equals(_array, _expected, "#4 array_insert, negative index (insert at index counting from end)");
		
		//#5 array_insert, negative index multiple
		_array = [1, 2, 3, 4];
		array_insert(_array, -1, "a", "b", "c");
		assert_array_equals(_array, [1, 2, 3, "a", "b", "c", 4], "#4 array_insert, negative index multiple values (insert at index counting from end)");

	})

	addFact("array_all", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_all(_array, _even);
		assert_true(_result, "#1 array_all : failed to detect that all members were even");
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		
		_result = array_all(_array, _greaterOrEqualsTen);
		assert_false(_result, "#2 array_all : failed to detect that all not all members are greater than 10");
	
		_result = array_all(_array, _greaterOrEqualsTen, 4, 3);
		assert_true(_result, "#3 array_all : failed to use correct range (positive values)");
		
		_result = array_all(_array, _greaterOrEqualsTen, -4, -4);
		assert_false(_result, "#4 array_all : failed to use correct range (negative values)");
	});
	
	addFact("array_any", function() {
	
		var _odd = function(_value, _index) { return _value % 2 != 0; }
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_any(_array, _odd);
		assert_false(_result, "#1 array_any : failed to detect that no member is odd");
		
		var _greaterOrEqualsTen = function(_value, _index) { return _value >= 10; }
		
		_result = array_any(_array, _greaterOrEqualsTen);
		assert_true(_result, "#2 array_any : failed to detect that some members are greater than 10");
	
		_result = array_any(_array, _greaterOrEqualsTen, 4, 3);
		assert_true(_result, "#3 array_any : failed to use correct range (positive values)");
		
		_result = array_any(_array, _greaterOrEqualsTen, -4, -4);
		assert_false(_result, "#3 array_any : failed to use correct range (negative values)");
	
	});

	addFact("array_concat", function() {
	
		var _array1 = [1, 2, 3, 4, 5, 6];
		var _array2 = ["a", "b", "c", "d", "e", "f"];
	
		var _result = array_concat(_array1, _array2);	
		assert_array_equals(_result, [1, 2, 3, 4, 5, 6, "a", "b", "c", "d", "e", "f"], "#1 array_concat : fail to concat mixed type arrays");
		assert_array_equals(_array1, [1, 2, 3, 4, 5, 6], "#2 array_concat : mutated input array");	
		assert_array_equals(_array2, ["a", "b", "c", "d", "e", "f"], "#3 array_concat : mutated input array");
		
	});
	
	addFact("array_copy_while", function() {
	
		var _array = [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6];
		
		// Copy while is numeric
		var _result = array_copy_while(_array, is_numeric);
		assert_array_equals(_result, [1, 2, 3], "#1 array_copy_while : failed to return the correct array (numeric)");
		
		// Copy whiel is string
		_result = array_copy_while(_array, is_string);
		assert_array_equals(_result, [], "#2 array_copy_while : failed stop copying after first invalid predicate (string)");
	
		_result = array_copy_while(_array, is_string, 3, 6);
		assert_array_equals(_result, ["a", "b", "c", "d", "e", "f"], "#3 array_copy_while: failed to use correct range (positive values)");
	
		_result = array_copy_while(_array, is_string, -4, -6);
		assert_array_equals(_result, ["f", "e", "d", "c", "b", "a"], "#3 array_copy_while: failed to use correct range/order (positive values)");
		
		assert_array_equals(_array, [1, 2, 3, "a", "b", "c", "d", "e", "f", 4, 5, 6], "#2 array_copy_while : mutated input array");	
	
	});
	
	addFact("array_create_ext", function() {
	
		var _constructor = function() constructor {
			
		}
		
		var _result = array_create_ext(10, function(_index) { return _index });
		assert_array_equals(_result, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], "#1 array_create_ext : failed to return the correct array (numeric)");
		
		_result = array_create_ext(10, function(_index) { return string(_index) });
		assert_array_equals(_result, ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], "#1 array_create_ext : failed to return the correct array (numeric)");
	
		_result = array_create_ext(10, method( { const: _constructor }, function() { return new const(); }));
		assert_array_length(_result, 10, "#2 array_create_ext: failed to create array with correct size (constructor)");
	
		assert_false(_result[0] == _result[1], "#3 array_create_ext: failed to create array with distinct elements (constructor)")
	
		_result = array_all(_result, is_struct);
		assert_true(_result, "#4 array_create_ext: failed to create array with correct element type (constructor)");
	
	
	});
	
	addFact("array_filter", function() {
		
		var _even = function(_value, _index) { return _value % 2 == 0; }
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter(_array, _even);
		assert_array_equals(_result, [2, 4, 6, 8, 10], "#1 array_filter : failed to filter all the even elements");
		
		_result = array_filter(_array, _even, 4, 3);
		assert_array_equals(_result, [6], "#2 array_filter : failed to use correct range (positive values)");

		_result = array_filter(_array, _even, -4, -4);
		assert_array_equals(_result, [6, 4], "#3 array_filter : failed to use correct range/order (positive values)");
		
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "#3 array_filter : mutated the input array (shouldn't)");
	
	})
	
	addFact("array_filter_ext", function() {
	
		var _even = function(_value, _index) { return _value % 2 == 0; }
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_filter_ext(_array, _even);
		assert_equals(_result, 5, "#1 array_filter_ext : failed to return the correct amount of filtered elements");
		
		assert_false(array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]), "#2 array_filter_ext : failed to mutate the original array")
		
		assert_array_equals(_array, [2, 4, 6, 8, 10, 6, 7, 8, 9, 10], "#1 array_filter_ext : failed to filter the array correctly");
			
	});
	
	addFact("array_find_index", function() {
	
		var _findFive = function(_value, _index) { return _value == 5; }
		var _findTwenty = function(_value, _index) { return _value == 20; }
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
	
		var _result = array_find_index(_array, _findFive);
		assert_equals(_result, 4, "#1 array_find_index : failed to return the correct index (existing)");
		
		_result = array_find_index(_array, _findTwenty);
		assert_equals(_result, -1, "#2 array_find_index : failed to return the correct index (non-existing)");
			
	});
	
	addFact("array_first", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_first(_array);
		assert_equals(_result, 1, "#1 array_first : failed to return the correct value (array with elements)");
		
		_array = [];
		
		_result = array_first(_array);
		assert_equals(_result, undefined, "#2 array_first : failed to return the correct value (empty array)");
	
	});
	
	addFact("array_foreach", function() {
	
		var _array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
		var _context = { 
			sum: 0, 
			func: function(_value, _index) { 
				sum += _value; 
				assert_equals(_value, _index, "#1.X array_foreach : value/index mismatch");
			}
		};
	
		var _method = method( _context, _context.func );
		
		array_foreach(_array, _method);
		
		assert_equals(_context.sum, 45, "#2 array_foreach : failed to iterate over all the elements");
	
	});
	
	addFact("array_intersection", function() {
		
		var _array1 = [0, "a", 2, "b", 4, "c", 6, "d", 8, "e"];
		var _array2 = [1, 2, "a", 4, 5, "e", 8, 9];
		
		var _result = array_intersection(_array1, _array2);
		assert_array_equals(_result, ["a", 2, 4, 8, "e"], "#1 array_intersection : fail to create the intersection of 2 mixed type arrays");
		assert_array_equals(_array1, [0, "a", 2, "b", 4, "c", 6, "d", 8, "e"], "#2 array_intersection : mutated input array");	
		assert_array_equals(_array2, [1, 2, "a", 4, 5, "e", 8, 9], "#3 array_intersection : mutated input array");
	});
	
	addFact("array_last", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_last(_array);
		assert_equals(_result, 10, "#1 array_last : failed to return the correct value (array with elements)");
		
		_array = [];
		
		_result = array_last(_array);
		assert_equals(_result, undefined, "#2 array_last : failed to return the correct value (empty array)");
	
	});

	addFact("array_map", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map(_array, function(_value) { return _value * 2; })
		
		assert_array_equals(_result, [2, 4, 6, 8, 10, 12, 14, 16, 18, 20], "#1 array_map : fail to produce the correct output");
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "#2 array_map : mutated input array");	
	
	});
	
	addFact("array_map_ext", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_map_ext(_array, function(_value) { return _value * 2; }, 3, 4)
		
		assert_equals(_result, 4, "#1 array_map_ext : fail to return the correct number of mutated elements");
		
		assert_array_equals(_array, [1, 2, 3, 8, 10, 12, 14, 8, 9, 10], "#2 array_map_ext : failed to correctly mutate the array");
	
	});
	
	addFact("array_reduce", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_reduce(_array, function(_prev, _value, _index) { return _prev + _value; });
	
		assert_equals(_result, 55, "#1 array_reduce : failed to return the correct value");
	
	});

	addFact("array_reverse", function() {
	
		var _array = [2, 4, 6, 8, 10, 12, 14];
	
		var _result = array_reverse(_array);
		assert_array_equals(_result, [14, 12, 10, 8, 6, 4, 2], "#1 array_reverse : failed to return the correct output (full iteration)");
		
		_result = array_reverse(_array, 2, 3);
		assert_array_equals(_result, [10, 8, 6], "#2 array_reverse : failed to return the correct output (partial, positive)");
		
		_result = array_reverse(_array, -3, 3);
		assert_array_equals(_result, [14, 12, 10], "#3 array_reverse : failed to return the correct output (partial, negative)");
		
		assert_array_equals(_array, [2, 4, 6, 8, 10, 12, 14], "#4 array_map : mutated input array");	
	
	});
	
	addFact("array_reverse_ext", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_reverse_ext(_array, 3, 4)
		
		assert_equals(_result, 4, "#1 array_reverse_ext : fail to return the correct number of mutated elements");
		
		assert_array_equals(_array, [1, 2, 3, 7, 6, 5, 4, 8, 9, 10], "#2 array_reverse_ext : failed to correctly mutate the array");
	
	});

	addFact("array_shuffle", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		var _result = array_shuffle(_array);
	
		assert_false(array_equals(_array, _result), "#1 array_shuffle : failed to shuffle the initial array");
	
		assert_array_length(_result, 10, "#2 array_shuffle : returned array element number mismatch");
	
		assert_array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], "#3 array_shuffle : mutated input array");	
	
	});
	
	addFact("array_shuffle_ext", function() {
	
		var _array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		
		array_shuffle_ext(_array);
	
		assert_false(array_equals(_array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]), "#1 array_shuffle_ext : failed to mutate initial array");
	
		assert_array_length(_array, 10, "#2 array_shuffle_ext : mutated array element number mismatch");

	});

	addFact("array_union", function() {
	
		var _array1 = [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, "e", 7];
		var _array2 = [3, "c", 4, "d", 5, "e", 6, "e", 7, "f", 8, "g", 9];
	
		var _result = array_union(_array1, _array2);
		assert_array_equals(_result, [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, 7, "f", 8, "g", 9], "#1 array_union : failed to return the correct output");
		
		assert_array_equals(_array1, [1, "a", 2, "b", 3, "c", 4, "d", 5, "e", 6, "e", 7], "#2 array_union : mutated input array");
		assert_array_equals(_array2, [3, "c", 4, "d", 5, "e", 6, "e", 7, "f", 8, "g", 9], "#3 array_union : mutated input array");

	});
	
	addFact("array_unique", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c"];
		var _result = array_unique(_array);
		
		assert_array_equals(_result, [1, "a", 2, "b", 3, "c", 4], "#1 array_unique : failed to return the correct output");
		assert_array_equals(_array, [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c"], "#2 array_unique : mutated input array");
		
		_array = [1.3, 1.7, 1.9, 1.4, 1.3, 2, 1.7];		
		_result = array_unique(_array);
		assert_array_equals(_result, [1.3, 1.7, 1.9, 1.4, 2], "#3 array_unique : failed to return the correct output (doubles)");
		
		_array = [{}, {}, [], [], {}, {}];		
		_result = array_unique(_array);
		assert_array_length(_result, 6, "#4 array_unique : unique arrays and structs were not treated as unique");

		var _arr = [], _struct = {};
		_array = [{}, _struct, _arr, _arr, _struct, {}];	
		_result = array_unique(_array);
		assert_array_length(_result, 4, "#4 array_unique : referenced arrays and structs were treated as unique");
	});
	
	addFact("array_unique_ext", function() {
	
		var _array = [1, "a", 2, "b", 3, "c", 4, 1, "a", 2, "b", 3, "c", 5, "d"];
		
		var _result = array_unique_ext(_array);
		
		assert_equals(_result, 9, "#1 array_unique_ext : fail to return the correct number of mutated elements");
		
		assert_array_equals(_array, [1, "a", 2, "b", 3, "c", 4, 5, "d", 2, "b", 3, "c", 5, "d"], "#2 array_reverse_ext : failed to correctly mutate the array");
	
	});

}

