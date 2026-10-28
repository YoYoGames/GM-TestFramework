

function BasicAccessorExpressionsTestSuite() : TestSuite() constructor {

	// Write and read facts are deliberately kept independent of each other:
	// a write fact writes through the accessor and verifies with the plain API,
	// a read fact is populated with the plain API and verifies through the accessor.
	// A failure therefore localises to one direction rather than "somewhere in this chain".

	// ARRAY ACCESS TESTS

	addFact("Array access and modification #1", function() {
		var arr = [0, 1, 2];
		arr[0] = 1;

		assert_equals(arr[0], 1, "Array modification failed at index 0.");
	});

	addFact("Array access and modification #2", function() {
		var arr = [0, 1, 2];
		var test = arr[2];

		assert_equals(test, 2, "Array access failed at index 2.");
	});

	addFact("Array access and modification #3", function() {
		var arr = [0, 1, 2];
		arr[0] = 1;

		assert_array_equals(arr, [1,1,2], "Array equals failed.");
	});

	// LIST ACCESS TESTS

	addFact("List access and modification #1", function() {
		var list = ds_list_create();
		list[| 0] = 1;

		assert_equals(ds_list_find_value(list, 0), 1, "List modification failed at index 0.");

		ds_list_destroy(list);
	});

	addFact("List access and modification #2", function() {
		var list = ds_list_create();
		list[| 0] = 1;
		list[| 1] = 2;

		assert_equals(ds_list_find_value(list, 1), 2, "List modification failed at index 1.");

		ds_list_destroy(list);
	});

	addFact("List access and modification #3", function() {
		var list = ds_list_create();
		ds_list_set(list, 2, 3);
		var test = list[| 2];

		assert_equals(test, 3, "List access failed at index 2.");

		ds_list_destroy(list);
	});

	// GRID ACCESS TESTS

	addFact("Grid access and modification #1", function() {
		var grid = ds_grid_create(5, 5);
		ds_grid_set_region(grid, 0, 0, 4, 4, "example");
		grid[# 0, 1] = 2;

		assert_equals(ds_grid_get(grid, 0, 1), 2, "Grid modification failed at [0, 1].");

		ds_grid_destroy(grid);
	});

	addFact("Grid access and modification #2", function() {
		var grid = ds_grid_create(5, 5);
		ds_grid_set_region(grid, 0, 0, 4, 4, "example");
		var test = grid[# 3, 4];

		assert_equals(test, "example", "Grid access failed at [3, 4].");

		ds_grid_destroy(grid);
	});

	// MAP ACCESS TESTS

	addFact("Map access and modification #1", function() {
		var map = ds_map_create();
		map[? "zero"] = 1;
		ds_map_set(map, "zero", 2);

		assert_equals(ds_map_find_value(map, "zero"), 2, "Map modification failed for key 'zero'.");

		ds_map_destroy(map);
	});

	addFact("Map access and modification #2", function() {
		var map = ds_map_create();
		ds_map_add(map, "two", 3);
		var test = map[? "two"];

		assert_equals(test, 3, "Map access failed for key 'two'.");

		ds_map_destroy(map);
	});

	// STRUCT DOT ACCESSOR TESTS

	addFact("Struct Dot Accessor Test #1", function() {
		var struct = {zero: 0, one: 1, two: 2};
		var test = struct.two;

		assert_equals(test, 2, "Dot accessor did not return the expected value for 'two'");
	});

	addFact("Struct Dot Accessor Test #2", function() {
		var struct = {zero: 0, one: 1, two: 2};
		struct.zero = 1;

		assert_equals(variable_struct_get(struct, "zero"), 1, "Dot accessor did not modify the 'zero' field correctly");
	});

	// STRUCT BRACKET ACCESSOR :CONST: TESTS

	addFact("Struct Bracket Accessor :Const: Test #1", function() {
		var struct = {zero: 0, one: 1, two: 2};
		var test = struct[$ "two"];

		assert_equals(test, 2, "Bracket accessor :Const: did not return the expected value for 'two'");
	});

	addFact("Struct Bracket Accessor :Const: Test #2", function() {
		var struct = {zero: 0, one: 1, two: 2};
		struct[$ "zero"] = 1;

		assert_equals(variable_struct_get(struct, "zero"), 1, "Bracket accessor :Const: did not modify the 'zero' field correctly");
	});

	// STRUCT BRACKET ACCESSOR :DYNAMIC: TESTS

	addFact("Struct Bracket Accessor :Dynamic: Test #1", function() {
		var struct = {zero: 0, one: 1, two: 2};

		var _key = "two";
		var test = struct[$ _key];

		assert_equals(test, 2, "Bracket accessor :Dynamic: did not return the expected value for 'two'");
	});

	addFact("Struct Bracket Accessor :Dynamic: Test #2", function() {
		var struct = {zero: 0, one: 1, two: 2};

		var _key = "zero";
		struct[$ _key] = 1;

		assert_equals(variable_struct_get(struct, "zero"), 1, "Bracket accessor :Dynamic: did not modify the 'zero' field correctly");
	});

	// STRUCT HASH ACCESSOR TESTS

	addFact("Struct hash setting #1", function() {
		var struct = {one: 1};

		// Set new value using hash of "one"
		struct_set_from_hash(struct, variable_get_hash("one"), "oneAgain");

		assert_equals(variable_struct_get(struct, "one"), "oneAgain", "Struct modification using hash failed.");
	});

	addFact("Struct hash setting #2", function() {
		var struct = {one: 1};

		// Set new value using hash of "one"
		struct_set_from_hash(struct, variable_get_hash("one"), "oneAgain");

		assert_struct_equals(struct, {one:"oneAgain"}, "Struct equals failed.");
	});

	// ARRAY WITH MULTIPLE ACCESSORS TESTS

	addFact("Array with multiple accessors (Read/Write) #1", function() {
		var arr = array_create(8);
		array_set(arr, 0, [10, 20, 30]);

		arr[0][1] = 999;

		assert_equals(array_get(array_get(arr, 0), 1), 999, "Array, Array write failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #2", function() {
		var arr = array_create(8);
		array_set(arr, 1, ds_list_create());
		ds_list_add(array_get(arr, 1), 1, 2, 3);

		arr[1][| 1] = 888;

		assert_equals(ds_list_find_value(array_get(arr, 1), 1), 888, "Array, List write failed.");

		ds_list_destroy(array_get(arr, 1));
	});

	addFact("Array with multiple accessors (Read/Write) #3", function() {
		var arr = array_create(8);
		array_set(arr, 2, ds_grid_create(5, 5));
		ds_grid_set(array_get(arr, 2), 2, 2, 50);

		arr[2][# 2, 2] = 777;

		assert_equals(ds_grid_get(array_get(arr, 2), 2, 2), 777, "Array, Grid write failed.");

		ds_grid_destroy(array_get(arr, 2));
	});

	addFact("Array with multiple accessors (Read/Write) #4", function() {
		var arr = array_create(8);
		array_set(arr, 3, ds_map_create());
		ds_map_add(array_get(arr, 3), "mapName", 300);

		arr[3][? "mapName"] = 666;

		assert_equals(ds_map_find_value(array_get(arr, 3), "mapName"), 666, "Array, Map write failed.");

		ds_map_destroy(array_get(arr, 3));
	});

	addFact("Array with multiple accessors (Read/Write) #5", function() {
		var arr = array_create(8);
		array_set(arr, 4, {name: "dotValue"});

		arr[4].name = "newDotValue";

		assert_equals(variable_struct_get(array_get(arr, 4), "name"), "newDotValue", "Array, Struct Dot write failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #6", function() {
		var arr = array_create(8);
		array_set(arr, 5, {bracketName: "bracketValue"});

		arr[5][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(array_get(arr, 5), "bracketName"), "newBracketValue", "Array, Struct Bracket :Const: write failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #7", function() {
		var arr = array_create(8);
		array_set(arr, 5, {bracketName: "bracketValue"});

		var _key = "bracketName";
		arr[5][$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(array_get(arr, 5), "bracketName"), "newBracketValue", "Array, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #8", function() {
		var arr = array_create(8);
		array_set(arr, 6, {hashName: "hashValue"});

		struct_set_from_hash(arr[6], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(array_get(arr, 6), "hashName"), "newHashValue", "Array, Struct Hash write failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #9", function() {
		var arr = array_create(8);
		array_set(arr, 0, [10, 999, 30]);

		assert_equals(arr[0][1], 999, "Array, Array access failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #10", function() {
		var arr = array_create(8);
		array_set(arr, 1, ds_list_create());
		ds_list_add(array_get(arr, 1), 1, 888, 3);

		assert_equals(arr[1][| 1], 888, "Array, List access failed.");

		ds_list_destroy(array_get(arr, 1));
	});

	addFact("Array with multiple accessors (Read/Write) #11", function() {
		var arr = array_create(8);
		array_set(arr, 2, ds_grid_create(5, 5));
		ds_grid_set(array_get(arr, 2), 2, 2, 777);

		assert_equals(arr[2][# 2, 2], 777, "Array, Grid access failed.");

		ds_grid_destroy(array_get(arr, 2));
	});

	addFact("Array with multiple accessors (Read/Write) #12", function() {
		var arr = array_create(8);
		array_set(arr, 3, ds_map_create());
		ds_map_add(array_get(arr, 3), "mapName", 666);

		assert_equals(arr[3][? "mapName"], 666, "Array, Map access failed.");

		ds_map_destroy(array_get(arr, 3));
	});

	addFact("Array with multiple accessors (Read/Write) #13", function() {
		var arr = array_create(8);
		array_set(arr, 4, {name: "newDotValue"});

		assert_equals(arr[4].name, "newDotValue", "Array, Struct Dot access failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #14", function() {
		var arr = array_create(8);
		array_set(arr, 5, {bracketName: "newBracketValue"});

		assert_equals(arr[5][$ "bracketName"], "newBracketValue", "Array, Struct Bracket :Const: access failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #15", function() {
		var arr = array_create(8);
		array_set(arr, 5, {bracketName: "newBracketValue"});

		var _key = "bracketName";

		assert_equals(arr[5][$ _key], "newBracketValue", "Array, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #16", function() {
		var arr = array_create(8);
		array_set(arr, 6, {hashName: "newHashValue"});

		assert_equals(struct_get_from_hash(arr[6], variable_get_hash("hashName")), "newHashValue", "Array, Struct Hash access failed.");
	});

	addFact("Array with multiple accessors (Read/Write) #17", function() {
		var arr = array_create(8);
		array_set(arr, 7, function() { return [100, 200]; });

		var _retArr = arr[7]();

		assert_equals(_retArr[0], 100, "Array, Function Call access failed (first return value).");
	});

	addFact("Array with multiple accessors (Read/Write) #18", function() {
		var arr = array_create(8);
		array_set(arr, 7, function() { return [100, 200]; });

		var _retArr = arr[7]();

		assert_equals(_retArr[1], 200, "Array, Function Call access failed (second return value).");
	});

	// LIST WITH MULTIPLE ACCESSORS TESTS

	addFact("List with multiple accessors (Read/Write) #1", function() {
		var list = ds_list_create();
		ds_list_set(list, 0, [10, 20, 30]);

		list[| 0][1] = 999;

		assert_equals(array_get(ds_list_find_value(list, 0), 1), 999, "List, Array write failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #2", function() {
		var list = ds_list_create();
		ds_list_set(list, 1, ds_list_create());
		ds_list_add(ds_list_find_value(list, 1), 1, 2, 3);

		list[| 1][| 1] = 888;

		assert_equals(ds_list_find_value(ds_list_find_value(list, 1), 1), 888, "List, List write failed.");

		ds_list_destroy(ds_list_find_value(list, 1));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #3", function() {
		var list = ds_list_create();
		ds_list_set(list, 2, ds_grid_create(5, 5));
		ds_grid_set(ds_list_find_value(list, 2), 2, 2, 50);

		list[| 2][# 2, 2] = 777;

		assert_equals(ds_grid_get(ds_list_find_value(list, 2), 2, 2), 777, "List, Grid write failed.");

		ds_grid_destroy(ds_list_find_value(list, 2));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #4", function() {
		var list = ds_list_create();
		ds_list_set(list, 3, ds_map_create());
		ds_map_add(ds_list_find_value(list, 3), "mapName", 300);

		list[| 3][? "mapName"] = 666;

		assert_equals(ds_map_find_value(ds_list_find_value(list, 3), "mapName"), 666, "List, Map write failed.");

		ds_map_destroy(ds_list_find_value(list, 3));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #5", function() {
		var list = ds_list_create();
		ds_list_set(list, 4, {name: "dotValue"});

		list[| 4].name = "newDotValue";

		assert_equals(variable_struct_get(ds_list_find_value(list, 4), "name"), "newDotValue", "List, Struct Dot write failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #6", function() {
		var list = ds_list_create();
		ds_list_set(list, 5, {bracketName: "bracketValue"});

		list[| 5][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(ds_list_find_value(list, 5), "bracketName"), "newBracketValue", "List, Struct Bracket :Const: write failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #7", function() {
		var list = ds_list_create();
		ds_list_set(list, 5, {bracketName: "bracketValue"});

		var _key = "bracketName";
		list[| 5][$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(ds_list_find_value(list, 5), "bracketName"), "newBracketValue", "List, Struct Bracket :Dynamic: write failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #8", function() {
		var list = ds_list_create();
		ds_list_set(list, 6, {hashName: "hashValue"});

		struct_set_from_hash(list[| 6], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(ds_list_find_value(list, 6), "hashName"), "newHashValue", "List, Struct Hash write failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #9", function() {
		var list = ds_list_create();
		ds_list_set(list, 0, [10, 999, 30]);

		assert_equals(list[| 0][1], 999, "List, Array access failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #10", function() {
		var list = ds_list_create();
		ds_list_set(list, 1, ds_list_create());
		ds_list_add(ds_list_find_value(list, 1), 1, 888, 3);

		assert_equals(list[| 1][| 1], 888, "List, List access failed.");

		ds_list_destroy(ds_list_find_value(list, 1));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #11", function() {
		var list = ds_list_create();
		ds_list_set(list, 2, ds_grid_create(5, 5));
		ds_grid_set(ds_list_find_value(list, 2), 2, 2, 777);

		assert_equals(list[| 2][# 2, 2], 777, "List, Grid access failed.");

		ds_grid_destroy(ds_list_find_value(list, 2));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #12", function() {
		var list = ds_list_create();
		ds_list_set(list, 3, ds_map_create());
		ds_map_add(ds_list_find_value(list, 3), "mapName", 666);

		assert_equals(list[| 3][? "mapName"], 666, "List, Map access failed.");

		ds_map_destroy(ds_list_find_value(list, 3));
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #13", function() {
		var list = ds_list_create();
		ds_list_set(list, 4, {name: "newDotValue"});

		assert_equals(list[| 4].name, "newDotValue", "List, Struct Dot access failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #14", function() {
		var list = ds_list_create();
		ds_list_set(list, 5, {bracketName: "newBracketValue"});

		assert_equals(list[| 5][$ "bracketName"], "newBracketValue", "List, Struct Bracket :Const: access failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #15", function() {
		var list = ds_list_create();
		ds_list_set(list, 5, {bracketName: "newBracketValue"});

		var _key = "bracketName";

		assert_equals(list[| 5][$ _key], "newBracketValue", "List, Struct Bracket :Dynamic: access failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #16", function() {
		var list = ds_list_create();
		ds_list_set(list, 6, {hashName: "newHashValue"});

		assert_equals(struct_get_from_hash(list[| 6], variable_get_hash("hashName")), "newHashValue", "List, Struct Hash access failed.");

		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #17", function() {
		var list = ds_list_create();
		ds_list_set(list, 7, function() {
			var listFunc = ds_list_create();
			ds_list_add(listFunc, 100, 200);
			return listFunc;
		});

		var _retList = list[| 7]();

		assert_equals(_retList[| 0], 100, "List, Function Call access failed (first return value).");

		ds_list_destroy(_retList);
		ds_list_destroy(list);
	});

	addFact("List with multiple accessors (Read/Write) #18", function() {
		var list = ds_list_create();
		ds_list_set(list, 7, function() {
			var listFunc = ds_list_create();
			ds_list_add(listFunc, 100, 200);
			return listFunc;
		});

		var _retList = list[| 7]();

		assert_equals(_retList[| 1], 200, "List, Function Call access failed (second return value).");

		ds_list_destroy(_retList);
		ds_list_destroy(list);
	});

	// GRID WITH MULTIPLE ACCESSORS TESTS

	addFact("Grid with multiple accessors (Read/Write) #1", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 0, 1, [10, 20, 30]);

		grid[# 0, 1][1] = 999;

		assert_equals(array_get(ds_grid_get(grid, 0, 1), 1), 999, "Grid, Array write failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #2", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 2, 3, ds_list_create());
		ds_list_add(ds_grid_get(grid, 2, 3), 1, 2, 3);

		grid[# 2, 3][| 1] = 888;

		assert_equals(ds_list_find_value(ds_grid_get(grid, 2, 3), 1), 888, "Grid, List write failed.");

		ds_list_destroy(ds_grid_get(grid, 2, 3));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #3", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 4, 5, ds_grid_create(5, 5));
		ds_grid_set(ds_grid_get(grid, 4, 5), 2, 2, 50);

		grid[# 4, 5][# 2, 2] = 777;

		assert_equals(ds_grid_get(ds_grid_get(grid, 4, 5), 2, 2), 777, "Grid, Grid write failed.");

		ds_grid_destroy(ds_grid_get(grid, 4, 5));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #4", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 6, 7, ds_map_create());
		ds_map_add(ds_grid_get(grid, 6, 7), "mapName", 300);

		grid[# 6, 7][? "mapName"] = 666;

		assert_equals(ds_map_find_value(ds_grid_get(grid, 6, 7), "mapName"), 666, "Grid, Map write failed.");

		ds_map_destroy(ds_grid_get(grid, 6, 7));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #5", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 8, 9, {name: "dotValue"});

		grid[# 8, 9].name = "newDotValue";

		assert_equals(variable_struct_get(ds_grid_get(grid, 8, 9), "name"), "newDotValue", "Grid, Struct Dot write failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #6", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 10, 11, {bracketName: "bracketValue"});

		grid[# 10, 11][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(ds_grid_get(grid, 10, 11), "bracketName"), "newBracketValue", "Grid, Struct Bracket :Const: write failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #7", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 10, 11, {bracketName: "bracketValue"});

		var _key = "bracketName";
		grid[# 10, 11][$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(ds_grid_get(grid, 10, 11), "bracketName"), "newBracketValue", "Grid, Struct Bracket :Dynamic: write failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #8", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 12, 13, {hashName: "hashValue"});

		struct_set_from_hash(grid[# 12, 13], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(ds_grid_get(grid, 12, 13), "hashName"), "newHashValue", "Grid, Struct Hash write failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #9", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 0, 1, [10, 999, 30]);

		assert_equals(grid[# 0, 1][1], 999, "Grid, Array access failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #10", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 2, 3, ds_list_create());
		ds_list_add(ds_grid_get(grid, 2, 3), 1, 888, 3);

		assert_equals(grid[# 2, 3][| 1], 888, "Grid, List access failed.");

		ds_list_destroy(ds_grid_get(grid, 2, 3));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #11", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 4, 5, ds_grid_create(5, 5));
		ds_grid_set(ds_grid_get(grid, 4, 5), 2, 2, 777);

		assert_equals(grid[# 4, 5][# 2, 2], 777, "Grid, Grid access failed.");

		ds_grid_destroy(ds_grid_get(grid, 4, 5));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #12", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 6, 7, ds_map_create());
		ds_map_add(ds_grid_get(grid, 6, 7), "mapName", 666);

		assert_equals(grid[# 6, 7][? "mapName"], 666, "Grid, Map access failed.");

		ds_map_destroy(ds_grid_get(grid, 6, 7));
		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #13", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 8, 9, {name: "newDotValue"});

		assert_equals(grid[# 8, 9].name, "newDotValue", "Grid, Struct Dot access failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #14", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 10, 11, {bracketName: "newBracketValue"});

		assert_equals(grid[# 10, 11][$ "bracketName"], "newBracketValue", "Grid, Struct Bracket :Const: access failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #15", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 10, 11, {bracketName: "newBracketValue"});

		var _key = "bracketName";

		assert_equals(grid[# 10, 11][$ _key], "newBracketValue", "Grid, Struct Bracket :Dynamic: access failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #16", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 12, 13, {hashName: "newHashValue"});

		assert_equals(struct_get_from_hash(grid[# 12, 13], variable_get_hash("hashName")), "newHashValue", "Grid, Struct Hash access failed.");

		ds_grid_destroy(grid);
	});

	addFact("Grid with multiple accessors (Read/Write) #17", function() {
		var grid = ds_grid_create(16, 16);
		ds_grid_set(grid, 14, 15, function() {
			var gridFunc = ds_grid_create(3, 3);
			ds_grid_set(gridFunc, 1, 1, 100);
			return gridFunc;
		});

		var _retGrid = grid[# 14, 15]();

		assert_equals(_retGrid[# 1, 1], 100, "Grid, Function Call access failed.");

		ds_grid_destroy(_retGrid);
		ds_grid_destroy(grid);
	});

	// MAP WITH MULTIPLE ACCESSORS TESTS

	addFact("Map with multiple accessors (Read/Write) #1", function() {
		var map = ds_map_create();
		ds_map_add(map, "array", [10, 20, 30]);

		map[? "array"][1] = 999;

		assert_equals(array_get(ds_map_find_value(map, "array"), 1), 999, "Map, Array write failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #2", function() {
		var map = ds_map_create();
		var nestedList = ds_list_create();
		ds_list_add(nestedList, 1, 2, 3);
		ds_map_add(map, "list", nestedList);

		map[? "list"][| 1] = 888;

		assert_equals(ds_list_find_value(ds_map_find_value(map, "list"), 1), 888, "Map, List write failed.");

		ds_list_destroy(nestedList);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #3", function() {
		var map = ds_map_create();
		var nestedGrid = ds_grid_create(5, 5);
		ds_grid_set(nestedGrid, 2, 2, 50);
		ds_map_add(map, "grid", nestedGrid);

		map[? "grid"][# 2, 2] = 777;

		assert_equals(ds_grid_get(ds_map_find_value(map, "grid"), 2, 2), 777, "Map, Grid write failed.");

		ds_grid_destroy(nestedGrid);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #4", function() {
		var map = ds_map_create();
		var nestedMap = ds_map_create();
		ds_map_add(nestedMap, "mapName", 300);
		ds_map_add(map, "map", nestedMap);

		map[? "map"][? "mapName"] = 666;

		assert_equals(ds_map_find_value(ds_map_find_value(map, "map"), "mapName"), 666, "Map, Map write failed.");

		ds_map_destroy(nestedMap);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #5", function() {
		var map = ds_map_create();
		ds_map_add(map, "structDot", {name: "dotValue"});

		map[? "structDot"].name = "newDotValue";

		assert_equals(variable_struct_get(ds_map_find_value(map, "structDot"), "name"), "newDotValue", "Map, Struct Dot write failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #6", function() {
		var map = ds_map_create();
		ds_map_add(map, "structBracket", {bracketName: "bracketValue"});

		map[? "structBracket"][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(ds_map_find_value(map, "structBracket"), "bracketName"), "newBracketValue", "Map, Struct Bracket :Const: write failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #7", function() {
		var map = ds_map_create();
		ds_map_add(map, "structBracket", {bracketName: "bracketValue"});

		var _key = "bracketName";
		map[? "structBracket"][$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(ds_map_find_value(map, "structBracket"), "bracketName"), "newBracketValue", "Map, Struct Bracket :Dynamic: write failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #8", function() {
		var map = ds_map_create();
		ds_map_add(map, "structHash", {hashName: "hashValue"});

		struct_set_from_hash(map[? "structHash"], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(ds_map_find_value(map, "structHash"), "hashName"), "newHashValue", "Map, Struct Hash write failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #9", function() {
		var map = ds_map_create();
		ds_map_add(map, "array", [10, 999, 30]);

		assert_equals(map[? "array"][1], 999, "Map, Array access failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #10", function() {
		var map = ds_map_create();
		var nestedList = ds_list_create();
		ds_list_add(nestedList, 1, 888, 3);
		ds_map_add(map, "list", nestedList);

		assert_equals(map[? "list"][| 1], 888, "Map, List access failed.");

		ds_list_destroy(nestedList);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #11", function() {
		var map = ds_map_create();
		var nestedGrid = ds_grid_create(5, 5);
		ds_grid_set(nestedGrid, 2, 2, 777);
		ds_map_add(map, "grid", nestedGrid);

		assert_equals(map[? "grid"][# 2, 2], 777, "Map, Grid access failed.");

		ds_grid_destroy(nestedGrid);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #12", function() {
		var map = ds_map_create();
		var nestedMap = ds_map_create();
		ds_map_add(nestedMap, "mapName", 666);
		ds_map_add(map, "map", nestedMap);

		assert_equals(map[? "map"][? "mapName"], 666, "Map, Map access failed.");

		ds_map_destroy(nestedMap);
		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #13", function() {
		var map = ds_map_create();
		ds_map_add(map, "structDot", {name: "newDotValue"});

		assert_equals(map[? "structDot"].name, "newDotValue", "Map, Struct Dot access failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #14", function() {
		var map = ds_map_create();
		ds_map_add(map, "structBracket", {bracketName: "newBracketValue"});

		assert_equals(map[? "structBracket"][$ "bracketName"], "newBracketValue", "Map, Struct Bracket :Const: access failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #15", function() {
		var map = ds_map_create();
		ds_map_add(map, "structBracket", {bracketName: "newBracketValue"});

		var _key = "bracketName";

		assert_equals(map[? "structBracket"][$ _key], "newBracketValue", "Map, Struct Bracket :Dynamic: access failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #16", function() {
		var map = ds_map_create();
		ds_map_add(map, "structHash", {hashName: "newHashValue"});

		assert_equals(struct_get_from_hash(map[? "structHash"], variable_get_hash("hashName")), "newHashValue", "Map, Struct Hash access failed.");

		ds_map_destroy(map);
	});

	addFact("Map with multiple accessors (Read/Write) #17", function() {
		var map = ds_map_create();
		ds_map_add(map, "function", function() {
			var mapFunc = ds_map_create();
			ds_map_add(mapFunc, "funcKey", 100);
			return mapFunc;
		});

		var _retMap = map[? "function"]();

		assert_equals(_retMap[? "funcKey"], 100, "Map, Function Call access failed.");

		ds_map_destroy(_retMap);
		ds_map_destroy(map);
	});

	// STRUCT DOT ACCESSOR WITH MULTIPLE ACCESSORS TESTS

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #1", function() {
		var struct = {array: [10, 20, 30]};

		struct.array[1] = 999;

		assert_equals(array_get(variable_struct_get(struct, "array"), 1), 999, "Struct, Array write failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #2", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 2, 3);

		struct.list[| 1] = 888;

		assert_equals(ds_list_find_value(variable_struct_get(struct, "list"), 1), 888, "Struct, List write failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #3", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 50);

		struct.grid[# 2, 2] = 777;

		assert_equals(ds_grid_get(variable_struct_get(struct, "grid"), 2, 2), 777, "Struct, Grid write failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #4", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 300);

		struct.map[? "mapName"] = 666;

		assert_equals(ds_map_find_value(variable_struct_get(struct, "map"), "mapName"), 666, "Struct, Map write failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #5", function() {
		var struct = {structDot: {name: "dotValue"}};

		struct.structDot.name = "newDotValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structDot"), "name"), "newDotValue", "Struct, Struct Dot write failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #6", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		struct.structBracket[$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct, Struct Bracket :Const: write failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #7", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		var _key = "bracketName";
		struct.structBracket[$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #8", function() {
		var struct = {structHash: {hashName: "hashValue"}};

		struct_set_from_hash(struct.structHash, variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(variable_struct_get(struct, "structHash"), "hashName"), "newHashValue", "Struct, Struct Hash write failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #9", function() {
		var struct = {array: [10, 999, 30]};

		assert_equals(struct.array[1], 999, "Struct, Array access failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #10", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 888, 3);

		assert_equals(struct.list[| 1], 888, "Struct, List access failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #11", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 777);

		assert_equals(struct.grid[# 2, 2], 777, "Struct, Grid access failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #12", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 666);

		assert_equals(struct.map[? "mapName"], 666, "Struct, Map access failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #13", function() {
		var struct = {structDot: {name: "newDotValue"}};

		assert_equals(struct.structDot.name, "newDotValue", "Struct, Struct Dot access failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #14", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		assert_equals(struct.structBracket[$ "bracketName"], "newBracketValue", "Struct, Struct Bracket :Const: access failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #15", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		var _key = "bracketName";

		assert_equals(struct.structBracket[$ _key], "newBracketValue", "Struct, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #16", function() {
		var struct = {structHash: {hashName: "newHashValue"}};

		assert_equals(struct_get_from_hash(struct.structHash, variable_get_hash("hashName")), "newHashValue", "Struct, Struct Hash access failed.");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #17", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};

		assert_equals(struct.functionCall().key, "funcValue", "Struct, Function Call access failed (inline call).");
	});

	addFact("Struct Dot Accessor with multiple accessors (Read/Write) #18", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};

		var _retStruct = struct.functionCall();

		assert_equals(_retStruct.key, "funcValue", "Struct, Function Call access failed (stored return value).");
	});

	// STRUCT BRACKET ACCESSOR :CONST: WITH MULTIPLE ACCESSORS TESTS

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #1", function() {
		var struct = {array: [10, 20, 30]};

		struct[$ "array"][1] = 999;

		assert_equals(array_get(variable_struct_get(struct, "array"), 1), 999, "Struct Bracket :Const:, Array write failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #2", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 2, 3);

		struct[$ "list"][| 1] = 888;

		assert_equals(ds_list_find_value(variable_struct_get(struct, "list"), 1), 888, "Struct Bracket :Const:, List write failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #3", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 50);

		struct[$ "grid"][# 2, 2] = 777;

		assert_equals(ds_grid_get(variable_struct_get(struct, "grid"), 2, 2), 777, "Struct Bracket :Const:, Grid write failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #4", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 300);

		struct[$ "map"][? "mapName"] = 666;

		assert_equals(ds_map_find_value(variable_struct_get(struct, "map"), "mapName"), 666, "Struct Bracket :Const:, Map write failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #5", function() {
		var struct = {structDot: {name: "dotValue"}};

		struct[$ "structDot"].name = "newDotValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structDot"), "name"), "newDotValue", "Struct Bracket :Const:, Struct Dot write failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #6", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		struct[$ "structBracket"][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Bracket :Const:, Struct Bracket :Const: write failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #7", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		var _key = "bracketName";
		struct[$ "structBracket"][$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Bracket :Const:, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #8", function() {
		var struct = {structHash: {hashName: "hashValue"}};

		struct_set_from_hash(struct[$ "structHash"], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(variable_struct_get(struct, "structHash"), "hashName"), "newHashValue", "Struct Bracket :Const:, Struct Hash write failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #9", function() {
		var struct = {array: [10, 999, 30]};

		assert_equals(struct[$ "array"][1], 999, "Struct Bracket :Const:, Array access failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #10", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 888, 3);

		assert_equals(struct[$ "list"][| 1], 888, "Struct Bracket :Const:, List access failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #11", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 777);

		assert_equals(struct[$ "grid"][# 2, 2], 777, "Struct Bracket :Const:, Grid access failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #12", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 666);

		assert_equals(struct[$ "map"][? "mapName"], 666, "Struct Bracket :Const:, Map access failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #13", function() {
		var struct = {structDot: {name: "newDotValue"}};

		assert_equals(struct[$ "structDot"].name, "newDotValue", "Struct Bracket :Const:, Struct Dot access failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #14", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		assert_equals(struct[$ "structBracket"][$ "bracketName"], "newBracketValue", "Struct Bracket :Const:, Struct Bracket :Const: access failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #15", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		var _key = "bracketName";

		assert_equals(struct[$ "structBracket"][$ _key], "newBracketValue", "Struct Bracket :Const:, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #16", function() {
		var struct = {structHash: {hashName: "newHashValue"}};

		assert_equals(struct_get_from_hash(struct[$ "structHash"], variable_get_hash("hashName")), "newHashValue", "Struct Bracket :Const:, Struct Hash access failed.");
	});

	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write) #17", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};

		var _retStruct = struct[$ "functionCall"]();

		assert_equals(_retStruct[$ "key"], "funcValue", "Struct Bracket :Const:, Function Call access failed.");
	});

	// STRUCT BRACKET ACCESSOR :DYNAMIC: WITH MULTIPLE ACCESSORS TESTS

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #1", function() {
		var struct = {array: [10, 20, 30]};

		var _key = "array";
		struct[$ _key][1] = 999;

		assert_equals(array_get(variable_struct_get(struct, "array"), 1), 999, "Struct Bracket with variable, Array write failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #2", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 2, 3);

		var _key = "list";
		struct[$ _key][| 1] = 888;

		assert_equals(ds_list_find_value(variable_struct_get(struct, "list"), 1), 888, "Struct Bracket with variable, List write failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #3", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 50);

		var _key = "grid";
		struct[$ _key][# 2, 2] = 777;

		assert_equals(ds_grid_get(variable_struct_get(struct, "grid"), 2, 2), 777, "Struct Bracket with variable, Grid write failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #4", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 300);

		var _key = "map";
		struct[$ _key][? "mapName"] = 666;

		assert_equals(ds_map_find_value(variable_struct_get(struct, "map"), "mapName"), 666, "Struct Bracket with variable, Map write failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #5", function() {
		var struct = {structDot: {name: "dotValue"}};

		var _key = "structDot";
		struct[$ _key].name = "newDotValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structDot"), "name"), "newDotValue", "Struct Bracket with variable, Struct Dot write failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #6", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		var _key = "structBracket";
		struct[$ _key][$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Bracket with variable, Struct Bracket :Const: write failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #7", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};

		var _key = "structBracket";
		var _key2 = "bracketName";
		struct[$ _key][$ _key2] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Bracket with variable, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #8", function() {
		var struct = {structHash: {hashName: "hashValue"}};

		var _key = "structHash";
		struct_set_from_hash(struct[$ _key], variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(variable_struct_get(struct, "structHash"), "hashName"), "newHashValue", "Struct Bracket with variable, Struct Hash write failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #9", function() {
		var struct = {array: [10, 999, 30]};

		var _key = "array";

		assert_equals(struct[$ _key][1], 999, "Struct Bracket with variable, Array access failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #10", function() {
		var struct = {list: ds_list_create()};
		ds_list_add(variable_struct_get(struct, "list"), 1, 888, 3);

		var _key = "list";

		assert_equals(struct[$ _key][| 1], 888, "Struct Bracket with variable, List access failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #11", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 777);

		var _key = "grid";

		assert_equals(struct[$ _key][# 2, 2], 777, "Struct Bracket with variable, Grid access failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #12", function() {
		var struct = {map: ds_map_create()};
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 666);

		var _key = "map";

		assert_equals(struct[$ _key][? "mapName"], 666, "Struct Bracket with variable, Map access failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #13", function() {
		var struct = {structDot: {name: "newDotValue"}};

		var _key = "structDot";

		assert_equals(struct[$ _key].name, "newDotValue", "Struct Bracket with variable, Struct Dot access failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #14", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		var _key = "structBracket";

		assert_equals(struct[$ _key][$ "bracketName"], "newBracketValue", "Struct Bracket with variable, Struct Bracket :Const: access failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #15", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};

		var _key = "structBracket";
		var _key2 = "bracketName";

		assert_equals(struct[$ _key][$ _key2], "newBracketValue", "Struct Bracket with variable, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #16", function() {
		var struct = {structHash: {hashName: "newHashValue"}};

		var _key = "structHash";

		assert_equals(struct_get_from_hash(struct[$ _key], variable_get_hash("hashName")), "newHashValue", "Struct Bracket with variable, Struct Hash access failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: with multiple accessors (Read/Write) #17", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};

		var _key = "functionCall";
		var _key2 = "key";

		var _retStruct = struct[$ _key]();

		assert_equals(_retStruct[$ _key2], "funcValue", "Struct Bracket with variable, Function Call access failed.");
	});

	// STRUCT HASH ACCESSOR WITH MULTIPLE ACCESSORS TESTS

	addFact("Struct Hash Accessor (Read/Write) #1", function() {
		var struct = {array: [10, 20, 30]};
		var _arrayHash = variable_get_hash("array");

		var _array = struct_get_from_hash(struct, _arrayHash);
		_array[1] = 999;

		assert_equals(array_get(variable_struct_get(struct, "array"), 1), 999, "Struct Hash, Array write failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #2", function() {
		var struct = {list: ds_list_create()};
		var _listHash = variable_get_hash("list");
		ds_list_add(variable_struct_get(struct, "list"), 1, 2, 3);

		var _list = struct_get_from_hash(struct, _listHash);
		_list[| 1] = 888;

		assert_equals(ds_list_find_value(variable_struct_get(struct, "list"), 1), 888, "Struct Hash, List write failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Hash Accessor (Read/Write) #3", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		var _gridHash = variable_get_hash("grid");
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 50);

		var _grid = struct_get_from_hash(struct, _gridHash);
		_grid[# 2, 2] = 777;

		assert_equals(ds_grid_get(variable_struct_get(struct, "grid"), 2, 2), 777, "Struct Hash, Grid write failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Hash Accessor (Read/Write) #4", function() {
		var struct = {map: ds_map_create()};
		var _mapHash = variable_get_hash("map");
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 300);

		var _map = struct_get_from_hash(struct, _mapHash);
		_map[? "mapName"] = 666;

		assert_equals(ds_map_find_value(variable_struct_get(struct, "map"), "mapName"), 666, "Struct Hash, Map write failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Hash Accessor (Read/Write) #5", function() {
		var struct = {structDot: {name: "dotValue"}};
		var _dotHash = variable_get_hash("structDot");

		struct_get_from_hash(struct, _dotHash).name = "newDotValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structDot"), "name"), "newDotValue", "Struct Hash, Struct Dot write failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #6", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};
		var _bracketHash = variable_get_hash("structBracket");

		struct_get_from_hash(struct, _bracketHash)[$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Hash, Struct Bracket :Const: write failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #7", function() {
		var struct = {structBracket: {bracketName: "bracketValue"}};
		var _bracketHash = variable_get_hash("structBracket");

		var _key = "bracketName";
		struct_get_from_hash(struct, _bracketHash)[$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(variable_struct_get(struct, "structBracket"), "bracketName"), "newBracketValue", "Struct Hash, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #8", function() {
		var struct = {structHash: {hashName: "hashValue"}};
		var _hashStructHash = variable_get_hash("structHash");

		struct_set_from_hash(struct_get_from_hash(struct, _hashStructHash), variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(variable_struct_get(struct, "structHash"), "hashName"), "newHashValue", "Struct Hash, Struct Hash write failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #9", function() {
		var struct = {array: [10, 999, 30]};
		var _arrayHash = variable_get_hash("array");

		var _array = struct_get_from_hash(struct, _arrayHash);

		assert_equals(_array[1], 999, "Struct Hash, Array access failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #10", function() {
		var struct = {list: ds_list_create()};
		var _listHash = variable_get_hash("list");
		ds_list_add(variable_struct_get(struct, "list"), 1, 888, 3);

		var _list = struct_get_from_hash(struct, _listHash);

		assert_equals(_list[| 1], 888, "Struct Hash, List access failed.");

		ds_list_destroy(variable_struct_get(struct, "list"));
	});

	addFact("Struct Hash Accessor (Read/Write) #11", function() {
		var struct = {grid: ds_grid_create(5, 5)};
		var _gridHash = variable_get_hash("grid");
		ds_grid_set(variable_struct_get(struct, "grid"), 2, 2, 777);

		var _grid = struct_get_from_hash(struct, _gridHash);

		assert_equals(_grid[# 2, 2], 777, "Struct Hash, Grid access failed.");

		ds_grid_destroy(variable_struct_get(struct, "grid"));
	});

	addFact("Struct Hash Accessor (Read/Write) #12", function() {
		var struct = {map: ds_map_create()};
		var _mapHash = variable_get_hash("map");
		ds_map_add(variable_struct_get(struct, "map"), "mapName", 666);

		var _map = struct_get_from_hash(struct, _mapHash);

		assert_equals(_map[? "mapName"], 666, "Struct Hash, Map access failed.");

		ds_map_destroy(variable_struct_get(struct, "map"));
	});

	addFact("Struct Hash Accessor (Read/Write) #13", function() {
		var struct = {structDot: {name: "newDotValue"}};
		var _dotHash = variable_get_hash("structDot");

		assert_equals(struct_get_from_hash(struct, _dotHash).name, "newDotValue", "Struct Hash, Struct Dot access failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #14", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};
		var _bracketHash = variable_get_hash("structBracket");

		assert_equals(struct_get_from_hash(struct, _bracketHash)[$ "bracketName"], "newBracketValue", "Struct Hash, Struct Bracket :Const: access failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #15", function() {
		var struct = {structBracket: {bracketName: "newBracketValue"}};
		var _bracketHash = variable_get_hash("structBracket");

		var _key = "bracketName";

		assert_equals(struct_get_from_hash(struct, _bracketHash)[$ _key], "newBracketValue", "Struct Hash, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #16", function() {
		var struct = {structHash: {hashName: "newHashValue"}};
		var _hashStructHash = variable_get_hash("structHash");

		assert_equals(struct_get_from_hash(struct_get_from_hash(struct, _hashStructHash), variable_get_hash("hashName")), "newHashValue", "Struct Hash, Struct Hash access failed.");
	});

	addFact("Struct Hash Accessor (Read/Write) #17", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};
		var _funcHash = variable_get_hash("functionCall");
		var _keyHash = variable_get_hash("key");

		assert_equals(struct_get_from_hash(struct_get_from_hash(struct, _funcHash)(), _keyHash), "funcValue", "Struct Hash, Function Call access failed (inline call).");
	});

	addFact("Struct Hash Accessor (Read/Write) #18", function() {
		var struct = {
			functionCall: function() {
				return {key: "funcValue"};
			}
		};
		var _funcHash = variable_get_hash("functionCall");
		var _keyHash = variable_get_hash("key");

		var _retStruct = struct_get_from_hash(struct, _funcHash)();

		assert_equals(struct_get_from_hash(_retStruct, _keyHash), "funcValue", "Struct Hash, Function Call access failed (stored return value).");
	});

	// FUNCTION CALL WITH MULTIPLE ACCESSORS TESTS

	addFact("Function Call with multiple accessors (Read/Write) #1", function() {
		funcArray = function() {
			static r = [10, 20, 30];
			return r;
		}

		funcArray()[1] = 999;

		assert_equals(array_get(funcArray(), 1), 999, "Function Call, Array write failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #2", function() {
		funcList = function() {
			static r = ds_list_create();
			return r;
		}
		ds_list_add(funcList(), 1, 2, 3);

		funcList()[| 1] = 888;

		assert_equals(ds_list_find_value(funcList(), 1), 888, "Function Call, List write failed.");

		ds_list_destroy(funcList());
	});

	addFact("Function Call with multiple accessors (Read/Write) #3", function() {
		funcGrid = function() {
			static r = ds_grid_create(5, 5);
			return r;
		}
		ds_grid_set(funcGrid(), 2, 2, 50);

		var _retGrid = funcGrid();
		_retGrid[# 2, 2] = 777;

		assert_equals(ds_grid_get(funcGrid(), 2, 2), 777, "Function Call, Grid write failed.");

		ds_grid_destroy(funcGrid());
	});

	addFact("Function Call with multiple accessors (Read/Write) #4", function() {
		funcMap = function() {
			static r = ds_map_create();
			return r;
		}
		ds_map_add(funcMap(), "mapName", 300);

		funcMap()[? "mapName"] = 666;

		assert_equals(ds_map_find_value(funcMap(), "mapName"), 666, "Function Call, Map write failed.");

		ds_map_destroy(funcMap());
	});

	addFact("Function Call with multiple accessors (Read/Write) #5", function() {
		funcStructDot = function() {
			static r = {name: "dotValue"};
			return r;
		}

		funcStructDot().name = "newDotValue";

		assert_equals(variable_struct_get(funcStructDot(), "name"), "newDotValue", "Function Call, Struct Dot write failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #6", function() {
		funcStructBracket = function() {
			static r = {bracketName: "bracketValue"};
			return r;
		}

		funcStructBracket()[$ "bracketName"] = "newBracketValue";

		assert_equals(variable_struct_get(funcStructBracket(), "bracketName"), "newBracketValue", "Function Call, Struct Bracket :Const: write failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #7", function() {
		funcStructBracket = function() {
			static r = {bracketName: "bracketValue"};
			return r;
		}

		var _key = "bracketName";
		funcStructBracket()[$ _key] = "newBracketValue";

		assert_equals(variable_struct_get(funcStructBracket(), "bracketName"), "newBracketValue", "Function Call, Struct Bracket :Dynamic: write failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #8", function() {
		funcStructHash = function() {
			static r = {hashName: "hashValue"};
			return r;
		}

		struct_set_from_hash(funcStructHash(), variable_get_hash("hashName"), "newHashValue");

		assert_equals(variable_struct_get(funcStructHash(), "hashName"), "newHashValue", "Function Call, Struct Hash write failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #9", function() {
		funcArray = function() {
			static r = [10, 999, 30];
			return r;
		}

		assert_equals(funcArray()[1], 999, "Function Call, Array access failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #10", function() {
		funcList = function() {
			static r = ds_list_create();
			return r;
		}
		ds_list_add(funcList(), 1, 888, 3);

		assert_equals(funcList()[| 1], 888, "Function Call, List access failed.");

		ds_list_destroy(funcList());
	});

	addFact("Function Call with multiple accessors (Read/Write) #11", function() {
		funcGrid = function() {
			static r = ds_grid_create(5, 5);
			return r;
		}
		ds_grid_set(funcGrid(), 2, 2, 777);

		var _retGrid = funcGrid();

		assert_equals(_retGrid[# 2, 2], 777, "Function Call, Grid access failed.");

		ds_grid_destroy(funcGrid());
	});

	addFact("Function Call with multiple accessors (Read/Write) #12", function() {
		funcMap = function() {
			static r = ds_map_create();
			return r;
		}
		ds_map_add(funcMap(), "mapName", 666);

		assert_equals(funcMap()[? "mapName"], 666, "Function Call, Map access failed.");

		ds_map_destroy(funcMap());
	});

	addFact("Function Call with multiple accessors (Read/Write) #13", function() {
		funcStructDot = function() {
			static r = {name: "newDotValue"};
			return r;
		}

		assert_equals(funcStructDot().name, "newDotValue", "Function Call, Struct Dot access failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #14", function() {
		funcStructBracket = function() {
			static r = {bracketName: "newBracketValue"};
			return r;
		}

		assert_equals(funcStructBracket()[$ "bracketName"], "newBracketValue", "Function Call, Struct Bracket :Const: access failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #15", function() {
		funcStructBracket = function() {
			static r = {bracketName: "newBracketValue"};
			return r;
		}

		var _key = "bracketName";

		assert_equals(funcStructBracket()[$ _key], "newBracketValue", "Function Call, Struct Bracket :Dynamic: access failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #16", function() {
		funcStructHash = function() {
			static r = {hashName: "newHashValue"};
			return r;
		}

		assert_equals(struct_get_from_hash(funcStructHash(), variable_get_hash("hashName")), "newHashValue", "Function Call, Struct Hash access failed.");
	});

	addFact("Function Call with multiple accessors (Read/Write) #17", function() {
		funcFunctionCall = function() {
			static r = function() {
				static r = {key: "funcValue"};
				return r;
			};
			return r;
		}

		var _retStruct = funcFunctionCall()();

		assert_equals(_retStruct.key, "funcValue", "Function Call, Function Call access failed.");
	});

}
