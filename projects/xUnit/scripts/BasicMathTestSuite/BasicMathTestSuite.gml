
function BasicMathTestSuite() : TestSuite() constructor {

	addFact("abs_test", function() {

		// Abs test
		//show_debug_message("Abs test");
			
		// Whole numbers
		{
			var numOne = 2;
			var numTwo = 3;
			var negOne = -2;
			var negTwo = -3;
			
			// Run the floor operation
			var resOne = abs(numOne);
			var resTwo = abs(numTwo);
			var resNegOne = abs(negOne);
			var resNegTwo = abs(negTwo);
			
			// Assert results
			assert_equals(resOne, 2, "#1 Positive");
			assert_equals(resTwo, 3, "#2 Positive two");
			assert_equals(resNegOne, 2, "#3 Negative one");
			assert_equals(resNegTwo, 3, "#4 Negative two");
		}
		// Fractionals
		{
			var numOne = 5.5;
			var numTwo = 7.7;
			var negOne = -9.9;
			var negTwo = -15.1;
			var resNumOne = abs(numOne);
			var resNumTwo = abs(numTwo);
			var resNegOne = abs(negOne);
			var resNegTwo = abs(negTwo);
			    
			assert_equals(resNumOne, 5.5, "#5 fractional positive");
			assert_equals(resNumTwo, 7.7, "#6 fractional positive two");
			assert_equals(resNegOne, 9.9, "#7 fractional negative one");
			assert_equals(resNegTwo, 15.1, "#8 fractional negative two");
		}
			
		// Literals
		{
			// Test local
			assert_equals(abs(7.7), 7.7, "#1 Literals Positive");
			assert_equals(abs(0.3), 0.3, "#2 Literals Positive");
			assert_equals(abs(-4.4), 4.4, "#1 Literals Negative");
			assert_equals(abs(-6.6), 6.6, "#2 Literals Negative");
		}
			
		// Int32
		{
			{
			    // The only way to generate an int32 is to read it from a buffer
			    var _buffer = buffer_create(16, buffer_fixed, 1 );
			    buffer_write(_buffer, buffer_s32, 0x0A);
			    var _vInt = buffer_peek(_buffer, 0, buffer_s32);
			    var absInt = abs(_vInt);
			    assert_equals(absInt, 10, "#1 Int32 Abs Positive" );
					
				// Clean up
				buffer_delete(_buffer);
			}
			{
			    // The only way to generate an int32 is to read it from a buffer
			    var _buffer = buffer_create(16, buffer_fixed, 1 );
			    buffer_write(_buffer, buffer_s32, 0xFFFFFF80);
			    var _vInt = buffer_peek(_buffer, 0, buffer_s32);
			    var absInt = abs(_vInt);
			    assert_equals(absInt, 128, "#1 Int32 Abs Negative" );
					
				// Clean up
				buffer_delete(_buffer);
			}
		}
			
		// Int64
		{
			{
			    // The only way to generate an int32 is to read it from a buffer
			    var bigInt = 0x80000000;
			    assert_true(is_int64(bigInt), "bigInt is the incorrect type");
			    var absInt = abs(bigInt);
			    assert_true(is_real(absInt), "absInt is not a real"); // Currently absInt is returned as a real. 
			    //assert_true(is_int64(absInt), "absInt is the incorrect type");
			    assert_equals(absInt, 0x80000000, "#1 Int64 Abs Positive" );
			}
			{
			    // The only way to generate an int32 is to read it from a buffer
			    var bigInt = 0xFFFFFFFF12345678;
			    assert_true(is_int64(bigInt), "bigInt is the incorrect type");        
			    var absInt = abs(bigInt);
			    assert_true(is_real(absInt), "absInt is not a real"); // Currently absInt is returned as a real. 
			    //assert_true(is_int64(absInt), "absInt is the incorrect type");
			    assert_equals(absInt, 3989547400, "#1 Int64 Abs Negative" );
			}
		}
			
		//show_debug_message("Abs test end");
	})

	addFact("angle_difference_test", function() {

		//angle_difference test
		//show_debug_message("start angle_difference() test");
			
		var _result;
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90, 170);
		assert_equals(_result, -80, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90, -170);
		assert_equals(_result, -100, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-90, 170);
		assert_equals(_result, 100, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-90, -170);
		assert_equals(_result, 80, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(0, 10);
		assert_equals(_result, -10, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(0, -10);
		assert_equals(_result, 10, "#1 angle_difference( real const , real const )")
			
			
		// test distance = 0
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90, 90);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-270, 90);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90, -270);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-540, 540);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-2160, 1080);
		assert_equals(_result, 0, "#1 angle_difference( real const , real const )")
			
			
		// test large range
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(2100, 1080);
		assert_equals(_result, -60, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(2100, -1080);
		assert_equals(_result, -60, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-2100, 1080);
		assert_equals(_result, 60, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-2100, -1080);
		assert_equals(_result, 60, "#1 angle_difference( real const , real const )")
			
			
		// test decimal values
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90.5, 95.5);
		assert_equals(_result, -5, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90.75, 95.5);
		assert_equals(_result, -4.75, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(90, -170.5);
		assert_equals(_result, -99.5, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-90, 170.5);
		assert_equals(_result, 99.5, "#1 angle_difference( real const , real const )")
			
		//#1 angle_difference( real const , real const )
		_result = angle_difference(-90, -170.5);
		assert_equals(_result, 80.5, "#1 angle_difference( real const , real const )")
			
			
			
		// test local real/int/int64 types
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 90);
		buffer_write(_buffer, buffer_f32, 270);
		buffer_write(_buffer, buffer_s32, 90);
		buffer_write(_buffer, buffer_s32, 270);
		buffer_write(_buffer, buffer_u64, 90);
		buffer_write(_buffer, buffer_u64, 270);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
			
		//#1 angle_difference( real local , real local )
		_result = angle_difference(_vReal1, _vReal2);
		assert_equals(_result, -180, "#1 angle_difference( real local , real local )")
			
		//#1 angle_difference( real local , real local )
		_result = angle_difference(-_vReal1, _vReal2);
		assert_equals(_result, 0, "#1 angle_difference( real local , real local )")
			
		//#1 angle_difference( real local , real local )
		_result = angle_difference(_vReal1, -_vReal2);
		assert_equals(_result, 0, "#1 angle_difference( real local , real local )")
			
		//#1 angle_difference( real local , real local )
		_result = angle_difference(-_vReal1, -_vReal2);
		assert_equals(_result, -180, "#1 angle_difference( real local , real local )")
			
			
		//#1 angle_difference( int local , int local )
		_result = angle_difference(_vInt1, _vInt2);
		assert_equals(_result, -180, "#1 angle_difference( int local , int local )")
			
		//#1 angle_difference( int local , int local )
		_result = angle_difference(-_vInt1, _vInt2);
		assert_equals(_result, 0, "#1 angle_difference( int local , int local )")
			
		//#1 angle_difference( int local , int local )
		_result = angle_difference(_vInt1, -_vInt2);
		assert_equals(_result, 0, "#1 angle_difference( int local , int local )")
			
		//#1 angle_difference( int local , int local )
		_result = angle_difference(-_vInt1, -_vInt2);
		assert_equals(_result, -180, "#1 angle_difference( int local , int local )")
			
			
		//#1 angle_difference( int64 local , int64 local )
		_result = angle_difference(_vInt64_1, _vInt64_2);
		assert_equals(_result, -180, "#1 angle_difference( int64 local , int64 local )")
			
		//#1 angle_difference( int64 local , int64 local )
		_result = angle_difference(-_vInt64_1, _vInt64_2);
		assert_equals(_result, 0, "#1 angle_difference( int64 local , int64 local )")
			
		//#1 angle_difference( int64 local , int64 local )
		_result = angle_difference(_vInt64_1, -_vInt64_2);
		assert_equals(_result, 0, "#1 angle_difference( int64 local , int64 local )")
			
		//#1 angle_difference( int64 local , int64 local )
		_result = angle_difference(-_vInt64_1, -_vInt64_2);
		assert_equals(_result, -180, "#1 angle_difference( int64 local , int64 local )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("arccos_input_range_test", function() {

		// arccos input range test
		assert_throw(function() {
			var _number = 1.1
			return arccos(_number);	
		}, "#1 Passing an out of range value to arccos (should throw error)");

	})

	addFact("arccos_test", function() {

		// arccos test
			
		//show_debug_message("Begin arccos test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		#macro half_pi_ArccosTest (pi/2)
			
		// Basic tests
		var arccosZero = arccos(0)
		var arccosOne = arccos(1)
		var arccosNegOne = arccos(-1)
		assert_equals(arccosZero, half_pi_ArccosTest, "#1 arccos(0) == half_pi_ArccosTest")
		assert_equals(arccosOne, 0, "#2 arccos(1) == 0")
		assert_equals(arccosNegOne, pi, "#3 arccos(-1) == pi")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = arccos(_yPos)
			assert_greater_or_equal(_xPos, 0, "X Pos should always be greater than 0")
			assert_less_or_equal(_xPos, pi, "X Pos should always be less than pi")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End arccos test")
	})

	addFact("arcsin_input_range_test", function() {

		// Arcsin input range test
		assert_throw(function() {
			var _number = 1.1
			return arcsin(_number);	
		}, "#1 Passing an out of range value to 'arcsin' (should throw error)");
	})

	addFact("arcsin_test", function() {

		// arcsin test
			
		//show_debug_message("Begin arcsin test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		#macro half_pi_ArcsinTest (pi/2)
			
		// Basic tests
		var arcsinZero = arcsin(0)
		var arcsinOne = arcsin(1)
		var arcsinNegOne = arcsin(-1)
		assert_equals(arcsinZero, 0, "#1 arcsin(0) == 0")
		assert_equals(arcsinOne, half_pi_ArcsinTest, "#2 arcsin(1) == half_pi_ArcsinTest")
		assert_equals(arcsinNegOne, (-half_pi_ArcsinTest), "#3 arcsin(-1) == -half_pi_ArcsinTest")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = arcsin(_yPos)
			assert_greater_or_equal(_xPos, -half_pi_ArcsinTest, "X Pos should always be greater than -half_pi_ArcsinTest")
			assert_less_or_equal(_xPos, half_pi_ArcsinTest, "X Pos should always be less than half_pi_ArcsinTest")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End arcsin test")
	})

	addFact("arctan2_test", function() {

		// arctan2 test
		//show_debug_message("Begin arctan2 test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Constants
		#macro quarter_pi_Arctan2Test (pi/4)
		#macro two_pi_Arctan2Test (pi*2)
			
		// Basic tests
		var twoOverTwo = arctan2(2, 2)
		var twoOverNegativeTwo = arctan2(2, -2)
		var negativeTwoOverTwo = arctan2(-2, 2)
		var negativeOverNegative = arctan2(-2, -2)
		assert_equals(twoOverTwo, quarter_pi_Arctan2Test, "#1 arctan2(2, 2) == pi/4")
		assert_equals(twoOverNegativeTwo, (pi - quarter_pi_Arctan2Test), "#2 arctan2(2, -2) == pi - (pi/4)")
		assert_equals(negativeTwoOverTwo, -(quarter_pi_Arctan2Test), "#3 arctan2(-2, 2) == -(pi/4)")
		assert_equals(negativeOverNegative, -(pi - quarter_pi_Arctan2Test), "#4 arctan2(-2, -2) == -(pi - (pi/4)")
			
		var _res1 = arctan2(      1,    0.5)
		var _res2 = arctan2(    0.5,   0.75)
		var _res3 = arctan2(    0.4,  -0.66)
		var _res4 = arctan2(    0.4,   0.66)
		var _res5 = arctan2(    0.9,    0.1)
		var _res6 = arctan2(    0.3,   0.75)
		var _res7 = arctan2( -0.123, -0.456)
		var _res8 = arctan2( -0.789,  0.123)
		var _res9 = arctan2( -0.321,      1)
		assert_equals(_res1,   1.10715     , ("_res1 ==  1.10715 "))
		assert_equals(_res2,   0.588003    , ("_res2 ==  0.588003"))
		assert_equals(_res3,   2.59673     , ("_res3 ==  2.59673 "))
		assert_equals(_res4,   0.544864    , ("_res4 ==  0.544864"))
		assert_equals(_res5,   1.46014     , ("_res5 ==  1.46014 "))
		assert_equals(_res6,   0.380506    , ("_res6 ==  0.380506"))
		assert_equals(_res7,  -2.87813     , ("_res7 == -2.87813 "))
		assert_equals(_res8,  -1.41615     , ("_res8 == -1.41615 "))
		assert_equals(_res9,  -0.31061     , ("_res9 == -0.31061 "))
			
		//show_debug_message("End arctan2 test")
	})

	addFact("arctan_test", function() {

		// Arctan test
		//show_debug_message("Begin arctan test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Constants
		#macro quarter_pi_ArctanTest (pi/4)
		#macro half_pi_ArctanTest (pi/2)
			
		// Basic tests
		var atanZero = arctan(0)
		var atanOne = arctan(1)
		var atanNegOne = arctan(-1)
		assert_equals(atanZero, 0, "#1 arctan(0) == 0")
		assert_equals(atanOne, quarter_pi_ArctanTest, "#2 arctan(1) == pi/4")
		assert_equals(atanNegOne, -(quarter_pi_ArctanTest), "#3 (arctan(-1) == -(pi/4)")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = arctan(_yPos)
			assert_greater_or_equal(_xPos, -(half_pi_ArctanTest), "X Pos should always be greater than -(pi/2)")
			assert_less_or_equal(_xPos, half_pi_ArctanTest, "X Pos should always be less than (pi/2)")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End arctan test")
	})

	addFact("ceil_test", function() {

		// Ceil test
		//show_debug_message("Ceil test");
			
		// Set up test data
		var numOne = 2.3;
		var numTwo = 3.8;
		var negOne = -2.3;
		var negTwo = -3.8;
			
		// Run the Ceil operation
		var resOne = ceil(numOne);
		var resTwo = ceil(numTwo);
		var resNegOne = ceil(negOne);
		var resNegTwo = ceil(negTwo);
			
		// Assert initial results
		assert_equals(resOne, 3.0, "#1 Positive");
		assert_equals(resTwo, 4.0, "#2 Positive");
		assert_equals(resNegOne, -2.0, "#1 Negative");
		assert_equals(resNegTwo, -3.0, "#2 Negative");
			
		// Test local
		assert_equals(ceil(7.7), 8.0, "#1 Local Positive");
		assert_equals(ceil(0.3), 1.0, "#2 Local Positive");
		assert_equals(ceil(-4.4), -4.0, "#1 Local Negative");
		assert_equals(ceil(-6.6), -6.0, "#2 Local Negative");
			
		//show_debug_message("Ceil test end");
	})

	addFact("clamp_test", function() {

		//clamp test
		//show_debug_message("start clamp() test");
			
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 4.5);
		buffer_write(_buffer, buffer_f32, 0.1);
		buffer_write(_buffer, buffer_f32, 12.5);
		buffer_write(_buffer, buffer_s32, 200);
		buffer_write(_buffer, buffer_s32, 100);
		buffer_write(_buffer, buffer_s32, 300);
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_write(_buffer, buffer_u64, 1000);
		buffer_write(_buffer, buffer_u64, 10000);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal1 = buffer_read(_buffer, buffer_f32);
		var _vReal2 = buffer_read(_buffer, buffer_f32);
		var _vReal_3 = buffer_read(_buffer, buffer_f32);
			
		var _vInt1 = buffer_read(_buffer, buffer_s32);
		var _vInt2 = buffer_read(_buffer, buffer_s32);
		var _vInt_3 = buffer_read(_buffer, buffer_s32);
			
		var _vInt64_1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_3 = buffer_read(_buffer, buffer_u64);
			
			
		var _result;
			
		//#1 clamp( real local, real local , real local )
		_result = clamp( _vReal1, _vReal2 , _vReal_3 );
		assert_equals(_result, _vReal1, "#1 clamp( real local, real local , real local )")
			
		//#2 clamp( real local, real local , real local )
		_result = clamp(_vReal2, _vReal1 , _vReal_3 );
		assert_equals(_result, _vReal1, "#2 clamp( real local, real local , real local )")
			
		//#3 clamp( real local, real local , real local )
		_result = clamp(_vReal_3, _vReal2, _vReal1);
		assert_equals(_result, _vReal1, "#3 clamp( real local, real local , real local )")
			
		//#4 clamp( real local, real local , real local ) - min/max flipped
		_result = clamp(_vReal1, _vReal_3, _vReal2);
		assert_equals(_result, _vReal2, "#4 clamp( real local, real local , real local ) - min/max flipped")
			
		//#5 clamp( real local, real local , real local ) - min/max flipped
		_result = clamp(_vReal_3, _vReal1, _vReal2);
		assert_equals(_result, _vReal2, "#5 clamp( real local, real local , real local ) - min/max flipped" )
			
		//#6 clamp( real local, real local , real local ) - min/max negative
		_result = clamp(_vReal1, -_vReal_3, -_vReal2);
		assert_equals(_result, -_vReal2, "#6 clamp( real local, real local , real local ) - min/max negative")
			
		//#7 clamp( real local, real local , real local ) - min/max flipped and negative
		_result = clamp(_vReal1, -_vReal2, -_vReal_3);
		assert_equals(_result, -_vReal_3, "#7 clamp( real local, real local , real local ) - min/max flipped and negative")
			
		// negative value
			
		//#8 clamp( real local, real local , real local )
		_result = clamp( -_vReal1, _vReal2 , _vReal_3 );
		assert_equals(_result, _vReal2, "#8 clamp( real local, real local , real local )")
			
		//#9 clamp( real local, real local , real local )
		_result = clamp(-_vReal2, _vReal1 , _vReal_3 );
		assert_equals(_result, _vReal1, "#9 clamp( real local, real local , real local )")
			
		//#10 clamp( real local, real local , real local )
		_result = clamp(-_vReal_3, _vReal2, _vReal1);
		assert_equals(_result, _vReal2, "#10 clamp( real local, real local , real local )")
			
		//#11 clamp( real local, real local , real local ) - min/max flipped
		_result = clamp(-_vReal1, _vReal_3, _vReal2);
		assert_equals(_result, _vReal2, "#11 clamp( real local, real local , real local ) - min/max flipped")
			
		//#12 clamp( real local, real local , real local ) - min/max flipped
		_result = clamp(-_vReal_3, _vReal1, _vReal2);
		assert_equals(_result, _vReal2, "#12 clamp( real local, real local , real local ) - min/max flipped" )
			
		//#13 clamp( real local, real local , real local ) - min/max negative
		_result = clamp(-_vReal1, -_vReal_3, -_vReal2);
		assert_equals(_result, -_vReal1, "#13 clamp( real local, real local , real local ) - min/max negative")
			
		//#14 clamp( real local, real local , real local ) - min/max flipped and negative
		_result = clamp(-_vReal1, -_vReal2, -_vReal_3);
		assert_equals(_result, -_vReal_3, "#14 clamp( real local, real local , real local ) - min/max flipped and negative")
			
			
			
		//#15 clamp( int local, int local , int local )
		_result = clamp( _vInt1, _vInt2 , _vInt_3 );
		assert_equals(_result, _vInt1, "#15 clamp( int local, int local , int local )")
			
		//#16 clamp( int local, int local , int local )
		_result = clamp(_vInt2, _vInt1 , _vInt_3 );
		assert_equals(_result, _vInt1, "#16 clamp( int local, int local , int local )")
			
		//#17 clamp( int local, int local , int local )
		_result = clamp(_vInt_3, _vInt2, _vInt1);
		assert_equals(_result, _vInt1, "#173 clamp( int local, int local , int local )")
			
		//#18 clamp( int local, int local , int local ) - min/max flipped
		_result = clamp(_vInt1, _vInt_3, _vInt2);
		assert_equals(_result, _vInt2, "#18 clamp( int local, int local , int local ) - min/max flipped")
			
		//#19 clamp( int local, int local , int local ) - min/max flipped
		_result = clamp(_vInt_3, _vInt1, _vInt2);
		assert_equals(_result, _vInt2, "#19 clamp( int local, int local , int local ) - min/max flipped" )
			
		//#20 clamp( int local, int local , int local ) - min/max negative
		_result = clamp(_vInt1, -_vInt_3, -_vInt2);
		assert_equals(_result, -_vInt2, "#20 clamp( int local, int local , int local ) - min/max negative")
			
		//#21 clamp( int local, int local , int local ) - min/max flipped and negative
		_result = clamp(_vInt1, -_vInt2, -_vInt_3);
		assert_equals(_result, -_vInt_3, "#21 clamp( int local, int local , int local ) - min/max flipped and negative")
			
		// negative value
			
		//#22 clamp( int local, int local , int local )
		_result = clamp( -_vInt1, _vInt2 , _vInt_3 );
		assert_equals(_result, _vInt2, "#22 clamp( int local, int local , int local )")
			
		//#23 clamp( int local, int local , int local )
		_result = clamp(-_vInt2, _vInt1 , _vInt_3 );
		assert_equals(_result, _vInt1, "#23 clamp( int local, int local , int local )")
			
		//#24 clamp( int local, int local , int local )
		_result = clamp(-_vInt_3, _vInt2, _vInt1);
		assert_equals(_result, _vInt2, "#24 clamp( int local, int local , int local )")
			
		//#25 clamp( int local, int local , int local ) - min/max flipped
		_result = clamp(-_vInt1, _vInt_3, _vInt2);
		assert_equals(_result, _vInt2, "#25 clamp( int local, int local , int local ) - min/max flipped")
			
		//#26 clamp( int local, int local , int local ) - min/max flipped
		_result = clamp(-_vInt_3, _vInt1, _vInt2);
		assert_equals(_result, _vInt2, "#26 clamp( int local, int local , int local ) - min/max flipped" )
			
		//#27 clamp( int local, int local , int local ) - min/max negative
		_result = clamp(-_vInt1, -_vInt_3, -_vInt2);
		assert_equals(_result, -_vInt1, "#27 clamp( int local, int local , int local ) - min/max negative")
			
		//#28 clamp( int local, int local , int local ) - min/max flipped and negative
		_result = clamp(-_vInt1, -_vInt2, -_vInt_3);
		assert_equals(_result, -_vInt_3, "#28 clamp( int local, int local , int local ) - min/max flipped and negative")
			
			
			
		//#29 clamp( int64 local, int64 local , int64 local )
		_result = clamp( _vInt64_1, _vInt64_2 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#29 clamp( int64 local, int64 local , int64 local )")
			
		//#30 clamp( int64 local, int64 local , int64 local )
		_result = clamp(_vInt64_2, _vInt64_1 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#30 clamp( int64 local, int64 local , int64 local )")
			
		//#31 clamp( int64 local, int64 local , int64 local )
		_result = clamp(_vInt64_3, _vInt64_2, _vInt64_1);
		assert_equals(_result, _vInt64_1, "#31 clamp( int64 local, int64 local , int64 local )")
			
		//#32 clamp( int64 local, int64 local , int64 local ) - min/max flipped
		_result = clamp(_vInt64_1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#32 clamp( int64 local, int64 local , int64 local ) - min/max flipped")
			
		//#33 clamp( int64 local, int64 local , int64 local ) - min/max flipped
		_result = clamp(_vInt64_3, _vInt64_1, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#33 clamp( int64 local, int64 local , int64 local ) - min/max flipped" )
			
		//#34 clamp( int64 local, int64 local , int64 local ) - min/max negative
		_result = clamp(_vInt64_1, -_vInt64_3, -_vInt64_2);
		assert_equals(_result, -_vInt64_2, "#34 clamp( int64 local, int64 local , int64 local ) - min/max negative")
			
		//#35 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative
		_result = clamp(_vInt64_1, -_vInt64_2, -_vInt64_3);
		assert_equals(_result, -_vInt64_3, "#35 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative")
			
		// negative value
			
		//#36 clamp( int64 local, int64 local , int64 local )
		_result = clamp( -_vInt64_1, _vInt64_2 , _vInt64_3 );
		assert_equals(_result, _vInt64_2, "#36 clamp( int64 local, int64 local , int64 local )")
			
		//#37 clamp( int64 local, int64 local , int64 local )
		_result = clamp(-_vInt64_2, _vInt64_1 , _vInt64_3 );
		assert_equals(_result, _vInt64_1, "#37 clamp( int64 local, int64 local , int64 local )")
			
		//#38 clamp( int64 local, int64 local , int64 local )
		_result = clamp(-_vInt64_3, _vInt64_2, _vInt64_1);
		assert_equals(_result, _vInt64_2, "#38 clamp( int64 local, int64 local , int64 local )")
			
		//#39 clamp( int64 local, int64 local , int64 local ) - min/max flipped
		_result = clamp(-_vInt64_1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#39 clamp( int64 local, int64 local , int64 local ) - min/max flipped")
			
		//#40 clamp( int64 local, int64 local , int64 local ) - min/max flipped
		_result = clamp(-_vInt64_3, _vInt64_1, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#40 clamp( int64 local, int64 local , int64 local ) - min/max flipped" )
			
		//#41 clamp( int64 local, int64 local , int64 local ) - min/max negative
		_result = clamp(-_vInt64_1, -_vInt64_3, -_vInt64_2);
		assert_equals(_result, -_vInt64_1, "#41 clamp( int64 local, int64 local , int64 local ) - min/max negative")
			
		//#42 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative
		_result = clamp(-_vInt64_1, -_vInt64_2, -_vInt64_3);
		assert_equals(_result, -_vInt64_3, "#42 clamp( int64 local, int64 local , int64 local ) - min/max flipped and negative")
			
			
			
		//#43 clamp( real const, real const , real const )
		_result = clamp( 4.5, 0.1 , 12.5 );
		assert_equals(_result, 4.5, "#43 clamp( real const, real const , real const )")
			
		//#44 clamp( real const, real const , real const )
		_result = clamp(0.1, 4.5 , 12.5 );
		assert_equals(_result, 4.5, "#44 clamp( real const, real const , real const )")
			
		//#45 clamp( real const, real const , real const )
		_result = clamp(12.5, 0.1, 4.5);
		assert_equals(_result, 4.5, "#45 clamp( real const, real const , real const )")
			
		//#46 clamp( real const, real const , real const ) - min/max flipped
		_result = clamp(4.5, 12.5, 0.1);
		assert_equals(_result, 0.1, "#46 clamp( real const, real const , real const ) - min/max flipped")
			
		//#47 clamp( real const, real const , real const ) - min/max flipped
		_result = clamp(12.5, 4.5, 0.1);
		assert_equals(_result, 0.1, "#47 clamp( real const, real const , real const ) - min/max flipped" )
			
		//#48 clamp( real const, real const , real const ) - min/max negative
		_result = clamp(4.5, -12.5, -0.1);
		assert_equals(_result, -0.1, "#48 clamp( real const, real const , real const ) - min/max negative")
			
		//#49 clamp( real const, real const , real const ) - min/max flipped and negative
		_result = clamp(4.5, -0.1, -12.5);
		assert_equals(_result, -12.5, "#49 clamp( real const, real const , real const ) - min/max flipped and negative")
			
		// negative value
			
		//#50 clamp( real const, real const , real const )
		_result = clamp( -4.5, 0.1 , 12.5 );
		assert_equals(_result, 0.1, "#50 clamp( real const, real const , real const )")
			
		//#51 clamp( real const, real const , real const )
		_result = clamp(-0.1, 4.5 , 12.5 );
		assert_equals(_result, 4.5, "#51 clamp( real const, real const , real const )")
			
		//#52 clamp( real const, real const , real const )
		_result = clamp(-12.5, 0.1, 4.5);
		assert_equals(_result, 0.1, "#52 clamp( real const, real const , real const )")
			
		//#53 clamp( real const, real const , real const ) - min/max flipped
		_result = clamp(-4.5, 12.5, 0.1);
		assert_equals(_result, 0.1, "#53 clamp( real const, real const , real const ) - min/max flipped")
			
		//#54 clamp( real const, real const , real const ) - min/max flipped
		_result = clamp(-12.5, 4.5, 0.1);
		assert_equals(_result, 0.1, "#54 clamp( real const, real const , real const ) - min/max flipped" )
			
		//#55 clamp( real const, real const , real const ) - min/max negative
		_result = clamp(-4.5, -12.5, -0.1);
		assert_equals(_result, -4.5, "#55 clamp( real const, real const , real const ) - min/max negative")
			
		//#56 clamp( real const, real const , real const ) - min/max flipped and negative
		_result = clamp(-4.5, -0.1, -12.5);
		assert_equals(_result, -12.5, "#56 clamp( real const, real const , real const ) - min/max flipped and negative")
			
		// mixed numeric types
			
		//#57 clamp( real local, real local , real local )
		_result = clamp(_vInt1, _vReal2, _vReal_3);
		assert_equals(_result, _vReal_3, "#57 clamp( int local, real local , real local )")
			
		//#58 clamp( real local, real local , real local )
		_result = clamp(_vInt1, _vInt64_2, _vInt64_3);
		assert_equals(_result, _vInt64_2, "#58 clamp( int local, real local , real local )")
			
		//#59 clamp( real local, real local , real local )
		_result = clamp(_vInt64_1, _vReal2, _vReal_3 );
		assert_equals(_result, _vReal_3, "#59 clamp( int64 local, real local , real local )")
			
		//#60 clamp( real local, real local , real local )
		_result = clamp(_vInt64_1, _vInt2, _vInt_3 );
		assert_equals(_result, _vInt_3, "#60 clamp( int64 local, real local , real local )")
			
		//#61 clamp( real local, int local , int local )
		_result = clamp(_vReal1, _vInt2, _vInt_3);
		assert_equals(_result, _vInt2, "#61 clamp( real local, int local , int local )")
			
		//#62 clamp( real local, int64 local , int64 local ) - min/max flipped
		_result = clamp(_vReal1, _vInt64_3, _vInt64_2);
		assert_equals(_result, _vInt64_2, "#62 clamp( real local, real local , real local ) - min/max flipped")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("cos_test", function() {

		// Cos (radian angle) Test
			
		//show_debug_message("Begin cos test")
			
		// Basic tests
		var cosZero = cos(0)
		var cosPi = cos(pi)
		var cosTwoPi = cos(2*pi)
		assert_equals(cosZero, 1, "#1 cos(0) equals 1")
		assert_equals(cosPi, -1, "#2 cos(pi) equals -1")
		assert_equals(cosTwoPi, 1, "#3 cos(2*pi) equals 1")
			
		var _xPos = 0
		while (_xPos < (2*pi))
		{
			assert_less_or_equal(_xPos, (2*pi), "Ensure _xPos is always less than 2*pi")
			
			var _yPos = cos(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")
			
			_xPos += 0.01
		}
			
		//show_debug_message("End cos test")
	})

	addFact("darccos_input_range_test", function() {

		// darccos input range test
		assert_throw(function() {
			var _number = 1.1
			return darccos(_number);	
		}, "#1 Passing an out of range value to 'darccos' (should throw error)");
	})

	addFact("darccos_test", function() {

		// darccos test
			
		//show_debug_message("Begin darccos test")
			
		// Basic tests
		var arccosZero = darccos(0)
		var arccosOne = darccos(1)
		var arccosNegOne = darccos(-1)
		assert_equals(arccosZero, 90.0, "#1 darccos(0) == 90")
		assert_equals(arccosOne, 0, "#2 darccos(1) == 0")
		assert_equals(arccosNegOne, 180.0, "#3 darccos(-1) == 180")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = darccos(_yPos)
			assert_greater_or_equal(_xPos, 0, "X Pos should always be greater than 0")
			assert_less_or_equal(_xPos, 180.0, "X Pos should always be less than 180")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End darccos test")
	})

	addFact("darcsin_input_range_test", function() {

		// darcsin input range test
		assert_throw(function() {
			var _number = 1.1
			return darcsin(_number);	
		}, "#1 Passing an out of range value to 'darcsin' (should throw error)");
	})

	addFact("darcsin_test", function() {

		// darcsin test
			
		//show_debug_message("Begin darcsin test")
			
		// Basic tests
		var arcsinZero = darcsin(0)
		var arcsinOne = darcsin(1)
		var arcsinNegOne = darcsin(-1)
		assert_equals(arcsinZero, 0, "#1 darcsin(0) == 0")
		assert_equals(arcsinOne, 90, "#2 darcsin(1) == 90")
		assert_equals(arcsinNegOne, (-90), "#3 darcsin(-1) == -90")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = darcsin(_yPos)
			assert_greater_or_equal(_xPos, -90, "X Pos should always be greater than -90")
			assert_less_or_equal(_xPos, 90, "X Pos should always be less than 90")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End darcsin test")
	})

	addFact("darctan2_test", function() {

		// darctan2 test
		//show_debug_message("Begin darctan2 test")
			
		// Basic tests
		var twoOverTwo = darctan2(2, 2)
		var twoOverNegativeTwo = darctan2(2, -2)
		var negativeTwoOverTwo = darctan2(-2, 2)
		var negativeOverNegative = darctan2(-2, -2)
		assert_equals(twoOverTwo, 45, "#1 darctan2(2, 2) == 45deg")
		assert_equals(twoOverNegativeTwo, 135, "#2 darctan2(2, -2) == 135deg")
		assert_equals(negativeTwoOverTwo, -45, "#3 darctan2(-2, 2) == -45deg")
		assert_equals(negativeOverNegative, -135, "#4 darctan2(-2, -2) == -135deg")
			
		var _res1 = darctan2(      1,    0.5)
		var _res2 = darctan2(    0.5,   0.75)
		var _res3 = darctan2(    0.4,  -0.66)
		var _res4 = darctan2(    0.4,   0.66)
		var _res5 = darctan2(    0.9,    0.1)
		var _res6 = darctan2(    0.3,   0.75)
		var _res7 = darctan2( -0.123, -0.456)
		var _res8 = darctan2( -0.789,  0.123)
			
		assert_equals(_res1,  63.4349479675293    , ("_res1 ==  63.4349 "))
		assert_equals(_res2,  33.6900672912598    , ("_res2 ==  33.6901 "))
		assert_equals(_res3,  148.781600952148    , ("_res3 ==  148.782 "))
		assert_equals(_res4,  31.2184009552002    , ("_res4 ==  31.2184 "))
		assert_equals(_res5,  83.6598052978516    , ("_res5 ==  83.6598 "))
		assert_equals(_res6,  21.8014087677002    , ("_res6 ==  21.8014 "))
		assert_equals(_res7,  -164.90447          , ("_res7 == -164.904 "))
		assert_equals(_res8,  -81.1392822265625   , ("_res8 == -81.1393 "))
			
		//show_debug_message("End darctan2 test")
	})

	addFact("darctan_test", function() {

		// Arctan test
		//show_debug_message("Begin darctan test")
			
		// Basic tests
		var atanZero = darctan(0)
		var atanOne = darctan(1)
		var atanNegOne = darctan(-1)
		assert_equals(atanZero, 0, "#1 darctan(0) == 0")
		assert_equals(atanOne, 45, "#2 darctan(1) == 45")
		assert_equals(atanNegOne, -45, "#3 (darctan(-1) == -45")
			
		// Range test
		var _yPos = -1
		while (_yPos <= 1)
		{
			assert_less_or_equal(_yPos, (1), "Ensure _yPos is always less than 1")
			
			var _xPos = darctan(_yPos)
			assert_greater_or_equal(_xPos, -90, "X Pos should always be greater than -90")
			assert_less_or_equal(_xPos, 90, "X Pos should always be less than 90")
			
			_yPos += 0.01
		}
			
		//show_debug_message("End darctan test")
	})

	addFact("dcos_test", function() {

		// dcos Test
			
		//show_debug_message("Begin dcos test")
			
		// Basic tests
		var dcos0 = dcos(0)
		var dcosPi = dcos(180.0)
		var dcos2Pi = dcos(360.0)
		assert_equals(dcos0, 1, "#1 dcos(0) equals 1")
		assert_equals(dcosPi, -1, "#2 dcos(pi) equals -1")
		assert_equals(dcos2Pi, 1, "#3 dcos(2*pi) equals 1")
			
		#macro upper_limit_DcosTest (360.0)
			
		var _xPos = 0
		while (_xPos < upper_limit_DcosTest)
		{
			assert_less_or_equal(_xPos, upper_limit_DcosTest, "Ensure _xPos is always less than 360")
			
			var _yPos = dcos(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")
			
			_xPos += 0.5
		}
			
		//show_debug_message("End dcos test")
	})

	addFact("degtorad_test", function() {

		// degtorad test
			
		//show_debug_message("Begin degtorad test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		{
			var zero = degtorad(0)
			var piTest = degtorad(180)
			var pi_2 = degtorad(90)
			var pi_4 = degtorad(45)
			var pi_by_2 = degtorad(360)
			assert_equals(zero, 0.0, "0 rad == 0 deg")
			assert_equals(piTest, pi, "Pi rad == 180 deg")
			assert_equals(pi_2, (pi/2), "Pi/2 rad == 90 deg")
			assert_equals(pi_4, (pi/4), "Pi/4 rad == 45 deg")
			assert_equals(pi_by_2, (pi*2), "2*Pi rad == 360 deg")
		}
			
		// Vars
		{
			var zero_deg = 0
			var oneEighty = 180
			var ninety = 90
			var fortyFive = 45
			var threeSixty = 360
			
			var zero_rad = degtorad(zero_deg)
			var piTest_rad = degtorad(oneEighty)
			var pi_2_rad = degtorad(ninety)
			var pi_4_rad = degtorad(fortyFive)
			var pi_by_2_rad = degtorad(threeSixty)
			assert_equals(zero_rad, 0.0, "0 rad == 0 deg")
			assert_equals(piTest_rad, pi, "Pi rad == 180 deg")
			assert_equals(pi_2_rad, (pi/2), "Pi/2 rad == 90 deg")
			assert_equals(pi_4_rad, (pi/4), "Pi/4 rad == 45 deg")
			assert_equals(pi_by_2_rad, (pi*2), "2*Pi rad == 360 deg")
		}
			
		//show_debug_message("End degtorad test")
	})

	addFact("dot_product_3d_normalised_test", function() {

		// dot_product_3d_normalised test
		//show_debug_message("Begin dot_product_3d_normalised test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		var res0 = dot_product_3d_normalised(0, 0, 0, 0, 0, 0)
		assert_true(is_nan(res0), "#0 Normalised Dot product of two zero vectors is NaN");
			
		var _res1 = dot_product_3d_normalised(0.5, 0.5, 0.0, -0.5, 0.5, 1.0)
		assert_equals(_res1, 0.0, "#1 Normalised Dot product of two perpendicular is 0")
			
		var _res2 = dot_product_3d_normalised(3.0, 1.0, 0.0, 1.0, -3.0, 0.0)
		assert_equals(_res2, 0.0, "#2 Normalised Dot product of two perpendicular is 0")
			
		var _res3 = dot_product_3d_normalised(2.0, 3.0, 4.0, -3.0, -1.0, 5.0)
		assert_equals(_res3, 0.345270651315, "#3 Normalised Dot product of (2, 3, 4) and (-3, -1, 5) is 0.345270651315")
			
		var _res4 = dot_product_3d_normalised(2.0, 3.0, 4.0, -3.0, -1.0, -5.0)
		assert_equals(_res4, -0.910258989832, "#4 Normalised Dot Product is (2.0, 3.0, 4.0) and (-3.0, -1.0, -5.0) is -0.910258989832")
			
		var _res5 = dot_product_3d_normalised(1.0, 2.0, 3.0, 4.0, 5.0, 6.0)
		assert_equals(_res5, 0.974631786346, "#5 Normalised Dot Product is (1.0, 2.0, 3.0) and (4.0, 5.0, 6.0) is 0.9836991")
			
		var _res6 = dot_product_3d_normalised(1.0, 2.0, 3.0, -4.0, -5.0, -6.0)
		assert_equals(_res6, -0.974631786346, "#6 Normalised Dot Product is (1.0, 2.0, 3.0) and (-4.0, -5.0, -6.0) is -0.9836991")
			
		// Properties of Normalised Dot Product
			
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
			
		// S vs Z
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
			
		//show_debug_message("End dot_product_3d_normalised test")
	})

	addFact("dot_product_3d_test", function() {

		// dot_product_3d test
		//show_debug_message("Begin dot_product_3d test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic 2D tests
		var res0 = dot_product_3d(0, 0, 0, 0, 0, 0)
		assert_equals(res0, 0.0, "#0 Dot product of two zero vectors is 0")
			
		var _res1 = dot_product_3d(0.5, 0.5, 0, -0.5, 0.5, 0)
		assert_equals(_res1, 0.0, "#1 Dot product of two perpendicular is 0")
			
		var _res2 = dot_product_3d(3, 1, 0, 1, -3, 0)
		assert_equals(_res2, 0.0, "#2 Dot product of two perpendicular is 0")
			
		var _res3 = dot_product_3d(2, 3, 0, -3, -1, 0)
		assert_equals(_res3, -9.0, "#3 Dot product of (2,3, 0) and (-3, -1, 0) is -9")
			
		var _res4 = dot_product_3d(1.0, 1.0, 0.0, 0.5, 0.5, 0.0)
		assert_equals(_res4, 1.0, "#4 Dot Product is (1, 1, 0) and (0.5, 0.5, 0.0) is 1")
			
		// Basic 3D tests
			
		var _res5 = dot_product_3d(0, 0, 1, -1, 1, 0)
		////show_debug_message(string(_res5))
		assert_equals(_res5, 0.0, "#1 Dot product of two perpendicular is 0")
			
		var _res6 = dot_product_3d(1, 1, 0, 0, 0, -1)
		////show_debug_message(string(_res6))
		assert_equals(_res6, 0.0, "#1 Dot product of two perpendicular is 0")
			
		var _res7 = dot_product_3d(3, 1, -8, 1, -3, -4)
		assert_equals(_res7, 32.0, "#2 Dot product of (3, 1, -8) and (1, -3, -4) is 0")
			
		var _res8 = dot_product_3d(7, 7, 7, 1, 2, 3)
		assert_equals(_res8, 42.0, "#3 Dot product of (7, 7, 7) and (1, 2, 3) is 42")
			
		var _res9 = dot_product_3d(0.6, 0.5, -5.0, -0.5, 0.5, 1.0)
		assert_equals(_res9, -5.05, "#4 Dot Product is (0.6, 0.5, 0.0) and (-0.5, 0.5, 0.0) is -0.05")
			
		// Properties of Dot Product
			
		// Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, z1, x2, y2, z2;
		x1 = 0.5
		y1 = 0.5
		z1 = 0.0
		x2 = 0.5
		y2 = -0.4
		z2 = 0.0
		var resPos = dot_product_3d(x1, y1, z1, x2, y2, z2)
		////show_debug_message(string(resPos))
		assert_greater(resPos, 0, "#5 dot product must be positive")
			
		// Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, z3, x4, y4, z4;
		x3 = 0.5
		y3 = 0.5
		z3 = 0.0
		x4 = 0.5
		y4 = -0.6
		z4 = 0.0
		var resNeg = dot_product_3d(x3, y3, z3, x4, y4, z4)
		////show_debug_message(string(resNeg))
		assert_less(resNeg, 0, "#6")
			
		//show_debug_message("End dot_product_3d test")
	})

	addFact("dot_product_normalised_test", function() {

		// dot_product_normalised test
		//show_debug_message("Begin dot_product_normalised test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		var res0 = dot_product_normalised(0, 0, 0, 0)
		assert_true(is_nan(res0), "#0 Normalised Dot product of two zero vectors is NaN")
			
		var _res1 = dot_product_normalised(0.5, 0.5, -0.5, 0.5)
		assert_equals(_res1, 0.0, "#1 Normalised Dot product of two perpendicular is 0")
			
		var _res2 = dot_product_normalised(3, 1, 1, -3)
		assert_equals(_res2, 0.0, "#2 Normalised Dot product of two perpendicular is 0")
			
		var _res3 = dot_product_normalised(2, 3, -3, -1)
		assert_equals(_res3, -0.789352238178, "#3 Normalised Dot product of (2,3) and (-3, -1) is -0.79")
			
		var _res4 = dot_product_normalised(1.0, 1.0, 0.5, 0.5)
		assert_equals(_res4, 1.0, "#4 Normalised Dot Product is (1, 1) and (0.5, 0.5) is 1")
			
		var _res5 = dot_product_normalised(1.0, 2.0, 3.0, 4.0)
		assert_equals(_res5, 0.983869910240, "#5 Normalised Dot Product is (1, 2) and (3, 4) is 0.9836991")
			
		var _res6 = dot_product_normalised(1.0, 2.0, -3.0, -4.0)
		assert_equals(_res6, -0.983869910240, "#5 Normalised Dot Product is (1, 2) and (-3, -4) is -0.9836991")
			
		// Properties of Normalised Dot Product
			
		// Normalised Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, x2, y2;
		x1 = 1.5
		y1 = 1.5
		x2 = 1.5
		y2 = -1.2
		var resPos = dot_product_normalised(x1, y1, x2, y2)
		assert_greater(resPos, 0, "#5 dot product normalised must be positive")
			
		// Normalised Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, x4, y4;
		x3 = 1.5
		y3 = 1.5
		x4 = 1.5
		y4 = -1.8
		var resNeg = dot_product_normalised(x3, y3, x4, y4)
		assert_less(resNeg, 0, "#6 dot product normalised must be negative")
			
		// S vs Z
		var sx1, sy1, sx2, sy2;
		sx1 = 1
		sy1 = 2
		sx2 = 3
		sy2 = 4
		var sres1 = dot_product_normalised(sx1, sy1, sx2, sy2)
		var zres1 = dot_product_normalized(sx1, sy1, sx2, sy2)
		assert_equals(sres1, zres1, "S and Z methods should match")
			
		var sx3, sy3, sx4, sy4;
		sx3 = 5
		sy3 = 6
		sx4 = 7
		sy4 = 8
		var sres2 = dot_product_normalised(sx3, sy3, sx4, sy4)
		var zres2 = dot_product_normalized(sx3, sy3, sx4, sy4)
		assert_equals(sres2, zres2, "S and Z methods should match")
			
		var sx5, sy5, sx6, sy6;
		sx5 = 8
		sy5 = 9
		sx6 = 10
		sy6 = 11
		var sres3 = dot_product_normalised(sx5, sy5, sx6, sy6)
		var zres3 = dot_product_normalized(sx5, sy5, sx6, sy6)
		assert_equals(sres3, zres3, "S and Z methods should match")
			
		//show_debug_message("End dot_product_normalised test")
	})

	addFact("dot_product_test", function() {

		// dot_product test
		//show_debug_message("Begin dot_product test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		var res0 = dot_product(0, 0, 0, 0)
		assert_equals(res0, 0.0, "#0 Dot product of two zero vectors is 0")
			
		var _res1 = dot_product(0.5, 0.5, -0.5, 0.5)
		assert_equals(_res1, 0.0, "#1 Dot product of two perpendicular is 0")
			
		var _res2 = dot_product(3, 1, 1, -3)
		assert_equals(_res2, 0.0, "#2 Dot product of two perpendicular is 0")
			
		var _res3 = dot_product(2, 3, -3, -1)
		assert_equals(_res3, -9.0, "#3 Dot product of (2,3) and (-3, -1) is -9")
			
		var _res4 = dot_product(1.0, 1.0, 0.5, 0.5)
		assert_equals(_res4, 1.0, "#4 Dot Product is (1, 1) and (0.5, 0.5) is 1")
			
		// Properties of Dot Product
			
		// Dot product of vectors where angle between < 90 will be positive.
		var x1, y1, x2, y2;
		x1 = 0.5
		y1 = 0.5
		x2 = 0.5
		y2 = -0.4
		var _res5 = dot_product(x1, y1, x2, y2)
		assert_greater(_res5, 0, "#5 dot product must be positive")
			
		// Dot product of vectors where angle between > 90 will be negative.
		var x3, y3, x4, y4;
		x3 = 0.5
		y3 = 0.5
		x4 = 0.5
		y4 = -0.6
		var _res6 = dot_product(x3, y3, x4, y4)
		assert_less(_res6, 0, "#6")
			
		//show_debug_message("End dot_product test")
	})

	addFact("dsin_test", function() {

		// dsin Test
			
		//show_debug_message("Begin dsin test")
			
		// Basic tests
		var sin0 = dsin(0)
		var sinPi = dsin(180.0)
		var sin2Pi = dsin(360.0)
		assert_equals(sin0, 0, "#1 dsin(0) equals zero")
		assert_equals(sinPi, 0, "#2 dsin(pi) equals zero")
		assert_equals(sin2Pi, 0, "#3 dsin(2*pi) equals zero")
			
		#macro upper_limit_DsinTest 360.0
			
		var _xPos = 0
		while (_xPos < (upper_limit_DsinTest))
		{
			assert_less_or_equal(_xPos, (upper_limit_DsinTest), "Ensure _xPos is always less than 360")
			
			var _yPos = dsin(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")
			
			_xPos += 0.5
		}
			
		//show_debug_message("End dsin test")
	})

	addFact("dtan_test", function() {

		// dtan test
			
		//show_debug_message("Begin dtan test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		var dtan0 = dtan(0)
		var dtanPi = dtan(180)
		var dtan2Pi = dtan(360)
		assert_equals(dtan0, 0, "#1 Tan Zero == 0")
		assert_equals(dtanPi, 0, "#2 Tan 180 == 0")
		assert_equals(dtan2Pi, 0, "#3 Tan 360 == 0")
			
		// dtan(x) = 1
		var tanFortyFiveDeg = dtan(45.0)
		var tanTwoTwoFiveDeg = dtan(225.0)
		assert_equals(tanFortyFiveDeg, 1.0, "#4 Tan 45 == 1")
		assert_equals(tanTwoTwoFiveDeg, 1.0, "#5 Tan 225 == 1")
			
		// dtan(x) = -1
		var tanOneThirtyFiveDeg = dtan(135.0)
		var tanThreeFifteenDeg = dtan(315.0)
		assert_equals(tanOneThirtyFiveDeg, -1, "#6 Tan 135 == -1")
		assert_equals(tanThreeFifteenDeg, -1, "#7 Tan 315 == -1")
			
		//show_debug_message("End dtan test")
	})

	addFact("exp_test", function() {

		//exp test
		//show_debug_message("start exp() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10);
		buffer_write(_buffer, buffer_u64, 4);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 exp( real local )
		_result = exp(_vReal);
		assert_equals(_result, 12.1824939607, "#1 exp( real local )")
			
		//#2 exp( int local )
		_result = exp(_vInt);
		assert_equals(_result, 22026.4657948067, "#2 exp( int local )")
			
		//#3 exp( int64 local )
		_result = exp(_vInt64);
		assert_equals(_result, 54.5981500331, "#3 exp( int64 local )")
			
			
		//#4 exp( real const )
		_result = exp(2.5);
		assert_equals(_result, 12.1824939607, "#4 exp( real const )")
			
		//#5 exp( int const )
		_result = exp(10);
		assert_equals(_result, 22026.4657948067, "#5 exp( int const )")
			
		//#6 exp( int64 const )
		_result = exp(int64(4));
		assert_equals(_result, 54.5981500331, "#6 exp( int64 const )")
			
			
		// negative value tests
			
		//#7 exp( real local )
		_result = exp(-_vReal);
		assert_equals(_result, 0.08208499862, "#7 exp( real local )")
			
		//#8 exp( int local )
		_result = exp(-_vInt);
		assert_equals(_result, 0.00004539992, "#8 exp( int local )")
			
		//#9 exp( int64 local )
		_result = exp(-_vInt64);
		assert_equals(_result, 0.01831563888, "#9 exp( int64 local )")
			
			
		//#10 exp( real const )
		_result = exp(-2.5);
		assert_equals(_result, 0.08208499862, "#10 exp( real const )")
			
		//#11 exp( int const )
		_result = exp(-10);
		assert_equals(_result, 0.00004539992, "#11 exp( int const )")
			
		//#12 exp( int64 const )
		_result = exp(int64(-4));
		assert_equals(_result, 0.01831563888, "#12 exp( int64 const )")
			
			
		// zero test
			
		//#13 exp( 0 )
		_result = exp(0);
		assert_equals(_result, 1, "#13 exp( 0 )")
			
		// one test
			
		//#14 exp( 1 )
		_result = exp(1);
		assert_equals(_result, 2.71828182845905, "#14 exp( 1 )")
			
		// infinity test
			
		//#15 exp( infinity )
		_result = exp(_infinity);
		assert_true(is_infinity(_result), "#15 exp( infinity )")
			
		// NaN test
			
		//#16 exp( NaN )
		_result = exp(_nan);
		assert_true(is_nan(_result), "#16 exp( NaN )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("floor_test", function() {

		// Floor test
		//show_debug_message("Floor test");
			
		// Set up test data
		var numOne = 2.3;
		var numTwo = 3.8;
		var negOne = -2.3;
		var negTwo = -3.8;
			
		// Run the floor operation
		var resOne = floor(numOne);
		var resTwo = floor(numTwo);
		var resNegOne = floor(negOne);
		var resNegTwo = floor(negTwo);
			
		// Assert initial results
		assert_equals(resOne, 2.0, "#1 Positive");
		assert_equals(resTwo, 3.0, "#2 Positive");
		assert_equals(resNegOne, -3.0, "#1 Negative");
		assert_equals(resNegTwo, -4.0, "#2 Negative");
			
		// Test local
		assert_equals(floor(7.7), 7.0, "#1 Local Positive");
		assert_equals(floor(0.3), 0.0, "#2 Local Positive");
		assert_equals(floor(-4.4), -5.0, "#1 Local Negative");
		assert_equals(floor(-6.6), -7.0, "#1 Local Negative");
			
		//show_debug_message("Floor test end");
	})

	addFact("frac_test", function() {

		// Frac test
			
		//show_debug_message("Begin frac test")
			
		// Positive tests
		var numOne = 3.125
		var numTwo = 6.921
		var numThree = 3.4
			
		var fracOne = frac(numOne)
		var fracTwo = frac(numTwo)
		var fracThree = frac(numThree)
		assert_equals(fracOne, 0.125, "#1 fracOne = 0.125")
		assert_equals(fracTwo, 0.921, "#2 fracTwo = 0.921")
		assert_equals(fracThree, 0.4, "#3 fracThree = 0.4")
			
		// Negative tests
		var negativeOne = -3.125
		var negativeTwo = -6.921
		var negativeThree = -3.4
			
		var negativeFracOne = frac(negativeOne)
		var negativeFracTwo = frac(negativeTwo)
		var negativeFracThree = frac(negativeThree)
		assert_equals(negativeFracOne, -0.125, "#1 negativeFracOne = -0.125")
		assert_equals(negativeFracTwo, -0.921, "#2 negativeFracTwo = -0.921")
		assert_equals(negativeFracThree, -0.4, "#3 negativeFracThree = -0.4")
			
		// Whole numbers
		var wholeNumOne = 1.0
		var wholeNumTwo = 55.0
		var wholeNumThree = 0.0
		var wholeNumFour = 28
		var wholeNumFive = -44
			
		var wholeFracOne = frac(wholeNumOne)
		var wholeFracTwo = frac(wholeNumTwo)
		var wholeFracThree = frac(wholeNumThree)
		var wholeFracFour = frac(wholeNumFour)
		var wholeFracFive = frac(wholeNumFive)
		assert_equals(wholeFracOne, 0, "#1 Whole number frac() = zero")
		assert_equals(wholeFracTwo, 0, "#2 Whole number frac() = zero")
		assert_equals(wholeFracThree, 0, "#3 Whole number frac() = zero")
		assert_equals(wholeFracFour, 0, "#4 Whole number frac() = zero")
		assert_equals(wholeFracFive, 0, "#5 Whole number frac() = zero")
			
		// Literals
		assert_equals(frac(0.0), 0, "#1 Literal zero")
		assert_equals(frac(654.0), 0, "#2 Literal whole number")
		assert_equals(frac(-654.0), 0, "#3 Literal whole negative number")
		assert_equals(frac(123.456), 0.456, "#4 Literal positive number")
		assert_equals(frac(-123.456), -0.456, "#5 Literal negative number")
			
		//show_debug_message("End frac test")
	})

	addFact("lengthdir_x_test", function() {

		// lengthdir_x test
			
		//show_debug_message("Begin lengthdir_x test")
			
		math_set_epsilon(0.001);
			
		// Basic tests
		var _res1 = lengthdir_x(2, 0)
		assert_equals(_res1, 2, "_res1 == 2, no angle inputted")
			
		var _res2 = lengthdir_x(2, 90)
		assert_equals(_res2, 0, "_res2 == 0, angle is perpendicular")
			
		// Unit Circle Test
		var dAngle = 0.0
		while (dAngle <= 360.0)
		{
			var _xPos = dcos(dAngle);    
			var lengthDirX = lengthdir_x(1, dAngle)
			    
			//show_debug_message("_xPos: " + string(_xPos) + " | lengthDirX: " + string(lengthDirX))
			assert_equals(_xPos, lengthDirX, "Unit Circle Test At Angle " + string(dAngle))
			
			dAngle += 0.5
		}
			
		//show_debug_message("End lengthdir_x test")
	})

	addFact("lengthdir_y_test", function() {

		// lengthdir_y test
			
		//show_debug_message("Begin lengthdir_y test")
			
		math_set_epsilon(0.001);
			
		// Basic tests
		var _res1 = lengthdir_y(2, 0)
		assert_equals(_res1, 0, "_res1 == 0, no angle inputted")
			
		// Unit Circle Test
		var dAngle = 0.0
		while (dAngle <= 360.0)
		{
			// Inverted to match the gamemaker world space where Y up is negative.
			var _yPos = -(dsin(dAngle));
			var lengthDirY = lengthdir_y(1, dAngle)
			    
			//show_debug_message("_yPos: " + string(_yPos) + " | lengthDirY: " + string(lengthDirY))
			assert_equals(_yPos, lengthDirY, "Unit Circle Test At Angle " + string(dAngle))
			
			dAngle += 0.5
		}
			
		//show_debug_message("End lengthdir_y test")
	})

	addFact("lerp_test", function() {

		//lerp test
		//show_debug_message("start lerp() test");
		var _buff, _vReal1, _vReal2, _vInt1, _vInt2, _vInt64_1, _vInt64_2, _lerpQuarter, _lerpHalf, _lerpThreeQuarters, _result, _expected;
			
		_buff = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buff, buffer_f32, 2.5);
		buffer_write(_buff, buffer_f32, 7.5);
		buffer_write(_buff, buffer_s32, 100);
		buffer_write(_buff, buffer_s32, 200);
		buffer_write(_buff, buffer_u64, 500);
		buffer_write(_buff, buffer_u64, 5000);
		buffer_seek(_buff, buffer_seek_start, 0);
			
		_vReal1 = buffer_read(_buff, buffer_f32);
		_vReal2 = buffer_read(_buff, buffer_f32);
			
		_vInt1 = buffer_read(_buff, buffer_s32);
		_vInt2 = buffer_read(_buff, buffer_s32);
			
		_vInt64_1 = buffer_read(_buff, buffer_u64);
		_vInt64_2 = buffer_read(_buff, buffer_u64);
			
		_lerpQuarter = 0.25;
		_lerpHalf = 0.5;
		_lerpThreeQuarters = 0.75;
			
		//#1 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, _lerpQuarter );
		_expected = _vReal1 + (_vReal2 - _vReal1) * 0.25;
		assert_equals(_result, _expected, "#1 lerp( real local, real local , real local )")
			
		//#2 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, _lerpHalf );
		_expected = _vReal1 + (_vReal2 - _vReal1) * 0.5;
		assert_equals(_result, _expected, "#2 lerp( real local, real local , real local )")
			
		//#3 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, _lerpThreeQuarters );
		_expected = _vReal1 + (_vReal2 - _vReal1) * 0.75;
		assert_equals(_result, _expected, "#3 lerp( real local, real local , real local )")
			
		//#4 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, 0 );
		assert_equals(_result, _vReal1, "#4 lerp( real local, real local , real local )")
			
		//#5 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, 1 );
		assert_equals(_result, _vReal2, "#5 lerp( real local, real local , real local )")
			
		//#6 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, -1 );
		_expected = _vReal1 + (_vReal2 - _vReal1) * -1;
		assert_equals(_result, _expected, "#6 lerp( real local, real local , real local )")
			
		//#7 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, 2 );
		_expected = _vReal1 + (_vReal2 - _vReal1) * 2;
		assert_equals(_result, _expected, "#7 lerp( real local, real local , real local )")
			
		//#8 lerp( real local, real local , real local )
		_result = lerp( _vReal1, _vReal2, 1.1 );
		_expected = _vReal1 + (_vReal2 - _vReal1) * 1.1;
		assert_equals(_result, _expected, "#8 lerp( real local, real local , real local )")
			
			
			
		//#9 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, _lerpQuarter );
		_expected = _vInt1 + (_vInt2 - _vInt1) * 0.25;
		assert_equals(_result, _expected, "#9 lerp( int local, int local , int local )")
			
		//#10 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, _lerpHalf );
		_expected = _vInt1 + (_vInt2 - _vInt1) * 0.5;
		assert_equals(_result, _expected, "#10 lerp( int local, int local , int local )")
			
		//#11 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, _lerpThreeQuarters );
		_expected = _vInt1 + (_vInt2 - _vInt1) * 0.75;
		assert_equals(_result, _expected, "#11 lerp( int local, int local , int local )")
			
		//#12 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, 0 );
		assert_equals(_result, _vInt1, "#12 lerp( int local, int local , int local )")
			
		//#13 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, 1 );
		assert_equals(_result, _vInt2, "#13 lerp( int local, int local , int local )")
			
		//#14 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, -1 );
		_expected = _vInt1 + (_vInt2 - _vInt1) * -1;
		assert_equals(_result, _expected, "#14 lerp( int local, int local , int local )")
			
		//#15 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, 2 );
		_expected = _vInt1 + (_vInt2 - _vInt1) * 2;
		assert_equals(_result, _expected, "#15 lerp( int local, int local , int local )")
			
		//#16 lerp( int local, int local , int local )
		_result = lerp( _vInt1, _vInt2, 1.1 );
		_expected = _vInt1 + (_vInt2 - _vInt1) * 1.1;
		assert_equals(_result, _expected, "#16 lerp( int local, int local , int local )")
			
			
			
		//#17 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, _lerpQuarter );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.25;
		assert_equals(_result, _expected, "#17 lerp( int64 local, int64 local , int64 local )")
			
		//#18 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, _lerpHalf );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.5;
		assert_equals(_result, _expected, "#18 lerp( int64 local, int64 local , int64 local )")
			
		//#19 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, _lerpThreeQuarters );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 0.75;
		assert_equals(_result, _expected, "#19 lerp( int64 local, int64 local , int64 local )")
			
		//#20 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, 0 );
		assert_equals(_result, _vInt64_1, "#20 lerp( int64 local, int64 local , int64 local )")
			
		//#21 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, 1 );
		assert_equals(_result, _vInt64_2, "#21 lerp( int64 local, int64 local , int64 local )")
			
		//#22 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, -1 );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * -1;
		assert_equals(_result, _expected, "#22 lerp( int64 local, int64 local , int64 local )")
			
		//#23 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, 2 );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 2;
		assert_equals(_result, _expected, "#23 lerp( int64 local, int64 local , int64 local )")
			
		//#24 lerp( int64 local, int64 local , int64 local )
		_result = lerp( _vInt64_1, _vInt64_2, 1.1 );
		_expected = _vInt64_1 + (_vInt64_2 - _vInt64_1) * 1.1;
		assert_equals(_result, _expected, "#24 lerp( int64 local, int64 local , int64 local )")
			
		// Clean up
		buffer_delete(_buff);
	})

	addFact("ln_test", function() {

		//ln test
		//show_debug_message("start ln() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10);
		buffer_write(_buffer, buffer_u64, 4);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 ln( real local )
		_result = ln(_vReal);
		assert_equals(_result, 0.91629073187, "#1 ln( real local )")
			
		//#2 ln( int local )
		_result = ln(_vInt);
		assert_equals(_result, 2.30258509299, "#2 ln( int local )")
			
		//#3 ln( int64 local )
		_result = ln(_vInt64);
		assert_equals(_result, 1.38629436112, "#3 ln( int64 local )")
			
			
		//#4 ln( real const )
		_result = ln(2.5);
		assert_equals(_result, 0.91629073187, "#4 ln( real const )")
			
		//#5 ln( int const )
		_result = ln(10);
		assert_equals(_result, 2.30258509299, "#5 ln( int const )")
			
		//#6 ln( int64 const )
		_result = ln(int64(4));
		assert_equals(_result, 1.38629436112, "#6 ln( int64 const )")
			
			
		// negative value tests
			
		//#7 ln( real local )
		_result = ln(-_vReal);
		assert_true(is_nan(_result), "#7 ln( real local )")
			
		//#8 ln( int local )
		_result = ln(-_vInt);
		assert_true(is_nan(_result), "#8 ln( int local )")
			
		//#9 ln( int64 local )
		_result = ln(-_vInt64);
		assert_true(is_nan(_result), "#9 ln( int64 local )")
			
			
		//#10 ln( real const )
		_result = ln(-2.5);
		assert_true(is_nan(_result), "#10 ln( real const )")
			
		//#11 ln( int const )
		_result = ln(-10);
		assert_true(is_nan(_result), "#11 ln( int const )")
			
		//#12 ln( int64 const )
		_result = ln(int64(-4));
		assert_true(is_nan(_result), "#12 ln( int64 const )")
			
			
		// zero test
			
		//#13 ln( real const )
		_result = ln(0);
		assert_true(is_infinity(_result), "#13 ln( real const )")
			
		// one test
			
		//#14 ln( 1 )
		_result = ln(1);
		assert_equals(_result, 0, "#14 ln( 1 )")
			
		// inverse test
			
		//#15 ln( real const )
		var _value = exp(3.5);
		_result = ln(_value);
		assert_equals(_result, 3.5, "#15 ln( real const )")
			
		// infinity test
			
		//#16 ln( infinity )
		_result = ln(_infinity);
		assert_true(is_infinity(_result), "#16 ln( infinity )")
			
		// NaN test
			
		//#17 ln( NaN )
		_result = ln(_nan);
		assert_true(is_nan(_result), "#17 ln( NaN )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log10_test", function() {

		//log10 test
		//show_debug_message("start log10() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10000);
		buffer_write(_buffer, buffer_u64, 42);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 log10( real local )
		_result = log10(_vReal);
		assert_equals(_result, 0.39794000867, "#1 log10( real local )")
			
		//#2 log10( int local )
		_result = log10(_vInt);
		assert_equals(_result, 4, "#2 log10( int local )")
			
		//#3 log10( int64 local )
		_result = log10(_vInt64);
		assert_equals(_result, 1.6232492904, "#3 log10( int64 local )")
			
			
		//#4 log10( real const )
		_result = log10(2.5);
		assert_equals(_result, 0.39794000867, "#4 log10( real const )")
			
		//#5 log10( int const )
		_result = log10(10000);
		assert_equals(_result, 4, "#5 log10( int const )")
			
		//#6 log10( int64 const )
		_result = log10(int64(42));
		assert_equals(_result, 1.6232492904, "#6 log10( int64 const )")
			
		// negative value tests
			
		//#7 log10( real local )
		_result = log10(-_vReal);
		assert_true(is_nan(_result), "#7 log10( real local )")
			
		//#8 log10( int local )
		_result = log10(-_vInt);
		assert_true(is_nan(_result), "#8 log10( int local )")
			
		//#9 log10( int64 local )
		_result = log10(-_vInt64);
		assert_true(is_nan(_result), "#9 log10( int64 local )")
			
			
		//#10 log10( real const )
		_result = log10(-2.5);
		assert_true(is_nan(_result), "#10 log10( real const )")
			
		//#11 log10( int const )
		_result = log10(-10000);
		assert_true(is_nan(_result), "#11 log10( int const )")
			
		//#12 log10( int64 const )
		_result = log10(int64(-42));
		assert_true(is_nan(_result), "#12 log10( int64 const )")
			
		// zero test
			
		//#13 log10( 0 )
		_result = log10(0);
		assert_true(is_infinity(_result), "#13 log10( 0 )")
			
		// one test
			
		//#14 log10( 1 )
		_result = log10(1);
		assert_equals(_result, 0, "#14 log10( 1 )")
			
		// negative power tests
			
		//#15 log10( real local )
		_result = log10(0.1);
		assert_equals(_result, -1, "#15 log10( real local )")
			
		//#16 log10( int local )
		_result = log10(0.01);
		assert_equals(_result, -2, "#16 log10( int local )")
			
		//#17 log10( int64 local )
		_result = log10(0.001);
		assert_equals(_result, -3, "#17 log10( int64 local )")
			
		// infinity test
			
		//#18 log10( infinity )
		_result = log10(_infinity);
		assert_true(is_infinity(_result), "#18 log10( infinity )")
			
		// NaN test
			
		//#19 log10( NaN )
		_result = log10(_nan);
		assert_true(is_nan(_result), "#19 log10( NaN )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("log2_test", function() {

		//log2 test
		//show_debug_message("start log2() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 8);
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 log2( real local )
		_result = log2(_vReal);
		assert_equals(_result, 1.32192809489, "#1 log2( real local )")
			
		//#2 log2( int local )
		_result = log2(_vInt);
		assert_equals(_result, 3, "#2 log2( int local )")
			
		//#3 log2( int64 local )
		_result = log2(_vInt64);
		assert_equals(_result, 2, "#3 log2( int64 local )")
			
			
		//#4 log2( real const )
		_result = log2(2.5);
		assert_equals(_result, 1.32192809489, "#4 log2( real const )")
			
		//#5 log2( int const )
		_result = log2(8);
		assert_equals(_result, 3, "#5 log2( int const )")
			
		//#6 log2( int64 const )
		_result = log2(int64(4));
		assert_equals(_result, 2, "#6 log2( int64 const )")
			
		// negative value tests
			
		//#7 log2( real local )
		_result = log2(-_vReal);
		assert_true(is_nan(_result), "#7 log2( real local )")
			
		//#8 log2( int local )
		_result = log2(-_vInt);
		assert_true(is_nan(_result), "#8 log2( int local )")
			
		//#9 log2( int64 local )
		_result = log2(-_vInt64);
		assert_true(is_nan(_result), "#9 log2( int64 local )")
			
			
		//#10 log2( real const )
		_result = log2(-2.5);
		assert_true(is_nan(_result), "#10 log2( real const )")
			
		//#11 log2( int const )
		_result = log2(-8);
		assert_true(is_nan(_result), "#11 log2( int const )")
			
		//#12 log2( int64 const )
		_result = log2(int64(-4));
		assert_true(is_nan(_result), "#12 log2( int64 const )")
			
		// zero test
			
		//#13 log2( 0 )
		_result = log2(0);
		assert_true(is_infinity(_result), "#13 log2( 0 )")
			
		// one test
			
		//#14 log2( 1 )
		_result = log2(1);
		assert_equals(_result, 0, "#14 log2( 1 )")
			
		// negative power tests
			
		//#15 log2( real local )
		_result = log2(0.5);
		assert_equals(_result, -1, "#15 log2( real local )")
			
		//#16 log2( int local )
		_result = log2(0.25);
		assert_equals(_result, -2, "#16 log2( int local )")
			
		//#17 log2( int64 local )
		_result = log2(0.125);
		assert_equals(_result, -3, "#17 log2( int64 local )")
			
		// infinity test
			
		//#18 log2( infinity )
		_result = log2(_infinity);
		assert_true(is_infinity(_result), "#18 log2( infinity )")
			
		// NaN test
			
		//#19 log2( NaN )
		_result = log2(_nan);
		assert_true(is_nan(_result), "#19 log2( NaN )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("logn_test", function() {

		//logn test
		//show_debug_message("start logn() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10);
		buffer_write(_buffer, buffer_u64, 4);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 logn( real const , real local )
		_result = logn(5, _vReal);
		assert_equals(_result, 0.56932344192661, "#1 logn( real const , real local )")
			
		//#2 logn( real const , int local )
		_result = logn(5, _vInt);
		assert_equals(_result, 1.4306765580734, "#2 logn( real const , int local )")
			
		//#3 logn( real const , int64 local )
		_result = logn(5, _vInt64);
		assert_equals(_result, 0.86135311614679, "#3 logn( real const , int64 local )")
			
			
		//#4 logn( real const , real local )
		_result = logn(2, _vReal);
		assert_equals(_result, log2(_vReal), "#4 logn( real const , real local )")
			
		//#5 logn( real const , int local )
		_result = logn(2, _vInt);
		assert_equals(_result, log2(_vInt), "#5 logn( real const , int local )")
			
		//#6 logn( real const , int64 local )
		_result = logn(2, _vInt64);
		assert_equals(_result, log2(_vInt64), "#6 logn( real const , int64 local )")
			
			
		//#7 logn( real const , real local )
		_result = logn(10, _vReal);
		assert_equals(_result, log10(_vReal), "#7 logn( real const , real local )")
			
		//#8 logn( real const , int local )
		_result = logn(10, _vInt);
		assert_equals(_result, log10(_vInt), "#8 logn( real const , int local )")
			
		//#9 logn( real const , int64 local )
		_result = logn(10, _vInt64);
		assert_equals(_result, log10(_vInt64), "#9 logn( real const , int64 local )")
			
			
		//#10 logn( real local , real const )
		_result = logn(1, _vReal);
		assert_true(is_infinity(_result), "#10 logn( real local , real const )")
			
		//#11 logn( int local , real const )
		_result = logn(1, _vInt);
		assert_true(is_infinity(_result), "#11 logn( int local , real const )")
			
		//#12 logn( int64 local , real const )
		_result = logn(1, _vInt64);
		assert_true(is_infinity(_result), "#12 logn( int64 local , real const )")
			
			
		//#13 logn( real local , real const )
		_result = logn(0, _vReal);
		assert_equals(_result, 0, "#13 logn( real local , real const )")
			
		//#14 logn( int local , real const )
		_result = logn(0, _vInt);
		assert_equals(_result, 0, "#14 logn( int local , real const )")
			
		//#15 logn( int64 local , real const )
		_result = logn(0, _vInt64);
		assert_equals(_result, 0, "#15 logn( int64 local , real const )")
			
			
		//#16 logn( real local , real const )
		_result = logn(0.5, _vReal);
		assert_equals(_result, -1.3219280948874, "#16 logn( real local , real const )")
			
		//#17 logn( int local , real const )
		_result = logn(0.5, _vInt);
		assert_equals(_result, -3.3219280948874, "#17 logn( int local , real const )")
			
		//#18 logn( int64 local , real const )
		_result = logn(0.5, _vInt64);
		assert_equals(_result, -2, "#18 logn( int64 local , real const )")
			
			
		//#19 logn( real local , real const )
		_result = logn(-2, _vReal);
		assert_true(is_nan(_result), "#19 logn( real local , real const )")
			
		//#20 logn( int local , real const )
		_result = logn(-2, _vInt);
		assert_true(is_nan(_result), "#20 logn( int local , real const )")
			
		//#21 logn( int64 local , real const )
		_result = logn(-2, _vInt64);
		assert_true(is_nan(_result), "#21 logn( int64 local , real const )")
			
			
		// negative values
			
		//#22 logn( real const , real local )
		_result = logn(5, -_vReal);
		assert_true(is_nan(_result), "#22 logn( real const , real local )")
			
		//#23 logn( real const , int local )
		_result = logn(5, -_vInt);
		assert_true(is_nan(_result), "#23 logn( real const , int local )")
			
		//#24 logn( real const , int64 local )
		_result = logn(5, -_vInt64);
		assert_true(is_nan(_result), "#24 logn( real const , int64 local )")
			
			
		//#25 logn( real local , real const )
		_result = logn(1, -_vReal);
		assert_true(is_nan(_result), "#25 logn( real local , real const )")
			
		//#26 logn( int local , real const )
		_result = logn(1, -_vInt);
		assert_true(is_nan(_result), "#26 logn( int local , real const )")
			
		//#27 logn( int64 local , real const )
		_result = logn(1, -_vInt64);
		assert_true(is_nan(_result), "#27 logn( int64 local , real const )")
			
			
		//#28 logn( real local , real const )
		_result = logn(0, -_vReal);
		assert_true(is_nan(_result), "#28 logn( real local , real const )")
			
		//#29 logn( int local , real const )
		_result = logn(0, -_vInt);
		assert_true(is_nan(_result), "#29 logn( int local , real const )")
			
		//#30 logn( int64 local , real const )
		_result = logn(0, -_vInt64);
		assert_true(is_nan(_result), "#30 logn( int64 local , real const )")
			
			
		//#31 logn( real local , real const )
		_result = logn(0.5, -_vReal);
		assert_true(is_nan(_result), "#31 logn( real local , real const )")
			
		//#32 logn( int local , real const )
		_result = logn(0.5, -_vInt);
		assert_true(is_nan(_result), "#32 logn( int local , real const )")
			
		//#33 logn( int64 local , real const )
		_result = logn(0.5, -_vInt64);
		assert_true(is_nan(_result), "#33 logn( int64 local , real const )")
			
			
		//#34 logn( real local , real const )
		_result = logn(-2, _vReal);
		assert_true(is_nan(_result), "#34 logn( real local , real const )")
			
		//#35 logn( int local , real const )
		_result = logn(-2, _vInt);
		assert_true(is_nan(_result), "#35 logn( int local , real const )")
			
		//#36 logn( int64 local , real const )
		_result = logn(-2, _vInt64);
		assert_true(is_nan(_result), "#36 logn( int64 local , real const )")
			
		// Clean up
		buffer_delete(_buffer);
			
		// real/int32/int64 as base
			
		_buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 5.5);
		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_u64, 2);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
		var realBase = buffer_read(_buffer, buffer_f32);
		var intBase = buffer_read(_buffer, buffer_s32);
		var int64Base = buffer_read(_buffer, buffer_u64);
			
			
		//#37 logn( real const , real local )
		_result = logn(realBase, _vReal);
		assert_equals(_result, 0.53749333173972, "#37 logn( real const , real local )")
			
		//#38 logn( real const , real local )
		_result = logn(intBase, _vReal);
		assert_equals(_result, log2(_vReal), "#38 logn( real const , real local )")
			
		//#39 logn( real const , real local )
		_result = logn(int64Base, _vReal);
		assert_equals(_result, log2(_vReal), "#39 logn( real const , real local )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("math_get_epsilon_test", function() {

		//math_get_epsilon test
		//show_debug_message("start math_get_epsilon() test");
			
		var _result;
			
		//#1 initially set value for epsilon should be 0.00001
		//_result = math_get_epsilon();
		//assert_equals(_result, 0.00001, "#1 math_get_epsilon( )")
			
		// tests that returned epsilon value from math_get_epsilon changes if internal epsilon value is changed
			
		//#2 math_get_epsilon()
		math_set_epsilon(0.1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.1, "#2 math_get_epsilon( )")
			
		//#3 math_get_epsilon()
		math_set_epsilon(0.001);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#3 math_get_epsilon( )")
			
		//#4 math_get_epsilon()
		math_set_epsilon(0.005);
		_result = math_get_epsilon();
		assert_equals(_result, 0.005, "#4 math_get_epsilon( )")
			
		//#5 math_get_epsilon()
		math_set_epsilon(0);
		_result = math_get_epsilon();
		assert_equals(_result, 0.00000000001, "#5 math_get_epsilon( )")
			
		// tests that returned epsilon value from math_get_epsilon doesnt change if internal epsilon value isn't changed
			
		//#6 math_get_epsilon()
		math_set_epsilon(0.001);
		math_set_epsilon(1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#6 math_get_epsilon( )")
			
		//#7 math_get_epsilon()
		math_set_epsilon(0.001);
		math_set_epsilon(100);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#7 math_get_epsilon( )")
			
		//#8 math_get_epsilon()
		math_set_epsilon(0.001);
		math_set_epsilon(-1);
		_result = math_get_epsilon();
		assert_equals(_result, 0.001, "#8 math_get_epsilon( )")
			
		//#9 math_get_epsilon() - assigning returned epsilon as epsilon
		math_set_epsilon(0.001);
		_result = math_get_epsilon();
		math_set_epsilon(_result);
			
		assert_equals(0.1112, 0.1113, "#9 math_set_epsilon( real local ) - assigning returned epsilon as epsilon")
		assert_not_equals(0.1122, 0.1133, "#9 math_set_epsilon( real local ) - assigning returned epsilon as epsilon")
			
			
		//show_debug_message("end math_get_epsilon() test");
	})

	addFact("math_set_epsilon_test", function() {

		//math_set_epsilon test
		//show_debug_message("start math_set_epsilon() test");
			
		// The only way to generate an int32 is to read it from a buffer
		var _buffer = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buffer, buffer_s32, 0);
		buffer_write(_buffer, buffer_s32, 1);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vInt_zero = buffer_read(_buffer, buffer_s32);
		var _vInt_one = buffer_read(_buffer, buffer_s32);
			
		//#1 initially set value for epsilon should be 0.00001
		//assert_equals(0.111345, 0.111346, "#1 math_set_epsilon( real const )")
		//assert_not_equals(0.111335, 0.111446, "#1 math_set_epsilon( real const )")
			
		//#2 math_set_epsilon( real const )
		math_set_epsilon(0.1);
		assert_equals(0.12, 0.13, "#2 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#2 math_set_epsilon( real const )")
			
		//#2 math_set_epsilon( real const )
		math_set_epsilon(0.001);
		assert_equals(0.1112, 0.1113, "#3 math_set_epsilon( real const )")
		assert_not_equals(0.1122, 0.1133, "#3 math_set_epsilon( real const )")
			
		//#4 math_set_epsilon( real const )
		math_set_epsilon(0.00001);
		assert_equals(0.111345, 0.111346, "#4 math_set_epsilon( real const )")
		assert_not_equals(0.111335, 0.111446, "#4 math_set_epsilon( real const )")
			
		//#5 math_set_epsilon( real const )
		math_set_epsilon(0.5);
		assert_equals(0.1, 0.5, "#5 math_set_epsilon( real const )")
		assert_not_equals(0.1, 0.7, "#5 math_set_epsilon( real const )")
			
		//#6 math_set_epsilon( real const )
		math_set_epsilon(0.05);
		assert_equals(0.1, 0.15, "#6 math_set_epsilon( real const )")
		assert_not_equals(0.1, 0.17, "#6 math_set_epsilon( real const )")
			
			
		// test that values of 0 set the epsilon to 0.00000000001
			
		//#7 math_set_epsilon( real const )
		math_set_epsilon(0);
		assert_equals(0.11123456789, 0.11123456789, "#7 math_set_epsilon( 0 )")
		assert_not_equals(0.11123456788, 0.11123456789, "#7 math_set_epsilon( 0 )")
			
			
		// test that values >= 1  and < 0 leave the epsilon unchanged
		math_set_epsilon(0.1);
			
		//#8 math_set_epsilon( real const )
		math_set_epsilon(1);
		assert_equals(0.12, 0.13, "#8 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#8 math_set_epsilon( real const )")
			
		//#9 math_set_epsilon( real const )
		math_set_epsilon(100);
		assert_equals(0.12, 0.13, "#9 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#9 math_set_epsilon( real const )")
			
		//#10 math_set_epsilon( real const )
		math_set_epsilon(-0.001);
		assert_equals(0.12, 0.13, "#10 math_set_epsilon( real const )")
		assert_not_equals(0.22, 0.33, "#10 math_set_epsilon( real const )")
			
			
		// test that int/in54 values of 0 set the epsilon to 0.00000000001
			
		//#11 math_set_epsilon( int const (0) )
		math_set_epsilon(_vInt_zero);
		assert_equals(0.111234567898, 0.111234567899, "#11 initially set value for epsilon should be 0.00000000001")
		assert_not_equals(0.11123456788, 0.11123456789, "#11 initially set value for epsilon should be 0.00000000001")
			
		//#12 math_set_epsilon( int64 const (0) )
		math_set_epsilon(int64(0));
		assert_equals(0.111234567898, 0.111234567899, "#12 initially set value for epsilon should be 0.00000000001")
		assert_not_equals(0.11123456788, 0.11123456789, "#12 initially set value for epsilon should be 0.00000000001")
			
			
		// test that int/int64 values >= 1 and < 0 leave the epsilon unchanged
		math_set_epsilon(0.1);
			
		//#13 math_set_epsilon( int const (1) )
		math_set_epsilon(_vInt_one);
		assert_equals(0.12, 0.13, "#13 math_set_epsilon( int const (1) )")
		assert_not_equals(0.22, 0.33, "#13 math_set_epsilon( int const (1) )")
			
		//#14 math_set_epsilon( int64 const (1) )
		math_set_epsilon(int64(1));
		assert_equals(0.12, 0.13, "#14 math_set_epsilon( int64 const (1) )")
		assert_not_equals(0.22, 0.33, "#14 math_set_epsilon( int64 const (1) )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("max_test", function() {

		//max test
		//show_debug_message("start max() test");
			
		#macro kReal_MaxTest 2.5
		#macro kInt_MaxTest 10
		#macro kInt64_MaxTest 0xff87654321
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_write(_buffer, buffer_u64, 0xdeadc0deabcdefed);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		global.gReal = 99;
		global.gInt = _vInt;
		global.gInt64 = int64(0x12131415161718);
			
		var _objTest = instance_create_depth(0,0,0,oTest);
			
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;
		_objOther.oInt = _vInt;
		_objOther.oInt64 = int64(0x1122334455667788);
			
			
		var _result;
			
		// zero arguments
			
		//#1 max()
		_result = max();
		assert_equals(_result, 0, "#1 max() - zero arguments")
			
			
		// testing different argument types
			
		// one argument, local
				
		//#2 max( real local )
		_result = max(_vReal);
		assert_equals(_result, _vReal, "#2 max( real local )")
				
		//#3 max( int local )
		_result = max(_vInt);
		assert_equals(_result, _vInt, "#3 max( int local )")
				
		//#4 max( int64 local )
		_result = max(_vInt64);
		assert_equals(_result, _vInt64, "#4 max( int64 local )")
			
			
		// one argument, global	
				
		//#5 max( real global )
		_result = max(global.gReal);
		assert_equals(_result, global.gReal, "#5 max( real global )")
				
		//#6 max( int global )
		_result = max(global.gInt);
		assert_equals(_result, global.gInt, "#6 max( int global )")
				
		//#7 max( int64 global )
		_result = max(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 max( int64 global )")
			
			
		// one argument, instance
				
		//#8 max( real instance )
		_result = max(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 max( real instance )")
				
		//#9 max( int instance )
		_result = max(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 max( int instance )")
				
		//#10 max( int64 instance )
		_result = max(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 max( int64 instance )")
			
			
		// one argument, const
				
		//#11 max( real instance )
		_result = max(42.0);
		assert_equals(_result, 42.0, "#11 max( real instance )")
				
		//#12 max( int instance )
		_result = max(12);
		assert_equals(_result, 12, "#12 max( int instance )")
				
		//#13 max( int64 instance )
		_result = max(0x1122334455667788);
		assert_equals(_result, 0x1122334455667788, "#13 max( int64 instance )")
			
			
		// one argument, macro
			
		//#14 max( real macro )
		_result = max(kReal_MaxTest);
		assert_equals(_result, kReal_MaxTest, "#14 max( real macro )")
				
		//#15 max( int macro )
		_result = max(kInt_MaxTest);
		assert_equals(_result, kInt_MaxTest, "#15 max( int macro )")
				
		//#16 max( int64 macro )
		_result = max(kInt64_MaxTest);
		assert_equals(_result, kInt64_MaxTest, "#16 max( int64 macro )")
			
			
		// multiple argumenents
			
		//#17 max( real const , real const , real const , real const )
		_result = max(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 99.9, "#17 max( real const , real const , real const , real const )");
			
		//#18 max( real const , real const , real const , real const )
		_result = max(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -0.5, "#18 max( real const , real const , real const , real const )");
			
		//#19 max( real const , real const , real const , real const )
		_result = max(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, 0.5, "#19 max( real const , real const , real const , real const )");
			
		//#20 max( int64 const , int64 const , int64 const , int64 const )
		_result = max(0x1122334455667788, 0x8877665544332211, 0x7FFFFFFFFFFFFFFF, 0x5566778811223344);
		assert_equals(_result, 0x7FFFFFFFFFFFFFFF, "#20 max( int64 const , int64 const , int64 const , int64 const )");
			
		//#21 max( real const , real const , real const , real const )
		_result = max(kReal_MaxTest, _objOther.oReal, global.gReal, _vReal);
		assert_equals(_result, _objOther.oReal, "#21 max( real const , real const , real const , real const )");
			
		//#22 max( real const , real const , real const , real const )
		_result = max(-kReal_MaxTest, -_objOther.oReal, -global.gReal, -_vReal);
		assert_equals(_result, -kReal_MaxTest, "#22 max( real const , real const , real const , real const )");
			
			
		// Identical values
			
		//#23 max( real const , real const , real const , real const )
		_result = max(50, 50, 50, 50);
		assert_equals(_result, 50, "#23 max( real const , real const , real const , real const )");
			
		//#24 max( real const , real const , real const , real const )
		_result = max(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#24 max( real const , real const , real const , real const )");
			
		// Clean up
		buffer_delete(_buffer);
			
		instance_destroy(_objTest);
		instance_destroy(_objOther);
	})

	addFact("mean_test", function() {

		//mean test
		//show_debug_message("start mean() test");
			
		#macro kReal_MeanTest 2.5
		#macro kInt_MeanTest 10
		#macro kInt64_MeanTest int64(5000)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		global.gReal = 99;
		global.gInt = _vInt;
		global.gInt64 = int64(5000);
			
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;
		_objOther.oInt = _vInt;
		_objOther.oInt64 = int64(5000);
			
			
		var _result;
			
		// zero arguments
			
		//#1 mean()
		_result = mean();
		assert_equals(_result, 0, "#1 mean() - zero arguments")
			
			
		// testing different argument types
			
		// one argument, local
				
		//#2 mean( real local )
		_result = mean(_vReal);
		assert_equals(_result, _vReal, "#2 mean( real local )")
				
		//#3 mean( int local )
		_result = mean(_vInt);
		assert_equals(_result, _vInt, "#3 mean( int local )")
				
		//#4 mean( int64 local )
		_result = mean(_vInt64);
		assert_equals(_result, _vInt64, "#4 mean( int64 local )")
			
			
		// one argument, global	
				
		//#5 mean( real global )
		_result = mean(global.gReal);
		assert_equals(_result, global.gReal, "#5 mean( real global )")
				
		//#6 mean( int global )
		_result = mean(global.gInt);
		assert_equals(_result, global.gInt, "#6 mean( int global )")
				
		//#7 mean( int64 global )
		_result = mean(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 mean( int64 global )")
			
			
		// one argument, instance
				
		//#8 mean( real instance )
		_result = mean(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 mean( real instance )")
				
		//#9 mean( int instance )
		_result = mean(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 mean( int instance )")
				
		//#10 mean( int64 instance )
		_result = mean(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 mean( int64 instance )")
			
			
		// one argument, const
				
		//#11 mean( real instance )
		_result = mean(42.0);
		assert_equals(_result, 42.0, "#11 mean( real instance )")
				
		//#12 mean( int instance )
		_result = mean(12);
		assert_equals(_result, 12, "#12 mean( int instance )")
				
		//#13 mean( int64 instance )
		_result = mean(int64(5000));
		assert_equals(_result, int64(5000), "#13 mean( int64 instance )")
			
			
		// one argument, macro
			
		//#14 mean( real macro )
		_result = mean(kReal_MeanTest);
		assert_equals(_result, kReal_MeanTest, "#14 mean( real macro )")
				
		//#15 mean( int macro )
		_result = mean(kInt_MeanTest);
		assert_equals(_result, kInt_MeanTest, "#15 mean( int macro )")
				
		//#16 mean( int64 macro )
		_result = mean(kInt64_MeanTest);
		assert_equals(_result, kInt64_MeanTest, "#16 mean( int64 macro )")
			
			
		// multiple argumenents
			
		//#17 mean( real const , real const , real const , real const )
		_result = mean(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 25.875, "#17 mean( real const , real const , real const , real const )");
			
		//#18 mean( real const , real const , real const , real const )
		_result = mean(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -25.875, "#18 mean( real const , real const , real const , real const )");
			
		//#19 mean( real const , real const , real const , real const )
		_result = mean(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -25.625, "#19 mean( real const , real const , real const , real const )");
			
		//#20 mean( real const , real const , real const , real const )
		_result = mean(0.5, -0.5, 0.5, -0.5);
		assert_equals(_result, 0, "#20 mean( real const , real const , real const , real const )");
			
		//#21 mean( int64 const , int64 const , int64 const , int64 const )
		_result = mean(int64(100), int64(-50), int64(200), int64(-10));
		assert_equals(_result, 60, "#21 mean( int64 const , int64 const , int64 const , int64 const )");
			
		// Identical values
			
		//#22 mean( real const , real const , real const , real const )
		_result = mean(50, 50, 50, 50);
		assert_equals(_result, 50, "#22 mean( real const , real const , real const , real const )");
			
		//#23 mean( real const , real const , real const , real const )
		_result = mean(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#23 mean( real const , real const , real const , real const )");
			
		// Clean up
		buffer_delete(_buffer);
			
		instance_destroy(_objOther);
	})

	addFact("median_test", function() {

		//median test
		//show_debug_message("start median() test");
			
		#macro kReal_MedianTest 2.5
		#macro kInt_MedianTest 10
		#macro kInt64_MedianTest int64(5000)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_write(_buffer, buffer_u64, 5000);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		global.gReal = 99;
		global.gInt = _vInt;
		global.gInt64 = int64(5000);
			
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;
		_objOther.oInt = _vInt;
		_objOther.oInt64 = int64(5000);
			
			
		var _result;
			
		// zero arguments
			
		//#1 median()
		_result = median();
		assert_equals(_result, 0, "#1 median() - zero arguments")
			
			
		// testing different argument types
			
		// one argument, local
				
		//#2 median( real local )
		_result = median(_vReal);
		assert_equals(_result, _vReal, "#2 median( real local )")
				
		//#3 median( int local )
		_result = median(_vInt);
		assert_equals(_result, _vInt, "#3 median( int local )")
				
		//#4 median( int64 local )
		_result = median(_vInt64);
		assert_equals(_result, _vInt64, "#4 median( int64 local )")
			
			
		// one argument, global	
				
		//#5 median( real global )
		_result = median(global.gReal);
		assert_equals(_result, global.gReal, "#5 median( real global )")
				
		//#6 median( int global )
		_result = median(global.gInt);
		assert_equals(_result, global.gInt, "#6 median( int global )")
				
		//#7 median( int64 global )
		_result = median(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 median( int64 global )")
			
			
		// one argument, instance
				
		//#8 median( real instance )
		_result = median(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 median( real instance )")
				
		//#9 median( int instance )
		_result = median(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 median( int instance )")
				
		//#10 median( int64 instance )
		_result = median(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 median( int64 instance )")
			
			
		// one argument, const
				
		//#11 median( real instance )
		_result = median(42.0);
		assert_equals(_result, 42.0, "#11 median( real instance )")
				
		//#12 median( int instance )
		_result = median(12);
		assert_equals(_result, 12, "#12 median( int instance )")
				
		//#13 median( int64 instance )
		_result = median(int64(5000));
		assert_equals(_result, int64(5000), "#13 median( int64 instance )")
			
			
		// one argument, macro
			
		//#14 median( real macro )
		_result = median(kReal_MedianTest);
		assert_equals(_result, kReal_MedianTest, "#14 median( real macro )")
				
		//#15 median( int macro )
		_result = median(kInt_MedianTest);
		assert_equals(_result, kInt_MedianTest, "#15 median( int macro )")
				
		//#16 median( int64 macro )
		_result = median(kInt64_MedianTest);
		assert_equals(_result, kInt64_MedianTest, "#16 median( int64 macro )")
			
			
		// multiple (even) argumenents
			
		//#17 median( real const , real const , real const , real const )
		_result = median(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 2.0, "#17 median( real const , real const , real const , real const )");
			
		//#18 median( real const , real const , real const , real const )
		_result = median(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -1.1, "#18 median( real const , real const , real const , real const )");
			
		//#19 median( real const , real const , real const , real const )
		_result = median(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -1.1, "#19 median( real const , real const , real const , real const )");
			
		//#20 median( real const , real const , real const , real const )
		_result = median(0.5, -0.5, 0.5, -0.5);
		assert_equals(_result, 0.5, "#20 median( real const , real const , real const , real const )");
			
		//#21 median( int64 const , int64 const , int64 const , int64 const )
		_result = median(int64(100), int64(-50), int64(200), int64(-10));
		assert_equals(_result, int64(100), "#21 median( int64 const , int64 const , int64 const , int64 const )");
			
			
		// multiple (odd) argumenents
			
		//#22 median( real const , real const , real const , real const )
		_result = median(0.5, 1.1, 2.0, 99.9, 234.0);
		assert_equals(_result, 2.0, "#22 median( real const , real const , real const , real const )");
			
		//#23 median( real const , real const , real const , real const )
		_result = median(-0.5, -1.1, -2.0, -99.9, -234.0);
		assert_equals(_result, -2.0, "#23 median( real const , real const , real const , real const )");
			
		//#24 median( real const , real const , real const , real const )
		_result = median(0.5, -1.1, -2.0, -99.9, 234.0);
		assert_equals(_result, -1.1, "#24 median( real const , real const , real const , real const )");
			
		//#25 median( real const , real const , real const , real const )
		_result = median(0.5, -0.5, 0.5, -0.5, 0.5);
		assert_equals(_result, 0.5, "#25 median( real const , real const , real const , real const )");
			
		//#26 median( int64 const , int64 const , int64 const , int64 const )
		_result = median(int64(100), int64(-50), int64(200), int64(-10), int64(-99));
		assert_equals(_result, int64(-10), "#26 median( int64 const , int64 const , int64 const , int64 const )");
			
			
		// Identical values
			
		//#27 median( real const , real const , real const , real const )
		_result = median(50, 50, 50, 50);
		assert_equals(_result, 50, "#27 median( real const , real const , real const , real const )");
			
		//#28 median( real const , real const , real const , real const )
		_result = median(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#28 median( real const , real const , real const , real const )");
			
		// Clean up
		buffer_delete(_buffer);
			
		instance_destroy(_objOther);
	})

	addFact("min_test", function() {

		//min test
		//show_debug_message("start min() test");
			
		#macro kReal_MinTest 2.5
		#macro kInt_MinTest 10
		#macro kInt64_MinTest 0xff87654321
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 3.14159);
		buffer_write(_buffer, buffer_s32, 0x12345678);
		buffer_write(_buffer, buffer_u64, 0xdeadc0deabcdefed);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		global.gReal = 99;
		global.gInt = _vInt;
		global.gInt64 = int64(0x12131415161718);
			
		var _objOther = instance_create_depth(0,0,0,oOther);
		_objOther.oReal = 0x1000;
		_objOther.oInt = _vInt;
		_objOther.oInt64 = int64(0x1122334455667788);
			
		var _result;
			
		// zero arguments
			
		//#1 min()
		_result = min();
		assert_equals(_result, 0, "#1 min() - zero arguments")
			
			
		// testing different argument types
			
		// one argument, local
				
		//#2 min( real local )
		_result = min(_vReal);
		assert_equals(_result, _vReal, "#2 min( real local )")
				
		//#3 min( int local )
		_result = min(_vInt);
		assert_equals(_result, _vInt, "#3 min( int local )")
				
		//#4 min( int64 local )
		_result = min(_vInt64);
		assert_equals(_result, _vInt64, "#4 min( int64 local )")
			
			
		// one argument, global	
				
		//#5 min( real global )
		_result = min(global.gReal);
		assert_equals(_result, global.gReal, "#5 min( real global )")
				
		//#6 min( int global )
		_result = min(global.gInt);
		assert_equals(_result, global.gInt, "#6 min( int global )")
				
		//#7 min( int64 global )
		_result = min(global.gInt64);
		assert_equals(_result, global.gInt64, "#7 min( int64 global )")
			
			
		// one argument, instance
				
		//#8 min( real instance )
		_result = min(_objOther.oReal);
		assert_equals(_result, _objOther.oReal, "#8 min( real instance )")
				
		//#9 min( int instance )
		_result = min(_objOther.oInt);
		assert_equals(_result, _objOther.oInt, "#9 min( int instance )")
				
		//#10 min( int64 instance )
		_result = min(_objOther.oInt64);
		assert_equals(_result, _objOther.oInt64, "#10 min( int64 instance )")
			
			
		// one argument, const
				
		//#11 min( real instance )
		_result = min(42.0);
		assert_equals(_result, 42.0, "#11 min( real instance )")
				
		//#12 min( int instance )
		_result = min(12);
		assert_equals(_result, 12, "#12 min( int instance )")
				
		//#13 min( int64 instance )
		_result = min(0x1122334455667788);
		assert_equals(_result, 0x1122334455667788, "#13 min( int64 instance )")
			
			
		// one argument, macro
			
		//#14 min( real macro )
		_result = min(kReal_MinTest);
		assert_equals(_result, kReal_MinTest, "#14 min( real macro )")
				
		//#15 min( int macro )
		_result = min(kInt_MinTest);
		assert_equals(_result, kInt_MinTest, "#15 min( int macro )")
				
		//#16 min( int64 macro )
		_result = min(kInt64_MinTest);
		assert_equals(_result, kInt64_MinTest, "#16 min( int64 macro )")
			
			
		// multiple argumenents
			
		//#17 min( real const , real const , real const , real const )
		_result = min(0.5, 1.1, 2.0, 99.9);
		assert_equals(_result, 0.5, "#17 min( real const , real const , real const , real const )");
			
		//#18 min( real const , real const , real const , real const )
		_result = min(-0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -99.9, "#18 min( real const , real const , real const , real const )");
			
		//#19 min( real const , real const , real const , real const )
		_result = min(0.5, -1.1, -2.0, -99.9);
		assert_equals(_result, -99.9, "#19 min( real const , real const , real const , real const )");
			
		//#20 min( int64 const , int64 const , int64 const , int64 const )
		_result = min(0x1122334455667788, 0x8877665544332211, 0x7FFFFFFFFFFFFFFF, 0x5566778811223344);
		assert_equals(_result, 0x1122334455667788, "#20 min( int64 const , int64 const , int64 const , int64 const )");
			
		//#21 min( real const , real const , real const , real const )
		_result = min(kReal_MinTest, _objOther.oReal, global.gReal, _vReal);
		assert_equals(_result, kReal_MinTest, "#21 min( real const , real const , real const , real const )");
			
		//#22 min( real const , real const , real const , real const )
		_result = min(-kReal_MinTest, -_objOther.oReal, -global.gReal, -_vReal);
		assert_equals(_result, -_objOther.oReal, "#22 min( real const , real const , real const , real const )");
			
			
		// Identical values
			
		//#23 min( real const , real const , real const , real const )
		_result = min(50, 50, 50, 50);
		assert_equals(_result, 50, "#23 min( real const , real const , real const , real const )");
			
		//#24 min( real const , real const , real const , real const )
		_result = min(-250.25, -250.25, -250.25, -250.25);
		assert_equals(_result, -250.25, "#24 min( real const , real const , real const , real const )");
			
		// Clean up
		buffer_delete(_buffer);
		instance_destroy(_objOther);
	})

	addFact("point_direction_test", function() {

		//point_direction test
		var _buffer = buffer_create(16, buffer_grow, 1 );
			
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, -10.2);
			
		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);
			
		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);
			
		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);
			
		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
			
		math_set_epsilon(0.0001);
			
		var _result;
			
		//#1 point_direction( real local , real local , real local , real local )
		_result = point_direction(_vReal_x1, _vReal_y1, _vReal_x2, _vReal_y2);
		assert_equals(_result, 61.4195, "#1 point_direction( real local , real local , real local , real local )")
			
		//#2 point_direction( int local , int local , int local , int local )
		_result = point_direction(_vInt_x1, _vInt_y1, _vInt_x2, _vInt_y2);
		assert_equals(_result, 35.8376, "#2 point_direction( int local , int local , int local , int local )")
			
		//#3 point_direction( int64 local , int64 local , int64 local , int64 local )
		_result = point_direction(_vInt64_x1, _vInt64_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 39.0938, "#3 point_direction( int64 local , int64 local , int64 local , int64 local )")
			
			
		//#1 point_direction( real local , real local , real local , real local )
		_result = point_direction(_vReal_x1, _vReal_y1, -_vReal_x2, -_vReal_y2);
		assert_equals(_result, 209.6444, "#1 point_direction( real local , real local , real local , real local )")
			
		//#2 point_direction( int local , int local , int local , int local )
		_result = point_direction(_vInt_x1, _vInt_y1, -_vInt_x2, -_vInt_y2);
		assert_equals(_result, 197.6501, "#2 point_direction( int local , int local , int local , int local )")
			
		//#3 point_direction( int64 local , int64 local , int64 local , int64 local )
		_result = point_direction(_vInt64_x1, _vInt64_y1, -_vInt64_x2, -_vInt64_y2);
		assert_equals(_result, 196.2602, "#3 point_direction( int64 local , int64 local , int64 local , int64 local )")
			
			
		//#4 point_direction( real local , real local , real local , real local )
		_result = point_direction(_vReal_x1, _vReal_y1, _vInt_x2, _vInt_y2);
		assert_equals(_result, 37.0267, "#4 point_direction( real local , real local , real local , real local )")
			
		//#5 point_direction( real local , real local , real local , real local )
		_result = point_direction(_vReal_x1, _vReal_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 37.0267, "#5 point_direction( real local , real local , real local , real local )")
			
		//#6 point_direction( real local , real local , real local , real local )
		_result = point_direction(_vInt_x1, _vInt_y1, _vInt64_x2, _vInt64_y2);
		assert_equals(_result, 35.8376, "#6 point_direction( real local , real local , real local , real local )")
			
			
		// zero angle
			
		//#7 point_direction( real local , real local , real local , real local )
		_result = point_direction(10.2, 99.5, 10.2, 99.5);
		assert_equals(_result, 0, "#7 point_direction( real local , real local , real local , real local )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_3d_test", function() {

		//point_distance_3d test
		//show_debug_message("start point_distance_3d() test");
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
			
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 4.3);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, -3.9);
			
		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 4);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);
		buffer_write(_buffer, buffer_s32, 4);
			
		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
		buffer_write(_buffer, buffer_u64, 4);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_z1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);
		var _vReal_z2 = buffer_read(_buffer, buffer_f32);
			
		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_z1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);
		var _vInt_z2 = buffer_read(_buffer, buffer_s32);
			
		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_z2 = buffer_read(_buffer, buffer_u64);
			
		math_set_epsilon(0.0001);
			
		var _result, _dx, _dy, _dz, _expected;
			
		//#1 point_distance_3d( real local , real local , real local , real local , real local , real local )
		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vReal_x2, _vReal_y2, _vReal_z2);
		_dx = _vReal_x2 - _vReal_x1;
		_dy = _vReal_y2 - _vReal_y1;
		_dz = _vReal_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#1 point_distance_3d( real local , real local , real local , real local , real local , real local )")
			
		//#2 point_distance_3d( int local , int local , int local , int local , int local , int local )
		_result = point_distance_3d(_vInt_x1, _vInt_y1, _vInt_z1, _vInt_x2, _vInt_y2, _vInt_z2);
		_dx = _vInt_x2 - _vInt_x1;
		_dy = _vInt_y2 - _vInt_y1;
		_dz = _vInt_z2 - _vInt_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#2 point_distance_3d( int local , int local , int local , int local , int local , int local )")
			
		//#3 point_distance_3d( int64 local , int64 local , int64 local , int64 local , int64 local , int64 local )
		_result = point_distance_3d(_vInt64_x1, _vInt64_y1, _vInt64_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vInt64_x1;
		_dy = _vInt64_y2 - _vInt64_y1;
		_dz = _vInt64_z2 - _vInt64_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#3 point_distance_3d( int64 local , int64 local , int64 local , int64 local , int64 local , int64 local )")
			
			
		//#4 point_distance_3d( real local , real local , real local , real local , real local , real local )
		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vInt_x2, _vInt_y2, _vInt_z2);
		_dx = _vInt_x2 - _vReal_x1;
		_dy = _vInt_y2 - _vReal_y1;
		_dz = _vInt_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#4 point_distance_3d( real local , real local , real local , real local , real local , real local )")
			
		//#5 point_distance_3d( real local , real local , real local , real local , real local , real local )
		_result = point_distance_3d(_vReal_x1, _vReal_y1, _vReal_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vReal_x1;
		_dy = _vInt64_y2 - _vReal_y1;
		_dz = _vInt64_z2 - _vReal_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#5 point_distance_3d( real local , real local , real local , real local , real local , real local )")
			
		//#6 point_distance_3d( real local , real local , real local , real local , real local , real local )
		_result = point_distance_3d(_vInt_x1, _vInt_y1, _vInt_z1, _vInt64_x2, _vInt64_y2, _vInt64_z2);
		_dx = _vInt64_x2 - _vInt_x1;
		_dy = _vInt64_y2 - _vInt_y1;
		_dz = _vInt64_z2 - _vInt_z1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) + (_dz*_dz) );
		assert_equals(_result, _expected, "#6 point_distance_3d( real local , real local , real local , real local , real local , real local )")
			
			
		// zero length
			
		//#7 point_distance_3d( real local , real local , real local , real local , real local , real local )
		_result = point_distance_3d(10.2, 99.5, -234, 10.2, 99.5, -234);
		assert_equals(_result, 0, "#7 point_distance_3d( real local , real local , real local , real local , real local , real local )")
			
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("point_distance_test", function() {

		//point_distance test
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
			
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_f32, 3.2);
		buffer_write(_buffer, buffer_f32, 9.8);
		buffer_write(_buffer, buffer_f32, 3.2);
			
		buffer_write(_buffer, buffer_s32, 2);
		buffer_write(_buffer, buffer_s32, 3);
		buffer_write(_buffer, buffer_s32, 20);
		buffer_write(_buffer, buffer_s32, -10);
			
		buffer_write(_buffer, buffer_u64, 4);
		buffer_write(_buffer, buffer_u64, 3);
		buffer_write(_buffer, buffer_u64, 20);
		buffer_write(_buffer, buffer_u64, -10);
			
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal_x1 = buffer_read(_buffer, buffer_f32);
		var _vReal_y1 = buffer_read(_buffer, buffer_f32);
		var _vReal_x2 = buffer_read(_buffer, buffer_f32);
		var _vReal_y2 = buffer_read(_buffer, buffer_f32);
			
		var _vInt_x1 = buffer_read(_buffer, buffer_s32);
		var _vInt_y1 = buffer_read(_buffer, buffer_s32);
		var _vInt_x2 = buffer_read(_buffer, buffer_s32);
		var _vInt_y2 = buffer_read(_buffer, buffer_s32);
			
		var _vInt64_x1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y1 = buffer_read(_buffer, buffer_u64);
		var _vInt64_x2 = buffer_read(_buffer, buffer_u64);
		var _vInt64_y2 = buffer_read(_buffer, buffer_u64);
			
		math_set_epsilon(0.0001);
			
		var _expected, _result, _dx, _dy;
			
		//#1 point_distance( real local , real local , real local , real local , real local , real local )
		_result = point_distance(_vReal_x1, _vReal_y1, _vReal_x2, _vReal_y2);
		_dx = _vReal_x2 - _vReal_x1;
		_dy = _vReal_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#1 point_distance( real local , real local , real local , real local )")
			
		//#2 point_distance( int local , int local , int local , int local , int local , int local )
		_result = point_distance(_vInt_x1, _vInt_y1, _vInt_x2, _vInt_y2);
		_dx = _vInt_x2 - _vInt_x1;
		_dy = _vInt_y2 - _vInt_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#2 point_distance( int local , int local , int local , int local )")
			
		//#3 point_distance( int64 local , int64 local , int64 local , int64 local , int64 local , int64 local )
		_result = point_distance(_vInt64_x1, _vInt64_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vInt64_x1;
		_dy = _vInt64_y2 - _vInt64_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#3 point_distance( int64 local , int64 local , int64 local , int64 local )")
			
			
		//#4 point_distance( real local , real local , real local , real local , real local , real local )
		_result = point_distance(_vReal_x1, _vReal_y1, _vInt_x2, _vInt_y2);
		_dx = _vInt_x2 - _vReal_x1;
		_dy = _vInt_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#4 point_distance( real local , real local , real local , real local )")
			
		//#5 point_distance( real local , real local , real local , real local , real local , real local )
		_result = point_distance(_vReal_x1, _vReal_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vReal_x1;
		_dy = _vInt64_y2 - _vReal_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#5 point_distance( real local , real local , real local , real local )")
			
		//#6 point_distance( real local , real local , real local , real local , real local , real local )
		_result = point_distance(_vInt_x1, _vInt_y1, _vInt64_x2, _vInt64_y2);
		_dx = _vInt64_x2 - _vInt_x1;
		_dy = _vInt64_y2 - _vInt_y1;
		_expected = sqrt( (_dx*_dx) + (_dy*_dy) );
		assert_equals(_result, _expected, "#6 point_distance( real local , real local , real local , real local )")
			
			
		// zero length
			
		//#7 point_distance( real local , real local , real local , real local , real local , real local )
		_result = point_distance(10.2, 99.5, 10.2, 99.5);
		assert_equals(_result, 0, "#7 point_distance( real local , real local , real local , real local )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("power_test", function() {

		//power test
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10);
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
			
		//#1 power( real local , real const )
		_result = power(_vReal , 2);
		assert_equals(_result, 6.25, "#1 power( real local , real const )")
			
		//#2 power( int local , real const )
		_result = power(_vInt, 2);
		assert_equals(_result, 100, "#2 power( int local , real const )")
			
		//#3 power( int64 local , real const )
		_result = power(_vInt64, 2);
		assert_equals(_result, 16, "#3 power( int64 local , real const )")
			
			
		//#4 power( real local , real const )
		_result = power(_vReal , 10);
		assert_equals(_result, 9536.7431640625, "#4 power( real local , real const )")
			
		//#5 power( int local , real const )
		_result = power(_vInt, 10);
		assert_equals(_result, 10000000000, "#5 power( int local , real const )")
			
		//#6 power( int64 local , real const )
		_result = power(_vInt64, 10);
		assert_equals(_result, 1048576, "#6 power( int64 local , real const )")
			
			
		//#7 power( real local , 0 )
		_result = power(_vReal , 0);
		assert_equals(_result, 1, "#7 power( real local , 0 )")
			
		//#8 power( int local , 0 )
		_result = power(_vInt, 0);
		assert_equals(_result, 1, "#8 power( int local , 0 )")
			
		//#9 power( int64 local , 0 )
		_result = power(_vInt64, 0);
		assert_equals(_result, 1, "#9 power( int64 local , 0 )")
			
			
		//#10 power( real local , 0 )
		_result = power(_vReal , -2);
		assert_equals(_result, 0.16, "#10 power( real local , 0 )")
			
		//#11 power( int local , 0 )
		_result = power(_vInt, -10);
		assert_equals(_result, 0.0000000001, "#11 power( int local , 0 )")
			
		//#12 power( int64 local , real const )
		_result = power(_vInt64, -3);
		assert_equals(_result, 0.015625, "#12 power( int64 local , 0 )")
			
			
			
		// negative value test
			
		//#13 power( real local , real const )
		_result = power(-_vReal , 2);
		assert_equals(_result, 6.25, "#13 power( real local , real const )")
			
		//#14 power( int local , real const )
		_result = power(-_vInt, 2);
		assert_equals(_result, 100, "#14 power( int local , real const )")
			
		//#15 power( int64 local , real const )
		_result = power(-_vInt64, 2);
		assert_equals(_result, 16, "#15 power( int64 local , real const )")
			
			
		//#16 power( real local , real const )
		_result = power(-_vReal , 10);
		assert_equals(_result, 9536.7431640625, "#16 power( real local , real const )")
			
		//#17 power( int local , real const )
		_result = power(-_vInt, 10);
		assert_equals(_result, 10000000000, "#17 power( int local , real const )")
			
		//#18 power( int64 local , real const )
		_result = power(-_vInt64, 10);
		assert_equals(_result, 1048576, "#18 power( int64 local , real const )")
			
			
		//#19 power( real local , 0 )
		_result = power(-_vReal , 0);
		assert_equals(_result, 1, "#19 power( real local , 0 )")
			
		//#20 power( int local , 0 )
		_result = power(-_vInt, 0);
		assert_equals(_result, 1, "#20 power( int local , 0 )")
			
		//#21 power( int64 local , real const )
		_result = power(-_vInt64, 0);
		assert_equals(_result, 1, "#21 power( int64 local , 0 )")
			
			
		//#22 power( real local , 0 )
		_result = power(-_vReal , -2);
		assert_equals(_result, 0.16, "#22 power( real local , 0 )")
			
		//#23 power( int local , 0 )
		_result = power(-_vInt, -10);
		assert_equals(_result, 0.0000000001, "#23 power( int local , 0 )")
			
		//#24 power( int64 local , real const )
		_result = power(-_vInt64, -3);
		assert_equals(_result, -0.015625, "#24 power( int64 local , 0 )")
			
			
		// test invalid types Infinity/NaN
			
		//#25 power( real local , infinity )
		_result = power(_vReal , _infinity);
		assert_true(is_infinity(_result), "#25 power( real local , infinity )")
			
		//#26 power( int local , infinity )
		_result = power(_vInt, _infinity);
		assert_true(is_infinity(_result), "#26 power( int local , infinity )")
			
		//27 power( int64 local , infinity )
		_result = power(_vInt64, _infinity);
		assert_true(is_infinity(_result), "#27 power( int64 local , infinity )")
			
			
		//#28 power( real local , NaN )
		_result = power(_vReal , _nan);
		assert_true(is_nan(_result), "#28 power( real local , NaN )")
			
		//#29 power( int local , NaN )
		_result = power(_vInt, _nan);
		assert_true(is_nan(_result), "#29 power( int local , NaN )")
			
		//#30 power( int64 local , NaN )
		_result = power(_vInt64, _nan);
		assert_true(is_nan(_result), "#30 power( int64 local , NaN )")
			
		//#31 power( int local , infinity )
		_result = power(_infinity, 2);
		assert_true(is_infinity(_result), "#31 power( int local , infinity )")
			
		//#32 power( int64 local , NaN )
		_result = power(_nan, 2);
		assert_true(is_nan(_result), "#32 power( int64 local , NaN )")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("radtodeg_test", function() {

		// radtodeg test
			
		//show_debug_message("Begin radtodeg test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		{
			var zero = radtodeg(0)
			var piTest = radtodeg(pi)
			var pi_2 = radtodeg(pi/2)
			var pi_4 = radtodeg(pi/4)
			var pi_by_2 = radtodeg(2*pi)
			assert_equals(zero, 0.0, "0 rad == 0 deg")
			assert_equals(piTest, 180.0, "Pi rad == 180 deg")
			assert_equals(pi_2, 90.0, "Pi/2 rad == 90 deg")
			assert_equals(pi_4, 45.0, "Pi/4 rad == 45 deg")
			assert_equals(round(pi_by_2), round(360), "2*Pi rad == 360 deg")
		}
			
		// Vars
		{
			var zero_rad = 0
			var piTest = pi
			var pi_2 = pi/2
			var pi_4 = pi/4
			var pi_by_2 = 2*pi
			
			var zero_deg = radtodeg(zero_rad)
			var piTest_deg = radtodeg(piTest)
			var pi_2_deg = radtodeg(pi_2)
			var pi_4_deg = radtodeg(pi_4)
			var pi_by_2_deg = radtodeg(pi_by_2)
			assert_equals(zero_deg, 0.0, "0 rad == 0 deg")
			assert_equals(piTest_deg, 180.0, "Pi rad == 180 deg")
			assert_equals(pi_2_deg, 90.0, "Pi/2 rad == 90 deg")
			assert_equals(pi_4_deg, 45.0, "Pi/4 rad == 45 deg")
			assert_equals(round(pi_by_2_deg), round(360.0), "2*Pi rad == 360 deg")
		}
			
		//show_debug_message("End radtodeg test")
	})

	addFact("round_test", function() {

		// Round test
			
		//show_debug_message("Begin round test")
			
		// Set up test data.
		var numOne = 2.5
		var numTwo = 3.5
		var numThree = 6.6
		var numFour = 7.9
		var numFive = 4.1
		var numSix = 99.2
			
		var roundedNumOne = round(numOne)
		var roundedNumTwo = round(numTwo)
		var roundedNumThree = round(numThree)
		var roundedNumFour = round(numFour)
		var roundedNumFive = round(numFive)
		var roundedNumSix = round(numSix)
		assert_equals(roundedNumOne, 2, "#1 Rounding 2.5 down to 2")
		assert_equals(roundedNumTwo, 4, "#2 Rounding 3.5 up to 4")
		assert_equals(roundedNumThree, 7, "#3 Rounding 6.6 up to 7")
		assert_equals(roundedNumFour, 8, "#4 Rounding 7.9 up to 8")
		assert_equals(roundedNumFive, 4, "#5 Rounding 4.1 down to 4")
		assert_equals(roundedNumSix, 99, "#6 Rounding 99.2 down to 99")
			
		// Negative numbers
		var negNumOne = -2.5
		var negNumTwo = -3.5
		var negNumThree = -76.9
		var negNumFour = -34.1
		var negNumFive = -83.6
			
		var roundedNegNumOne = round(negNumOne)
		var roundedNegNumTwo = round(negNumTwo)
		var roundedNegNumThree = round(negNumThree)
		var roundedNegNumFour = round(negNumFour)
		var roundedNegNumFive = round(negNumFive)
		assert_equals(roundedNegNumOne, -2, "#1 Rounding -2.5 up to -2")
		assert_equals(roundedNegNumTwo, -4, "#2 Rounding -3.5 down to -4")
		assert_equals(roundedNegNumThree, -77, "#3 Rounding -76.9 down to -77")
		assert_equals(roundedNegNumFour, -34, "#4 Rounding -34.1 up to -34")
		assert_equals(roundedNegNumFive, -84, "#5 Rounding -83.6 down to -84")
			
		// Whole numbers
		var wholeNumOne = 3.0
		var wholeNumTwo = 99.0
		var wholeNegNumOne = -8.0
		var wholeNegNumTwo = -44.0
		var roundedWholeNumOne = round(wholeNumOne)
		var roundedWholeNumTwo = round(wholeNumTwo)
		var roundedWholeNegNumOne = round(wholeNegNumOne)
		var roundedWholeNegNumTwo = round(wholeNegNumTwo)
		assert_equals(roundedWholeNumOne, 3, "#1 Rounded Whole Num 3 to 3")
		assert_equals(roundedWholeNumTwo, 99, "#2 Rounded Whole Num 99 to 99")
		assert_equals(roundedWholeNegNumOne, -8, "#1 Rounded Whole Negative Num -8 to -8")
		assert_equals(roundedWholeNegNumTwo, -44, "#2 Rounded Whole Negative Num -44 to -44")
			
		// Literals
		assert_equals(round(7.5), 8, "#1 Rounded Literal 7.5 to 8")
		assert_equals(round(6.5), 6, "#2 Rounded Literal 6.5 to 6")
		assert_equals(round(0.3), 0, "#3 Rounded Literal 0.3 to 0")
		assert_equals(round(-3.5), -4, "#4 Rounded Literal -3.5 to -4")
		assert_equals(round(-2.5), -2, "#5 Rounded Literal -2.5 to -2")
		assert_equals(round(-0.3), 0, "#6 Rounded Literal -0.3 to 0")
		assert_equals(round(-7.3), -7, "7 Rounded Literal -7.3 to -7")
			
		//show_debug_message("End round test")
	})

	addFact("sign_test", function() {

		// Sign test
			
		//show_debug_message("Begin sign test")
			
		// Basic tests 
		var positiveOne = 1
		var negativeOne = -1
		var zero = 0
			
		var signPositiveOne = sign(positiveOne)
		var signNegativeOne = sign(negativeOne)
		var signZero = sign(zero)
		assert_equals(signPositiveOne, 1, "#1 Sign of 1 is 1")
		assert_equals(signNegativeOne, -1, "#2 Sign of -1 is -1")
		assert_equals(signZero, 0, "#3 Sign of 0 is 0")
			
		// Numeric tests
		var numOne = 77.1
		var numTwo = -77.1
		var numThree = 45
		var numFour = 89.2
		var numFive = 12345678
		var numSix = -12345678
		var hexOne = 0x80
			
		var _buffer = buffer_create(16, buffer_fixed, 1 );
		buffer_write(_buffer, buffer_s32, 0xFFFFFF80);
		var hexTwo = buffer_peek(_buffer, 0, buffer_s32);
			
		var signOne = sign(numOne)
		var signTwo = sign(numTwo)
		var signThree = sign(numThree)
		var signFour = sign(numFour)
		var signFive = sign(numFive)
		var signSix = sign(numSix)
		var signHexOne = sign(hexOne)
		var signHexTwo = sign(hexTwo)
		assert_equals(signOne, 1, "#1 Sign of 77.1 is 1")
		assert_equals(signTwo, -1, "#2 Sign of -77.1 is -1")
		assert_equals(signThree, 1, "#3 Sign of 45 is 1")
		assert_equals(signFour, 1, "#4 Sign of 89.2 is 1")
		assert_equals(signFive, 1, "#5 Sign of 12345678 is 1")
		assert_equals(signSix, -1, "#6 Sign of -12345678 is -1")
		assert_equals(signHexOne, 1, "#7 Sign of 128 is 1")
		assert_equals(signHexTwo, -1, "#8 Sign of -128 is -1")
			
		// Literals
		assert_equals(sign(1), 1, "#1 Sign of 1 is 1")
		assert_equals(sign(-1), -1, "#2 Sign of -1 is -1")
		assert_equals(sign(0), 0, "#3 Sign of 0 is 0")
		assert_equals(sign(5), 1, "#4 Sign of 5 is 1")
		assert_equals(sign(-5), -1, "#5 Sign of -5 is -1")
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("sin_test", function() {

		// Sin (radian angle) Test
			
		//show_debug_message("Begin sin test")
			
		// Basic tests
		var sinZero = sin(0)
		var sinPi = sin(pi)
		var sinTwoPi = sin(2*pi)
		assert_equals(sinZero, 0, "#1 sin(0) equals zero")
		assert_equals(sinPi, 0, "#2 sin(pi) equals zero")
		assert_equals(sinTwoPi, 0, "#3 sin(2*pi) equals zero")
			
		var _xPos = 0
		while (_xPos < (2*pi))
		{
			assert_less_or_equal(_xPos, (2*pi), "Ensure _xPos is always less than 2*pi")
			
			var _yPos = sin(_xPos)
			assert_greater_or_equal(_yPos, -1, "Y Pos should always be greater than -1")
			assert_less_or_equal(_yPos, 1, "Y Pos should always be less than 1")
			
			_xPos += 0.01
		}
			
		//show_debug_message("End sin test")
	})

	addFact("sqrt_negative_num_test", function() {

		// Sqrt Negative Num Test
		assert_throw(function() {
			var _number = -1
			return sqrt(_number)
		}, "#1 Calling 'sqrt' on negative number (should throw error)");
	
	})

	addFact("sqrt_test", function() {

		// Sqrt Test
			
		//show_debug_message("Begin Sqrt Test")
			
		// Basic tests
		var squareNumOne = 4
		var squareNumTwo = 9
		var squareNumThree = 16
		var squareNumFour = 25
			
		var rootNumOne = sqrt(squareNumOne)
		var rootNumTwo = sqrt(squareNumTwo)
		var rootNumThree = sqrt(squareNumThree)
		var rootNumFour = sqrt(squareNumFour)
		assert_equals(rootNumOne, 2, "#1 Square root of 4")
		assert_equals(rootNumTwo, 3, "#2 Square root of 9")
		assert_equals(rootNumThree, 4, "#3 Square root of 16")
		assert_equals(rootNumFour, 5, "#4 Square root of 25")
			
		// Product operations
		var sixteenBySixteen = 16*16
		var rootRes = sqrt(sixteenBySixteen)
		assert_equals(rootRes, 16, "Sqrt of 16 * 16")
			
		var squareSixteen = sqr(16)
		var squareSixteenRes = sqrt(squareSixteen)
		assert_equals(squareSixteenRes, 16, "Sqrt of sqr(16)")
			
		// Big number
		var bigNum = 0x100000000
		var sqrtBigNumRes = sqrt(bigNum)
		assert_equals(sqrtBigNumRes, 65536, "Sqrt of 0x100000000")
			
		//show_debug_message("End Sqrt Test")
	})

	addFact("sqr_test", function() {

		//sqr test
		//show_debug_message("start sqr() test");
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		var _buffer = buffer_create(16, buffer_grow, 1 );
		buffer_write(_buffer, buffer_f32, 2.5);
		buffer_write(_buffer, buffer_s32, 10);
		buffer_write(_buffer, buffer_u64, 4);
		buffer_seek(_buffer, buffer_seek_start, 0);
			
		var _vReal = buffer_read(_buffer, buffer_f32);
		var _vInt = buffer_read(_buffer, buffer_s32);
		var _vInt64 = buffer_read(_buffer, buffer_u64);
			
		var _infinity = infinity;
		var _nan = NaN;
			
		var _result;
			
		//#1 sqr( real local )
		_result = sqr(_vReal);
		assert_equals(_result, 6.25, "#1 sqr( real local )")
			
		//#2 sqr( int local )
		_result = sqr(_vInt);
		assert_equals(_result, 100, "#2 sqr( int local )")
			
		//#3 sqr( int64 local )
		_result = sqr(_vInt64);
		assert_equals(_result, 16, "#3 sqr( int64 local )")
			
			
		//#4 sqr( real const )
		_result = sqr(2.5);
		assert_equals(_result, 6.25, "#4 sqr( real const )")
			
		//#5 sqr( int const )
		_result = sqr(10);
		assert_equals(_result, 100, "#5 sqr( int const )")
			
		//#6 sqr( int64 const )
		_result = sqr(int64(4));
		assert_equals(_result, 16, "#6 sqr( int64 const )")
			
			
		// negative value tests
			
		//#7 sqr( real local )
		_result = sqr(-_vReal);
		assert_equals(_result, 6.25, "#7 sqr( real local )")
			
		//#8 sqr( int local )
		_result = sqr(-_vInt);
		assert_equals(_result, 100, "#8 sqr( int local )")
			
		//#9 sqr( int64 local )
		_result = sqr(-_vInt64);
		assert_equals(_result, 16, "#9 sqr( int64 local )")
			
			
		//#10 sqr( real const )
		_result = sqr(-2.5);
		assert_equals(_result, 6.25, "#10 sqr( real const )")
			
		//#11 sqr( int const )
		_result = sqr(-10);
		assert_equals(_result, 100, "#11 sqr( int const )")
			
		//#12 sqr( int64 const )
		_result = sqr(int64(-4));
		assert_equals(_result, 16, "#12 sqr( int64 const )")
			
			
		// zero test
			
		//#13 sqr( 0 )
		_result = sqr(0);
		assert_equals(_result, 0, "#13 sqr( 0 )")
			
		// one test
			
		//#14 sqr( 1 )
		_result = sqr(1);
		assert_equals(_result, 1, "#14 sqr( 1 )")
			
		// infinity test
			
		//#15 sqr( infinity )
		_result = sqr(_infinity);
		assert_true(is_infinity(_result), "#15 sqr( infinity )")
			
		// NaN test
			
		//#16 sqr( NaN )
		_result = sqr(_nan);
		assert_true(is_nan(_result), "#16 sqr( NaN )")
			
			
		// Clean up
		buffer_delete(_buffer);
	})

	addFact("tan_test", function() {

		// Tan (radian angle) Test
			
		//show_debug_message("Begin tan test")
			
		// Set an explicit epsilon to account for different default epsilons in YYC and VM.
		math_set_epsilon(0.00001)
			
		// Basic tests
		var tanZero = tan(0)
		var tanPi = tan(pi)
		var tanTwoPi = tan(2*pi)
		assert_equals(tanZero, 0, "#1 Tan Zero == 0")
		assert_equals(tanPi, 0, "#2 Tan Pi == 0")
		assert_equals(tanTwoPi, 0, "#3 Tan 2*pi == 0")
			
		// Consts
		#macro kPiDivFour_TanTest (pi/4)
		//show_debug_message("kPiDivFour_TanTest: " + string(kPiDivFour_TanTest))
			
		// tan(x) = 1
		var tanFortyFiveDeg = tan(kPiDivFour_TanTest)
		var tanTwoTwoFiveDeg = tan((kPiDivFour_TanTest) + pi)
		assert_equals(tanFortyFiveDeg, 1, "#4 Tan Pi/4 == 1")
		assert_equals(tanTwoTwoFiveDeg, 1, "#5 Tan Pi + Pi/4 == 1")
			
		// tan(x) = -1
		var tanOneThirtyFiveDeg = tan((pi) - (kPiDivFour_TanTest))
		var tanThreeFifteenDeg = tan((pi*2) - (kPiDivFour_TanTest))
		assert_equals(tanOneThirtyFiveDeg, -1, "#6 Tan Pi - (Pi/4) == -1")
		assert_equals(tanThreeFifteenDeg, -1, "#7 Tan (Pi * 2) - (Pi/4) == -1")
			
		//show_debug_message("End tan test")
	})
	
}