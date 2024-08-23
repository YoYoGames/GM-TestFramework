// Add variables to test names of
#macro NAMEOF_TEST_REAL 21.37
#macro NAMEOF_TEST_STRING "foobar"
	#macro NAMEOF_TEST_TABBED_MACRO "test" // this is important that \t character is in this line before #macro

enum nameof_test {
	entry_1,
	entry_2,
}
global.NAMEOF_GLOBAL_TEST_REAL = 21.37;
global.NAMEOF_GLOBAL_TEST_STRING = "foobar";

function BasicNameofTestSuite() : TestSuite() constructor {

	// Test names of macros
	addFact("nameof_macro_test", function() {
		assert_equals(nameof(NAMEOF_TEST_REAL), "NAMEOF_TEST_REAL", "nameof of macro which holds real value");
		assert_equals(nameof(NAMEOF_TEST_STRING), "NAMEOF_TEST_STRING", "nameof of macro which holds string value");
		assert_equals(nameof(NAMEOF_TEST_TABBED_MACRO), "NAMEOF_TEST_TABBED_MACRO", "nameof of macro which have \\t character before keyword");
	});
	
	// Test names of enums
	addFact("nameof_enum_test", function() {
		assert_equals(nameof(nameof_test.entry_1), "nameof_test.entry_1", "nameof of enum which holds real value");
		assert_equals(nameof(nameof_test.entry_2), "nameof_test.entry_2", "nameof of enum which holds string value");
	});
	
	// Test names of global variables
	addFact("nameof_global_test", function() {
		assert_equals(nameof(global.NAMEOF_GLOBAL_TEST_REAL), "global.NAMEOF_GLOBAL_TEST_REAL", "nameof of global which holds real value");
		assert_equals(nameof(global.NAMEOF_GLOBAL_TEST_STRING), "global.NAMEOF_GLOBAL_TEST_STRING", "nameof of global which holds string value");
	});
	
	// Test names of local variables
	addFact("nameof_localvar_test", function() {
		var _real = 21.37, _string = "foobar";
		
		assert_equals(nameof(_real), "_real", "#7 nameof of localvar which holds real value");
		assert_equals(nameof(_string), "_string", "#8 nameof of localvar which holds string value");
	});
}
