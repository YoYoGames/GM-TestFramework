function GetValueDetails() {
	
	var valueDetails = [ 
		[ ptr({}),		"ptr" ],
		[ pointer_null,		"ptrNull" ],
		[ pointer_invalid,	"ptrInvalid" ],
		[ "hello",			"string" ],
		[ 1000,				"number" ],
		[ int32(1000),		"int32" ],
		[ int64(0xFFFFFFF), "int64" ],
		[ true,				"bool" ],
		[ NaN,				"nan" ],
		[ infinity,			"infinity" ],
		[ undefined,		"undefined" ],
		[{},				"struct" ],
		[ [],				"array" ],
		[ function() {},	"method"] ];
		
	return valueDetails;
	
}

function BasicVariableTestSuite() : TestSuite() constructor {
	
	// PARAMETER TESTS
	
	addFact("parameter_count_tests", function() {

		// parameter count tests.
			
		// ---- Basic Test ----
		if (os_browser == browser_not_a_browser) {
			
			switch (os_type) 
			{
			    case os_windows:
			    {
			        if (!code_is_compiled()) 
			        {
			            // ====================== VM ======================
			
			            var paramCount = parameter_count();
			            assert_greater_or_equal(paramCount, 3, "parameter_count should not return fewer than 3 params on VM.");
			
			            // Cannot modify the params that are currently passed in via the test rig.
			        }
			        else
			        {
			            // ====================== YYC ======================
			            var paramCount = parameter_count();
			            assert_greater_or_equal(paramCount, 1, "parameter_count should not return fewer than 1 params on YYC.");
			        }
			        break;
			    }
			    default:
			    {
			        show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			        show_debug_message("parameter_count_test needs to be updated to support this platform: " + string(os_type));
			        show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			        break;
			    }
			}
		} // end if

	})
		
	addFact("parameter_string_tests", function() {

		// parameter string tests.
		//show_debug_message("Begin parameter_string_test");
			
		// ---- Basic Test ----
		if (os_browser == browser_not_a_browser) {
			switch (os_type) 
			{
			    case os_windows:
			    {
			        if (!code_is_compiled()) 
			        {
			            // ====================== VM ======================
			
			            var paramCount = parameter_count();
			            assert_greater_or_equal(paramCount, 3, "parameter_count should not return fewer than 3 params on VM.");
			
			            var dashGameFound = 0;
			            var dashGameParamIndex = 0;
			            var testNameFound = 0;
			
			            //show_debug_message("Param count: " + string(paramCount));
			            if (paramCount >= 0)
			            {
			                var paramIndex;
			                for (paramIndex = 0; paramIndex < paramCount; ++paramIndex)
			                {
			                    var paramStr = parameter_string(paramIndex);
			                    //show_debug_message("Param: " + string(paramIndex + 1) + ": " + paramStr);
			
			                    if (paramIndex == 0)
			                    {
			                        var indexofExe = string_pos(".exe", paramStr);
			                        assert_not_equals(indexofExe, 0, "First param should contain .exe");
			                    }
			
			                    if (dashGameFound == 0)
			                    {
			                        dashGameFound = string_pos("-game", paramStr);
			                        if (dashGameFound != 0)
			                        {
			                            dashGameParamIndex = paramIndex;
			                        }
			                    }
			
			                    if ((dashGameParamIndex > 0) && ((dashGameParamIndex + 1) == paramIndex))
			                    {
			                        //var indexofTestName = string_pos("parameter_string_tests", paramStr);
									// We are NOT using external tests anymore
			                        //assert_not_equals(indexofTestName, 0, "Test folder and name not found after -game");
			                        testNameFound = 1;
			                    }
			                }
			            }
			            assert_not_equals(dashGameFound, 0, "-game was not found");
							
						// We are NOT using exernal tests anymore
			            //assert_equals(testNameFound, 1, "test name was not found");
			        }
			        else
			        {
			            // ====================== YYC ======================
			
			            var paramCount = parameter_count();
			            assert_greater_or_equal(paramCount, 1, "parameter_count should not return fewer than 1 params on YYC.");
			
			            var testNameFound = 0;
			            var headlessFound = 0;
			
			            //show_debug_message("Param count: " + string(paramCount));
			            if (paramCount >= 0)
			            {
			                var paramIndex;
			                for (paramIndex = 0; paramIndex < paramCount; ++paramIndex)
			                {
			                    var paramStr = parameter_string(paramIndex);
			                    //show_debug_message("Param: " + string(paramIndex + 1) + ": " + paramStr);
			
			                    if (testNameFound == 0)
			                    {
			                        testNameFound = string_pos("parameter_string_tests", paramStr);
			                    }
			
			                    if (headlessFound == 0)
			                    {
			                        headlessFound = string_pos("-headless", paramStr);
			                    }
			                }
			            }
			
			            //assert_not_equals(testNameFound, 0, "test name was not found");
			            //assert_not_equals(headlessFound, 0, "headless was not found");
			        }
			
			        break;
			    }
			    default:
			    {
			        show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			        show_debug_message("parameter_string_test needs to be updated to support this platform: " + string(os_type));
			        show_debug_message("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			        break;
			    }
			}
		} // end if
			
		//show_debug_message("End parameter_string_test");
	})

	// GLOBALS

	addFact("variable_global_exists_test #1", function() {
			
		// ##### GENERAL TYPES #####
			
		var valueDetails = GetValueDetails(); 
			
		var valueType, value, details, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];
			
			if (details != "nan") {
			
				// check that global variable does NOT exist before adding it
				output = variable_global_exists("variable");
				assert_false(output, "variable_global_exists():" + details + ", detected a nonexistent variable");
				
			}
				
			// set global variables here
			variable_global_set("variable", value);
			output = variable_global_exists("variable");
			// check if they exist
			assert_true(output, "variable_global_exists():" + details + ", failed to detect existing variable");
			// delete variable
			variable_struct_remove(global, "variable");
		}
			
	});

	addFact("variable_global_set_get_test #1", function() {

		// ##### GENERAL TYPES #####
			
		var valueDetails = GetValueDetails(); 
			
		var valueType, value, details, type, output;
			
		var valueDetailsCount = array_length(valueDetails);
		for (var j = 0; j < valueDetailsCount; j++) {
				
			valueType = valueDetails[j];
			value = valueType[0];
			details = valueType[1];
						
			type = typeof(value);
			
			// set global variables here
			variable_global_set("variable", value);
			output = variable_global_get("variable");
			// check if the values and the data types are correct
			if (details != "nan") {
				assert_equals(output, value, "variable_global_set/get():" + details + ", failed to maintain value consistency");
			} else { 
				assert_nan(output, "variable_struct_set/get():" + details + ", failed to maintain value consistency");
			}
			assert_typeof(output, type, "variable_global_set/get():" + details + ", failed to maintain type consistency");
			// delete variables
			variable_struct_remove(global, "variable");
			
		}
	});
	
	addFact("variable_global_get_names_test #1", function() { 
			
		var iterations = 100;
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// create a bunch of global variables with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_global_set(expected[i], i);
		}
		
		// get list of global variables
		output = variable_instance_get_names(global);
		// check if they contain all expected names
		assert_array_contains_all(output, expected, "variable_global_get_names(), failed to return the correct variable names.");
		
		// remove variables
		for (var i = 0; i < length; i++) {
			variable_struct_remove(global, expected[i]);
		}
			
	})
	
	addFact("variable_global_names_count_test #1", function() {

		var iterations = 100;
			
		var output, globalNames, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// create a bunch of global variables with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_global_set(expected[i], i);
		}
		
		// get list of global variables
		globalNames = variable_instance_get_names(global);
		output = 0;
		
		// get the number of variables that were added
		for (var i = 0; i < length; i++) {
			if (array_contains(globalNames, expected[i])) {
				output++;
			}
		}
		
		// check if it is the expected number of variables
		assert_equals(output, length, "variable_global_names_count, failed to return the correct variable number.");
		
		// delete variables
		for (var i = 0; i < length; i++) {
			variable_struct_remove(global, expected[i]);
		}
		
	})

	// INSTANCES
	
	addFact("variable_instance_exists_test #1", function() {

		// ##### GENERAL TYPES #####
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, name, output;
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
					
				name = "variable" + string(j);
				
				// check that variable does NOT exist before adding it
				output = variable_instance_exists(target, name);
				assert_false(output, "variable_instance_exists("+ info +"):" + details + ", detected a nonexistent variable");
				
				// add instance variable
				variable_instance_set(target, name, value);
				
				// check that variable exists after adding it
				output = variable_instance_exists(target, name);
				assert_true(output, "variable_instance_exists("+ info +"):" + details + ", failed to detect an existing variable");
				
				// delete variable
				variable_struct_remove(target, name);
			}
		}
			
		instance_destroy(instance);
		
	});
	
	addFact("variable_instance_exists_test #2", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var valueType, value, details, name, output;
			
		// ##### WITH + SELF ####
			
		instance = instance_create_depth(0, 0, 0, oEmpty);
				
		with (instance) {
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
					
				name = "variable" + string(j);
				
				// check that variable does NOT exist before adding it
				output = variable_instance_exists(self, name);
				assert_false(output, "variable_instance_exists(self):" + details + ", detected a nonexistent variable");
				
				// add instance variable
				variable_instance_set(self, name, value);
					
				// check that variable exists after adding it
				output = variable_instance_exists(self, name);
				assert_true(output, "variable_instance_exists(self):" + details + ", failed to detect an existing variable");
				
			}
		}
		
		instance_destroy(instance);
		
	});
	
	addFact("variable_instance_exists_test #3", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var valueType, value, details, name, output;

		// ##### WITH + WITH + OTHER ####

		var instance1 = instance_create_depth(0, 0, 0, oEmpty);
		var instance2 = instance_create_depth(0, 0, 0, oEmpty);
			
		with (instance1) {
			with (instance2) {
				for (var j = 0; j < valueDetailsCount; j++) {
				
					valueType = valueDetails[j];
					value = valueType[0];
					details = valueType[1];
						
					name = "variable" + string(j);
					
					// check that variable does NOT exist before adding it
					output = variable_instance_exists(other, name);
					assert_false(output, "variable_instance_exists(other):" + details + ", detected a nonexistent variable");
					
					// add instance variable
					variable_instance_set(other, name, value);
					
					// check that variable exists ater adding it
					output = variable_instance_exists(other, name);
					assert_true(output, "variable_instance_exists(other):" + details + ", failed to detect an existing variable");
					
				}
			}
		}
			
		instance_destroy(instance1);
		instance_destroy(instance2);
		
	});

	addFact("variable_instance_exists_test #4", function() {

		// ##### FAILS #####

		assert_throw(function() {
			var target = [];
			// feather ignore once GM1041
			return variable_instance_exists(target, "variable");
		}, "variable_instance_exists( array, ... ), should throw error");
		
	});

	addFact("variable_instance_exists_test #5", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = undefined;
			// feather ignore once GM1041
			return variable_instance_exists(target, "variable");
		}, "variable_instance_exists( undefined, ... ), should throw error");
		
	});

	addFact("variable_instance_exists_test #6", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = "string";
			// feather ignore once GM1041
			return variable_instance_exists(target, "variable");
		}, "variable_instance_exists( string, ... ), should throw error");
			
	});
	
	addFact("variable_instance_get_names_test #1", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### GENERAL ####

		// get array of instance variable names
		output = variable_instance_get_names(instance);
		// check if the added variable names are in the array
		assert_array_contains_all(output, expected, "variable_instance_get_names(instance), failed to return the correct variable names.");
		
		instance_destroy(instance);
		
	});
	
	addFact("variable_instance_get_names_test #2", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### WITH + SELF ####

		instance = instance_create_depth(0, 0, 0, oEmpty);
	
		with (instance) {
			
			// add a bunch of variables with different names
			for (var i = 0; i < length; i++) {
				variable_instance_set(self, expected[i], i);
			}
			
			// get array of instance variable names
			output = variable_instance_get_names(self);
			// check if the added variable names are in the array
			assert_array_contains_all(output, expected, "variable_instance_get_names(self), failed to return the correct variable names.");
		}
			
		instance_destroy(instance);
		
	});
	
	addFact("variable_instance_get_names_test #3", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### WITH + WITH + OTHER ####

		var instance1 = instance_create_depth(0, 0, 0, oEmpty);
		var instance2 = instance_create_depth(0, 0, 0, oEmpty);
	
		with (instance1) {
			with(instance2) {
				
				// add a bunch of variables with different names
				for (var i = 0; i < length; i++) {
					variable_instance_set(other, expected[i], i);
				}
				
				// get array of instance variable names
				output = variable_instance_get_names(other);
				// check if the added variable names are in the array
				assert_array_contains_all(output, expected, "variable_instance_get_names(self), failed to return the correct variable names.");
			}
		}
			
		instance_destroy(instance1);
		instance_destroy(instance2);
		
	});

	addFact("variable_instance_get_names_test #4", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = [];
			// feather ignore once GM1044
			return variable_instance_get_names(input);
		}, "variable_instance_get_names( array, ... ), should throw error");
		
	});

	addFact("variable_instance_get_names_tests #5", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = undefined;
			// feather ignore once GM1044
			return variable_instance_get_names(input);
		}, "variable_instance_get_names( undefined, ... ), should throw error");
		
	});

	addFact("variable_instance_get_names_test #6", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = "string";
			// feather ignore once GM1044
			return variable_instance_get_names(input);
		}, "variable_instance_get_names( string, ... ), should throw error");

	});
	
	addFact("variable_instance_names_count_test #1", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the instance with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### GENERAL ####
		
		// get the array of instance variable names
		output = variable_instance_get_names(instance);
		// check if the number of variables is the expected number
		assert_array_length(output, length, "variable_instance_names_count(instance), failed to return the correct variable number.");
			
		instance_destroy(instance);

	});
	
	addFact("variable_instance_names_count_test #2", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the instance with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### WITH + SELF ####

		instance = instance_create_depth(0, 0, 0, oEmpty);
	
		with (instance) {
			
			// add a bunch of variables to the instance with different names
			for (var i = 0; i < length; i++) {
				variable_instance_set(self, expected[i], i);
			}
			
			// get the array of instance variable names
			output = variable_instance_names_count(self);
			// check if the number of variables is the expected number
			assert_array_length(output, length, "variable_instance_names_count(self), failed to return the correct variable number.");
		}
			
		instance_destroy(instance);

	});

	addFact("variable_instance_names_count_test #3", function() {

		var iterations = 100;
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var output, expected = array_create(iterations);
			
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the instance with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_instance_set(instance, expected[i], i);
		}
			
		// ##### WITH + WITH + OTHER ####

		var instance1 = instance_create_depth(0, 0, 0, oEmpty);
		var instance2 = instance_create_depth(0, 0, 0, oEmpty);
	
		with (instance1) {
			with(instance2) {
				
				// add a bunch of variables to the instance with different names
				for (var i = 0; i < length; i++) {
					variable_instance_set(other, expected[i], i);
				}
				
				// get the array of instance variable names
				output = variable_instance_names_count(other);
				// check if the number of variables is the expected number
				assert_array_length(output, length, "variable_instance_names_count(other), failed to return the correct variable number.");
			}
		}
			
		instance_destroy(instance1);
		instance_destroy(instance2);

	});

	addFact("variable_instance_names_count_test #4", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = [];
			// feather ignore once GM1041
			return variable_instance_names_count(input);
		}, "variable_instance_get_names( array, ... ), should throw error");

	});

	addFact("variable_instance_names_count_test #5", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = undefined;
			// feather ignore once GM1041
			return variable_instance_names_count(input);
		}, "variable_instance_get_names( undefined, ... ), should throw error");

	});

	addFact("variable_instance_names_count_test #6", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = "string";
			// feather ignore once GM1041
			return variable_instance_names_count(input);
		}, "variable_instance_get_names( string, ... ), should throw error");

	});

	addFact("variable_instance_set_get_test #1", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;
		
		// ##### GENERAL TYPES #####
		
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				if (details != "nan") {
				
					type = typeof(value);
					// set instance variable
					variable_instance_set(target, "variable", value);
					// get instance variable
					output = variable_instance_get(target, "variable");
					
					// check if the type and value of variable is the expected one
					assert_equals(output, value, "variable_instance_set/get("+ info +"):" + details + ", failed to maintain value consistency");
					assert_typeof(output, type, "variable_instance_set/get("+ info +"):" + details + ", failed to maintain type consistency");
					
				}
			}
		}
		
		instance_destroy(instance);

	});

	addFact("variable_instance_set_get_test #2", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;
		
		// ##### NAN #####
		
		type = "number"
		value = NaN;
			
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			// set instance variable
			variable_instance_set(target, "variable", value);
			// get instance variable
			output = variable_instance_get(target, "variable");
			
			// check if the type and value of variable is the expected one
			assert_nan(output, "variable_instance_set/get("+ info +"):" + type + ", failed to maintain value consistency");
			assert_typeof(output, type, "variable_instance_set/get("+ info +"):" + type + ", failed to maintain type consistency");

		}
		
		instance_destroy(instance);

	});

	addFact("variable_instance_set_get_test #3", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;
			
		// ##### WITH + SELF ####
			
		instance = instance_create_depth(0, 0, 0, oEmpty);
				
		with (instance) {
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				if (details != "nan") {
				
					type = typeof(value);
					// set instance variable
					variable_instance_set(self, "variable", value);
					// get instance variable
					output = variable_instance_get(self, "variable");
					
					// check if the type and value of variable is the expeceted one
					assert_equals(output, value, "variable_instance_set/get(self):" + details + ", failed to maintain value consistency");
					assert_typeof(output, type, "variable_instance_set/get(self):" + details + ", failed to maintain type consistency");
					
				}
			}
		}
			
		instance_destroy(instance);

	});

	addFact("variable_instance_set_get_test #4", function() {
			
		var instance = instance_create_depth(0, 0, 0, oEmpty);
			
		var targetInfos = [ 
			[ instance,			"instance" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;

		// ##### WITH + WITH + OTHER ####

		var instance1 = instance_create_depth(0, 0, 0, oEmpty);
		var instance2 = instance_create_depth(0, 0, 0, oEmpty);
			
		with (instance1) {
			with (instance2) {
				for (var j = 0; j < valueDetailsCount; j++) {
				
					valueType = valueDetails[j];
					value = valueType[0];
					details = valueType[1];
					
					if (details != "nan") {
					
						type = typeof(value);
						// set instance variable
						variable_instance_set(other, "variable", value);
						// get instance variable
						output = variable_instance_get(other, "variable");
						
						// check if the type and value of variable is the expected one
						assert_equals(output, value, "variable_instance_set/get(other):" + details + ", failed to maintain value consistency");
						assert_typeof(output, type, "variable_instance_set/get(other):" + details + ", failed to maintain type consistency");
						
					}
				}
			}
		}
			
		instance_destroy(instance1);
		instance_destroy(instance2);

	});

	addFact("variable_instance_set_get_test #5", function() {

		// ##### FAILS #####

		assert_throw(function() {
			var target = [];
			// feather ignore once GM1041
			variable_instance_set(target, "variable", 0);
			// feather ignore once GM1044
			return variable_instance_get(target, "variable");
		}, "variable_instance_set/get( array, ... ), should throw error");

	});

	addFact("variable_instance_set_get_test #6", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = undefined;
			// feather ignore once GM1041
			variable_instance_set(target, "variable", 0);
			// feather ignore once GM1044
			return variable_instance_get(target, "variable");
		}, "variable_instance_set/get( undefined, ... ), should throw error");

	});

	addFact("variable_instance_set_get_test #7", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = "string";
			// feather ignore once GM1041
			variable_instance_set(target, "variable", 0);
			return variable_instance_get(target, "variable");
		}, "variable_instance_set/get( string, ... ), should throw error");
		
	});

	// STRUCTS
	
	addFact("variable_struct_exists_test #1", function() {
			
		// ##### GENERAL TYPES #####
			
		var struct = {};
			
		var targetInfos = [ 
			[ struct,			"struct" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, name, output;
			
		// ##### GENERAL TYPES #####
		
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
					
				name = "variable" + string(j);
				
				// check that struct does NOT exist before adding it
				output = variable_struct_exists(target, name);
				assert_false(output, "variable_struct_exists("+ info +"):" + details + ", detected a nonexistent variable");
				
				// set struct here
				variable_instance_set(target, name, value);
				
				// check if it exists
				output = variable_struct_exists(target, name);
				assert_true(output, "variable_struct_exists("+ info +"):" + details + ", failed to detect an existing variable");
				
				// delete struct
				variable_struct_remove(target, name);
			}
		}
		
	});
		
	addFact("variable_struct_exists_test #2", function() {
			
		var struct = {};
			
		var targetInfos = [ 
			[ struct,			"struct" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, name, output;
			
		// ##### WITH + SELF ####
			
		struct = {};
				
		with (struct) {
			
			target = self;
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
					
				name = "variable" + string(j);
				
				// check that struct does NOT exist before adding it
				output = variable_struct_exists(target, name);
				assert_false(output, "variable_struct_exists(self):" + details + ", detected a nonexistent variable");
				
				// set struct here
				variable_instance_set(target, name, value);
				
				// check if it exists
				output = variable_struct_exists(target, name);
				assert_true(output, "variable_struct_exists(self):" + details + ", failed to detect an existing variable");
				
				// delete struct
				variable_struct_remove(target, name);
			}
		}
		
	});
		
	addFact("variable_struct_exists_test #3", function() {
			
		var struct = {};
			
		var targetInfos = [ 
			[ struct,			"struct" ],
			[ global,			"global" ]];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, name, output;

		// ##### WITH + WITH + OTHER ####

		var struct1 = {};
		var struct2 = {};
			
		with (struct1) {
			with (struct2) {
					
				target = other;
				for (var j = 0; j < valueDetailsCount; j++) {
				
					valueType = valueDetails[j];
					value = valueType[0];
					details = valueType[1];
						
					name = "variable" + string(j);
					
					// check that struct does NOT exist before adding it
					output = variable_struct_exists(target, name);
					assert_false(output, "variable_struct_exists(other):" + details + ", detected a nonexistent variable");
					
					// set struct here
					variable_instance_set(target, name, value);
					
					// check if it exists
					output = variable_struct_exists(target, name);
					assert_true(output, "variable_struct_exists(other):" + details + ", failed to detect an existing variable");
					
					// delete struct
					variable_struct_remove(target, name);
				}
			}
		}
		
	});
		
	addFact("variable_struct_exists_test #4", function() {

		// ##### FAILS #####

		assert_throw(function() {
			var target = [];
			// feather ignore once GM1041
			return variable_struct_exists(target, "variable");
		}, "variable_struct_exists( array, ... ), should throw error");
		
	});
		
	addFact("variable_struct_exists_test #5", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = undefined
			// feather ignore once GM1041
			return variable_struct_exists(target, "variable");
		}, "#5 variable_struct_exists( undefined, ... ), should throw error");
		
	});
		
	addFact("variable_struct_exists_test #6", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = "string";
			// feather ignore once GM1041
			return variable_struct_exists(target, "variable");
		}, "#6 variable_struct_exists( string, ... ), should throw error");
		
	});

	addFact("variable_struct_remove_test #1", function() {
			
		var output, input = { text : "world", number: 10 };
		
		// remove variable from struct, and check that it does NOT exist anymore
		variable_struct_remove(input, "text");
		output = variable_struct_exists(input, "text");
		assert_false(output, "variable_struct_remove(...), detected unexistent variable");
		
	});

	addFact("variable_struct_remove_test #2", function() {
			
		var output, input = { text : "world", number: 10 };
		
		// remove variable from struct, and check that it does NOT exist anymore
		variable_struct_remove(input, "number");
		output = variable_struct_exists(input, "number");
		assert_false(output, "variable_struct_remove(...), detected unexistent variable");
		
	});

	addFact("variable_struct_remove_test #3", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var input = [];
			// feather ignore once GM1041
			variable_struct_remove(input, "name");
		}, "variable_struct_remove( array, ... ), should throw error");
		
	});

	addFact("variable_struct_remove_test #4", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var input = undefined;
			// feather ignore once GM1041
			variable_struct_remove(input, "name");
		}, "variable_struct_remove( undefined, ... ), should throw error");
		
	});

	addFact("variable_struct_remove_test #5", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var input = "string";
			// feather ignore once GM1041
			variable_struct_remove(input, "name");
		}, "variable_struct_exists_test( string, ... ), should throw error");
		
	});
				
	addFact("variable_struct_get_names_test #1", function() {
			
		var output, input = { text : "world", number: 10 };
		
		// get array of variable names
		output = variable_struct_get_names(input);

		// check that they are all there
		assert_array_length(output, 2, "variable_struct_get_names(), failed to detect all names");
		assert_array_contains_all(output, ["text", "number"], "variable_struct_get_names(), failed to detect the correct names");
		// remove variables from the struct
		variable_struct_remove(input, "text");
		variable_struct_remove(input, "number");
		
		// check that they were removed
		output = variable_struct_get_names(input);
		assert_array_length(output, 0, "variable_struct_get_names(), failed to detect names on empty struct");
		
	});
				
	addFact("variable_struct_get_names_test #2", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = [];
			// feather ignore once GM1041
			return variable_struct_get_names(input);
		}, "variable_struct_get_names( array, ... ), should throw error");
		
	});
				
	addFact("variable_struct_get_names_test #3", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = undefined;
			// feather ignore once GM1041
			return variable_struct_get_names(input);
		}, "variable_struct_get_names( undefined, ... ), should throw error");
		
	});
				
	addFact("variable_struct_get_names_test #4", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = "string";
			// feather ignore once GM1041
			return variable_struct_get_names(input);
		}, "variable_struct_get_names( string, ... ), should throw error");
			
	});
		
	addFact("variable_struct_names_count test #1", function() {
			
		var iterations = 100;
		var struct = {}
			
		var output, expected = array_create(iterations);
		
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the struct with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_struct_set(struct, expected[i], i);
		}
			
		// ##### GENERAL ####
		
		// get list of variable names
		output = variable_struct_get_names(struct);
		// check the number of variables is the expected one
		assert_array_length(output, length, "variable_struct_names_count(struct), failed to return the correct variable number.");
			
	});	
		
	addFact("variable_struct_names_count test #2", function() {
			
		var iterations = 100;
		var struct = {}
			
		var output, expected = array_create(iterations);
		
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the struct with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_struct_set(struct, expected[i], i);
		}
			
		// ##### WITH + SELF ####

		struct = {};
	
		with (struct) {
			
			// add a bunch of variables to the struct with different names
			for (var i = 0; i < length; i++) {
				variable_instance_set(self, expected[i], i);
			}

			// get list of variable names
			output = variable_struct_names_count(self);
			// check the number of variables is the expected one
			assert_array_length(output, length, "variable_struct_names_count(self), failed to return the correct variable number.");
		}
			
	});	
		
	addFact("variable_struct_names_count test #3", function() {
			
		var iterations = 100;
		var struct = {}
			
		var output, expected = array_create(iterations);
		
		for (var i = 0; i < iterations; i++) {
			expected[i] = "variable" + string(i);
		}
		
		// add a bunch of variables to the struct with different names
		var length = array_length(expected);
		for (var i = 0; i < length; i++) {
			variable_struct_set(struct, expected[i], i);
		}
			
		// ##### WITH + WITH + OTHER ####

		var struct1 = {};
		var struct2 = {};
	
		with (struct1) {
			with(struct2) {

				// add a bunch of variables to the struct with different names
				for (var i = 0; i < length; i++) {
					variable_instance_set(other, expected[i], i);
				}

				// get list of variable names
				output = variable_struct_names_count(other);
				// check the number of variables is the expected one
				assert_array_length(output, length, "variable_struct_names_count(other), failed to return the correct variable number.");
			}
		}
			
	});	
		
	addFact("variable_struct_names_count test #4", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = [];
			// feather ignore once GM1041
			return variable_struct_names_count(input);
		}, "variable_struct_names_count( array, ... ), should throw error");
			
	});	
		
	addFact("variable_struct_names_count test #5", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = undefined;
			// feather ignore once GM1041
			return variable_struct_names_count(input);
		}, "variable_struct_names_count( undefined, ... ), should throw error");
			
	});	
		
	addFact("variable_struct_names_count test #6", function() {
			
		// ##### FAILS #####
			
		assert_throw(function() {
			var input = "string";
			// feather ignore once GM1041
			return variable_struct_names_count(input);
		}, "variable_struct_names_count( string, ... ), should throw error");
			
	});
	
	addFact("variable_struct_set_get_test #1", function() {
			
		var targetInfos = [ 
			[ {},				"struct" ],
			[ global,			"global" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;
			
		// ##### GENERAL TYPES #####
		
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				if (details != "nan") {
				
					type = typeof(value);
					
					// set struct variable
					variable_struct_set(target, "variable", value);
					// get struct variable
					output = variable_struct_get(target, "variable");
					
					// check if the value and type is correct
					assert_equals(output, value, "variable_struct_set/get("+ info +"):" + details + ", failed to maintain value consistency");
					assert_typeof(output, type, "variable_struct_set/get("+ info +"):" + details + ", failed to maintain type consistency");
					
				}
			}
		}
			
	});

	addFact("variable_struct_set_get_test #2", function() {
			
		var targetInfos = [ 
			[ {},				"struct" ],
			[ global,			"global" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;

		// ##### WITH + SELF ####
			
		var struct = {};
				
		with (struct) {
			
			for (var j = 0; j < valueDetailsCount; j++) {
				
				valueType = valueDetails[j];
				value = valueType[0];
				details = valueType[1];
				
				if (details != "nan") {
				
					type = typeof(value);
					
					// set struct variable
					variable_struct_set(self, "variable", value);
					// get struct variable
					output = variable_struct_get(self, "variable");
					
					// check if the value and type is correct
					assert_equals(output, value, "variable_struct_set/get(self):" + details + ", failed to maintain value consistency");
					assert_typeof(output, type, "variable_struct_set/get(self):" + details + ", failed to maintain type consistency");
					
				}
			}
		}
			
	});

	addFact("variable_struct_set_get_test #3", function() {
			
		var targetInfos = [ 
			[ {},				"struct" ],
			[ global,			"global" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;

		// ##### WITH + WITH + OTHER ####

		var struct1 = {};
		var struct2 = {};
			
		with (struct1) {
			with (struct2) {
				for (var j = 0; j < valueDetailsCount; j++) {
				
					valueType = valueDetails[j];
					value = valueType[0];
					details = valueType[1];
					
					if (details != "nan") {
					
					type = typeof(value);
					
						// set struct variable
						variable_struct_set(other, "variable", value);
						// get struct variable
						output = variable_struct_get(other, "variable");
						
						// check if the value and type is correct
						assert_equals(output, value, "variable_struct_set/get(other):" + details + ", failed to maintain value consistency");
						assert_typeof(output, type, "variable_struct_set/get(other):" + details + ", failed to maintain type consistency");
						
					}
				}
			}
		}
			
	});

	addFact("variable_struct_set_get_test #4", function() {
			
		var targetInfos = [ 
			[ {},				"struct" ],
			[ global,			"global" ] ];
			
		var valueDetails = GetValueDetails();
			
		var targetInfosCount = array_length(targetInfos);
		var valueDetailsCount = array_length(valueDetails);
			
		var targetInfo, target, info, valueType, value, details, type, output;

		// ##### NAN #####
		
		type = "number"
		value = NaN;
			
		for (var i = 0; i < targetInfosCount; i++) {
			
			targetInfo = targetInfos[i];
			target = targetInfo[0];
			info = targetInfo[1];
			
			// set struct variable
			variable_struct_set(target, "variable", value);
			// get struct variable
			output = variable_struct_get(target, "variable");
			
			// check if the value and type is correct
			assert_nan(output, "variable_struct_set/get("+ info +"):" + type + ", failed to maintain value consistency");
			assert_typeof(output, type, "variable_struct_set/get("+ info +"):" + type + ", failed to maintain type consistency");

		}
			
	});

	addFact("variable_struct_set_get_test #5", function() {

		// ##### FAILS #####

		assert_throw(function() {
			var target = [];
			// feather ignore once GM1041
			variable_struct_set(target, "variable", 0);
			// feather ignore once GM1041
			return variable_struct_get(target, "variable");
		}, "variable_struct_set/get( array, ... ), should throw error");
			
	});

	addFact("variable_struct_set_get_test #6", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = undefined;
			// feather ignore once GM1041
			variable_struct_set(target, "variable", 0);
			// feather ignore once GM1041
			return variable_struct_get(target, "variable");
		}, "variable_struct_set/get( undefined, ... ), should throw error");
			
	});

	addFact("variable_struct_set_get_test #7", function() {

		// ##### FAILS #####
			
		assert_throw(function() {
			var target = "string";
			// feather ignore once GM1041
			variable_struct_set(target, "variable", 0);
			// feather ignore once GM1041
			return variable_struct_get(target, "variable");
		}, "variable_struct_set/get( string, ... ), should throw error");
			
	})

	addFact("builtin_instance_varnames_test #1", function() {

		var value = function() {};

		var output, input = { 
			x: value, y: value, xprevious: value, yprevious: value, xstart: value, ystart: value,
			hspeed: value, vspeed: value, direction: value, speed: value, friction: value, gravity: value,
			gravity_direction: value, in_collision_tree: value,

			path_index: value, path_position: value, path_positionprevious: value, path_speed: value, path_scale: value,
			path_orientation: value, path_endaction: value,

			object_index: value, id: value, solid: value, persistent: value, mask_index: value, instance_count: value,
			instance_id: value,

			alarm: value, timeline_index: value, timeline_position: value, timeline_speed: value, timeline_running: value,
			timeline_loop: value,

			visible: value, sprite_index: value, sprite_width: value, sprite_height: value, sprite_xoffset: value, 
			sprite_yoffset: value, image_number: value, image_index: value, image_speed: value, depth: value,
			image_xscale: value, image_yscale: value, image_angle: value, image_alpha: value, image_blend: value,
			bbox_left: value, bbox_right: value, bbox_top: value, bbox_bottom: value,

			message: value, longMessage: value, script: value, stacktrace: value,

			layer: value,

			in_sequence: value, sequence_instance: value 
			
		}
					
		var type = typeof(value);
			
		var names = variable_struct_get_names(input);
		var count = array_length(names);
		repeat (count) {
			var name = names[--count];
					
			output = input[$ name];
			// check if each built-in instance variable value and type is correct
			assert_equals(output, value, "struct[$ "+ name +"], failed to maintain value consistency");
			assert_typeof(output, type, "struct[$ "+ name +"], failed to maintain type consistency");
		}
	})

	addFact("builtin_constant_varnames_test #1", function() {

		var value = function() {};
			
		var output, input = {
			//self: value, // <------ Cannot set a constant to a value
			other: value,
			all: value,
			noone: value,
			global: value,
			undefined: value,
			pointer_invalid: value,
			pointer_null: value,

			path_action_stop: value,
			path_action_restart: value,
			path_action_continue: value,
			path_action_reverse: value,
			
			true: value,
			false: value,
			pi: value,
			NaN: value,
			infinity: value,
			//GM_build_date: value,
			//GM_version: value,
			//GM_runtime_version: value,


			ev_create: value,
			ev_pre_create: value,
			ev_destroy: value,
			ev_step: value,
			ev_alarm: value,
			ev_keyboard: value,
			ev_mouse: value,
			ev_collision: value,
			ev_other: value,
			ev_draw: value,
			ev_draw_begin: value,
			ev_draw_end: value,
			ev_draw_pre: value,
			ev_draw_post: value,
			ev_keypress: value,
			ev_keyrelease: value,
			ev_trigger: value,
			ev_left_button: value,
			ev_right_button: value,
			ev_middle_button: value,
			ev_no_button: value,
			ev_left_press: value,
			ev_right_press: value,
			ev_middle_press: value,
			ev_left_release: value,
			ev_right_release: value,
			ev_middle_release: value,
			ev_mouse_enter: value,
			ev_mouse_leave: value,
			ev_mouse_wheel_up: value,
			ev_mouse_wheel_down: value,
			ev_global_left_button: value,
			ev_global_right_button: value,
			ev_global_middle_button: value,
			ev_global_left_press: value,
			ev_global_right_press: value,
			ev_global_middle_press: value,
			ev_global_left_release: value,
			ev_global_right_release: value,
			ev_global_middle_release: value,
			ev_joystick1_left: value,
			ev_joystick1_right: value,
			ev_joystick1_up: value,
			ev_joystick1_down: value,
			ev_joystick1_button1: value,
			ev_joystick1_button2: value,
			ev_joystick1_button3: value,
			ev_joystick1_button4: value,
			ev_joystick1_button5: value,
			ev_joystick1_button6: value,
			ev_joystick1_button7: value,
			ev_joystick1_button8: value,
			ev_joystick2_left: value,
			ev_joystick2_right: value,
			ev_joystick2_up: value,
			ev_joystick2_down: value,
			ev_joystick2_button1: value,
			ev_joystick2_button2: value,
			ev_joystick2_button3: value,
			ev_joystick2_button4: value,
			ev_joystick2_button5: value,
			ev_joystick2_button6: value,
			ev_joystick2_button7: value,
			ev_joystick2_button8: value,
			ev_outside: value,
			ev_boundary: value,
			ev_boundary_view0: value,
			ev_boundary_view1: value,
			ev_boundary_view2: value,
			ev_boundary_view3: value,
			ev_boundary_view4: value,
			ev_boundary_view5: value,
			ev_boundary_view6: value,
			ev_boundary_view7: value,
			ev_game_start: value,
			ev_game_end: value,
			ev_room_start: value,
			ev_room_end: value,
			ev_no_more_lives: value,
			ev_animation_end: value,
			ev_end_of_path: value,
			ev_no_more_health: value,
			ev_user0: value,
			ev_user1: value,
			ev_user2: value,
			ev_user3: value,
			ev_user4: value,
			ev_user5: value,
			ev_user6: value,
			ev_user7: value,
			ev_user8: value,
			ev_user9: value,
			ev_user10: value,
			ev_user11: value,
			ev_user12: value,
			ev_user13: value,
			ev_user14: value,
			ev_user15: value,
			ev_outside_view0: value,
			ev_outside_view1: value,
			ev_outside_view2: value,
			ev_outside_view3: value,
			ev_outside_view4: value,
			ev_outside_view5: value,
			ev_outside_view6: value,
			ev_outside_view7: value,
			ev_boundary_view0: value,
			ev_boundary_view1: value,
			ev_boundary_view2: value,
			ev_boundary_view3: value,
			ev_boundary_view4: value,
			ev_boundary_view5: value,
			ev_boundary_view6: value,
			ev_boundary_view7: value,
			ev_animation_update: value,
			ev_animation_event: value,
			ev_web_image_load: value,
			ev_web_sound_load: value,
			ev_web_async: value,
			ev_dialog_async: value,
			ev_web_iap: value,
			ev_web_cloud: value,
			ev_web_networking: value,
			ev_web_steam: value,
			ev_social: value,
			ev_push_notification: value,
			ev_async_save_load: value,
			ev_audio_recording: value,
			ev_audio_playback: value,
			ev_system_event: value,
			ev_broadcast_message: value,
			ev_step_normal: value,
			ev_step_begin: value,
			ev_step_end: value,
			ev_gui: value,
			ev_gui_begin: value,
			ev_gui_end: value,
			ev_cleanup: value,

			ev_gesture: value,

			ev_gesture_tap: value,
			ev_gesture_double_tap: value,
			ev_gesture_drag_start: value,
			ev_gesture_dragging: value,
			ev_gesture_drag_end: value,
			ev_gesture_flick: value,
			ev_gesture_pinch_start: value,
			ev_gesture_pinch_in: value,
			ev_gesture_pinch_out: value,
			ev_gesture_pinch_end: value,
			ev_gesture_rotate_start: value,
			ev_gesture_rotating: value,
			ev_gesture_rotate_end: value,
			ev_global_gesture_tap: value,
			ev_global_gesture_double_tap: value,
			ev_global_gesture_drag_start: value,
			ev_global_gesture_dragging: value,
			ev_global_gesture_drag_end: value,
			ev_global_gesture_flick: value,
			ev_global_gesture_pinch_start: value,
			ev_global_gesture_pinch_in: value,
			ev_global_gesture_pinch_out: value,
			ev_global_gesture_pinch_end: value,
			ev_global_gesture_rotate_start: value,
			ev_global_gesture_rotating: value,
			ev_global_gesture_rotate_end: value,
			ev_async_web_image_load: value,
			ev_async_web: value,
			ev_async_dialog: value,
			ev_async_web_iap: value,
			ev_async_web_cloud: value,
			ev_async_web_networking: value,
			ev_async_web_steam: value,
			ev_async_social: value,
			ev_async_push_notification: value,
			ev_async_save_load: value,
			ev_async_audio_recording: value,
			ev_async_audio_playback: value,
			ev_async_audio_playback_ended: value,
			ev_async_system_event: value,

			vk_nokey: value,
			vk_anykey: value,
			vk_enter: value,
			vk_return: value,
			vk_shift: value,
			vk_control: value,
			vk_alt: value,
			vk_escape: value,
			vk_space: value,
			vk_backspace: value,
			vk_tab: value,
			vk_pause: value,
			vk_printscreen: value,
			vk_left: value,
			vk_right: value,
			vk_up: value,
			vk_down: value,
			vk_home: value,
			vk_end: value,
			vk_delete: value,
			vk_insert: value,
			vk_pageup: value,
			vk_pagedown: value,
			vk_f1: value,
			vk_f2: value,
			vk_f3: value,
			vk_f4: value,
			vk_f5: value,
			vk_f6: value,
			vk_f7: value,
			vk_f8: value,
			vk_f9: value,
			vk_f10: value,
			vk_f11: value,
			vk_f12: value,
			vk_numpad0: value,
			vk_numpad1: value,
			vk_numpad2: value,
			vk_numpad3: value,
			vk_numpad4: value,
			vk_numpad5: value,
			vk_numpad6: value,
			vk_numpad7: value,
			vk_numpad8: value,
			vk_numpad9: value,
			vk_divide: value,
			vk_multiply: value,
			vk_subtract: value,
			vk_add: value,
			vk_decimal: value,
			vk_lshift: value,
			vk_lcontrol: value,
			vk_lalt: value,
			vk_rshift: value,
			vk_rcontrol: value,
			vk_ralt: value,

			mb_any: value,
			mb_none: value,
			mb_left: value,
			mb_right: value,
			mb_middle: value,
			mb_side1: value,
			mb_side2: value,

			c_aqua: value,
			c_black: value,
			c_blue: value,
			c_dkgray: value,
			c_dkgrey: value,
			c_fuchsia: value,
			c_gray: value,
			c_grey: value,
			c_green: value,
			c_lime: value,
			c_ltgray: value,
			c_ltgrey: value,
			c_maroon: value,
			c_navy: value,
			c_olive: value,
			c_purple: value,
			c_red: value,
			c_silver: value,
			c_teal: value,
			c_white: value,
			c_yellow: value,
			c_orange: value,


			fa_left: value,
			fa_center: value,
			fa_right: value,

			fa_top: value,
			fa_middle: value,
			fa_bottom: value,

			pr_pointlist: value,
			pr_linelist: value,
			pr_linestrip: value,
			pr_trianglelist: value,
			pr_trianglestrip: value,
			pr_trianglefan: value,

			bm_normal: value,
			bm_add: value,
			bm_max: value,
			bm_min: value,
			bm_subtract: value,
			bm_zero: value,
			bm_one: value,
			bm_reverse_subtract: value,

			bm_src_colour: value,
			bm_inv_src_colour: value,
			bm_src_color: value,
			bm_inv_src_color: value,
			bm_src_alpha: value,
			bm_inv_src_alpha: value,
			bm_dest_alpha: value,
			bm_inv_dest_alpha: value,
			bm_dest_colour: value,
			bm_inv_dest_colour: value,
			bm_dest_color: value,
			bm_inv_dest_color: value,
			bm_src_alpha_sat: value,

			tf_point: value,
			tf_linear: value,
			tf_anisotropic: value,

			mip_off: value,
			mip_on: value,
			mip_markedonly: value,

			audio_falloff_none: value,
			audio_falloff_inverse_distance: value,
			audio_falloff_inverse_distance_clamped: value,
			audio_falloff_linear_distance: value,
			audio_falloff_linear_distance_clamped: value,
			audio_falloff_exponent_distance: value,
			audio_falloff_exponent_distance_clamped: value,

			audio_mono: value,
			audio_stereo: value,
			audio_3D: value,

			cr_default: value,
			cr_none: value,
			cr_arrow: value,
			cr_cross: value,
			cr_beam: value,
			cr_size_nesw: value,
			cr_size_ns: value,
			cr_size_nwse: value,
			cr_size_we: value,
			cr_uparrow: value,
			cr_hourglass: value,
			cr_drag: value,
			cr_appstart: value,
			cr_handpoint: value,
			cr_size_all: value,

			asset_object: value,
			asset_unknown: value,
			asset_sprite: value,
			asset_sound: value,
			asset_room: value,
			asset_path: value,
			asset_script: value,
			asset_font: value,
			asset_timeline: value,
			asset_tiles: value,
			asset_shader: value,
			asset_sequence: value,
			asset_animationcurve: value,

			fa_readonly: value,
			fa_hidden: value,
			fa_sysfile: value,
			fa_volumeid: value,
			fa_directory: value,
			fa_archive: value,

			ds_type_map: value,
			ds_type_list: value,
			ds_type_stack: value,
			ds_type_queue: value,
			ds_type_grid: value,
			ds_type_priority: value,

			ef_explosion: value,
			ef_ring: value,
			ef_ellipse: value,
			ef_firework: value,
			ef_smoke: value,
			ef_smokeup: value,
			ef_star: value,
			ef_spark: value,
			ef_flare: value,
			ef_cloud: value,
			ef_rain: value,
			ef_snow: value,

			pt_shape_pixel: value,
			pt_shape_disk: value,
			pt_shape_square: value,
			pt_shape_line: value,
			pt_shape_star: value,
			pt_shape_circle: value,
			pt_shape_ring: value,
			pt_shape_sphere: value,
			pt_shape_flare: value,
			pt_shape_spark: value,
			pt_shape_explosion: value,
			pt_shape_cloud: value,
			pt_shape_smoke: value,
			pt_shape_snow: value,

			ps_distr_linear: value,
			ps_distr_gaussian: value,
			ps_distr_invgaussian: value,
			ps_shape_rectangle: value,
			ps_shape_ellipse: value,
			ps_shape_diamond: value,
			ps_shape_line: value,
			ps_mode_burst: value,
			ps_mode_stream: value,

			os_windows: value,
			os_macosx: value,
			os_ios: value,
			os_android: value,
			os_linux: value,
			os_unknown: value,
			os_winphone: value,
			os_win8native: value,
			os_psvita: value,
			os_ps4: value,
			os_xboxone: value,
			os_ps3: value,
			os_uwp: value,
			os_tvos: value,
			os_switch: value,
			os_ps5: value,
			os_xboxseriesxs: value,
			os_operagx: value,

			browser_not_a_browser: value,
			browser_unknown: value,
			browser_ie: value,
			browser_firefox: value,
			browser_chrome: value,
			browser_safari: value,
			browser_safari_mobile: value,
			browser_opera: value,
			browser_tizen: value,
			browser_edge: value,
			browser_windows_store: value,
			browser_ie_mobile: value,

			device_ios_unknown: value,
			device_ios_iphone: value,
			device_ios_iphone_retina: value,
			device_ios_ipad: value,
			device_ios_ipad_retina: value,
			device_ios_iphone5: value,
			device_ios_iphone6: value,
			device_ios_iphone6plus: value,

			device_emulator: value,
			device_tablet: value,

			display_landscape: value,
			display_landscape_flipped: value,
			display_portrait: value,
			display_portrait_flipped: value,

			cmpfunc_never: value,
			cmpfunc_less: value,
			cmpfunc_equal: value,
			cmpfunc_lessequal: value,
			cmpfunc_greater: value,
			cmpfunc_notequal: value,
			cmpfunc_greaterequal: value,
			cmpfunc_always: value,

			cull_noculling: value,
			cull_clockwise: value,
			cull_counterclockwise: value,

			lighttype_dir: value,
			lighttype_point: value,

			buffer_fixed: value,
			buffer_grow: value,
			buffer_wrap: value,
			buffer_fast: value,
			buffer_vbuffer: value,
			buffer_u8: value,
			buffer_s8: value,
			buffer_u16: value,
			buffer_s16: value,
			buffer_u32: value,
			buffer_s32: value,
			buffer_u64: value,
			buffer_f16: value,
			buffer_f32: value,
			buffer_f64: value,
			buffer_bool: value,
			buffer_text: value,
			buffer_string: value,

			buffer_seek_start: value,
			buffer_seek_relative: value,
			buffer_seek_end: value,

			gp_face1: value,
			gp_face2: value,
			gp_face3: value,
			gp_face4: value,
			gp_shoulderl: value,
			gp_shoulderr: value,
			gp_shoulderlb: value,
			gp_shoulderrb: value,
			gp_select: value,
			gp_start: value,
			gp_stickl: value,
			gp_stickr: value,
			gp_padu: value,
			gp_padd: value,
			gp_padl: value,
			gp_padr: value,
			gp_axislh: value,
			gp_axislv: value,
			gp_axisrh: value,
			gp_axisrv: value,
			gp_touchpadbutton: value,

			gp_axis_acceleration_x: value,
			gp_axis_acceleration_y: value,
			gp_axis_acceleration_z: value,

			gp_axis_angular_velocity_x: value,
			gp_axis_angular_velocity_y: value,
			gp_axis_angular_velocity_z: value,

			gp_axis_orientation_x: value,
			gp_axis_orientation_y: value,
			gp_axis_orientation_z: value,
			gp_axis_orientation_w: value,

			vertex_usage_position: value,
			vertex_usage_colour: value,
			vertex_usage_color: value,
			vertex_usage_normal: value,
			vertex_usage_texcoord: value,
			vertex_usage_blendweight: value,
			vertex_usage_blendindices: value,
			vertex_usage_psize: value,
			vertex_usage_tangent: value,
			vertex_usage_binormal: value,
			vertex_usage_fog: value,
			vertex_usage_depth: value,
			vertex_usage_sample: value,

			vertex_type_float1: value,
			vertex_type_float2: value,
			vertex_type_float3: value,
			vertex_type_float4: value,
			vertex_type_colour: value,
			vertex_type_color: value,
			vertex_type_ubyte4: value,

			layerelementtype_undefined: value,
			layerelementtype_background: value,
			layerelementtype_instance: value,
			layerelementtype_oldtilemap: value,
			layerelementtype_sprite: value,
			layerelementtype_tilemap: value,
			layerelementtype_particlesystem: value,
			layerelementtype_tile: value,
			layerelementtype_sequence: value,

			kbv_type_default: value,
			kbv_type_ascii: value,
			kbv_type_url: value,
			kbv_type_email: value,
			kbv_type_numbers: value,
			kbv_type_phone: value,
			kbv_type_phone_name: value,

			kbv_returnkey_default: value,
			kbv_returnkey_go: value,
			kbv_returnkey_google: value,
			kbv_returnkey_join: value,
			kbv_returnkey_next: value,
			kbv_returnkey_route: value,
			kbv_returnkey_search: value,
			kbv_returnkey_send: value,
			kbv_returnkey_yahoo: value,
			kbv_returnkey_done: value,
			kbv_returnkey_continue: value,
			kbv_returnkey_emergency: value,

			kbv_autocapitalize_none: value,
			kbv_autocapitalize_words: value,
			kbv_autocapitalize_sentences: value,
			kbv_autocapitalize_characters: value,

			os_permission_denied_dont_request: value,
			os_permission_denied: value,
			os_permission_granted: value,

			nineslice_left: value,
			nineslice_top: value,
			nineslice_right: value,
			nineslice_bottom: value,
			nineslice_centre: value,
			nineslice_center: value,

			nineslice_stretch: value,
			nineslice_repeat: value,
			nineslice_mirror: value,
			nineslice_blank: value,
			nineslice_hide: value,

			seqtracktype_graphic: value,
			seqtracktype_audio: value,
			seqtracktype_real: value,
			seqtracktype_color: value,
			seqtracktype_colour: value,
			seqtracktype_bool: value,
			seqtracktype_string: value,
			seqtracktype_sequence: value,
			seqtracktype_clipmask: value,
			seqtracktype_clipmask_mask: value,
			seqtracktype_clipmask_subject: value,
			seqtracktype_group: value,
			seqtracktype_empty: value,
			seqtracktype_spriteframes: value,
			seqtracktype_instance: value,
			seqtracktype_message: value,
			seqtracktype_moment: value,

			seqplay_oneshot: value,
			seqplay_loop: value,
			seqplay_pingpong: value,

			seqdir_right: value,
			seqdir_left: value,

			seqinterpolation_assign: value,
			seqinterpolation_lerp: value,

			seqaudiokey_loop: value,
			seqaudiokey_oneshot: value,

			animcurvetype_linear: value,
			animcurvetype_catmullrom: value,
			
			bboxkind_diamond: value,
			bboxkind_ellipse: value,
			bboxkind_precise: value,
			bboxkind_rectangular: value,
			
			bboxmode_automatic: value,
			bboxmode_fullimage: value,
			bboxmode_manual: value,
			
			dll_cdecl: value,
			dll_stdcall: value,
			
			gamespeed_fps: value,
			gamespeed_microseconds: value,
			
			m_axisx: value,
			m_axisx_gui: value,
			m_axisy: value,
			m_axisy_gui: value,
			m_scroll_down: value,
			m_scroll_up: value,
			
			matrix_projection: value,
			matrix_view: value,
			matrix_world: value,
			
			network_config_avoid_time_wait: value,
			network_config_connect_timeout: value,
			network_config_disable_multicast: value,
			network_config_disable_reliable_udp: value,
			network_config_enable_multicast: value,
			network_config_enable_reliable_udp: value,
			network_config_use_non_blocking_socket: value,
			network_config_websocket_protocol: value,
			network_connect_active: value,
			network_connect_blocking: value,
			network_connect_nonblocking: value,
			network_connect_none: value,
			network_connect_passive: value,
			network_send_binary: value,
			network_send_text: value,
			network_socket_bluetooth: value,
			network_socket_tcp: value,
			network_socket_udp: value,
			network_socket_ws: value,
			network_type_connect: value,
			network_type_data: value,
			network_type_disconnect: value,
			network_type_down: value,
			network_type_non_blocking_connect: value,
			network_type_up: value,
			network_type_up_failed: value,
			
			phy_debug_render_aabb: value,
			phy_debug_render_collision_pairs: value,
			phy_debug_render_coms: value,
			phy_debug_render_core_shapes: value,
			phy_debug_render_joints: value,
			phy_debug_render_obb: value,
			phy_debug_render_shapes: value,
			phy_joint_anchor_1_x: value,
			phy_joint_anchor_1_y: value,
			phy_joint_anchor_2_x: value,
			phy_joint_anchor_2_y: value,
			phy_joint_angle: value,
			phy_joint_angle_limits: value,
			phy_joint_damping_ratio: value,
			phy_joint_frequency: value,
			phy_joint_length_1: value,
			phy_joint_length_2: value,
			phy_joint_lower_angle_limit: value,
			phy_joint_max_force: value,
			phy_joint_max_length: value,
			phy_joint_max_motor_force: value,
			phy_joint_max_motor_torque: value,
			phy_joint_motor_force: value,
			phy_joint_motor_speed: value,
			phy_joint_motor_torque: value,
			phy_joint_reaction_force_x: value,
			phy_joint_reaction_force_y: value,
			phy_joint_reaction_torque: value,
			phy_joint_speed: value,
			phy_joint_translation: value,
			phy_joint_upper_angle_limit: value,
			phy_particle_data_flag_category: value,
			phy_particle_data_flag_color: value,
			phy_particle_data_flag_position: value,
			phy_particle_data_flag_typeflags: value,
			phy_particle_data_flag_velocity: value,
			phy_particle_flag_colormixing: value,
			phy_particle_flag_elastic: value,
			phy_particle_flag_powder: value,
			phy_particle_flag_spring: value,
			phy_particle_flag_tensile: value,
			phy_particle_flag_viscous: value,
			phy_particle_flag_wall: value,
			phy_particle_flag_water: value,
			phy_particle_flag_zombie: value,
			phy_particle_group_flag_rigid: value,
			phy_particle_group_flag_solid: value,
			
			seqtextkey_bottom: value,
			seqtextkey_center: value,	
			seqtextkey_justify: value,
			seqtextkey_left: value,
			seqtextkey_middle: value,
			seqtextkey_right: value,
			seqtextkey_top: value,
			
			spritespeed_framespergameframe: value,
			spritespeed_framespersecond: value,
			
			surface_r16float: value,	  
			surface_r32float: value,	  
			surface_r8unorm: value,
			surface_rg8unorm: value,
			surface_rgba16float: value,
			surface_rgba32float: value,
			surface_rgba4unorm: value,
			surface_rgba8unorm: value,
			
			texturegroup_status_fetched: value,
			texturegroup_status_loaded: value,
			texturegroup_status_loading: value,
			texturegroup_status_unloaded: value,
			
			tile_flip: value,
			tile_index_mask: value,
			tile_mirror: value,
			tile_rotate: value,
			
			time_source_expire_after: value,
			time_source_expire_nearest: value,
			time_source_game: value,
			time_source_global: value,
			time_source_state_active: value,
			time_source_state_initial: value,
			time_source_state_paused: value,
			time_source_state_stopped: value,
			time_source_units_frames: value,
			time_source_units_seconds: value,
			
			timezone_local: value,
			timezone_utc: value,
			
			tm_countvsyncs: value,
			tm_sleep: value,
			tm_systemtiming: value,
			
			ty_real: value,
			ty_string: value,
			
			video_format_rgba: value,
			video_format_yuv: value,
			
			video_status_closed: value,
			video_status_paused: value,
			video_status_playing: value,
			video_status_preparing: value
			
			
		}
					
		var type = typeof(value);
			
		var names = variable_struct_get_names(input);
		var count = array_length(names);
		
		repeat (count) {
			var name = names[--count];
					
			output = input[$ name];
			// check if each built-in constant variable value and type is correct
			assert_equals(output, value, "struct[$ "+ name +"], failed to maintain value consistency");
			assert_typeof(output, type, "struct[$ "+ name +"], failed to maintain type consistency");
			
		}
		
	})

}