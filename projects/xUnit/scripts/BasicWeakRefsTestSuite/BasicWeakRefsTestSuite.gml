
function BasicWeakRefsTestSuite() : TestSuite() constructor {

	addFact("weak_ref_create test #1", function() {

		var valueDetails = [
			[ {},					"struct" ],
			[ function() {},		"method" ],
			[ weak_ref_create({}),	"weakref" ] ];
			
		var valueType, value, details, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];

			output = weak_ref_create(value);
			assert_not_equals(output, -1, string("weak_ref_create({0}), failed to create weakref", details));
		}
		
	});

	addFact("weak_ref_create test #2", function() {

		var valueDetails = [
			[ {},					"struct" ],
			[ function() {},		"method" ],
			[ weak_ref_create({}),	"weakref" ] ];
			
		var valueType, value, details, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];

			output = weak_ref_create(value);
			assert_typeof(output, "struct", string("weak_ref_create({0}), failed to return a struct", details));
		}
		
	});

	addFact("weak_ref_create test #3", function() {

		var valueDetails = [
			[ {},					"struct" ],
			[ function() {},		"method" ],
			[ weak_ref_create({}),	"weakref" ] ];
			
		var valueType, value, details, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];

			output = weak_ref_create(value);
			assert_equals(output.ref, value, string("weak_ref_create({0}), failed to extablish the correct reference", details));
		}
			
	});
	
	// WEAK REF ALIVE TESTS

	addFact("weak_ref_alive tets #1", function() {
			

		var valueDetails = [
			[ {},					"struct" ],
			[ function() {},		"method" ],
			[ weak_ref_create({}),	"weakref" ] ];
			
		var valueType, value, details, input, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];

			input = weak_ref_create(value);
			output = weak_ref_alive(input);
			assert_true(output, string("weak_ref_alive(): {0}, failed to detect alive weakref", details));
		}
			
	});

	// WEAK REF ANY ALIVE TESTS
	
	addFact("weak_ref_any_alive test #1", function() {

		// #### VALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input);
		assert_true(output, "weak_ref_any_alive(array), failed to detect alive references");
		
	});

	addFact("weak_ref_any_alive test #2", function() {

		// #### VALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, -3, 10);
		assert_true(output, "weak_ref_any_alive(array, real, real), (-) index / (+) length, failed to detect alive references");
		
	});

	addFact("weak_ref_any_alive test #3", function() {

		// #### VALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, "0", "2");
		assert_true(output, "weak_ref_any_alive(array, string, string), (+) index / (+) length, failed to detect alive references");
		
	});

	addFact("weak_ref_any_alive test #4", function() {
			
		// #### INVALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, -20, 1);
		assert_undefined(output, "weak_ref_any_alive(array, real, real), (-) index / (+) length, worked even out of range");
		
	});

	addFact("weak_ref_any_alive test #5", function() {
			
		// #### INVALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, 22, 33);
		assert_undefined(output, "weak_ref_any_alive(array, real, real), (+) index / (+) length, worked even out of range");
		
	});

	addFact("weak_ref_any_alive test #6", function() {
			
		// #### INVALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, -3, -10);
		assert_undefined(output, "weak_ref_any_alive(array, real, real), (-) index / (-) length, worked even out of range");
		
	});

	addFact("weak_ref_any_alive test #7", function() {
			
		// #### INVALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input, 4, -10);
		assert_undefined(output, "weak_ref_any_alive(array, real, real), (+) index / (-) length, worked even out of range");
		
	})

}