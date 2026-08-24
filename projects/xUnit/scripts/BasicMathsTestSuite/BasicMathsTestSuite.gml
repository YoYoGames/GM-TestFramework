
function BasicMathsTestSuite() : TestSuite() constructor {

	// ABS TESTS

	addFact("abs_test #1", function() {

		// Whole numbers: abs( positive )
		var numOne = 2;

		var resOne = abs(numOne);
		assert_equals(resOne, 2, "#1 Positive");
	})

	addFact("abs_test #2", function() {

		// Whole numbers: abs( positive )
		var numTwo = 3;

		var resTwo = abs(numTwo);
		assert_equals(resTwo, 3, "#2 Positive two");
	})

	addFact("abs_test #3", function() {

		// Whole numbers: abs( negative )
		var negOne = -2;

		var resNegOne = abs(negOne);
		assert_equals(resNegOne, 2, "#3 Negative one");
	})

	addFact("abs_test #4", function() {

		// Whole numbers: abs( negative )
		var negTwo = -3;

		var resNegTwo = abs(negTwo);
		assert_equals(resNegTwo, 3, "#4 Negative two");
	})

	addFact("abs_test #5", function() {

		// Fractionals: abs( positive )
		var numOne = 5.5;

		var resNumOne = abs(numOne);
		assert_equals(resNumOne, 5.5, "#5 fractional positive");
	})

	addFact("abs_test #6", function() {

		// Fractionals: abs( positive )
		var numTwo = 7.7;

		var resNumTwo = abs(numTwo);
		assert_equals(resNumTwo, 7.7, "#6 fractional positive two");
	})

	addFact("abs_test #7", function() {

		// Fractionals: abs( negative )
		var negOne = -9.9;

		var resNegOne = abs(negOne);
		assert_equals(resNegOne, 9.9, "#7 fractional negative one");
	})

	addFact("abs_test #8", function() {

		// Fractionals: abs( negative )
		var negTwo = -15.1;

		var resNegTwo = abs(negTwo);
		assert_equals(resNegTwo, 15.1, "#8 fractional negative two");
	})

	addFact("abs_test #9", function() {

		// Literals: abs( positive )
		assert_equals(abs(7.7), 7.7, "#1 Literals Positive");
	})

	addFact("abs_test #10", function() {

		// Literals: abs( positive )
		assert_equals(abs(0.3), 0.3, "#2 Literals Positive");
	})

	addFact("abs_test #11", function() {

		// Literals: abs( negative )
		assert_equals(abs(-4.4), 4.4, "#1 Literals Negative");
	})

	addFact("abs_test #12", function() {

		// Literals: abs( negative )
		assert_equals(abs(-6.6), 6.6, "#2 Literals Negative");
	})

	addFact("abs_test #13", function() {

		// Int32: abs( positive )
		// The only way to generate an int32 is to read it from a buffer
		var _buffer = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buffer, buffer_s32, 0x0A);
		var _vInt = buffer_peek(_buffer, 0, buffer_s32);

		var absInt = abs(_vInt);
		assert_equals(absInt, 10, "#1 Int32 Abs Positive" );

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("abs_test #14", function() {

		// Int32: abs( negative )
		// The only way to generate an int32 is to read it from a buffer
		var _buffer = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buffer, buffer_s32, 0xFFFFFF80);
		var _vInt = buffer_peek(_buffer, 0, buffer_s32);

		var absInt = abs(_vInt);
		assert_equals(absInt, 128, "#1 Int32 Abs Negative" );

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("abs_test #15", function() {

		// Int64: abs( positive )
		var bigInt = 0x80000000;
		assert_true(is_int64(bigInt), "bigInt is the incorrect type");

		var absInt = abs(bigInt);
		assert_true(is_real(absInt), "absInt is not a real"); // Currently absInt is returned as a real.
		//assert_true(is_int64(absInt), "absInt is the incorrect type");
		assert_equals(absInt, 0x80000000, "#1 Int64 Abs Positive" );
	})

	addFact("abs_test #16", function() {

		// Int64: abs( negative )
		var bigInt = 0xFFFFFFFF12345678;
		assert_true(is_int64(bigInt), "bigInt is the incorrect type");

		var absInt = abs(bigInt);
		assert_true(is_real(absInt), "absInt is not a real"); // Currently absInt is returned as a real.
		//assert_true(is_int64(absInt), "absInt is the incorrect type");
		assert_equals(absInt, 3989547400, "#1 Int64 Abs Negative" );
	})

	// ANGLE_DIFFERENCE TESTS

	addFact("angle_difference_test #1", function() {

		// angle_difference( real const , real const ): (90, 170)
		var _result = angle_difference(90, 170);
		assert_equals(_result, -80, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #2", function() {

		// angle_difference( real const , real const ): (90, -170)
		var _result = angle_difference(90, -170);
		assert_equals(_result, -100, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #3", function() {

		// angle_difference( real const , real const ): (-90, 170)
		var _result = angle_difference(-90, 170);
		assert_equals(_result, 100, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #4", function() {

		// angle_difference( real const , real const ): (-90, -170)
		var _result = angle_difference(-90, -170);
		assert_equals(_result, 80, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #5", function() {

		// angle_difference( real const , real const ): (0, 10)
		var _result = angle_difference(0, 10);
		assert_equals(_result, -10, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #6", function() {

		// angle_difference( real const , real const ): (0, -10)
		var _result = angle_difference(0, -10);
		assert_equals(_result, 10, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #7", function() {

		// test distance = 0: (90, 90)
		var _result = angle_difference(90, 90);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #8", function() {

		// test distance = 0: (-270, 90)
		var _result = angle_difference(-270, 90);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #9", function() {

		// test distance = 0: (90, -270)
		var _result = angle_difference(90, -270);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #10", function() {

		// test distance = 0: (-540, 540)
		var _result = angle_difference(-540, 540);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #11", function() {

		// test distance = 0: (-2160, 1080)
		var _result = angle_difference(-2160, 1080);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #12", function() {

		// test large range: (2100, 1080)
		var _result = angle_difference(2100, 1080);
		assert_equals(_result, -60, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #13", function() {

		// test large range: (2100, -1080)
		var _result = angle_difference(2100, -1080);
		assert_equals(_result, -60, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #14", function() {

		// test large range: (-2100, 1080)
		var _result = angle_difference(-2100, 1080);
		assert_equals(_result, 60, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #15", function() {

		// test large range: (-2100, -1080)
		var _result = angle_difference(-2100, -1080);
		assert_equals(_result, 60, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #16", function() {

		// test decimal values: (90.5, 95.5)
		var _result = angle_difference(90.5, 95.5);
		assert_equals(_result, -5, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #17", function() {

		// test decimal values: (90.75, 95.5)
		var _result = angle_difference(90.75, 95.5);
		assert_equals(_result, -4.75, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #18", function() {

		// test decimal values: (90, -170.5)
		var _result = angle_difference(90, -170.5);
		assert_equals(_result, -99.5, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #19", function() {

		// test decimal values: (-90, 170.5)
		var _result = angle_difference(-90, 170.5);
		assert_equals(_result, 99.5, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #20", function() {

		// test decimal values: (-90, -170.5)
		var _result = angle_difference(-90, -170.5);
		assert_equals(_result, 80.5, "#1 angle_difference( real const , real const )")
	})

	addFact("angle_difference_test #21", function() {

		// test local real type: sign-handling matrix
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 90);
		buffer_write(_buffer, buffer_f32, 270);
		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _result;

		_result = angle_difference(_vReal1, _vReal2);
		assert_equals(_result, -180, "#1 angle_difference( real local , real local )")

		_result = angle_difference(-_vReal1, _vReal2);
		assert_equals(_result, 0, "#1 angle_difference( real local , real local )")

		_result = angle_difference(_vReal1, -_vReal2);
		assert_equals(_result, 0, "#1 angle_difference( real local , real local )")

		_result = angle_difference(-_vReal1, -_vReal2);
		assert_equals(_result, -180, "#1 angle_difference( real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("angle_difference_test #22", function() {

		// test local int type: sign-handling matrix
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 90);
		buffer_write(_buffer, buffer_s32, 270);
		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _result;

		_result = angle_difference(_vInt1, _vInt2);
		assert_equals(_result, -180, "#1 angle_difference( int local , int local )")

		_result = angle_difference(-_vInt1, _vInt2);
		assert_equals(_result, 0, "#1 angle_difference( int local , int local )")

		_result = angle_difference(_vInt1, -_vInt2);
		assert_equals(_result, 0, "#1 angle_difference( int local , int local )")

		_result = angle_difference(-_vInt1, -_vInt2);
		assert_equals(_result, -180, "#1 angle_difference( int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("angle_difference_test #23", function() {

		// test local int64 type: sign-handling matrix
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 90);
		buffer_write(_buffer, buffer_u64, 270);
		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _result;

		_result = angle_difference(_vInt64_1, _vInt64_2);
		assert_equals(_result, -180, "#1 angle_difference( int64 local , int64 local )")

		_result = angle_difference(-_vInt64_1, _vInt64_2);
		assert_equals(_result, 0, "#1 angle_difference( int64 local , int64 local )")

		_result = angle_difference(_vInt64_1, -_vInt64_2);
		assert_equals(_result, 0, "#1 angle_difference( int64 local , int64 local )")

		_result = angle_difference(-_vInt64_1, -_vInt64_2);
		assert_equals(_result, -180, "#1 angle_difference( int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	// ARCCOS TESTS

	#macro half_pi_ArccosTest (pi/2)

	addFact("arccos_input_range_test", function() {

		// arccos input range test
		assert_throw(function() {
			var _number = 1.1
			return arccos(_number);	
		}, "#1 Passing an out of range value to arccos (should throw error)");

	})

	addFact("arccos_test #1", function() {

		// arccos: arccos(0) == pi/2
		var arccosZero = arccos(0)
		assert_equals(arccosZero, half_pi_ArccosTest, "#1 arccos(0) == half_pi_ArccosTest")
	})

	addFact("arccos_test #2", function() {

		// arccos: arccos(1) == 0
		var arccosOne = arccos(1)
		assert_equals(arccosOne, 0, "#2 arccos(1) == 0")
	})

	addFact("arccos_test #3", function() {

		// arccos: arccos(-1) == pi
		var arccosNegOne = arccos(-1)
		assert_equals(arccosNegOne, pi, "#3 arccos(-1) == pi")
	})

	addFact("arccos_test #4", function() {

		// arccos: output stays within [0, pi] across the valid input range
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = arccos(_yPos)
			assert_greater_or_equal(_xPos, 0, "X Pos should always be greater than 0")
			assert_less_or_equal(_xPos, pi, "X Pos should always be less than pi")

			_yPos += 0.01
		}
	})

	// ARCSIN TESTS

	#macro half_pi_ArcsinTest (pi/2)

	addFact("arcsin_input_range_test", function() {

		// Arcsin input range test
		assert_throw(function() {
			var _number = 1.1
			return arcsin(_number);	
		}, "#1 Passing an out of range value to 'arcsin' (should throw error)");
	})

	addFact("arcsin_test #1", function() {

		// arcsin: arcsin(0) == 0
		var arcsinZero = arcsin(0)
		assert_equals(arcsinZero, 0, "#1 arcsin(0) == 0")
	})

	addFact("arcsin_test #2", function() {

		// arcsin: arcsin(1) == pi/2
		var arcsinOne = arcsin(1)
		assert_equals(arcsinOne, half_pi_ArcsinTest, "#2 arcsin(1) == half_pi_ArcsinTest")
	})

	addFact("arcsin_test #3", function() {

		// arcsin: arcsin(-1) == -pi/2
		var arcsinNegOne = arcsin(-1)
		assert_equals(arcsinNegOne, (-half_pi_ArcsinTest), "#3 arcsin(-1) == -half_pi_ArcsinTest")
	})

	addFact("arcsin_test #4", function() {

		// arcsin: output stays within [-pi/2, pi/2] across the valid input range
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = arcsin(_yPos)
			assert_greater_or_equal(_xPos, -half_pi_ArcsinTest, "X Pos should always be greater than -half_pi_ArcsinTest")
			assert_less_or_equal(_xPos, half_pi_ArcsinTest, "X Pos should always be less than half_pi_ArcsinTest")

			_yPos += 0.01
		}
	})

	// ARCTAN2 TESTS

	#macro quarter_pi_Arctan2Test (pi/4)
	#macro two_pi_Arctan2Test (pi*2)

	addFact("arctan2_test #1", function() {

		// arctan2: first quadrant
		var twoOverTwo = arctan2(2, 2)
		assert_equals(twoOverTwo, quarter_pi_Arctan2Test, "#1 arctan2(2, 2) == pi/4")
	})

	addFact("arctan2_test #2", function() {

		// arctan2: second quadrant
		var twoOverNegativeTwo = arctan2(2, -2)
		assert_equals(twoOverNegativeTwo, (pi - quarter_pi_Arctan2Test), "#2 arctan2(2, -2) == pi - (pi/4)")
	})

	addFact("arctan2_test #3", function() {

		// arctan2: fourth quadrant
		var negativeTwoOverTwo = arctan2(-2, 2)
		assert_equals(negativeTwoOverTwo, -(quarter_pi_Arctan2Test), "#3 arctan2(-2, 2) == -(pi/4)")
	})

	addFact("arctan2_test #4", function() {

		// arctan2: third quadrant
		var negativeOverNegative = arctan2(-2, -2)
		assert_equals(negativeOverNegative, -(pi - quarter_pi_Arctan2Test), "#4 arctan2(-2, -2) == -(pi - (pi/4))")
	})

	addFact("arctan2_test #5", function() {

		// arctan2: arbitrary value
		var _res1 = arctan2(      1,    0.5)
		assert_equals(_res1,   1.10715     , ("_res1 ==  1.10715 "))
	})

	addFact("arctan2_test #6", function() {

		// arctan2: arbitrary value
		var _res2 = arctan2(    0.5,   0.75)
		assert_equals(_res2,   0.588003    , ("_res2 ==  0.588003"))
	})

	addFact("arctan2_test #7", function() {

		// arctan2: arbitrary value
		var _res3 = arctan2(    0.4,  -0.66)
		assert_equals(_res3,   2.59673     , ("_res3 ==  2.59673 "))
	})

	addFact("arctan2_test #8", function() {

		// arctan2: arbitrary value
		var _res4 = arctan2(    0.4,   0.66)
		assert_equals(_res4,   0.544864    , ("_res4 ==  0.544864"))
	})

	addFact("arctan2_test #9", function() {

		// arctan2: arbitrary value
		var _res5 = arctan2(    0.9,    0.1)
		assert_equals(_res5,   1.46014     , ("_res5 ==  1.46014 "))
	})

	addFact("arctan2_test #10", function() {

		// arctan2: arbitrary value
		var _res6 = arctan2(    0.3,   0.75)
		assert_equals(_res6,   0.380506    , ("_res6 ==  0.380506"))
	})

	addFact("arctan2_test #11", function() {

		// arctan2: arbitrary value
		var _res7 = arctan2( -0.123, -0.456)
		assert_equals(_res7,  -2.87813     , ("_res7 == -2.87813 "))
	})

	addFact("arctan2_test #12", function() {

		// arctan2: arbitrary value
		var _res8 = arctan2( -0.789,  0.123)
		assert_equals(_res8,  -1.41615     , ("_res8 == -1.41615 "))
	})

	addFact("arctan2_test #13", function() {

		// arctan2: arbitrary value
		var _res9 = arctan2( -0.321,      1)
		assert_equals(_res9,  -0.31061     , ("_res9 == -0.31061 "))
	})

	// ARCTAN TESTS

	#macro quarter_pi_ArctanTest (pi/4)
	#macro half_pi_ArctanTest (pi/2)

	addFact("arctan_test #1", function() {

		// arctan: arctan(0) == 0
		var atanZero = arctan(0)
		assert_equals(atanZero, 0, "#1 arctan(0) == 0")
	})

	addFact("arctan_test #2", function() {

		// arctan: arctan(1) == pi/4
		var atanOne = arctan(1)
		assert_equals(atanOne, quarter_pi_ArctanTest, "#2 arctan(1) == pi/4")
	})

	addFact("arctan_test #3", function() {

		// arctan: arctan(-1) == -(pi/4)
		var atanNegOne = arctan(-1)
		assert_equals(atanNegOne, -(quarter_pi_ArctanTest), "#3 (arctan(-1) == -(pi/4)")
	})

	addFact("arctan_test #4", function() {

		// arctan: output stays within (-pi/2, pi/2) across the tested input range
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = arctan(_yPos)
			assert_greater_or_equal(_xPos, -(half_pi_ArctanTest), "X Pos should always be greater than -(pi/2)")
			assert_less_or_equal(_xPos, half_pi_ArctanTest, "X Pos should always be less than (pi/2)")

			_yPos += 0.01
		}
	})

	// CEIL TESTS

	addFact("ceil_test #1", function() {

		// Ceil: positive and negative variables
		var numOne = 2.3;
		var numTwo = 3.8;
		var negOne = -2.3;
		var negTwo = -3.8;

		var resOne = ceil(numOne);
		var resTwo = ceil(numTwo);
		var resNegOne = ceil(negOne);
		var resNegTwo = ceil(negTwo);

		assert_equals(resOne, 3.0, "#1 Positive");
		assert_equals(resTwo, 4.0, "#2 Positive");
		assert_equals(resNegOne, -2.0, "#1 Negative");
		assert_equals(resNegTwo, -3.0, "#2 Negative");
	})

	addFact("ceil_test #2", function() {

		// Ceil: literal values
		assert_equals(ceil(7.7), 8.0, "#1 Local Positive");
		assert_equals(ceil(0.3), 1.0, "#2 Local Positive");
		assert_equals(ceil(-4.4), -4.0, "#1 Local Negative");
		assert_equals(ceil(-6.6), -6.0, "#2 Local Negative");
	})

	// CLAMP TESTS

	addFact("clamp_test #1", function() {

		// clamp( real local, real local , real local ): value within range
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp( _vReal1, _vReal2 , _vReal_3 );
		assert_equals(_result, _vReal1, "#1 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #2", function() {

		// clamp( real local, real local , real local ): value below min
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal2, _vReal1 , _vReal_3 );
		assert_equals(_result, _vReal1, "#2 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #3", function() {

		// clamp( real local, real local , real local ): value above max
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal_3, _vReal2, _vReal1);
		assert_equals(_result, _vReal1, "#3 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #4", function() {

		// clamp( real local, real local , real local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal1, _vReal_3, _vReal2);
		assert_equals(_result, _vReal2, "#4 clamp( real local, real local , real local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #5", function() {

		// clamp( real local, real local , real local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal_3, _vReal1, _vReal2);
		assert_equals(_result, _vReal2, "#5 clamp( real local, real local , real local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #6", function() {

		// clamp( real local, real local , real local ): min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal1, -_vReal_3, -_vReal2);
		assert_equals(_result, -_vReal2, "#6 clamp( real local, real local , real local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #7", function() {

		// clamp( real local, real local , real local ): min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vReal1, -_vReal2, -_vReal_3);
		assert_equals(_result, -_vReal_3, "#7 clamp( real local, real local , real local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #8", function() {

		// clamp( real local, real local , real local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp( -_vReal1, _vReal2 , _vReal_3 );
		assert_equals(_result, _vReal2, "#8 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #9", function() {

		// clamp( real local, real local , real local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal2, _vReal1 , _vReal_3 );
		assert_equals(_result, _vReal1, "#9 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #10", function() {

		// clamp( real local, real local , real local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal_3, _vReal2, _vReal1);
		assert_equals(_result, _vReal2, "#10 clamp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #11", function() {

		// clamp( real local, real local , real local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal1, _vReal_3, _vReal2);
		assert_equals(_result, _vReal2, "#11 clamp( real local, real local , real local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #12", function() {

		// clamp( real local, real local , real local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal_3, _vReal1, _vReal2);
		assert_equals(_result, _vReal2, "#12 clamp( real local, real local , real local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #13", function() {

		// clamp( real local, real local , real local ): negative value, min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal1, -_vReal_3, -_vReal2);
		assert_equals(_result, -_vReal1, "#13 clamp( real local, real local , real local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #14", function() {

		// clamp( real local, real local , real local ): negative value, min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(-_vReal1, -_vReal2, -_vReal_3);
		assert_equals(_result, -_vReal_3, "#14 clamp( real local, real local , real local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #15", function() {

		// clamp( int local, int local , int local ): value within range
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp( _vInt1, _vInt2 , _vInt_3 );
		assert_equals(_result, _vInt1, "#15 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #16", function() {

		// clamp( int local, int local , int local ): value below min
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt2, _vInt1 , _vInt_3 );
		assert_equals(_result, _vInt1, "#16 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #17", function() {

		// clamp( int local, int local , int local ): value above max
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt_3, _vInt2, _vInt1);
		assert_equals(_result, _vInt1, "#173 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #18", function() {

		// clamp( int local, int local , int local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt1, _vInt_3, _vInt2);
		assert_equals(_result, _vInt2, "#18 clamp( int local, int local , int local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #19", function() {

		// clamp( int local, int local , int local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt_3, _vInt1, _vInt2);
		assert_equals(_result, _vInt2, "#19 clamp( int local, int local , int local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #20", function() {

		// clamp( int local, int local , int local ): min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt1, -_vInt_3, -_vInt2);
		assert_equals(_result, -_vInt2, "#20 clamp( int local, int local , int local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #21", function() {

		// clamp( int local, int local , int local ): min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt1, -_vInt2, -_vInt_3);
		assert_equals(_result, -_vInt_3, "#21 clamp( int local, int local , int local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #22", function() {

		// clamp( int local, int local , int local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp( -_vInt1, _vInt2 , _vInt_3 );
		assert_equals(_result, _vInt2, "#22 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #23", function() {

		// clamp( int local, int local , int local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt2, _vInt1 , _vInt_3 );
		assert_equals(_result, _vInt1, "#23 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #24", function() {

		// clamp( int local, int local , int local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt_3, _vInt2, _vInt1);
		assert_equals(_result, _vInt2, "#24 clamp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #25", function() {

		// clamp( int local, int local , int local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt1, _vInt_3, _vInt2);
		assert_equals(_result, _vInt2, "#25 clamp( int local, int local , int local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #26", function() {

		// clamp( int local, int local , int local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt_3, _vInt1, _vInt2);
		assert_equals(_result, _vInt2, "#26 clamp( int local, int local , int local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #27", function() {

		// clamp( int local, int local , int local ): negative value, min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt1, -_vInt_3, -_vInt2);
		assert_equals(_result, -_vInt1, "#27 clamp( int local, int local , int local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #28", function() {

		// clamp( int local, int local , int local ): negative value, min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(-_vInt1, -_vInt2, -_vInt_3);
		assert_equals(_result, -_vInt_3, "#28 clamp( int local, int local , int local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #29", function() {

		// clamp( int64 local, int64 local , int64 local ): value within range
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp( _vInt64_1, _vInt64_2 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#29 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #30", function() {

		// clamp( int64 local, int64 local , int64 local ): value below min
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_2, _vInt64_1 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#30 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #31", function() {

		// clamp( int64 local, int64 local , int64 local ): value above max
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_3, _vInt64_2, _vInt64_1);
		assert_equals(_result, _vInt64_1, "#31 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #32", function() {

		// clamp( int64 local, int64 local , int64 local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#32 clamp( int64 local, int64 local , int64 local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #33", function() {

		// clamp( int64 local, int64 local , int64 local ): min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_3, _vInt64_1, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#33 clamp( int64 local, int64 local , int64 local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #34", function() {

		// clamp( int64 local, int64 local , int64 local ): min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_1, -_vInt64_3, -_vInt64_2);
		assert_equals(_result, -_vInt64_2, "#34 clamp( int64 local, int64 local , int64 local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #35", function() {

		// clamp( int64 local, int64 local , int64 local ): min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt64_1, -_vInt64_2, -_vInt64_3);
		assert_equals(_result, -_vInt64_3, "#35 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #36", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp( -_vInt64_1, _vInt64_2 , _vInt64_3 );
		assert_equals(_result, _vInt64_2, "#36 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #37", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_2, _vInt64_1 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#37 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #38", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_3, _vInt64_2, _vInt64_1);
		assert_equals(_result, _vInt64_2, "#38 clamp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #39", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#39 clamp( int64 local, int64 local , int64 local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #40", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value, min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_3, _vInt64_1, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#40 clamp( int64 local, int64 local , int64 local ) - min/max flipped" )

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #41", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value, min/max negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_1, -_vInt64_3, -_vInt64_2);
		assert_equals(_result, -_vInt64_1, "#41 clamp( int64 local, int64 local , int64 local ) - min/max negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #42", function() {

		// clamp( int64 local, int64 local , int64 local ): negative value, min/max flipped and negative
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(-_vInt64_1, -_vInt64_2, -_vInt64_3);
		assert_equals(_result, -_vInt64_3, "#42 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #43", function() {

		// clamp( real const, real const , real const ): value within range
		var _result = clamp( 4.5, 0.1 , 12.5 );
		assert_equals(_result, 4.5, "#43 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #44", function() {

		// clamp( real const, real const , real const ): value below min
		var _result = clamp(0.1, 4.5 , 12.5 );
		assert_equals(_result, 4.5, "#44 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #45", function() {

		// clamp( real const, real const , real const ): value above max
		var _result = clamp(12.5, 0.1, 4.5);
		assert_equals(_result, 4.5, "#45 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #46", function() {

		// clamp( real const, real const , real const ): min/max flipped
		var _result = clamp(4.5, 12.5, 0.1);
		assert_equals(_result, 0.1, "#46 clamp( real const, real const , real const ) - min/max flipped")
	})

	addFact("clamp_test #47", function() {

		// clamp( real const, real const , real const ): min/max flipped
		var _result = clamp(12.5, 4.5, 0.1);
		assert_equals(_result, 0.1, "#47 clamp( real const, real const , real const ) - min/max flipped" )
	})

	addFact("clamp_test #48", function() {

		// clamp( real const, real const , real const ): min/max negative
		var _result = clamp(4.5, -12.5, -0.1);
		assert_equals(_result, -0.1, "#48 clamp( real const, real const , real const ) - min/max negative")
	})

	addFact("clamp_test #49", function() {

		// clamp( real const, real const , real const ): min/max flipped and negative
		var _result = clamp(4.5, -0.1, -12.5);
		assert_equals(_result, -12.5, "#49 clamp( real const, real const , real const ) - min/max flipped and negative")
	})

	addFact("clamp_test #50", function() {

		// clamp( real const, real const , real const ): negative value
		var _result = clamp( -4.5, 0.1 , 12.5 );
		assert_equals(_result, 0.1, "#50 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #51", function() {

		// clamp( real const, real const , real const ): negative value
		var _result = clamp(-0.1, 4.5 , 12.5 );
		assert_equals(_result, 4.5, "#51 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #52", function() {

		// clamp( real const, real const , real const ): negative value
		var _result = clamp(-12.5, 0.1, 4.5);
		assert_equals(_result, 0.1, "#52 clamp( real const, real const , real const )")
	})

	addFact("clamp_test #53", function() {

		// clamp( real const, real const , real const ): negative value, min/max flipped
		var _result = clamp(-4.5, 12.5, 0.1);
		assert_equals(_result, 0.1, "#53 clamp( real const, real const , real const ) - min/max flipped")
	})

	addFact("clamp_test #54", function() {

		// clamp( real const, real const , real const ): negative value, min/max flipped
		var _result = clamp(-12.5, 4.5, 0.1);
		assert_equals(_result, 0.1, "#54 clamp( real const, real const , real const ) - min/max flipped" )
	})

	addFact("clamp_test #55", function() {

		// clamp( real const, real const , real const ): negative value, min/max negative
		var _result = clamp(-4.5, -12.5, -0.1);
		assert_equals(_result, -4.5, "#55 clamp( real const, real const , real const ) - min/max negative")
	})

	addFact("clamp_test #56", function() {

		// clamp( real const, real const , real const ): negative value, min/max flipped and negative
		var _result = clamp(-4.5, -0.1, -12.5);
		assert_equals(_result, -12.5, "#56 clamp( real const, real const , real const ) - min/max flipped and negative")
	})

	addFact("clamp_test #57", function() {

		// mixed numeric types: clamp( int local, real local , real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vInt1, _vReal2, _vReal_3);
		assert_equals(_result, _vReal_3, "#57 clamp( int local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #58", function() {

		// mixed numeric types: clamp( int local, int64 local , int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vInt1, _vInt64_2, _vInt64_3);
		assert_equals(_result, _vInt64_2, "#58 clamp( int local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #59", function() {

		// mixed numeric types: clamp( int64 local, real local , real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);

		var _result = clamp(_vInt64_1, _vReal2, _vReal_3 );
		assert_equals(_result, _vReal_3, "#59 clamp( int64 local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #60", function() {

		// mixed numeric types: clamp( int64 local, int local , int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vInt64_1, _vInt2, _vInt_3 );
		assert_equals(_result, _vInt_3, "#60 clamp( int64 local, real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #61", function() {

		// mixed numeric types: clamp( real local, int local , int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);

		var _result = clamp(_vReal1, _vInt2, _vInt_3);
		assert_equals(_result, _vInt2, "#61 clamp( real local, int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("clamp_test #62", function() {

		// mixed numeric types: clamp( real local, int64 local , int64 local ) - min/max flipped
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);

		var _result = clamp(_vReal1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#62 clamp( real local, real local , real local ) - min/max flipped")

		// Clean up
		buffer_delete(_buffer);
	})

	// COS TESTS

	addFact("cos_test #1", function() {

		// Cos (radian angle): cos(0) == 1
		var cosZero = cos(0)
		assert_equals(cosZero, 1, "#1 cos(0) equals 1")
	})

	addFact("cos_test #2", function() {

		// Cos (radian angle): cos(pi) == -1
		var cosPi = cos(pi)
		assert_equals(cosPi, -1, "#2 cos(pi) equals -1")
	})

	addFact("cos_test #3", function() {

		// Cos (radian angle): cos(2*pi) == 1
		var cosTwoPi = cos(2*pi)
		assert_equals(cosTwoPi, 1, "#3 cos(2*pi) equals 1")
	})

	addFact("cos_test #4", function() {

		// Cos (radian angle): output stays within [-1, 1] across [0, 2*pi)
		var _xPos = 0
		while (_xPos < (2*pi))
		{
			assert_less_or_equal(_xPos, (2*pi), "Ensure _xPos is always less than 2*pi")

			var _yPos = cos(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")

			_xPos += 0.01
		}
	})

	// DARCCOS TESTS

	addFact("darccos_input_range_test", function() {

		// darccos input range test
		assert_throw(function() {
			var _number = 1.1
			return darccos(_number);	
		}, "#1 Passing an out of range value to 'darccos' (should throw error)");
	})

	addFact("darccos_test #1", function() {

		// darccos: darccos(0) == 90
		var arccosZero = darccos(0)
		assert_equals(arccosZero, 90.0, "#1 darccos(0) == 90")
	})

	addFact("darccos_test #2", function() {

		// darccos: darccos(1) == 0
		var arccosOne = darccos(1)
		assert_equals(arccosOne, 0, "#2 darccos(1) == 0")
	})

	addFact("darccos_test #3", function() {

		// darccos: darccos(-1) == 180
		var arccosNegOne = darccos(-1)
		assert_equals(arccosNegOne, 180.0, "#3 darccos(-1) == 180")
	})

	addFact("darccos_test #4", function() {

		// darccos: output stays within [0, 180] across the input range [-1, 1]
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = darccos(_yPos)
			assert_greater_or_equal(_xPos, 0, "X Pos should always be greater than 0")
			assert_less_or_equal(_xPos, 180.0, "X Pos should always be less than 180")

			_yPos += 0.01
		}
	})

	// DARCSIN TESTS

	addFact("darcsin_input_range_test", function() {

		// darcsin input range test
		assert_throw(function() {
			var _number = 1.1
			return darcsin(_number);	
		}, "#1 Passing an out of range value to 'darcsin' (should throw error)");
	})

	addFact("darcsin_test #1", function() {

		// darcsin: darcsin(0) == 0
		var arcsinZero = darcsin(0)
		assert_equals(arcsinZero, 0, "#1 darcsin(0) == 0")
	})

	addFact("darcsin_test #2", function() {

		// darcsin: darcsin(1) == 90
		var arcsinOne = darcsin(1)
		assert_equals(arcsinOne, 90, "#2 darcsin(1) == 90")
	})

	addFact("darcsin_test #3", function() {

		// darcsin: darcsin(-1) == -90
		var arcsinNegOne = darcsin(-1)
		assert_equals(arcsinNegOne, (-90), "#3 darcsin(-1) == -90")
	})

	addFact("darcsin_test #4", function() {

		// darcsin: output stays within [-90, 90] across the input range [-1, 1]
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = darcsin(_yPos)
			assert_greater_or_equal(_xPos, -90, "X Pos should always be greater than -90")
			assert_less_or_equal(_xPos, 90, "X Pos should always be less than 90")

			_yPos += 0.01
		}
	})

	// DARCTAN2 TESTS

	addFact("darctan2_test #1", function() {

		// darctan2: first quadrant
		var twoOverTwo = darctan2(2, 2)
		assert_equals(twoOverTwo, 45, "#1 darctan2(2, 2) == 45deg")
	})

	addFact("darctan2_test #2", function() {

		// darctan2: second quadrant
		var twoOverNegativeTwo = darctan2(2, -2)
		assert_equals(twoOverNegativeTwo, 135, "#2 darctan2(2, -2) == 135deg")
	})

	addFact("darctan2_test #3", function() {

		// darctan2: fourth quadrant
		var negativeTwoOverTwo = darctan2(-2, 2)
		assert_equals(negativeTwoOverTwo, -45, "#3 darctan2(-2, 2) == -45deg")
	})

	addFact("darctan2_test #4", function() {

		// darctan2: third quadrant
		var negativeOverNegative = darctan2(-2, -2)
		assert_equals(negativeOverNegative, -135, "#4 darctan2(-2, -2) == -135deg")
	})

	addFact("darctan2_test #5", function() {

		// darctan2: arbitrary value
		var _res1 = darctan2(      1,    0.5)
		assert_equals(_res1,  63.4349479675293    , ("_res1 ==  63.4349 "))
	})

	addFact("darctan2_test #6", function() {

		// darctan2: arbitrary value
		var _res2 = darctan2(    0.5,   0.75)
		assert_equals(_res2,  33.6900672912598    , ("_res2 ==  33.6901 "))
	})

	addFact("darctan2_test #7", function() {

		// darctan2: arbitrary value
		var _res3 = darctan2(    0.4,  -0.66)
		assert_equals(_res3,  148.781600952148    , ("_res3 ==  148.782 "))
	})

	addFact("darctan2_test #8", function() {

		// darctan2: arbitrary value
		var _res4 = darctan2(    0.4,   0.66)
		assert_equals(_res4,  31.2184009552002    , ("_res4 ==  31.2184 "))
	})

	addFact("darctan2_test #9", function() {

		// darctan2: arbitrary value
		var _res5 = darctan2(    0.9,    0.1)
		assert_equals(_res5,  83.6598052978516    , ("_res5 ==  83.6598 "))
	})

	addFact("darctan2_test #10", function() {

		// darctan2: arbitrary value
		var _res6 = darctan2(    0.3,   0.75)
		assert_equals(_res6,  21.8014087677002    , ("_res6 ==  21.8014 "))
	})

	addFact("darctan2_test #11", function() {

		// darctan2: arbitrary value
		var _res7 = darctan2( -0.123, -0.456)
		assert_equals(_res7,  -164.90447          , ("_res7 == -164.904 "))
	})

	addFact("darctan2_test #12", function() {

		// darctan2: arbitrary value
		var _res8 = darctan2( -0.789,  0.123)
		assert_equals(_res8,  -81.1392822265625   , ("_res8 == -81.1393 "))
	})

	// DARCTAN TESTS

	addFact("darctan_test #1", function() {

		// darctan: darctan(0) == 0
		var atanZero = darctan(0)
		assert_equals(atanZero, 0, "#1 darctan(0) == 0")
	})

	addFact("darctan_test #2", function() {

		// darctan: darctan(1) == 45
		var atanOne = darctan(1)
		assert_equals(atanOne, 45, "#2 darctan(1) == 45")
	})

	addFact("darctan_test #3", function() {

		// darctan: darctan(-1) == -45
		var atanNegOne = darctan(-1)
		assert_equals(atanNegOne, -45, "#3 darctan(-1) == -45")
	})

	addFact("darctan_test #4", function() {

		// darctan: output stays within [-90, 90] across the input range [-1, 1]
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")

			var _xPos = darctan(_yPos)
			assert_greater_or_equal(_xPos, -90, "X Pos should always be greater than -90")
			assert_less_or_equal(_xPos, 90, "X Pos should always be less than 90")

			_yPos += 0.01
		}
	})

	// DCOS TESTS

	#macro upper_limit_DcosTest (360.0)

	addFact("dcos_test #1", function() {

		// dcos (degree angle): dcos(0) == 1
		var dcos0 = dcos(0)
		assert_equals(dcos0, 1, "#1 dcos(0) equals 1")
	})

	addFact("dcos_test #2", function() {

		// dcos (degree angle): dcos(180) == -1
		var dcosPi = dcos(180.0)
		assert_equals(dcosPi, -1, "#2 dcos(pi) equals -1")
	})

	addFact("dcos_test #3", function() {

		// dcos (degree angle): dcos(360) == 1
		var dcos2Pi = dcos(360.0)
		assert_equals(dcos2Pi, 1, "#3 dcos(2*pi) equals 1")
	})

	addFact("dcos_test #4", function() {

		// dcos (degree angle): output stays within [-1, 1] across [0, 360)
		var _xPos = 0
		while (_xPos < upper_limit_DcosTest)
		{
			assert_less_or_equal(_xPos, upper_limit_DcosTest, "Ensure _xPos is always less than 360")

			var _yPos = dcos(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")

			_xPos += 0.5
		}
	})

	// DEGTORAD TESTS

	addFact("degtorad_test #1", function() {

		// degtorad( real const ): degtorad(0) == 0
		var zero = degtorad(0)
		assert_equals(zero, 0.0, "0 rad == 0 deg")
	})

	addFact("degtorad_test #2", function() {

		// degtorad( real const ): degtorad(180) == pi
		var piTest = degtorad(180)
		assert_equals(piTest, pi, "Pi rad == 180 deg")
	})

	addFact("degtorad_test #3", function() {

		// degtorad( real const ): degtorad(90) == pi/2
		var pi_2 = degtorad(90)
		assert_equals(pi_2, (pi/2), "Pi/2 rad == 90 deg")
	})

	addFact("degtorad_test #4", function() {

		// degtorad( real const ): degtorad(45) == pi/4
		var pi_4 = degtorad(45)
		assert_equals(pi_4, (pi/4), "Pi/4 rad == 45 deg")
	})

	addFact("degtorad_test #5", function() {

		// degtorad( real const ): degtorad(360) == pi*2
		var pi_by_2 = degtorad(360)
		assert_equals(pi_by_2, (pi*2), "2*Pi rad == 360 deg")
	})

	addFact("degtorad_test #6", function() {

		// degtorad( real local ): degtorad(0) == 0
		var zero_deg = 0
		var zero_rad = degtorad(zero_deg)
		assert_equals(zero_rad, 0.0, "0 rad == 0 deg")
	})

	addFact("degtorad_test #7", function() {

		// degtorad( real local ): degtorad(180) == pi
		var oneEighty = 180
		var piTest_rad = degtorad(oneEighty)
		assert_equals(piTest_rad, pi, "Pi rad == 180 deg")
	})

	addFact("degtorad_test #8", function() {

		// degtorad( real local ): degtorad(90) == pi/2
		var ninety = 90
		var pi_2_rad = degtorad(ninety)
		assert_equals(pi_2_rad, (pi/2), "Pi/2 rad == 90 deg")
	})

	addFact("degtorad_test #9", function() {

		// degtorad( real local ): degtorad(45) == pi/4
		var fortyFive = 45
		var pi_4_rad = degtorad(fortyFive)
		assert_equals(pi_4_rad, (pi/4), "Pi/4 rad == 45 deg")
	})

	addFact("degtorad_test #10", function() {

		// degtorad( real local ): degtorad(360) == pi*2
		var threeSixty = 360
		var pi_by_2_rad = degtorad(threeSixty)
		assert_equals(pi_by_2_rad, (pi*2), "2*Pi rad == 360 deg")
	})

	// DOT_PRODUCT_3D_NORMALISED TESTS

	addFact("dot_product_3d_normalised_test #1", function() {

		// dot_product_3d_normalised: two zero vectors
		var res0 = dot_product_3d_normalised(0, 0, 0, 0, 0, 0)
		assert_true(is_nan(res0), "#0 Normalised Dot product of two zero vectors is NaN");
	})

	addFact("dot_product_3d_normalised_test #2", function() {

		// dot_product_3d_normalised: perpendicular vectors
		var _res1 = dot_product_3d_normalised(0.5, 0.5, 0.0, -0.5, 0.5, 1.0)
		assert_equals(_res1, 0.0, "#1 Normalised Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_normalised_test #3", function() {

		// dot_product_3d_normalised: perpendicular vectors
		var _res2 = dot_product_3d_normalised(3.0, 1.0, 0.0, 1.0, -3.0, 0.0)
		assert_equals(_res2, 0.0, "#2 Normalised Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_normalised_test #4", function() {

		// dot_product_3d_normalised: (2, 3, 4) and (-3, -1, 5)
		var _res3 = dot_product_3d_normalised(2.0, 3.0, 4.0, -3.0, -1.0, 5.0)
		assert_equals(_res3, 0.345270651315, "#3 Normalised Dot product of (2, 3, 4) and (-3, -1, 5) is 0.345270651315")
	})

	addFact("dot_product_3d_normalised_test #5", function() {

		// dot_product_3d_normalised: (2, 3, 4) and (-3, -1, -5)
		var _res4 = dot_product_3d_normalised(2.0, 3.0, 4.0, -3.0, -1.0, -5.0)
		assert_equals(_res4, -0.910258989832, "#4 Normalised Dot Product is (2.0, 3.0, 4.0) and (-3.0, -1.0, -5.0) is -0.910258989832")
	})

	addFact("dot_product_3d_normalised_test #6", function() {

		// dot_product_3d_normalised: (1, 2, 3) and (4, 5, 6)
		var _res5 = dot_product_3d_normalised(1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
		assert_equals(_res5, 0.974631786346, "#5 Normalised Dot Product is (1.0, 2.0, 3.0) and (4.0, 5.0, 6.0) is 0.9836991")
	})

	addFact("dot_product_3d_normalised_test #7", function() {

		// dot_product_3d_normalised: (1, 2, 3) and (-4, -5, -6)
		var _res6 = dot_product_3d_normalised(1.0, 2.0, 3.0, -4.0, -5.0, -6.0)
		assert_equals(_res6, -0.974631786346, "#6 Normalised Dot Product is (1.0, 2.0, 3.0) and (-4.0, -5.0, -6.0) is -0.9836991")
	})

	addFact("dot_product_3d_normalised_test #8", function() {

		// Normalised Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, z1, x2, y2, z2;
		x1 = 1.5
		y1 = 1.5
		z1 = 2.0
		x2 = 1.5
		y2 = -1.2
		z2 = 2.0
		var resPos = dot_product_3d_normalised(x1, y1, z1, x2, y2, z2)
		assert_greater(resPos, 0, "#5 dot product normalised must be positive")
	})

	addFact("dot_product_3d_normalised_test #9", function() {

		// Normalised Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, z3, x4, y4, z4;
		x3 = 1.5
		y3 = 1.5
		z3 = 2.0
		x4 = 1.5
		y4 = -1.8
		z4 = -2.0
		var resNeg = dot_product_3d_normalised(x3, y3, z3, x4, y4, z4)
		assert_less(resNeg, 0, "#6 dot product normalised must be negative")
	})

	addFact("dot_product_3d_normalised_test #10", function() {

		// S vs Z: (1, 2, 3) and (4, 5, 6)
		var sx1, sy1, sz1, sx2, sy2, sz2;
		sx1 = 1
		sy1 = 2
		sz1 = 3
		sx2 = 4
		sy2 = 5
		sz2 = 6
		var sres1 = dot_product_3d_normalised(sx1, sy1, sz1, sx2, sy2, sz2)
		var zres1 = dot_product_3d_normalized(sx1, sy1, sz1, sx2, sy2, sz2)
		assert_equals(sres1, zres1, "S and Z methods should match")
	})

	addFact("dot_product_3d_normalised_test #11", function() {

		// S vs Z: (7, 8, 9) and (10, 11, 12)
		var sx3, sy3, sz3, sx4, sy4, sz4;
		sx3 = 7
		sy3 = 8
		sz3 = 9
		sx4 = 10
		sy4 = 11
		sz4 = 12
		var sres2 = dot_product_3d_normalised(sx3, sy3, sz3, sx4, sy4, sz4)
		var zres2 = dot_product_3d_normalized(sx3, sy3, sz3, sx4, sy4, sz4)
		assert_equals(sres2, zres2, "S and Z methods should match")
	})

	addFact("dot_product_3d_normalised_test #12", function() {

		// S vs Z: (13, 14, 15) and (16, 17, 18)
		var sx5, sy5, sz5, sx6, sy6, sz6;
		sx5 = 13
		sy5 = 14
		sz5 = 15
		sx6 = 16
		sy6 = 17
		sz6 = 18
		var sres3 = dot_product_3d_normalised(sx5, sy5, sz5, sx6, sy6, sz6)
		var zres3 = dot_product_3d_normalized(sx5, sy5, sz5, sx6, sy6, sz6)
		assert_equals(sres3, zres3, "S and Z methods should match")
	})

	// DOT_PRODUCT_3D TESTS

	addFact("dot_product_3d_test #1", function() {

		// dot_product_3d (2D inputs): two zero vectors
		var res0 = dot_product_3d(0, 0, 0, 0, 0, 0)
		assert_equals(res0, 0.0, "#0 Dot product of two zero vectors is 0")
	})

	addFact("dot_product_3d_test #2", function() {

		// dot_product_3d (2D inputs): perpendicular vectors
		var _res1 = dot_product_3d(0.5, 0.5, 0, -0.5, 0.5, 0)
		assert_equals(_res1, 0.0, "#1 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_test #3", function() {

		// dot_product_3d (2D inputs): perpendicular vectors
		var _res2 = dot_product_3d(3, 1, 0, 1, -3, 0)
		assert_equals(_res2, 0.0, "#2 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_test #4", function() {

		// dot_product_3d (2D inputs): (2, 3, 0) and (-3, -1, 0)
		var _res3 = dot_product_3d(2, 3, 0, -3, -1, 0)
		assert_equals(_res3, -9.0, "#3 Dot product of (2,3, 0) and (-3, -1, 0) is -9")
	})

	addFact("dot_product_3d_test #5", function() {

		// dot_product_3d (2D inputs): (1, 1, 0) and (0.5, 0.5, 0)
		var _res4 = dot_product_3d(1.0, 1.0, 0.0, 0.5, 0.5, 0.0)
		assert_equals(_res4, 1.0, "#4 Dot Product is (1, 1, 0) and (0.5, 0.5, 0.0) is 1")
	})

	addFact("dot_product_3d_test #6", function() {

		// dot_product_3d (3D inputs): perpendicular vectors
		var _res5 = dot_product_3d(0, 0, 1, -1, 1, 0)
		assert_equals(_res5, 0.0, "#1 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_test #7", function() {

		// dot_product_3d (3D inputs): perpendicular vectors
		var _res6 = dot_product_3d(1, 1, 0, 0, 0, -1)
		assert_equals(_res6, 0.0, "#1 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_3d_test #8", function() {

		// dot_product_3d (3D inputs): (3, 1, -8) and (1, -3, -4)
		var _res7 = dot_product_3d(3, 1, -8, 1, -3, -4)
		assert_equals(_res7, 32.0, "#2 Dot product of (3, 1, -8) and (1, -3, -4) is 0")
	})

	addFact("dot_product_3d_test #9", function() {

		// dot_product_3d (3D inputs): (7, 7, 7) and (1, 2, 3)
		var _res8 = dot_product_3d(7, 7, 7, 1, 2, 3)
		assert_equals(_res8, 42.0, "#3 Dot product of (7, 7, 7) and (1, 2, 3) is 42")
	})

	addFact("dot_product_3d_test #10", function() {

		// dot_product_3d (3D inputs): (0.6, 0.5, -5.0) and (-0.5, 0.5, 1.0)
		var _res9 = dot_product_3d(0.6, 0.5, -5.0, -0.5, 0.5, 1.0)
		assert_equals(_res9, -5.05, "#4 Dot Product is (0.6, 0.5, 0.0) and (-0.5, 0.5, 0.0) is -0.05")
	})

	addFact("dot_product_3d_test #11", function() {

		// Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, z1, x2, y2, z2;
		x1 = 0.5
		y1 = 0.5
		z1 = 0.0
		x2 = 0.5
		y2 = -0.4
		z2 = 0.0
		var resPos = dot_product_3d(x1, y1, z1, x2, y2, z2)
		assert_greater(resPos, 0, "#5 dot product must be positive")
	})

	addFact("dot_product_3d_test #12", function() {

		// Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, z3, x4, y4, z4;
		x3 = 0.5
		y3 = 0.5
		z3 = 0.0
		x4 = 0.5
		y4 = -0.6
		z4 = 0.0
		var resNeg = dot_product_3d(x3, y3, z3, x4, y4, z4)
		assert_less(resNeg, 0, "#6")
	})

	// DOT_PRODUCT_NORMALISED TESTS

	addFact("dot_product_normalised_test #1", function() {

		// dot_product_normalised: two zero vectors
		var res0 = dot_product_normalised(0, 0, 0, 0)
		assert_true(is_nan(res0), "#0 Normalised Dot product of two zero vectors is NaN")
	})

	addFact("dot_product_normalised_test #2", function() {

		// dot_product_normalised: perpendicular vectors
		var _res1 = dot_product_normalised(0.5, 0.5, -0.5, 0.5)
		assert_equals(_res1, 0.0, "#1 Normalised Dot product of two perpendicular is 0")
	})

	addFact("dot_product_normalised_test #3", function() {

		// dot_product_normalised: perpendicular vectors
		var _res2 = dot_product_normalised(3, 1, 1, -3)
		assert_equals(_res2, 0.0, "#2 Normalised Dot product of two perpendicular is 0")
	})

	addFact("dot_product_normalised_test #4", function() {

		// dot_product_normalised: (2, 3) and (-3, -1)
		var _res3 = dot_product_normalised(2, 3, -3, -1)
		assert_equals(_res3, -0.789352238178, "#3 Normalised Dot product of (2,3) and (-3, -1) is -0.79")
	})

	addFact("dot_product_normalised_test #5", function() {

		// dot_product_normalised: (1, 1) and (0.5, 0.5)
		var _res4 = dot_product_normalised(1.0, 1.0, 0.5, 0.5)
		assert_equals(_res4, 1.0, "#4 Normalised Dot Product is (1, 1) and (0.5, 0.5) is 1")
	})

	addFact("dot_product_normalised_test #6", function() {

		// dot_product_normalised: (1, 2) and (3, 4)
		var _res5 = dot_product_normalised(1.0, 2.0, 3.0, 4.0)
		assert_equals(_res5, 0.983869910240, "#5 Normalised Dot Product is (1, 2) and (3, 4) is 0.9836991")
	})

	addFact("dot_product_normalised_test #7", function() {

		// dot_product_normalised: (1, 2) and (-3, -4)
		var _res6 = dot_product_normalised(1.0, 2.0, -3.0, -4.0)
		assert_equals(_res6, -0.983869910240, "#5 Normalised Dot Product is (1, 2) and (-3, -4) is -0.9836991")
	})

	addFact("dot_product_normalised_test #8", function() {

		// Normalised Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, x2, y2;
		x1 = 1.5
		y1 = 1.5
		x2 = 1.5
		y2 = -1.2
		var resPos = dot_product_normalised(x1, y1, x2, y2)
		assert_greater(resPos, 0, "#5 dot product normalised must be positive")
	})

	addFact("dot_product_normalised_test #9", function() {

		// Normalised Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, x4, y4;
		x3 = 1.5
		y3 = 1.5
		x4 = 1.5
		y4 = -1.8
		var resNeg = dot_product_normalised(x3, y3, x4, y4)
		assert_less(resNeg, 0, "#6 dot product normalised must be negative")
	})

	addFact("dot_product_normalised_test #10", function() {

		// S vs Z: (1, 2) and (3, 4)
		var sx1, sy1, sx2, sy2;
		sx1 = 1
		sy1 = 2
		sx2 = 3
		sy2 = 4
		var sres1 = dot_product_normalised(sx1, sy1, sx2, sy2)
		var zres1 = dot_product_normalized(sx1, sy1, sx2, sy2)
		assert_equals(sres1, zres1, "S and Z methods should match")
	})

	addFact("dot_product_normalised_test #11", function() {

		// S vs Z: (5, 6) and (7, 8)
		var sx3, sy3, sx4, sy4;
		sx3 = 5
		sy3 = 6
		sx4 = 7
		sy4 = 8
		var sres2 = dot_product_normalised(sx3, sy3, sx4, sy4)
		var zres2 = dot_product_normalized(sx3, sy3, sx4, sy4)
		assert_equals(sres2, zres2, "S and Z methods should match")
	})

	addFact("dot_product_normalised_test #12", function() {

		// S vs Z: (8, 9) and (10, 11)
		var sx5, sy5, sx6, sy6;
		sx5 = 8
		sy5 = 9
		sx6 = 10
		sy6 = 11
		var sres3 = dot_product_normalised(sx5, sy5, sx6, sy6)
		var zres3 = dot_product_normalized(sx5, sy5, sx6, sy6)
		assert_equals(sres3, zres3, "S and Z methods should match")
	})

	// DOT_PRODUCT TESTS

	addFact("dot_product_test #1", function() {

		// dot_product: two zero vectors
		var res0 = dot_product(0, 0, 0, 0)
		assert_equals(res0, 0.0, "#0 Dot product of two zero vectors is 0")
	})

	addFact("dot_product_test #2", function() {

		// dot_product: perpendicular vectors
		var _res1 = dot_product(0.5, 0.5, -0.5, 0.5)
		assert_equals(_res1, 0.0, "#1 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_test #3", function() {

		// dot_product: perpendicular vectors
		var _res2 = dot_product(3, 1, 1, -3)
		assert_equals(_res2, 0.0, "#2 Dot product of two perpendicular is 0")
	})

	addFact("dot_product_test #4", function() {

		// dot_product: (2, 3) and (-3, -1)
		var _res3 = dot_product(2, 3, -3, -1)
		assert_equals(_res3, -9.0, "#3 Dot product of (2,3) and (-3, -1) is -9")
	})

	addFact("dot_product_test #5", function() {

		// dot_product: (1, 1) and (0.5, 0.5)
		var _res4 = dot_product(1.0, 1.0, 0.5, 0.5)
		assert_equals(_res4, 1.0, "#4 Dot Product is (1, 1) and (0.5, 0.5) is 1")
	})

	addFact("dot_product_test #6", function() {

		// Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, x2, y2;
		x1 = 0.5
		y1 = 0.5
		x2 = 0.5
		y2 = -0.4
		var _res5 = dot_product(x1, y1, x2, y2)
		assert_greater(_res5, 0, "#5 dot product must be positive")
	})

	addFact("dot_product_test #7", function() {

		// Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, x4, y4;
		x3 = 0.5
		y3 = 0.5
		x4 = 0.5
		y4 = -0.6
		var _res6 = dot_product(x3, y3, x4, y4)
		assert_less(_res6, 0, "#6")
	})

	// DSIN TESTS

	#macro upper_limit_DsinTest 360.0

	addFact("dsin_test #1", function() {

		// dsin (degree angle): dsin(0) == 0
		var sin0 = dsin(0)
		assert_equals(sin0, 0, "#1 dsin(0) equals zero")
	})

	addFact("dsin_test #2", function() {

		// dsin (degree angle): dsin(180) == 0
		var sinPi = dsin(180.0)
		assert_equals(sinPi, 0, "#2 dsin(pi) equals zero")
	})

	addFact("dsin_test #3", function() {

		// dsin (degree angle): dsin(360) == 0
		var sin2Pi = dsin(360.0)
		assert_equals(sin2Pi, 0, "#3 dsin(2*pi) equals zero")
	})

	addFact("dsin_test #4", function() {

		// dsin (degree angle): output stays within [-1, 1] across [0, 360)
		var _xPos = 0
		while (_xPos < (upper_limit_DsinTest))
		{
			assert_less_or_equal(_xPos, (upper_limit_DsinTest), "Ensure _xPos is always less than 360")

			var _yPos = dsin(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")

			_xPos += 0.5
		}
	})

	// DTAN TESTS

	addFact("dtan_test #1", function() {

		// dtan (degree angle): dtan(0) == 0
		var dtan0 = dtan(0)
		assert_equals(dtan0, 0, "#1 Tan Zero == 0")
	})

	addFact("dtan_test #2", function() {

		// dtan (degree angle): dtan(180) == 0
		var dtanPi = dtan(180)
		assert_equals(dtanPi, 0, "#2 Tan 180 == 0")
	})

	addFact("dtan_test #3", function() {

		// dtan (degree angle): dtan(360) == 0
		var dtan2Pi = dtan(360)
		assert_equals(dtan2Pi, 0, "#3 Tan 360 == 0")
	})

	addFact("dtan_test #4", function() {

		// dtan (degree angle): dtan(45) == 1
		var tanFortyFiveDeg = dtan(45.0)
		assert_equals(tanFortyFiveDeg, 1.0, "#4 Tan 45 == 1")
	})

	addFact("dtan_test #5", function() {

		// dtan (degree angle): dtan(225) == 1
		var tanTwoTwoFiveDeg = dtan(225.0)
		assert_equals(tanTwoTwoFiveDeg, 1.0, "#5 Tan 225 == 1")
	})

	addFact("dtan_test #6", function() {

		// dtan (degree angle): dtan(135) == -1
		var tanOneThirtyFiveDeg = dtan(135.0)
		assert_equals(tanOneThirtyFiveDeg, -1, "#6 Tan 135 == -1")
	})

	addFact("dtan_test #7", function() {

		// dtan (degree angle): dtan(315) == -1
		var tanThreeFifteenDeg = dtan(315.0)
		assert_equals(tanThreeFifteenDeg, -1, "#7 Tan 315 == -1")
	})

	// EXP TESTS

	addFact("exp_test #1", function() {

		// exp( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = exp(_vReal);
		assert_equals(_result, 12.1824939607, "#1 exp( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #2", function() {

		// exp( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = exp(_vInt);
		assert_equals(_result, 22026.4657948067, "#2 exp( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #3", function() {

		// exp( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = exp(_vInt64);
		assert_equals(_result, 54.5981500331, "#3 exp( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #4", function() {

		// exp( real const )
		var _result = exp(2.5);
		assert_equals(_result, 12.1824939607, "#4 exp( real const )")
	})

	addFact("exp_test #5", function() {

		// exp( int const )
		var _result = exp(10);
		assert_equals(_result, 22026.4657948067, "#5 exp( int const )")
	})

	addFact("exp_test #6", function() {

		// exp( int64 const )
		var _result = exp(int64(4));
		assert_equals(_result, 54.5981500331, "#6 exp( int64 const )")
	})

	addFact("exp_test #7", function() {

		// negative value: exp( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = exp(-_vReal);
		assert_equals(_result, 0.08208499862, "#7 exp( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #8", function() {

		// negative value: exp( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = exp(-_vInt);
		assert_equals(_result, 0.00004539992, "#8 exp( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #9", function() {

		// negative value: exp( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = exp(-_vInt64);
		assert_equals(_result, 0.01831563888, "#9 exp( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("exp_test #10", function() {

		// negative value: exp( real const )
		var _result = exp(-2.5);
		assert_equals(_result, 0.08208499862, "#10 exp( real const )")
	})

	addFact("exp_test #11", function() {

		// negative value: exp( int const )
		var _result = exp(-10);
		assert_equals(_result, 0.00004539992, "#11 exp( int const )")
	})

	addFact("exp_test #12", function() {

		// negative value: exp( int64 const )
		var _result = exp(int64(-4));
		assert_equals(_result, 0.01831563888, "#12 exp( int64 const )")
	})

	addFact("exp_test #13", function() {

		// zero test
		var _result = exp(0);
		assert_equals(_result, 1, "#13 exp( 0 )")
	})

	addFact("exp_test #14", function() {

		// one test
		var _result = exp(1);
		assert_equals(_result, 2.71828182845905, "#14 exp( 1 )")
	})

	addFact("exp_test #15", function() {

		// infinity test
		var _infinity = infinity;

		var _result = exp(_infinity);
		assert_true(is_infinity(_result), "#15 exp( infinity )")
	})

	addFact("exp_test #16", function() {

		// NaN test
		var _nan = NaN;

		var _result = exp(_nan);
		assert_true(is_nan(_result), "#16 exp( NaN )")
	})

	// FLOOR TESTS

	addFact("floor_test #1", function() {

		// Floor: positive and negative variables
		var numOne = 2.3;
		var numTwo = 3.8;
		var negOne = -2.3;
		var negTwo = -3.8;

		var resOne = floor(numOne);
		var resTwo = floor(numTwo);
		var resNegOne = floor(negOne);
		var resNegTwo = floor(negTwo);

		assert_equals(resOne, 2.0, "#1 Positive");
		assert_equals(resTwo, 3.0, "#2 Positive");
		assert_equals(resNegOne, -3.0, "#1 Negative");
		assert_equals(resNegTwo, -4.0, "#2 Negative");
	})

	addFact("floor_test #2", function() {

		// Floor: literal values
		assert_equals(floor(7.7), 7.0, "#1 Local Positive");
		assert_equals(floor(0.3), 0.0, "#2 Local Positive");
		assert_equals(floor(-4.4), -5.0, "#1 Local Negative");
		assert_equals(floor(-6.6), -7.0, "#2 Local Negative");
	})

	// FRAC TESTS

	addFact("frac_test #1", function() {

		// Positive tests: frac(3.125)
		var numOne = 3.125

		var fracOne = frac(numOne)
		assert_equals(fracOne, 0.125, "#1 fracOne = 0.125")
	})

	addFact("frac_test #2", function() {

		// Positive tests: frac(6.921)
		var numTwo = 6.921

		var fracTwo = frac(numTwo)
		assert_equals(fracTwo, 0.921, "#2 fracTwo = 0.921")
	})

	addFact("frac_test #3", function() {

		// Positive tests: frac(3.4)
		var numThree = 3.4

		var fracThree = frac(numThree)
		assert_equals(fracThree, 0.4, "#3 fracThree = 0.4")
	})

	addFact("frac_test #4", function() {

		// Negative tests: frac(-3.125)
		var negativeOne = -3.125

		var negativeFracOne = frac(negativeOne)
		assert_equals(negativeFracOne, -0.125, "#1 negativeFracOne = -0.125")
	})

	addFact("frac_test #5", function() {

		// Negative tests: frac(-6.921)
		var negativeTwo = -6.921

		var negativeFracTwo = frac(negativeTwo)
		assert_equals(negativeFracTwo, -0.921, "#2 negativeFracTwo = -0.921")
	})

	addFact("frac_test #6", function() {

		// Negative tests: frac(-3.4)
		var negativeThree = -3.4

		var negativeFracThree = frac(negativeThree)
		assert_equals(negativeFracThree, -0.4, "#3 negativeFracThree = -0.4")
	})

	addFact("frac_test #7", function() {

		// Whole numbers: frac(1.0)
		var wholeNumOne = 1.0

		var wholeFracOne = frac(wholeNumOne)
		assert_equals(wholeFracOne, 0, "#1 Whole number frac() = zero")
	})

	addFact("frac_test #8", function() {

		// Whole numbers: frac(55.0)
		var wholeNumTwo = 55.0

		var wholeFracTwo = frac(wholeNumTwo)
		assert_equals(wholeFracTwo, 0, "#2 Whole number frac() = zero")
	})

	addFact("frac_test #9", function() {

		// Whole numbers: frac(0.0)
		var wholeNumThree = 0.0

		var wholeFracThree = frac(wholeNumThree)
		assert_equals(wholeFracThree, 0, "#3 Whole number frac() = zero")
	})

	addFact("frac_test #10", function() {

		// Whole numbers: frac(28)
		var wholeNumFour = 28

		var wholeFracFour = frac(wholeNumFour)
		assert_equals(wholeFracFour, 0, "#4 Whole number frac() = zero")
	})

	addFact("frac_test #11", function() {

		// Whole numbers: frac(-44)
		var wholeNumFive = -44

		var wholeFracFive = frac(wholeNumFive)
		assert_equals(wholeFracFive, 0, "#5 Whole number frac() = zero")
	})

	addFact("frac_test #12", function() {

		// Literals: frac(0.0)
		assert_equals(frac(0.0), 0, "#1 Literal zero")
	})

	addFact("frac_test #13", function() {

		// Literals: frac(654.0)
		assert_equals(frac(654.0), 0, "#2 Literal whole number")
	})

	addFact("frac_test #14", function() {

		// Literals: frac(-654.0)
		assert_equals(frac(-654.0), 0, "#3 Literal whole negative number")
	})

	addFact("frac_test #15", function() {

		// Literals: frac(123.456)
		assert_equals(frac(123.456), 0.456, "#4 Literal positive number")
	})

	addFact("frac_test #16", function() {

		// Literals: frac(-123.456)
		assert_equals(frac(-123.456), -0.456, "#5 Literal negative number")
	})

	// LENGTHDIR_X TESTS

	addFact("lengthdir_x_test #1", function() {

		// lengthdir_x: no angle inputted
		math_set_epsilon(0.001);

		var _res1 = lengthdir_x(2, 0)
		assert_equals(_res1, 2, "_res1 == 2, no angle inputted")
	})

	addFact("lengthdir_x_test #2", function() {

		// lengthdir_x: angle is perpendicular
		math_set_epsilon(0.001);

		var _res2 = lengthdir_x(2, 90)
		assert_equals(_res2, 0, "_res2 == 0, angle is perpendicular")
	})

	addFact("lengthdir_x_test #3", function() {

		// lengthdir_x: unit circle matches dcos across [0, 360]
		math_set_epsilon(0.001);

		var dAngle = 0.0
		while (dAngle <= 360.0)
		{
			var _xPos = dcos(dAngle);
			var lengthDirX = lengthdir_x(1, dAngle)

			assert_equals(_xPos, lengthDirX, "Unit Circle Test At Angle " + string(dAngle))

			dAngle += 0.5
		}
	})

	// LENGTHDIR_Y TESTS

	addFact("lengthdir_y_test #1", function() {

		// lengthdir_y: no angle inputted
		math_set_epsilon(0.001);

		var _res1 = lengthdir_y(2, 0)
		assert_equals(_res1, 0, "_res1 == 0, no angle inputted")
	})

	addFact("lengthdir_y_test #2", function() {

		// lengthdir_y: unit circle matches -dsin across [0, 360]
		math_set_epsilon(0.001);

		var dAngle = 0.0
		while (dAngle <= 360.0)
		{
			// Inverted to match the gamemaker world space where Y up is negative.
			var _yPos = -(dsin(dAngle));
			var lengthDirY = lengthdir_y(1, dAngle)

			assert_equals(_yPos, lengthDirY, "Unit Circle Test At Angle " + string(dAngle))

			dAngle += 0.5
		}
	})

	// LERP TESTS

	addFact("lerp_test #1", function() {

		// lerp( real local, real local , real local ): quarter
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _lerpQuarter = 0.25;

		var _result = lerp( _vReal1, _vReal2, _lerpQuarter );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * 0.25;
		assert_equals(_result, _expected, "#1 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #2", function() {

		// lerp( real local, real local , real local ): half
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _lerpHalf = 0.5;

		var _result = lerp( _vReal1, _vReal2, _lerpHalf );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * 0.5;
		assert_equals(_result, _expected, "#2 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #3", function() {

		// lerp( real local, real local , real local ): three quarters
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _lerpThreeQuarters = 0.75;

		var _result = lerp( _vReal1, _vReal2, _lerpThreeQuarters );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * 0.75;
		assert_equals(_result, _expected, "#3 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #4", function() {

		// lerp( real local, real local , real local ): amount 0
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _result = lerp( _vReal1, _vReal2, 0 );
		assert_equals(_result, _vReal1, "#4 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #5", function() {

		// lerp( real local, real local , real local ): amount 1
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _result = lerp( _vReal1, _vReal2, 1 );
		assert_equals(_result, _vReal2, "#5 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #6", function() {

		// lerp( real local, real local , real local ): amount -1, extrapolating below
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _result = lerp( _vReal1, _vReal2, -1 );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * -1;
		assert_equals(_result, _expected, "#6 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #7", function() {

		// lerp( real local, real local , real local ): amount 2, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _result = lerp( _vReal1, _vReal2, 2 );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * 2;
		assert_equals(_result, _expected, "#7 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #8", function() {

		// lerp( real local, real local , real local ): amount 1.1, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vReal1 = buffer_read(_buff, buffer_f32);
		var _vReal2 = buffer_read(_buff, buffer_f32);

		var _result = lerp( _vReal1, _vReal2, 1.1 );
		var _expected = _vReal1 + (_vReal2 - _vReal1) * 1.1;
		assert_equals(_result, _expected, "#8 lerp( real local, real local , real local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #9", function() {

		// lerp( int local, int local , int local ): quarter
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _lerpQuarter = 0.25;

		var _result = lerp( _vInt1, _vInt2, _lerpQuarter );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * 0.25;
		assert_equals(_result, _expected, "#9 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #10", function() {

		// lerp( int local, int local , int local ): half
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _lerpHalf = 0.5;

		var _result = lerp( _vInt1, _vInt2, _lerpHalf );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * 0.5;
		assert_equals(_result, _expected, "#10 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #11", function() {

		// lerp( int local, int local , int local ): three quarters
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _lerpThreeQuarters = 0.75;

		var _result = lerp( _vInt1, _vInt2, _lerpThreeQuarters );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * 0.75;
		assert_equals(_result, _expected, "#11 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #12", function() {

		// lerp( int local, int local , int local ): amount 0
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _result = lerp( _vInt1, _vInt2, 0 );
		assert_equals(_result, _vInt1, "#12 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #13", function() {

		// lerp( int local, int local , int local ): amount 1
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _result = lerp( _vInt1, _vInt2, 1 );
		assert_equals(_result, _vInt2, "#13 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #14", function() {

		// lerp( int local, int local , int local ): amount -1, extrapolating below
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _result = lerp( _vInt1, _vInt2, -1 );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * -1;
		assert_equals(_result, _expected, "#14 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #15", function() {

		// lerp( int local, int local , int local ): amount 2, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _result = lerp( _vInt1, _vInt2, 2 );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * 2;
		assert_equals(_result, _expected, "#15 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #16", function() {

		// lerp( int local, int local , int local ): amount 1.1, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt1 = buffer_read(_buff, buffer_s32);
		var _vInt2 = buffer_read(_buff, buffer_s32);

		var _result = lerp( _vInt1, _vInt2, 1.1 );
		var _expected = _vInt1 + (_vInt2 - _vInt1) * 1.1;
		assert_equals(_result, _expected, "#16 lerp( int local, int local , int local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #17", function() {

		// lerp( int64 local, int64 local , int64 local ): quarter
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _lerpQuarter = 0.25;

		var _result = lerp( _vInt64_1, _vInt64_2, _lerpQuarter );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.25;
		assert_equals(_result, _expected, "#17 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #18", function() {

		// lerp( int64 local, int64 local , int64 local ): half
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _lerpHalf = 0.5;

		var _result = lerp( _vInt64_1, _vInt64_2, _lerpHalf );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.5;
		assert_equals(_result, _expected, "#18 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #19", function() {

		// lerp( int64 local, int64 local , int64 local ): three quarters
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _lerpThreeQuarters = 0.75;

		var _result = lerp( _vInt64_1, _vInt64_2, _lerpThreeQuarters );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.75;
		assert_equals(_result, _expected, "#19 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #20", function() {

		// lerp( int64 local, int64 local , int64 local ): amount 0
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _result = lerp( _vInt64_1, _vInt64_2, 0 );
		assert_equals(_result, _vInt64_1, "#20 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #21", function() {

		// lerp( int64 local, int64 local , int64 local ): amount 1
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _result = lerp( _vInt64_1, _vInt64_2, 1 );
		assert_equals(_result, _vInt64_2, "#21 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #22", function() {

		// lerp( int64 local, int64 local , int64 local ): amount -1, extrapolating below
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _result = lerp( _vInt64_1, _vInt64_2, -1 );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * -1;
		assert_equals(_result, _expected, "#22 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #23", function() {

		// lerp( int64 local, int64 local , int64 local ): amount 2, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _result = lerp( _vInt64_1, _vInt64_2, 2 );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 2;
		assert_equals(_result, _expected, "#23 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	addFact("lerp_test #24", function() {

		// lerp( int64 local, int64 local , int64 local ): amount 1.1, extrapolating above
		var _buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _vInt64_1 = buffer_read(_buff, buffer_u64);
		var _vInt64_2 = buffer_read(_buff, buffer_u64);

		var _result = lerp( _vInt64_1, _vInt64_2, 1.1 );
		var _expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 1.1;
		assert_equals(_result, _expected, "#24 lerp( int64 local, int64 local , int64 local )")

		// Clean up
		buffer_delete(_buff);
	})

	// LN TESTS

	addFact("ln_test #1", function() {

		// ln( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = ln(_vReal);
		assert_equals(_result, 0.91629073187, "#1 ln( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #2", function() {

		// ln( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = ln(_vInt);
		assert_equals(_result, 2.30258509299, "#2 ln( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #3", function() {

		// ln( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = ln(_vInt64);
		assert_equals(_result, 1.38629436112, "#3 ln( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #4", function() {

		// ln( real const )
		var _result = ln(2.5);
		assert_equals(_result, 0.91629073187, "#4 ln( real const )")
	})

	addFact("ln_test #5", function() {

		// ln( int const )
		var _result = ln(10);
		assert_equals(_result, 2.30258509299, "#5 ln( int const )")
	})

	addFact("ln_test #6", function() {

		// ln( int64 const )
		var _result = ln(int64(4));
		assert_equals(_result, 1.38629436112, "#6 ln( int64 const )")
	})

	addFact("ln_test #7", function() {

		// negative value: ln( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = ln(-_vReal);
		assert_true(is_nan(_result), "#7 ln( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #8", function() {

		// negative value: ln( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = ln(-_vInt);
		assert_true(is_nan(_result), "#8 ln( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #9", function() {

		// negative value: ln( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = ln(-_vInt64);
		assert_true(is_nan(_result), "#9 ln( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("ln_test #10", function() {

		// negative value: ln( real const )
		var _result = ln(-2.5);
		assert_true(is_nan(_result), "#10 ln( real const )")
	})

	addFact("ln_test #11", function() {

		// negative value: ln( int const )
		var _result = ln(-10);
		assert_true(is_nan(_result), "#11 ln( int const )")
	})

	addFact("ln_test #12", function() {

		// negative value: ln( int64 const )
		var _result = ln(int64(-4));
		assert_true(is_nan(_result), "#12 ln( int64 const )")
	})

	addFact("ln_test #13", function() {

		// zero test
		var _result = ln(0);
		assert_true(is_infinity(_result), "#13 ln( real const )")
	})

	addFact("ln_test #14", function() {

		// one test
		var _result = ln(1);
		assert_equals(_result, 0, "#14 ln( 1 )")
	})

	addFact("ln_test #15", function() {

		// inverse test
		var _value = exp(3.5);
		var _result = ln(_value);
		assert_equals(_result, 3.5, "#15 ln( real const )")
	})

	addFact("ln_test #16", function() {

		// infinity test
		var _infinity = infinity;

		var _result = ln(_infinity);
		assert_true(is_infinity(_result), "#16 ln( infinity )")
	})

	addFact("ln_test #17", function() {

		// NaN test
		var _nan = NaN;

		var _result = ln(_nan);
		assert_true(is_nan(_result), "#17 ln( NaN )")
	})

	// LOG10 TESTS

	addFact("log10_test #1", function() {

		// log10( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = log10(_vReal);
		assert_equals(_result, 0.39794000867, "#1 log10( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #2", function() {

		// log10( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = log10(_vInt);
		assert_equals(_result, 4, "#2 log10( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #3", function() {

		// log10( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 42);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = log10(_vInt64);
		assert_equals(_result, 1.6232492904, "#3 log10( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #4", function() {

		// log10( real const )
		var _result = log10(2.5);
		assert_equals(_result, 0.39794000867, "#4 log10( real const )")
	})

	addFact("log10_test #5", function() {

		// log10( int const )
		var _result = log10(10000);
		assert_equals(_result, 4, "#5 log10( int const )")
	})

	addFact("log10_test #6", function() {

		// log10( int64 const )
		var _result = log10(int64(42));
		assert_equals(_result, 1.6232492904, "#6 log10( int64 const )")
	})

	addFact("log10_test #7", function() {

		// negative value: log10( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = log10(-_vReal);
		assert_true(is_nan(_result), "#7 log10( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #8", function() {

		// negative value: log10( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = log10(-_vInt);
		assert_true(is_nan(_result), "#8 log10( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #9", function() {

		// negative value: log10( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 42);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = log10(-_vInt64);
		assert_true(is_nan(_result), "#9 log10( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test #10", function() {

		// negative value: log10( real const )
		var _result = log10(-2.5);
		assert_true(is_nan(_result), "#10 log10( real const )")
	})

	addFact("log10_test #11", function() {

		// negative value: log10( int const )
		var _result = log10(-10000);
		assert_true(is_nan(_result), "#11 log10( int const )")
	})

	addFact("log10_test #12", function() {

		// negative value: log10( int64 const )
		var _result = log10(int64(-42));
		assert_true(is_nan(_result), "#12 log10( int64 const )")
	})

	addFact("log10_test #13", function() {

		// zero test
		var _result = log10(0);
		assert_true(is_infinity(_result), "#13 log10( 0 )")
	})

	addFact("log10_test #14", function() {

		// one test
		var _result = log10(1);
		assert_equals(_result, 0, "#14 log10( 1 )")
	})

	addFact("log10_test #15", function() {

		// negative power: log10(0.1)
		var _result = log10(0.1);
		assert_equals(_result, -1, "#15 log10( real local )")
	})

	addFact("log10_test #16", function() {

		// negative power: log10(0.01)
		var _result = log10(0.01);
		assert_equals(_result, -2, "#16 log10( int local )")
	})

	addFact("log10_test #17", function() {

		// negative power: log10(0.001)
		var _result = log10(0.001);
		assert_equals(_result, -3, "#17 log10( int64 local )")
	})

	addFact("log10_test #18", function() {

		// infinity test
		var _infinity = infinity;

		var _result = log10(_infinity);
		assert_true(is_infinity(_result), "#18 log10( infinity )")
	})

	addFact("log10_test #19", function() {

		// NaN test
		var _nan = NaN;

		var _result = log10(_nan);
		assert_true(is_nan(_result), "#19 log10( NaN )")
	})

	// LOG2 TESTS

	addFact("log2_test #1", function() {

		// log2( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = log2(_vReal);
		assert_equals(_result, 1.32192809489, "#1 log2( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #2", function() {

		// log2( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 8);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = log2(_vInt);
		assert_equals(_result, 3, "#2 log2( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #3", function() {

		// log2( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = log2(_vInt64);
		assert_equals(_result, 2, "#3 log2( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #4", function() {

		// log2( real const )
		var _result = log2(2.5);
		assert_equals(_result, 1.32192809489, "#4 log2( real const )")
	})

	addFact("log2_test #5", function() {

		// log2( int const )
		var _result = log2(8);
		assert_equals(_result, 3, "#5 log2( int const )")
	})

	addFact("log2_test #6", function() {

		// log2( int64 const )
		var _result = log2(int64(4));
		assert_equals(_result, 2, "#6 log2( int64 const )")
	})

	addFact("log2_test #7", function() {

		// negative value: log2( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = log2(-_vReal);
		assert_true(is_nan(_result), "#7 log2( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #8", function() {

		// negative value: log2( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 8);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = log2(-_vInt);
		assert_true(is_nan(_result), "#8 log2( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #9", function() {

		// negative value: log2( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = log2(-_vInt64);
		assert_true(is_nan(_result), "#9 log2( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test #10", function() {

		// negative value: log2( real const )
		var _result = log2(-2.5);
		assert_true(is_nan(_result), "#10 log2( real const )")
	})

	addFact("log2_test #11", function() {

		// negative value: log2( int const )
		var _result = log2(-8);
		assert_true(is_nan(_result), "#11 log2( int const )")
	})

	addFact("log2_test #12", function() {

		// negative value: log2( int64 const )
		var _result = log2(int64(-4));
		assert_true(is_nan(_result), "#12 log2( int64 const )")
	})

	addFact("log2_test #13", function() {

		// zero test
		var _result = log2(0);
		assert_true(is_infinity(_result), "#13 log2( 0 )")
	})

	addFact("log2_test #14", function() {

		// one test
		var _result = log2(1);
		assert_equals(_result, 0, "#14 log2( 1 )")
	})

	addFact("log2_test #15", function() {

		// negative power: log2(0.5)
		var _result = log2(0.5);
		assert_equals(_result, -1, "#15 log2( real local )")
	})

	addFact("log2_test #16", function() {

		// negative power: log2(0.25)
		var _result = log2(0.25);
		assert_equals(_result, -2, "#16 log2( int local )")
	})

	addFact("log2_test #17", function() {

		// negative power: log2(0.125)
		var _result = log2(0.125);
		assert_equals(_result, -3, "#17 log2( int64 local )")
	})

	addFact("log2_test #18", function() {

		// infinity test
		var _infinity = infinity;

		var _result = log2(_infinity);
		assert_true(is_infinity(_result), "#18 log2( infinity )")
	})

	addFact("log2_test #19", function() {

		// NaN test
		var _nan = NaN;

		var _result = log2(_nan);
		assert_true(is_nan(_result), "#19 log2( NaN )")
	})

	// LOGN TESTS

	addFact("logn_test #1", function() {

		// logn( real const , real local ): base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(5, _vReal);
		assert_equals(_result, 0.56932344192661, "#1 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #2", function() {

		// logn( real const , int local ): base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(5, _vInt);
		assert_equals(_result, 1.4306765580734, "#2 logn( real const , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #3", function() {

		// logn( real const , int64 local ): base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(5, _vInt64);
		assert_equals(_result, 0.86135311614679, "#3 logn( real const , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #4", function() {

		// logn( real const , real local ): base 2 agrees with log2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(2, _vReal);
		assert_equals(_result, log2(_vReal), "#4 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #5", function() {

		// logn( real const , int local ): base 2 agrees with log2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(2, _vInt);
		assert_equals(_result, log2(_vInt), "#5 logn( real const , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #6", function() {

		// logn( real const , int64 local ): base 2 agrees with log2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(2, _vInt64);
		assert_equals(_result, log2(_vInt64), "#6 logn( real const , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #7", function() {

		// logn( real const , real local ): base 10 agrees with log10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(10, _vReal);
		assert_equals(_result, log10(_vReal), "#7 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #8", function() {

		// logn( real const , int local ): base 10 agrees with log10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(10, _vInt);
		assert_equals(_result, log10(_vInt), "#8 logn( real const , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #9", function() {

		// logn( real const , int64 local ): base 10 agrees with log10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(10, _vInt64);
		assert_equals(_result, log10(_vInt64), "#9 logn( real const , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #10", function() {

		// logn( real local , real const ): base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(1, _vReal);
		assert_true(is_infinity(_result), "#10 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #11", function() {

		// logn( int local , real const ): base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(1, _vInt);
		assert_true(is_infinity(_result), "#11 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #12", function() {

		// logn( int64 local , real const ): base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(1, _vInt64);
		assert_true(is_infinity(_result), "#12 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #13", function() {

		// logn( real local , real const ): base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(0, _vReal);
		assert_equals(_result, 0, "#13 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #14", function() {

		// logn( int local , real const ): base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(0, _vInt);
		assert_equals(_result, 0, "#14 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #15", function() {

		// logn( int64 local , real const ): base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(0, _vInt64);
		assert_equals(_result, 0, "#15 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #16", function() {

		// logn( real local , real const ): fractional base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(0.5, _vReal);
		assert_equals(_result, -1.3219280948874, "#16 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #17", function() {

		// logn( int local , real const ): fractional base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(0.5, _vInt);
		assert_equals(_result, -3.3219280948874, "#17 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #18", function() {

		// logn( int64 local , real const ): fractional base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(0.5, _vInt64);
		assert_equals(_result, -2, "#18 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #19", function() {

		// logn( real local , real const ): negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(-2, _vReal);
		assert_true(is_nan(_result), "#19 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #20", function() {

		// logn( int local , real const ): negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(-2, _vInt);
		assert_true(is_nan(_result), "#20 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #21", function() {

		// logn( int64 local , real const ): negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(-2, _vInt64);
		assert_true(is_nan(_result), "#21 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #22", function() {

		// negative values: logn( real const , real local ), base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(5, -_vReal);
		assert_true(is_nan(_result), "#22 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #23", function() {

		// negative values: logn( real const , int local ), base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(5, -_vInt);
		assert_true(is_nan(_result), "#23 logn( real const , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #24", function() {

		// negative values: logn( real const , int64 local ), base 5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(5, -_vInt64);
		assert_true(is_nan(_result), "#24 logn( real const , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #25", function() {

		// negative values: logn( real local , real const ), base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(1, -_vReal);
		assert_true(is_nan(_result), "#25 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #26", function() {

		// negative values: logn( int local , real const ), base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(1, -_vInt);
		assert_true(is_nan(_result), "#26 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #27", function() {

		// negative values: logn( int64 local , real const ), base 1
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(1, -_vInt64);
		assert_true(is_nan(_result), "#27 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #28", function() {

		// negative values: logn( real local , real const ), base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(0, -_vReal);
		assert_true(is_nan(_result), "#28 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #29", function() {

		// negative values: logn( int local , real const ), base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(0, -_vInt);
		assert_true(is_nan(_result), "#29 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #30", function() {

		// negative values: logn( int64 local , real const ), base 0
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(0, -_vInt64);
		assert_true(is_nan(_result), "#30 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #31", function() {

		// negative values: logn( real local , real const ), base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(0.5, -_vReal);
		assert_true(is_nan(_result), "#31 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #32", function() {

		// negative values: logn( int local , real const ), base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(0.5, -_vInt);
		assert_true(is_nan(_result), "#32 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #33", function() {

		// negative values: logn( int64 local , real const ), base 0.5
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(0.5, -_vInt64);
		assert_true(is_nan(_result), "#33 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #34", function() {

		// negative values: logn( real local , real const ), negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = logn(-2, -_vReal);
		assert_true(is_nan(_result), "#34 logn( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #35", function() {

		// negative values: logn( int local , real const ), negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = logn(-2, -_vInt);
		assert_true(is_nan(_result), "#35 logn( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #36", function() {

		// negative values: logn( int64 local , real const ), negative base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = logn(-2, -_vInt64);
		assert_true(is_nan(_result), "#36 logn( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #37", function() {

		// real as base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 5.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var realBase = buffer_read(_buffer, buffer_f32);

		var _result = logn(realBase, _vReal);
		assert_equals(_result, 0.53749333173972, "#37 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #38", function() {

		// int32 as base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 2);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var intBase = buffer_read(_buffer, buffer_s32);

		var _result = logn(intBase, _vReal);
		assert_equals(_result, log2(_vReal), "#38 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test #39", function() {

		// int64 as base
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_u64, 2);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var int64Base = buffer_read(_buffer, buffer_u64);

		var _result = logn(int64Base, _vReal);
		assert_equals(_result, log2(_vReal), "#39 logn( real const , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	// MATH_GET_EPSILON TESTS

	addFact("math_get_epsilon_test #1", function() {

		// math_get_epsilon: epsilon changes when set
		var _result;

		math_set_epsilon(0.1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.1, "#2 math_get_epsilon( )")

		math_set_epsilon(0.001);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#3 math_get_epsilon( )")

		math_set_epsilon(0.005);
		_result = math_get_epsilon();
		assert_equals(_result, 0.005, "#4 math_get_epsilon( )")

		math_set_epsilon(0);
		_result = math_get_epsilon();
		assert_equals(_result, 0.00000000001, "#5 math_get_epsilon( )")
	})

	addFact("math_get_epsilon_test #2", function() {

		// math_get_epsilon: unchanged when invalid values set
		var _result;

		math_set_epsilon(0.001);
		math_set_epsilon(1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#6 math_get_epsilon( )")

		math_set_epsilon(0.001);
		math_set_epsilon(100);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#7 math_get_epsilon( )")

		math_set_epsilon(0.001);
		math_set_epsilon(-1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#8 math_get_epsilon( )")

		// assigning returned epsilon as epsilon
		math_set_epsilon(0.001);
		_result = math_get_epsilon();
		math_set_epsilon(_result);

		assert_equals(0.1112, 0.1113, "#9 math_set_epsilon( real local ) - assigning returned epsilon as epsilon")
		assert_not_equals(0.1122, 0.1133, "#9 math_set_epsilon( real local ) - assigning returned epsilon as epsilon")
	})

	// MATH_SET_EPSILON TESTS

	addFact("math_set_epsilon_test #1", function() {

		// math_set_epsilon: real const values
		math_set_epsilon(0.1);
		assert_equals(0.12, 0.13, "#2 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#2 math_set_epsilon( real const )")

		math_set_epsilon(0.001);
		assert_equals(0.1112, 0.1113, "#3 math_set_epsilon( real const )")
		assert_not_equals(0.1122, 0.1133, "#3 math_set_epsilon( real const )")

		math_set_epsilon(0.00001);
		assert_equals(0.111345, 0.111346, "#4 math_set_epsilon( real const )")
		assert_not_equals(0.111335, 0.111446, "#4 math_set_epsilon( real const )")

		math_set_epsilon(0.5);
		assert_equals(0.1, 0.5, "#5 math_set_epsilon( real const )")
		assert_not_equals(0.1, 0.7, "#5 math_set_epsilon( real const )")

		math_set_epsilon(0.05);
		assert_equals(0.1, 0.15, "#6 math_set_epsilon( real const )")
		assert_not_equals(0.1, 0.17, "#6 math_set_epsilon( real const )")
	})

	addFact("math_set_epsilon_test #2", function() {

		// math_set_epsilon: zero value sets to 0.00000000001
		math_set_epsilon(0);
		assert_equals(0.11123456789, 0.11123456789, "#7 math_set_epsilon( 0 )")
		assert_not_equals(0.11123456788, 0.11123456789, "#7 math_set_epsilon( 0 )")
	})

	addFact("math_set_epsilon_test #3", function() {

		// math_set_epsilon: values >= 1 and < 0 leave epsilon unchanged
		math_set_epsilon(0.1);

		math_set_epsilon(1);
		assert_equals(0.12, 0.13, "#8 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#8 math_set_epsilon( real const )")

		math_set_epsilon(100);
		assert_equals(0.12, 0.13, "#9 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#9 math_set_epsilon( real const )")

		math_set_epsilon(-0.001);
		assert_equals(0.12, 0.13, "#10 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#10 math_set_epsilon( real const )")
	})

	addFact("math_set_epsilon_test #4", function() {

		// math_set_epsilon: int/int64 zero and nonzero values
		var _buffer = buffer_create(16, buffer_fixed, 1);
		buffer_write(_buffer, buffer_s32, 0);
		buffer_write(_buffer, buffer_s32, 1);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt_zero = buffer_read(_buffer, buffer_s32);
		var _vInt_one = buffer_read(_buffer, buffer_s32);

		// int(0) sets epsilon to 0.00000000001
		math_set_epsilon(_vInt_zero);
		assert_equals(0.111234567898, 0.111234567899, "#11 initially set value for epsilon should be 0.00000000001")
		assert_not_equals(0.11123456788, 0.11123456789, "#11 initially set value for epsilon should be 0.00000000001")

		// int64(0) sets epsilon to 0.00000000001
		math_set_epsilon(int64(0));
		assert_equals(0.111234567898, 0.111234567899, "#12 initially set value for epsilon should be 0.00000000001")
		assert_not_equals(0.11123456788, 0.11123456789, "#12 initially set value for epsilon should be 0.00000000001")

		// int(1) leaves epsilon unchanged
		math_set_epsilon(0.1);
		math_set_epsilon(_vInt_one);
		assert_equals(0.12, 0.13, "#13 math_set_epsilon( int const (1) )")
		assert_not_equals(0.22, 0.33, "#13 math_set_epsilon( int const (1) )")

		// int64(1) leaves epsilon unchanged
		math_set_epsilon(int64(1));
		assert_equals(0.12, 0.13, "#14 math_set_epsilon( int64 const (1) )")
		assert_not_equals(0.22, 0.33, "#14 math_set_epsilon( int64 const (1) )")

		buffer_delete(_buffer);
	})

	// MAX TESTS

	#macro kReal_MaxTest 2.5
	#macro kInt_MaxTest 10
	#macro kInt64_MaxTest 0xff87654321

	addFact("max_test #1", function() {

		// zero arguments
		var _result = max();
		assert_equals(_result, 0, "#1 max() - zero arguments")
	})

	addFact("max_test #2", function() {

		// one argument, local: max( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = max(_vReal);
		assert_equals(_result, _vReal, "#2 max( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("max_test #3", function() {

		// one argument, local: max( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = max(_vInt);
		assert_equals(_result, _vInt, "#3 max( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("max_test #4", function() {

		// one argument, local: max( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 0xdeadc0deabcdefed);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = max(_vInt64);
		assert_equals(_result, _vInt64, "#4 max( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("max_test #5", function() {

		// one argument, global: max( real global )
		global.gReal = 99;

		var _result = max(global.gReal);
		assert_equals(_result, global.gReal, "#5 max( real global )")
	})

	addFact("max_test #6", function() {

		// one argument, global: max( int global )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		global.gInt = _vInt;

		var _result = max(global.gInt);
		assert_equals(_result, global.gInt, "#6 max( int global )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("max_test #7", function() {

		// one argument, global: max( int64 global )
		global.gInt64 = int64(0x12131415161718);

		var _result = max(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 max( int64 global )")
	})

	addFact("max_test #8", function() {

		// one argument, instance: max( real instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = max(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 max( real instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("max_test #9", function() {

		// one argument, instance: max( int instance )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt = _vInt;

		var _result = max(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 max( int instance )")

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("max_test #10", function() {

		// one argument, instance: max( int64 instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt64 = int64(0x1122334455667788);

		var _result = max(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 max( int64 instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("max_test #11", function() {

		// one argument, const: max( real const )
		var _result = max(42.0);
		assert_equals(_result, 42.0, "#11 max( real instance )")
	})

	addFact("max_test #12", function() {

		// one argument, const: max( int const )
		var _result = max(12);
		assert_equals(_result, 12, "#12 max( int instance )")
	})

	addFact("max_test #13", function() {

		// one argument, const: max( int64 const )
		var _result = max(0x1122334455667788);
		assert_equals(_result, 0x1122334455667788, "#13 max( int64 instance )")
	})

	addFact("max_test #14", function() {

		// one argument, macro: max( real macro )
		var _result = max(kReal_MaxTest);
		assert_equals(_result, kReal_MaxTest, "#14 max( real macro )")
	})

	addFact("max_test #15", function() {

		// one argument, macro: max( int macro )
		var _result = max(kInt_MaxTest);
		assert_equals(_result, kInt_MaxTest, "#15 max( int macro )")
	})

	addFact("max_test #16", function() {

		// one argument, macro: max( int64 macro )
		var _result = max(kInt64_MaxTest);
		assert_equals(_result, kInt64_MaxTest, "#16 max( int64 macro )")
	})

	addFact("max_test #17", function() {

		// multiple arguments: all positive
		var _result = max(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 99.9, "#17 max( real const , real const , real const , real const )");
	})

	addFact("max_test #18", function() {

		// multiple arguments: all negative
		var _result = max(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -0.5, "#18 max( real const , real const , real const , real const )");
	})

	addFact("max_test #19", function() {

		// multiple arguments: mixed sign
		var _result = max(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, 0.5, "#19 max( real const , real const , real const , real const )");
	})

	addFact("max_test #20", function() {

		// multiple arguments: int64 consts
		var _result = max(0x1122334455667788, 0x8877665544332211, 0x7FFFFFFFFFFFFFFF, 0x5566778811223344);
		assert_equals(_result, 0x7FFFFFFFFFFFFFFF, "#20 max( int64 const , int64 const , int64 const , int64 const )");
	})

	addFact("max_test #21", function() {

		// multiple arguments: macro, instance, global and local
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		global.gReal = 99;

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = max(kReal_MaxTest, _objOther.oReal, global.gReal, _vReal);
		assert_equals(_result, _objOther.oReal, "#21 max( real const , real const , real const , real const )");

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("max_test #22", function() {

		// multiple arguments: macro, instance, global and local, all negated
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		global.gReal = 99;

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = max(-kReal_MaxTest, -_objOther.oReal, -global.gReal, -_vReal);
		assert_equals(_result, -kReal_MaxTest, "#22 max( real const , real const , real const , real const )");

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("max_test #23", function() {

		// identical values: positive
		var _result = max(50, 50, 50, 50);
		assert_equals(_result, 50, "#23 max( real const , real const , real const , real const )");
	})

	addFact("max_test #24", function() {

		// identical values: negative
		var _result = max(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#24 max( real const , real const , real const , real const )");
	})

	// MEAN TESTS

	#macro kReal_MeanTest 2.5
	#macro kInt_MeanTest 10
	#macro kInt64_MeanTest int64(5000)

	addFact("mean_test #1", function() {

		// zero arguments
		var _result = mean();
		assert_equals(_result, 0, "#1 mean() - zero arguments")
	})

	addFact("mean_test #2", function() {

		// one argument, local: mean( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = mean(_vReal);
		assert_equals(_result, _vReal, "#2 mean( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("mean_test #3", function() {

		// one argument, local: mean( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = mean(_vInt);
		assert_equals(_result, _vInt, "#3 mean( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("mean_test #4", function() {

		// one argument, local: mean( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = mean(_vInt64);
		assert_equals(_result, _vInt64, "#4 mean( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("mean_test #5", function() {

		// one argument, global: mean( real global )
		global.gReal = 99;

		var _result = mean(global.gReal);
		assert_equals(_result, global.gReal, "#5 mean( real global )")
	})

	addFact("mean_test #6", function() {

		// one argument, global: mean( int global )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		global.gInt = _vInt;

		var _result = mean(global.gInt);
		assert_equals(_result, global.gInt, "#6 mean( int global )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("mean_test #7", function() {

		// one argument, global: mean( int64 global )
		global.gInt64 = int64(5000);

		var _result = mean(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 mean( int64 global )")
	})

	addFact("mean_test #8", function() {

		// one argument, instance: mean( real instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = mean(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 mean( real instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("mean_test #9", function() {

		// one argument, instance: mean( int instance )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt = _vInt;

		var _result = mean(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 mean( int instance )")

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("mean_test #10", function() {

		// one argument, instance: mean( int64 instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt64 = int64(5000);

		var _result = mean(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 mean( int64 instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("mean_test #11", function() {

		// one argument, const: mean( real const )
		var _result = mean(42.0);
		assert_equals(_result, 42.0, "#11 mean( real instance )")
	})

	addFact("mean_test #12", function() {

		// one argument, const: mean( int const )
		var _result = mean(12);
		assert_equals(_result, 12, "#12 mean( int instance )")
	})

	addFact("mean_test #13", function() {

		// one argument, const: mean( int64 const )
		var _result = mean(int64(5000));
		assert_equals(_result, int64(5000), "#13 mean( int64 instance )")
	})

	addFact("mean_test #14", function() {

		// one argument, macro: mean( real macro )
		var _result = mean(kReal_MeanTest);
		assert_equals(_result, kReal_MeanTest, "#14 mean( real macro )")
	})

	addFact("mean_test #15", function() {

		// one argument, macro: mean( int macro )
		var _result = mean(kInt_MeanTest);
		assert_equals(_result, kInt_MeanTest, "#15 mean( int macro )")
	})

	addFact("mean_test #16", function() {

		// one argument, macro: mean( int64 macro )
		var _result = mean(kInt64_MeanTest);
		assert_equals(_result, kInt64_MeanTest, "#16 mean( int64 macro )")
	})

	addFact("mean_test #17", function() {

		// multiple arguments: all positive
		var _result = mean(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 25.875, "#17 mean( real const , real const , real const , real const )");
	})

	addFact("mean_test #18", function() {

		// multiple arguments: all negative
		var _result = mean(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -25.875, "#18 mean( real const , real const , real const , real const )");
	})

	addFact("mean_test #19", function() {

		// multiple arguments: mixed sign
		var _result = mean(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -25.625, "#19 mean( real const , real const , real const , real const )");
	})

	addFact("mean_test #20", function() {

		// multiple arguments: cancelling to zero
		var _result = mean(0.5, -0.5, 0.5, -0.5);
		assert_equals(_result, 0, "#20 mean( real const , real const , real const , real const )");
	})

	addFact("mean_test #21", function() {

		// multiple arguments: int64 consts
		var _result = mean(int64(100), int64(-50), int64(200), int64(-10));
		assert_equals(_result, 60, "#21 mean( int64 const , int64 const , int64 const , int64 const )");
	})

	addFact("mean_test #22", function() {

		// identical values: positive
		var _result = mean(50, 50, 50, 50);
		assert_equals(_result, 50, "#22 mean( real const , real const , real const , real const )");
	})

	addFact("mean_test #23", function() {

		// identical values: negative
		var _result = mean(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#23 mean( real const , real const , real const , real const )");
	})

	// MEDIAN TESTS

	#macro kReal_MedianTest 2.5
	#macro kInt_MedianTest 10
	#macro kInt64_MedianTest int64(5000)

	addFact("median_test #1", function() {

		// zero arguments
		var _result = median();
		assert_equals(_result, 0, "#1 median() - zero arguments")
	})

	addFact("median_test #2", function() {

		// one argument, local: median( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = median(_vReal);
		assert_equals(_result, _vReal, "#2 median( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("median_test #3", function() {

		// one argument, local: median( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = median(_vInt);
		assert_equals(_result, _vInt, "#3 median( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("median_test #4", function() {

		// one argument, local: median( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = median(_vInt64);
		assert_equals(_result, _vInt64, "#4 median( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("median_test #5", function() {

		// one argument, global: median( real global )
		global.gReal = 99;

		var _result = median(global.gReal);
		assert_equals(_result, global.gReal, "#5 median( real global )")
	})

	addFact("median_test #6", function() {

		// one argument, global: median( int global )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		global.gInt = _vInt;

		var _result = median(global.gInt);
		assert_equals(_result, global.gInt, "#6 median( int global )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("median_test #7", function() {

		// one argument, global: median( int64 global )
		global.gInt64 = int64(5000);

		var _result = median(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 median( int64 global )")
	})

	addFact("median_test #8", function() {

		// one argument, instance: median( real instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = median(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 median( real instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("median_test #9", function() {

		// one argument, instance: median( int instance )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt = _vInt;

		var _result = median(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 median( int instance )")

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("median_test #10", function() {

		// one argument, instance: median( int64 instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt64 = int64(5000);

		var _result = median(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 median( int64 instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("median_test #11", function() {

		// one argument, const: median( real const )
		var _result = median(42.0);
		assert_equals(_result, 42.0, "#11 median( real instance )")
	})

	addFact("median_test #12", function() {

		// one argument, const: median( int const )
		var _result = median(12);
		assert_equals(_result, 12, "#12 median( int instance )")
	})

	addFact("median_test #13", function() {

		// one argument, const: median( int64 const )
		var _result = median(int64(5000));
		assert_equals(_result, int64(5000), "#13 median( int64 instance )")
	})

	addFact("median_test #14", function() {

		// one argument, macro: median( real macro )
		var _result = median(kReal_MedianTest);
		assert_equals(_result, kReal_MedianTest, "#14 median( real macro )")
	})

	addFact("median_test #15", function() {

		// one argument, macro: median( int macro )
		var _result = median(kInt_MedianTest);
		assert_equals(_result, kInt_MedianTest, "#15 median( int macro )")
	})

	addFact("median_test #16", function() {

		// one argument, macro: median( int64 macro )
		var _result = median(kInt64_MedianTest);
		assert_equals(_result, kInt64_MedianTest, "#16 median( int64 macro )")
	})

	addFact("median_test #17", function() {

		// multiple (even) arguments: all positive
		var _result = median(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 2.0, "#17 median( real const , real const , real const , real const )");
	})

	addFact("median_test #18", function() {

		// multiple (even) arguments: all negative
		var _result = median(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -1.1, "#18 median( real const , real const , real const , real const )");
	})

	addFact("median_test #19", function() {

		// multiple (even) arguments: mixed sign
		var _result = median(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -1.1, "#19 median( real const , real const , real const , real const )");
	})

	addFact("median_test #20", function() {

		// multiple (even) arguments: alternating sign
		var _result = median(0.5, -0.5, 0.5, -0.5);
		assert_equals(_result, 0.5, "#20 median( real const , real const , real const , real const )");
	})

	addFact("median_test #21", function() {

		// multiple (even) arguments: int64 consts
		var _result = median(int64(100), int64(-50), int64(200), int64(-10));
		assert_equals(_result, int64(100), "#21 median( int64 const , int64 const , int64 const , int64 const )");
	})

	addFact("median_test #22", function() {

		// multiple (odd) arguments: all positive
		var _result = median(0.5, 1.1, 2.0, 99.9, 234.0);
		assert_equals(_result, 2.0, "#22 median( real const , real const , real const , real const )");
	})

	addFact("median_test #23", function() {

		// multiple (odd) arguments: all negative
		var _result = median(-0.5, -1.1, -2.0, -99.9, -234.0);
		assert_equals(_result, -2.0, "#23 median( real const , real const , real const , real const )");
	})

	addFact("median_test #24", function() {

		// multiple (odd) arguments: mixed sign
		var _result = median(0.5, -1.1, -2.0, -99.9, 234.0);
		assert_equals(_result, -1.1, "#24 median( real const , real const , real const , real const )");
	})

	addFact("median_test #25", function() {

		// multiple (odd) arguments: alternating sign
		var _result = median(0.5, -0.5, 0.5, -0.5, 0.5);
		assert_equals(_result, 0.5, "#25 median( real const , real const , real const , real const )");
	})

	addFact("median_test #26", function() {

		// multiple (odd) arguments: int64 consts
		var _result = median(int64(100), int64(-50), int64(200), int64(-10), int64(-99));
		assert_equals(_result, int64(-10), "#26 median( int64 const , int64 const , int64 const , int64 const )");
	})

	addFact("median_test #27", function() {

		// identical values: positive
		var _result = median(50, 50, 50, 50);
		assert_equals(_result, 50, "#27 median( real const , real const , real const , real const )");
	})

	addFact("median_test #28", function() {

		// identical values: negative
		var _result = median(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#28 median( real const , real const , real const , real const )");
	})

	// MIN TESTS

	#macro kReal_MinTest 2.5
	#macro kInt_MinTest 10
	#macro kInt64_MinTest 0xff87654321

	addFact("min_test #1", function() {

		// zero arguments
		var _result = min();
		assert_equals(_result, 0, "#1 min() - zero arguments")
	})

	addFact("min_test #2", function() {

		// one argument, local: min( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = min(_vReal);
		assert_equals(_result, _vReal, "#2 min( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("min_test #3", function() {

		// one argument, local: min( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = min(_vInt);
		assert_equals(_result, _vInt, "#3 min( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("min_test #4", function() {

		// one argument, local: min( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 0xdeadc0deabcdefed);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = min(_vInt64);
		assert_equals(_result, _vInt64, "#4 min( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("min_test #5", function() {

		// one argument, global: min( real global )
		global.gReal = 99;

		var _result = min(global.gReal);
		assert_equals(_result, global.gReal, "#5 min( real global )")
	})

	addFact("min_test #6", function() {

		// one argument, global: min( int global )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		global.gInt = _vInt;

		var _result = min(global.gInt);
		assert_equals(_result, global.gInt, "#6 min( int global )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("min_test #7", function() {

		// one argument, global: min( int64 global )
		global.gInt64 = int64(0x12131415161718);

		var _result = min(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 min( int64 global )")
	})

	addFact("min_test #8", function() {

		// one argument, instance: min( real instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = min(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 min( real instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("min_test #9", function() {

		// one argument, instance: min( int instance )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt = _vInt;

		var _result = min(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 min( int instance )")

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("min_test #10", function() {

		// one argument, instance: min( int64 instance )
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oInt64 = int64(0x1122334455667788);

		var _result = min(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 min( int64 instance )")

		// Clean up
		instance_destroy(_objOther);
	})

	addFact("min_test #11", function() {

		// one argument, const: min( real const )
		var _result = min(42.0);
		assert_equals(_result, 42.0, "#11 min( real instance )")
	})

	addFact("min_test #12", function() {

		// one argument, const: min( int const )
		var _result = min(12);
		assert_equals(_result, 12, "#12 min( int instance )")
	})

	addFact("min_test #13", function() {

		// one argument, const: min( int64 const )
		var _result = min(0x1122334455667788);
		assert_equals(_result, 0x1122334455667788, "#13 min( int64 instance )")
	})

	addFact("min_test #14", function() {

		// one argument, macro: min( real macro )
		var _result = min(kReal_MinTest);
		assert_equals(_result, kReal_MinTest, "#14 min( real macro )")
	})

	addFact("min_test #15", function() {

		// one argument, macro: min( int macro )
		var _result = min(kInt_MinTest);
		assert_equals(_result, kInt_MinTest, "#15 min( int macro )")
	})

	addFact("min_test #16", function() {

		// one argument, macro: min( int64 macro )
		var _result = min(kInt64_MinTest);
		assert_equals(_result, kInt64_MinTest, "#16 min( int64 macro )")
	})

	addFact("min_test #17", function() {

		// multiple arguments: all positive
		var _result = min(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 0.5, "#17 min( real const , real const , real const , real const )");
	})

	addFact("min_test #18", function() {

		// multiple arguments: all negative
		var _result = min(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -99.9, "#18 min( real const , real const , real const , real const )");
	})

	addFact("min_test #19", function() {

		// multiple arguments: mixed sign
		var _result = min(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -99.9, "#19 min( real const , real const , real const , real const )");
	})

	addFact("min_test #20", function() {

		// multiple arguments: int64 consts
		var _result = min(0x0122334455667788, 0x0877665544332211, 0x0FFFFFFFFFFFFFFF, 0x0566778811223344);
		assert_equals(_result, 0x0122334455667788, "#20 min( int64 const , int64 const , int64 const , int64 const )");
	})

	addFact("min_test #21", function() {

		// multiple arguments: macro, instance, global and local
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		global.gReal = 99;

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = min(kReal_MinTest, _objOther.oReal, global.gReal, _vReal);
		assert_equals(_result, kReal_MinTest, "#21 min( real const , real const , real const , real const )");

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("min_test #22", function() {

		// multiple arguments: macro, instance, global and local, all negated
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		global.gReal = 99;

		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;

		var _result = min(-kReal_MinTest, -_objOther.oReal, -global.gReal, -_vReal);
		assert_equals(_result, -_objOther.oReal, "#22 min( real const , real const , real const , real const )");

		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("min_test #23", function() {

		// identical values: positive
		var _result = min(50, 50, 50, 50);
		assert_equals(_result, 50, "#23 min( real const , real const , real const , real const )");
	})

	addFact("min_test #24", function() {

		// identical values: negative
		var _result = min(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#24 min( real const , real const , real const , real const )");
	})

	// POINT_DIRECTION TESTS

	addFact("point_direction_test #1", function() {

		// point_direction( real local ): direct and negated target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, -10.2);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);

		math_set_epsilon(0.0001);

		var _result;

		_result = point_direction(_vReal_x1, _vReal_y1, _vReal_x2, _vReal_y2);
		assert_equals(_result, 61.4195, "#1 point_direction( real local , real local , real local , real local )")

		_result = point_direction(_vReal_x1, _vReal_y1, -_vReal_x2, -_vReal_y2);
		assert_equals(_result, 209.6444, "#1 point_direction( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #2", function() {

		// point_direction( int local ): direct and negated target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _result;

		_result = point_direction(_vInt_x1, _vInt_y1, _vInt_x2, _vInt_y2);
		assert_equals(_result, 35.8376, "#2 point_direction( int local , int local , int local , int local )")

		_result = point_direction(_vInt_x1, _vInt_y1, -_vInt_x2, -_vInt_y2);
		assert_equals(_result, 197.6501, "#2 point_direction( int local , int local , int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #3", function() {

		// point_direction( int64 local ): direct and negated target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result;

		_result = point_direction(_vInt64_x1, _vInt64_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 39.0938, "#3 point_direction( int64 local , int64 local , int64 local , int64 local )")

		_result = point_direction(_vInt64_x1, _vInt64_y1, -_vInt64_x2, -_vInt64_y2);
		assert_equals(_result, 196.2602, "#3 point_direction( int64 local , int64 local , int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #4", function() {

		// point_direction: real origin, int target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _result = point_direction(_vReal_x1, _vReal_y1, _vInt_x2, _vInt_y2);
		assert_equals(_result, 37.0267, "#4 point_direction( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #5", function() {

		// point_direction: real origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result = point_direction(_vReal_x1, _vReal_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 37.0267, "#5 point_direction( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #6", function() {

		// point_direction: int origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result = point_direction(_vInt_x1, _vInt_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 35.8376, "#6 point_direction( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_direction_test #7", function() {

		// zero angle
		math_set_epsilon(0.0001);

		var _result = point_direction(10.2, 99.5, 10.2, 99.5);
		assert_equals(_result, 0, "#7 point_direction( real local , real local , real local , real local )")
	})

	// POINT_DISTANCE_3D TESTS

	addFact("point_distance_3d_test #1", function() {

		// point_distance_3d( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 4.3);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, -3.9);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_z1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);
		var _vReal_z2 = buffer_read(_buffer, buffer_f32);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vReal_x2, _vReal_y2, _vReal_z2);
		_dx = _vReal_x2 - _vReal_x1;
		_dy = _vReal_y2 - _vReal_y1;
		_dz = _vReal_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#1 point_distance_3d( real local , real local , real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #2", function() {

		// point_distance_3d( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 4);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);
		buffer_write(_buffer, buffer_s32, 4);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_z1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);
		var _vInt_z2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vInt_x1, _vInt_y1, _vInt_z1, _vInt_x2, _vInt_y2, _vInt_z2);
		_dx = _vInt_x2 - _vInt_x1;
		_dy = _vInt_y2 - _vInt_y1;
		_dz = _vInt_z2 - _vInt_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#2 point_distance_3d( int local , int local , int local , int local , int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #3", function() {

		// point_distance_3d( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
		buffer_write(_buffer, buffer_u64, 4);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vInt64_x1, _vInt64_y1, _vInt64_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vInt64_x1;
		_dy = _vInt64_y2 - _vInt64_y1;
		_dz = _vInt64_z2 - _vInt64_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#3 point_distance_3d( int64 local , int64 local , int64 local , int64 local , int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #4", function() {

		// point_distance_3d: real origin, int target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 4.3);

		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);
		buffer_write(_buffer, buffer_s32, 4);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_z1 = buffer_read(_buffer, buffer_f32);

		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);
		var _vInt_z2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vInt_x2, _vInt_y2, _vInt_z2);
		_dx = _vInt_x2 - _vReal_x1;
		_dy = _vInt_y2 - _vReal_y1;
		_dz = _vInt_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#4 point_distance_3d( real local , real local , real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #5", function() {

		// point_distance_3d: real origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 4.3);

		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
		buffer_write(_buffer, buffer_u64, 4);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_z1 = buffer_read(_buffer, buffer_f32);

		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vReal_x1;
		_dy = _vInt64_y2 - _vReal_y1;
		_dz = _vInt64_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#5 point_distance_3d( real local , real local , real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #6", function() {

		// point_distance_3d: int origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 4);

		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
		buffer_write(_buffer, buffer_u64, 4);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_z1 = buffer_read(_buffer, buffer_s32);

		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _result, _dx, _dy, _dz, _expected;

		_result = point_distance_3d(_vInt_x1, _vInt_y1, _vInt_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vInt_x1;
		_dy = _vInt64_y2 - _vInt_y1;
		_dz = _vInt64_z2 - _vInt_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#6 point_distance_3d( real local , real local , real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test #7", function() {

		// zero length
		math_set_epsilon(0.0001);

		var _result = point_distance_3d(10.2, 99.5, -234, 10.2, 99.5, -234);
		assert_equals(_result, 0, "#7 point_distance_3d( real local , real local , real local , real local , real local , real local )")
	})

	// POINT_DISTANCE TESTS

	addFact("point_distance_test #1", function() {

		// point_distance( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, 3.2);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vReal_x1, _vReal_y1, _vReal_x2, _vReal_y2);
		_dx = _vReal_x2 - _vReal_x1;
		_dy = _vReal_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#1 point_distance( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #2", function() {

		// point_distance( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vInt_x1, _vInt_y1, _vInt_x2, _vInt_y2);
		_dx = _vInt_x2 - _vInt_x1;
		_dy = _vInt_y2 - _vInt_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#2 point_distance( int local , int local , int local , int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #3", function() {

		// point_distance( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vInt64_x1, _vInt64_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vInt64_x1;
		_dy = _vInt64_y2 - _vInt64_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#3 point_distance( int64 local , int64 local , int64 local , int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #4", function() {

		// point_distance: real origin, int target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);

		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);

		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vReal_x1, _vReal_y1, _vInt_x2, _vInt_y2);
		_dx = _vInt_x2 - _vReal_x1;
		_dy = _vInt_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#4 point_distance( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #5", function() {

		// point_distance: real origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);

		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);

		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vReal_x1, _vReal_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vReal_x1;
		_dy = _vInt64_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#5 point_distance( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #6", function() {

		// point_distance: int origin, int64 target
		var _buffer = buffer_create(16, buffer_grow, 1 );

		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);

		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);

		buffer_seek(_buffer, buffer_seek_start, 0);

		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);

		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);

		math_set_epsilon(0.0001);

		var _expected, _result, _dx, _dy;

		_result = point_distance(_vInt_x1, _vInt_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vInt_x1;
		_dy = _vInt64_y2 - _vInt_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#6 point_distance( real local , real local , real local , real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test #7", function() {

		// zero length
		math_set_epsilon(0.0001);

		var _result = point_distance(10.2, 99.5, 10.2, 99.5);
		assert_equals(_result, 0, "#7 point_distance( real local , real local , real local , real local )")
	})

	// POWER TESTS

	addFact("power_test #1", function() {

		// power( real local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(_vReal , 2);
		assert_equals(_result, 6.25, "#1 power( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #2", function() {

		// power( int local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(_vInt, 2);
		assert_equals(_result, 100, "#2 power( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #3", function() {

		// power( int64 local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(_vInt64, 2);
		assert_equals(_result, 16, "#3 power( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #4", function() {

		// power( real local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(_vReal , 10);
		assert_equals(_result, 9536.7431640625, "#4 power( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #5", function() {

		// power( int local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(_vInt, 10);
		assert_equals(_result, 10000000000, "#5 power( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #6", function() {

		// power( int64 local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(_vInt64, 10);
		assert_equals(_result, 1048576, "#6 power( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #7", function() {

		// power( real local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(_vReal , 0);
		assert_equals(_result, 1, "#7 power( real local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #8", function() {

		// power( int local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(_vInt, 0);
		assert_equals(_result, 1, "#8 power( int local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #9", function() {

		// power( int64 local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(_vInt64, 0);
		assert_equals(_result, 1, "#9 power( int64 local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #10", function() {

		// power( real local , -2 ): negative exponent
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(_vReal , -2);
		assert_equals(_result, 0.16, "#10 power( real local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #11", function() {

		// power( int local , -10 ): negative exponent
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(_vInt, -10);
		assert_equals(_result, 0.0000000001, "#11 power( int local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #12", function() {

		// power( int64 local , -3 ): negative exponent
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(_vInt64, -3);
		assert_equals(_result, 0.015625, "#12 power( int64 local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #13", function() {

		// Negative value test: power( -real local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(-_vReal , 2);
		assert_equals(_result, 6.25, "#13 power( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #14", function() {

		// Negative value test: power( -int local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(-_vInt, 2);
		assert_equals(_result, 100, "#14 power( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #15", function() {

		// Negative value test: power( -int64 local , real const ): raised to 2
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(-_vInt64, 2);
		assert_equals(_result, 16, "#15 power( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #16", function() {

		// Negative value test: power( -real local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(-_vReal , 10);
		assert_equals(_result, 9536.7431640625, "#16 power( real local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #17", function() {

		// Negative value test: power( -int local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(-_vInt, 10);
		assert_equals(_result, 10000000000, "#17 power( int local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #18", function() {

		// Negative value test: power( -int64 local , real const ): raised to 10
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(-_vInt64, 10);
		assert_equals(_result, 1048576, "#18 power( int64 local , real const )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #19", function() {

		// Negative value test: power( -real local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(-_vReal , 0);
		assert_equals(_result, 1, "#19 power( real local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #20", function() {

		// Negative value test: power( -int local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(-_vInt, 0);
		assert_equals(_result, 1, "#20 power( int local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #21", function() {

		// Negative value test: power( -int64 local , 0 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(-_vInt64, 0);
		assert_equals(_result, 1, "#21 power( int64 local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #22", function() {

		// Negative value test: power( -real local , -2 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = power(-_vReal , -2);
		assert_equals(_result, 0.16, "#22 power( real local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #23", function() {

		// Negative value test: power( -int local , -10 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = power(-_vInt, -10);
		assert_equals(_result, 0.0000000001, "#23 power( int local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #24", function() {

		// Negative value test: power( -int64 local , -3 )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = power(-_vInt64, -3);
		assert_equals(_result, -0.015625, "#24 power( int64 local , 0 )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #25", function() {

		// Test invalid types Infinity/NaN: power( real local , infinity )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _infinity = infinity;

		var _result = power(_vReal , _infinity);
		assert_true(is_infinity(_result), "#25 power( real local , infinity )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #26", function() {

		// Test invalid types Infinity/NaN: power( int local , infinity )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _infinity = infinity;

		var _result = power(_vInt, _infinity);
		assert_true(is_infinity(_result), "#26 power( int local , infinity )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #27", function() {

		// Test invalid types Infinity/NaN: power( int64 local , infinity )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _infinity = infinity;

		var _result = power(_vInt64, _infinity);
		assert_true(is_infinity(_result), "#27 power( int64 local , infinity )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #28", function() {

		// Test invalid types Infinity/NaN: power( real local , NaN )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _nan = NaN;

		var _result = power(_vReal , _nan);
		assert_true(is_nan(_result), "#28 power( real local , NaN )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #29", function() {

		// Test invalid types Infinity/NaN: power( int local , NaN )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _nan = NaN;

		var _result = power(_vInt, _nan);
		assert_true(is_nan(_result), "#29 power( int local , NaN )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #30", function() {

		// Test invalid types Infinity/NaN: power( int64 local , NaN )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _nan = NaN;

		var _result = power(_vInt64, _nan);
		assert_true(is_nan(_result), "#30 power( int64 local , NaN )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test #31", function() {

		// Test invalid types Infinity/NaN: power( infinity , real const )
		var _infinity = infinity;

		var _result = power(_infinity, 2);
		assert_true(is_infinity(_result), "#31 power( int local , infinity )")
	})

	addFact("power_test #32", function() {

		// Test invalid types Infinity/NaN: power( NaN , real const )
		var _nan = NaN;

		var _result = power(_nan, 2);
		assert_true(is_nan(_result), "#32 power( int64 local , NaN )")
	})

	// RADTODEG TESTS

	addFact("radtodeg_test #1", function() {

		// radtodeg( real const ): radtodeg(0) == 0
		var zero = radtodeg(0)
		assert_equals(zero, 0.0, "0 rad == 0 deg")
	})

	addFact("radtodeg_test #2", function() {

		// radtodeg( real const ): radtodeg(pi) == 180
		var piTest = radtodeg(pi)
		assert_equals(piTest, 180.0, "Pi rad == 180 deg")
	})

	addFact("radtodeg_test #3", function() {

		// radtodeg( real const ): radtodeg(pi/2) == 90
		var pi_2 = radtodeg(pi/2)
		assert_equals(pi_2, 90.0, "Pi/2 rad == 90 deg")
	})

	addFact("radtodeg_test #4", function() {

		// radtodeg( real const ): radtodeg(pi/4) == 45
		var pi_4 = radtodeg(pi/4)
		assert_equals(pi_4, 45.0, "Pi/4 rad == 45 deg")
	})

	addFact("radtodeg_test #5", function() {

		// radtodeg( real const ): radtodeg(2*pi) == 360
		var pi_by_2 = radtodeg(2*pi)
		assert_equals(round(pi_by_2), round(360), "2*Pi rad == 360 deg")
	})

	addFact("radtodeg_test #6", function() {

		// radtodeg( real local ): radtodeg(0) == 0
		var zero_rad = 0
		var zero_deg = radtodeg(zero_rad)
		assert_equals(zero_deg, 0.0, "0 rad == 0 deg")
	})

	addFact("radtodeg_test #7", function() {

		// radtodeg( real local ): radtodeg(pi) == 180
		var piTest = pi
		var piTest_deg = radtodeg(piTest)
		assert_equals(piTest_deg, 180.0, "Pi rad == 180 deg")
	})

	addFact("radtodeg_test #8", function() {

		// radtodeg( real local ): radtodeg(pi/2) == 90
		var pi_2 = pi/2
		var pi_2_deg = radtodeg(pi_2)
		assert_equals(pi_2_deg, 90.0, "Pi/2 rad == 90 deg")
	})

	addFact("radtodeg_test #9", function() {

		// radtodeg( real local ): radtodeg(pi/4) == 45
		var pi_4 = pi/4
		var pi_4_deg = radtodeg(pi_4)
		assert_equals(pi_4_deg, 45.0, "Pi/4 rad == 45 deg")
	})

	addFact("radtodeg_test #10", function() {

		// radtodeg( real local ): radtodeg(2*pi) == 360
		var pi_by_2 = 2*pi
		var pi_by_2_deg = radtodeg(pi_by_2)
		assert_equals(round(pi_by_2_deg), round(360.0), "2*Pi rad == 360 deg")
	})

	// ROUND TESTS

	addFact("round_test #1", function() {

		// Positive tests: round(2.5)
		var numOne = 2.5

		var roundedNumOne = round(numOne)
		assert_equals(roundedNumOne, 2, "#1 Rounding 2.5 down to 2")
	})

	addFact("round_test #2", function() {

		// Positive tests: round(3.5)
		var numTwo = 3.5

		var roundedNumTwo = round(numTwo)
		assert_equals(roundedNumTwo, 4, "#2 Rounding 3.5 up to 4")
	})

	addFact("round_test #3", function() {

		// Positive tests: round(6.6)
		var numThree = 6.6

		var roundedNumThree = round(numThree)
		assert_equals(roundedNumThree, 7, "#3 Rounding 6.6 up to 7")
	})

	addFact("round_test #4", function() {

		// Positive tests: round(7.9)
		var numFour = 7.9

		var roundedNumFour = round(numFour)
		assert_equals(roundedNumFour, 8, "#4 Rounding 7.9 up to 8")
	})

	addFact("round_test #5", function() {

		// Positive tests: round(4.1)
		var numFive = 4.1

		var roundedNumFive = round(numFive)
		assert_equals(roundedNumFive, 4, "#5 Rounding 4.1 down to 4")
	})

	addFact("round_test #6", function() {

		// Positive tests: round(99.2)
		var numSix = 99.2

		var roundedNumSix = round(numSix)
		assert_equals(roundedNumSix, 99, "#6 Rounding 99.2 down to 99")
	})

	addFact("round_test #7", function() {

		// Negative numbers: round(-2.5)
		var negNumOne = -2.5

		var roundedNegNumOne = round(negNumOne)
		assert_equals(roundedNegNumOne, -2, "#1 Rounding -2.5 up to -2")
	})

	addFact("round_test #8", function() {

		// Negative numbers: round(-3.5)
		var negNumTwo = -3.5

		var roundedNegNumTwo = round(negNumTwo)
		assert_equals(roundedNegNumTwo, -4, "#2 Rounding -3.5 down to -4")
	})

	addFact("round_test #9", function() {

		// Negative numbers: round(-76.9)
		var negNumThree = -76.9

		var roundedNegNumThree = round(negNumThree)
		assert_equals(roundedNegNumThree, -77, "#3 Rounding -76.9 down to -77")
	})

	addFact("round_test #10", function() {

		// Negative numbers: round(-34.1)
		var negNumFour = -34.1

		var roundedNegNumFour = round(negNumFour)
		assert_equals(roundedNegNumFour, -34, "#4 Rounding -34.1 up to -34")
	})

	addFact("round_test #11", function() {

		// Negative numbers: round(-83.6)
		var negNumFive = -83.6

		var roundedNegNumFive = round(negNumFive)
		assert_equals(roundedNegNumFive, -84, "#5 Rounding -83.6 down to -84")
	})

	addFact("round_test #12", function() {

		// Whole numbers: round(3.0)
		var wholeNumOne = 3.0

		var roundedWholeNumOne = round(wholeNumOne)
		assert_equals(roundedWholeNumOne, 3, "#1 Rounded Whole Num 3 to 3")
	})

	addFact("round_test #13", function() {

		// Whole numbers: round(99.0)
		var wholeNumTwo = 99.0

		var roundedWholeNumTwo = round(wholeNumTwo)
		assert_equals(roundedWholeNumTwo, 99, "#2 Rounded Whole Num 99 to 99")
	})

	addFact("round_test #14", function() {

		// Whole numbers: round(-8.0)
		var wholeNegNumOne = -8.0

		var roundedWholeNegNumOne = round(wholeNegNumOne)
		assert_equals(roundedWholeNegNumOne, -8, "#1 Rounded Whole Negative Num -8 to -8")
	})

	addFact("round_test #15", function() {

		// Whole numbers: round(-44.0)
		var wholeNegNumTwo = -44.0

		var roundedWholeNegNumTwo = round(wholeNegNumTwo)
		assert_equals(roundedWholeNegNumTwo, -44, "#2 Rounded Whole Negative Num -44 to -44")
	})

	addFact("round_test #16", function() {

		// Literals: round(7.5)
		assert_equals(round(7.5), 8, "#1 Rounded Literal 7.5 to 8")
	})

	addFact("round_test #17", function() {

		// Literals: round(6.5)
		assert_equals(round(6.5), 6, "#2 Rounded Literal 6.5 to 6")
	})

	addFact("round_test #18", function() {

		// Literals: round(0.3)
		assert_equals(round(0.3), 0, "#3 Rounded Literal 0.3 to 0")
	})

	addFact("round_test #19", function() {

		// Literals: round(-3.5)
		assert_equals(round(-3.5), -4, "#4 Rounded Literal -3.5 to -4")
	})

	addFact("round_test #20", function() {

		// Literals: round(-2.5)
		assert_equals(round(-2.5), -2, "#5 Rounded Literal -2.5 to -2")
	})

	addFact("round_test #21", function() {

		// Literals: round(-0.3)
		assert_equals(round(-0.3), 0, "#6 Rounded Literal -0.3 to 0")
	})

	addFact("round_test #22", function() {

		// Literals: round(-7.3)
		assert_equals(round(-7.3), -7, "7 Rounded Literal -7.3 to -7")
	})

	// SIGN TESTS

	addFact("sign_test #1", function() {

		// Basic tests: sign(1)
		var positiveOne = 1

		var signPositiveOne = sign(positiveOne)
		assert_equals(signPositiveOne, 1, "#1 Sign of 1 is 1")
	})

	addFact("sign_test #2", function() {

		// Basic tests: sign(-1)
		var negativeOne = -1

		var signNegativeOne = sign(negativeOne)
		assert_equals(signNegativeOne, -1, "#2 Sign of -1 is -1")
	})

	addFact("sign_test #3", function() {

		// Basic tests: sign(0)
		var zero = 0

		var signZero = sign(zero)
		assert_equals(signZero, 0, "#3 Sign of 0 is 0")
	})

	addFact("sign_test #4", function() {

		// Numeric tests: sign(77.1)
		var numOne = 77.1

		var signOne = sign(numOne)
		assert_equals(signOne, 1, "#1 Sign of 77.1 is 1")
	})

	addFact("sign_test #5", function() {

		// Numeric tests: sign(-77.1)
		var numTwo = -77.1

		var signTwo = sign(numTwo)
		assert_equals(signTwo, -1, "#2 Sign of -77.1 is -1")
	})

	addFact("sign_test #6", function() {

		// Numeric tests: sign(45)
		var numThree = 45

		var signThree = sign(numThree)
		assert_equals(signThree, 1, "#3 Sign of 45 is 1")
	})

	addFact("sign_test #7", function() {

		// Numeric tests: sign(89.2)
		var numFour = 89.2

		var signFour = sign(numFour)
		assert_equals(signFour, 1, "#4 Sign of 89.2 is 1")
	})

	addFact("sign_test #8", function() {

		// Numeric tests: sign(12345678)
		var numFive = 12345678

		var signFive = sign(numFive)
		assert_equals(signFive, 1, "#5 Sign of 12345678 is 1")
	})

	addFact("sign_test #9", function() {

		// Numeric tests: sign(-12345678)
		var numSix = -12345678

		var signSix = sign(numSix)
		assert_equals(signSix, -1, "#6 Sign of -12345678 is -1")
	})

	addFact("sign_test #10", function() {

		// Numeric tests: sign( hex const )
		var hexOne = 0x80

		var signHexOne = sign(hexOne)
		assert_equals(signHexOne, 1, "#7 Sign of 128 is 1")
	})

	addFact("sign_test #11", function() {

		// Numeric tests: sign( negative int local read from a buffer )
		var _buffer = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buffer, buffer_s32, 0xFFFFFF80);
		var hexTwo = buffer_peek(_buffer, 0, buffer_s32);

		var signHexTwo = sign(hexTwo)
		assert_equals(signHexTwo, -1, "#8 Sign of -128 is -1")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sign_test #12", function() {

		// Literals: sign(1)
		assert_equals(sign(1), 1, "#1 Sign of 1 is 1")
	})

	addFact("sign_test #13", function() {

		// Literals: sign(-1)
		assert_equals(sign(-1), -1, "#2 Sign of -1 is -1")
	})

	addFact("sign_test #14", function() {

		// Literals: sign(0)
		assert_equals(sign(0), 0, "#3 Sign of 0 is 0")
	})

	addFact("sign_test #15", function() {

		// Literals: sign(5)
		assert_equals(sign(5), 1, "#4 Sign of 5 is 1")
	})

	addFact("sign_test #16", function() {

		// Literals: sign(-5)
		assert_equals(sign(-5), -1, "#5 Sign of -5 is -1")
	})

	// SIN TESTS

	addFact("sin_test #1", function() {

		// Sin (radian angle): sin(0) == 0
		var sinZero = sin(0)
		assert_equals(sinZero, 0, "#1 sin(0) equals zero")
	})

	addFact("sin_test #2", function() {

		// Sin (radian angle): sin(pi) == 0
		var sinPi = sin(pi)
		assert_equals(sinPi, 0, "#2 sin(pi) equals zero")
	})

	addFact("sin_test #3", function() {

		// Sin (radian angle): sin(2*pi) == 0
		var sinTwoPi = sin(2*pi)
		assert_equals(sinTwoPi, 0, "#3 sin(2*pi) equals zero")
	})

	addFact("sin_test #4", function() {

		// Sin (radian angle): output stays within [-1, 1] across [0, 2*pi)
		var _xPos = 0
		while (_xPos < (2*pi))
		{
			assert_less_or_equal(_xPos, (2*pi), "Ensure _xPos is always less than 2*pi")

			var _yPos = sin(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")

			_xPos += 0.01
		}
	})

	addFact("sqrt_negative_num_test", function() {

		// Sqrt Negative Num Test
		assert_throw(function() {
			var _number = -1
			return sqrt(_number)
		}, "#1 Calling 'sqrt' on negative number (should throw error)");
	
	})

	// SQRT TESTS

	addFact("sqrt_test #1", function() {

		// Basic tests: sqrt(4)
		var squareNumOne = 4

		var rootNumOne = sqrt(squareNumOne)
		assert_equals(rootNumOne, 2, "#1 Square root of 4")
	})

	addFact("sqrt_test #2", function() {

		// Basic tests: sqrt(9)
		var squareNumTwo = 9

		var rootNumTwo = sqrt(squareNumTwo)
		assert_equals(rootNumTwo, 3, "#2 Square root of 9")
	})

	addFact("sqrt_test #3", function() {

		// Basic tests: sqrt(16)
		var squareNumThree = 16

		var rootNumThree = sqrt(squareNumThree)
		assert_equals(rootNumThree, 4, "#3 Square root of 16")
	})

	addFact("sqrt_test #4", function() {

		// Basic tests: sqrt(25)
		var squareNumFour = 25

		var rootNumFour = sqrt(squareNumFour)
		assert_equals(rootNumFour, 5, "#4 Square root of 25")
	})

	addFact("sqrt_test #5", function() {

		// Product operations: sqrt(16 * 16)
		var sixteenBySixteen = 16*16

		var rootRes = sqrt(sixteenBySixteen)
		assert_equals(rootRes, 16, "Sqrt of 16 * 16")
	})

	addFact("sqrt_test #6", function() {

		// Product operations: sqrt(sqr(16))
		var squareSixteen = sqr(16)

		var squareSixteenRes = sqrt(squareSixteen)
		assert_equals(squareSixteenRes, 16, "Sqrt of sqr(16)")
	})

	addFact("sqrt_test #7", function() {

		// Big number: sqrt(0x100000000)
		var bigNum = 0x100000000

		var sqrtBigNumRes = sqrt(bigNum)
		assert_equals(sqrtBigNumRes, 65536, "Sqrt of 0x100000000")
	})

	// SQR TESTS

	addFact("sqr_test #1", function() {

		// sqr( real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = sqr(_vReal);
		assert_equals(_result, 6.25, "#1 sqr( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #2", function() {

		// sqr( int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = sqr(_vInt);
		assert_equals(_result, 100, "#2 sqr( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #3", function() {

		// sqr( int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = sqr(_vInt64);
		assert_equals(_result, 16, "#3 sqr( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #4", function() {

		// sqr( real const )
		var _result = sqr(2.5);
		assert_equals(_result, 6.25, "#4 sqr( real const )")
	})

	addFact("sqr_test #5", function() {

		// sqr( int const )
		var _result = sqr(10);
		assert_equals(_result, 100, "#5 sqr( int const )")
	})

	addFact("sqr_test #6", function() {

		// sqr( int64 const )
		var _result = sqr(int64(4));
		assert_equals(_result, 16, "#6 sqr( int64 const )")
	})

	addFact("sqr_test #7", function() {

		// Negative value tests: sqr( -real local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);

		var _result = sqr(-_vReal);
		assert_equals(_result, 6.25, "#7 sqr( real local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #8", function() {

		// Negative value tests: sqr( -int local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_s32, 10);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt = buffer_read(_buffer, buffer_s32);

		var _result = sqr(-_vInt);
		assert_equals(_result, 100, "#8 sqr( int local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #9", function() {

		// Negative value tests: sqr( -int64 local )
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt64 = buffer_read(_buffer, buffer_u64);

		var _result = sqr(-_vInt64);
		assert_equals(_result, 16, "#9 sqr( int64 local )")

		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sqr_test #10", function() {

		// Negative value tests: sqr( -real const )
		var _result = sqr(-2.5);
		assert_equals(_result, 6.25, "#10 sqr( real const )")
	})

	addFact("sqr_test #11", function() {

		// Negative value tests: sqr( -int const )
		var _result = sqr(-10);
		assert_equals(_result, 100, "#11 sqr( int const )")
	})

	addFact("sqr_test #12", function() {

		// Negative value tests: sqr( -int64 const )
		var _result = sqr(int64(-4));
		assert_equals(_result, 16, "#12 sqr( int64 const )")
	})

	addFact("sqr_test #13", function() {

		// Zero test: sqr( 0 )
		var _result = sqr(0);
		assert_equals(_result, 0, "#13 sqr( 0 )")
	})

	addFact("sqr_test #14", function() {

		// One test: sqr( 1 )
		var _result = sqr(1);
		assert_equals(_result, 1, "#14 sqr( 1 )")
	})

	addFact("sqr_test #15", function() {

		// Infinity test: sqr( infinity )
		var _infinity = infinity;

		var _result = sqr(_infinity);
		assert_true(is_infinity(_result), "#15 sqr( infinity )")
	})

	addFact("sqr_test #16", function() {

		// NaN test: sqr( NaN )
		var _nan = NaN;

		var _result = sqr(_nan);
		assert_true(is_nan(_result), "#16 sqr( NaN )")
	})

	// TAN TESTS

	#macro kPiDivFour_TanTest (pi/4)

	addFact("tan_test #1", function() {

		// Tan (radian angle): tan(0) == 0
		var tanZero = tan(0)
		assert_equals(tanZero, 0, "#1 Tan Zero == 0")
	})

	addFact("tan_test #2", function() {

		// Tan (radian angle): tan(pi) == 0
		var tanPi = tan(pi)
		assert_equals(tanPi, 0, "#2 Tan Pi == 0")
	})

	addFact("tan_test #3", function() {

		// Tan (radian angle): tan(2*pi) == 0
		var tanTwoPi = tan(2*pi)
		assert_equals(tanTwoPi, 0, "#3 Tan 2*pi == 0")
	})

	addFact("tan_test #4", function() {

		// Tan (radian angle): tan(pi/4) == 1
		var tanFortyFiveDeg = tan(kPiDivFour_TanTest)
		assert_equals(tanFortyFiveDeg, 1, "#4 Tan Pi/4 == 1")
	})

	addFact("tan_test #5", function() {

		// Tan (radian angle): tan(pi + pi/4) == 1
		var tanTwoTwoFiveDeg = tan((kPiDivFour_TanTest) + pi)
		assert_equals(tanTwoTwoFiveDeg, 1, "#5 Tan Pi + Pi/4 == 1")
	})

	addFact("tan_test #6", function() {

		// Tan (radian angle): tan(pi - pi/4) == -1
		var tanOneThirtyFiveDeg = tan((pi) - (kPiDivFour_TanTest))
		assert_equals(tanOneThirtyFiveDeg, -1, "#6 Tan Pi - (Pi/4) == -1")
	})

	addFact("tan_test #7", function() {

		// Tan (radian angle): tan(2*pi - pi/4) == -1
		var tanThreeFifteenDeg = tan((pi*2) - (kPiDivFour_TanTest))
		assert_equals(tanThreeFifteenDeg, -1, "#7 Tan (Pi * 2) - (Pi/4) == -1")
	})
	
}