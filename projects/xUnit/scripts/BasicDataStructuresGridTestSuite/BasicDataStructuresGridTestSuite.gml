

function BasicDataStructuresGridTestSuite() : TestSuite() constructor {

	addFact("ds_grid_create_test", function() {
			
		var grid = ds_grid_create(10, 10);
			
		var output = ds_exists(grid, ds_type_grid);
		assert_true(output, "#1 ds_grid_create(), failed to create grid");
		ds_grid_destroy(grid);

	})

	addFact("ds_grid_resize_test", function() {
			
		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		output = ds_grid_width(grid);
		assert_equals(output, 10, "#1 ds_grid_width(), failed to get the correct grid width");
			
		output = ds_grid_height(grid);
		assert_equals(output, 10, "#2 ds_grid_height(), failed to get the correct grid height");
			
		ds_grid_resize(grid, 20, 20);
			
		output = ds_grid_width(grid);
		assert_equals(output, 20, "#3.1 ds_grid_resize(), failed to correctly resize the grid");
		output = ds_grid_height(grid);
		assert_equals(output, 20, "#3.2 ds_grid_resize(), failed to correctly resize the grid");
			
		ds_grid_destroy(grid);
			
		//show_debug_message("end dsGridResize test");
	})
		
	addFact("ds_grid_copy_shuffle_set_add_multiply_test", function() {
		
		var grid = ds_grid_create(10, 10);
		var copiedGrid = ds_grid_create(10, 10);
			
		grid[# 5, 5] = "Hello";
		grid[# 0, 0] = 9;
		grid[# 0, 1] = 8;
		grid[# 0, 2] = 7;
		grid[# 0, 3] = 6;
		grid[# 0, 4] = 5;
			
		ds_grid_sort(grid, 0, true);
		assert_equals(grid[# 0, 0], 0, "#1.1 ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 5], 5, "#1.2 ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 6], 6, "#1.3 ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 7], 7, "#1.4 ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 8], 8, "#1.5 ds_grid_sort(), failed to sort the grid (colum 0)");
		assert_equals(grid[# 0, 9], 9, "#1.6 ds_grid_sort(), failed to sort the grid (colum 0)");
			
		ds_grid_copy(copiedGrid, grid);
		assert_grid_equals(grid, copiedGrid, "#2 ds_grid_copy(), failed to create a copy of the original");
			
		ds_grid_shuffle(copiedGrid);
		assert_grid_not_equals(grid, copiedGrid, "#3 ds_grid_shuffle(), failed to shuffle the original grid");
			
		ds_grid_set(grid, 5, 5, 100);
		ds_grid_add(grid, 5, 5, 100);
		ds_grid_multiply(grid, 5, 5, 5);
		assert_equals(grid[# 5, 5], 1000, "#4 ds_grid_set/add/multiply(), failed operations");
			
		ds_grid_set_region(grid, 6, 6, 9, 9, 3);
		ds_grid_add_region(grid, 6, 6, 9, 9, 3);
		ds_grid_multiply_region(grid, 6, 6, 9, 9, 3);
		assert_equals(grid[# 7, 7], 18, "#4 ds_grid_set/add/multiply_region(), failed operations");
			
		copiedGrid[# 0, 0] = 0;
		copiedGrid[# 0, 1] = 0;
		copiedGrid[# 1, 0] = 0;
		copiedGrid[# 1, 1] = 0;
			
		ds_grid_set_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
		ds_grid_add_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
		ds_grid_multiply_grid_region(grid, copiedGrid, 0, 0, 1, 1, 8, 8);
			
		assert_equals(grid[# 9, 9], 0, "#4 ds_grid_set/add/multiply_grid_region(), failed operations");
			
		// Clean Up
		ds_grid_destroy(grid);
		ds_grid_destroy(copiedGrid);
			
	})

	addFact("ds_grid_region_test", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);
			
		ds_grid_set_region(grid, 0, 0, 4, 4, 2);
		ds_grid_add_region(grid, 0, 0, 4, 4, 3);
		ds_grid_multiply_region(grid, 0, 0, 4, 4, 5);
			
		output = ds_grid_get_sum(grid, 0, 0, 4, 4);
		assert_equals(output, 625, "#1 ds_grid_get_sum(), failed to return the correct value.");
			
		output = ds_grid_get_max(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "#2 ds_grid_get_max(), failed to return the correct value.");
			
		output = ds_grid_get_min(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "#3 ds_grid_get_min(), failed to return the correct value.");
			
		output = ds_grid_get_mean(grid, 0, 0, 4, 4);
		assert_equals(output, 25, "#4 ds_grid_get_mean(), failed to return the correct value.");
		ds_grid_destroy(grid);
			
		//show_debug_message("end dsGridRegion test");
	})

	addFact("ds_grid_disk_test", function() {
			
		var output, grid = ds_grid_create(10, 10);
			
		ds_grid_set_disk(grid, 7, 7, 3, 10);
		ds_grid_add_disk(grid, 7, 7, 3, -5);
		ds_grid_multiply_disk(grid, 7, 7, 3, 3);
			
		output = ds_grid_get_disk_sum(grid, 7, 7, 3);
		assert_equals(output, 405, "#1 ds_grid_get_disk_sum(), failed to return the correct value.");
			
		output = ds_grid_get_disk_min(grid, 7, 7, 3);
		assert_equals(output, 15, "#2 ds_grid_get_disk_min(), failed to return the correct value.");
			
		output = ds_grid_get_disk_max(grid, 7, 7, 3);
		assert_equals(output, 15, "#3 ds_grid_get_disk_max(), failed to return the correct value.");
			
		output = ds_grid_get_disk_mean(grid, 7, 7, 3);
		assert_equals(output, 15, "#4 ds_grid_get_disk_mean(), failed to return the correct value.");
			
		output = ds_grid_value_disk_exists(grid, 7, 7, 3, 15);
		assert_equals(output, true, "#5 ds_grid_value_disk_exists(), failed to return the correct value.");
			
		output = ds_grid_value_disk_x(grid, 7, 7, 3, 15);
		assert_equals(output, 4, "#6 ds_grid_value_disk_x(), failed to return the correct value.");
			
		output = ds_grid_value_disk_y(grid, 7, 7, 3, 15);
		assert_equals(output, 7, "#7 ds_grid_value_disk_y(), failed to return the correct value.");
			
		ds_grid_destroy(grid);
	})

	addFact("ds_grid_value_check_test", function() {

		var grid, output;
			
		grid = ds_grid_create(10, 10);

		grid[# 5, 5] = 100;
			
		var maxIndexX = ds_grid_width(grid) - 1;
		var maxIndexY = ds_grid_height(grid) - 1;
			
		output = ds_grid_value_exists(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, true, "DS Grid Value Exists");
			
		output = ds_grid_value_x(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, 5, "DS Grid Value X");
			
		output = ds_grid_value_y(grid, 0, 0, maxIndexX, maxIndexY, 100);
		assert_equals(output, 5, "DS Grid Value Y");
			
		ds_grid_clear(grid, 0);
		ds_grid_destroy(grid);
			
	})

	addFact("ds_grid_read_write_test", function() {

		var grid, writtenGrid, output;
			
		grid = ds_grid_create(10, 10);
		grid[# 5, 5] = "Hello";
			
		var checkValue = "5B0200000A0000000A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000500000048656C6C6F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			
		writtenGrid = ds_grid_write(grid);
		assert_equals(writtenGrid, checkValue, "#1 ds_grid_write(), doesn't match pre-baked encoded string");
			
		ds_grid_clear(grid, 0);
		output = ds_grid_value_exists(grid, 0, 0, 9, 9, "Hello");
		assert_false(output, "#2 ds_grid_clear(), failed to clear grid");
			
		grid = ds_grid_create(20, 20);
		ds_grid_read(grid, writtenGrid);
			
		assert_equals(grid[# 5, 5], "Hello", "#3 ds_grid_read(), failed to read grid from encoded string");
			
		ds_grid_destroy(grid);
			
	})
	
}

