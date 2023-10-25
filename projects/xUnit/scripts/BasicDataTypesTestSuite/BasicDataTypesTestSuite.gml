

function BasicDataTypesTestSuite() : TestSuite() constructor {

	// TYPE CONVERSION

	addFact("bool_test_skip", function() {

		var input, output;
			
		//#1 bool(pointer)
		input = ptr({});
		output = bool(input);
		assert_true(output, "#1 bool ( pointer:local ), should return true");
		assert_typeof(output, "bool", "#1.1 bool ( pointer:local ), should be of type bool");
			
		//#2 bool(pointer_invalid)
		input = pointer_invalid;
		output = bool(input);
		assert_true(output, "#2 bool ( pointer_invalid:local ), should be true");
		assert_typeof(output, "bool", "#2.1 bool ( pointer_invalid:local ), should return bool type");
		
		//#3 bool(pointer_null) should be false
		input = pointer_null;
		output = bool(input);
		assert_false(output, "#3 bool ( pointer_null:local ), should be false");
		assert_typeof(output, "bool", "#3.1 bool ( pointer_null:local ), should be of type bool");
		
	}, { test_filter: platform_noone });

	addFact("bool_test", function() {

		var input, output;
					
		//#4 bool(real) should be true
		input = 32.33;
		output = bool(input);
		assert_true(output, "#4 bool ( real:local ), should be true");
		assert_typeof(output, "bool", "#4.1 bool ( real:local ), should return bool type");
			
		//#5 bool(real) <= 0.5 should be false
		input = 0.5;
		output = bool(input);
		assert_false(output, "#5 bool ( real:local ), <= 0.5 should be false");
		assert_typeof(output, "bool", "#5.1 bool ( real:local ), should return bool type");
			
		//#6 bool(real) > 0.5 should be true
		input = 0.55;
		output = bool(input);
		assert_true(output, "#6 bool ( real:local ), > 0.5 should be true");
		assert_typeof(output, "bool", "#6.1 bool ( real:local ), should return bool type");
			
		//#7 bool(int32) should be true
		input = int32(12);
		output = bool(input);
		assert_true(output, "#7 bool ( int32:local ), should be true");
		assert_typeof(output, "bool", "#7.1 bool ( int32:local ), should return bool type");
			
		//#8 bool(int64) should be true
		input = int64(32);
		output = bool(input);
		assert_true(output, "#8 bool ( int64:local ), should be true");
		assert_typeof(output, "bool", "#8.1 bool ( int64:local ), should return bool type");
			
		//#9 bool('true') should be true
		input = "true";
		output = bool(input);
		assert_true(output, "#9 bool ( 'true':local ), should be true");
		assert_typeof(output, "bool", "#9.1 bool ( 'true':local ), should return bool type");
			
		//#10 bool('false') should be false
		input = "false";
		output = bool(input);
		assert_false(output, "#10 bool ( 'false':local ), should be false");
		assert_typeof(output, "bool", "#10.1 bool ( 'false':local ), should return bool type");
			
		//#11 bool(bool) should be false
		input = true;
		output = bool(input);
		assert_true(output, "#11 bool ( bool:local ), should be true");
		assert_typeof(output, "bool", "#11.1 bool ( bool:local ), should return bool type");
			
		//#12 bool(nan) should be false
		input = NaN;
		output = bool(input);
		assert_false(output, "#12 bool ( nan:local ), should be false");
		assert_typeof(output, "bool", "#12.1 bool ( nan:local ), should return bool type");
			
		//#13 bool(infinity) should be false
		input = infinity;
		output = bool(input);
		assert_true(output, "#13 bool ( infinity:local ), should be true");
		assert_typeof(output, "bool", "#13.1 bool ( infinity:local ), should return bool type");
			
		//#14 bool(undefined) should be false
		input = undefined;
		output = bool(input);
		assert_false(output, "#14 bool ( undefined:local ), should be false");
		assert_typeof(output, "bool", "#14.1 bool ( undefined:local ), should return bool type");

		//#14 bool(struct) should be true
		input = {};
		output = bool(input);
		assert_true(output, "#15 bool ( struct:local ), should be true");
		assert_typeof(output, "bool", "#15.1 bool ( struct:local ), should return bool type");
			
		//#15 bool(struct) should be true
		input = function() {};
		output = bool(input);
		assert_true(output, "#16 bool ( method:local ), should be true");
		assert_typeof(output, "bool", "#16.1 bool ( method:local ), should return bool type");

		//#16 bool(array) should throw error
		assert_throw(function() {
			var input = [];
			return bool(input);
		}, "#17 bool ( array ), should throw error");
		
		//#17 bool ( string ), where string is not 'true'/'false', should throw error
		assert_throw(function() {
			var input = "string";
			return bool(input);
		}, "#18 bool ( string ), where string is not 'true'/'false', should throw error");
			
	})

	addFact("int64_test", function() {
		
		var _input, _output;
		
		var i = 0;
		
		//#1 int64 ( pointer )
		_input = ptr({});
		_output = int64(_input);
		assert_not_null(_output, "#1 int64 ( pointer:local ), should not be null");
		assert_typeof(_output, "int64", "#1.1 int64 ( pointer:local ), should be of type int64");
			
		//#4 int64 ( real ) should be true
		_input = 32.33;
		_output = int64(_input);
		assert_equals(_output, round(_input), "#4 int64 ( real:local ), should be rounded value");
		assert_typeof(_output, "int64", "#4.1 int64 ( real:local ), should return int64 type");
			
		//#5 int64 ( int32 ) should be true
		_input = int32(22);
		_output = int64(_input);
		assert_equals(_output, _input, "#5 int64 ( int32:local ), should be equal to _input");
		assert_typeof(_output, "int64", "#5.1 int64 ( int32:local ), should return int64 type");
			
		//#6 int64 ( int64 ), should be true
		_input = int64(12);
		_output = int64(_input);
		assert_equals(_output, _input, "#6 int64 ( int64:local ), should be equal to _input");
		assert_typeof(_output, "int64", "#6.1 int64 ( int64:local ), should return int64 type");
					
		//#7 int64 ( string ), with real value, should be converted and floored
		_input = "1.72";
		_output = int64(_input);
		assert_equals(_output, 1, "#7 int64 ( string:local ), with real value, should be rounded value");
		assert_typeof(_output, "int64", "#7.1 int64 ( string:local ), should return int64 type");
					
		//#8 int64 ( string ), with real value, should be converted and floored
		_input = "-21233.223";
		_output = int64(_input);
		assert_equals(_output, -21233, "#8 int64 ( string:local ), with real negative value, should be rounded value");
		assert_typeof(_output, "int64", "#8.1 int64 ( string:local ), should return int64 type");

		//#9 int64 ( string ), with real value, should be converted and floored
		_input = "+21233.223";
		_output = int64(_input);
		assert_equals(_output, 21233, "#9 int64 ( string:local ), with real signed positive value, should be rounded value");
		assert_typeof(_output, "int64", "#9.1 int64 ( string:local ), should return int64 type");

		//#10 int64 ( nan ), should be NaN
		_input = NaN;
		_output = int64(_input);
		assert_equals(_output, 0, "#10 int64 ( nan:local ), should be 0");
		assert_typeof(_output, "int64", "#10.1 int64 ( nan:local ), should return number type");
			
		//#11 int64 ( infinity ), should be infinity
		_input = infinity;
		_output = int64(_input);
		assert_equals(_output, 9223372036854775807, "#11 int64 ( infinity:local ), should equal to infinity");
		assert_typeof(_output, "int64", "#11.1 int64 ( infinity:local ), should return number type");

		//#12 int64 ( struct ), should be NaN
		_input = { key: "value" };
		_output = int64(_input);
		assert_equals(_output, 0, "#12 int64 ( struct:local ), should be 0");
		assert_typeof(_output, "int64", "#12.1 int64 ( struct:local ), should return number type");

		//#13 int64 ( function ), should be NaN
		_input = function() {};
		_output = int64(_input);
		assert_equals(_output, 0, "#13 int64 ( function:local ), should be NaN 0");
		assert_typeof(_output, "int64", "#13.1 int64 ( function:local ), should return number type");

		//#14 int64 ( string ) that is not a number, should throw error
		assert_throw(function() {
			var _input = "string";
			return int64(_input);
		}, "#14 int64 ( string ), should throw error");

		//#15 int64 ( array ), should throw error
		assert_throw(function() {
			var _input = [];
			return int64(_input);
		}, "#15 int64 ( array ), should throw error");
		
		//#16 int64 ( undefined ), should throw error
		assert_throw(function() {
			var _input = undefined
			return int64(_input);
		}, "#16 int64 ( undefined ), should throw error");
		
	})

	addFact("string_test", function() {
	
		var input, output;
			
		//#1 string ( pointer ), should not be undefined
		input = ptr({});
		output = string(input);
		assert_not_undefined(output, "#1 string ( pointer:local ), should not be undefined");
		assert_typeof(output, "string", "#1.1 string ( pointer:local ), should be of type string");
			
		//#3 string ( pointer_null ), should be 'null'
		input = pointer_null;
		output = string(input);
		assert_equals(output, "null", "#3 string ( pointer_null:local ), should be 'null'");
		assert_typeof(output, "string", "#3.1 string ( pointer_null:local ), should be of type string");
			
		//#4 string ( real ), should be the equivalent string value
		input = 32.33;
		output = string(input);
		assert_equals(output, "32.33", "#4 string ( real:local ), should be the equivalent string value");
		assert_typeof(output, "string", "#4.1 string ( real:local ), should return string type");
			
		//#5 string ( int32 ), should be the equivalent string value
		input = int32(22);
		output = string(input);
		assert_equals(output, "22", "#5 string ( int32:local ), should be the equivalent string value");
		assert_typeof(output, "string", "#5.1 string ( int32:local ), should return string type");
			
		//#6 string ( int64 ), should be the equivalent string value
		input = int64(223231);
		output = string(input);
		assert_equals(output, "223231", "#6 string ( int32:local ), should be the equivalent string value");
		assert_typeof(output, "string", "#6.1 string ( int32:local ), should return string type");
					
		//#7 string ( string ), should be the input value
		input = "-21233.223";
		output = string(input);
		assert_equals(output, input, "#7 string ( string:local ), should be the input value");
		assert_typeof(output, "string", "#7.1 string ( string:local ), should return string type");
			
		//#8 string ( nan ), should be 'NaN'
		input = NaN;
		output = string(input);
		assert_equals(output, "NaN", "#8 string ( nan:local ), should be 'NaN'");
		assert_typeof(output, "string", "#8.1 string ( nan:local ), should return string type");
			
		//#9 string ( infinity ), should be 'inf'
		input = infinity;
		output = string(input);
		assert_equals(output, "inf", "#9 string ( infinity:local ), should be 'inf'");
		assert_typeof(output, "string", "#9.1 string ( infinity:local ), should return string type");

		//#10 string ( struct ), should be 'undefined'
		input = undefined;
		output = string(input);
		assert_equals(output, "undefined", "#10 string ( undefined:local ), should be 'undefined'");
		assert_typeof(output, "string", "#10.1 string ( undefined:local ), should return string type");

		//#11 string ( struct ), should be the equivalent string value
		input = { key: "value" };
		output = string(input);
		assert_equals(output, @'{ key : "value" }', "#11 string ( struct:local ), should be the equivalent string value");
		assert_typeof(output, "string", "#11.1 string ( struct:local ), should return string type");

		//#12 string ( array ), should be the equivalent string value
		input = [1, 2, 3];
		output = string(input);
		assert_equals(output, @'[ 1,2,3 ]', "#12 string ( array:local ), should be the equivalent string value");
		assert_typeof(output, "string", "#12.1 string ( array:local ), should return string type");
			
		//#13 string ( method ), should not throw error
		assert_not_throws(function() {
			var input = function() {};
			return string(input);
		}, "#13 string ( method ), should not throw error");
		
	})

	addFact("real_test", function() {
			
		var input, output;
			
		//#1 real ( real ) should be true
		input = 32.33;
		output = real(input);
		assert_equals(output, input, "#1 real ( real:local ), should be the input value");
		assert_typeof(output, "number", "#1.1 real ( real:local ), should return number type");
			
		//#2 real ( int32 ) should be true
		input = int32(22);
		output = real(input);
		assert_equals(output, input, "#2 real ( int32:local ), should be the input value");
		assert_typeof(output, "number", "#2.1 real ( int32:local ), should return number type");
			
		//#3 real ( real ), should be true
		input = real(12);
		output = real(input);
		assert_equals(output, input, "#3 real ( real:local ), should be the input value");
		assert_typeof(output, "number", "#3.1 real ( real:local ), should return number type");
					
		//#4 real ( string ), with real value, should be converted and floored
		input = "1.72";
		output = real(input);
		assert_equals(output, 1.72, "#4 real ( bool:local ), should be the parsed input value");
		assert_typeof(output, "number", "#4.1 real ( bool:local ), should return number type");
					
		//#5 real ( string ), with real value, should be converted and floored
		input = "-21233.223";
		output = real(input);
		assert_equals(output, -21233.223, "#5 real ( string:local ), should be the parsed input value");
		assert_typeof(output, "number", "#5.1 real ( string:local ), should return number type");

		//#6 real ( string ), with real value, should be converted and floored
		input = "+21233.223";
		output = real(input);
		assert_equals(output, 21233.223, "#6 real ( string:local ), should be the parsed input value");
		assert_typeof(output, "number", "#6.1 real ( string:local ), should return number type");

		//#7 real ( nan ), should be false
		input = NaN;
		output = real(input);
		assert_nan(output, "#7 real ( nan:local ), should be NaN");
		assert_typeof(output, "number", "#7.1 real ( nan:local ), should return number type");
			
		//#8 real ( infinity ), should be false
		input = infinity;
		output = real(input);
		assert_equals(output, infinity, "#8 real ( infinity:local ), should equal infinity");
		assert_typeof(output, "number", "#8.1 real ( infinity:local ), should return number type");

		//#9 real ( struct ), should be false
		input = { key: "value" };
		output = real(input);
		assert_nan(output, "#9 real ( struct:local ), should be NaN");
		assert_typeof(output, "number", "#9.1 real ( struct:local ), should return number type");

		//#10 int64 ( function ), should be NaN
		input = function() {};
		output = real(input);
		assert_nan(output, "#10 real ( function:local ), should be NaN");
		assert_typeof(output, "number", "#10.1 real ( function:local ), should return number type");

		//#11 real ( string ) that is not a number, should throw error
		assert_throw(function() {
			var input = "string";
			return real(input);
		}, "#11 real ( 'string' ), should throw error");

		//#12 real ( array ), should throw error
		assert_throw(function() {
			var input = [];
			return real(input);
		}, "#12 real ( array ), should throw error");
		
		//#13 real ( undefined ), should throw error
		assert_throw(function() {
			var input = undefined
			return real(input);
		}, "#13 real ( undefined ), should throw error");
			
		//#14 real ( undefined ), should throw error
		assert_throw(function() {
			var input = ptr({});
			return real(input);
		}, "#14 real ( ptr ), should throw error");
			
		//#15 real ( undefined ), should throw error
		assert_throw(function() {
			var input = pointer_null;
			return real(input);
		}, "#15 real ( pointer_null ), should throw error");

		//#16 real ( undefined ), should throw error
		assert_throw(function() {
			var input = pointer_invalid;
			return real(input);
		}, "#16 real ( pointer_invalid ), should throw error");
			
	})

/*
	addFact("ptr_test", function() {
		
		var input, output;
				
		//#1 ptr ( pointer )
		input = ptr({});
		output = ptr(input);
		assert_not_null(output, "#1 ptr ( pointer:local ), should not be null");
		assert_typeof(output, "ptr", "#1.1 ptr ( pointer:local ), should be of type ptr");
			
		//#2 ptr ( pointer_invalid )
		input = pointer_invalid;
		output = ptr(input);
		assert_not_null(output, "#2 ptr ( pointer_invalid:local ), should not be null");
		assert_typeof(output, "ptr", "#2.1 ptr ( pointer_invalid:local ), should return ptr type");
						
		//#3 ptr ( pointer_null ) should be null
		input = pointer_null;
		output = ptr(input);
		assert_null(output, "#3 ptr ( pointer_null:local ), should be null");
		assert_typeof(output, "ptr", "#3.1 ptr ( pointer_null:local ), should be of ptr type");
			
		//#4 ptr ( ptr ) should be valid
		input = 32.33;
		output = ptr(input);
		assert_not_null(output, "#4 ptr ( real:local ), should not be null");
		assert_typeof(output, "ptr", "#4.1 ptr ( real:local ), should return ptr type");
			
		//#5 ptr ( int32 ) should be valid
		input = int32(22);
		output = ptr(input);
		assert_not_null(output, "#5 ptr ( int32:local ), should not be null");
		assert_typeof(output, "ptr", "#5.1 ptr ( int32:local ), should return ptr type");
									
		//#6 ptr ( string ), should be valid
		input = "1.72";
		output = ptr(input);
		assert_not_null(output, "#6 ptr ( string:local ), should not be null");
		assert_typeof(output, "ptr", "#6.1 ptr ( string:local ), should return ptr type");
				
		//#7 ptr ( nan ), valid convertion
		assert_not_throws(function() {
				
			var input = NaN;
			var output = ptr(input);
			assert_typeof(output, "ptr", "#7.1 ptr ( nan:local ), should return ptr type");
				
		}, "#7 ptr ( nan:local ), should not throw an error, valid convertion" );

		//#8 ptr ( infinity ), valid convertion
		assert_not_throws(function() {
				
			var input = infinity;
			var output = ptr(input);
			assert_typeof(output, "ptr", "#8.1 ptr ( infinity:local ), should return ptr type");
				
		}, "#8 ptr ( infinity:local ), should not throw an error, valid convertion" );
		
				
		//#9 ptr ( struct ), valid convertion
		assert_not_throws(function() {
				
			var input = { key: "value" };
			var output = ptr(input);
			assert_typeof(output, "ptr", "#9.1 ptr ( struct:local ), should return ptr type");
				
		}, "#9 ptr ( struct:local ), should not throw an error, valid convertion" );
		
				
		//#10 ptr ( method ), valid convertion
		assert_not_throws(function() {
				
			var input = function() {};
			var output = ptr(input);
			assert_typeof(output, "ptr", "#10.1 ptr ( method:local ), should return ptr type");
				
		}, "#10 ptr ( method:local ), should not throw an error, valid convertion" );
		
				
		if (platform_not_browser()) {
			//#11 ptr ( array ), valid convertion
			assert_not_throws(function() {
				var input = [];
				return ptr(input);
			}, "#11 ptr ( array ), should not throw an error, valid convertion");
		}
		
				
		//#12 ptr ( undefined )
		assert_throw(function() {
			var input = undefined
			return ptr(input);
		}, "#12 ptr ( undefined ), should throw error");
			
	})
*/

	// TYPE CHECKING
	
	addTheory("is_array_test", [
	
		[ptr({}),				assert_false,	"#1 is_array ( pointer:local ), should be false"],
		[pointer_invalid,		assert_false,	"#2 is_array ( pointer_invalid:local ), should be false"],
		[pointer_null,			assert_false,	"#3 is_array ( pointer_null:local ), should be false"],
		
		[32.33,					assert_false,	"#4 is_array ( real:local ), should be false"],
		[int32(22),				assert_false,	"#5 is_array ( int32:local ), should be false"],
		[int64(12),				assert_false,	"#6 is_array ( int64:local ), should be false"],
		
		[RainbowColors.Orange,	assert_false,	"#7 is_array ( int64:local ), should be false (enum entries are always int64)"],
		
		["-21233.223",			assert_false,	"#8 is_array ( string:local ), numeric string should be false"],
		[true,					assert_false,	"#9 is_array ( bool:local ), should be false"],
		[NaN,					assert_false,	"#10 is_array ( NaN:local ), should be false"],
		[infinity,				assert_false,	"#11 is_array ( infinity:local ), should be false"],
		[undefined,				assert_false,	"#12 is_array ( undefined:local ), should be false"],
		
		[[],					assert_true,	"#13 is_array ( array:local ), should be true"],
		[{ key: "value" },		assert_false,	"#14 is_array ( struct:local ), should be false"],
		[function() {},			assert_false,	"#15 is_array ( method:local ), should be false"],
		[get_timer,				assert_false,	"#16 is_array ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_array(_input)
		_test_func(_output, _desc);
		
	})

	
	addTheory("is_bool_test", [
	
		[ptr({}),				assert_false,	"#1 is_bool ( pointer:local ), should be false"],
		[pointer_invalid,		assert_false,	"#2 is_bool ( pointer_invalid:local ), should be false"],
		[pointer_null,			assert_false,	"#3 is_bool ( pointer_null:local ), should be false"],
		
		[32.33,					assert_false,	"#4 is_bool ( real:local ), should be false"],
		[int32(22),				assert_false,	"#5 is_bool ( int32:local ), should be false"],
		[int64(12),				assert_false,	"#6 is_bool ( int64:local ), should be false"],
		
		[RainbowColors.Orange,	assert_false,	"#7 is_bool ( int64:local ), should be false (enum entries are always int64)"],
		
		["-21233.223",			assert_false,	"#8 is_bool ( string:local ), numeric string should be false"],
		[true,					assert_true,	"#9 is_bool ( bool:local ), should be true"],
		[NaN,					assert_false,	"#10 is_bool ( NaN:local ), should be false"],
		[infinity,				assert_false,	"#11 is_bool ( infinity:local ), should be false"],
		[undefined,				assert_false,	"#12 is_bool ( undefined:local ), should be false"],
		
		[[],					assert_false,	"#13 is_bool ( array:local ), should be false"],
		[{ key: "value" },		assert_false,	"#14 is_bool ( struct:local ), should be false"],
		[function() {},			assert_false,	"#15 is_bool ( method:local ), should be false"],
		[get_timer,				assert_false,	"#16 is_bool ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_bool(_input)
		_test_func(_output, _desc);
		
	})
	

	addTheory("is_infinity_test", [
	
		[ptr({}),				assert_false,	"#1 is_infinity ( pointer:local ), should be false"],
		[pointer_invalid,		assert_false,	"#2 is_infinity ( pointer_invalid:local ), should be false"],
		[pointer_null,			assert_false,	"#3 is_infinity ( pointer_null:local ), should be false"],
		
		[32.33,					assert_false,	"#4 is_infinity ( real:local ), should be false"],
		[int32(22),				assert_false,	"#5 is_infinity ( int32:local ), should be false"],
		[int64(12),				assert_false,	"#6 is_infinity ( int64:local ), should be false"],
		
		[RainbowColors.Orange,	assert_false,	"#7 is_infinity ( int64:local ), should be false (enum entries are always int64)"],
		
		["-21233.223",			assert_false,	"#8 is_infinity ( string:local ), numeric string should be false"],
		[true,					assert_false,	"#9 is_infinity ( bool:local ), should be false"],
		[NaN,					assert_false,	"#10 is_infinity ( NaN:local ), should be false"],
		[infinity,				assert_true,	"#11 is_infinity ( infinity:local ), should be true"],
		[undefined,				assert_false,	"#12 is_infinity ( undefined:local ), should be false"],
		
		[[],					assert_false,	"#13 is_infinity ( array:local ), should be false"],
		[{ key: "value" },		assert_false,	"#14 is_infinity ( struct:local ), should be false"],
		[function() {},			assert_false,	"#15 is_infinity ( method:local ), should be false"],
		[get_timer,				assert_false,	"#16 is_infinity ( function:local ), should be false"],
		
		[infinity + 300,		assert_true,	"#17 is_infinity ( infinity + value ), should be true"],
		[infinity - 300,		assert_true,	"#18 is_infinity ( infinity - value ), should be true"],
		[infinity * 300,		assert_true,	"#19 is_infinity ( infinity * value ), should be true"],
		[infinity / 300,		assert_true,	"#20 is_infinity ( infinity / value ), should be true"],
		[infinity / NaN,		assert_false,	"#21 is_infinity ( value / infinity ), should be false (expect 0)"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_infinity(_input)
		_test_func(_output, _desc);
		
	})
	
	addTheory("is_int32_test", [
	
		[ptr({}),				assert_false,	"#1 is_int32 ( pointer:local ), should be false"],
		[pointer_invalid,		assert_false,	"#2 is_int32 ( pointer_invalid:local ), should be false"],
		[pointer_null,			assert_false,	"#3 is_int32 ( pointer_null:local ), should be false"],
		
		[32.33,					assert_false,	"#4 is_int32 ( real:local ), should be false"],
		[int32(22),				assert_true,	"#5 is_int32 ( int32:local ), should be true"],
		[int64(12),				assert_false,	"#6 is_int32 ( int64:local ), should be false"],
		
		[RainbowColors.Orange,	assert_false,	"#7 is_int32 ( int64:local ), should be false (enum entries are always int64)", platform_not_browser],
		
		["-21233.223",			assert_false,	"#8 is_int32 ( string:local ), numeric string should be false"],
		[true,					assert_false,	"#9 is_int32 ( bool:local ), should be false"],
		[NaN,					assert_false,	"#10 is_int32 ( NaN:local ), should be false"],
		[infinity,				assert_false,	"#11 is_int32 ( infinity:local ), should be false"],
		[undefined,				assert_false,	"#12 is_int32 ( undefined:local ), should be false"],
		
		[[],					assert_false,	"#13 is_int32 ( array:local ), should be false"],
		[{ key: "value" },		assert_false,	"#14 is_int32 ( struct:local ), should be false"],
		[function() {},			assert_false,	"#15 is_int32 ( method:local ), should be false"],
		[get_timer,				assert_false,	"#16 is_int32 ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_int32(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_int64_test", [
	
		[ptr({}),				assert_false,	"#1 is_int64 ( pointer:local ), should be false"],
		[pointer_invalid,		assert_false,	"#2 is_int64 ( pointer_invalid:local ), should be false"],
		[pointer_null,			assert_false,	"#3 is_int64 ( pointer_null:local ), should be false"],
		
		[32.33,					assert_false,	"#4 is_int64 ( real:local ), should be false"],
		[int32(22),				assert_false,	"#5 is_int64 ( int32:local ), should be false"],
		[int64(12),				assert_true,	"#6 is_int64 ( int64:local ), should be true"],
		
		[RainbowColors.Orange,	assert_true,	"#7 is_int64 ( int64:local ), should be true (enum entries are always int64)", platform_not_browser],
		
		["-21233.223",			assert_false,	"#8 is_int64 ( string:local ), numeric string should be false"],
		[true,					assert_false,	"#9 is_int64 ( bool:local ), should be false"],
		[NaN,					assert_false,	"#10 is_int64 ( NaN:local ), should be false"],
		[infinity,				assert_false,	"#11 is_int64 ( infinity:local ), should be false"],
		[undefined,				assert_false,	"#12 is_int64 ( undefined:local ), should be false"],
		
		[[],					assert_false,	"#13 is_int64 ( array:local ), should be false"],
		[{ key: "value" },		assert_false,	"#14 is_int64 ( struct:local ), should be false"],
		[function() {},			assert_false,	"#15 is_int64 ( method:local ), should be false"],
		[get_timer,				assert_false,	"#16 is_int64 ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_int64(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_method_test", [
	
		[ptr({}),			assert_false,	"#1 is_method ( pointer:local ), should be false"],
		[pointer_invalid,	assert_false,	"#2 is_method ( pointer_invalid:local ), should be false"],
		[pointer_null,		assert_false,	"#3 is_method ( pointer_null:local ), should be false"],
		
		[32.33,				assert_false,	"#4 is_method ( real:local ), should be false"],
		[int32(22),			assert_false,	"#5 is_method ( int32:local ), should be false"],
		[int64(12),			assert_false,	"#6 is_method ( int64:local ), should be false"],
		
		["-21233.223",		assert_false,	"#7 is_method ( string:local ), numeric string should be false"],
		[true,				assert_false,	"#8 is_method ( bool:local ), should be false"],
		[NaN,				assert_false,	"#9 is_method ( NaN:local ), should be false"],
		[infinity,			assert_false,	"#10 is_method ( infinity:local ), should be false"],
		[undefined,			assert_false,	"#11 is_method ( undefined:local ), should be true"],
		
		[[],				assert_false,	"#12 is_method ( array:local ), should be false"],
		[{ key: "value" },	assert_false,	"#13 is_method ( struct:local ), should be false"],
		[function() {},		assert_true,	"#14 is_method ( method:local ), should be true"],
		[get_timer,			assert_false,	"#15 is_method ( function:local ), should be false", platform_not_browser],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_method(_input)
		_test_func(_output, _desc);
		
	});

	addTheory("is_nan_test", [
	
		[ptr({}),			assert_false,	"#1 is_nan ( pointer:local ), should be false"],
		[pointer_invalid,	assert_false,	"#2 is_nan ( pointer_invalid:local ), should be false"],
		[pointer_null,		assert_false,	"#3 is_nan ( pointer_null:local ), should be false"],
		
		[32.33,				assert_false,	"#4 is_nan ( real:local ), should be false"],
		[int32(22),			assert_false,	"#5 is_nan ( int32:local ), should be false"],
		[int64(12),			assert_false,	"#6 is_nan ( int64:local ), should be false"],
		
		["-21233.223",		assert_false,	"#7 is_nan ( string:local ), numeric string should be false"],
		["",				assert_true,	"#8 is_nan ( string:local ), empty string should be true"],
		["abc",				assert_true,	"#9 is_nan ( string:local ), non-numeric string should be true"],
		
		[true,				assert_false,	"#10 is_nan ( bool:local ), should be false"],
		[NaN,				assert_true,	"#11 is_nan ( NaN:local ), should be true"],
		[infinity,			assert_false,	"#12 is_nan ( infinity:local ), should be false"],
		[undefined,			assert_true,	"#13 is_nan ( undefined:local ), should be true"],
		
		[[],				assert_true,	"#14 is_nan ( array:local ), should be true"],
		[{ key: "value" },	assert_true,	"#15 is_nan ( struct:local ), should be true"],
		[function() {},		assert_true,	"#16 is_nan ( method:local ), should be true"],
		[get_timer,			assert_false,	"#17 is_nan ( function:local ), should be false", platform_not_browser],
		
		[NaN + 300,			assert_true,	"#18 is_nan ( NaN + value ), should be true"],
		[NaN - 300,			assert_true,	"#19 is_nan ( NaN - value ), should be true"],
		[NaN * 300,			assert_true,	"#20 is_nan ( NaN * value ), should be true"],
		[NaN / 300,			assert_true,	"#21 is_nan ( NaN / value ), should be true"],
		[300 / NaN,			assert_true,	"#22 is_nan ( value / NaN ), should be true"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_nan(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_numeric_test", [
	
		[ptr({}),			assert_false,	"#1 is_numeric ( pointer:local ), should be false"],
		[pointer_invalid,	assert_false,	"#2 is_numeric ( pointer_invalid:local ), should be false"],
		[pointer_null,		assert_false,	"#3 is_numeric ( pointer_null:local ), should be false"],
		
		[32.33,				assert_true,	"#4 is_numeric ( real:local ), should be true"],
		[int32(22),			assert_true,	"#5 is_numeric ( int32:local ), should be true"],
		[int64(12),			assert_true,	"#6 is_numeric ( int64:local ), should be true"],
		
		["-21233.223",		assert_false,	"#7 is_numeric ( string:local ), numeric string should be false"],
		["",				assert_false,	"#8 is_numeric ( string:local ), empty string should be false"],
		["abc",				assert_false,	"#9 is_numeric ( string:local ), non-numeric string should be false"],
		
		[true,				assert_true,	"#10 is_numeric ( bool:local ), should be true"],
		[NaN,				assert_true,	"#11 is_numeric ( NaN:local ), should be false"],
		[infinity,			assert_true,	"#12 is_numeric ( infinity:local ), should be true"],
		[undefined,			assert_false,	"#13 is_numeric ( undefined:local ), should be false"],
		
		[[],				assert_false,	"#14 is_numeric ( array:local ), should be false"],
		[{ key: "value" },	assert_false,	"#15 is_numeric ( struct:local ), should be false"],
		[function() {},		assert_false,	"#16 is_numeric ( method:local ), should be false"],
		[get_timer,			assert_true,	"#17 is_numeric ( function:local ), should be true", platform_not_browser],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_numeric(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_ptr_test", [
	
		[ptr({}),			assert_true,	"#1 is_ptr ( pointer:local ), should be true"],
		[pointer_invalid,	assert_true,	"#2 is_ptr ( pointer_invalid:local ), should be true"],
		[pointer_null,		assert_true,	"#3 is_ptr ( pointer_null:local ), should be true"],
		
		[32.33,				assert_false,	"#4 is_ptr ( real:local ), should be false"],
		[int32(22),			assert_false,	"#5 is_ptr ( int32:local ), should be false"],
		[int64(12),			assert_false,	"#6 is_ptr ( int64:local ), should be false"],
		
		["-21233.223",		assert_false,	"#7 is_ptr ( string:local ), numeric string should be false"],
		["",				assert_false,	"#8 is_ptr ( string:local ), empty string should be false"],
		["abc",				assert_false,	"#9 is_ptr ( string:local ), non-numeric string should be false"],
		
		[true,				assert_false,	"#10 is_ptr ( bool:local ), should be false"],
		[NaN,				assert_false,	"#11 is_ptr ( NaN:local ), should be false"],
		[infinity,			assert_false,	"#12 is_ptr ( infinity:local ), should be false"],
		[undefined,			assert_false,	"#13 is_ptr ( undefined:local ), should be false"],
		
		[[],				assert_false,	"#14 is_ptr ( array:local ), should be false"],
		[{ key: "value" },	assert_false,	"#15 is_ptr ( struct:local ), should be false"],
		[function() {},		assert_false,	"#16 is_ptr ( method:local ), should be false"],
		[get_timer,			assert_false,	"#17 is_ptr ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_ptr(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_real_test", [
	
		[ptr({}),			assert_false,	"#1 is_real( pointer:local ), should be false"],
		[pointer_invalid,	assert_false,	"#2 is_real( pointer_invalid:local ), should be false"],
		[pointer_null,		assert_false,	"#3 is_real( pointer_null:local ), should be false"],

		[32.33,				assert_true,	"#4 is_real( real:local ), should be true"],
		[int32(22),			assert_false,	"#5 is_real( int32:local ), should be false", platform_not_browser],
		[int64(12),			assert_false,	"#6 is_real( int64:local ), should be false"],

		["-21233.223",		assert_false,	"#7 is_real( string:local ), numeric string should be false"],
		["",				assert_false,	"#8 is_real( string:local ), empty string should be false"],
		["abc",				assert_false,	"#9 is_real( string:local ), non-numeric string should be false"],

		[true,				assert_false,	"#10 is_real ( bool:local ), should be true"],
		[NaN,				assert_true,	"#11 is_real ( NaN:local ), should be true"],
		[infinity,			assert_true,	"#12 is_real ( infinity:local ), should be true"],
		[undefined,			assert_false,	"#13 is_real ( undefined:local ), should be false"],

		[[],				assert_false,	"#14 is_real ( array:local ), should be false"],
		[{ key: "value" },	assert_false,	"#15 is_real ( struct:local ), should be false"],
		[function() {},		assert_false,	"#16 is_real ( method:local ), should be false"],
		[get_timer,			assert_true,	"#17 is_real ( function:local ), should be true", platform_not_browser],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_real(_input)
		_test_func(_output, _desc);
		
	});


	addTheory("is_struct_test", [
	
		[ptr({}),			assert_false,	"#1 is_struct( pointer:local ), should be false"],
		[pointer_invalid,	assert_false,	"#2 is_struct( pointer_invalid:local ), should be false"],
		[pointer_null,		assert_false,	"#3 is_struct( pointer_null:local ), should be false"],

		[32.33,				assert_false,	"#4 is_struct( real:local ), should be false"],
		[int32(22),			assert_false,	"#5 is_struct( int32:local ), should be false"],
		[int64(12),			assert_false,	"#6 is_struct( int64:local ), should be false"],

		["-21233.223",		assert_false,	"#7 is_struct( string:local ), numeric string should be false"],
		["",				assert_false,	"#8 is_struct( string:local ), empty string should be false"],
		["abc",				assert_false,	"#9 is_struct( string:local ), non-numeric string should be false"],

		[true,				assert_false,	"#10 is_struct ( bool:local ), should be false"],
		[NaN,				assert_false,	"#11 is_struct ( NaN:local ), should be false"],
		[infinity,			assert_false,	"#12 is_struct ( infinity:local ), should be false"],
		[undefined,			assert_false,	"#13 is_struct ( undefined:local ), should be false"],

		[[],				assert_false,	"#14 is_struct ( array:local ), should be false"],
		[{ key: "value" },	assert_true,	"#15 is_struct ( struct:local ), should be true"],
		[function() {},		assert_true,	"#16 is_struct ( method:local ), should be true", platform_not_browser],
		[get_timer,			assert_false,	"#17 is_struct ( function:local ), should be false"],
		
	], function(_input, _test_func, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		var _output = is_struct(_input)
		_test_func(_output, _desc);
		
	});
	
	
	addTheory("typeof_test", [
	
		[ptr({}),			"ptr",			"#1 typeof( pointer:local )"],
		[pointer_invalid,	"ptr",			"#2 typeof( pointer_invalid:local )"],
		[pointer_null,		"ptr",			"#3 typeof( pointer_null:local )"],

		[32.33,				"number",		"#4 typeof( real:local )"],
		[int32(22),			"int32",		"#5 typeof( int32:local )",	platform_not_browser],
		[int64(12),			"int64",		"#6 typeof( int64:local )"],

		["-21233.223",		"string",		"#7 typeof( string:local )"],
		["",				"string",		"#8 typeof( string:local )"],
		["abc",				"string",		"#9 typeof( string:local )"],

		[true,				"bool",			"#10 typeof ( bool:local )"],
		[NaN,				"number",		"#11 typeof ( NaN:local )"],
		[infinity,			"number",		"#12 typeof ( infinity:local )"],
		[undefined,			"undefined",	"#13 typeof ( undefined:local )"],

		[[],				"array",		"#14 typeof ( array:local )"],
		[{ key: "value" },	"struct",		"#15 typeof ( struct:local )"],
		[function() {},		"method",		"#16 typeof ( method:local )"],
		[get_timer,			"number",		"#17 typeof ( function:local )", platform_not_browser],
		
	], function(_input, _expected, _desc, _condition = undefined) {
		
		if (is_callable(_condition) && !_condition()) {
			return log_info("Skipping test: {0}", _desc);
		}
		
		assert_typeof(_input, _expected, _desc);
		
	});

}