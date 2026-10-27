// Compile time constant folding must give exactly the type and value the runtime gives for the same operands (GameMaker-Bugs#16191)
// Each check computes an expression on literals (which the compiler folds) and on the same values passed through
// constant_folding_rt() (which the runtime computes) and compares the type and the exact value (the bits of a real, the bytes of a string).

/// @ignore
function constant_folding_rt(_value) {
	return _value;
}

/// @ignore
function constant_folding_describe(_value) {
	var _type = typeof(_value);
	switch (_type) {
	case "number":
		var _buffer = buffer_create(8, buffer_fixed, 1);
		buffer_write(_buffer, buffer_f64, _value);
		var _low = buffer_peek(_buffer, 0, buffer_u32);
		var _high = buffer_peek(_buffer, 4, buffer_u32);
		buffer_delete(_buffer);
		return $"number {string_format(_value, 0, 17)} [{_high}:{_low}]";
	case "string":
		var _bytes = "string [";
		for (var _i = 1; _i <= string_byte_length(_value); ++_i) _bytes += string(string_byte_at(_value, _i)) + " ";
		return _bytes + "]";
	case "bool":
		return "bool " + string(_value ? 1 : 0) + " arithmetic " + string(_value + 0);
	default:
		return _type + " " + string(_value);
	}
}

/// @ignore
function constant_folding_check(_name, _folded, _runtime) {
	var _folded_desc, _runtime_desc;
	try { _folded_desc = constant_folding_describe(_folded()); } catch (_e) { _folded_desc = "throws"; }
	try { _runtime_desc = constant_folding_describe(_runtime()); } catch (_e) { _runtime_desc = "throws"; }
	assert_equals(_folded_desc, _runtime_desc, _name + " folded at compile time should give the same type and value as at runtime");
}

