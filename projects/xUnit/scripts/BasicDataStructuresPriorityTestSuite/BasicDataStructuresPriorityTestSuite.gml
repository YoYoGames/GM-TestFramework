

function BasicDataStructuresPriorityTestSuite() : TestSuite() constructor {

	addFact("ds_priority_create_test #1", function() {
						
		var priority = ds_priority_create();
			
		var output = ds_exists(priority, ds_type_priority);
		assert_true(output, "ds_priority_create(), failed to create priority");
			
		ds_priority_destroy(priority);
	});
	
	// PRIORITY ADD TESTS
	
	addFact("ds_priority_add_test #1", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_size(priority);
		assert_equals(output, 5, "ds_priority_add(), failed to add the correct number or elements");

	});
	
	// PRIORITY FIND TESTS
	
	addFact("ds_priority_find_test #1", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 5000, "ds_priority_find_min(), failed to retrieve the correct value");

	});
	
	addFact("ds_priority_find_test #2", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 1000, "ds_priority_find_max(), failed to retrieve the correct value");

	});
	
	addFact("ds_priority_find_test #3", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_find_priority(priority, 3000);
		assert_equals(output, 6, "ds_priority_find_priority(), failed to retrieve the correct value");

	});
	
	// PRIORITY DELETE TESTS
	
	addFact("ds_priority_add_find_delete_test #1", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_delete_min(priority);
		assert_equals(output, 5000, "ds_priority_delete_min(), failed to delete/retrieve the correct value");
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 4000, "ds_priority_find_min(), failed to retrieve the correct value (after deletion)");

	});

	addFact("ds_priority_add_find_delete_test #2", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_delete_max(priority);
		assert_equals(output, 1000, "ds_priority_delete_max(), failed to delete/retrieve the correct value");
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 2000, "ds_priority_find_max(), failed to retrieve the correct value (after deletion)");

	});
	
	addFact("ds_priority_add_find_delete_test #3", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		ds_priority_delete_value(priority, 3000);
		output = ds_priority_size(priority);
		assert_equals(output, 4, "ds_priority_delete_value(), failed to change the priority size");

	});

	// PRIORITY CHANGE TESTS

	addFact("ds_priority_change_test #1", function() {

		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		ds_priority_change_priority(priority, 1000, 90);
		output = ds_priority_find_priority(priority, 1000);
		assert_equals(output, 90, "ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_change_priority(priority, 3000, 80);
		output = ds_priority_find_priority(priority, 3000);
		assert_equals(output, 80, "ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_change_priority(priority, 5000, 70);
		output = ds_priority_find_priority(priority, 5000);
		assert_equals(output, 70, "ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_destroy(priority);
	})
	
	// PRIORITY COPY TESTS

	addFact("ds_priority_copy_test #1", function() {

		var priority, copiedPriority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 10, 5);
		ds_priority_add(priority, 100, 20);
		ds_priority_add(priority, 1000, 100);
			
		copiedPriority = ds_priority_create();
		ds_priority_copy(copiedPriority, priority);
		
		// Could do an assert_priority_queue_equals instead of all this 
		// |
		// V
		
		output = ds_priority_size(priority);
		assert_equals(output, 3, "ds_priority_copy(), failed to copy the correct number of elements");
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 1000, "ds_priority_copy(), failed to copy the correct data");
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 10, "ds_priority_copy(), failed to copy the correct data");
			
		output = ds_priority_find_priority(priority, 100);
		assert_equals(output, 20, "ds_priority_copy(), failed to copy the correct data");
			
		ds_priority_destroy(priority);
		ds_priority_destroy(copiedPriority);
	});
	
	// PRIORITY EMPTY TESTS
	
	addFact("ds_priority_empty_test #1", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		
		output = ds_priority_empty(priority);
		assert_true(output, "ds_priority_clear(), failed to clear a priority queue");
			
		ds_priority_destroy(priority);
	});
	
	addFact("ds_priority_empty_test #2", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 100, 20);
			
		output = ds_priority_empty(priority);
		assert_false(output, "ds_priority_clear(), failed to clear a priority queue");
			
		ds_priority_destroy(priority);
	});
	
	// PRIORITY CLEAR TESTS

	addFact("ds_priority_clear_test #1", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 100, 20);
			
		ds_priority_clear(priority);
		output = ds_priority_empty(priority);
		assert_true(output, "ds_priority_clear(), failed to clear a priority queue");
			
		ds_priority_destroy(priority);
	});

	// PRIORITY READ WRITE TESTS

	addFact("ds_priority_read_write_test #1", function() {
			
		var priority, writtenPriority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 100, 20);
		ds_priority_add(priority, 1000, 100);
		ds_priority_delete_value(priority, 1000);
			
		var checkValue = "F701000001000000000000000000000000003440000000000000000000005940";
			
		writtenPriority = ds_priority_write(priority);
		assert_equals(writtenPriority, checkValue, "ds_priority_write(), doesn't match pre-baked encoded string");
			
		ds_priority_clear(priority);
			
		ds_priority_read(priority, writtenPriority);
		output = ds_priority_size(priority);
		assert_equals(output, 1, "ds_priority_read(), failed to read the correct number of elements");
		output = ds_priority_find_max(priority);
		assert_equals(output, 100, "ds_priority_read(), failed to read the correct data");
			
		ds_priority_destroy(priority);
	});
	
}