function BasicDataStructuresMapTestSuite() : TestSuite() constructor {

	addFact("ds_map_create_test #1", function() {
	
		var _map = ds_map_create();
		
		var _output = ds_exists(_map, ds_type_map);
		assert_true(_output, "ds_list_create(), failed to create map");
			
		// Clean up
		ds_map_destroy(_map);
	})

	// MAP ADD TESTS
	
	addFact("ds_map_add_find_test #1", function() {

		var _map, _output;
		
		_map = ds_map_create();
		ds_map_add(_map, "One", 1);
		ds_map_add(_map, "Two", 2);
		ds_map_add(_map, "Three", 3);
		ds_map_add(_map, "Four", 4);
		ds_map_add(_map, "Five", 5);
		
		assert_map_size(_map, 5, "ds_map_add(), failed to added correct amount of elements");
			
		// Clean up
		ds_map_destroy(_map);

	});
	
	addFact("ds_map_add_find_test #2", function() {

		var _map, _output;
		
		_map = ds_map_create();
		
		ds_map_add_list(_map, "List", ds_list_create());
		
		_output = ds_exists(_map[? "List"], ds_type_list);
		assert_true(_output, "ds_map_add_list(), list failed to be created/added");
		_output = ds_map_is_list(_map, "List");
		assert_true(_output, "ds_map_is_list(), failed to be mark element as list");
			
		// Clean up
		ds_map_destroy(_map);

	});
	
	addFact("ds_map_add_find_test #3", function() {

		var _map, _output;
		
		_map = ds_map_create();
		
		ds_map_add_map(_map, "Map", ds_map_create());
		
		_output = ds_exists(_map[? "Map"], ds_type_map);
		assert_true(_output, "ds_map_add_map(), map failed to be created/added");
		_output = ds_map_is_map(_map, "Map");
		assert_true(_output, "ds_map_is_map(), failed to be mark element as map");
			
		// Clean up
		ds_map_destroy(_map);

	});
	
	// MAP FIND 
	
	addFact("ds_map_add_find_test #1", function() {

		var _map, _output;
		
		_map = ds_map_create();
		ds_map_add(_map, "One", 1);
		ds_map_add(_map, "Two", 2);
		ds_map_add(_map, "Three", 3);
		ds_map_add(_map, "Four", 4);
		ds_map_add(_map, "Five", 5);
			
		// RK :: We cannot guarantee the order within the map (but we can say that we should be able to iterate over the whole list from start to finish, or from last to first)
		var _key, _count;
		var _firstKey = ds_map_find_first(_map);
		
		_key = _firstKey;
		_count = 0;
		while (_key != undefined) {
			++_count;
			_key = ds_map_find_next(_map, _key);		
		} // end while
		
		assert_equals( _count, 5, "ds_map_find_next(), failed to iterated over all map entries");
			
		// Clean up
		ds_map_destroy(_map);

	});
	
	addFact("ds_map_add_find_test #2", function() {

		var _map, _output;
		
		_map = ds_map_create();
		ds_map_add(_map, "One", 1);
		ds_map_add(_map, "Two", 2);
		ds_map_add(_map, "Three", 3);
		ds_map_add(_map, "Four", 4);
		ds_map_add(_map, "Five", 5);
			
		// RK :: We cannot guarantee the order within the map (but we can say that we should be able to iterate over the whole list from start to finish, or from last to first)
		var _key, _count;
		var _lastKey = ds_map_find_last(_map);
		
		_key = _lastKey;
		_count = 0;
		while (_key != undefined) {
			++_count;
			_key = ds_map_find_previous(_map, _key );
		} // end while
		assert_equals( _count, 5, "ds_map_find_previous(), failed to iterated over all map entries");
			
		// Clean up
		ds_map_destroy(_map);

	});
	
	// MAP DELETE TESTS
	
	addFact("ds_map_delete test #1", function() {
		
		var _map, _output;
		
		_map = ds_map_create();
		ds_map_add(_map, "One", 1);
		
		ds_map_delete(_map, "One");
		
		assert_map_empty(_map, "ds_map_delete(), failed to delete key and value");
		
	});
	
	// MAP COPY TESTS
	
	addFact("ds_map_read_write_test #1", function() {
			
		var _map, _output;
		
		_map = ds_map_create();
			
		ds_map_add_map(_map, "Map", ds_map_create());
		
		var _copiedMap = ds_map_create();
		ds_map_copy(_copiedMap, _map);
		assert_map_equals(_map, _copiedMap, "ds_map_copy(), failed to correctly copy map");
			
		// Clean up
		ds_map_destroy(_map);
		ds_map_destroy(_copiedMap);
			
	});
	
	// MAP EMPTY TESTS
	
	addFact("ds_map_read_write_test #1", function() {

		var _map, _output;
		
		_map = ds_map_create();
		
		_output = ds_map_empty(_map)
		assert_true(_output, "ds_map_clear(), failed to clear map contents");
			
		// Clean up
		ds_map_destroy(_map);
			
	});
	
	addFact("ds_map_read_write_test #2", function() {
			
		var _map, _output;
		
		_map = ds_map_create();
			
		ds_map_add_map(_map, "Map", ds_map_create());
		
		_output = ds_map_empty(_map)
		assert_false(_output, "ds_map_empty(), detected empty map when it shouldn't");
			
		// Clean up
		ds_map_destroy(_map);
			
	});
	
	// MAP READ TESTS

	addFact("ds_map_read_write_test #1", function() {
			
		var _map, _output;
		
		_map = ds_map_create();
			
		ds_map_add_map(_map, "Map", ds_map_create());
		
		var _copiedMap = ds_map_create();
		ds_map_copy(_copiedMap, _map);
		
		var _writtenMap = ds_map_write(_map);
		ds_map_clear(_map);
		
		ds_map_read(_map, _writtenMap);
		assert_map_equals(_map, _copiedMap, "ds_map_read(), failed to correctly read map from encoded string");
			
		// Clean up
		ds_map_destroy(_map);
		ds_map_destroy(_copiedMap);
			
	});

	// MAP REPLACE TESTS
	
	addFact("ds_map_replace_test #1", function() {

		//SB: ds_map_replace_list/map and ds_map_size
			
		var _output;
			
		var _map = ds_map_create();
		var _listToAdd = ds_list_create();
		var _listToReplace = ds_list_create();
		
		ds_map_add_list(_map, "List", _listToAdd);
		ds_map_replace_list(_map, "List", _listToReplace);
		assert_equals(_map[? "List"], _listToReplace, "DS Map Replace List");
		
		assert_map_size(_map, 1, "ds_map_add/replace_map(), failed to add and replace a map");
			
		// Clean up
		ds_list_destroy(_listToAdd);
		ds_list_destroy(_listToReplace);
		ds_map_destroy(_map);
	});

	addFact("ds_map_replace_test #2", function() {

		//SB: ds_map_replace_list/map and ds_map_size
			
		var _output;
			
		var _map = ds_map_create();
		
		var _mapToAdd = ds_map_create();
		var _mapToReplace = ds_map_create();
		
		ds_map_add_map(_map, "Map", _mapToAdd);
		ds_map_replace_map(_map, "Map", _mapToReplace);
		assert_equals(_map[? "Map"], _mapToReplace, "DS Map Replace Map");
		
		assert_map_size(_map, 1, "ds_map_add/replace_map(), failed to add and replace a map");
			
		// Clean up
		ds_map_destroy(_mapToAdd);
		ds_map_destroy(_mapToReplace);
		ds_map_destroy(_map);
	});
	
	// MAP SAVING LOADING TESTS
	
	addFact("ds_map_secure_save_load_test #1", function() {

		var _map, _output;

		// ##### SAVE/LOAD SECURE #####

		_map = ds_map_create();
		ds_map_set(_map, "Three", 3);
		ds_map_secure_save(_map, "mapSecure.sav");
		ds_map_clear(_map);
			
		// Clean up
		ds_map_destroy(_map);
			
		_map = ds_map_secure_load("mapSecure.sav");
		
		_output = ds_map_empty(_map);
		assert_false(_output, "ds_map_secure_load(), loaded empty map (could be a ds_map_secure_save problem)");
		assert_map_size(_map, 1, "ds_map_secure_load(), loaded wrong number of elements (could be a ds_map_secure_save problem)");
		_output = ds_map_exists(_map, "Three")
		assert_true(_output, "ds_map_secure_load(), failed to load correct data (could be a ds_map_secure_save problem)");
		
	}, {
		test_filter: platform_not_browser
	});
	
	addFact("ds_map_secure_save_load_test #2", function() {

		var _map, _output;
		
		_map = ds_map_create();
		ds_map_set(_map, "Three", 3);
		
		// ##### SAVE/LOAD BUFFER #####
		
		var _mapSaveBuffer = buffer_create(1024, buffer_grow, 2);
		ds_map_secure_save_buffer(_map, _mapSaveBuffer);
		ds_map_clear(_map);

		// Clean up
		ds_map_destroy(_map);
			
		buffer_seek(_mapSaveBuffer, 0, buffer_seek_start);
		
		_map = ds_map_secure_load_buffer(_mapSaveBuffer);
		
		_output = ds_map_empty(_map);
		assert_false(_output, "ds_map_secure_load_buffer(), loaded empty map (could be a ds_map_secure_save_buffer problem)");
		assert_map_size(_map, 1, "ds_map_secure_load_buffer(), loaded wrong number of elements (could be a ds_map_secure_save_buffer problem)");
		_output = ds_map_exists(_map, "Three")
		assert_true(_output, "ds_map_secure_load_buffer(), failed to load correct data (could be a ds_map_secure_save_buffer problem)");
			
		// Clean up
		buffer_delete(_mapSaveBuffer);
		ds_map_destroy(_map);
	}, {
		test_filter: platform_not_browser
	});
	
	// MAP REFERENCE KEY TESTS
	
	addFact("ds_map_array_reference_keys_test", function() {
		// Making sure that DS map can properly handle array keys
		// I.e. different array references are treated as separate keys
		// even if arrays themselves are equivalent
		
		// Setup
		var _firstArray = [];
		var _secondArray = [];
		var _thirdArray = [];
		
		var _map = ds_map_create();
		_map[? _firstArray] = "first";
		_map[? _secondArray] = "second";
		_map[? _thirdArray] = "third";
		
		// Assertions
		var _output;
		_output = ds_map_size(_map);
		assert_equals(_output, 3, $"The map of arrays should have 3 keys but had {_output} instead.");
		
		_output = _map[? _firstArray];
		assert_equals(_output, "first", $"The result keyed by the first array should be 'first' but was '{_output}' instead.");
		_output = _map[? _secondArray];
		assert_equals(_output, "second", $"The result keyed by the second array should be 'second' but was '{_output}' instead.");
		_output = _map[? _thirdArray];
		assert_equals(_output, "third", $"The result keyed by the third array should be 'third' but was '{_output}' instead.");
		
		// Clean up
		ds_map_destroy(_map);
	})
	
	addFact("ds_map_struct_reference_keys_test", function() {
		// Making sure that DS map can properly handle struct keys
		// I.e. different struct references are treated as separate keys
		// even if structs themselves are equivalent
		
		// Setup
		var _firstStruct = {};
		var _secondStruct = {};
		var _thirdStruct = {};
		
		var _map = ds_map_create();
		_map[? _firstStruct] = "first";
		_map[? _secondStruct] = "second";
		_map[? _thirdStruct] = "third";
		
		// Assertions
		var _output;
		_output = ds_map_size(_map);
		assert_equals(_output, 3, $"The map of structs should have 3 keys but had {_output} instead.");
		
		_output = _map[? _firstStruct];
		assert_equals(_output, "first", $"The result keyed by the first struct should be 'first' but was '{_output}' instead.");
		_output = _map[? _secondStruct];
		assert_equals(_output, "second", $"The result keyed by the second struct should be 'second' but was '{_output}' instead.");
		_output = _map[? _thirdStruct];
		assert_equals(_output, "third", $"The result keyed by the third struct should be 'third' but was '{_output}' instead.");
		
		// Clean up
		ds_map_destroy(_map);
	})
}