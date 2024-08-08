

function BasicDataStructuresListTestSuite() : TestSuite() constructor {

	addFact("ds_list_create_test", function() {

		var list = ds_list_create();
		
		var _output = ds_exists(list, ds_type_list);
		assert_true(_output, "#1 ds_list_create(), failed to create list");
			
		// Clean up
		ds_list_destroy(list);
	});

	// LIST ADD TESTS
	
	addFact("ds_list_add test #1", function() {

		//SB: ds_list_add, ds_list_size
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, 40, 50);
		assert_list_equals_array(list, [10, 20, 30, 40, 50], "ds_list_add(..), failed to correctly add entries to the list");
		
		assert_list_size(list, 5, "ds_list_size(..), failed to return correct list size");
		
		// Clean up
		ds_list_destroy(list);
	});
	
	// LIST SET TESTS
	
	addFact("ds_list_set test #1", function() {

		//SB: ds_list_add, ds_list_size
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, 40, 50);
		ds_list_set(list, 0, 60);
		
		output = list[| 0];
		assert_equals(output, 60, "ds_list_set(...), failed to set the correct value on a valid index");
		
		// Clean up
		ds_list_destroy(list);
	});
	
	// LIST INSERT TEST
	
	addFact("ds_list_insert test #1", function() {

		//SB: ds_list_add, ds_list_size
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, 40, 50);
		
		ds_list_insert(list, 1, 70);
		assert_list_equals_array(list, [10, 70, 20, 30, 40, 50], "ds_list_insert(...), failed to insert the correct value on a valid index");
		
		output = ds_list_size(list);
		assert_list_size(list, 6, "ds_list_insert(..), failed to resize the list using out-of-bounds index");
		
		// Clean up
		ds_list_destroy(list);
	});

	// LIST DELETE TESTS

	addFact("ds_list_delete test #1", function() {

		//SB: ds_list_add, ds_list_size
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, 40, 50);
		
		ds_list_delete(list, 2);
		assert_list_equals_array(list, [10, 20, 40, 50], "ds_list_insert(...), failed to insert the correct value on a valid index");
		assert_list_size(list, 4, "ds_list_delete(..), failed to resize the list");
		
		// Clean up
		ds_list_destroy(list);
	});

	// LIST COPY TESTS

	addFact("ds_list_copy_test #1", function() {

		//SB: ds_list_copy/insert/replace/delete/sort/set and ds_list_find_index/value
				
		ds_set_precision(0.00001);
		
		var output, list;
		
		list = ds_list_create();
			
		ds_list_add(list, 50, 40.001, 30.992, 20, 10, 0.01);
			
		var copiedList = ds_list_create();
			
		ds_list_copy(copiedList, list);
		assert_list_size(list, 6, "ds_list_copy(), failed to create a list of the same size");
		assert_list_equals_array(list, [50, 40.001, 30.992, 20, 10, 0.01], "ds_list_copy(), failed to create a list with correct entries");
					
		// Clean up
		ds_list_destroy(list);
		ds_list_destroy(copiedList);
		
	})

	// LIST SORT TESTS

	addFact("ds_list_sort test #1", function() {
			
		ds_set_precision(0.00001);
		
		var output, list;
		
		list = ds_list_create();
			
		ds_list_add(list, 50, 40.001, 30.992, 20, 10, 0.01);
			
		ds_list_sort(list, true)
		assert_list_equals_array(list, [0.01, 10, 20, 30.992, 40.001, 50], "ds_list_sort(), failed to sort the list correctly (ascending)");
			
		// Clean up
		ds_list_destroy(list);
		
	});

	addFact("ds_list_sort test #2", function() {
			
		ds_set_precision(0.00001);
		
		var output, list;
		
		list = ds_list_create();
			
		ds_list_add(list, 50, 40.001, 30.992, 20, 10, 0.01);
			
		ds_list_sort(list, false)
		assert_list_equals_array(list, [50, 40.001, 30.992, 20, 10, 0.01], "ds_list_sort(), failed to sort the list correctly (descending)");
			
		// Clean up
		ds_list_destroy(list);
		
	});
	
	// LIST MARK TESTS

	addFact("ds_list_mark test #1", function() {

		//SB: ds_list_add, ds_list_size, ds_list_mark_as_list and ds_list_mark_as_map
			
		ds_set_precision(0.00001);
		
		var list, output, listToAdd;
		
		list = ds_list_create();
		listToAdd = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, listToAdd);
		
		output = ds_list_is_list(list, 3);
		assert_false(output, "ds_list_is_list(), detected an unmarked list");
		
		ds_list_mark_as_list(list, 3);

		output = ds_list_is_list(list, 3);
		assert_true(output, "ds_list_mark_as_list(), failed to mark list");
			
		ds_list_sort(list, true);
		output = ds_list_is_list(list, 0);
		assert_true(output, "ds_list_sort(), messed with marked list");
		
		// Clean up
		ds_list_destroy(list);
		
	});

	addFact("ds_list_mark test #2", function() {

		//SB: ds_list_add, ds_list_size, ds_list_mark_as_list and ds_list_mark_as_map
			
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30);
		
		var mapToAdd = ds_map_create();
		
		ds_list_add(list, mapToAdd);
		
		output = ds_list_is_map(list, 3);
		assert_false(output, "ds_list_is_map(), detected an unmarked map");
		
		ds_list_mark_as_map(list, 3);
		
		output = ds_list_is_map(list, 3);
		assert_true(output, "ds_list_mark_as_map(), failed to mark map");
		
		// Clean up
		ds_list_destroy(list);
		
	});
	
	// LIST READ WRITE TESTS
	
	addFact("ds_list_read_write_clear_test", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
			
		var list = ds_list_create();
			
		ds_list_add(list, "hello", 30, 20, 10, "world");
			
		var writtenList = ds_list_write(list);
			
		ds_list_clear(list);
		assert_list_empty(list, "#1 ds_list_clear(), failed to clear a list");
		
		ds_list_read(list, writtenList);
		assert_list_equals_array(list, ["hello", 30, 20, 10, "world"], "#2 ds_list_read(), failed to correctly read the list");
			
		var oldWrittenList = "2F01000005000000010000000500000068656C6C6F000000000000000000003E400000000000000000000034400000000000000000000024400100000005000000776F726C64";
		
		ds_list_clear(list);
		ds_list_read(list, oldWrittenList);
		assert_list_equals_array(list, ["hello", 30, 20, 10, "world"], "#3 ds_list_read(), failed to correctly read the list (from backed string)");
			
		ds_list_destroy(list);

	});
	
	// LIST FIND TESTS
	
	addFact("ds_list_find_test #1", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, "hello");
		assert_equals(output, 0, "ds_list_find_index(), failed to find index of a valid entry (string)");
		
		ds_list_destroy(list);
		
	});
	
	addFact("ds_list_find_test #2", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, 30);
		assert_equals(output, 1, "ds_list_find_index(), failed to find index of a valid entry (real)");
		
		ds_list_destroy(list);
		
	});
	
	addFact("ds_list_find_test #3", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, func);
		assert_equals(output, 2, "ds_list_find_index(), failed to find index of a valid entry (function)");
		
		ds_list_destroy(list);
		
	});
	
	addFact("ds_list_find_test #4", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, struct);
		assert_equals(output, 3, "ds_list_find_index(), failed to find index of a valid entry (struct)");
				
		ds_list_destroy(list);
		
	});
	
	addFact("ds_list_find_test #5", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, "world");
		assert_equals(output, -1, "ds_list_find_index(), found index of an invalid entry (string)");
				
		ds_list_destroy(list);
		
	});
}

