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

	addFact("constant_folding_test #12", function() {
		
		// Check that string_replace and string_replace_all match the runtime (GameMaker-Bugs#14968)
		constant_folding_check("string_replace(\"hello world\", \"o\", \"0\")", function() { return string_replace("hello world", "o", "0"); }, function() { return string_replace(constant_folding_rt("hello world"), constant_folding_rt("o"), constant_folding_rt("0")); });
		constant_folding_check("string_replace(\"hello\", \"\", \"x\")", function() { return string_replace("hello", "", "x"); }, function() { return string_replace(constant_folding_rt("hello"), constant_folding_rt(""), constant_folding_rt("x")); });
		constant_folding_check("string_replace(\"aaa\", \"a\", \"bb\")", function() { return string_replace("aaa", "a", "bb"); }, function() { return string_replace(constant_folding_rt("aaa"), constant_folding_rt("a"), constant_folding_rt("bb")); });
		constant_folding_check("string_replace(\"héllo é\", \"é\", \"e\")", function() { return string_replace("héllo é", "é", "e"); }, function() { return string_replace(constant_folding_rt("héllo é"), constant_folding_rt("é"), constant_folding_rt("e")); });
		constant_folding_check("string_replace(123.5, \".\", \",\")", function() { return string_replace(123.5, ".", ","); }, function() { return string_replace(constant_folding_rt(123.5), constant_folding_rt("."), constant_folding_rt(",")); });
		constant_folding_check("string_replace(\"abc\", \"abc\", \"\")", function() { return string_replace("abc", "abc", ""); }, function() { return string_replace(constant_folding_rt("abc"), constant_folding_rt("abc"), constant_folding_rt("")); });
		constant_folding_check("string_replace(\"abc\", \"x\", \"y\")", function() { return string_replace("abc", "x", "y"); }, function() { return string_replace(constant_folding_rt("abc"), constant_folding_rt("x"), constant_folding_rt("y")); });
		constant_folding_check("string_replace_all(\"hello world\", \"o\", \"0\")", function() { return string_replace_all("hello world", "o", "0"); }, function() { return string_replace_all(constant_folding_rt("hello world"), constant_folding_rt("o"), constant_folding_rt("0")); });
		constant_folding_check("string_replace_all(\"aaaa\", \"aa\", \"b\")", function() { return string_replace_all("aaaa", "aa", "b"); }, function() { return string_replace_all(constant_folding_rt("aaaa"), constant_folding_rt("aa"), constant_folding_rt("b")); });
		constant_folding_check("string_replace_all(\"héhé\", \"é\", \"€\")", function() { return string_replace_all("héhé", "é", "€"); }, function() { return string_replace_all(constant_folding_rt("héhé"), constant_folding_rt("é"), constant_folding_rt("€")); });
		constant_folding_check("string_replace_all(\"hello\", \"\", \"x\")", function() { return string_replace_all("hello", "", "x"); }, function() { return string_replace_all(constant_folding_rt("hello"), constant_folding_rt(""), constant_folding_rt("x")); });
		constant_folding_check("string_replace_all(\"abcabc\", \"bc\", \"\")", function() { return string_replace_all("abcabc", "bc", ""); }, function() { return string_replace_all(constant_folding_rt("abcabc"), constant_folding_rt("bc"), constant_folding_rt("")); });
		constant_folding_check("string_replace_all(\"aXbXc\", \"X\", \"\")", function() { return string_replace_all("aXbXc", "X", ""); }, function() { return string_replace_all(constant_folding_rt("aXbXc"), constant_folding_rt("X"), constant_folding_rt("")); });
		constant_folding_check("string_replace(\"ééé\", \"é\", \"e\")", function() { return string_replace("ééé", "é", "e"); }, function() { return string_replace(constant_folding_rt("ééé"), constant_folding_rt("é"), constant_folding_rt("e")); });
	});

	addFact("constant_folding_test #13", function() {
		
		// Check that string_repeat, string_letters, string_digits and string_lettersdigits match the runtime
		constant_folding_check("string_repeat(\"ab\", 3)", function() { return string_repeat("ab", 3); }, function() { return string_repeat(constant_folding_rt("ab"), constant_folding_rt(3)); });
		constant_folding_check("string_repeat(\"ab\", 0)", function() { return string_repeat("ab", 0); }, function() { return string_repeat(constant_folding_rt("ab"), constant_folding_rt(0)); });
		constant_folding_check("string_repeat(\"ab\", -1)", function() { return string_repeat("ab", -1); }, function() { return string_repeat(constant_folding_rt("ab"), constant_folding_rt(-1)); });
		constant_folding_check("string_repeat(\"é\", 2)", function() { return string_repeat("é", 2); }, function() { return string_repeat(constant_folding_rt("é"), constant_folding_rt(2)); });
		constant_folding_check("string_repeat(\"ab\", 2.7)", function() { return string_repeat("ab", 2.7); }, function() { return string_repeat(constant_folding_rt("ab"), constant_folding_rt(2.7)); });
		constant_folding_check("string_repeat(\"ab\", int64(3))", function() { return string_repeat("ab", int64(3)); }, function() { return string_repeat(constant_folding_rt("ab"), int64(constant_folding_rt(3))); });
		constant_folding_check("string_repeat(12, 2)", function() { return string_repeat(12, 2); }, function() { return string_repeat(constant_folding_rt(12), constant_folding_rt(2)); });
		constant_folding_check("string_letters(\"a1b2-c3é Z\")", function() { return string_letters("a1b2-c3é Z"); }, function() { return string_letters(constant_folding_rt("a1b2-c3é Z")); });
		constant_folding_check("string_digits(\"a1b2 3.5é9\")", function() { return string_digits("a1b2 3.5é9"); }, function() { return string_digits(constant_folding_rt("a1b2 3.5é9")); });
		constant_folding_check("string_lettersdigits(\"a1_b2 é!Z\")", function() { return string_lettersdigits("a1_b2 é!Z"); }, function() { return string_lettersdigits(constant_folding_rt("a1_b2 é!Z")); });
	});

	addFact("constant_folding_test #14", function() {
		
		// Check that string_copy, string_insert and string_delete match the runtime
		constant_folding_check("string_copy(\"hello\", 2, 3)", function() { return string_copy("hello", 2, 3); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(2), constant_folding_rt(3)); });
		constant_folding_check("string_copy(\"hello\", 0, 2)", function() { return string_copy("hello", 0, 2); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_copy(\"hello\", -1, 2)", function() { return string_copy("hello", -1, 2); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(-1), constant_folding_rt(2)); });
		constant_folding_check("string_copy(\"hello\", 4, 10)", function() { return string_copy("hello", 4, 10); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(4), constant_folding_rt(10)); });
		constant_folding_check("string_copy(\"hello\", 10, 2)", function() { return string_copy("hello", 10, 2); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(10), constant_folding_rt(2)); });
		constant_folding_check("string_copy(\"héllo\", 2, 2)", function() { return string_copy("héllo", 2, 2); }, function() { return string_copy(constant_folding_rt("héllo"), constant_folding_rt(2), constant_folding_rt(2)); });
		constant_folding_check("string_copy(\"hello\", 2, -1)", function() { return string_copy("hello", 2, -1); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(2), constant_folding_rt(-1)); });
		constant_folding_check("string_copy(\"hello\", 2.9, 1.9)", function() { return string_copy("hello", 2.9, 1.9); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(2.9), constant_folding_rt(1.9)); });
		constant_folding_check("string_copy(\"hello\", -2.5, 2)", function() { return string_copy("hello", -2.5, 2); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(-2.5), constant_folding_rt(2)); });
		constant_folding_check("string_insert(\"XX\", \"hello\", 3)", function() { return string_insert("XX", "hello", 3); }, function() { return string_insert(constant_folding_rt("XX"), constant_folding_rt("hello"), constant_folding_rt(3)); });
		constant_folding_check("string_insert(\"XX\", \"hello\", 0)", function() { return string_insert("XX", "hello", 0); }, function() { return string_insert(constant_folding_rt("XX"), constant_folding_rt("hello"), constant_folding_rt(0)); });
		constant_folding_check("string_insert(\"XX\", \"hello\", 10)", function() { return string_insert("XX", "hello", 10); }, function() { return string_insert(constant_folding_rt("XX"), constant_folding_rt("hello"), constant_folding_rt(10)); });
		constant_folding_check("string_insert(\"é\", \"héllo\", 3)", function() { return string_insert("é", "héllo", 3); }, function() { return string_insert(constant_folding_rt("é"), constant_folding_rt("héllo"), constant_folding_rt(3)); });
		constant_folding_check("string_insert(5, \"hello\", 2)", function() { return string_insert(5, "hello", 2); }, function() { return string_insert(constant_folding_rt(5), constant_folding_rt("hello"), constant_folding_rt(2)); });
		constant_folding_check("string_delete(\"hello\", 2, 2)", function() { return string_delete("hello", 2, 2); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(2), constant_folding_rt(2)); });
		constant_folding_check("string_delete(\"hello\", -2, 1)", function() { return string_delete("hello", -2, 1); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(-2), constant_folding_rt(1)); });
		constant_folding_check("string_delete(\"hello\", 0, 2)", function() { return string_delete("hello", 0, 2); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_delete(\"hello\", 3, -2)", function() { return string_delete("hello", 3, -2); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(3), constant_folding_rt(-2)); });
		constant_folding_check("string_delete(\"héllo\", 2, 1)", function() { return string_delete("héllo", 2, 1); }, function() { return string_delete(constant_folding_rt("héllo"), constant_folding_rt(2), constant_folding_rt(1)); });
		constant_folding_check("string_delete(\"hello\", -5, 1)", function() { return string_delete("hello", -5, 1); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(-5), constant_folding_rt(1)); });
		constant_folding_check("string_delete(\"hello\", 2, 100)", function() { return string_delete("hello", 2, 100); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(2), constant_folding_rt(100)); });
		constant_folding_check("string_delete(\"hello\", 1, 0)", function() { return string_delete("hello", 1, 0); }, function() { return string_delete(constant_folding_rt("hello"), constant_folding_rt(1), constant_folding_rt(0)); });
		constant_folding_check("string_copy(\"hello\", 1, 0)", function() { return string_copy("hello", 1, 0); }, function() { return string_copy(constant_folding_rt("hello"), constant_folding_rt(1), constant_folding_rt(0)); });
	});

	addFact("constant_folding_test #15", function() {
		
		// Check that string_hash_to_newline and string_format match the runtime (and a real that is not a whole number is converted to a string by the runtime)
		constant_folding_check("string_hash_to_newline(\"a#b\")", function() { return string_hash_to_newline("a#b"); }, function() { return string_hash_to_newline(constant_folding_rt("a#b")); });
		constant_folding_check("string_hash_to_newline(\"a\\\\#b\")", function() { return string_hash_to_newline("a\\#b"); }, function() { return string_hash_to_newline(constant_folding_rt("a\\#b")); });
		constant_folding_check("string_hash_to_newline(\"##\")", function() { return string_hash_to_newline("##"); }, function() { return string_hash_to_newline(constant_folding_rt("##")); });
		constant_folding_check("string_hash_to_newline(\"a\\\\\\\\#b\")", function() { return string_hash_to_newline("a\\\\#b"); }, function() { return string_hash_to_newline(constant_folding_rt("a\\\\#b")); });
		constant_folding_check("string_hash_to_newline(\"é#é\")", function() { return string_hash_to_newline("é#é"); }, function() { return string_hash_to_newline(constant_folding_rt("é#é")); });
		constant_folding_check("string_format(3.14159, 5, 2)", function() { return string_format(3.14159, 5, 2); }, function() { return string_format(constant_folding_rt(3.14159), constant_folding_rt(5), constant_folding_rt(2)); });
		constant_folding_check("string_format(-3.14159, 0, 3)", function() { return string_format(-3.14159, 0, 3); }, function() { return string_format(constant_folding_rt(-3.14159), constant_folding_rt(0), constant_folding_rt(3)); });
		constant_folding_check("string_format(42, 1, 0)", function() { return string_format(42, 1, 0); }, function() { return string_format(constant_folding_rt(42), constant_folding_rt(1), constant_folding_rt(0)); });
		constant_folding_check("string_format(0.125, 0, 2)", function() { return string_format(0.125, 0, 2); }, function() { return string_format(constant_folding_rt(0.125), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(2.5, 0, 0)", function() { return string_format(2.5, 0, 0); }, function() { return string_format(constant_folding_rt(2.5), constant_folding_rt(0), constant_folding_rt(0)); });
		constant_folding_check("string_format(1234567.891, 3, 2)", function() { return string_format(1234567.891, 3, 2); }, function() { return string_format(constant_folding_rt(1234567.891), constant_folding_rt(3), constant_folding_rt(2)); });
		constant_folding_check("string_format(100000000000000000000, 0, 2)", function() { return string_format(100000000000000000000, 0, 2); }, function() { return string_format(constant_folding_rt(100000000000000000000), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(0.1, 0, 20)", function() { return string_format(0.1, 0, 20); }, function() { return string_format(constant_folding_rt(0.1), constant_folding_rt(0), constant_folding_rt(20)); });
		constant_folding_check("string_format(7, -3, -2)", function() { return string_format(7, -3, -2); }, function() { return string_format(constant_folding_rt(7), constant_folding_rt(-3), constant_folding_rt(-2)); });
		constant_folding_check("string_format(123.456, 10, 1)", function() { return string_format(123.456, 10, 1); }, function() { return string_format(constant_folding_rt(123.456), constant_folding_rt(10), constant_folding_rt(1)); });
		constant_folding_check("string_format(\"str\", 1, 1)", function() { return string_format("str", 1, 1); }, function() { return string_format(constant_folding_rt("str"), constant_folding_rt(1), constant_folding_rt(1)); });
		constant_folding_check("string_format(int64(12), 4, 1)", function() { return string_format(int64(12), 4, 1); }, function() { return string_format(int64(constant_folding_rt(12)), constant_folding_rt(4), constant_folding_rt(1)); });
		constant_folding_check("string_format(0.5, 0, 0)", function() { return string_format(0.5, 0, 0); }, function() { return string_format(constant_folding_rt(0.5), constant_folding_rt(0), constant_folding_rt(0)); });
		constant_folding_check("string_format(1.5, 0, 0)", function() { return string_format(1.5, 0, 0); }, function() { return string_format(constant_folding_rt(1.5), constant_folding_rt(0), constant_folding_rt(0)); });
		constant_folding_check("string_format(-0.004, 0, 2)", function() { return string_format(-0.004, 0, 2); }, function() { return string_format(constant_folding_rt(-0.004), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(-0.006, 0, 2)", function() { return string_format(-0.006, 0, 2); }, function() { return string_format(constant_folding_rt(-0.006), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(99.995, 0, 2)", function() { return string_format(99.995, 0, 2); }, function() { return string_format(constant_folding_rt(99.995), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(2.675, 0, 2)", function() { return string_format(2.675, 0, 2); }, function() { return string_format(constant_folding_rt(2.675), constant_folding_rt(0), constant_folding_rt(2)); });
		constant_folding_check("string_format(5, 300, 2)", function() { return string_format(5, 300, 2); }, function() { return string_format(constant_folding_rt(5), constant_folding_rt(300), constant_folding_rt(2)); });
		constant_folding_check("string_upper(1.5)", function() { return string_upper(1.5); }, function() { return string_upper(constant_folding_rt(1.5)); });
		constant_folding_check("string_lower(12)", function() { return string_lower(12); }, function() { return string_lower(constant_folding_rt(12)); });
	});

	addFact("constant_folding_test #16", function() {
		
		// Check that bool and the is_ functions give the same bool as the runtime
		constant_folding_check("bool(1)", function() { return bool(1); }, function() { return bool(constant_folding_rt(1)); });
		constant_folding_check("bool(0)", function() { return bool(0); }, function() { return bool(constant_folding_rt(0)); });
		constant_folding_check("bool(0.5)", function() { return bool(0.5); }, function() { return bool(constant_folding_rt(0.5)); });
		constant_folding_check("bool(0.4)", function() { return bool(0.4); }, function() { return bool(constant_folding_rt(0.4)); });
		constant_folding_check("bool(-1)", function() { return bool(-1); }, function() { return bool(constant_folding_rt(-1)); });
		constant_folding_check("bool(int64(5))", function() { return bool(int64(5)); }, function() { return bool(int64(constant_folding_rt(5))); });
		constant_folding_check("bool(int64(0))", function() { return bool(int64(0)); }, function() { return bool(int64(constant_folding_rt(0))); });
		constant_folding_check("bool(true)", function() { return bool(true); }, function() { return bool(constant_folding_rt(true)); });
		constant_folding_check("is_int32(5)", function() { return is_int32(5); }, function() { return is_int32(constant_folding_rt(5)); });
		constant_folding_check("is_int32(5.5)", function() { return is_int32(5.5); }, function() { return is_int32(constant_folding_rt(5.5)); });
		constant_folding_check("is_int32(int64(5))", function() { return is_int32(int64(5)); }, function() { return is_int32(int64(constant_folding_rt(5))); });
		constant_folding_check("is_int32(\"5\")", function() { return is_int32("5"); }, function() { return is_int32(constant_folding_rt("5")); });
		constant_folding_check("is_int32(true)", function() { return is_int32(true); }, function() { return is_int32(constant_folding_rt(true)); });
		constant_folding_check("is_int32(undefined)", function() { return is_int32(undefined); }, function() { return is_int32(constant_folding_rt(undefined)); });
		constant_folding_check("is_real(5)", function() { return is_real(5); }, function() { return is_real(constant_folding_rt(5)); });
		constant_folding_check("is_real(5.5)", function() { return is_real(5.5); }, function() { return is_real(constant_folding_rt(5.5)); });
		constant_folding_check("is_real(int64(5))", function() { return is_real(int64(5)); }, function() { return is_real(int64(constant_folding_rt(5))); });
		constant_folding_check("is_real(\"5\")", function() { return is_real("5"); }, function() { return is_real(constant_folding_rt("5")); });
		constant_folding_check("is_real(true)", function() { return is_real(true); }, function() { return is_real(constant_folding_rt(true)); });
		constant_folding_check("is_real(undefined)", function() { return is_real(undefined); }, function() { return is_real(constant_folding_rt(undefined)); });
		constant_folding_check("is_infinity(5)", function() { return is_infinity(5); }, function() { return is_infinity(constant_folding_rt(5)); });
		constant_folding_check("is_infinity(infinity)", function() { return is_infinity(infinity); }, function() { return is_infinity(constant_folding_rt(infinity)); });
		constant_folding_check("is_infinity(-infinity)", function() { return is_infinity(-infinity); }, function() { return is_infinity(constant_folding_rt(-infinity)); });
		constant_folding_check("is_infinity(\"5\")", function() { return is_infinity("5"); }, function() { return is_infinity(constant_folding_rt("5")); });
		constant_folding_check("is_infinity(true)", function() { return is_infinity(true); }, function() { return is_infinity(constant_folding_rt(true)); });
		constant_folding_check("is_infinity(int64(5))", function() { return is_infinity(int64(5)); }, function() { return is_infinity(int64(constant_folding_rt(5))); });
		constant_folding_check("is_nan(5)", function() { return is_nan(5); }, function() { return is_nan(constant_folding_rt(5)); });
		constant_folding_check("is_nan(\"abc\")", function() { return is_nan("abc"); }, function() { return is_nan(constant_folding_rt("abc")); });
		constant_folding_check("is_nan(\"5\")", function() { return is_nan("5"); }, function() { return is_nan(constant_folding_rt("5")); });
		constant_folding_check("is_nan(undefined)", function() { return is_nan(undefined); }, function() { return is_nan(constant_folding_rt(undefined)); });
		constant_folding_check("is_nan(NaN)", function() { return is_nan(NaN); }, function() { return is_nan(constant_folding_rt(NaN)); });
		constant_folding_check("is_nan(true)", function() { return is_nan(true); }, function() { return is_nan(constant_folding_rt(true)); });
		constant_folding_check("is_nan(int64(5))", function() { return is_nan(int64(5)); }, function() { return is_nan(int64(constant_folding_rt(5))); });
		constant_folding_check("is_bool(true)", function() { return is_bool(true); }, function() { return is_bool(constant_folding_rt(true)); });
		constant_folding_check("is_bool(1)", function() { return is_bool(1); }, function() { return is_bool(constant_folding_rt(1)); });
		constant_folding_check("is_bool(\"true\")", function() { return is_bool("true"); }, function() { return is_bool(constant_folding_rt("true")); });
		constant_folding_check("is_bool(undefined)", function() { return is_bool(undefined); }, function() { return is_bool(constant_folding_rt(undefined)); });
		constant_folding_check("is_numeric(5)", function() { return is_numeric(5); }, function() { return is_numeric(constant_folding_rt(5)); });
		constant_folding_check("is_numeric(5.5)", function() { return is_numeric(5.5); }, function() { return is_numeric(constant_folding_rt(5.5)); });
		constant_folding_check("is_numeric(\"5\")", function() { return is_numeric("5"); }, function() { return is_numeric(constant_folding_rt("5")); });
		constant_folding_check("is_numeric(true)", function() { return is_numeric(true); }, function() { return is_numeric(constant_folding_rt(true)); });
		constant_folding_check("is_numeric(int64(1))", function() { return is_numeric(int64(1)); }, function() { return is_numeric(int64(constant_folding_rt(1))); });
		constant_folding_check("is_numeric(undefined)", function() { return is_numeric(undefined); }, function() { return is_numeric(constant_folding_rt(undefined)); });
		constant_folding_check("is_string(\"a\")", function() { return is_string("a"); }, function() { return is_string(constant_folding_rt("a")); });
		constant_folding_check("is_string(5)", function() { return is_string(5); }, function() { return is_string(constant_folding_rt(5)); });
		constant_folding_check("is_string(undefined)", function() { return is_string(undefined); }, function() { return is_string(constant_folding_rt(undefined)); });
		constant_folding_check("is_callable(5)", function() { return is_callable(5); }, function() { return is_callable(constant_folding_rt(5)); });
		constant_folding_check("is_callable(\"a\")", function() { return is_callable("a"); }, function() { return is_callable(constant_folding_rt("a")); });
		constant_folding_check("is_callable(undefined)", function() { return is_callable(undefined); }, function() { return is_callable(constant_folding_rt(undefined)); });
		constant_folding_check("is_int32(100000)", function() { return is_int32(100000); }, function() { return is_int32(constant_folding_rt(100000)); });
		constant_folding_check("is_real(100000)", function() { return is_real(100000); }, function() { return is_real(constant_folding_rt(100000)); });
		constant_folding_check("is_real(-5)", function() { return is_real(-5); }, function() { return is_real(constant_folding_rt(-5)); });
		constant_folding_check("is_int32(-100000)", function() { return is_int32(-100000); }, function() { return is_int32(constant_folding_rt(-100000)); });
		constant_folding_check("is_infinity(undefined)", function() { return is_infinity(undefined); }, function() { return is_infinity(constant_folding_rt(undefined)); });
		constant_folding_check("is_nan(\"\")", function() { return is_nan(""); }, function() { return is_nan(constant_folding_rt("")); });
		constant_folding_check("bool(undefined)", function() { return bool(undefined); }, function() { return bool(constant_folding_rt(undefined)); });
	});

	addFact("constant_folding_test #17", function() {
		
		// Check that string_starts_with, string_ends_with, string_pos, string_last_pos and string_count match the runtime
		constant_folding_check("string_starts_with(\"hello\", \"he\")", function() { return string_starts_with("hello", "he"); }, function() { return string_starts_with(constant_folding_rt("hello"), constant_folding_rt("he")); });
		constant_folding_check("string_starts_with(\"hello\", \"\")", function() { return string_starts_with("hello", ""); }, function() { return string_starts_with(constant_folding_rt("hello"), constant_folding_rt("")); });
		constant_folding_check("string_starts_with(\"he\", \"hello\")", function() { return string_starts_with("he", "hello"); }, function() { return string_starts_with(constant_folding_rt("he"), constant_folding_rt("hello")); });
		constant_folding_check("string_starts_with(\"héllo\", \"hé\")", function() { return string_starts_with("héllo", "hé"); }, function() { return string_starts_with(constant_folding_rt("héllo"), constant_folding_rt("hé")); });
		constant_folding_check("string_starts_with(\"hello\", \"lo\")", function() { return string_starts_with("hello", "lo"); }, function() { return string_starts_with(constant_folding_rt("hello"), constant_folding_rt("lo")); });
		constant_folding_check("string_starts_with(123, \"12\")", function() { return string_starts_with(123, "12"); }, function() { return string_starts_with(constant_folding_rt(123), constant_folding_rt("12")); });
		constant_folding_check("string_ends_with(\"hello\", \"lo\")", function() { return string_ends_with("hello", "lo"); }, function() { return string_ends_with(constant_folding_rt("hello"), constant_folding_rt("lo")); });
		constant_folding_check("string_ends_with(\"hello\", \"\")", function() { return string_ends_with("hello", ""); }, function() { return string_ends_with(constant_folding_rt("hello"), constant_folding_rt("")); });
		constant_folding_check("string_ends_with(\"lo\", \"hello\")", function() { return string_ends_with("lo", "hello"); }, function() { return string_ends_with(constant_folding_rt("lo"), constant_folding_rt("hello")); });
		constant_folding_check("string_ends_with(\"héllo\", \"llo\")", function() { return string_ends_with("héllo", "llo"); }, function() { return string_ends_with(constant_folding_rt("héllo"), constant_folding_rt("llo")); });
		constant_folding_check("string_ends_with(\"hello\", \"he\")", function() { return string_ends_with("hello", "he"); }, function() { return string_ends_with(constant_folding_rt("hello"), constant_folding_rt("he")); });
		constant_folding_check("string_pos(\"l\", \"hello\")", function() { return string_pos("l", "hello"); }, function() { return string_pos(constant_folding_rt("l"), constant_folding_rt("hello")); });
		constant_folding_check("string_pos(\"\", \"hello\")", function() { return string_pos("", "hello"); }, function() { return string_pos(constant_folding_rt(""), constant_folding_rt("hello")); });
		constant_folding_check("string_pos(\"é\", \"héllo\")", function() { return string_pos("é", "héllo"); }, function() { return string_pos(constant_folding_rt("é"), constant_folding_rt("héllo")); });
		constant_folding_check("string_pos(\"lo\", \"héllo\")", function() { return string_pos("lo", "héllo"); }, function() { return string_pos(constant_folding_rt("lo"), constant_folding_rt("héllo")); });
		constant_folding_check("string_pos(\"x\", \"hello\")", function() { return string_pos("x", "hello"); }, function() { return string_pos(constant_folding_rt("x"), constant_folding_rt("hello")); });
		constant_folding_check("string_pos(\"hello\", \"hi\")", function() { return string_pos("hello", "hi"); }, function() { return string_pos(constant_folding_rt("hello"), constant_folding_rt("hi")); });
		constant_folding_check("string_pos(1, \"a1b1\")", function() { return string_pos(1, "a1b1"); }, function() { return string_pos(constant_folding_rt(1), constant_folding_rt("a1b1")); });
		constant_folding_check("string_pos_ext(\"l\", \"hello\", 4)", function() { return string_pos_ext("l", "hello", 4); }, function() { return string_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(4)); });
		constant_folding_check("string_pos_ext(\"l\", \"hello\", 0)", function() { return string_pos_ext("l", "hello", 0); }, function() { return string_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(0)); });
		constant_folding_check("string_pos_ext(\"l\", \"hello\", -1)", function() { return string_pos_ext("l", "hello", -1); }, function() { return string_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(-1)); });
		constant_folding_check("string_pos_ext(\"l\", \"hello\", 10)", function() { return string_pos_ext("l", "hello", 10); }, function() { return string_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(10)); });
		constant_folding_check("string_pos_ext(\"é\", \"éaé\", 2)", function() { return string_pos_ext("é", "éaé", 2); }, function() { return string_pos_ext(constant_folding_rt("é"), constant_folding_rt("éaé"), constant_folding_rt(2)); });
		constant_folding_check("string_pos_ext(\"\", \"hello\", 3)", function() { return string_pos_ext("", "hello", 3); }, function() { return string_pos_ext(constant_folding_rt(""), constant_folding_rt("hello"), constant_folding_rt(3)); });
		constant_folding_check("string_pos_ext(\"o\", \"hello\", 5)", function() { return string_pos_ext("o", "hello", 5); }, function() { return string_pos_ext(constant_folding_rt("o"), constant_folding_rt("hello"), constant_folding_rt(5)); });
		constant_folding_check("string_last_pos(\"l\", \"hello\")", function() { return string_last_pos("l", "hello"); }, function() { return string_last_pos(constant_folding_rt("l"), constant_folding_rt("hello")); });
		constant_folding_check("string_last_pos(\"\", \"hello\")", function() { return string_last_pos("", "hello"); }, function() { return string_last_pos(constant_folding_rt(""), constant_folding_rt("hello")); });
		constant_folding_check("string_last_pos(\"é\", \"éaé\")", function() { return string_last_pos("é", "éaé"); }, function() { return string_last_pos(constant_folding_rt("é"), constant_folding_rt("éaé")); });
		constant_folding_check("string_last_pos(\"x\", \"hello\")", function() { return string_last_pos("x", "hello"); }, function() { return string_last_pos(constant_folding_rt("x"), constant_folding_rt("hello")); });
		constant_folding_check("string_last_pos(\"hello\", \"hi\")", function() { return string_last_pos("hello", "hi"); }, function() { return string_last_pos(constant_folding_rt("hello"), constant_folding_rt("hi")); });
		constant_folding_check("string_last_pos_ext(\"l\", \"hello\", 3)", function() { return string_last_pos_ext("l", "hello", 3); }, function() { return string_last_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(3)); });
		constant_folding_check("string_last_pos_ext(\"l\", \"hello\", 0)", function() { return string_last_pos_ext("l", "hello", 0); }, function() { return string_last_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(0)); });
		constant_folding_check("string_last_pos_ext(\"l\", \"hello\", 10)", function() { return string_last_pos_ext("l", "hello", 10); }, function() { return string_last_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(10)); });
		constant_folding_check("string_last_pos_ext(\"l\", \"hello\", -1)", function() { return string_last_pos_ext("l", "hello", -1); }, function() { return string_last_pos_ext(constant_folding_rt("l"), constant_folding_rt("hello"), constant_folding_rt(-1)); });
		constant_folding_check("string_last_pos_ext(\"é\", \"éaéa\", 3)", function() { return string_last_pos_ext("é", "éaéa", 3); }, function() { return string_last_pos_ext(constant_folding_rt("é"), constant_folding_rt("éaéa"), constant_folding_rt(3)); });
		constant_folding_check("string_last_pos_ext(\"\", \"hello\", 3)", function() { return string_last_pos_ext("", "hello", 3); }, function() { return string_last_pos_ext(constant_folding_rt(""), constant_folding_rt("hello"), constant_folding_rt(3)); });
		constant_folding_check("string_last_pos_ext(\"h\", \"hello\", 1)", function() { return string_last_pos_ext("h", "hello", 1); }, function() { return string_last_pos_ext(constant_folding_rt("h"), constant_folding_rt("hello"), constant_folding_rt(1)); });
		constant_folding_check("string_count(\"l\", \"hello\")", function() { return string_count("l", "hello"); }, function() { return string_count(constant_folding_rt("l"), constant_folding_rt("hello")); });
		constant_folding_check("string_count(\"\", \"hello\")", function() { return string_count("", "hello"); }, function() { return string_count(constant_folding_rt(""), constant_folding_rt("hello")); });
		constant_folding_check("string_count(\"aa\", \"aaaa\")", function() { return string_count("aa", "aaaa"); }, function() { return string_count(constant_folding_rt("aa"), constant_folding_rt("aaaa")); });
		constant_folding_check("string_count(\"é\", \"éé\")", function() { return string_count("é", "éé"); }, function() { return string_count(constant_folding_rt("é"), constant_folding_rt("éé")); });
		constant_folding_check("string_count(\"x\", \"\")", function() { return string_count("x", ""); }, function() { return string_count(constant_folding_rt("x"), constant_folding_rt("")); });
		constant_folding_check("string_last_pos(\"\", \"\")", function() { return string_last_pos("", ""); }, function() { return string_last_pos(constant_folding_rt(""), constant_folding_rt("")); });
		constant_folding_check("string_pos(\"\", \"\")", function() { return string_pos("", ""); }, function() { return string_pos(constant_folding_rt(""), constant_folding_rt("")); });
		constant_folding_check("string_count(\"\", \"\")", function() { return string_count("", ""); }, function() { return string_count(constant_folding_rt(""), constant_folding_rt("")); });
	});

	addFact("constant_folding_test #18", function() {
		
		// Check that string_char_at and string_ord_at match the runtime
		constant_folding_check("string_char_at(\"hello\", 1)", function() { return string_char_at("hello", 1); }, function() { return string_char_at(constant_folding_rt("hello"), constant_folding_rt(1)); });
		constant_folding_check("string_char_at(\"hello\", 0)", function() { return string_char_at("hello", 0); }, function() { return string_char_at(constant_folding_rt("hello"), constant_folding_rt(0)); });
		constant_folding_check("string_char_at(\"hello\", 6)", function() { return string_char_at("hello", 6); }, function() { return string_char_at(constant_folding_rt("hello"), constant_folding_rt(6)); });
		constant_folding_check("string_char_at(\"héllo\", 2)", function() { return string_char_at("héllo", 2); }, function() { return string_char_at(constant_folding_rt("héllo"), constant_folding_rt(2)); });
		constant_folding_check("string_char_at(\"hello\", -3)", function() { return string_char_at("hello", -3); }, function() { return string_char_at(constant_folding_rt("hello"), constant_folding_rt(-3)); });
		constant_folding_check("string_char_at(\"\", 1)", function() { return string_char_at("", 1); }, function() { return string_char_at(constant_folding_rt(""), constant_folding_rt(1)); });
		constant_folding_check("string_char_at(\"a😀b\", 2)", function() { return string_char_at("a😀b", 2); }, function() { return string_char_at(constant_folding_rt("a😀b"), constant_folding_rt(2)); });
		constant_folding_check("string_ord_at(\"hello\", 1)", function() { return string_ord_at("hello", 1); }, function() { return string_ord_at(constant_folding_rt("hello"), constant_folding_rt(1)); });
		constant_folding_check("string_ord_at(\"hello\", 0)", function() { return string_ord_at("hello", 0); }, function() { return string_ord_at(constant_folding_rt("hello"), constant_folding_rt(0)); });
		constant_folding_check("string_ord_at(\"hello\", 6)", function() { return string_ord_at("hello", 6); }, function() { return string_ord_at(constant_folding_rt("hello"), constant_folding_rt(6)); });
		constant_folding_check("string_ord_at(\"héllo\", 2)", function() { return string_ord_at("héllo", 2); }, function() { return string_ord_at(constant_folding_rt("héllo"), constant_folding_rt(2)); });
		constant_folding_check("string_ord_at(\"\", 1)", function() { return string_ord_at("", 1); }, function() { return string_ord_at(constant_folding_rt(""), constant_folding_rt(1)); });
		constant_folding_check("string_ord_at(\"😀\", 1)", function() { return string_ord_at("😀", 1); }, function() { return string_ord_at(constant_folding_rt("😀"), constant_folding_rt(1)); });
		constant_folding_check("string_ord_at(\"hello\", 7)", function() { return string_ord_at("hello", 7); }, function() { return string_ord_at(constant_folding_rt("hello"), constant_folding_rt(7)); });
		constant_folding_check("string_char_at(\"hello\", 2.5)", function() { return string_char_at("hello", 2.5); }, function() { return string_char_at(constant_folding_rt("hello"), constant_folding_rt(2.5)); });
	});

	addFact("constant_folding_test #19", function() {
		
		// Check that the hash and base64 functions match the runtime
		constant_folding_check("sha1_string_utf8(\"hello\")", function() { return sha1_string_utf8("hello"); }, function() { return sha1_string_utf8(constant_folding_rt("hello")); });
		constant_folding_check("sha1_string_utf8(\"\")", function() { return sha1_string_utf8(""); }, function() { return sha1_string_utf8(constant_folding_rt("")); });
		constant_folding_check("sha1_string_utf8(\"héllo\")", function() { return sha1_string_utf8("héllo"); }, function() { return sha1_string_utf8(constant_folding_rt("héllo")); });
		constant_folding_check("sha1_string_utf8(42)", function() { return sha1_string_utf8(42); }, function() { return sha1_string_utf8(constant_folding_rt(42)); });
		constant_folding_check("sha1_string_unicode(\"hello\")", function() { return sha1_string_unicode("hello"); }, function() { return sha1_string_unicode(constant_folding_rt("hello")); });
		constant_folding_check("sha1_string_unicode(\"😀a\")", function() { return sha1_string_unicode("😀a"); }, function() { return sha1_string_unicode(constant_folding_rt("😀a")); });
		constant_folding_check("md5_string_utf8(\"hello\")", function() { return md5_string_utf8("hello"); }, function() { return md5_string_utf8(constant_folding_rt("hello")); });
		constant_folding_check("md5_string_utf8(\"\")", function() { return md5_string_utf8(""); }, function() { return md5_string_utf8(constant_folding_rt("")); });
		constant_folding_check("md5_string_utf8(\"héllo\")", function() { return md5_string_utf8("héllo"); }, function() { return md5_string_utf8(constant_folding_rt("héllo")); });
		constant_folding_check("md5_string_unicode(\"hello\")", function() { return md5_string_unicode("hello"); }, function() { return md5_string_unicode(constant_folding_rt("hello")); });
		constant_folding_check("md5_string_unicode(\"😀a\")", function() { return md5_string_unicode("😀a"); }, function() { return md5_string_unicode(constant_folding_rt("😀a")); });
		constant_folding_check("base64_encode(\"hello\")", function() { return base64_encode("hello"); }, function() { return base64_encode(constant_folding_rt("hello")); });
		constant_folding_check("base64_encode(\"\")", function() { return base64_encode(""); }, function() { return base64_encode(constant_folding_rt("")); });
		constant_folding_check("base64_encode(\"héllo\")", function() { return base64_encode("héllo"); }, function() { return base64_encode(constant_folding_rt("héllo")); });
		constant_folding_check("base64_encode(\"ab\")", function() { return base64_encode("ab"); }, function() { return base64_encode(constant_folding_rt("ab")); });
		constant_folding_check("base64_encode(\"a\")", function() { return base64_encode("a"); }, function() { return base64_encode(constant_folding_rt("a")); });
		constant_folding_check("base64_decode(\"aGVsbG8=\")", function() { return base64_decode("aGVsbG8="); }, function() { return base64_decode(constant_folding_rt("aGVsbG8=")); });
		constant_folding_check("base64_decode(\"aGVsbG8\")", function() { return base64_decode("aGVsbG8"); }, function() { return base64_decode(constant_folding_rt("aGVsbG8")); });
		constant_folding_check("base64_decode(\"aGk\")", function() { return base64_decode("aGk"); }, function() { return base64_decode(constant_folding_rt("aGk")); });
		constant_folding_check("base64_decode(\"!!\")", function() { return base64_decode("!!"); }, function() { return base64_decode(constant_folding_rt("!!")); });
		constant_folding_check("base64_decode(\"aGVs*bG8\")", function() { return base64_decode("aGVs*bG8"); }, function() { return base64_decode(constant_folding_rt("aGVs*bG8")); });
		constant_folding_check("base64_decode(\"AA==\")", function() { return base64_decode("AA=="); }, function() { return base64_decode(constant_folding_rt("AA==")); });
		constant_folding_check("base64_decode(\"aMOpbGxv\")", function() { return base64_decode("aMOpbGxv"); }, function() { return base64_decode(constant_folding_rt("aMOpbGxv")); });
		constant_folding_check("base64_decode(\"a\")", function() { return base64_decode("a"); }, function() { return base64_decode(constant_folding_rt("a")); });
	});

	addFact("constant_folding_test #20", function() {
		
		// Check that merge_colour and make_colour_hsv match the runtime
		constant_folding_check("merge_colour(c_red, c_blue, 0.5)", function() { return merge_colour(c_red, c_blue, 0.5); }, function() { return merge_colour(constant_folding_rt(c_red), constant_folding_rt(c_blue), constant_folding_rt(0.5)); });
		constant_folding_check("merge_colour(16744512, 1056816, 0.25)", function() { return merge_colour(16744512, 1056816, 0.25); }, function() { return merge_colour(constant_folding_rt(16744512), constant_folding_rt(1056816), constant_folding_rt(0.25)); });
		constant_folding_check("merge_colour(255, 65280, 1.5)", function() { return merge_colour(255, 65280, 1.5); }, function() { return merge_colour(constant_folding_rt(255), constant_folding_rt(65280), constant_folding_rt(1.5)); });
		constant_folding_check("merge_colour(255, 65280, -0.5)", function() { return merge_colour(255, 65280, -0.5); }, function() { return merge_colour(constant_folding_rt(255), constant_folding_rt(65280), constant_folding_rt(-0.5)); });
		constant_folding_check("merge_colour(255, 65280, 0.3)", function() { return merge_colour(255, 65280, 0.3); }, function() { return merge_colour(constant_folding_rt(255), constant_folding_rt(65280), constant_folding_rt(0.3)); });
		constant_folding_check("merge_color(255, 16711680, 0.75)", function() { return merge_color(255, 16711680, 0.75); }, function() { return merge_color(constant_folding_rt(255), constant_folding_rt(16711680), constant_folding_rt(0.75)); });
		constant_folding_check("make_colour_hsv(0, 0, 0)", function() { return make_colour_hsv(0, 0, 0); }, function() { return make_colour_hsv(constant_folding_rt(0), constant_folding_rt(0), constant_folding_rt(0)); });
		constant_folding_check("make_colour_hsv(128, 255, 255)", function() { return make_colour_hsv(128, 255, 255); }, function() { return make_colour_hsv(constant_folding_rt(128), constant_folding_rt(255), constant_folding_rt(255)); });
		constant_folding_check("make_colour_hsv(255, 255, 255)", function() { return make_colour_hsv(255, 255, 255); }, function() { return make_colour_hsv(constant_folding_rt(255), constant_folding_rt(255), constant_folding_rt(255)); });
		constant_folding_check("make_colour_hsv(300, -5, 128)", function() { return make_colour_hsv(300, -5, 128); }, function() { return make_colour_hsv(constant_folding_rt(300), constant_folding_rt(-5), constant_folding_rt(128)); });
		constant_folding_check("make_colour_hsv(37.5, 200.2, 100.9)", function() { return make_colour_hsv(37.5, 200.2, 100.9); }, function() { return make_colour_hsv(constant_folding_rt(37.5), constant_folding_rt(200.2), constant_folding_rt(100.9)); });
		constant_folding_check("make_colour_hsv(42, 128, 200)", function() { return make_colour_hsv(42, 128, 200); }, function() { return make_colour_hsv(constant_folding_rt(42), constant_folding_rt(128), constant_folding_rt(200)); });
		constant_folding_check("make_colour_hsv(170, 85, 51)", function() { return make_colour_hsv(170, 85, 51); }, function() { return make_colour_hsv(constant_folding_rt(170), constant_folding_rt(85), constant_folding_rt(51)); });
		constant_folding_check("make_color_hsv(85, 255, 128)", function() { return make_color_hsv(85, 255, 128); }, function() { return make_color_hsv(constant_folding_rt(85), constant_folding_rt(255), constant_folding_rt(128)); });
		constant_folding_check("merge_colour(5308645, 5250375, 0.1)", function() { return merge_colour(5308645, 5250375, 0.1); }, function() { return merge_colour(constant_folding_rt(5308645), constant_folding_rt(5250375), constant_folding_rt(0.1)); });
		constant_folding_check("merge_colour(4491559, 13667777, -0.024)", function() { return merge_colour(4491559, 13667777, -0.024); }, function() { return merge_colour(constant_folding_rt(4491559), constant_folding_rt(13667777), constant_folding_rt(-0.024)); });
		constant_folding_check("merge_colour(3799279, 2991072, 0.533)", function() { return merge_colour(3799279, 2991072, 0.533); }, function() { return merge_colour(constant_folding_rt(3799279), constant_folding_rt(2991072), constant_folding_rt(0.533)); });
		constant_folding_check("merge_colour(15727746, 6183788, -0.36)", function() { return merge_colour(15727746, 6183788, -0.36); }, function() { return merge_colour(constant_folding_rt(15727746), constant_folding_rt(6183788), constant_folding_rt(-0.36)); });
		constant_folding_check("merge_colour(6316061, 11118238, 0.29)", function() { return merge_colour(6316061, 11118238, 0.29); }, function() { return merge_colour(constant_folding_rt(6316061), constant_folding_rt(11118238), constant_folding_rt(0.29)); });
		constant_folding_check("merge_colour(3718490, 8358364, 0.2796)", function() { return merge_colour(3718490, 8358364, 0.2796); }, function() { return merge_colour(constant_folding_rt(3718490), constant_folding_rt(8358364), constant_folding_rt(0.2796)); });
		constant_folding_check("merge_colour(16161067, 8879570, 1.2)", function() { return merge_colour(16161067, 8879570, 1.2); }, function() { return merge_colour(constant_folding_rt(16161067), constant_folding_rt(8879570), constant_folding_rt(1.2)); });
		constant_folding_check("merge_colour(11335858, 3110174, -0.05)", function() { return merge_colour(11335858, 3110174, -0.05); }, function() { return merge_colour(constant_folding_rt(11335858), constant_folding_rt(3110174), constant_folding_rt(-0.05)); });
		constant_folding_check("merge_colour(15120258, 8529513, 1.345)", function() { return merge_colour(15120258, 8529513, 1.345); }, function() { return merge_colour(constant_folding_rt(15120258), constant_folding_rt(8529513), constant_folding_rt(1.345)); });
		constant_folding_check("merge_colour(11809748, 15744637, -0.4)", function() { return merge_colour(11809748, 15744637, -0.4); }, function() { return merge_colour(constant_folding_rt(11809748), constant_folding_rt(15744637), constant_folding_rt(-0.4)); });
		constant_folding_check("merge_colour(2853742, 13327947, -0.2303)", function() { return merge_colour(2853742, 13327947, -0.2303); }, function() { return merge_colour(constant_folding_rt(2853742), constant_folding_rt(13327947), constant_folding_rt(-0.2303)); });
		constant_folding_check("merge_colour(9347734, 2879278, 0.31)", function() { return merge_colour(9347734, 2879278, 0.31); }, function() { return merge_colour(constant_folding_rt(9347734), constant_folding_rt(2879278), constant_folding_rt(0.31)); });
		constant_folding_check("merge_colour(14871869, 9328232, 1.225)", function() { return merge_colour(14871869, 9328232, 1.225); }, function() { return merge_colour(constant_folding_rt(14871869), constant_folding_rt(9328232), constant_folding_rt(1.225)); });
		constant_folding_check("merge_colour(8419625, 9307851, -0.0814)", function() { return merge_colour(8419625, 9307851, -0.0814); }, function() { return merge_colour(constant_folding_rt(8419625), constant_folding_rt(9307851), constant_folding_rt(-0.0814)); });
		constant_folding_check("merge_colour(5919377, 8480711, 1.04)", function() { return merge_colour(5919377, 8480711, 1.04); }, function() { return merge_colour(constant_folding_rt(5919377), constant_folding_rt(8480711), constant_folding_rt(1.04)); });
		constant_folding_check("merge_colour(8141498, 14497512, 1.3)", function() { return merge_colour(8141498, 14497512, 1.3); }, function() { return merge_colour(constant_folding_rt(8141498), constant_folding_rt(14497512), constant_folding_rt(1.3)); });
		constant_folding_check("merge_colour(15989837, 7674276, -0.1)", function() { return merge_colour(15989837, 7674276, -0.1); }, function() { return merge_colour(constant_folding_rt(15989837), constant_folding_rt(7674276), constant_folding_rt(-0.1)); });
		constant_folding_check("merge_colour(4003411, 3406801, 1.2487)", function() { return merge_colour(4003411, 3406801, 1.2487); }, function() { return merge_colour(constant_folding_rt(4003411), constant_folding_rt(3406801), constant_folding_rt(1.2487)); });
		constant_folding_check("merge_colour(6842498, 3271738, -0.1)", function() { return merge_colour(6842498, 3271738, -0.1); }, function() { return merge_colour(constant_folding_rt(6842498), constant_folding_rt(3271738), constant_folding_rt(-0.1)); });
		constant_folding_check("merge_colour(12665748, 1405546, 0.9)", function() { return merge_colour(12665748, 1405546, 0.9); }, function() { return merge_colour(constant_folding_rt(12665748), constant_folding_rt(1405546), constant_folding_rt(0.9)); });
		constant_folding_check("merge_colour(13863831, 15789100, -0.11)", function() { return merge_colour(13863831, 15789100, -0.11); }, function() { return merge_colour(constant_folding_rt(13863831), constant_folding_rt(15789100), constant_folding_rt(-0.11)); });
		constant_folding_check("merge_colour(9989161, 11131550, 0.3)", function() { return merge_colour(9989161, 11131550, 0.3); }, function() { return merge_colour(constant_folding_rt(9989161), constant_folding_rt(11131550), constant_folding_rt(0.3)); });
		constant_folding_check("merge_colour(12857633, 2371339, 0.63)", function() { return merge_colour(12857633, 2371339, 0.63); }, function() { return merge_colour(constant_folding_rt(12857633), constant_folding_rt(2371339), constant_folding_rt(0.63)); });
		constant_folding_check("merge_colour(1224887, 3627689, 0.13)", function() { return merge_colour(1224887, 3627689, 0.13); }, function() { return merge_colour(constant_folding_rt(1224887), constant_folding_rt(3627689), constant_folding_rt(0.13)); });
		constant_folding_check("merge_colour(2750475, 1098201, 0.9365)", function() { return merge_colour(2750475, 1098201, 0.9365); }, function() { return merge_colour(constant_folding_rt(2750475), constant_folding_rt(1098201), constant_folding_rt(0.9365)); });
		constant_folding_check("merge_colour(4383472, 79937, 0.8)", function() { return merge_colour(4383472, 79937, 0.8); }, function() { return merge_colour(constant_folding_rt(4383472), constant_folding_rt(79937), constant_folding_rt(0.8)); });
		constant_folding_check("merge_colour(8208520, 11331050, -0.4282)", function() { return merge_colour(8208520, 11331050, -0.4282); }, function() { return merge_colour(constant_folding_rt(8208520), constant_folding_rt(11331050), constant_folding_rt(-0.4282)); });
		constant_folding_check("merge_colour(15351960, 7482760, 1.46)", function() { return merge_colour(15351960, 7482760, 1.46); }, function() { return merge_colour(constant_folding_rt(15351960), constant_folding_rt(7482760), constant_folding_rt(1.46)); });
		constant_folding_check("merge_colour(10983335, 2043595, 0.4727)", function() { return merge_colour(10983335, 2043595, 0.4727); }, function() { return merge_colour(constant_folding_rt(10983335), constant_folding_rt(2043595), constant_folding_rt(0.4727)); });
		constant_folding_check("merge_colour(1631799, 16660479, -0.2)", function() { return merge_colour(1631799, 16660479, -0.2); }, function() { return merge_colour(constant_folding_rt(1631799), constant_folding_rt(16660479), constant_folding_rt(-0.2)); });
		constant_folding_check("make_colour_hsv(103.0, 202.17, 244.1)", function() { return make_colour_hsv(103.0, 202.17, 244.1); }, function() { return make_colour_hsv(constant_folding_rt(103.0), constant_folding_rt(202.17), constant_folding_rt(244.1)); });
		constant_folding_check("make_colour_hsv(181.01, 181.48, 184.78)", function() { return make_colour_hsv(181.01, 181.48, 184.78); }, function() { return make_colour_hsv(constant_folding_rt(181.01), constant_folding_rt(181.48), constant_folding_rt(184.78)); });
		constant_folding_check("make_colour_hsv(198.0, 259.0, 193.0)", function() { return make_colour_hsv(198.0, 259.0, 193.0); }, function() { return make_colour_hsv(constant_folding_rt(198.0), constant_folding_rt(259.0), constant_folding_rt(193.0)); });
		constant_folding_check("make_colour_hsv(79.8, 34.43, 266.9)", function() { return make_colour_hsv(79.8, 34.43, 266.9); }, function() { return make_colour_hsv(constant_folding_rt(79.8), constant_folding_rt(34.43), constant_folding_rt(266.9)); });
		constant_folding_check("make_colour_hsv(176.68, 55.4, 138.33)", function() { return make_colour_hsv(176.68, 55.4, 138.33); }, function() { return make_colour_hsv(constant_folding_rt(176.68), constant_folding_rt(55.4), constant_folding_rt(138.33)); });
		constant_folding_check("make_colour_hsv(241.15, 205.2, -8.0)", function() { return make_colour_hsv(241.15, 205.2, -8.0); }, function() { return make_colour_hsv(constant_folding_rt(241.15), constant_folding_rt(205.2), constant_folding_rt(-8.0)); });
		constant_folding_check("make_colour_hsv(102.1, 193.0, 138.5)", function() { return make_colour_hsv(102.1, 193.0, 138.5); }, function() { return make_colour_hsv(constant_folding_rt(102.1), constant_folding_rt(193.0), constant_folding_rt(138.5)); });
		constant_folding_check("make_colour_hsv(208.0, 237.0, 12.5)", function() { return make_colour_hsv(208.0, 237.0, 12.5); }, function() { return make_colour_hsv(constant_folding_rt(208.0), constant_folding_rt(237.0), constant_folding_rt(12.5)); });
		constant_folding_check("make_colour_hsv(126.0, 231.7, 115.87)", function() { return make_colour_hsv(126.0, 231.7, 115.87); }, function() { return make_colour_hsv(constant_folding_rt(126.0), constant_folding_rt(231.7), constant_folding_rt(115.87)); });
		constant_folding_check("make_colour_hsv(109.37, 95.13, 14.86)", function() { return make_colour_hsv(109.37, 95.13, 14.86); }, function() { return make_colour_hsv(constant_folding_rt(109.37), constant_folding_rt(95.13), constant_folding_rt(14.86)); });
		constant_folding_check("make_colour_hsv(214.61, 178.0, 119.15)", function() { return make_colour_hsv(214.61, 178.0, 119.15); }, function() { return make_colour_hsv(constant_folding_rt(214.61), constant_folding_rt(178.0), constant_folding_rt(119.15)); });
		constant_folding_check("make_colour_hsv(88.0, 162.0, 147.42)", function() { return make_colour_hsv(88.0, 162.0, 147.42); }, function() { return make_colour_hsv(constant_folding_rt(88.0), constant_folding_rt(162.0), constant_folding_rt(147.42)); });
		constant_folding_check("make_colour_hsv(84.65, 111.2, 148.0)", function() { return make_colour_hsv(84.65, 111.2, 148.0); }, function() { return make_colour_hsv(constant_folding_rt(84.65), constant_folding_rt(111.2), constant_folding_rt(148.0)); });
		constant_folding_check("make_colour_hsv(-3.0, 17.4, 134.4)", function() { return make_colour_hsv(-3.0, 17.4, 134.4); }, function() { return make_colour_hsv(constant_folding_rt(-3.0), constant_folding_rt(17.4), constant_folding_rt(134.4)); });
		constant_folding_check("make_colour_hsv(223.56, 230.17, 133.05)", function() { return make_colour_hsv(223.56, 230.17, 133.05); }, function() { return make_colour_hsv(constant_folding_rt(223.56), constant_folding_rt(230.17), constant_folding_rt(133.05)); });
		constant_folding_check("make_colour_hsv(264.0, 0.62, 62.9)", function() { return make_colour_hsv(264.0, 0.62, 62.9); }, function() { return make_colour_hsv(constant_folding_rt(264.0), constant_folding_rt(0.62), constant_folding_rt(62.9)); });
		constant_folding_check("make_colour_hsv(95.98, -8.99, 181.71)", function() { return make_colour_hsv(95.98, -8.99, 181.71); }, function() { return make_colour_hsv(constant_folding_rt(95.98), constant_folding_rt(-8.99), constant_folding_rt(181.71)); });
		constant_folding_check("make_colour_hsv(69.0, 17.23, 12.0)", function() { return make_colour_hsv(69.0, 17.23, 12.0); }, function() { return make_colour_hsv(constant_folding_rt(69.0), constant_folding_rt(17.23), constant_folding_rt(12.0)); });
		constant_folding_check("make_colour_hsv(121.96, 268.0, 8.0)", function() { return make_colour_hsv(121.96, 268.0, 8.0); }, function() { return make_colour_hsv(constant_folding_rt(121.96), constant_folding_rt(268.0), constant_folding_rt(8.0)); });
		constant_folding_check("make_colour_hsv(266.59, 0.05, 166.1)", function() { return make_colour_hsv(266.59, 0.05, 166.1); }, function() { return make_colour_hsv(constant_folding_rt(266.59), constant_folding_rt(0.05), constant_folding_rt(166.1)); });
		constant_folding_check("make_colour_hsv(201.22, 29.43, 0.01)", function() { return make_colour_hsv(201.22, 29.43, 0.01); }, function() { return make_colour_hsv(constant_folding_rt(201.22), constant_folding_rt(29.43), constant_folding_rt(0.01)); });
		constant_folding_check("make_colour_hsv(218.0, 68.45, 91.4)", function() { return make_colour_hsv(218.0, 68.45, 91.4); }, function() { return make_colour_hsv(constant_folding_rt(218.0), constant_folding_rt(68.45), constant_folding_rt(91.4)); });
		constant_folding_check("make_colour_hsv(227.43, 5.2, 99.8)", function() { return make_colour_hsv(227.43, 5.2, 99.8); }, function() { return make_colour_hsv(constant_folding_rt(227.43), constant_folding_rt(5.2), constant_folding_rt(99.8)); });
		constant_folding_check("make_colour_hsv(221.8, 175.64, 22.0)", function() { return make_colour_hsv(221.8, 175.64, 22.0); }, function() { return make_colour_hsv(constant_folding_rt(221.8), constant_folding_rt(175.64), constant_folding_rt(22.0)); });
		constant_folding_check("make_colour_hsv(169.0, 158.0, 153.1)", function() { return make_colour_hsv(169.0, 158.0, 153.1); }, function() { return make_colour_hsv(constant_folding_rt(169.0), constant_folding_rt(158.0), constant_folding_rt(153.1)); });
		constant_folding_check("make_colour_hsv(252.27, 42.0, 154.0)", function() { return make_colour_hsv(252.27, 42.0, 154.0); }, function() { return make_colour_hsv(constant_folding_rt(252.27), constant_folding_rt(42.0), constant_folding_rt(154.0)); });
		constant_folding_check("make_colour_hsv(77.3, 222.0, 62.0)", function() { return make_colour_hsv(77.3, 222.0, 62.0); }, function() { return make_colour_hsv(constant_folding_rt(77.3), constant_folding_rt(222.0), constant_folding_rt(62.0)); });
		constant_folding_check("make_colour_hsv(178.97, 66.3, 115.38)", function() { return make_colour_hsv(178.97, 66.3, 115.38); }, function() { return make_colour_hsv(constant_folding_rt(178.97), constant_folding_rt(66.3), constant_folding_rt(115.38)); });
		constant_folding_check("make_colour_hsv(163.95, 57.8, 128.0)", function() { return make_colour_hsv(163.95, 57.8, 128.0); }, function() { return make_colour_hsv(constant_folding_rt(163.95), constant_folding_rt(57.8), constant_folding_rt(128.0)); });
		constant_folding_check("make_colour_hsv(6.31, 257.2, 182.19)", function() { return make_colour_hsv(6.31, 257.2, 182.19); }, function() { return make_colour_hsv(constant_folding_rt(6.31), constant_folding_rt(257.2), constant_folding_rt(182.19)); });
	});

	addFact("constant_folding_test #21", function() {
		
		// Check that the functions that were already folded match the runtime: make_colour_rgb, string_lower and string_upper (only ASCII is folded) (GameMaker-Bugs#14968)
		constant_folding_check("make_colour_rgb(255, 128, 64)", function() { return make_colour_rgb(255, 128, 64); }, function() { return make_colour_rgb(constant_folding_rt(255), constant_folding_rt(128), constant_folding_rt(64)); });
		constant_folding_check("make_colour_rgb(300, -5, 2.7)", function() { return make_colour_rgb(300, -5, 2.7); }, function() { return make_colour_rgb(constant_folding_rt(300), constant_folding_rt(-5), constant_folding_rt(2.7)); });
		constant_folding_check("make_colour_rgb(1.9, 2.9, 3.9)", function() { return make_colour_rgb(1.9, 2.9, 3.9); }, function() { return make_colour_rgb(constant_folding_rt(1.9), constant_folding_rt(2.9), constant_folding_rt(3.9)); });
		constant_folding_check("make_colour_rgb(-1.5, 0, 0)", function() { return make_colour_rgb(-1.5, 0, 0); }, function() { return make_colour_rgb(constant_folding_rt(-1.5), constant_folding_rt(0), constant_folding_rt(0)); });
		constant_folding_check("make_color_rgb(1, 2, 3)", function() { return make_color_rgb(1, 2, 3); }, function() { return make_color_rgb(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3)); });
		constant_folding_check("string_lower(\"HeLLo\")", function() { return string_lower("HeLLo"); }, function() { return string_lower(constant_folding_rt("HeLLo")); });
		constant_folding_check("string_lower(\"HÉLLO WÖRLD\")", function() { return string_lower("HÉLLO WÖRLD"); }, function() { return string_lower(constant_folding_rt("HÉLLO WÖRLD")); });
		constant_folding_check("string_lower(\"İSTANBUL\")", function() { return string_lower("İSTANBUL"); }, function() { return string_lower(constant_folding_rt("İSTANBUL")); });
		constant_folding_check("string_lower(\"ΣΑΣ Ω\")", function() { return string_lower("ΣΑΣ Ω"); }, function() { return string_lower(constant_folding_rt("ΣΑΣ Ω")); });
		constant_folding_check("string_lower(12)", function() { return string_lower(12); }, function() { return string_lower(constant_folding_rt(12)); });
		constant_folding_check("string_lower(true)", function() { return string_lower(true); }, function() { return string_lower(constant_folding_rt(true)); });
		constant_folding_check("string_lower(1.5)", function() { return string_lower(1.5); }, function() { return string_lower(constant_folding_rt(1.5)); });
		constant_folding_check("string_upper(\"hello\")", function() { return string_upper("hello"); }, function() { return string_upper(constant_folding_rt("hello")); });
		constant_folding_check("string_upper(\"héllo wörld\")", function() { return string_upper("héllo wörld"); }, function() { return string_upper(constant_folding_rt("héllo wörld")); });
		constant_folding_check("string_upper(\"straße\")", function() { return string_upper("straße"); }, function() { return string_upper(constant_folding_rt("straße")); });
		constant_folding_check("string_upper(\"ǆ ı ÿ\")", function() { return string_upper("ǆ ı ÿ"); }, function() { return string_upper(constant_folding_rt("ǆ ı ÿ")); });
		constant_folding_check("string_upper(\"ﬁ\")", function() { return string_upper("ﬁ"); }, function() { return string_upper(constant_folding_rt("ﬁ")); });
		constant_folding_check("string_upper(\"ω σ\")", function() { return string_upper("ω σ"); }, function() { return string_upper(constant_folding_rt("ω σ")); });
	});

	addFact("constant_folding_test #22", function() {
		
		// Check ceil, floor, round, degtorad, radtodeg, abs, sign, frac and sqr
		constant_folding_check("ceil(1.5)", function() { return ceil(1.5); }, function() { return ceil(constant_folding_rt(1.5)); });
		constant_folding_check("ceil(-1.5)", function() { return ceil(-1.5); }, function() { return ceil(constant_folding_rt(-1.5)); });
		constant_folding_check("ceil(-0.5)", function() { return ceil(-0.5); }, function() { return ceil(constant_folding_rt(-0.5)); });
		constant_folding_check("floor(-0.5)", function() { return floor(-0.5); }, function() { return floor(constant_folding_rt(-0.5)); });
		constant_folding_check("floor(1.5)", function() { return floor(1.5); }, function() { return floor(constant_folding_rt(1.5)); });
		constant_folding_check("round(2.5)", function() { return round(2.5); }, function() { return round(constant_folding_rt(2.5)); });
		constant_folding_check("round(3.5)", function() { return round(3.5); }, function() { return round(constant_folding_rt(3.5)); });
		constant_folding_check("round(-2.5)", function() { return round(-2.5); }, function() { return round(constant_folding_rt(-2.5)); });
		constant_folding_check("round(-0.4)", function() { return round(-0.4); }, function() { return round(constant_folding_rt(-0.4)); });
		constant_folding_check("round(0.5)", function() { return round(0.5); }, function() { return round(constant_folding_rt(0.5)); });
		constant_folding_check("round(100000000000000000000)", function() { return round(100000000000000000000); }, function() { return round(constant_folding_rt(100000000000000000000)); });
		constant_folding_check("round(infinity)", function() { return round(infinity); }, function() { return round(constant_folding_rt(infinity)); });
		constant_folding_check("degtorad(180)", function() { return degtorad(180); }, function() { return degtorad(constant_folding_rt(180)); });
		constant_folding_check("degtorad(1)", function() { return degtorad(1); }, function() { return degtorad(constant_folding_rt(1)); });
		constant_folding_check("degtorad(0.1)", function() { return degtorad(0.1); }, function() { return degtorad(constant_folding_rt(0.1)); });
		constant_folding_check("radtodeg(1)", function() { return radtodeg(1); }, function() { return radtodeg(constant_folding_rt(1)); });
		constant_folding_check("radtodeg(pi)", function() { return radtodeg(pi); }, function() { return radtodeg(constant_folding_rt(pi)); });
		constant_folding_check("radtodeg(0.3)", function() { return radtodeg(0.3); }, function() { return radtodeg(constant_folding_rt(0.3)); });
		constant_folding_check("abs(-3)", function() { return abs(-3); }, function() { return abs(constant_folding_rt(-3)); });
		constant_folding_check("abs(-0)", function() { return abs(-0); }, function() { return abs(constant_folding_rt(-0)); });
		constant_folding_check("abs(-2.5)", function() { return abs(-2.5); }, function() { return abs(constant_folding_rt(-2.5)); });
		constant_folding_check("sign(-2)", function() { return sign(-2); }, function() { return sign(constant_folding_rt(-2)); });
		constant_folding_check("sign(0)", function() { return sign(0); }, function() { return sign(constant_folding_rt(0)); });
		constant_folding_check("sign(-0)", function() { return sign(-0); }, function() { return sign(constant_folding_rt(-0)); });
		constant_folding_check("sign(3)", function() { return sign(3); }, function() { return sign(constant_folding_rt(3)); });
		constant_folding_check("frac(2.75)", function() { return frac(2.75); }, function() { return frac(constant_folding_rt(2.75)); });
		constant_folding_check("frac(-2.75)", function() { return frac(-2.75); }, function() { return frac(constant_folding_rt(-2.75)); });
		constant_folding_check("frac(-2)", function() { return frac(-2); }, function() { return frac(constant_folding_rt(-2)); });
		constant_folding_check("frac(100000000000000000000)", function() { return frac(100000000000000000000); }, function() { return frac(constant_folding_rt(100000000000000000000)); });
		constant_folding_check("frac(0.1)", function() { return frac(0.1); }, function() { return frac(constant_folding_rt(0.1)); });
		constant_folding_check("frac(12345.678)", function() { return frac(12345.678); }, function() { return frac(constant_folding_rt(12345.678)); });
		constant_folding_check("sqr(3)", function() { return sqr(3); }, function() { return sqr(constant_folding_rt(3)); });
		constant_folding_check("sqr(-1.5)", function() { return sqr(-1.5); }, function() { return sqr(constant_folding_rt(-1.5)); });
		constant_folding_check("sqr(0.1)", function() { return sqr(0.1); }, function() { return sqr(constant_folding_rt(0.1)); });
	});

	addFact("constant_folding_test #23", function() {
		
		// Check colour_get_red, colour_get_green, colour_get_blue and colour_get_value
		constant_folding_check("colour_get_red(c_orange)", function() { return colour_get_red(c_orange); }, function() { return colour_get_red(constant_folding_rt(c_orange)); });
		constant_folding_check("colour_get_red(-1)", function() { return colour_get_red(-1); }, function() { return colour_get_red(constant_folding_rt(-1)); });
		constant_folding_check("colour_get_red(-2.5)", function() { return colour_get_red(-2.5); }, function() { return colour_get_red(constant_folding_rt(-2.5)); });
		constant_folding_check("colour_get_red(4294967551)", function() { return colour_get_red(4294967551); }, function() { return colour_get_red(constant_folding_rt(4294967551)); });
		constant_folding_check("colour_get_green(1900000000)", function() { return colour_get_green(1900000000); }, function() { return colour_get_green(constant_folding_rt(1900000000)); });
		constant_folding_check("colour_get_blue(16777215.7)", function() { return colour_get_blue(16777215.7); }, function() { return colour_get_blue(constant_folding_rt(16777215.7)); });
		constant_folding_check("color_get_red(255.9)", function() { return color_get_red(255.9); }, function() { return color_get_red(constant_folding_rt(255.9)); });
		constant_folding_check("colour_get_value(c_orange)", function() { return colour_get_value(c_orange); }, function() { return colour_get_value(constant_folding_rt(c_orange)); });
		constant_folding_check("colour_get_value(77)", function() { return colour_get_value(77); }, function() { return colour_get_value(constant_folding_rt(77)); });
		constant_folding_check("colour_get_value(12345678)", function() { return colour_get_value(12345678); }, function() { return colour_get_value(constant_folding_rt(12345678)); });
		constant_folding_check("colour_get_value(0)", function() { return colour_get_value(0); }, function() { return colour_get_value(constant_folding_rt(0)); });
		constant_folding_check("colour_get_value(3355443)", function() { return colour_get_value(3355443); }, function() { return colour_get_value(constant_folding_rt(3355443)); });
		constant_folding_check("colour_get_value(10066329)", function() { return colour_get_value(10066329); }, function() { return colour_get_value(constant_folding_rt(10066329)); });
	});

	addFact("constant_folding_test #24", function() {
		
		// Check string_concat, string_join and string with placeholders (the runtime leaves a placeholder with no value and {0:X} as they are)
		constant_folding_check("string_concat(\"a\", 1, 2.5, true, undefined)", function() { return string_concat("a", 1, 2.5, true, undefined); }, function() { return string_concat(constant_folding_rt("a"), constant_folding_rt(1), constant_folding_rt(2.5), constant_folding_rt(true), constant_folding_rt(undefined)); });
		constant_folding_check("string_concat(\"x\")", function() { return string_concat("x"); }, function() { return string_concat(constant_folding_rt("x")); });
		constant_folding_check("string_concat(1.005)", function() { return string_concat(1.005); }, function() { return string_concat(constant_folding_rt(1.005)); });
		constant_folding_check("string_concat(0.125)", function() { return string_concat(0.125); }, function() { return string_concat(constant_folding_rt(0.125)); });
		constant_folding_check("string_concat(0.375, \"|\")", function() { return string_concat(0.375, "|"); }, function() { return string_concat(constant_folding_rt(0.375), constant_folding_rt("|")); });
		constant_folding_check("string_concat(-0.001, \"|\")", function() { return string_concat(-0.001, "|"); }, function() { return string_concat(constant_folding_rt(-0.001), constant_folding_rt("|")); });
		constant_folding_check("string_concat(1234567.891, \"|\")", function() { return string_concat(1234567.891, "|"); }, function() { return string_concat(constant_folding_rt(1234567.891), constant_folding_rt("|")); });
		constant_folding_check("string_concat(100000000000000000000, \"|\")", function() { return string_concat(100000000000000000000, "|"); }, function() { return string_concat(constant_folding_rt(100000000000000000000), constant_folding_rt("|")); });
		constant_folding_check("string_concat(-0, \"|\")", function() { return string_concat(-0, "|"); }, function() { return string_concat(constant_folding_rt(-0), constant_folding_rt("|")); });
		constant_folding_check("string_join(\", \", \"a\", \"b\", 3)", function() { return string_join(", ", "a", "b", 3); }, function() { return string_join(constant_folding_rt(", "), constant_folding_rt("a"), constant_folding_rt("b"), constant_folding_rt(3)); });
		constant_folding_check("string_join(\"-\")", function() { return string_join("-"); }, function() { return string_join(constant_folding_rt("-")); });
		constant_folding_check("string_join(\"-\", \"only\")", function() { return string_join("-", "only"); }, function() { return string_join(constant_folding_rt("-"), constant_folding_rt("only")); });
		constant_folding_check("string_join(1.5, \"a\", \"b\")", function() { return string_join(1.5, "a", "b"); }, function() { return string_join(constant_folding_rt(1.5), constant_folding_rt("a"), constant_folding_rt("b")); });
		constant_folding_check("string(\"{0} and {1}\", \"a\", \"b\")", function() { return string("{0} and {1}", "a", "b"); }, function() { return string(constant_folding_rt("{0} and {1}"), constant_folding_rt("a"), constant_folding_rt("b")); });
		constant_folding_check("string(\"{1}{0}\", 1, 2)", function() { return string("{1}{0}", 1, 2); }, function() { return string(constant_folding_rt("{1}{0}"), constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("string(\"{2}\", \"a\")", function() { return string("{2}", "a"); }, function() { return string(constant_folding_rt("{2}"), constant_folding_rt("a")); });
		constant_folding_check("string(\"{{0}} {0}\", \"x\")", function() { return string("{{0}} {0}", "x"); }, function() { return string(constant_folding_rt("{{0}} {0}"), constant_folding_rt("x")); });
		constant_folding_check("string(\"{0:X}\", 255)", function() { return string("{0:X}", 255); }, function() { return string(constant_folding_rt("{0:X}"), constant_folding_rt(255)); });
		constant_folding_check("string(\"{ 0}\", 1)", function() { return string("{ 0}", 1); }, function() { return string(constant_folding_rt("{ 0}"), constant_folding_rt(1)); });
		constant_folding_check("string(\"}{\", 1)", function() { return string("}{", 1); }, function() { return string(constant_folding_rt("}{"), constant_folding_rt(1)); });
		constant_folding_check("string(\"{0}{10}\", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)", function() { return string("{0}{10}", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11); }, function() { return string(constant_folding_rt("{0}{10}"), constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3), constant_folding_rt(4), constant_folding_rt(5), constant_folding_rt(6), constant_folding_rt(7), constant_folding_rt(8), constant_folding_rt(9), constant_folding_rt(10), constant_folding_rt(11)); });
		constant_folding_check("string(\"{0}\", \"{1}\", \"b\")", function() { return string("{0}", "{1}", "b"); }, function() { return string(constant_folding_rt("{0}"), constant_folding_rt("{1}"), constant_folding_rt("b")); });
		constant_folding_check("string(\"a{\", 1)", function() { return string("a{", 1); }, function() { return string(constant_folding_rt("a{"), constant_folding_rt(1)); });
		constant_folding_check("string(\"{0}\", 2.5)", function() { return string("{0}", 2.5); }, function() { return string(constant_folding_rt("{0}"), constant_folding_rt(2.5)); });
		constant_folding_check("string(\"{0}\", true)", function() { return string("{0}", true); }, function() { return string(constant_folding_rt("{0}"), constant_folding_rt(true)); });
		constant_folding_check("string(1.5)", function() { return string(1.5); }, function() { return string(constant_folding_rt(1.5)); });
		constant_folding_check("string(true)", function() { return string(true); }, function() { return string(constant_folding_rt(true)); });
		constant_folding_check("string(undefined)", function() { return string(undefined); }, function() { return string(constant_folding_rt(undefined)); });
		constant_folding_check("string(5, 6)", function() { return string(5, 6); }, function() { return string(constant_folding_rt(5), constant_folding_rt(6)); });
		constant_folding_check("string(0.125)", function() { return string(0.125); }, function() { return string(constant_folding_rt(0.125)); });
	});

	addFact("constant_folding_test #25", function() {
		
		// Check min, max, mean, median and clamp
		constant_folding_check("min(1, 2)", function() { return min(1, 2); }, function() { return min(constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("min(3, NaN)", function() { return min(3, NaN); }, function() { return min(constant_folding_rt(3), constant_folding_rt(NaN)); });
		constant_folding_check("min(NaN, 3)", function() { return min(NaN, 3); }, function() { return min(constant_folding_rt(NaN), constant_folding_rt(3)); });
		constant_folding_check("max(1, NaN)", function() { return max(1, NaN); }, function() { return max(constant_folding_rt(1), constant_folding_rt(NaN)); });
		constant_folding_check("min(5)", function() { return min(5); }, function() { return min(constant_folding_rt(5)); });
		constant_folding_check("max(-1, -2, -3)", function() { return max(-1, -2, -3); }, function() { return max(constant_folding_rt(-1), constant_folding_rt(-2), constant_folding_rt(-3)); });
		constant_folding_check("mean(1, 2, 4)", function() { return mean(1, 2, 4); }, function() { return mean(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(4)); });
		constant_folding_check("mean(0.1, 0.2)", function() { return mean(0.1, 0.2); }, function() { return mean(constant_folding_rt(0.1), constant_folding_rt(0.2)); });
		constant_folding_check("mean(0.1, 0.2, 0.3)", function() { return mean(0.1, 0.2, 0.3); }, function() { return mean(constant_folding_rt(0.1), constant_folding_rt(0.2), constant_folding_rt(0.3)); });
		constant_folding_check("median(3, 1, 2)", function() { return median(3, 1, 2); }, function() { return median(constant_folding_rt(3), constant_folding_rt(1), constant_folding_rt(2)); });
		constant_folding_check("median(4, 1, 3, 2)", function() { return median(4, 1, 3, 2); }, function() { return median(constant_folding_rt(4), constant_folding_rt(1), constant_folding_rt(3), constant_folding_rt(2)); });
		constant_folding_check("median(5)", function() { return median(5); }, function() { return median(constant_folding_rt(5)); });
		constant_folding_check("median(1, NaN, 3)", function() { return median(1, NaN, 3); }, function() { return median(constant_folding_rt(1), constant_folding_rt(NaN), constant_folding_rt(3)); });
		constant_folding_check("clamp(5, 0, 3)", function() { return clamp(5, 0, 3); }, function() { return clamp(constant_folding_rt(5), constant_folding_rt(0), constant_folding_rt(3)); });
		constant_folding_check("clamp(-1, 0, 3)", function() { return clamp(-1, 0, 3); }, function() { return clamp(constant_folding_rt(-1), constant_folding_rt(0), constant_folding_rt(3)); });
		constant_folding_check("clamp(NaN, 0, 3)", function() { return clamp(NaN, 0, 3); }, function() { return clamp(constant_folding_rt(NaN), constant_folding_rt(0), constant_folding_rt(3)); });
		constant_folding_check("clamp(2, 3, 1)", function() { return clamp(2, 3, 1); }, function() { return clamp(constant_folding_rt(2), constant_folding_rt(3), constant_folding_rt(1)); });
	});

	addFact("constant_folding_test #26", function() {
		
		// Check lerp, angle_difference (single precision), dot_product, dot_product_3d and point_distance
		constant_folding_check("lerp(0, 10, 0.5)", function() { return lerp(0, 10, 0.5); }, function() { return lerp(constant_folding_rt(0), constant_folding_rt(10), constant_folding_rt(0.5)); });
		constant_folding_check("lerp(1, 2, 3)", function() { return lerp(1, 2, 3); }, function() { return lerp(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3)); });
		constant_folding_check("lerp(0.1, 0.7, 0.3)", function() { return lerp(0.1, 0.7, 0.3); }, function() { return lerp(constant_folding_rt(0.1), constant_folding_rt(0.7), constant_folding_rt(0.3)); });
		constant_folding_check("angle_difference(10, 350)", function() { return angle_difference(10, 350); }, function() { return angle_difference(constant_folding_rt(10), constant_folding_rt(350)); });
		constant_folding_check("angle_difference(350, 10)", function() { return angle_difference(350, 10); }, function() { return angle_difference(constant_folding_rt(350), constant_folding_rt(10)); });
		constant_folding_check("angle_difference(0.1, 0.3)", function() { return angle_difference(0.1, 0.3); }, function() { return angle_difference(constant_folding_rt(0.1), constant_folding_rt(0.3)); });
		constant_folding_check("angle_difference(1000, -1000)", function() { return angle_difference(1000, -1000); }, function() { return angle_difference(constant_folding_rt(1000), constant_folding_rt(-1000)); });
		constant_folding_check("angle_difference(45.5, 12.25)", function() { return angle_difference(45.5, 12.25); }, function() { return angle_difference(constant_folding_rt(45.5), constant_folding_rt(12.25)); });
		constant_folding_check("angle_difference(720, 0)", function() { return angle_difference(720, 0); }, function() { return angle_difference(constant_folding_rt(720), constant_folding_rt(0)); });
		constant_folding_check("angle_difference(123.456, 7.89)", function() { return angle_difference(123.456, 7.89); }, function() { return angle_difference(constant_folding_rt(123.456), constant_folding_rt(7.89)); });
		constant_folding_check("dot_product(1, 2, 3, 4)", function() { return dot_product(1, 2, 3, 4); }, function() { return dot_product(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3), constant_folding_rt(4)); });
		constant_folding_check("dot_product(0.1, 0.2, 0.3, 0.4)", function() { return dot_product(0.1, 0.2, 0.3, 0.4); }, function() { return dot_product(constant_folding_rt(0.1), constant_folding_rt(0.2), constant_folding_rt(0.3), constant_folding_rt(0.4)); });
		constant_folding_check("dot_product_3d(1, 2, 3, 4, 5, 6)", function() { return dot_product_3d(1, 2, 3, 4, 5, 6); }, function() { return dot_product_3d(constant_folding_rt(1), constant_folding_rt(2), constant_folding_rt(3), constant_folding_rt(4), constant_folding_rt(5), constant_folding_rt(6)); });
		constant_folding_check("point_distance(0, 0, 3, 4)", function() { return point_distance(0, 0, 3, 4); }, function() { return point_distance(constant_folding_rt(0), constant_folding_rt(0), constant_folding_rt(3), constant_folding_rt(4)); });
		constant_folding_check("point_distance(0.1, 0.2, 0.3, 0.4)", function() { return point_distance(0.1, 0.2, 0.3, 0.4); }, function() { return point_distance(constant_folding_rt(0.1), constant_folding_rt(0.2), constant_folding_rt(0.3), constant_folding_rt(0.4)); });
		constant_folding_check("dot_product(261.1431, -346.917, 727.4171, 718.0)", function() { return dot_product(261.1431, -346.917, 727.4171, 718.0); }, function() { return dot_product(constant_folding_rt(261.1431), constant_folding_rt(-346.917), constant_folding_rt(727.4171), constant_folding_rt(718.0)); });
		constant_folding_check("dot_product(-324.302, -413.7028, -584.0, 320.9)", function() { return dot_product(-324.302, -413.7028, -584.0, 320.9); }, function() { return dot_product(constant_folding_rt(-324.302), constant_folding_rt(-413.7028), constant_folding_rt(-584.0), constant_folding_rt(320.9)); });
		constant_folding_check("dot_product(-175.4, -669.5121, 939.27, -897.7576)", function() { return dot_product(-175.4, -669.5121, 939.27, -897.7576); }, function() { return dot_product(constant_folding_rt(-175.4), constant_folding_rt(-669.5121), constant_folding_rt(939.27), constant_folding_rt(-897.7576)); });
		constant_folding_check("dot_product(39.3978, -587.4, 238.13, 296.3037)", function() { return dot_product(39.3978, -587.4, 238.13, 296.3037); }, function() { return dot_product(constant_folding_rt(39.3978), constant_folding_rt(-587.4), constant_folding_rt(238.13), constant_folding_rt(296.3037)); });
		constant_folding_check("dot_product(954.142, -649.002, 664.63, 689.4)", function() { return dot_product(954.142, -649.002, 664.63, 689.4); }, function() { return dot_product(constant_folding_rt(954.142), constant_folding_rt(-649.002), constant_folding_rt(664.63), constant_folding_rt(689.4)); });
		constant_folding_check("dot_product(-120.1, -564.83, -566.1568, 120.0)", function() { return dot_product(-120.1, -564.83, -566.1568, 120.0); }, function() { return dot_product(constant_folding_rt(-120.1), constant_folding_rt(-564.83), constant_folding_rt(-566.1568), constant_folding_rt(120.0)); });
		constant_folding_check("dot_product(644.211, -187.885, -609.0, -798.0)", function() { return dot_product(644.211, -187.885, -609.0, -798.0); }, function() { return dot_product(constant_folding_rt(644.211), constant_folding_rt(-187.885), constant_folding_rt(-609.0), constant_folding_rt(-798.0)); });
		constant_folding_check("dot_product(347.284, 737.0, -965.1, -814.1)", function() { return dot_product(347.284, 737.0, -965.1, -814.1); }, function() { return dot_product(constant_folding_rt(347.284), constant_folding_rt(737.0), constant_folding_rt(-965.1), constant_folding_rt(-814.1)); });
		constant_folding_check("dot_product(479.0, 385.0, 738.4, -799.6)", function() { return dot_product(479.0, 385.0, 738.4, -799.6); }, function() { return dot_product(constant_folding_rt(479.0), constant_folding_rt(385.0), constant_folding_rt(738.4), constant_folding_rt(-799.6)); });
		constant_folding_check("dot_product(-4.235, -869.71, -73.0, -367.0)", function() { return dot_product(-4.235, -869.71, -73.0, -367.0); }, function() { return dot_product(constant_folding_rt(-4.235), constant_folding_rt(-869.71), constant_folding_rt(-73.0), constant_folding_rt(-367.0)); });
		constant_folding_check("dot_product(-28.3, -282.7, 40.3669, -669.0)", function() { return dot_product(-28.3, -282.7, 40.3669, -669.0); }, function() { return dot_product(constant_folding_rt(-28.3), constant_folding_rt(-282.7), constant_folding_rt(40.3669), constant_folding_rt(-669.0)); });
		constant_folding_check("dot_product(767.2189, 215.0, -783.0, -588.0)", function() { return dot_product(767.2189, 215.0, -783.0, -588.0); }, function() { return dot_product(constant_folding_rt(767.2189), constant_folding_rt(215.0), constant_folding_rt(-783.0), constant_folding_rt(-588.0)); });
		constant_folding_check("dot_product(144.5033, -492.767, -91.0, -265.0565)", function() { return dot_product(144.5033, -492.767, -91.0, -265.0565); }, function() { return dot_product(constant_folding_rt(144.5033), constant_folding_rt(-492.767), constant_folding_rt(-91.0), constant_folding_rt(-265.0565)); });
		constant_folding_check("dot_product(-591.283, 893.0964, -599.809, 992.72)", function() { return dot_product(-591.283, 893.0964, -599.809, 992.72); }, function() { return dot_product(constant_folding_rt(-591.283), constant_folding_rt(893.0964), constant_folding_rt(-599.809), constant_folding_rt(992.72)); });
		constant_folding_check("dot_product(825.3924, -409.0, 107.07, 996.7)", function() { return dot_product(825.3924, -409.0, 107.07, 996.7); }, function() { return dot_product(constant_folding_rt(825.3924), constant_folding_rt(-409.0), constant_folding_rt(107.07), constant_folding_rt(996.7)); });
		constant_folding_check("dot_product(379.1742, 874.6366, -803.0, 763.884)", function() { return dot_product(379.1742, 874.6366, -803.0, 763.884); }, function() { return dot_product(constant_folding_rt(379.1742), constant_folding_rt(874.6366), constant_folding_rt(-803.0), constant_folding_rt(763.884)); });
		constant_folding_check("dot_product(-722.4443, -848.62, -582.982, -250.8509)", function() { return dot_product(-722.4443, -848.62, -582.982, -250.8509); }, function() { return dot_product(constant_folding_rt(-722.4443), constant_folding_rt(-848.62), constant_folding_rt(-582.982), constant_folding_rt(-250.8509)); });
		constant_folding_check("dot_product(116.7802, -937.0, 865.9, 439.8)", function() { return dot_product(116.7802, -937.0, 865.9, 439.8); }, function() { return dot_product(constant_folding_rt(116.7802), constant_folding_rt(-937.0), constant_folding_rt(865.9), constant_folding_rt(439.8)); });
		constant_folding_check("dot_product(-169.5, -703.957, -926.24, -70.88)", function() { return dot_product(-169.5, -703.957, -926.24, -70.88); }, function() { return dot_product(constant_folding_rt(-169.5), constant_folding_rt(-703.957), constant_folding_rt(-926.24), constant_folding_rt(-70.88)); });
		constant_folding_check("dot_product(538.0, 672.85, 979.13, -548.4)", function() { return dot_product(538.0, 672.85, 979.13, -548.4); }, function() { return dot_product(constant_folding_rt(538.0), constant_folding_rt(672.85), constant_folding_rt(979.13), constant_folding_rt(-548.4)); });
		constant_folding_check("dot_product(-328.28, -998.985, 271.448, -59.293)", function() { return dot_product(-328.28, -998.985, 271.448, -59.293); }, function() { return dot_product(constant_folding_rt(-328.28), constant_folding_rt(-998.985), constant_folding_rt(271.448), constant_folding_rt(-59.293)); });
		constant_folding_check("dot_product(529.3241, 490.0, 510.4178, -302.3241)", function() { return dot_product(529.3241, 490.0, 510.4178, -302.3241); }, function() { return dot_product(constant_folding_rt(529.3241), constant_folding_rt(490.0), constant_folding_rt(510.4178), constant_folding_rt(-302.3241)); });
		constant_folding_check("dot_product(-965.571, -188.6, 883.4, 724.0)", function() { return dot_product(-965.571, -188.6, 883.4, 724.0); }, function() { return dot_product(constant_folding_rt(-965.571), constant_folding_rt(-188.6), constant_folding_rt(883.4), constant_folding_rt(724.0)); });
		constant_folding_check("dot_product(941.0, -727.3, 983.7802, -883.0)", function() { return dot_product(941.0, -727.3, 983.7802, -883.0); }, function() { return dot_product(constant_folding_rt(941.0), constant_folding_rt(-727.3), constant_folding_rt(983.7802), constant_folding_rt(-883.0)); });
		constant_folding_check("dot_product(-617.8, 937.5, 29.25, -306.939)", function() { return dot_product(-617.8, 937.5, 29.25, -306.939); }, function() { return dot_product(constant_folding_rt(-617.8), constant_folding_rt(937.5), constant_folding_rt(29.25), constant_folding_rt(-306.939)); });
		constant_folding_check("dot_product_3d(-709.8, -451.189, -601.1, 363.4248, -38.5274, -387.2)", function() { return dot_product_3d(-709.8, -451.189, -601.1, 363.4248, -38.5274, -387.2); }, function() { return dot_product_3d(constant_folding_rt(-709.8), constant_folding_rt(-451.189), constant_folding_rt(-601.1), constant_folding_rt(363.4248), constant_folding_rt(-38.5274), constant_folding_rt(-387.2)); });
		constant_folding_check("dot_product_3d(-612.2, -619.0, 685.59, -394.0, -735.844, -356.8)", function() { return dot_product_3d(-612.2, -619.0, 685.59, -394.0, -735.844, -356.8); }, function() { return dot_product_3d(constant_folding_rt(-612.2), constant_folding_rt(-619.0), constant_folding_rt(685.59), constant_folding_rt(-394.0), constant_folding_rt(-735.844), constant_folding_rt(-356.8)); });
		constant_folding_check("dot_product_3d(452.4955, -589.01, 120.0, -112.78, -925.6035, -518.45)", function() { return dot_product_3d(452.4955, -589.01, 120.0, -112.78, -925.6035, -518.45); }, function() { return dot_product_3d(constant_folding_rt(452.4955), constant_folding_rt(-589.01), constant_folding_rt(120.0), constant_folding_rt(-112.78), constant_folding_rt(-925.6035), constant_folding_rt(-518.45)); });
		constant_folding_check("dot_product_3d(353.824, 608.0, 738.2, 719.3, -610.9, 226.8)", function() { return dot_product_3d(353.824, 608.0, 738.2, 719.3, -610.9, 226.8); }, function() { return dot_product_3d(constant_folding_rt(353.824), constant_folding_rt(608.0), constant_folding_rt(738.2), constant_folding_rt(719.3), constant_folding_rt(-610.9), constant_folding_rt(226.8)); });
		constant_folding_check("dot_product_3d(745.7, -849.3465, -848.86, -965.824, 19.0, 682.0)", function() { return dot_product_3d(745.7, -849.3465, -848.86, -965.824, 19.0, 682.0); }, function() { return dot_product_3d(constant_folding_rt(745.7), constant_folding_rt(-849.3465), constant_folding_rt(-848.86), constant_folding_rt(-965.824), constant_folding_rt(19.0), constant_folding_rt(682.0)); });
		constant_folding_check("dot_product_3d(976.7234, 95.5, 367.5051, -29.821, 100.82, -992.0)", function() { return dot_product_3d(976.7234, 95.5, 367.5051, -29.821, 100.82, -992.0); }, function() { return dot_product_3d(constant_folding_rt(976.7234), constant_folding_rt(95.5), constant_folding_rt(367.5051), constant_folding_rt(-29.821), constant_folding_rt(100.82), constant_folding_rt(-992.0)); });
		constant_folding_check("dot_product_3d(-91.0, -89.7, -994.27, 979.94, -16.351, -892.0)", function() { return dot_product_3d(-91.0, -89.7, -994.27, 979.94, -16.351, -892.0); }, function() { return dot_product_3d(constant_folding_rt(-91.0), constant_folding_rt(-89.7), constant_folding_rt(-994.27), constant_folding_rt(979.94), constant_folding_rt(-16.351), constant_folding_rt(-892.0)); });
		constant_folding_check("dot_product_3d(-25.4, -124.1, 23.1, 551.96, 916.895, -455.028)", function() { return dot_product_3d(-25.4, -124.1, 23.1, 551.96, 916.895, -455.028); }, function() { return dot_product_3d(constant_folding_rt(-25.4), constant_folding_rt(-124.1), constant_folding_rt(23.1), constant_folding_rt(551.96), constant_folding_rt(916.895), constant_folding_rt(-455.028)); });
		constant_folding_check("dot_product_3d(172.804, 313.51, -553.464, -748.6, -297.122, -699.5)", function() { return dot_product_3d(172.804, 313.51, -553.464, -748.6, -297.122, -699.5); }, function() { return dot_product_3d(constant_folding_rt(172.804), constant_folding_rt(313.51), constant_folding_rt(-553.464), constant_folding_rt(-748.6), constant_folding_rt(-297.122), constant_folding_rt(-699.5)); });
		constant_folding_check("dot_product_3d(-11.2765, -907.024, 340.2, -399.3768, 464.0, -68.6)", function() { return dot_product_3d(-11.2765, -907.024, 340.2, -399.3768, 464.0, -68.6); }, function() { return dot_product_3d(constant_folding_rt(-11.2765), constant_folding_rt(-907.024), constant_folding_rt(340.2), constant_folding_rt(-399.3768), constant_folding_rt(464.0), constant_folding_rt(-68.6)); });
		constant_folding_check("dot_product_3d(69.61, 768.686, -388.0, 528.07, -672.6613, -7.6)", function() { return dot_product_3d(69.61, 768.686, -388.0, 528.07, -672.6613, -7.6); }, function() { return dot_product_3d(constant_folding_rt(69.61), constant_folding_rt(768.686), constant_folding_rt(-388.0), constant_folding_rt(528.07), constant_folding_rt(-672.6613), constant_folding_rt(-7.6)); });
		constant_folding_check("dot_product_3d(821.2, -527.379, -116.157, 117.5345, -183.3, -690.1)", function() { return dot_product_3d(821.2, -527.379, -116.157, 117.5345, -183.3, -690.1); }, function() { return dot_product_3d(constant_folding_rt(821.2), constant_folding_rt(-527.379), constant_folding_rt(-116.157), constant_folding_rt(117.5345), constant_folding_rt(-183.3), constant_folding_rt(-690.1)); });
		constant_folding_check("dot_product_3d(-31.347, 258.0, 857.0, 258.2, 315.864, 281.9997)", function() { return dot_product_3d(-31.347, 258.0, 857.0, 258.2, 315.864, 281.9997); }, function() { return dot_product_3d(constant_folding_rt(-31.347), constant_folding_rt(258.0), constant_folding_rt(857.0), constant_folding_rt(258.2), constant_folding_rt(315.864), constant_folding_rt(281.9997)); });
		constant_folding_check("dot_product_3d(15.0, -860.0, -737.714, 371.1, -723.0, -410.0)", function() { return dot_product_3d(15.0, -860.0, -737.714, 371.1, -723.0, -410.0); }, function() { return dot_product_3d(constant_folding_rt(15.0), constant_folding_rt(-860.0), constant_folding_rt(-737.714), constant_folding_rt(371.1), constant_folding_rt(-723.0), constant_folding_rt(-410.0)); });
		constant_folding_check("dot_product_3d(886.564, -329.02, -465.55, 776.0653, 925.47, 879.7)", function() { return dot_product_3d(886.564, -329.02, -465.55, 776.0653, 925.47, 879.7); }, function() { return dot_product_3d(constant_folding_rt(886.564), constant_folding_rt(-329.02), constant_folding_rt(-465.55), constant_folding_rt(776.0653), constant_folding_rt(925.47), constant_folding_rt(879.7)); });
		constant_folding_check("dot_product_3d(210.978, 436.3, -414.9, 496.8, 643.2614, 63.7)", function() { return dot_product_3d(210.978, 436.3, -414.9, 496.8, 643.2614, 63.7); }, function() { return dot_product_3d(constant_folding_rt(210.978), constant_folding_rt(436.3), constant_folding_rt(-414.9), constant_folding_rt(496.8), constant_folding_rt(643.2614), constant_folding_rt(63.7)); });
		constant_folding_check("dot_product_3d(677.2, 35.0, 305.555, -133.318, -875.393, -846.988)", function() { return dot_product_3d(677.2, 35.0, 305.555, -133.318, -875.393, -846.988); }, function() { return dot_product_3d(constant_folding_rt(677.2), constant_folding_rt(35.0), constant_folding_rt(305.555), constant_folding_rt(-133.318), constant_folding_rt(-875.393), constant_folding_rt(-846.988)); });
		constant_folding_check("dot_product_3d(-777.852, 245.547, 513.79, 658.757, 272.9233, -617.92)", function() { return dot_product_3d(-777.852, 245.547, 513.79, 658.757, 272.9233, -617.92); }, function() { return dot_product_3d(constant_folding_rt(-777.852), constant_folding_rt(245.547), constant_folding_rt(513.79), constant_folding_rt(658.757), constant_folding_rt(272.9233), constant_folding_rt(-617.92)); });
		constant_folding_check("dot_product_3d(259.06, -733.3444, 324.29, -740.309, -437.0, 452.6203)", function() { return dot_product_3d(259.06, -733.3444, 324.29, -740.309, -437.0, 452.6203); }, function() { return dot_product_3d(constant_folding_rt(259.06), constant_folding_rt(-733.3444), constant_folding_rt(324.29), constant_folding_rt(-740.309), constant_folding_rt(-437.0), constant_folding_rt(452.6203)); });
		constant_folding_check("dot_product_3d(-311.66, 62.0, 559.15, -175.0, 473.3, -548.0662)", function() { return dot_product_3d(-311.66, 62.0, 559.15, -175.0, 473.3, -548.0662); }, function() { return dot_product_3d(constant_folding_rt(-311.66), constant_folding_rt(62.0), constant_folding_rt(559.15), constant_folding_rt(-175.0), constant_folding_rt(473.3), constant_folding_rt(-548.0662)); });
		constant_folding_check("dot_product_3d(-217.2529, -125.9, 475.9, 514.76, -707.3129, -503.1)", function() { return dot_product_3d(-217.2529, -125.9, 475.9, 514.76, -707.3129, -503.1); }, function() { return dot_product_3d(constant_folding_rt(-217.2529), constant_folding_rt(-125.9), constant_folding_rt(475.9), constant_folding_rt(514.76), constant_folding_rt(-707.3129), constant_folding_rt(-503.1)); });
		constant_folding_check("dot_product_3d(79.5, 933.7, 880.9, 768.2, 201.0, 825.1213)", function() { return dot_product_3d(79.5, 933.7, 880.9, 768.2, 201.0, 825.1213); }, function() { return dot_product_3d(constant_folding_rt(79.5), constant_folding_rt(933.7), constant_folding_rt(880.9), constant_folding_rt(768.2), constant_folding_rt(201.0), constant_folding_rt(825.1213)); });
		constant_folding_check("dot_product_3d(458.1864, 331.0, 653.038, 578.599, -994.5, 977.5734)", function() { return dot_product_3d(458.1864, 331.0, 653.038, 578.599, -994.5, 977.5734); }, function() { return dot_product_3d(constant_folding_rt(458.1864), constant_folding_rt(331.0), constant_folding_rt(653.038), constant_folding_rt(578.599), constant_folding_rt(-994.5), constant_folding_rt(977.5734)); });
		constant_folding_check("dot_product_3d(731.08, -375.0, 376.9699, 120.1353, 977.0, 880.7333)", function() { return dot_product_3d(731.08, -375.0, 376.9699, 120.1353, 977.0, 880.7333); }, function() { return dot_product_3d(constant_folding_rt(731.08), constant_folding_rt(-375.0), constant_folding_rt(376.9699), constant_folding_rt(120.1353), constant_folding_rt(977.0), constant_folding_rt(880.7333)); });
		constant_folding_check("dot_product_3d(977.9, 538.2, -22.19, 278.2371, -327.7, -389.4487)", function() { return dot_product_3d(977.9, 538.2, -22.19, 278.2371, -327.7, -389.4487); }, function() { return dot_product_3d(constant_folding_rt(977.9), constant_folding_rt(538.2), constant_folding_rt(-22.19), constant_folding_rt(278.2371), constant_folding_rt(-327.7), constant_folding_rt(-389.4487)); });
		constant_folding_check("point_distance(-702.2938, -245.9275, -628.68, 718.1989)", function() { return point_distance(-702.2938, -245.9275, -628.68, 718.1989); }, function() { return point_distance(constant_folding_rt(-702.2938), constant_folding_rt(-245.9275), constant_folding_rt(-628.68), constant_folding_rt(718.1989)); });
		constant_folding_check("point_distance(-486.582, 455.0, 282.43, 557.126)", function() { return point_distance(-486.582, 455.0, 282.43, 557.126); }, function() { return point_distance(constant_folding_rt(-486.582), constant_folding_rt(455.0), constant_folding_rt(282.43), constant_folding_rt(557.126)); });
		constant_folding_check("point_distance(-458.63, -109.6, -950.3, -717.58)", function() { return point_distance(-458.63, -109.6, -950.3, -717.58); }, function() { return point_distance(constant_folding_rt(-458.63), constant_folding_rt(-109.6), constant_folding_rt(-950.3), constant_folding_rt(-717.58)); });
		constant_folding_check("point_distance(-441.2, 432.582, -540.11, -487.0)", function() { return point_distance(-441.2, 432.582, -540.11, -487.0); }, function() { return point_distance(constant_folding_rt(-441.2), constant_folding_rt(432.582), constant_folding_rt(-540.11), constant_folding_rt(-487.0)); });
		constant_folding_check("point_distance(201.313, -851.0, 155.8, 766.632)", function() { return point_distance(201.313, -851.0, 155.8, 766.632); }, function() { return point_distance(constant_folding_rt(201.313), constant_folding_rt(-851.0), constant_folding_rt(155.8), constant_folding_rt(766.632)); });
		constant_folding_check("point_distance(262.47, -220.9, 497.0171, 267.47)", function() { return point_distance(262.47, -220.9, 497.0171, 267.47); }, function() { return point_distance(constant_folding_rt(262.47), constant_folding_rt(-220.9), constant_folding_rt(497.0171), constant_folding_rt(267.47)); });
		constant_folding_check("point_distance(737.0, -855.9, 114.0205, 322.4326)", function() { return point_distance(737.0, -855.9, 114.0205, 322.4326); }, function() { return point_distance(constant_folding_rt(737.0), constant_folding_rt(-855.9), constant_folding_rt(114.0205), constant_folding_rt(322.4326)); });
		constant_folding_check("point_distance(-431.0, 601.41, 415.6, 727.0)", function() { return point_distance(-431.0, 601.41, 415.6, 727.0); }, function() { return point_distance(constant_folding_rt(-431.0), constant_folding_rt(601.41), constant_folding_rt(415.6), constant_folding_rt(727.0)); });
		constant_folding_check("point_distance(667.9, -108.0, -197.225, 718.3732)", function() { return point_distance(667.9, -108.0, -197.225, 718.3732); }, function() { return point_distance(constant_folding_rt(667.9), constant_folding_rt(-108.0), constant_folding_rt(-197.225), constant_folding_rt(718.3732)); });
		constant_folding_check("point_distance(574.0, 776.5, 85.21, -889.7)", function() { return point_distance(574.0, 776.5, 85.21, -889.7); }, function() { return point_distance(constant_folding_rt(574.0), constant_folding_rt(776.5), constant_folding_rt(85.21), constant_folding_rt(-889.7)); });
		constant_folding_check("point_distance(980.934, -727.0, -477.7, -495.5016)", function() { return point_distance(980.934, -727.0, -477.7, -495.5016); }, function() { return point_distance(constant_folding_rt(980.934), constant_folding_rt(-727.0), constant_folding_rt(-477.7), constant_folding_rt(-495.5016)); });
		constant_folding_check("point_distance(-907.76, 6.9147, 578.4952, -790.995)", function() { return point_distance(-907.76, 6.9147, 578.4952, -790.995); }, function() { return point_distance(constant_folding_rt(-907.76), constant_folding_rt(6.9147), constant_folding_rt(578.4952), constant_folding_rt(-790.995)); });
		constant_folding_check("point_distance(-546.16, -440.0, -605.53, 468.68)", function() { return point_distance(-546.16, -440.0, -605.53, 468.68); }, function() { return point_distance(constant_folding_rt(-546.16), constant_folding_rt(-440.0), constant_folding_rt(-605.53), constant_folding_rt(468.68)); });
		constant_folding_check("point_distance(216.0, -505.45, 79.298, -376.0)", function() { return point_distance(216.0, -505.45, 79.298, -376.0); }, function() { return point_distance(constant_folding_rt(216.0), constant_folding_rt(-505.45), constant_folding_rt(79.298), constant_folding_rt(-376.0)); });
		constant_folding_check("point_distance(-711.51, 954.74, -230.59, -246.8)", function() { return point_distance(-711.51, 954.74, -230.59, -246.8); }, function() { return point_distance(constant_folding_rt(-711.51), constant_folding_rt(954.74), constant_folding_rt(-230.59), constant_folding_rt(-246.8)); });
		constant_folding_check("point_distance(120.0, 933.0, 626.43, -798.0)", function() { return point_distance(120.0, 933.0, 626.43, -798.0); }, function() { return point_distance(constant_folding_rt(120.0), constant_folding_rt(933.0), constant_folding_rt(626.43), constant_folding_rt(-798.0)); });
		constant_folding_check("point_distance(-369.771, -225.0, -977.53, -141.0)", function() { return point_distance(-369.771, -225.0, -977.53, -141.0); }, function() { return point_distance(constant_folding_rt(-369.771), constant_folding_rt(-225.0), constant_folding_rt(-977.53), constant_folding_rt(-141.0)); });
		constant_folding_check("point_distance(-627.45, 840.0, -503.7, 987.135)", function() { return point_distance(-627.45, 840.0, -503.7, 987.135); }, function() { return point_distance(constant_folding_rt(-627.45), constant_folding_rt(840.0), constant_folding_rt(-503.7), constant_folding_rt(987.135)); });
		constant_folding_check("point_distance(824.5, 379.12, 613.75, -190.088)", function() { return point_distance(824.5, 379.12, 613.75, -190.088); }, function() { return point_distance(constant_folding_rt(824.5), constant_folding_rt(379.12), constant_folding_rt(613.75), constant_folding_rt(-190.088)); });
		constant_folding_check("point_distance(17.1, 193.0, -997.8, 582.34)", function() { return point_distance(17.1, 193.0, -997.8, 582.34); }, function() { return point_distance(constant_folding_rt(17.1), constant_folding_rt(193.0), constant_folding_rt(-997.8), constant_folding_rt(582.34)); });
		constant_folding_check("point_distance(631.2, 413.18, 503.6, 520.05)", function() { return point_distance(631.2, 413.18, 503.6, 520.05); }, function() { return point_distance(constant_folding_rt(631.2), constant_folding_rt(413.18), constant_folding_rt(503.6), constant_folding_rt(520.05)); });
		constant_folding_check("point_distance(341.5, 426.0617, -719.618, -992.4)", function() { return point_distance(341.5, 426.0617, -719.618, -992.4); }, function() { return point_distance(constant_folding_rt(341.5), constant_folding_rt(426.0617), constant_folding_rt(-719.618), constant_folding_rt(-992.4)); });
		constant_folding_check("point_distance(-958.67, -558.8, 773.0, -202.5872)", function() { return point_distance(-958.67, -558.8, 773.0, -202.5872); }, function() { return point_distance(constant_folding_rt(-958.67), constant_folding_rt(-558.8), constant_folding_rt(773.0), constant_folding_rt(-202.5872)); });
		constant_folding_check("point_distance(-1.0, -992.61, 304.0, 261.6)", function() { return point_distance(-1.0, -992.61, 304.0, 261.6); }, function() { return point_distance(constant_folding_rt(-1.0), constant_folding_rt(-992.61), constant_folding_rt(304.0), constant_folding_rt(261.6)); });
		constant_folding_check("point_distance(322.75, -846.2, -414.4, -511.76)", function() { return point_distance(322.75, -846.2, -414.4, -511.76); }, function() { return point_distance(constant_folding_rt(322.75), constant_folding_rt(-846.2), constant_folding_rt(-414.4), constant_folding_rt(-511.76)); });
		constant_folding_check("angle_difference(-286.55, 503.7)", function() { return angle_difference(-286.55, 503.7); }, function() { return angle_difference(constant_folding_rt(-286.55), constant_folding_rt(503.7)); });
		constant_folding_check("angle_difference(698.859, 888.437)", function() { return angle_difference(698.859, 888.437); }, function() { return angle_difference(constant_folding_rt(698.859), constant_folding_rt(888.437)); });
		constant_folding_check("angle_difference(56.007, 992.0)", function() { return angle_difference(56.007, 992.0); }, function() { return angle_difference(constant_folding_rt(56.007), constant_folding_rt(992.0)); });
		constant_folding_check("angle_difference(739.0, -403.1541)", function() { return angle_difference(739.0, -403.1541); }, function() { return angle_difference(constant_folding_rt(739.0), constant_folding_rt(-403.1541)); });
		constant_folding_check("angle_difference(-958.621, -440.5)", function() { return angle_difference(-958.621, -440.5); }, function() { return angle_difference(constant_folding_rt(-958.621), constant_folding_rt(-440.5)); });
		constant_folding_check("angle_difference(279.0, 949.6)", function() { return angle_difference(279.0, 949.6); }, function() { return angle_difference(constant_folding_rt(279.0), constant_folding_rt(949.6)); });
		constant_folding_check("angle_difference(307.0, -725.0)", function() { return angle_difference(307.0, -725.0); }, function() { return angle_difference(constant_folding_rt(307.0), constant_folding_rt(-725.0)); });
		constant_folding_check("angle_difference(129.6883, -268.0474)", function() { return angle_difference(129.6883, -268.0474); }, function() { return angle_difference(constant_folding_rt(129.6883), constant_folding_rt(-268.0474)); });
		constant_folding_check("angle_difference(-824.2659, -240.0)", function() { return angle_difference(-824.2659, -240.0); }, function() { return angle_difference(constant_folding_rt(-824.2659), constant_folding_rt(-240.0)); });
		constant_folding_check("angle_difference(982.811, -553.3056)", function() { return angle_difference(982.811, -553.3056); }, function() { return angle_difference(constant_folding_rt(982.811), constant_folding_rt(-553.3056)); });
		constant_folding_check("angle_difference(313.0, -269.0)", function() { return angle_difference(313.0, -269.0); }, function() { return angle_difference(constant_folding_rt(313.0), constant_folding_rt(-269.0)); });
		constant_folding_check("angle_difference(247.53, -669.0597)", function() { return angle_difference(247.53, -669.0597); }, function() { return angle_difference(constant_folding_rt(247.53), constant_folding_rt(-669.0597)); });
		constant_folding_check("angle_difference(485.0, 273.3289)", function() { return angle_difference(485.0, 273.3289); }, function() { return angle_difference(constant_folding_rt(485.0), constant_folding_rt(273.3289)); });
		constant_folding_check("angle_difference(833.5257, 226.9)", function() { return angle_difference(833.5257, 226.9); }, function() { return angle_difference(constant_folding_rt(833.5257), constant_folding_rt(226.9)); });
		constant_folding_check("angle_difference(134.5825, 65.82)", function() { return angle_difference(134.5825, 65.82); }, function() { return angle_difference(constant_folding_rt(134.5825), constant_folding_rt(65.82)); });
		constant_folding_check("lerp(-249.2543, -263.7072, 0.445)", function() { return lerp(-249.2543, -263.7072, 0.445); }, function() { return lerp(constant_folding_rt(-249.2543), constant_folding_rt(-263.7072), constant_folding_rt(0.445)); });
		constant_folding_check("lerp(-39.753, -754.84, 1.007)", function() { return lerp(-39.753, -754.84, 1.007); }, function() { return lerp(constant_folding_rt(-39.753), constant_folding_rt(-754.84), constant_folding_rt(1.007)); });
		constant_folding_check("lerp(-352.0818, -58.13, 1.835)", function() { return lerp(-352.0818, -58.13, 1.835); }, function() { return lerp(constant_folding_rt(-352.0818), constant_folding_rt(-58.13), constant_folding_rt(1.835)); });
		constant_folding_check("lerp(-896.089, 322.0, 0.035)", function() { return lerp(-896.089, 322.0, 0.035); }, function() { return lerp(constant_folding_rt(-896.089), constant_folding_rt(322.0), constant_folding_rt(0.035)); });
		constant_folding_check("lerp(996.1217, -377.858, -0.643)", function() { return lerp(996.1217, -377.858, -0.643); }, function() { return lerp(constant_folding_rt(996.1217), constant_folding_rt(-377.858), constant_folding_rt(-0.643)); });
		constant_folding_check("lerp(236.3, 488.79, 1.506)", function() { return lerp(236.3, 488.79, 1.506); }, function() { return lerp(constant_folding_rt(236.3), constant_folding_rt(488.79), constant_folding_rt(1.506)); });
		constant_folding_check("lerp(399.0, -324.8, 0.605)", function() { return lerp(399.0, -324.8, 0.605); }, function() { return lerp(constant_folding_rt(399.0), constant_folding_rt(-324.8), constant_folding_rt(0.605)); });
		constant_folding_check("lerp(-591.2, 9.0, 1.441)", function() { return lerp(-591.2, 9.0, 1.441); }, function() { return lerp(constant_folding_rt(-591.2), constant_folding_rt(9.0), constant_folding_rt(1.441)); });
		constant_folding_check("lerp(-717.3, -545.3432, -0.041)", function() { return lerp(-717.3, -545.3432, -0.041); }, function() { return lerp(constant_folding_rt(-717.3), constant_folding_rt(-545.3432), constant_folding_rt(-0.041)); });
		constant_folding_check("lerp(839.6897, 189.496, 0.967)", function() { return lerp(839.6897, 189.496, 0.967); }, function() { return lerp(constant_folding_rt(839.6897), constant_folding_rt(189.496), constant_folding_rt(0.967)); });
	});

	addFact("constant_folding_test #27", function() {
		
		// Check string_trim (the runtime white space), string_length (code points), string_byte_length and code_is_compiled
		constant_folding_check("string_trim(\"  a b  \")", function() { return string_trim("  a b  "); }, function() { return string_trim(constant_folding_rt("  a b  ")); });
		constant_folding_check("string_trim(\"​x​\")", function() { return string_trim("​x​"); }, function() { return string_trim(constant_folding_rt("​x​")); });
		constant_folding_check("string_trim(\"﻿x\")", function() { return string_trim("﻿x"); }, function() { return string_trim(constant_folding_rt("﻿x")); });
		constant_folding_check("string_trim(\" x　\")", function() { return string_trim(" x　"); }, function() { return string_trim(constant_folding_rt(" x　")); });
		constant_folding_check("string_trim(\"᠎x\")", function() { return string_trim("᠎x"); }, function() { return string_trim(constant_folding_rt("᠎x")); });
		constant_folding_check("string_trim_start(\"\\t\\nx \")", function() { return string_trim_start("\t\nx "); }, function() { return string_trim_start(constant_folding_rt("\t\nx ")); });
		constant_folding_check("string_trim_end(\" x⁠\")", function() { return string_trim_end(" x⁠"); }, function() { return string_trim_end(constant_folding_rt(" x⁠")); });
		constant_folding_check("string_trim(\"\\u001Fx\")", function() { return string_trim("\u001Fx"); }, function() { return string_trim(constant_folding_rt("\u001Fx")); });
		constant_folding_check("string_trim(\"‍x‌\")", function() { return string_trim("‍x‌"); }, function() { return string_trim(constant_folding_rt("‍x‌")); });
		constant_folding_check("string_length(\"héllo\")", function() { return string_length("héllo"); }, function() { return string_length(constant_folding_rt("héllo")); });
		constant_folding_check("string_length(\"👍🏽\")", function() { return string_length("👍🏽"); }, function() { return string_length(constant_folding_rt("👍🏽")); });
		constant_folding_check("string_length(\"é\")", function() { return string_length("é"); }, function() { return string_length(constant_folding_rt("é")); });
		constant_folding_check("string_length(\"\")", function() { return string_length(""); }, function() { return string_length(constant_folding_rt("")); });
		constant_folding_check("string_length(123)", function() { return string_length(123); }, function() { return string_length(constant_folding_rt(123)); });
		constant_folding_check("string_length(1.5)", function() { return string_length(1.5); }, function() { return string_length(constant_folding_rt(1.5)); });
		constant_folding_check("string_length(\"🇬🇧\")", function() { return string_length("🇬🇧"); }, function() { return string_length(constant_folding_rt("🇬🇧")); });
		constant_folding_check("string_byte_length(\"héllo\")", function() { return string_byte_length("héllo"); }, function() { return string_byte_length(constant_folding_rt("héllo")); });
		constant_folding_check("string_byte_length(\"👍🏽\")", function() { return string_byte_length("👍🏽"); }, function() { return string_byte_length(constant_folding_rt("👍🏽")); });
		constant_folding_check("string_byte_length(1.5)", function() { return string_byte_length(1.5); }, function() { return string_byte_length(constant_folding_rt(1.5)); });
		constant_folding_check("code_is_compiled()", function() { return code_is_compiled(); }, function() { var _f = code_is_compiled; return _f(); });
	});

	addFact("constant_folding_test #28", function() {
		
		// Check ord, chr, int64, real and is_method
		constant_folding_check("ord(\"A\")", function() { return ord("A"); }, function() { return ord(constant_folding_rt("A")); });
		constant_folding_check("ord(\"é\")", function() { return ord("é"); }, function() { return ord(constant_folding_rt("é")); });
		constant_folding_check("ord(\"😀\")", function() { return ord("😀"); }, function() { return ord(constant_folding_rt("😀")); });
		constant_folding_check("ord(\"\")", function() { return ord(""); }, function() { return ord(constant_folding_rt("")); });
		constant_folding_check("chr(65)", function() { return chr(65); }, function() { return chr(constant_folding_rt(65)); });
		constant_folding_check("chr(233)", function() { return chr(233); }, function() { return chr(constant_folding_rt(233)); });
		constant_folding_check("chr(128512)", function() { return chr(128512); }, function() { return chr(constant_folding_rt(128512)); });
		constant_folding_check("chr(0)", function() { return chr(0); }, function() { return chr(constant_folding_rt(0)); });
		constant_folding_check("int64(2.7)", function() { return int64(2.7); }, function() { return int64(constant_folding_rt(2.7)); });
		constant_folding_check("int64(-2.7)", function() { return int64(-2.7); }, function() { return int64(constant_folding_rt(-2.7)); });
		constant_folding_check("real(\"3.5\")", function() { return real("3.5"); }, function() { return real(constant_folding_rt("3.5")); });
		constant_folding_check("real(\"  7\")", function() { return real("  7"); }, function() { return real(constant_folding_rt("  7")); });
		constant_folding_check("is_method(5)", function() { return is_method(5); }, function() { return is_method(constant_folding_rt(5)); });
		constant_folding_check("is_method(undefined)", function() { return is_method(undefined); }, function() { return is_method(constant_folding_rt(undefined)); });
	});

}
