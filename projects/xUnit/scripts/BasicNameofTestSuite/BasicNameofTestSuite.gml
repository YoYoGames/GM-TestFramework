#macro NAMEOF_TEST_REAL 21.37
#macro NAMEOF_TEST_STRING "foobar"
enum nameof_test {
	entry_1,
	entry_2,
}
global.NAMEOF_GLOBAL_TEST_REAL = 21.37;
global.NAMEOF_GLOBAL_TEST_STRING = "foobar";

function BasicNameofTestSuite() : TestSuite() constructor {
	
	addFact("nameof_macro_test", function() {
		assert_equals("NAMEOF_TEST_REAL", nameof(NAMEOF_TEST_REAL), "#1 nameof of macro which holds real value");
		assert_equals("NAMEOF_TEST_STRING", nameof(NAMEOF_TEST_STRING), "#2 nameof of macro which holds string value");
	});
	
	addFact("nameof_enum_test", function() {
		assert_equals("nameof_test.entry_1", nameof(nameof_test.entry_1), "#3 nameof of enum which holds real value");
		assert_equals("nameof_test.entry_2", nameof(nameof_test.entry_2), "#4 nameof of enum which holds string value");
	});
	
	addFact("nameof_global_test", function() {
		assert_equals("global.NAMEOF_GLOBAL_TEST_REAL", nameof(global.NAMEOF_GLOBAL_TEST_REAL), "#5 nameof of global which holds real value");
		assert_equals("global.NAMEOF_GLOBAL_TEST_STRING", nameof(global.NAMEOF_GLOBAL_TEST_STRING), "#6 nameof of global which holds string value");
	});
}