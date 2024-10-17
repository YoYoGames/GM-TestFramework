

function BasicAccessorExpressionsTestSuite() : TestSuite() constructor {

    // Test for Array access and modification
    addFact("Array access and modification", function() {
        var arr = [0, 1, 2];
        arr[0] = 1;
        var test = arr[2];

        // Assertions
        assert_equals(arr[0], 1, "Array modification failed at index 0.");
        assert_equals(test, 2, "Array access failed at index 2.");
        assert_array_equals(arr, [1,1,2], "Array equals failed.");
    });

    // Test for List access and modification
    addFact("List access and modification", function() {
        var list = ds_list_create();
        list[| 0] = 1;
        list[| 1] = 2;
        ds_list_set(list, 2, 3);
        var test = list[| 2];

        // Assertions
        assert_equals(list[| 0], 1, "List modification failed at index 0.");
        assert_equals(list[| 1], 2, "List modification failed at index 1.");
        assert_equals(test, 3, "List access failed at index 2.");

        // Cleanup
        ds_list_destroy(list);
    });

    // Test for Grid access and modification
    addFact("Grid access and modification", function() {
        var grid = ds_grid_create(5, 5);
        ds_grid_set_region(grid, 0, 0, 4, 4, "example");
        grid[# 0, 1] = 2;
        var test = grid[# 3, 4];

        // Assertions
        assert_equals(grid[# 0, 1], 2, "Grid modification failed at [0, 1].");
        assert_equals(test, "example", "Grid access failed at [3, 4].");

        // Cleanup
        ds_grid_destroy(grid);
    });

    // Test for Map access and modification
    addFact("Map access and modification", function() {
        var map = ds_map_create();
        map[? "zero"] = 1;
        ds_map_set(map, "zero", 2);
        map[? "two"] = 3;
        var test = map[? "two"];

        // Assertions
        assert_equals(map[? "zero"], 2, "Map modification failed for key 'zero'.");
        assert_equals(test, 3, "Map access failed for key 'two'.");

        // Cleanup
        ds_map_destroy(map);
    });
	
	// Dot Accessor Test
    addFact("Struct Dot Accessor Test", function() {
        var struct = {zero: 0, one: 1, two: 2};
        struct.zero = 1;
        var test = struct.two;
        assert_equals(test, 2, "Dot accessor did not return the expected value for 'two'");
        assert_equals(struct.zero, 1, "Dot accessor did not modify the 'zero' field correctly");
    });

    // Struct Accessor Test
    addFact("Struct Bracket Accessor :Const: Test", function() {
        var struct = {zero: 0, one: 1, two: 2};
        struct[$ "zero"] = 1;
        var test = struct[$ "two"];
        assert_equals(test, 2, "Bracket accessor did not return the expected value for 'two'");
        assert_equals(struct[$ "zero"], 1, "Bracket accessor did not modify the 'zero' field correctly");
    });
	
    // Struct Accessor Test
    addFact("Struct Bracket Accessor :Dynamic: Test", function() {
        var struct = {zero: 0, one: 1, two: 2};
		
		var _key = "zero"
        struct[$ _key] = 1;
        
		var _key = "two"
		var test = struct[$ _key];
		
        assert_equals(test, 2, "Bracket accessor did not return the expected value for 'two'");
		
		var _key = "zero"
        assert_equals(struct[$ _key], 1, "Bracket accessor did not modify the 'zero' field correctly");
    });
	
    // Test for Struct hash setting
    addFact("Struct hash setting", function() {
        var struct = {one: 1};
        
        // Set new value using hash of "one"
        struct_set_from_hash(struct, variable_get_hash("one"), "oneAgain");
        
		var _value = struct_get_from_hash(struct, variable_get_hash("one"))
        // Assertions
        assert_equals(_value, "oneAgain", "Struct modification using hash failed.");
        assert_struct_equals(struct, {one:"oneAgain"}, "Struct equals failed.");
    });
	
	
	addFact("Array with multiple accessors (Read/Write)", function() {
	    // Initialize the array with various data structures and values
	    var arr = [
	        [10, 20, 30],                           // Array for Array access
	        ds_list_create(),                       // List for Array, List access
	        ds_grid_create(5, 5),                   // Grid for Array, Grid access
	        ds_map_create(),                        // Map for Array, Map access
	        {name: "dotValue"},                     // Struct for Array, Struct Dot access
	        {bracketName: "bracketValue"},          // Struct for Array, Struct Bracket access
	        {hashName: "hashValue"},                // Struct for Array, Struct Hash access
	        function() { return [100, 200]; }       // Function Call for Array, Function Call access
	    ];

	    // Populate List
	    ds_list_add(arr[1], 1, 2, 3);
    
	    // Populate Grid
	    ds_grid_set(arr[2], 2, 2, 50);
    
	    // Populate Map
	    ds_map_add(arr[3], "mapName", 300);

	    // ** Write Operations **

	    // Array, Array Access - Modify value
	    arr[0][1] = 999;
	    assert_equals(arr[0][1], 999, "Array, Array write failed.");

	    // Array, List Access - Modify value
	    arr[1][| 1] = 888;
	    assert_equals(arr[1][| 1], 888, "Array, List write failed.");

	    // Array, Grid Access - Modify value
	    arr[2][# 2, 2] = 777;
	    assert_equals(arr[2][# 2, 2], 777, "Array, Grid write failed.");

	    // Array, Map Access - Modify value
	    arr[3][? "mapName"] = 666;
	    assert_equals(arr[3][? "mapName"], 666, "Array, Map write failed.");

	    // Array, Struct Dot Access - Modify value
	    arr[4].name = "newDotValue";
	    assert_equals(arr[4].name, "newDotValue", "Array, Struct Dot write failed.");

	    // Array, Struct Bracket Access :Const: - Modify value
	    arr[5][$ "bracketName"] = "newBracketValue";
	    assert_equals(arr[5][$ "bracketName"], "newBracketValue", "Array, Struct Bracket :Const: write failed.");

	    // Array, Struct Bracket Access :Dynamic: - Modify value
	    var _key = "bracketName"
		arr[5][$ _key] = "newBracketValue";
	    assert_equals(arr[5][$ _key], "newBracketValue", "Array, Struct Bracket :Dynamic: write failed.");

	    // Array, Struct Hash Access - Modify value
	    struct_set_from_hash(arr[6], variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(arr[6], variable_get_hash("hashName")), "newHashValue", "Array, Struct Hash write failed.");

	    // ** Read Operations **

	    // Array, Array Access
	    assert_equals(arr[0][1], 999, "Array, Array access failed.");

	    // Array, List Access
	    assert_equals(arr[1][| 1], 888, "Array, List access failed.");

	    // Array, Grid Access
	    assert_equals(arr[2][# 2, 2], 777, "Array, Grid access failed.");

	    // Array, Map Access
	    assert_equals(arr[3][? "mapName"], 666, "Array, Map access failed.");

	    // Array, Struct Dot Access
	    assert_equals(arr[4].name, "newDotValue", "Array, Struct Dot access failed.");

	    // Array, Struct Bracket Access
	    assert_equals(arr[5][$ "bracketName"], "newBracketValue", "Array, Struct Bracket access failed.");

	    // Array, Struct Bracket Access
		var _key = "bracketName"
	    assert_equals(arr[5][$ _key], "newBracketValue", "Array, Struct Bracket access failed.");

	    // Array, Struct Hash Access
	    assert_equals(struct_get_from_hash(arr[6], variable_get_hash("hashName")), "newHashValue", "Array, Struct Hash access failed.");

	    // Array, Function Call Access (no write)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(arr[7]()[0], 100, "Array, Function Call access failed (first return value).");
//	    assert_equals(arr[7]()[1], 200, "Array, Function Call access failed (second return value).");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
		var _retArr = arr[7]()
		assert_equals(_retArr[0], 100, "Array, Function Call access failed (first return value).");
	    assert_equals(_retArr[1], 200, "Array, Function Call access failed (second return value).");

	    // Cleanup
	    ds_list_destroy(arr[1]);
	    ds_grid_destroy(arr[2]);
	    ds_map_destroy(arr[3]);
	});
	
	addFact("List with multiple accessors (Read/Write)", function() {
	    // Initialize the list with various data structures and values
	    var list = ds_list_create();
    
	    ds_list_add(list,
	        [10, 20, 30],                          // Array for List, Array access
	        ds_list_create(),                      // List for List, List access
	        ds_grid_create(5, 5),                  // Grid for List, Grid access
	        ds_map_create(),                       // Map for List, Map access
	        {name: "dotValue"},                    // Struct for List, Struct Dot access
	        {bracketName: "bracketValue"},         // Struct for List, Struct Bracket access
	        {hashName: "hashValue"},               // Struct for List, Struct Hash access
	        function() {                           // Function Call for List, Function Call access
	            var listFunc = ds_list_create();
	            ds_list_add(listFunc, 100, 200);
	            return listFunc;
	        }
	    );
    
	    // Populate nested List
	    ds_list_add(list[| 1], 1, 2, 3);

	    // Populate Grid
	    ds_grid_set(list[| 2], 2, 2, 50);

	    // Populate Map
	    ds_map_add(list[| 3], "mapName", 300);

	    // ** Write Operations **

	    // List, Array Access - Modify value
	    list[| 0][1] = 999;
	    assert_equals(list[| 0][1], 999, "List, Array write failed.");

	    // List, List Access - Modify value
	    list[| 1][| 1] = 888;
	    assert_equals(list[| 1][| 1], 888, "List, List write failed.");

	    // List, Grid Access - Modify value
	    list[| 2][# 2, 2] = 777;
	    assert_equals(list[| 2][# 2, 2], 777, "List, Grid write failed.");

	    // List, Map Access - Modify value
	    list[| 3][? "mapName"] = 666;
	    assert_equals(list[| 3][? "mapName"], 666, "List, Map write failed.");

	    // List, Struct Dot Access - Modify value
	    list[| 4].name = "newDotValue";
	    assert_equals(list[| 4].name, "newDotValue", "List, Struct Dot write failed.");

	    // List, Struct Bracket Access :Const: - Modify value
	    list[| 5][$ "bracketName"] = "newBracketValue";
	    assert_equals(list[| 5][$ "bracketName"], "newBracketValue", "List, Struct Bracket :Const: write failed.");

	    // List, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
	    list[| 5][$ _key] = "newBracketValue";
	    assert_equals(list[| 5][$ _key], "newBracketValue", "List, Struct Bracket :Dynamic: write failed.");

	    // List, Struct Hash Access - Modify value
	    struct_set_from_hash(list[| 6], variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(list[| 6], variable_get_hash("hashName")), "newHashValue", "List, Struct Hash write failed.");

	    // ** Read Operations **

	    // List, Array Access
	    assert_equals(list[| 0][1], 999, "List, Array access failed.");

	    // List, List Access
	    assert_equals(list[| 1][| 1], 888, "List, List access failed.");

	    // List, Grid Access
	    assert_equals(list[| 2][# 2, 2], 777, "List, Grid access failed.");

	    // List, Map Access
	    assert_equals(list[| 3][? "mapName"], 666, "List, Map access failed.");

	    // List, Struct Dot Access
	    assert_equals(list[| 4].name, "newDotValue", "List, Struct Dot access failed.");

	    // List, Struct Bracket Access :Const:
	    assert_equals(list[| 5][$ "bracketName"], "newBracketValue", "List, Struct Bracket access failed.");

	    // List, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
	    assert_equals(list[| 5][$ _key], "newBracketValue", "List, Struct Bracket access failed.");

	    // List, Struct Hash Access
	    assert_equals(struct_get_from_hash(list[| 6], variable_get_hash("hashName")), "newHashValue", "List, Struct Hash access failed.");
		
	    // List, Function Call Access (no write)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(list[| 7]()[| 0], 100, "List, Function Call access failed (first return value).");
//		assert_equals(list[| 7]()[| 1], 200, "List, Function Call access failed (second return value).");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	    // Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
	    var _retList = list[| 7]();
	    assert_equals(_retList[| 0], 100, "List, Function Call access failed (first return value).");
	    assert_equals(_retList[| 1], 200, "List, Function Call access failed (second return value).");

	    // Cleanup
	    ds_list_destroy(list[| 1]);
	    ds_grid_destroy(list[| 2]);
	    ds_map_destroy(list[| 3]);
	    ds_list_destroy(_retList); // Cleanup the list returned by the function
	    ds_list_destroy(list);
	});

	addFact("Grid with multiple accessors (Read/Write)", function() {
	    // Initialize the grid (5x5 for simplicity) with various data structures and values
	    var grid = ds_grid_create(16, 16);

	    // Fill the grid with values and data structures for different tests
	    ds_grid_set(grid, 0, 1, [10, 20, 30]);                           // Array for Grid, Array access
	    ds_grid_set(grid, 2, 3, ds_list_create());                       // List for Grid, List access
	    ds_grid_set(grid, 4, 5, ds_grid_create(5, 5));                   // Grid for Grid, Grid access
	    ds_grid_set(grid, 6, 7, ds_map_create());                        // Map for Grid, Map access
	    ds_grid_set(grid, 8, 9, {name: "dotValue"});                     // Struct for Grid, Struct Dot access
	    ds_grid_set(grid, 10, 11, {bracketName: "bracketValue"});        // Struct for Grid, Struct Bracket access
	    ds_grid_set(grid, 12, 13, {hashName: "hashValue"});              // Struct for Grid, Struct Hash access
	    ds_grid_set(grid, 14, 15, function() {                           // Function Call for Grid, Function Call access
	        var gridFunc = ds_grid_create(3, 3);
	        ds_grid_set(gridFunc, 1, 1, 100);
	        return gridFunc;
	    });

	    // Populate List
	    ds_list_add(grid[# 2, 3], 1, 2, 3);

	    // Populate Grid within the Grid
	    ds_grid_set(grid[# 4, 5], 2, 2, 50);

	    // Populate Map
	    ds_map_add(grid[# 6, 7], "mapName", 300);

	    // ** Write Operations **

	    // Grid, Array Access - Modify value
	    grid[# 0, 1][1] = 999;
	    assert_equals(grid[# 0, 1][1], 999, "Grid, Array write failed.");

	    // Grid, List Access - Modify value
	    grid[# 2, 3][| 1] = 888;
	    assert_equals(grid[# 2, 3][| 1], 888, "Grid, List write failed.");

	    // Grid, Grid Access - Modify value
	    grid[# 4, 5][# 2, 2] = 777;
	    assert_equals(grid[# 4, 5][# 2, 2], 777, "Grid, Grid write failed.");

	    // Grid, Map Access - Modify value
	    grid[# 6, 7][? "mapName"] = 666;
	    assert_equals(grid[# 6, 7][? "mapName"], 666, "Grid, Map write failed.");

	    // Grid, Struct Dot Access - Modify value
	    grid[# 8, 9].name = "newDotValue";
	    assert_equals(grid[# 8, 9].name, "newDotValue", "Grid, Struct Dot write failed.");

	    // Grid, Struct Bracket Access :Const: - Modify value
	    grid[# 10, 11][$ "bracketName"] = "newBracketValue";
	    assert_equals(grid[# 10, 11][$ "bracketName"], "newBracketValue", "Grid, Struct Bracket :Const: write failed.");

	    // Grid, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
	    grid[# 10, 11][$ _key] = "newBracketValue";
	    assert_equals(grid[# 10, 11][$ _key], "newBracketValue", "Grid, Struct Bracket :Dynamic: write failed.");

	    // Grid, Struct Hash Access - Modify value
	    struct_set_from_hash(grid[# 12, 13], variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(grid[# 12, 13], variable_get_hash("hashName")), "newHashValue", "Grid, Struct Hash write failed.");

	    // ** Read Operations **

	    // Grid, Array Access
	    assert_equals(grid[# 0, 1][1], 999, "Grid, Array access failed.");

	    // Grid, List Access
	    assert_equals(grid[# 2, 3][| 1], 888, "Grid, List access failed.");

	    // Grid, Grid Access
	    assert_equals(grid[# 4, 5][# 2, 2], 777, "Grid, Grid access failed.");

	    // Grid, Map Access
	    assert_equals(grid[# 6, 7][? "mapName"], 666, "Grid, Map access failed.");

	    // Grid, Struct Dot Access
	    assert_equals(grid[# 8, 9].name, "newDotValue", "Grid, Struct Dot access failed.");

	    // Grid, Struct Bracket Access :Const:
	    assert_equals(grid[# 10, 11][$ "bracketName"], "newBracketValue", "Grid, Struct Bracket access failed.");

	    // Grid, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
	    assert_equals(grid[# 10, 11][$ _key], "newBracketValue", "Grid, Struct Bracket access failed.");

	    // Grid, Struct Hash Access
	    assert_equals(struct_get_from_hash(grid[# 12, 13], variable_get_hash("hashName")), "newHashValue", "Grid, Struct Hash access failed.");

	    // Grid, Function Call Access (no write)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(grid[# 14, 15]()[# 1, 1], 100, "Grid, Function Call access failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
	    var _retGrid = grid[# 14, 15]();
	    assert_equals(_retGrid[# 1, 1], 100, "Grid, Function Call access failed.");

	    // Cleanup
	    ds_list_destroy(grid[# 2, 3]);
	    ds_grid_destroy(grid[# 4, 5]);
	    ds_map_destroy(grid[# 6, 7]);
	    ds_grid_destroy(_retGrid); // Cleanup the grid returned by the function
	    ds_grid_destroy(grid);
	});
	
	addFact("Map with multiple accessors (Read/Write)", function() {
	    // Initialize the map with various data structures and values
	    var map = ds_map_create();
    
	    ds_map_add(map, "array", [10, 20, 30]);                           // Array for Map, Array access
	    var nestedList = ds_list_create();
	    ds_list_add(nestedList, 1, 2, 3);
	    ds_map_add(map, "list", nestedList);                              // List for Map, List access
	    var nestedGrid = ds_grid_create(5, 5);
	    ds_grid_set(nestedGrid, 2, 2, 50);
	    ds_map_add(map, "grid", nestedGrid);                              // Grid for Map, Grid access
	    var nestedMap = ds_map_create();
	    ds_map_add(nestedMap, "mapName", 300);
	    ds_map_add(map, "map", nestedMap);                                // Map for Map, Map access
	    ds_map_add(map, "structDot", {name: "dotValue"});                 // Struct for Map, Struct Dot access
	    ds_map_add(map, "structBracket", {bracketName: "bracketValue"});  // Struct for Map, Struct Bracket access
	    ds_map_add(map, "structHash", {hashName: "hashValue"});           // Struct for Map, Struct Hash access
	    ds_map_add(map, "function", function() {                          // Function Call for Map, Function Call access
	        var mapFunc = ds_map_create();
	        ds_map_add(mapFunc, "funcKey", 100);
	        return mapFunc;
	    });

	    // ** Write Operations **

	    // Map, Array Access - Modify value
	    map[? "array"][1] = 999;
	    assert_equals(map[? "array"][1], 999, "Map, Array write failed.");

	    // Map, List Access - Modify value
	    map[? "list"][| 1] = 888;
	    assert_equals(map[? "list"][| 1], 888, "Map, List write failed.");

	    // Map, Grid Access - Modify value
	    map[? "grid"][# 2, 2] = 777;
	    assert_equals(map[? "grid"][# 2, 2], 777, "Map, Grid write failed.");

	    // Map, Map Access - Modify value
	    map[? "map"][? "mapName"] = 666;
	    assert_equals(map[? "map"][? "mapName"], 666, "Map, Map write failed.");

	    // Map, Struct Dot Access - Modify value
	    map[? "structDot"].name = "newDotValue";
	    assert_equals(map[? "structDot"].name, "newDotValue", "Map, Struct Dot write failed.");

	    // Map, Struct Bracket Access :Const: - Modify value
	    map[? "structBracket"][$ "bracketName"] = "newBracketValue";
	    assert_equals(map[? "structBracket"][$ "bracketName"], "newBracketValue", "Map, Struct Bracket :Const: write failed.");

	    // Map, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
	    map[? "structBracket"][$ _key] = "newBracketValue";
	    assert_equals(map[? "structBracket"][$ _key], "newBracketValue", "Map, Struct Bracket :Dynamic: write failed.");

	    // Map, Struct Hash Access - Modify value
	    struct_set_from_hash(map[? "structHash"], variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(map[? "structHash"], variable_get_hash("hashName")), "newHashValue", "Map, Struct Hash write failed.");

	    // ** Read Operations **

	    // Map, Array Access
	    assert_equals(map[? "array"][1], 999, "Map, Array access failed.");

	    // Map, List Access
	    assert_equals(map[? "list"][| 1], 888, "Map, List access failed.");

	    // Map, Grid Access
	    assert_equals(map[? "grid"][# 2, 2], 777, "Map, Grid access failed.");

	    // Map, Map Access
	    assert_equals(map[? "map"][? "mapName"], 666, "Map, Map access failed.");

	    // Map, Struct Dot Access
	    assert_equals(map[? "structDot"].name, "newDotValue", "Map, Struct Dot access failed.");

	    // Map, Struct Bracket Access :Const:
	    assert_equals(map[? "structBracket"][$ "bracketName"], "newBracketValue", "Map, Struct Bracket access failed.");

	    // Map, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
	    assert_equals(map[? "structBracket"][$ _key], "newBracketValue", "Map, Struct Bracket access failed.");

	    // Map, Struct Hash Access
	    assert_equals(struct_get_from_hash(map[? "structHash"], variable_get_hash("hashName")), "newHashValue", "Map, Struct Hash access failed.");

	    // Map, Function Call Access (no write)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(map[? "function"]()[? "funcKey"], 100, "Map, Function Call access failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
	    var _retMap = map[? "function"]();
	    assert_equals(_retMap[? "funcKey"], 100, "Map, Function Call access failed.");

	    // Cleanup
	    ds_list_destroy(map[? "list"]);
	    ds_grid_destroy(map[? "grid"]);
	    ds_map_destroy(map[? "map"]);
	    ds_map_destroy(_retMap); // Cleanup the map returned by the function
	    ds_map_destroy(map);
	});
	
	addFact("Struct Dot Accessor with multiple accessors (Read/Write)", function() {
		// Initialize the struct with various data structures and values
		var struct = {
		    array: [10, 20, 30],                      // Array for Struct, Array access
		    list: ds_list_create(),                   // List for Struct, List access
		    grid: ds_grid_create(5, 5),               // Grid for Struct, Grid access
		    map: ds_map_create(),                     // Map for Struct, Map access
		    structDot: {name: "dotValue"},            // Struct for Struct, Struct Dot access
		    structBracket: {bracketName: "bracketValue"}, // Struct for Struct, Struct Bracket access
		    structHash: {hashName: "hashValue"},      // Struct for Struct, Struct Hash access
		    functionCall: function() {                // Function Call for Struct, Function Call access
		        return {key: "funcValue"};
		    }
		};

		// Populate List
		ds_list_add(struct.list, 1, 2, 3);

		// Populate Grid
		ds_grid_set(struct.grid, 2, 2, 50);

		// Populate Map
		ds_map_add(struct.map, "mapName", 300);

		// ** Write Operations **

		// Struct Hash, Array Access - Modify value
		struct.array[1] = 999;
		assert_equals(struct.array[1], 999, "Struct, Array write failed.");

		// Struct Hash, List Access - Modify value
		struct.list[| 1] = 888;
		assert_equals(struct.list[| 1], 888, "Struct, List write failed.");

		// Struct Hash, Grid Access - Modify value
		struct.grid[# 2, 2] = 777;
		assert_equals(struct.grid[# 2, 2], 777, "Struct, Grid write failed.");

		// Struct Hash, Map Access - Modify value
		struct.map[? "mapName"] = 666;
		assert_equals(struct.map[? "mapName"], 666, "Struct, Map write failed.");

		// Struct Hash, Struct Dot Access - Modify value
		struct.structDot.name = "newDotValue";
		assert_equals(struct.structDot.name, "newDotValue", "Struct, Struct Dot write failed.");

		// Struct Hash, Struct Bracket Access :Const: - Modify value
		struct.structBracket[$ "bracketName"] = "newBracketValue";
		assert_equals(struct.structBracket[$ "bracketName"], "newBracketValue", "Struct, Struct Bracket :Const: write failed.");

		// Struct Hash, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
		struct.structBracket[$ _key] = "newBracketValue";
		assert_equals(struct.structBracket[$ _key], "newBracketValue", "Struct, Struct Bracket :Dynamic: write failed.");

		// Struct Hash, Struct Hash Access - Modify value
		struct_set_from_hash(struct.structHash, variable_get_hash("hashName"), "newHashValue");
		assert_equals(struct_get_from_hash(struct.structHash, variable_get_hash("hashName")), "newHashValue", "Struct, Struct Hash write failed.");

		// ** Read Operations **

		// Struct Hash, Array Access
		assert_equals(struct.array[1], 999, "Struct, Array access failed.");

		// Struct Hash, List Access
		assert_equals(struct.list[| 1], 888, "Struct, List access failed.");

		// Struct Hash, Grid Access
		assert_equals(struct.grid[# 2, 2], 777, "Struct, Grid access failed.");

		// Struct Hash, Map Access
		assert_equals(struct.map[? "mapName"], 666, "Struct, Map access failed.");

		// Struct Hash, Struct Dot Access
		assert_equals(struct.structDot.name, "newDotValue", "Struct, Struct Dot access failed.");

		// Struct Hash, Struct Bracket Access :Const:
		assert_equals(struct.structBracket[$ "bracketName"], "newBracketValue", "Struct, Struct Bracket access failed.");

		// Struct Hash, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
		assert_equals(struct.structBracket[$ _key], "newBracketValue", "Struct, Struct Bracket access failed.");

		// Struct Hash, Struct Hash Access
		assert_equals(struct_get_from_hash(struct.structHash, variable_get_hash("hashName")), "newHashValue", "Struct, Struct Hash access failed.");

		// Struct Hash, Function Call Access (no write)
		assert_equals(struct.functionCall().key, "funcValue", "Struct, Function Call access failed.");
		
		// No need for a Work around for the lines above, but we keep it for testing sake incase results are different
		var _retStruct = struct.functionCall();
		assert_equals(_retStruct.key, "funcValue", "Struct, Function Call access failed.");

		// Cleanup
		ds_list_destroy(struct.list);
		ds_grid_destroy(struct.grid);
		ds_map_destroy(struct.map);
	});
	
	addFact("Struct Bracket Accessor :Const: with multiple accessors (Read/Write)", function() {
		// Initialize the struct with various data structures and values
		var struct = {
		    array: [10, 20, 30],                      // Array for Struct, Array access
		    list: ds_list_create(),                   // List for Struct, List access
		    grid: ds_grid_create(5, 5),               // Grid for Struct, Grid access
		    map: ds_map_create(),                     // Map for Struct, Map access
		    structDot: {name: "dotValue"},            // Struct for Struct, Struct Dot access
		    structBracket: {bracketName: "bracketValue"}, // Struct for Struct, Struct Bracket access
		    structHash: {hashName: "hashValue"},      // Struct for Struct, Struct Hash access
		    functionCall: function() {                // Function Call for Struct, Function Call access
		        return {key: "funcValue"};
		    }
		};

		// Populate List
		ds_list_add(struct[$ "list"], 1, 2, 3);

		// Populate Grid
		ds_grid_set(struct[$ "grid"], 2, 2, 50);

		// Populate Map
		ds_map_add(struct[$ "map"], "mapName", 300);

		// ** Write Operations **

		// Struct Hash, Array Access - Modify value
		struct[$ "array"][1] = 999;
		assert_equals(struct[$ "array"][1], 999, "Struct Bracket :Const:, Array write failed.");

		// Struct Hash, List Access - Modify value
		struct[$ "list"][| 1] = 888;
		assert_equals(struct[$ "list"][| 1], 888,  "Struct Bracket :Const:, List write failed.");

		// Struct Hash, Grid Access - Modify value
		struct[$ "grid"][# 2, 2] = 777;
		assert_equals(struct[$ "grid"][# 2, 2], 777,  "Struct Bracket :Const:, Grid write failed.");

		// Struct Hash, Map Access - Modify value
		struct[$ "map"][? "mapName"] = 666;
		assert_equals(struct[$ "map"][? "mapName"], 666,  "Struct Bracket :Const:, Map write failed.");

		// Struct Hash, Struct Dot Access - Modify value
		struct[$ "structDot"].name = "newDotValue";
		assert_equals(struct[$ "structDot"].name, "newDotValue",  "Struct Bracket :Const:, Struct Dot write failed.");

		// Struct Hash, Struct Bracket Access :Const: - Modify value
		struct[$ "structBracket"][$ "bracketName"] = "newBracketValue";
		assert_equals(struct[$ "structBracket"][$ "bracketName"], "newBracketValue",  "Struct Bracket :Const:, Struct Bracket :Const: write failed.");

		// Struct Hash, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
		struct[$ "structBracket"][$ _key] = "newBracketValue";
		assert_equals(struct[$ "structBracket"][$ _key], "newBracketValue",  "Struct Bracket :Const:, Struct Bracket :Dynamic: write failed.");

		// Struct Hash, Struct Hash Access - Modify value
		struct_set_from_hash(struct[$ "structHash"], variable_get_hash("hashName"), "newHashValue");
		assert_equals(struct_get_from_hash(struct[$ "structHash"], variable_get_hash("hashName")), "newHashValue",  "Struct Bracket :Const:, Struct Hash write failed.");

		// ** Read Operations **

		// Struct Hash, Array Access
		assert_equals(struct[$ "array"][1], 999,  "Struct Bracket :Const:, Array access failed.");

		// Struct Hash, List Access
		assert_equals(struct[$ "list"][| 1], 888,  "Struct Bracket :Const:, List access failed.");

		// Struct Hash, Grid Access
		assert_equals(struct[$ "grid"][# 2, 2], 777,  "Struct Bracket :Const:, Grid access failed.");

		// Struct Hash, Map Access
		assert_equals(struct[$ "map"][? "mapName"], 666,  "Struct Bracket :Const:, Map access failed.");

		// Struct Hash, Struct Dot Access
		assert_equals(struct[$ "structDot"].name, "newDotValue",  "Struct Bracket :Const:, Struct Dot access failed.");

		// Struct Hash, Struct Bracket Access :Const:
		assert_equals(struct[$ "structBracket"][$ "bracketName"], "newBracketValue",  "Struct Bracket :Const:, Struct Bracket access failed.");

		// Struct Hash, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
		assert_equals(struct[$ "structBracket"][$ _key], "newBracketValue",  "Struct Bracket :Const:, Struct Bracket access failed.");

		// Struct Hash, Struct Hash Access
		assert_equals(struct_get_from_hash(struct[$ "structHash"], variable_get_hash("hashName")), "newHashValue",  "Struct Bracket :Const:, Struct Hash access failed.");

		// Struct Hash, Function Call Access (no write)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(struct[$ "functionCall"]()[$ "key"], "funcValue",  "Struct Bracket :Const:, Function Call access failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
		var _retStruct = struct[$ "functionCall"]();
		assert_equals(_retStruct[$ "key"], "funcValue",  "Struct Bracket :Const:, Function Call access failed.");

		// Cleanup
		ds_list_destroy(struct[$ "list"]);
		ds_grid_destroy(struct[$ "grid"]);
		ds_map_destroy(struct[$ "map"]);
	});
	
	addFact("Struct Bracket Accessor :Dynamic: string variables (Read/Write)", function() {
		// Initialize the struct with various data structures and values
		var struct = {
		    array: [10, 20, 30],                      // Array for Struct, Array access
		    list: ds_list_create(),                   // List for Struct, List access
		    grid: ds_grid_create(5, 5),               // Grid for Struct, Grid access
		    map: ds_map_create(),                     // Map for Struct, Map access
		    structDot: {name: "dotValue"},            // Struct for Struct, Struct Dot access
		    structBracket: {bracketName: "bracketValue"}, // Struct for Struct, Struct Bracket access
		    structHash: {hashName: "hashValue"},      // Struct for Struct, Struct Hash access
		    functionCall: function() {                // Function Call for Struct, Function Call access
		        return {key: "funcValue"};
		    }
		};

		// Populate List
		var _key = "list";
		ds_list_add(struct[$ _key], 1, 2, 3);

		// Populate Grid
		_key = "grid";
		ds_grid_set(struct[$ _key], 2, 2, 50);

		// Populate Map
		_key = "map";
		ds_map_add(struct[$ _key], "mapName", 300);

		// ** Write Operations **

		// Struct Hash, Array Access - Modify value
		_key = "array";
		struct[$ _key][1] = 999;
		assert_equals(struct[$ _key][1], 999, "Struct Bracket with variable, Array write failed.");

		// Struct Hash, List Access - Modify value
		_key = "list";
		struct[$ _key][| 1] = 888;
		assert_equals(struct[$ _key][| 1], 888, "Struct Bracket with variable, List write failed.");

		// Struct Hash, Grid Access - Modify value
		_key = "grid";
		struct[$ _key][# 2, 2] = 777;
		assert_equals(struct[$ _key][# 2, 2], 777, "Struct Bracket with variable, Grid write failed.");

		// Struct Hash, Map Access - Modify value
		_key = "map";
		struct[$ _key][? "mapName"] = 666;
		assert_equals(struct[$ _key][? "mapName"], 666, "Struct Bracket with variable, Map write failed.");

		// Struct Hash, Struct Dot Access - Modify value
		_key = "structDot";
		struct[$ _key].name = "newDotValue";
		assert_equals(struct[$ _key].name, "newDotValue", "Struct Bracket with variable, Struct Dot write failed.");

		// Struct Hash, Struct Bracket Access :Const: - Modify value
		_key = "structBracket";
		struct[$ _key][$ "bracketName"] = "newBracketValue";
		assert_equals(struct[$ _key][$ "bracketName"], "newBracketValue", "Struct Bracket with variable, Struct Bracket :Const: write failed.");

		// Struct Hash, Struct Bracket Access :Dynamic: - Modify value
		_key = "structBracket";
		var _key2 = "bracketName"
		struct[$ _key][$ _key2] = "newBracketValue";
		assert_equals(struct[$ _key][$ _key2], "newBracketValue", "Struct Bracket with variable, Struct Bracket :Dynamic: write failed.");

		// Struct Hash, Struct Hash Access - Modify value
		_key = "structHash";
		struct_set_from_hash(struct[$ _key], variable_get_hash("hashName"), "newHashValue");
		assert_equals(struct_get_from_hash(struct[$ _key], variable_get_hash("hashName")), "newHashValue", "Struct Bracket with variable, Struct Hash write failed.");

		// ** Read Operations **

		// Struct Hash, Array Access
		_key = "array";
		assert_equals(struct[$ _key][1], 999, "Struct Bracket with variable, Array access failed.");

		// Struct Hash, List Access
		_key = "list";
		assert_equals(struct[$ _key][| 1], 888, "Struct Bracket with variable, List access failed.");

		// Struct Hash, Grid Access
		_key = "grid";
		assert_equals(struct[$ _key][# 2, 2], 777, "Struct Bracket with variable, Grid access failed.");

		// Struct Hash, Map Access
		_key = "map";
		assert_equals(struct[$ _key][? "mapName"], 666, "Struct Bracket with variable, Map access failed.");

		// Struct Hash, Struct Dot Access
		_key = "structDot";
		assert_equals(struct[$ _key].name, "newDotValue", "Struct Bracket with variable, Struct Dot access failed.");

		// Struct Hash, Struct Bracket Access :Const:
		_key = "structBracket";
		assert_equals(struct[$ _key][$ "bracketName"], "newBracketValue", "Struct Bracket with variable, Struct Bracket access failed.");

		// Struct Hash, Struct Bracket Access :Dynamic:
		_key = "structBracket";
		var _key2 = "bracketName"
		assert_equals(struct[$ _key][$ _key2], "newBracketValue", "Struct Bracket with variable, Struct Bracket access failed.");

		// Struct Hash, Struct Hash Access
		_key = "structHash";
		assert_equals(struct_get_from_hash(struct[$ _key], variable_get_hash("hashName")), "newHashValue", "Struct Bracket with variable, Struct Hash access failed.");

		// Struct Hash, Function Call Access (no write)
		_key = "functionCall";
		var _key2 = "key";
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(struct[$ _key]()[$ _key2], "funcValue", "Struct Bracket with variable, Function Call access failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		// Work around for the lines above until a bug is fixed ::  https://github.com/YoYoGames/GameMaker-Bugs/issues/8041
		var _retStruct = struct[$ _key]();
		assert_equals(_retStruct[$ _key2], "funcValue", "Struct Bracket with variable, Function Call access failed.");

		// Cleanup
		ds_list_destroy(struct[$ "list"]);
		ds_grid_destroy(struct[$ "grid"]);
		ds_map_destroy(struct[$ "map"]);
	});
	
	addFact("Struct Hash Accessor (Read/Write)", function() {
	    // Initialize the struct with various data structures and values
	    var struct = {
	        array: [10, 20, 30],                      // Array for Struct, Array access
	        list: ds_list_create(),                   // List for Struct, List access
	        grid: ds_grid_create(5, 5),               // Grid for Struct, Grid access
	        map: ds_map_create(),                     // Map for Struct, Map access
	        structDot: {name: "dotValue"},            // Struct for Struct, Struct Dot access
	        structBracket: {bracketName: "bracketValue"}, // Struct for Struct, Struct Bracket access
	        structHash: {hashName: "hashValue"},      // Struct for Struct, Struct Hash access
	        functionCall: function() {                // Function Call for Struct, Function Call access
	            return {key: "funcValue"};
	        }
	    };

	    // Populate List
	    var _listHash = variable_get_hash("list");
	    ds_list_add(struct_get_from_hash(struct, _listHash), 1, 2, 3);

	    // Populate Grid
	    var _gridHash = variable_get_hash("grid");
	    ds_grid_set(struct_get_from_hash(struct, _gridHash), 2, 2, 50);

	    // Populate Map
	    var _mapHash = variable_get_hash("map");
	    ds_map_add(struct_get_from_hash(struct, _mapHash), "mapName", 300);

	    // ** Write Operations **

	    // Struct Hash, Array Access - Modify value
	    var _arrayHash = variable_get_hash("array");
	    var _array = struct_get_from_hash(struct, _arrayHash);
	    _array[1] = 999;
	    assert_equals(_array[1], 999, "Struct Hash, Array write failed.");

	    // Struct Hash, List Access - Modify value
	    var _list = struct_get_from_hash(struct, _listHash);
	    _list[| 1] = 888;
	    assert_equals(_list[| 1], 888, "Struct Hash, List write failed.");

	    // Struct Hash, Grid Access - Modify value
	    var _grid = struct_get_from_hash(struct, _gridHash);
	    _grid[# 2, 2] = 777;
	    assert_equals(_grid[# 2, 2], 777, "Struct Hash, Grid write failed.");

	    // Struct Hash, Map Access - Modify value
	    var _map = struct_get_from_hash(struct, _mapHash);
	    _map[? "mapName"] = 666;
	    assert_equals(_map[? "mapName"], 666, "Struct Hash, Map write failed.");

	    // Struct Hash, Struct Dot Access - Modify value
	    var _dotHash = variable_get_hash("structDot");
	    struct_get_from_hash(struct, _dotHash).name = "newDotValue";
	    assert_equals(struct_get_from_hash(struct, _dotHash).name, "newDotValue", "Struct Hash, Struct Dot write failed.");

	    // Struct Hash, Struct Bracket Access :Const: - Modify value
	    var _bracketHash = variable_get_hash("structBracket");
		struct_get_from_hash(struct, _bracketHash)[$ "bracketName"] = "newBracketValue"
	    assert_equals(struct_get_from_hash(struct, _bracketHash)[$ "bracketName"], "newBracketValue", "Struct Hash, Struct Bracket :Const: write failed.");

	    // Struct Hash, Struct Bracket Access :Dynamic: - Modify value
	    var _bracketHash = variable_get_hash("structBracket");
		var _key = "bracketName"
		struct_get_from_hash(struct, _bracketHash)[$ _key] = "newBracketValue"
	    assert_equals(struct_get_from_hash(struct, _bracketHash)[$ _key], "newBracketValue", "Struct Hash, Struct Bracket :Dynamic: write failed.");

	    // Struct Hash, Struct Hash Access - Modify value
	    var _hashStructHash = variable_get_hash("structHash");
	    struct_set_from_hash(struct_get_from_hash(struct, _hashStructHash), variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(struct_get_from_hash(struct, _hashStructHash), variable_get_hash("hashName")), "newHashValue", "Struct Hash, Struct Hash write failed.");

	    // ** Read Operations **

	    // Struct Hash, Array Access
	    _array = struct_get_from_hash(struct, _arrayHash);
	    assert_equals(_array[1], 999, "Struct Hash, Array access failed.");

	    // Struct Hash, List Access
	    _list = struct_get_from_hash(struct, _listHash);
	    assert_equals(_list[| 1], 888, "Struct Hash, List access failed.");

	    // Struct Hash, Grid Access
	    _grid = struct_get_from_hash(struct, _gridHash);
	    assert_equals(_grid[# 2, 2], 777, "Struct Hash, Grid access failed.");

	    // Struct Hash, Map Access
	    _map = struct_get_from_hash(struct, _mapHash);
	    assert_equals(_map[? "mapName"], 666, "Struct Hash, Map access failed.");

	    // Struct Hash, Struct Dot Access
	    _dotHash = variable_get_hash("structDot");
	    assert_equals(struct_get_from_hash(struct, _dotHash).name, "newDotValue", "Struct Hash, Struct Dot access failed.");

	    // Struct Hash, Struct Bracket Access :Const:
	    _bracketHash = variable_get_hash("structBracket");
	    assert_equals(struct_get_from_hash(struct, _bracketHash)[$ "bracketName"], "newBracketValue", "Struct Hash, Struct Bracket access failed.");

	    // Struct Hash, Struct Bracket Access :Dynamic:
	    _bracketHash = variable_get_hash("structBracket");
		var _key = "bracketName"
	    assert_equals(struct_get_from_hash(struct, _bracketHash)[$ _key], "newBracketValue", "Struct Hash, Struct Bracket access failed.");

	    // Struct Hash, Struct Hash Access
	    _hashStructHash = variable_get_hash("structHash");
	    assert_equals(struct_get_from_hash(struct_get_from_hash(struct, _hashStructHash), variable_get_hash("hashName")), "newHashValue", "Struct Hash, Struct Hash access failed.");

	    // Struct Hash, Function Call Access (no write)
	    var _funcHash = variable_get_hash("functionCall");
	    var _keyHash = variable_get_hash("key");
		assert_equals(struct_get_from_hash(struct_get_from_hash(struct, _funcHash)(), _keyHash), "funcValue", "Struct Hash, Function Call access failed.");
		
	    var _retStruct = struct_get_from_hash(struct, _funcHash)();
	    assert_equals(struct_get_from_hash(_retStruct, _keyHash), "funcValue", "Struct Hash, Function Call access failed.");

	    // Cleanup
	    ds_list_destroy(struct_get_from_hash(struct, _listHash));
	    ds_grid_destroy(struct_get_from_hash(struct, _gridHash));
	    ds_map_destroy(struct_get_from_hash(struct, _mapHash));
	});
	
	addFact("Function Call with multiple accessors (Read/Write)", function() {
	    // Define functions that return various data structures
	    funcArray = function() {
			static r = [10, 20, 30]
	        return r;
	    }
	    funcList = function() {
			static r = ds_list_create();
	        return r;
	    }
	    funcGrid = function() {
			static r = ds_grid_create(5, 5)
	        return r;
	    }
	    funcMap = function() {
			static r = ds_map_create()
	        return r;
	    }
	    funcStructDot = function() {
			static r = {name: "dotValue"}
	        return r;
	    }
	    funcStructBracket = function() {
			static r = {bracketName: "bracketValue"}
	        return r;
	    }
	    funcStructHash = function() {
			static r = {hashName: "hashValue"}
	        return r;
	    }
	    funcFunctionCall = function() {
			static r = function() {
				static r = {key: "funcValue"}
	            return r;
	        };
	        return r
	    }

	    // ** Write Operations **

	    // Function Call, Array Access - Modify value
	    funcArray()[1] = 999;
	    assert_equals(funcArray()[1], 999, "Function Call, Array write failed.");

	    // Function Call, List Access - Modify value
	    funcList()[| 1] = 888;
	    assert_equals(funcList()[| 1], 888, "Function Call, List write failed.");

	    // Function Call, Grid Access - Modify value
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	    funcGrid()[# 2, 2] = 777;
//	    assert_equals(funcGrid()[# 2, 2], 777, "Function Call, Grid write failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//work around for a bug :: https://github.com/YoYoGames/GameMaker-Bugs/issues/7799
		var _retGrid = funcGrid()
	    _retGrid[# 2, 2] = 777;
	    assert_equals(_retGrid[# 2, 2], 777, "Function Call, Grid write failed.");
		
	    // Function Call, Map Access - Modify value
	    funcMap()[? "mapName"] = 666;
	    assert_equals(funcMap()[? "mapName"], 666, "Function Call, Map write failed.");

	    // Function Call, Struct Dot Access - Modify value
	    funcStructDot().name = "newDotValue";
	    assert_equals(funcStructDot().name, "newDotValue", "Function Call, Struct Dot write failed.");

	    // Function Call, Struct Bracket Access :Const: - Modify value
	    funcStructBracket()[$ "bracketName"] = "newBracketValue";
	    assert_equals(funcStructBracket()[$ "bracketName"], "newBracketValue", "Function Call, Struct Bracket :Const: write failed.");

	    // Function Call, Struct Bracket Access :Dynamic: - Modify value
		var _key = "bracketName"
	    funcStructBracket()[$ _key] = "newBracketValue";
	    assert_equals(funcStructBracket()[$ _key], "newBracketValue", "Function Call, Struct Bracket :Dynamic: write failed.");

	    // Function Call, Struct Hash Access - Modify value
	    struct_set_from_hash(funcStructHash(), variable_get_hash("hashName"), "newHashValue");
	    assert_equals(struct_get_from_hash(funcStructHash(), variable_get_hash("hashName")), "newHashValue", "Function Call, Struct Hash write failed.");

	    // ** Read Operations **

	    // Function Call, Array Access
	    assert_equals(funcArray()[1], 999, "Function Call, Array access failed.");

	    // Function Call, List Access
	    assert_equals(funcList()[| 1], 888, "Function Call, List access failed.");

	    // Function Call, Grid Access
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		assert_equals(funcGrid()[# 2, 2], 777, "Function Call, Grid access failed.");
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
	    //work around for a bug :: https://github.com/YoYoGames/GameMaker-Bugs/issues/7799
		var _retGrid = funcGrid()
	    assert_equals(_retGrid[# 2, 2], 777, "Function Call, Grid access failed.");

	    // Function Call, Map Access
	    assert_equals(funcMap()[? "mapName"], 666, "Function Call, Map access failed.");

	    // Function Call, Struct Dot Access
	    assert_equals(funcStructDot().name, "newDotValue", "Function Call, Struct Dot access failed.");

	    // Function Call, Struct Bracket Access :Const:
	    assert_equals(funcStructBracket()[$ "bracketName"], "newBracketValue", "Function Call, Struct Bracket access failed.");

	    // Function Call, Struct Bracket Access :Dynamic:
		var _key = "bracketName"
	    assert_equals(funcStructBracket()[$ _key], "newBracketValue", "Function Call, Struct Bracket access failed.");

	    // Function Call, Struct Hash Access
	    assert_equals(struct_get_from_hash(funcStructHash(), variable_get_hash("hashName")), "newHashValue", "Function Call, Struct Hash access failed.");

	    // Function Call, Function Call Access (no write)
	    var _retStruct = funcFunctionCall()();
	    assert_equals(_retStruct.key, "funcValue", "Function Call, Function Call access failed.");

	    // Cleanup
	    ds_list_destroy(funcList());
	    ds_grid_destroy(funcGrid());
	    ds_map_destroy(funcMap());
	});


}