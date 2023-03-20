

function BasicDataTypesTestSuite() : TestSuite() constructor {

	// TYPE CONVERSION

	addFact("bool_test", function() {

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
		assert_true(output, "#14 bool ( struct:local ), should be true");
		assert_typeof(output, "bool", "#14.1 bool ( struct:local ), should return bool type");
			
		//#15 bool(struct) should be true
		input = function() {};
		output = bool(input);
		assert_true(output, "#15 bool ( method:local ), should be true");
		assert_typeof(output, "bool", "#15.1 bool ( method:local ), should return bool type");

		//#16 bool(array) should throw error
		assert_throw(function() {
			var input = [];
			return bool(input);
		}, "#16 bool ( array ), should throw error");
		
		//#17 bool ( string ), where string is not 'true'/'false', should throw error
		assert_throw(function() {
			var input = "string";
			return bool(input);
		}, "#17 bool ( string ), where string is not 'true'/'false', should throw error");
			
	})

	addFact("int64_test", function() {
		
		var _input, _output;
		
		var i = 0;
		
		//#1 int64 ( pointer )
		_input = ptr({});
		_output = int64(_input);
		assert_not_null(_output, "#1 int64 ( pointer:local ), should not be null");
		assert_typeof(_output, "int64", "#1.1 int64 ( pointer:local ), should be of type int64");
			
		//#2 int64 ( pointer_invalid )
		_input = pointer_invalid;
		_output = int64(_input);
		assert_equals(_output, -1, "#2 int64 ( pointer_invalid:local ), should be -1");
		assert_typeof(_output, "int64", "#2.1 int64 ( pointer_invalid:local ), should return int64 type");
			
		//#3 int64 ( pointer_null ) should be false
		_input = pointer_null;
		_output = int64(_input);
		assert_equals(_output, 0, "#3 int64 ( pointer_null:local ), should be zero (0)");
		assert_typeof(_output, "int64", "#3.1 int64 ( pointer_null:local ), should be of type int64");
			
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
		}, "#14 int64 ( array ), should throw error");

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
			
		//#11 ptr ( array ), valid convertion
		assert_not_throws(function() {
			var input = [];
			return ptr(input);
		}, "#11 ptr ( array ), should not throw an error, valid convertion");
		
		//#12 ptr ( undefined )
		assert_throw(function() {
			var input = undefined
			return ptr(input);
		}, "#12 ptr ( undefined ), should throw error");
			
	})

	// TYPE CHECKING

	addFact("is_array_test", function() {

		var input, output;

		//#1 is_array ( pointer )
		input = ptr({});
		output = is_array(input);
		assert_false(output, "#1 is_array ( pointer:local ), should be false");
			
		//#2 is_array ( pointer_invalid )
		input = pointer_invalid;
		output = is_array(input);
		assert_false(output, "#2 is_array ( pointer_invalid:local ), should be false");
			
		//#3 is_array ( pointer_null )
		input = pointer_null;
		output = is_array(input);
		assert_false(output, "#3 is_array ( pointer_null:local ), should be false");
			
		//#4 is_array ( real )
		input = 32.33;
		output = is_array(input);
		assert_false(output, "#4 is_array ( real:local ), should be false");
			
		//#5 is_array ( int32 )
		input = int32(22);
		output = is_array(input);
		assert_false(output, "#5 is_array ( int32:local ), should be false");
			
		//#6 is_array ( int64 )
		input = int64(12);
		output = is_array(input);
		assert_false(output, "#6 is_array ( int64:local ), should be false");
						
		//#7 is_array ( string )
		input = "-21233.223";
		output = is_array(input);
		assert_false(output, "#7 is_array ( string:local ), should be false");

		//#8 is_array ( bool )
		input = true;
		output = is_array(input);
		assert_false(output, "#8 is_array ( bool:local ), should be false");

		//#9 is_array ( nan )
		input = NaN;
		output = is_array(input);
		assert_false(output, "#9 is_array ( NaN:local ), should be false");
			
		//#10 is_array ( infinity )
		input = infinity;
		output = is_array(input);
		assert_false(output, "#10 is_array ( infinity:local ), should be false");
			
		//#11 is_array ( undefined )
		input = undefined;
		output = is_array(input);
		assert_false(output, "#11 is_array ( undefined:local ), should be false");

		//#12 is_array ( struct )
		input = { key: "value" };
		output = is_array(input);
		assert_false(output, "#12 is_array ( struct:local ), should be false");

		//#13 is_array ( array )
		input = [];
		output = is_array(input);
		assert_true(output, "#13 is_array ( array:local ), should be true");
			
		//#13.1 is_array ( array )
		output = is_array([]);
		assert_true(output, "#13.1 is_array ( array:literal ), should be true");
			
		//#14 is_array ( method )
		input = function() {};
		output = is_array(input);
		assert_false(output, "#14 is_array ( method:local ), should be false");
			
		//#15 is_array ( function )
		input = get_timer;
		output = is_array(input);
		assert_false(output, "#15 is_array ( function:local ), should be false");

	})

	addFact("is_bool_test", function() {

		var input, output;

		//#1 is_bool ( pointer )
		input = ptr({});
		output = is_bool(input);
		assert_false(output, "#1 is_bool ( pointer:local ), should be false");
			
		//#2 is_bool ( pointer_invalid )
		input = pointer_invalid;
		output = is_bool(input);
		assert_false(output, "#2 is_bool ( pointer_invalid:local ), should be false");
			
		//#3 is_bool ( pointer_null )
		input = pointer_null;
		output = is_bool(input);
		assert_false(output, "#3 is_bool ( pointer_null:local ), should be false");
			
		//#4 is_bool ( real )
		input = 32.33;
		output = is_bool(input);
		assert_false(output, "#4 is_bool ( real:local ), should be false");
			
		//#5 is_bool ( int32 )
		input = int32(22);
		output = is_bool(input);
		assert_false(output, "#5 is_bool ( int32:local ), should be false");
			
		//#6 is_bool ( int64 )
		input = int64(12);
		output = is_bool(input);
		assert_false(output, "#6 is_bool ( int64:local ), should be false");
						
		//#7 is_bool ( string )
		input = "-21233.223";
		output = is_bool(input);
		assert_false(output, "#7 is_bool ( string:local ), should be false");

		//#8 is_bool ( bool )
		input = true;
		output = is_bool(input);
		assert_true(output, "#8 is_bool ( bool:local ), should be true");
			
		//#8.1 is_bool ( bool )
		output = is_bool(true);
		assert_true(output, "#8.1 is_bool ( bool:literal ), should be true");

		//#9 is_bool ( nan )
		input = NaN;
		output = is_bool(input);
		assert_false(output, "#9 is_bool ( NaN:local ), should be false");
			
		//#10 is_bool ( infinity )
		input = infinity;
		output = is_bool(input);
		assert_false(output, "#10 is_bool ( infinity:local ), should be false");
			
		//#11 is_bool ( undefined )
		input = undefined;
		output = is_bool(input);
		assert_false(output, "#11 is_bool ( undefined:local ), should be false");

		//#12 is_bool ( struct )
		input = { key: "value" };
		output = is_bool(input);
		assert_false(output, "#12 is_bool ( struct:local ), should be false");

		//#13 is_bool ( array )
		input = [];
		output = is_bool(input);
		assert_false(output, "#13 is_bool ( array:local ), should be false");
			
		//#14 is_bool ( method )
		input = function() {};
		output = is_bool(input);
		assert_false(output, "#14 is_bool ( method:local ), should be false");
			
		//#15 is_bool ( function )
		input = get_timer;
		output = is_bool(input);
		assert_false(output, "#15 is_bool ( function:local ), should be false");
			

	})

	addFact("is_infinity_test", function() {

		var input, output;

		//#1 is_infinity ( pointer )
		input = ptr({});
		output = is_infinity(input);
		assert_false(output, "#1 is_infinity ( pointer:local ), should be false");
			
		//#2 is_infinity ( pointer_invalid )
		input = pointer_invalid;
		output = is_infinity(input);
		assert_false(output, "#2 is_infinity ( pointer_invalid:local ), should be false");
			
		//#3 is_infinity ( pointer_null )
		input = pointer_null;
		output = is_infinity(input);
		assert_false(output, "#3 is_infinity ( pointer_null:local ), should be false");
			
		//#4 is_infinity ( real )
		input = 32.33;
		output = is_infinity(input);
		assert_false(output, "#4 is_infinity ( real:local ), should be false");
			
		//#5 is_infinity ( int32 )
		input = int32(22);
		output = is_infinity(input);
		assert_false(output, "#5 is_infinity ( int32:local ), should be false");
			
		//#6 is_infinity ( int64 )
		input = int64(12);
		output = is_infinity(input);
		assert_false(output, "#6 is_infinity ( int64:local ), should be false");
						
		//#7 is_infinity ( string )
		input = "-21233.223";
		output = is_infinity(input);
		assert_false(output, "#7 is_infinity ( string:local ), should be false");

		//#8 is_infinity ( bool )
		input = true;
		output = is_infinity(input);
		assert_false(output, "#8 is_infinity ( bool:local ), should be false");

		//#9 is_infinity ( nan )
		input = NaN;
		output = is_infinity(input);
		assert_false(output, "#9 is_infinity ( NaN:local ), should be false");
			
		//#10 is_infinity ( infinity )
		input = infinity;
		output = is_infinity(input);
		assert_true(output, "#10 is_infinity ( infinity:local ), should be true");
			
		//#11 is_infinity ( undefined )
		input = undefined;
		output = is_infinity(input);
		assert_false(output, "#11 is_infinity ( undefined:local ), should be false");
			
		//#12 is_infinity ( struct )
		input = { key: "value" };
		output = is_infinity(input);
		assert_false(output, "#12 is_infinity ( struct:local ), should be false");

		//#13 is_infinity ( array )
		input = [];
		output = is_infinity(input);
		assert_false(output, "#13 is_infinity ( array:local ), should be false");

		//#14 is_infinity ( method )
		input = function() {};
		output = is_infinity(input);
		assert_false(output, "#14 is_infinity ( method:local ), should be false");
			
		//#15 is_infinity ( function )
		input = get_timer;
		output = is_infinity(input);
		assert_false(output, "#15 is_infinity ( function:local ), should be false");
			
	})

	addFact("is_int32_test", function() {

		var input, output;

		//#1 is_int32 ( pointer )
		input = ptr({});
		output = is_int32(input);
		assert_false(output, "#1 is_int32 ( pointer:local ), should be false");
			
		//#2 is_int32 ( pointer_invalid )
		input = pointer_invalid;
		output = is_int32(input);
		assert_false(output, "#2 is_int32 ( pointer_invalid:local ), should be false");
			
		//#3 is_int32 ( pointer_null )
		input = pointer_null;
		output = is_int32(input);
		assert_false(output, "#3 is_int32 ( pointer_null:local ), should be false");
			
		//#4 is_int32 ( real )
		input = 32.33;
		output = is_int32(input);
		assert_false(output, "#4 is_int32 ( real:local ), should be false");
			
		//#5 is_int32 ( int32 )
		input = int32(22);
		output = is_int32(input);
		assert_true(output, "#5 is_int32 ( int32:local ), should be true");
			
		//#6 is_int32 ( int64 )
		input = int64(12);
		output = is_int32(input);
		assert_false(output, "#6 is_int32 ( int64:local ), should be false");
						
		//#7 is_int32 ( string )
		input = "-21233.223";
		output = is_int32(input);
		assert_false(output, "#7 is_int32 ( string:local ), should be false");

		//#8 is_int32 ( bool )
		input = true;
		output = is_int32(input);
		assert_false(output, "#8 is_int32 ( bool:local ), should be false");

		//#9 is_int32 ( nan )
		input = NaN;
		output = is_int32(input);
		assert_false(output, "#9 is_int32 ( NaN:local ), should be false");
			
		//#10 is_int32 ( infinity )
		input = infinity;
		output = is_int32(input);
		assert_false(output, "#10 is_int32 ( infinity:local ), should be false");
			
		//#11 is_int32 ( undefined )
		input = undefined;
		output = is_int32(input);
		assert_false(output, "#11 is_int32 ( undefined:local ), should be false");

		//#12 is_int32 ( struct )
		input = { key: "value" };
		output = is_int32(input);
		assert_false(output, "#12 is_int32 ( struct:local ), should be false");

		//#13 is_int32 ( array )
		input = [];
		output = is_int32(input);
		assert_false(output, "#13 is_int32 ( array:local ), should be false");
			
		//#14 is_int32 ( method )
		input = function() {};
		output = is_int32(input);
		assert_false(output, "#14 is_int32 ( method:local ), should be false");
			
		//#15 is_int32 ( function )
		input = get_timer;
		output = is_int32(input);
		assert_false(output, "#15 is_int32 ( function:local ), should be false");
			
	})

	addFact("is_int64_test", function() {

		var input, output;

		//#1 is_int64 ( pointer )
		input = ptr({});
		output = is_int64(input);
		assert_false(output, "#1 is_int64 ( pointer:local ), should be false");
			
		//#2 is_int64 ( pointer_invalid )
		input = pointer_invalid;
		output = is_int64(input);
		assert_false(output, "#2 is_int64 ( pointer_invalid:local ), should be false");
			
		//#3 is_int64 ( pointer_null )
		input = pointer_null;
		output = is_int64(input);
		assert_false(output, "#3 is_int64 ( pointer_null:local ), should be false");
			
		//#4 is_int64 ( real )
		input = 32.33;
		output = is_int64(input);
		assert_false(output, "#4 is_int64 ( real:local ), should be false");
			
		//#5 is_int64 ( int32 )
		input = int32(22);
		output = is_int64(input);
		assert_false(output, "#5 is_int64 ( int32:local ), should be false");
			
		//#6 is_int64 ( int64 )
		input = int64(12);
		output = is_int64(input);
		assert_true(output, "#6 is_int64 ( int64:local ), should be true");
						
		//#7 is_int64 ( string )
		input = "-21233.223";
		output = is_int64(input);
		assert_false(output, "#7 is_int64 ( string:local ), should be false");

		//#8 is_int64 ( bool )
		input = true;
		output = is_int64(input);
		assert_false(output, "#8 is_int64 ( bool:local ), should be false");

		//#9 is_int64 ( nan )
		input = NaN;
		output = is_int64(input);
		assert_false(output, "#9 is_int64 ( NaN:local ), should be false");
			
		//#10 is_int64 ( infinity )
		input = infinity;
		output = is_int64(input);
		assert_false(output, "#10 is_int64 ( infinity:local ), should be false");
			
		//#11 is_int64 ( undefined )
		input = undefined;
		output = is_int64(input);
		assert_false(output, "#11 is_int64 ( undefined:local ), should be false");

		//#12 is_int64 ( struct )
		input = { key: "value" };
		output = is_int64(input);
		assert_false(output, "#12 is_int64 ( struct:local ), should be false");

		//#13 is_int64 ( array )
		input = [];
		output = is_int64(input);
		assert_false(output, "#13 is_int64 ( array:local ), should be false");
			
		//#14 is_int64 ( enum )
		input = RainbowColors.Orange;
		output = is_int64(input);
		assert_true(output, "#14 is_int64 ( enum ), should be true (enum entries are always int64)");
			
		//#15 is_int64 ( method )
		input = function() {};
		output = is_int64(input);
		assert_false(output, "#15 is_int64 ( method:local ), should be false");
			
		//#16 is_int64 ( function )
		input = get_timer;
		output = is_int64(input);
		assert_false(output, "#16 is_int64 ( function:local ), should be false");
			
	})

	addFact("is_method_test", function() {

		var input, output;

		//#1 is_method ( pointer )
		input = ptr({});
		output = is_method(input);
		assert_false(output, "#1 is_method ( pointer:local ), should be false");
			
		//#2 is_method ( pointer_invalid )
		input = pointer_invalid;
		output = is_method(input);
		assert_false(output, "#2 is_method ( pointer_invalid:local ), should be false");
			
		//#3 is_method ( pointer_null )
		input = pointer_null;
		output = is_method(input);
		assert_false(output, "#3 is_method ( pointer_null:local ), should be false");
			
		//#4 is_method ( real )
		input = 32.33;
		output = is_method(input);
		assert_false(output, "#4 is_method ( real:local ), should be false");
			
		//#5 is_method ( int32 )
		input = int32(22);
		output = is_method(input);
		assert_false(output, "#5 is_method ( int32:local ), should be false");
			
		//#6 is_method ( int64 )
		input = int64(12);
		output = is_method(input);
		assert_false(output, "#6 is_method ( int64:local ), should be false");
						
		//#7 is_method ( string )
		input = "-21233.223";
		output = is_method(input);
		assert_false(output, "#7 is_method ( string:local ), should be false");

		//#8 is_method ( bool )
		input = true;
		output = is_method(input);
		assert_false(output, "#8 is_method ( bool:local ), should be false");

		//#9 is_method ( nan )
		input = NaN;
		output = is_method(input);
		assert_false(output, "#9 is_method ( NaN:local ), should be false");
			
		//#10 is_method ( infinity )
		input = infinity;
		output = is_method(input);
		assert_false(output, "#10 is_method ( infinity:local ), should be false");
			
		//#11 is_method ( undefined )
		input = undefined;
		output = is_method(input);
		assert_false(output, "#11 is_method ( undefined:local ), should be false");

		//#12 is_method ( struct )
		input = { key: "value" };
		output = is_method(input);
		assert_false(output, "#12 is_method ( struct:local ), should be false");

		//#13 is_method ( array )
		input = [];
		output = is_method(input);
		assert_false(output, "#13 is_method ( array:local ), should be false");

		//#14 is_method ( method )
		input = function() {};
		output = is_method(input);
		assert_true(output, "#14 is_method ( method:local ), should be true");
			
		//#15 is_method ( function )
		input = get_timer;
		output = is_method(input);
		assert_false(output, "#15 is_method ( function:local ), should be false");

	})

	addFact("is_nan_test", function() {

		var input, output;

		//#1 is_nan ( pointer )
		input = ptr({});
		output = is_nan(input);
		assert_false(output, "#1 is_nan ( pointer:local ), should be false");
			
		//#2 is_nan ( pointer_invalid )
		input = pointer_invalid;
		output = is_nan(input);
		assert_false(output, "#2 is_nan ( pointer_invalid:local ), should be false");
			
		//#3 is_nan ( pointer_null )
		input = pointer_null;
		output = is_nan(input);
		assert_false(output, "#3 is_nan ( pointer_null:local ), should be false");
			
		//#4 is_nan ( real )
		input = 32.33;
		output = is_nan(input);
		assert_false(output, "#4 is_nan ( real:local ), should be false");
			
		//#5 is_nan ( int32 )
		input = int32(22);
		output = is_nan(input);
		assert_false(output, "#5 is_nan ( int32:local ), should be false");
			
		//#6 is_nan ( int64 )
		input = int64(12);
		output = is_nan(input);
		assert_false(output, "#6 is_nan ( int64:local ), should be false");
						
		//#7 is_nan ( string )
		input = "-21233.223";
		output = is_nan(input);
		assert_false(output, "#7 is_nan ( string:local ), should be false");

		//#8 is_nan ( bool )
		input = true;
		output = is_nan(input);
		assert_false(output, "#8 is_nan ( bool:local ), should be false");

		//#9 is_nan ( nan )
		input = NaN;
		output = is_nan(input);
		assert_true(output, "#9 is_nan ( NaN:local ), should be true");
			
		//#10 is_nan ( infinity )
		input = infinity;
		output = is_nan(input);
		assert_false(output, "#10 is_nan ( infinity:local ), should be false");
			
		//#11 is_nan ( undefined )
		input = undefined;
		output = is_nan(input);
		assert_false(output, "#11 is_nan ( undefined:local ), should be false");

		//#12 is_nan ( struct )
		input = { key: "value" };
		output = is_nan(input);
		assert_true(output, "#12 is_nan ( struct:local ), should be true (no valueOf is defined)");

		//#13 is_nan ( array )
		input = [];
		output = is_nan(input);
		assert_false(output, "#13 is_nan ( array:local ), should be false");

		//#14 is_nan ( method )
		input = function() {};
		output = is_nan(input);
		assert_true(output, "#14 is_nan ( method:local ), should be true (no valueOf is defined)");
			
		//#15 is_nan ( function )
		input = get_timer;
		output = is_nan(input);
		assert_false(output, "#15 is_nan ( function:local ), should be false");
		
		//#16 is_nan ( function )
		input = { key: "value", valueOf: function() { return 100; } };
		output = is_nan(input);
		assert_false(output, "#16 is_nan ( function:local ), should be false (valueOf is defined)");

	})

	addFact("is_numeric_test", function() {

		var input, output;

		//#1 is_numeric ( pointer )
		input = ptr({});
		output = is_numeric(input);
		assert_false(output, "#1 is_numeric ( pointer:local ), should be false");
			
		//#2 is_numeric ( pointer_invalid )
		input = pointer_invalid;
		output = is_numeric(input);
		assert_false(output, "#2 is_numeric ( pointer_invalid:local ), should be false");
			
		//#3 is_numeric ( pointer_null )
		input = pointer_null;
		output = is_numeric(input);
		assert_false(output, "#3 is_numeric ( pointer_null:local ), should be false");
			
		//#4 is_numeric ( real )
		input = 32.33;
		output = is_numeric(input);
		assert_true(output, "#4 is_numeric ( real:local ), should be true");
			
		//#5 is_numeric ( int32 )
		input = int32(22);
		output = is_numeric(input);
		assert_true(output, "#5 is_numeric ( int32:local ), should be true");
			
		//#6 is_numeric ( int64 )
		input = int64(12);
		output = is_numeric(input);
		assert_true(output, "#6 is_numeric ( int64:local ), should be true");
						
		//#7 is_numeric ( string )
		input = "-21233.223";
		output = is_numeric(input);
		assert_false(output, "#7 is_numeric ( string:local ), should be false");

		//#8 is_numeric ( bool )
		input = true;
		output = is_numeric(input);
		assert_true(output, "#8 is_numeric ( bool:local ), should be true");

		//#9 is_numeric ( nan )
		input = NaN;
		output = is_numeric(input);
		assert_true(output, "#9 is_numeric ( NaN:local ), should be true");
			
		//#10 is_numeric ( infinity )
		input = infinity;
		output = is_numeric(input);
		assert_true(output, "#10 is_numeric ( infinity:local ), should be true");
			
		//#11 is_numeric ( undefined )
		input = undefined;
		output = is_numeric(input);
		assert_false(output, "#11 is_numeric ( undefined:local ), should be false");

		//#12 is_numeric ( struct )
		input = { key: "value" };
		output = is_numeric(input);
		assert_false(output, "#12 is_numeric ( struct:local ), should be false");

		//#13 is_numeric ( array )
		input = [];
		output = is_numeric(input);
		assert_false(output, "#13 is_numeric ( array:local ), should be false");
			
		//#14 is_numeric ( method )
		input = function() {};
		output = is_numeric(input);
		assert_false(output, "#14 is_numeric ( method:local ), should be false");
			
		//#15 is_numeric ( function )
		input = get_timer;
		output = is_numeric(input);
		assert_true(output, "#15 is_numeric ( function:local ), should be true");
			
	})

	addFact("is_ptr_test", function() {

		var input, output;

		//#1 is_ptr ( pointer )
		input = ptr({});
		output = is_ptr(input);
		assert_true(output, "#1 is_ptr ( pointer:local ), should be true");
			
		//#2 is_ptr ( pointer_invalid )
		input = pointer_invalid;
		output = is_ptr(input);
		assert_true(output, "#2 is_ptr ( pointer_invalid:local ), should be true");
			
		//#3 is_ptr ( pointer_null )
		input = pointer_null;
		output = is_ptr(input);
		assert_true(output, "#3 is_ptr ( pointer_null:local ), should be true");
			
		//#4 is_ptr ( real )
		input = 32.33;
		output = is_ptr(input);
		assert_false(output, "#4 is_ptr ( real:local ), should be false");
			
		//#5 is_ptr ( int32 )
		input = int32(22);
		output = is_ptr(input);
		assert_false(output, "#5 is_ptr ( int32:local ), should be false");
			
		//#6 is_ptr ( int64 )
		input = int64(12);
		output = is_ptr(input);
		assert_false(output, "#6 is_ptr ( int64:local ), should be false");
						
		//#7 is_ptr ( string )
		input = "-21233.223";
		output = is_ptr(input);
		assert_false(output, "#7 is_ptr ( string:local ), should be false");

		//#8 is_ptr ( bool )
		input = true;
		output = is_ptr(input);
		assert_false(output, "#8 is_ptr ( bool:local ), should be false");

		//#9 is_ptr ( nan )
		input = NaN;
		output = is_ptr(input);
		assert_false(output, "#9 is_ptr ( NaN:local ), should be false");
			
		//#10 is_ptr ( infinity )
		input = infinity;
		output = is_ptr(input);
		assert_false(output, "#10 is_ptr ( infinity:local ), should be false");
			
		//#11 is_ptr ( undefined )
		input = undefined;
		output = is_ptr(input);
		assert_false(output, "#11 is_ptr ( undefined:local ), should be false");

		//#12 is_ptr ( struct )
		input = { key: "value" };
		output = is_ptr(input);
		assert_false(output, "#12 is_ptr ( struct:local ), should be false");

		//#13 is_ptr ( array )
		input = [];
		output = is_ptr(input);
		assert_false(output, "#13 is_ptr ( array:local ), should be false");
			
		//#14 is_ptr ( method )
		input = function() {};
		output = is_ptr(input);
		assert_false(output, "#14 is_ptr ( method:local ), should be false");
			
		//#15 is_ptr ( function )
		input = get_timer;
		output = is_ptr(input);
		assert_false(output, "#15 is_ptr ( function:local ), should be false");
			
	})

	addFact("is_real_test", function() {

		var input, output;

		//#1 is_real ( pointer )
		input = ptr({});
		output = is_real(input);
		assert_false(output, "#1 is_real ( pointer:local ), should be false");
			
		//#2 is_real ( pointer_invalid )
		input = pointer_invalid;
		output = is_real(input);
		assert_false(output, "#2 is_real ( pointer_invalid:local ), should be false");
			
		//#3 is_real ( pointer_null )
		input = pointer_null;
		output = is_real(input);
		assert_false(output, "#3 is_real ( pointer_null:local ), should be false");
			
		//#4 is_real ( real )
		input = 32.33;
		output = is_real(input);
		assert_true(output, "#4 is_real ( real:local ), should be true");
						
		//#4.1 is_real ( real )
		output = is_real(3232);
		assert_true(output, "#4.1 is_real ( real:literal ), should be true");
			
		//#5 is_real ( int32 )
		input = int32(22);
		output = is_real(input);
		assert_false(output, "#5 is_real ( int32:local ), should be false");
			
		//#6 is_real ( int64 )
		input = int64(12);
		output = is_real(input);
		assert_false(output, "#6 is_real ( int64:local ), should be false");
						
		//#7 is_real ( string )
		input = "-21233.223";
		output = is_real(input);
		assert_false(output, "#7 is_real ( string:local ), should be false");

		//#8 is_real ( bool )
		input = true;
		output = is_real(input);
		assert_false(output, "#8 is_real ( bool:local ), should be false");

		//#9 is_real ( nan )
		input = NaN;
		output = is_real(input);
		assert_true(output, "#9 is_real ( NaN:local ), should be true");
			
		//#10 is_real ( infinity )
		input = infinity;
		output = is_real(input);
		assert_true(output, "#10 is_real ( infinity:local ), should be true");
			
		//#11 is_real ( undefined )
		input = undefined;
		output = is_real(input);
		assert_false(output, "#11 is_real ( undefined:local ), should be false");

		//#12 is_real ( struct )
		input = { key: "value" };
		output = is_real(input);
		assert_false(output, "#12 is_real ( struct:local ), should be false");

		//#13 is_real ( array )
		input = [];
		output = is_real(input);
		assert_false(output, "#13 is_real ( array:local ), should be false");
			
		//#14 is_real ( method )
		input = function() {};
		output = is_real(input);
		assert_false(output, "#14 is_real ( method:local ), should be false");
			
		//#15 is_real ( function )
		input = get_timer;
		output = is_real(input);
		assert_true(output, "#15 is_real ( function:local ), should be true");
			
	})

	addFact("is_struct_test", function() {

		var input, output;

		//#1 is_struct ( pointer )
		input = ptr({});
		output = is_struct(input);
		assert_false(output, "#1 is_struct ( pointer:local ), should be false");
			
		//#2 is_struct ( pointer_invalid )
		input = pointer_invalid;
		output = is_struct(input);
		assert_false(output, "#2 is_struct ( pointer_invalid:local ), should be false");
			
		//#3 is_struct ( pointer_null )
		input = pointer_null;
		output = is_struct(input);
		assert_false(output, "#3 is_struct ( pointer_null:local ), should be false");
			
		//#4 is_struct ( real )
		input = 32.33;
		output = is_struct(input);
		assert_false(output, "#4 is_struct ( real:local ), should be false");
			
		//#5 is_struct ( int32 )
		input = int32(22);
		output = is_struct(input);
		assert_false(output, "#5 is_struct ( int32:local ), should be false");
			
		//#6 is_struct ( int64 )
		input = int64(12);
		output = is_struct(input);
		assert_false(output, "#6 is_struct ( int64:local ), should be false");
						
		//#7 is_struct ( string )
		input = "-21233.223";
		output = is_struct(input);
		assert_false(output, "#7 is_struct ( string:local ), should be false");

		//#8 is_struct ( bool )
		input = true;
		output = is_struct(input);
		assert_false(output, "#8 is_struct ( bool:local ), should be false");

		//#9 is_struct ( nan )
		input = NaN;
		output = is_struct(input);
		assert_false(output, "#9 is_struct ( NaN:local ), should be false");
			
		//#10 is_struct ( infinity )
		input = infinity;
		output = is_struct(input);
		assert_false(output, "#10 is_struct ( infinity:local ), should be false");
			
		//#11 is_struct ( undefined )
		input = undefined;
		output = is_struct(input);
		assert_false(output, "#11 is_struct ( undefined:local ), should be false");

		//#12 is_struct ( struct )
		input = { key: "value" };
		output = is_struct(input);
		assert_true(output, "#12 is_struct ( struct:local ), should be true");

		//#13 is_struct ( array )
		input = [];
		output = is_struct(input);
		assert_false(output, "#13 is_struct ( array:local ), should be false");

		//#14 is_struct ( method )
		input = function() {};
		output = is_struct(input);
		assert_true(output, "#14 is_struct ( method:local ), should be true");
			
		//#15 is_struct ( function )
		input = get_timer;
		output = is_struct(input);
		assert_false(output, "#15 is_struct ( function:local ), should be false");
			
	})
	
	addFact("typeof_test", function() {

		var value;

		//#1 typeof ( pointer )
		value = ptr({});
		assert_typeof(value, "ptr", "#1 typeof ( pointer:local ), value is not of the correct type");
			
		//#2 typeof ( pointer_invalid )
		value = pointer_invalid;
		assert_typeof(value, "ptr", "#2 typeof ( pointer_invalid:local ), value is not of the correct type");
			
		//#3 typeof ( pointer_null )
		value = pointer_null;
		assert_typeof(value, "ptr", "#3 typeof ( pointer_null:local ), value is not of the correct type");
			
		//#4 typeof ( real )
		value = 32.33;
		assert_typeof(value, "number", "#4 typeof ( real:local ), value is not of the correct type");
			
		//#5 typeof ( int32 )
		value = int32(22);
		assert_typeof(value, "int32", "#5 typeof ( int32:local ), value is not of the correct type");
			
		//#6 typeof ( int64 )
		value = int64(12);
		assert_typeof(value, "int64", "#6 typeof ( int64:local ), value is not of the correct type");
						
		//#7 typeof ( string )
		value = "-21233.223";
		assert_typeof(value, "string", "#7 typeof ( string:local ), value is not of the correct type");

		//#8 typeof ( bool )
		value = true;
		assert_typeof(value, "bool", "#8 typeof ( bool:local ), value is not of the correct type");

		//#9 typeof ( nan )
		value = NaN;
		assert_typeof(value, "number", "#9 typeof ( NaN:local ), value is not of the correct type");
			
		//#10 typeof ( infinity )
		value = infinity;
		assert_typeof(value, "number", "#10 typeof ( infinity:local ), value is not of the correct type");
			
		//#11 typeof ( undefined )
		value = undefined;
		assert_typeof(value, "undefined", "#11 typeof ( undefined:local ), value is not of the correct type");

		//#12 typeof ( struct )
		value = { key: "value" };
		assert_typeof(value, "struct", "#12 typeof ( struct:local ), value is not of the correct type");

		//#13 typeof ( array )
		value = [];
		assert_typeof(value, "array", "#13 typeof ( array:local ), value is not of the correct type");
			
		//#14 typeof ( method )
		value = function() {}
		assert_typeof(value, "method", "#14 typeof ( method:local ), value is not of the correct type");
			
		//#14 typeof ( function )
		value = get_timer;
		assert_typeof(value, "number", "#14 typeof ( function:local ), value is not of the correct type");
			
	})
}