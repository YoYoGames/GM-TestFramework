
function BasicWeakRefsTestSuite() : TestSuite() constructor {

	addFact("weak_ref_create", function() {

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
			assert_not_equals(output, -1, string("#1 weak_ref_create({0}), failed to create weakref", details));
			assert_typeof(output, "struct", string("#1.1 weak_ref_create({0}), failed to return a struct", details));
			assert_equals(output.ref, value, string("#1.2 weak_ref_create({0}), failed to extablish the correct reference", details));
		}
			
	})

	addFact("weak_ref_alive", function() {
			

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
			assert_true(output, string("#1 weak_ref_alive(): {0}, failed to detect alive weakref", details));
		}
			
	})

	addFact("weak_ref_any_alive", function() {

		// #### VALID ####

		var struct = {};
		var func = function() {};
		var weakref = weak_ref_create({});

		var output, input = [ weak_ref_create(struct), weak_ref_create(func), weak_ref_create(weakref) ];
			
		output = weak_ref_any_alive(input);
		assert_true(output, "#1 weak_ref_any_alive(array), failed to detect alive references");
			
		output = weak_ref_any_alive(input, -3, 10);
		assert_true(output, "#2 weak_ref_any_alive(array, real, real), (-) index / (+) length, failed to detect alive references");
			
		output = weak_ref_any_alive(input, "0", "2");
		assert_true(output, "#2.1 weak_ref_any_alive(array, string, string), (+) index / (+) length, failed to detect alive references");
			
		// #### INVALID ####
			
		output = weak_ref_any_alive(input, -20, 1);
		assert_undefined(output, "#3 weak_ref_any_alive(array, real, real), (-) index / (+) length, worked even out of range");
			
		output = weak_ref_any_alive(input, 22, 33);
		assert_undefined(output, "#4 weak_ref_any_alive(array, real, real), (+) index / (+) length, worked even out of range");
			
		output = weak_ref_any_alive(input, -3, -10);
		assert_undefined(output, "#5 weak_ref_any_alive(array, real, real), (-) index / (-) length, worked even out of range");
			
		output = weak_ref_any_alive(input, 4, -10);
		assert_undefined(output, "#6 weak_ref_any_alive(array, real, real), (+) index / (-) length, worked even out of range");
		
	})

}