

function BasicDataStructuresGridTestSuite() : TestSuite() constructor {

	addFact("ds_grid_create_test #1", function() {
			
		var grid = ds_grid_create(10, 10);
			
		var output = ds_exists(grid, ds_type_grid);
		assert_true(output, "ds_grid_create(), failed to create grid");
		ds_grid_destroy(grid);

	});
	
	// DS GRID WIDTH TESTS

	addFact("ds_grid_width_test #1", function() {
			
		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		output = ds_grid_width(grid);
		assert_equals(output, 10, "ds_grid_width(), failed to get the correct grid width");
			
		ds_grid_destroy(grid);
	});
	
	// DS GRID HEIGHT TESTS

	addFact("ds_grid_height_test #1", function() {
			
		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		output = ds_grid_height(grid);
		assert_equals(output, 10, "ds_grid_height(), failed to get the correct grid height");
			
		ds_grid_destroy(grid);
	});
	
	// DS GRID RESIZE TESTS

	addFact("ds_grid_resize_test #1", function() {
			
		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_resize(grid, 20, 20);
			
		output = ds_grid_width(grid);
		assert_equals(output, 20, "ds_grid_resize(), failed to correctly resize the grid width");
		output = ds_grid_height(grid);
		assert_equals(output, 20, "ds_grid_resize(), failed to correctly resize the grid height");
			
		ds_grid_destroy(grid);
	});
		
	// DS GRID SORT TESTS
	
	addFact("ds_grid_sort_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
			
		grid[# 5, 5] = "Hello";
		grid[# 0, 0] = 9;
		grid[# 0, 1] = 8;
		grid[# 0, 2] = 7;
		grid[# 0, 3] = 6;
		grid[# 0, 4] = 5;
			
		ds_grid_sort(grid, 0, true);
		assert_equals(grid[# 0, 0], 0, "ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 5], 5, "ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 6], 6, "ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 7], 7, "ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 8], 8, "ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 9], 9, "ds_grid_sort(), failed to sort the grid (colum 0)");
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	// DS GRID COPY TESTS
	
	addFact("ds_grid_copy_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
			
		grid[# 5, 5] = "Hello";
		grid[# 0, 0] = 9;
		grid[# 0, 1] = 8;
		grid[# 0, 2] = 7;
		grid[# 0, 3] = 6;
		grid[# 0, 4] = 5;
			
		ds_grid_copy(copiedGrid, grid);
		assert_grid_equals(grid, copiedGrid, "ds_grid_copy(), failed to create a copy of the original");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	});
	
	// DS GRID SHUFFLE TESTS
	
	addFact("ds_grid_shuffle_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
			
		grid[# 5, 5] = "Hello";
		grid[# 0, 0] = 9;
		grid[# 0, 1] = 8;
		grid[# 0, 2] = 7;
		grid[# 0, 3] = 6;
		grid[# 0, 4] = 5;
			
		ds_grid_copy(copiedGrid, grid);
			
		ds_grid_shuffle(copiedGrid);
		assert_grid_not_equals(grid, copiedGrid, "ds_grid_shuffle(), failed to shuffle the original grid");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	});
	
	// DS GRID SET TESTS
	
	addFact("ds_grid_set_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
		grid[# 5, 5] = "Hello";
			
		ds_grid_set(grid, 5, 5, 100);
		assert_equals(grid[# 5, 5], 100, "ds_grid_set(), failed to set correct value");
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	// DS GRID ADD TESTS
	
	addFact("ds_grid_add_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
			
		ds_grid_set(grid, 5, 5, 100);
		ds_grid_add(grid, 5, 5, 100);
		
		assert_equals(grid[# 5, 5], 200, "ds_grid_add(), failed to add value");
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	// DS GRID MULTIPLY TESTS
	
	addFact("ds_grid_multiply_test #1", function() {
		
		var grid = ds_grid_create(10, 10);
			
		ds_grid_set(grid, 5, 5, 100);
		ds_grid_multiply(grid, 5, 5, 5);
		
		assert_equals(grid[# 5, 5], 500, "ds_grid_multiply(), failed to multiply value");
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	// DS GRID REGION TESTS
	
	addFact("ds_grid_region test #1", function() {
		
		var grid = ds_grid_create(10, 10);
		
		var x1 = 6;
		var y1 = 6;
		var x2 = 9;
		var y2 = 9;
		
		var value = 3
		
		ds_grid_set_region(grid, x1, y1, x2, y2, value);
		
		for (var _x = x1; _x <= x2; _x++) {
			for (var _y = y1; _y <= y2; _y++) {
				
				assert_equals(grid[# _x, _y], value, "ds_grid_set_region(), failed to set correct value");
				
			}
		}
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	addFact("ds_grid_region test #2", function() {
		
		var grid = ds_grid_create(10, 10);
		
		var x1 = 6;
		var y1 = 6;
		var x2 = 9;
		var y2 = 9;
		
		var value = 3;
		var addValue = 3;
		
		ds_grid_set_region(grid, x1, y1, x2, y2, value);
		ds_grid_add_region(grid, x1, y1, x2, y2, addValue);
		
		for (var _x = x1; _x <= x2; _x++) {
			for (var _y = y1; _y <= y2; _y++) {
				
				assert_equals(grid[# _x, _y], value + addValue, "ds_grid_add_region(), failed to add correct value");
				
			}
		}
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	addFact("ds_grid_region test #3", function() {
		
		var grid = ds_grid_create(10, 10);
		
		var x1 = 6;
		var y1 = 6;
		var x2 = 9;
		var y2 = 9;
		
		var value = 3;
		var multiplyValue = 3;
		
		ds_grid_set_region(grid, x1, y1, x2, y2, value);
		ds_grid_multiply_region(grid, x1, y1, x2, y2, multiplyValue);
		
		for (var _x = x1; _x <= x2; _x++) {
			for (var _y = y1; _y <= y2; _y++) {
				
				assert_equals(grid[# _x, _y], value * multiplyValue, "ds_grid_multiply_region(), failed to multiply value");
				
			}
		}
			
		// Clean Up
		ds_grid_destroy(grid);
			
	});
	
	addFact("ds_grid_region test #4", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
			
		copiedGrid[# 0, 0] = 1;
		copiedGrid[# 0, 1] = 1;
		copiedGrid[# 1, 0] = 1;
		copiedGrid[# 1, 1] = 1;
			
		ds_grid_set_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
			
		assert_equals(grid[# 9, 9], 1, "ds_grid_set_region(), failed to set correct values");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	});
	
	addFact("ds_grid_region test #5", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
			
		copiedGrid[# 0, 0] = 2;
		copiedGrid[# 0, 1] = 2;
		copiedGrid[# 1, 0] = 2;
		copiedGrid[# 1, 1] = 2;
			
		ds_grid_add_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
			
		assert_equals(grid[# 9, 9], 2, "ds_grid_add_grid_region(), failed to add correct values");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	});
	
	addFact("ds_grid_region test #6", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
		
		grid[# 9, 9] = 1;
			
		copiedGrid[# 0, 0] = 2;
		copiedGrid[# 0, 1] = 2;
		copiedGrid[# 1, 0] = 2;
		copiedGrid[# 1, 1] = 2;
			
		ds_grid_multiply_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
			
		assert_equals(grid[# 9, 9], 2, "ds_grid_multiply_grid_region(), failed to multiply values");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	});
	
	// GRID SUM TESTS
	
	addFact("ds_grid_sum_test #1", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_set_region(grid, 0, 0, 4, 4, 2);
		ds_grid_add_region(grid, 0, 0, 4, 4, 3);
		ds_grid_multiply_region(grid, 0, 0, 4, 4, 5);
			
		output = ds_grid_get_sum(grid, 0, 0, 4, 4);
		assert_equals(output, 625, "ds_grid_get_sum(), failed to return the correct value.");
		ds_grid_destroy(grid);
		
	});
	
	// GRID MAX TEST

	addFact("ds_grid_max_test #1", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_set_region(grid, 0, 0, 4, 4, 2);
		ds_grid_add_region(grid, 0, 0, 4, 4, 3);
		ds_grid_multiply_region(grid, 0, 0, 4, 4, 5);
			
		output = ds_grid_get_max(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "ds_grid_get_max(), failed to return the correct value.");
		ds_grid_destroy(grid);
			
		//show_debug_message("end dsGridRegion test");
	});
	
	// GRID MIN TEST
	
	addFact("ds_grid_min_test #1", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_set_region(grid, 0, 0, 4, 4, 2);
		ds_grid_add_region(grid, 0, 0, 4, 4, 3);
		ds_grid_multiply_region(grid, 0, 0, 4, 4, 5);
			
		output = ds_grid_get_min(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "ds_grid_get_min(), failed to return the correct value.");
		ds_grid_destroy(grid);
			
		//show_debug_message("end dsGridRegion test");
	});
	
	// GRID MEAN TEST

	addFact("ds_grid_mean_test #1", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_set_region(grid, 0, 0, 4, 4, 2);
		ds_grid_add_region(grid, 0, 0, 4, 4, 3);
		ds_grid_multiply_region(grid, 0, 0, 4, 4, 5);
			
		output = ds_grid_get_mean(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "ds_grid_get_mean(), failed to return the correct value.");
		ds_grid_destroy(grid);
			
		//show_debug_message("end dsGridRegion test");
	});

	// GRID DISK TEST
	
	addFact("ds_grid_disk_test #1", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_get_disk_sum(grid, 7, 7, 3);
		assert_equals(output, 405, "ds_grid_get_disk_sum(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	addFact("ds_grid_disk_test #2", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_get_disk_min(grid, 7, 7, 3);
		assert_equals(output, 15, "ds_grid_get_disk_min(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	addFact("ds_grid_disk_test #3", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_get_disk_max(grid, 7, 7, 3);
		assert_equals(output, 15, "ds_grid_get_disk_max(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	addFact("ds_grid_disk_test #4", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_get_disk_mean(grid, 7, 7, 3);
		assert_equals(output, 15, "ds_grid_get_disk_mean(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});

	addFact("ds_grid_disk_test #5", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_value_disk_exists(grid, 7, 7, 3, 15);
		assert_equals(output, true, "ds_grid_value_disk_exists(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	addFact("ds_grid_disk_test #6", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_value_disk_x(grid, 7, 7, 3, 15);
		assert_equals(output, 4, "ds_grid_value_disk_x(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	addFact("ds_grid_disk_test #7", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_value_disk_y(grid, 7, 7, 3, 15);
		assert_equals(output, 7, "ds_grid_value_disk_y(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	});
	
	// GRID VALUE CHECK TESTS
	
	addFact("ds_grid_value_check_test #1", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);

		grid[# 5, 5] = 100;
			
		var maxIndexX = ds_grid_width(grid) - 1;
		var maxIndexY = ds_grid_height(grid) - 1;
			
		output = ds_grid_value_exists(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, true, "DS Grid Value Exists");
			
		ds_grid_clear(grid, 0);
		ds_grid_destroy(grid);
			
	});

	addFact("ds_grid_value_check_test #2", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);

		grid[# 5, 5] = 100;
			
		var maxIndexX = ds_grid_width(grid) - 1;
		var maxIndexY = ds_grid_height(grid) - 1;
			
		output = ds_grid_value_x(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, 5, "DS Grid Value X");
			
		ds_grid_clear(grid, 0);
		ds_grid_destroy(grid);
			
	});

	addFact("ds_grid_value_check_test #3", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);

		grid[# 5, 5] = 100;
			
		var maxIndexX = ds_grid_width(grid) - 1;
		var maxIndexY = ds_grid_height(grid) - 1;
			
		output = ds_grid_value_y(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, 5, "DS Grid Value Y");
			
		ds_grid_clear(grid, 0);
		ds_grid_destroy(grid);
			
	});
	
	// DS GRID READ WRITE TESTS
	
	addFact("ds_grid_read_write_test #1", function() {

		var grid, writtenGrid, output;
			
		grid = ds_grid_create(10, 10);
		grid[# 5, 5] = "Hello";
			
		var checkValue = "5B0200000A0000000A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000500000048656C6C6F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			
		writtenGrid = ds_grid_write(grid);
		assert_equals(writtenGrid, checkValue, "ds_grid_write(), doesn't match pre-baked encoded string");
			
		ds_grid_destroy(grid);
			
	});
	
	addFact("ds_grid_read_write_test #2", function() {

		var grid, writtenGrid, output;
			
		grid = ds_grid_create(10, 10);
		grid[# 5, 5] = "Hello";
			
		var checkValue = "5B0200000A0000000A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000500000048656C6C6F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			
		ds_grid_clear(grid, 0);
		output = ds_grid_value_exists(grid, 0, 0, 9, 9, "Hello");
		assert_false(output, "ds_grid_clear(), failed to clear grid");
			
		ds_grid_destroy(grid);
			
	});

	addFact("ds_grid_read_write_test #3", function() {

		var grid, writtenGrid, output;
			
		grid = ds_grid_create(10, 10);
		grid[# 5, 5] = "Hello";
			
		writtenGrid = ds_grid_write(grid);
			
		grid = ds_grid_create(20, 20);
		ds_grid_read(grid, writtenGrid);
			
		assert_equals(grid[# 5, 5], "Hello", "ds_grid_read(), failed to read grid from encoded string");
			
		ds_grid_destroy(grid);
			
	});
	
}