function BasicConstantFoldingTestSuite() : TestSuite() constructor {

	addFact("constant_folding_test #1", function() {
		
		// Check that logical operators give a bool
		constant_folding_check("!0", function() { return !0; }, function() { return !constant_folding_rt(0); });
		constant_folding_check("!1.5", function() { return !1.5; }, function() { return !constant_folding_rt(1.5); });
		constant_folding_check("!true", function() { return !true; }, function() { return !constant_folding_rt(true); });
		constant_folding_check("!int64(0)", function() { return !int64(0); }, function() { return !int64(constant_folding_rt(0)); });
		constant_folding_check("true && false", function() { return true && false; }, function() { return constant_folding_rt(true) && constant_folding_rt(false); });
		constant_folding_check("1 && 2", function() { return 1 && 2; }, function() { return constant_folding_rt(1) && constant_folding_rt(2); });
		constant_folding_check("int64(3) && 1", function() { return int64(3) && 1; }, function() { return int64(constant_folding_rt(3)) && constant_folding_rt(1); });
		constant_folding_check("1 || 0", function() { return 1 || 0; }, function() { return constant_folding_rt(1) || constant_folding_rt(0); });
		constant_folding_check("0 || 0", function() { return 0 || 0; }, function() { return constant_folding_rt(0) || constant_folding_rt(0); });
		constant_folding_check("1.5 ^^ 167", function() { return 1.5 ^^ 167; }, function() { return constant_folding_rt(1.5) ^^ constant_folding_rt(167); });
		constant_folding_check("1 ^^ 0", function() { return 1 ^^ 0; }, function() { return constant_folding_rt(1) ^^ constant_folding_rt(0); });
	});

	addFact("constant_folding_test #2", function() {
		
		// Check that comparisons give a bool and handle NaN and mixed types
		constant_folding_check("1 < 2", function() { return 1 < 2; }, function() { return constant_folding_rt(1) < constant_folding_rt(2); });
		constant_folding_check("2 <= 2", function() { return 2 <= 2; }, function() { return constant_folding_rt(2) <= constant_folding_rt(2); });
		constant_folding_check("167 != NaN", function() { return 167 != NaN; }, function() { return constant_folding_rt(167) != constant_folding_rt(NaN); });
		constant_folding_check("167 == NaN", function() { return 167 == NaN; }, function() { return constant_folding_rt(167) == constant_folding_rt(NaN); });
		constant_folding_check("NaN < 1", function() { return NaN < 1; }, function() { return constant_folding_rt(NaN) < constant_folding_rt(1); });
		constant_folding_check("NaN == NaN", function() { return NaN == NaN; }, function() { return constant_folding_rt(NaN) == constant_folding_rt(NaN); });
		constant_folding_check("true == \"12\"", function() { return true == "12"; }, function() { return constant_folding_rt(true) == constant_folding_rt("12"); });
		constant_folding_check("12 == \"12\"", function() { return 12 == "12"; }, function() { return constant_folding_rt(12) == constant_folding_rt("12"); });
		constant_folding_check("\"a\" == \"a\"", function() { return "a" == "a"; }, function() { return constant_folding_rt("a") == constant_folding_rt("a"); });
		constant_folding_check("\"a\" < \"b\"", function() { return "a" < "b"; }, function() { return constant_folding_rt("a") < constant_folding_rt("b"); });
	});

	addFact("constant_folding_test #3", function() {
		
		// Check that bitwise operators give an int64
		constant_folding_check("5 & 3", function() { return 5 & 3; }, function() { return constant_folding_rt(5) & constant_folding_rt(3); });
		constant_folding_check("5 | 3", function() { return 5 | 3; }, function() { return constant_folding_rt(5) | constant_folding_rt(3); });
		constant_folding_check("5 ^ 3", function() { return 5 ^ 3; }, function() { return constant_folding_rt(5) ^ constant_folding_rt(3); });
		constant_folding_check("~5", function() { return ~5; }, function() { return ~constant_folding_rt(5); });
		constant_folding_check("~true", function() { return ~true; }, function() { return ~constant_folding_rt(true); });
		constant_folding_check("5.7 & 3", function() { return 5.7 & 3; }, function() { return constant_folding_rt(5.7) & constant_folding_rt(3); });
		constant_folding_check("int64(5) & 3", function() { return int64(5) & 3; }, function() { return int64(constant_folding_rt(5)) & constant_folding_rt(3); });
		constant_folding_check("int64(5) | 1.5", function() { return int64(5) | 1.5; }, function() { return int64(constant_folding_rt(5)) | constant_folding_rt(1.5); });
	});

	addFact("constant_folding_test #4", function() {
		
		// Check that shifts take the count modulo 64 and give an int64
		constant_folding_check("1 << 3", function() { return 1 << 3; }, function() { return constant_folding_rt(1) << constant_folding_rt(3); });
		constant_folding_check("11 << 64", function() { return 11 << 64; }, function() { return constant_folding_rt(11) << constant_folding_rt(64); });
		constant_folding_check("11 >> 64", function() { return 11 >> 64; }, function() { return constant_folding_rt(11) >> constant_folding_rt(64); });
		constant_folding_check("1 << 65", function() { return 1 << 65; }, function() { return constant_folding_rt(1) << constant_folding_rt(65); });
		constant_folding_check("256 >> 66", function() { return 256 >> 66; }, function() { return constant_folding_rt(256) >> constant_folding_rt(66); });
		constant_folding_check("int64(1) << 70", function() { return int64(1) << 70; }, function() { return int64(constant_folding_rt(1)) << constant_folding_rt(70); });
		constant_folding_check("-8 >> 1", function() { return -8 >> 1; }, function() { return -constant_folding_rt(8) >> constant_folding_rt(1); });
		constant_folding_check("1 << -1", function() { return 1 << -1; }, function() { return constant_folding_rt(1) << -constant_folding_rt(1); });
		constant_folding_check("2.9 << 1", function() { return 2.9 << 1; }, function() { return constant_folding_rt(2.9) << constant_folding_rt(1); });
	});

	addFact("constant_folding_test #5", function() {
		
		// Check that arithmetic keeps the type and the sign of zero
		constant_folding_check("1 + 2", function() { return 1 + 2; }, function() { return constant_folding_rt(1) + constant_folding_rt(2); });
		constant_folding_check("5 - 7", function() { return 5 - 7; }, function() { return constant_folding_rt(5) - constant_folding_rt(7); });
		constant_folding_check("3 * 4", function() { return 3 * 4; }, function() { return constant_folding_rt(3) * constant_folding_rt(4); });
		constant_folding_check("7 / 2", function() { return 7 / 2; }, function() { return constant_folding_rt(7) / constant_folding_rt(2); });
		constant_folding_check("1 / 3", function() { return 1 / 3; }, function() { return constant_folding_rt(1) / constant_folding_rt(3); });
		constant_folding_check("0.1 + 0.2", function() { return 0.1 + 0.2; }, function() { return constant_folding_rt(0.1) + constant_folding_rt(0.2); });
		constant_folding_check("0 / -3", function() { return 0 / -3; }, function() { return constant_folding_rt(0) / -constant_folding_rt(3); });
		constant_folding_check("0 * -1", function() { return 0 * -1; }, function() { return constant_folding_rt(0) * -constant_folding_rt(1); });
		constant_folding_check("1 / 0", function() { return 1 / 0; }, function() { return constant_folding_rt(1) / constant_folding_rt(0); });
		constant_folding_check("-1 / 0", function() { return -1 / 0; }, function() { return -constant_folding_rt(1) / constant_folding_rt(0); });
		constant_folding_check("true + 1", function() { return true + 1; }, function() { return constant_folding_rt(true) + constant_folding_rt(1); });
		constant_folding_check("true * 2", function() { return true * 2; }, function() { return constant_folding_rt(true) * constant_folding_rt(2); });
		constant_folding_check("1500000000 * 2", function() { return 1500000000 * 2; }, function() { return constant_folding_rt(1500000000) * constant_folding_rt(2); });
		constant_folding_check("9007199254740993 + 0b1011", function() { return 9007199254740993 + 0b1011; }, function() { return constant_folding_rt(9007199254740993) + constant_folding_rt(0b1011); });
		constant_folding_check("9007199254740993 * 2", function() { return 9007199254740993 * 2; }, function() { return constant_folding_rt(9007199254740993) * constant_folding_rt(2); });
		constant_folding_check("int64(5) + 1.5", function() { return int64(5) + 1.5; }, function() { return int64(constant_folding_rt(5)) + constant_folding_rt(1.5); });
		constant_folding_check("int64(7) / 2", function() { return int64(7) / 2; }, function() { return int64(constant_folding_rt(7)) / constant_folding_rt(2); });
	});

	addFact("constant_folding_test #6", function() {
		
		// Check that div and mod with mixed types
		constant_folding_check("7 div 2", function() { return 7 div 2; }, function() { return constant_folding_rt(7) div constant_folding_rt(2); });
		constant_folding_check("-7 div 2", function() { return -7 div 2; }, function() { return -constant_folding_rt(7) div constant_folding_rt(2); });
		constant_folding_check("7.5 div 2", function() { return 7.5 div 2; }, function() { return constant_folding_rt(7.5) div constant_folding_rt(2); });
		constant_folding_check("-7.5 div 2", function() { return -7.5 div 2; }, function() { return -constant_folding_rt(7.5) div constant_folding_rt(2); });
		constant_folding_check("int64(7) div 2", function() { return int64(7) div 2; }, function() { return int64(constant_folding_rt(7)) div constant_folding_rt(2); });
		constant_folding_check("int64(7) div 2.5", function() { return int64(7) div 2.5; }, function() { return int64(constant_folding_rt(7)) div constant_folding_rt(2.5); });
		constant_folding_check("7 div int64(2)", function() { return 7 div int64(2); }, function() { return constant_folding_rt(7) div int64(constant_folding_rt(2)); });
		constant_folding_check("\"12\" div int64(5)", function() { return "12" div int64(5); }, function() { return constant_folding_rt("12") div int64(constant_folding_rt(5)); });
		constant_folding_check("7 mod 3", function() { return 7 mod 3; }, function() { return constant_folding_rt(7) mod constant_folding_rt(3); });
		constant_folding_check("-7 mod 3", function() { return -7 mod 3; }, function() { return -constant_folding_rt(7) mod constant_folding_rt(3); });
		constant_folding_check("7.5 mod 2", function() { return 7.5 mod 2; }, function() { return constant_folding_rt(7.5) mod constant_folding_rt(2); });
		constant_folding_check("-7.5 mod 2", function() { return -7.5 mod 2; }, function() { return -constant_folding_rt(7.5) mod constant_folding_rt(2); });
		constant_folding_check("7 mod 0.5", function() { return 7 mod 0.5; }, function() { return constant_folding_rt(7) mod constant_folding_rt(0.5); });
		constant_folding_check("9007199254740993 mod 0xA7", function() { return 9007199254740993 mod 0xA7; }, function() { return constant_folding_rt(9007199254740993) mod constant_folding_rt(0xA7); });
		constant_folding_check("int64(7) mod 2.5", function() { return int64(7) mod 2.5; }, function() { return int64(constant_folding_rt(7)) mod constant_folding_rt(2.5); });
		constant_folding_check("5 mod int64(3)", function() { return 5 mod int64(3); }, function() { return constant_folding_rt(5) mod int64(constant_folding_rt(3)); });
	});

	addFact("constant_folding_test #7", function() {
		
		// Check that unary minus
		constant_folding_check("-true", function() { return -true; }, function() { return -constant_folding_rt(true); });
		constant_folding_check("-false", function() { return -false; }, function() { return -constant_folding_rt(false); });
		constant_folding_check("-(1)", function() { return -(1); }, function() { return -(constant_folding_rt(1)); });
		constant_folding_check("-0.0", function() { return -0.0; }, function() { return -constant_folding_rt(0.0); });
		constant_folding_check("-int64(5)", function() { return -int64(5); }, function() { return -int64(constant_folding_rt(5)); });
	});

	addFact("constant_folding_test #8", function() {
		
		// Check that maths functions
		constant_folding_check("sin(2)", function() { return sin(2); }, function() { return sin(constant_folding_rt(2)); });
		constant_folding_check("cos(2)", function() { return cos(2); }, function() { return cos(constant_folding_rt(2)); });
		constant_folding_check("tan(2)", function() { return tan(2); }, function() { return tan(constant_folding_rt(2)); });
		constant_folding_check("arcsin(0.5)", function() { return arcsin(0.5); }, function() { return arcsin(constant_folding_rt(0.5)); });
		constant_folding_check("arctan(2)", function() { return arctan(2); }, function() { return arctan(constant_folding_rt(2)); });
		constant_folding_check("arctan2(1, 2)", function() { return arctan2(1, 2); }, function() { return arctan2(constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("dsin(30)", function() { return dsin(30); }, function() { return dsin(constant_folding_rt(30)); });
		constant_folding_check("darcsin(0.5)", function() { return darcsin(0.5); }, function() { return darcsin(constant_folding_rt(0.5)); });
		constant_folding_check("darccos(0.5)", function() { return darccos(0.5); }, function() { return darccos(constant_folding_rt(0.5)); });
		constant_folding_check("exp(1)", function() { return exp(1); }, function() { return exp(constant_folding_rt(1)); });
		constant_folding_check("ln(2)", function() { return ln(2); }, function() { return ln(constant_folding_rt(2)); });
		constant_folding_check("ln(-1)", function() { return ln(-1); }, function() { return ln(-constant_folding_rt(1)); });
		constant_folding_check("log2(8)", function() { return log2(8); }, function() { return log2(constant_folding_rt(8)); });
		constant_folding_check("power(2, 10)", function() { return power(2, 10); }, function() { return power(constant_folding_rt(2), constant_folding_rt(10)); });
		constant_folding_check("power(-8, 1/3)", function() { return power(-8, 1/3); }, function() { return power(-constant_folding_rt(8), constant_folding_rt(1)/constant_folding_rt(3)); });
		constant_folding_check("sqrt(2)", function() { return sqrt(2); }, function() { return sqrt(constant_folding_rt(2)); });
		constant_folding_check("ceil(1.5)", function() { return ceil(1.5); }, function() { return ceil(constant_folding_rt(1.5)); });
		constant_folding_check("floor(1.5)", function() { return floor(1.5); }, function() { return floor(constant_folding_rt(1.5)); });
		constant_folding_check("round(2.5)", function() { return round(2.5); }, function() { return round(constant_folding_rt(2.5)); });
		constant_folding_check("round(-2.5)", function() { return round(-2.5); }, function() { return round(-constant_folding_rt(2.5)); });
		constant_folding_check("abs(-3)", function() { return abs(-3); }, function() { return abs(-constant_folding_rt(3)); });
		constant_folding_check("sign(-3)", function() { return sign(-3); }, function() { return sign(-constant_folding_rt(3)); });
		constant_folding_check("frac(3.75)", function() { return frac(3.75); }, function() { return frac(constant_folding_rt(3.75)); });
		constant_folding_check("point_direction(0, 0, 1, 1)", function() { return point_direction(0, 0, 1, 1); }, function() { return point_direction(constant_folding_rt(0), constant_folding_rt(0), constant_folding_rt(1), constant_folding_rt(1)); });
		constant_folding_check("point_distance(0, 0, 3, 4)", function() { return point_distance(0, 0, 3, 4); }, function() { return point_distance(constant_folding_rt(0), constant_folding_rt(0), constant_folding_rt(3), constant_folding_rt(4)); });
	});

	addFact("constant_folding_test #9", function() {
		
		// Check that single precision functions
		constant_folding_check("lengthdir_x(2, 2)", function() { return lengthdir_x(2, 2); }, function() { return lengthdir_x(constant_folding_rt(2), constant_folding_rt(2)); });
		constant_folding_check("lengthdir_y(2, 2)", function() { return lengthdir_y(2, 2); }, function() { return lengthdir_y(constant_folding_rt(2), constant_folding_rt(2)); });
		constant_folding_check("dot_product_normalised(2, 2, 2, 2)", function() { return dot_product_normalised(2, 2, 2, 2); }, function() { return dot_product_normalised(constant_folding_rt(2), constant_folding_rt(2), constant_folding_rt(2), constant_folding_rt(2)); });
		constant_folding_check("dot_product_3d_normalised(1, 2, 3, 4, 5, 6)", function() { return dot_product_3d_normalised(1, 2, 3, 4, 5, 6); }, function() { return dot_product_3d_normalised(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3), constant_folding_rt(4), constant_folding_rt(5), constant_folding_rt(6)); });
		constant_folding_check("colour_get_hue(0x123456)", function() { return colour_get_hue(0x123456); }, function() { return colour_get_hue(constant_folding_rt(0x123456)); });
		constant_folding_check("colour_get_saturation(0x123456)", function() { return colour_get_saturation(0x123456); }, function() { return colour_get_saturation(constant_folding_rt(0x123456)); });
		constant_folding_check("colour_get_value(0x123456)", function() { return colour_get_value(0x123456); }, function() { return colour_get_value(constant_folding_rt(0x123456)); });
	});

	addFact("constant_folding_test #10", function() {
		
		// Check that chr and ansi_char
		constant_folding_check("chr(65)", function() { return chr(65); }, function() { return chr(constant_folding_rt(65)); });
		constant_folding_check("chr(65.9)", function() { return chr(65.9); }, function() { return chr(constant_folding_rt(65.9)); });
		constant_folding_check("chr(-3)", function() { return chr(-3); }, function() { return chr(-constant_folding_rt(3)); });
		constant_folding_check("chr(0x1F600)", function() { return chr(0x1F600); }, function() { return chr(constant_folding_rt(0x1F600)); });
		constant_folding_check("ansi_char(65)", function() { return ansi_char(65); }, function() { return ansi_char(constant_folding_rt(65)); });
		constant_folding_check("ansi_char(167)", function() { return ansi_char(167); }, function() { return ansi_char(constant_folding_rt(167)); });
		constant_folding_check("ord(\"A\")", function() { return ord("A"); }, function() { return ord(constant_folding_rt("A")); });
	});

	addFact("constant_folding_test #11", function() {
		
		// Check that min, max and clamp keep the type
		constant_folding_check("min(1, 2)", function() { return min(1, 2); }, function() { return min(constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("max(1, 2)", function() { return max(1, 2); }, function() { return max(constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("max(true, true)", function() { return max(true, true); }, function() { return max(constant_folding_rt(true), constant_folding_rt(true)); });
		constant_folding_check("min(int64(5), int64(5))", function() { return min(int64(5), int64(5)); }, function() { return min(int64(constant_folding_rt(5)), int64(constant_folding_rt(5))); });
		constant_folding_check("max(1, int64(2))", function() { return max(1, int64(2)); }, function() { return max(constant_folding_rt(1), int64(constant_folding_rt(2))); });
		constant_folding_check("clamp(5, 0, 3)", function() { return clamp(5, 0, 3); }, function() { return clamp(constant_folding_rt(5), constant_folding_rt(0), constant_folding_rt(3)); });
		constant_folding_check("mean(1, 2, 4)", function() { return mean(1, 2, 4); }, function() { return mean(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(4)); });
	});

}
