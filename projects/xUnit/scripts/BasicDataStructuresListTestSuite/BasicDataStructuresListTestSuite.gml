

function BasicDataStructuresListTestSuite() : TestSuite() constructor {

	addFact("ds_list_create_test", function() {

		var list = ds_list_create();
		
		var _output = ds_exists(list, ds_type_list);
		assert_true(_output, "#1 ds_list_create(), failed to create list");
			
		// Clean up
		ds_list_destroy(list);
	})

	addFact("ds_list_add_set_insert_delete_test", function() {

		//SB: ds_list_add, ds_list_size
		ds_set_precision(0.00001);
		
		var list, output;
		
		list = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, 40, 50);
		assert_list_equals_array(list, [10, 20, 30, 40, 50], "#1 ds_list_add(..), failed to correctly add entries to the list");
		
		assert_list_size(list, 5, "#2 ds_list_size(..), failed to return correct list size");
		
		ds_list_set(list, 0, 60);
		output = list[| 0];
		assert_equals(output, 60, "#3 ds_list_set(...), failed to set the correct value on a valid index");
		
		ds_list_insert(list, 1, 70);
		output = list[| 1];
		assert_list_equals_array(list, [60, 70, 20, 30, 40, 50], "#4 ds_list_insert(...), failed to insert the correct value on a valid index");

		ds_list_set(list, 6, 80);
		output = list[| 6];
		assert_equals(output, 80, "#5 ds_list_set(...), failed to set the correct value on an out-of-bounds index");
		
		output = ds_list_size(list);
		assert_list_size(list, 7, "#6 ds_list_set(..), failed to resize the list using out-of-bounds index");
		
		ds_list_delete(list, 2);
		assert_list_size(list, 6, "#7 ds_list_delete(..), failed to resize the list");
		
		// Clean up
		ds_list_destroy(list);
	})

	addFact("ds_list_copy_test", function() {

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

	addFact("ds_list_sort_test", function() {
			
		ds_set_precision(0.00001);
		
		var output, list;
		
		list = ds_list_create();
			
		ds_list_add(list, 50, 40.001, 30.992, 20, 10, 0.01);
			
		ds_list_sort(list, true)
		assert_list_equals_array(list, [0.01, 10, 20, 30.992, 40.001, 50], "ds_list_sort(), failed to sort the list correctly (ascending)");
			
		ds_list_sort(list, false)
		assert_list_equals_array(list, [50, 40.001, 30.992, 20, 10, 0.01], "ds_list_sort(), failed to sort the list correctly (descending)");
			
		// Clean up
		ds_list_destroy(list);
		
	})

	addFact("ds_list_mark_test", function() {

		//SB: ds_list_add, ds_list_size, ds_list_mark_as_list and ds_list_mark_as_map
			
		ds_set_precision(0.00001);
		
		var list, output, listToAdd1, listToAdd2, listToAdd3;
		
		list = ds_list_create();
		listToAdd1 = ds_list_create();
		listToAdd2 = ds_list_create();
		listToAdd3 = ds_list_create();
			
		ds_list_add(list, 10, 20, 30, listToAdd1, listToAdd2, listToAdd3);
		
		output = ds_list_is_list(list, 3);
		assert_false(output, "#1.1 ds_list_is_list(), detected an unmarked list");
		output = ds_list_is_list(list, 4);
		assert_false(output, "#1.2 ds_list_is_list(), detected an unmarked list");
		output = ds_list_is_list(list, 5);
		assert_false(output, "#1.3 ds_list_is_list(), detected an unmarked list");
		
		ds_list_mark_as_list(list, 3);
		ds_list_mark_as_list(list, 4);
		ds_list_mark_as_list(list, 5);

		output = ds_list_is_list(list, 3);
		assert_true(output, "#2.1 ds_list_mark_as_list(), failed to mark list");
		output = ds_list_is_list(list, 4);
		assert_true(output, "#2.2 ds_list_mark_as_list(), failed to mark list");
		output = ds_list_is_list(list, 5);
		assert_true(output, "#2.3 ds_list_mark_as_list(), failed to mark list");
			
		ds_list_sort(list, true);
		output = ds_list_is_list(list, 0);
		assert_true(output, "#3.1 ds_list_sort(), messed with marked list");
		output = ds_list_is_list(list, 1);
		assert_true(output, "#3.2 ds_list_sort(), messed with marked list");
		output = ds_list_is_list(list, 2);
		assert_true(output, "#3.3 ds_list_sort(), messed with marked list");
		
		var mapToAdd = ds_map_create();
		
		ds_list_add(list, mapToAdd);
		
		output = ds_list_is_map(list, 6);
		assert_false(output, "#4 ds_list_is_map(), detected an unmarked map");
		
		ds_list_mark_as_map(list, 6);
		
		output = ds_list_is_map(list, 6);
		assert_true(output, "#5 ds_list_mark_as_map(), failed to mark map");
		
		// Clean up
		ds_list_destroy(list);
		
	})
		
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

	})
	
	addFact("ds_list_find_test", function() {

		//SB: ds_list_write, ds_list_clear, ds_list_empty and ds_list_read
		
		var list, output;
		
		list = ds_list_create();
		
		var struct = {};
		var func = function() {};
			
		ds_list_add(list, "hello", 30, func, struct);
		
		output = ds_list_find_index(list, "hello");
		assert_equals(output, 0, "#1 ds_list_find_index(), failed to find index of a valid entry (string)");
		
		output = ds_list_find_index(list, 30);
		assert_equals(output, 1, "#1 ds_list_find_index(), failed to find index of a valid entry (real)");
		
		output = ds_list_find_index(list, func);
		assert_equals(output, 2, "#1 ds_list_find_index(), failed to find index of a valid entry (function)");
		
		output = ds_list_find_index(list, struct);
		assert_equals(output, 3, "#1 ds_list_find_index(), failed to find index of a valid entry (struct)");
		
		output = ds_list_find_index(list, "world");
		assert_equals(output, -1, "#1 ds_list_find_index(), found index of an invalid entry (string)");
		
	})
}

