

function BasicDataStructuresPriorityTestSuite() : TestSuite() constructor {

	addFact("ds_priority_create_test", function() {
						
		var priority = ds_priority_create();
			
		var output = ds_exists(priority, ds_type_priority);
		assert_true(output, "#1 ds_priority_create(), failed to create priority");
			
		ds_priority_destroy(priority);
	})

	addFact("ds_priority_add_find_delete_test", function() {
			
		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		output = ds_priority_size(priority);
		assert_equals(output, 5, "#1 ds_priority_add(), failed to add the correct number or elements");
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 5000, "#2 ds_priority_find_min(), failed to retrieve the correct value");
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 1000, "#3 ds_priority_find_max(), failed to retrieve the correct value");
			
		output = ds_priority_find_priority(priority, 3000);
		assert_equals(output, 6, "#4 ds_priority_find_priority(), failed to retrieve the correct value");
			
			
		output = ds_priority_delete_min(priority);
		assert_equals(output, 5000, "#5 ds_priority_delete_min(), failed to delete/retrieve the correct value");
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 4000, "#6 ds_priority_find_min(), failed to retrieve the correct value (after deletion)");
			
		output = ds_priority_delete_max(priority);
		assert_equals(output, 1000, "#7 ds_priority_delete_max(), failed to delete/retrieve the correct value");
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 2000, "#8 ds_priority_find_max(), failed to retrieve the correct value (after deletion)");
			
		ds_priority_delete_value(priority, 3000);
		output = ds_priority_size(priority);
		assert_equals(output, 2, "#9 ds_priority_delete_value(), failed to change the priority size");

	})

	addFact("ds_priority_change_test", function() {

		var priority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 1000, 10);
		ds_priority_add(priority, 2000, 8);
		ds_priority_add(priority, 3000, 6);
		ds_priority_add(priority, 4000, 4);
		ds_priority_add(priority, 5000, 2);
			
		ds_priority_change_priority(priority, 1000, 90);
		output = ds_priority_find_priority(priority, 1000);
		assert_equals(output, 90, "#1.1 ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_change_priority(priority, 3000, 80);
		output = ds_priority_find_priority(priority, 3000);
		assert_equals(output, 80, "#1.2 ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_change_priority(priority, 5000, 70);
		output = ds_priority_find_priority(priority, 5000);
		assert_equals(output, 70, "#1.3 ds_priority_change/find_priority(), failed to find/retrieve the correct value");
			
		ds_priority_destroy(priority);
	})

	addFact("ds_priority_copy_test", function() {

		var priority, copiedPriority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 10, 5);
		ds_priority_add(priority, 100, 20);
		ds_priority_add(priority, 1000, 100);
			
		copiedPriority = ds_priority_create();
		ds_priority_copy(copiedPriority, priority);
			
		output = ds_priority_size(priority);
		assert_equals(output, 3, "#1 ds_priority_copy(), failed to copy the correct number of elements");
			
		output = ds_priority_find_max(priority);
		assert_equals(output, 1000, "#2.1 ds_priority_copy(), failed to copy the correct data");
			
		output = ds_priority_find_min(priority);
		assert_equals(output, 10, "#2.2 ds_priority_copy(), failed to copy the correct data");
			
		output = ds_priority_find_priority(priority, 100);
		assert_equals(output, 20, "#2.3 ds_priority_copy(), failed to copy the correct data");
			
		ds_priority_destroy(priority);
		ds_priority_destroy(copiedPriority);
	})

	addFact("ds_priority_read_write_test", function() {
			
		var priority, writtenPriority, output;
			
		priority = ds_priority_create();
		ds_priority_add(priority, 100, 20);
		ds_priority_add(priority, 1000, 100);
		ds_priority_delete_value(priority, 1000);
			
		var checkValue = "F701000001000000000000000000000000003440000000000000000000005940";
			
		writtenPriority = ds_priority_write(priority);
		assert_equals(writtenPriority, checkValue, "#1 ds_priority_write(), doesn't match pre-baked encoded string");
			
		output = ds_priority_empty(priority);
		assert_false(output, "#2 ds_priority_empty(), filed to detect non-empty queue");
			
		ds_priority_clear(priority);
		output = ds_priority_empty(priority);
		assert_true(output, "#3 ds_priority_clear(), failed to clear a priority queue");
			
		ds_priority_read(priority, writtenPriority);
		output = ds_priority_size(priority);
		assert_equals(output, 1, "#4 ds_priority_read(), failed to read the correct number of elements");
		output = ds_priority_find_max(priority);
		assert_equals(output, 100, "#5 ds_priority_read(), failed to read the correct data");
			
		ds_priority_destroy(priority);
	})
	
}