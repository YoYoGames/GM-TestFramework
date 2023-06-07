function BasicDataStructuresMapTestSuite() : TestSuite() constructor {

	addFact("ds_map_create_test", function() {
	
		var _map = ds_map_create();
		
		var _output = ds_exists(_map, ds_type_map);
		assert_true(_output, "#1 ds_list_create(), failed to create map");
			
		// Clean up
		ds_map_destroy(_map);
	})

	addFact("ds_map_add_find_test", function() {

		var _map, _output;
		
		_map = ds_map_create();
		ds_map_add(_map, "One", 1);
		ds_map_add(_map, "Two", 2);
		ds_map_add(_map, "Three", 3);
		ds_map_add(_map, "Four", 4);
		ds_map_add(_map, "Five", 5);
		
		assert_map_size(_map, 5, "#1 ds_map_add(), failed to added correct amount of elements");
		
		ds_map_add_list(_map, "List", ds_list_create());
		ds_map_add_map(_map, "Map", ds_map_create());
		
		_output = ds_exists(_map[? "List"], ds_type_list);
		assert_true(_output, "#2.1 ds_map_add_list(), list failed to be created/added");
		_output = ds_map_is_list(_map, "List");
		assert_true(_output, "#2.2 ds_map_is_list(), failed to be mark element as list");
		
		_output = ds_exists(_map[? "Map"], ds_type_map);
		assert_true(_output, "#3.1 ds_map_add_map(), map failed to be created/added");
		_output = ds_map_is_map(_map, "Map");
		assert_true(_output, "#3.2 ds_map_is_map(), failed to be mark element as map");
			
		// RK :: We cannot guarantee the order within the map (but we can say that we should be able to iterate over the whole list from start to finish, or from last to first)
		var _key, _count;
		var _firstKey = ds_map_find_first(_map);
		var _lastKey = ds_map_find_last(_map);
		
		_key = _firstKey;
		_count = 0;
		while (_key != undefined) {
			++_count;
			_key = ds_map_find_next(_map, _key);		
		} // end while
		
		assert_equals( _count, 7, "#4 ds_map_find_next(), failed to iterated over all map entries");
		
		_key = _lastKey;
		_count = 0;
		while (_key != undefined) {
			++_count;
			_key = ds_map_find_previous(_map, _key );
		} // end while
		assert_equals( _count, 7, "#5 ds_map_find_previous(), failed to iterated over all map entries");
		
			
		// RK :: Check the ds_map_keys_to_array function is working
		var _allKeys = ds_map_keys_to_array(_map);
		var _allValues = ds_map_values_to_array(_map);

		assert_array_length(_allKeys, 7, "#6 ds_map_keys_to_array(), failed to return the correct number of keys");
		assert_array_length(_allValues, 7, "#6 ds_map_values_to_array(), failed to return the correct number of values");

		_allKeys = ds_map_keys_to_array(_map, _allKeys);
		_allValues = ds_map_values_to_array(_map, _allValues);
		
		assert_array_length(_allKeys, 14, "#6 ds_map_keys_to_array(), failed to return the correct number of keys (re-use array)");
		assert_array_length(_allValues, 14, "#6 ds_map_values_to_array(), failed to return the correct number of values (re-use array)");
			
		// Clean up
		ds_map_destroy(_map);

	})

	addFact("ds_map_read_write_test", function() {

		//SB: ds_map_copy, ds_map_delete, ds_map_write, ds_map_clear, ds_map_empty and ds_map_read
		
		ds_map_destroy(0);
		ds_map_destroy(1);
			
		var _map, _output;
		
		_map = ds_map_create();
			
		ds_map_add_map(_map, "Map", ds_map_create());
		
		var _copiedMap = ds_map_create();
		ds_map_copy(_copiedMap, _map);
		assert_map_equals(_map, _copiedMap, "#1 ds_map_copy(), failed to correctly copy map");
		
		var _checkValue = "930100000100000001000000030000004D617000000000000000000000F03F";
		
		var _writtenMap = ds_map_write(_map);
		assert_equals(_writtenMap, _checkValue, "#2 ds_map_write(), doesn't match pre-baked encoded string");
		
		_output = ds_map_empty(_map)
		assert_false(_output, "#3 ds_map_empty(), detected empty map when it shouldn't");
		
		ds_map_clear(_map);
		_output = ds_map_empty(_map)
		assert_true(_output, "#3 ds_map_clear(), failed to clear map contents");
		
		ds_map_read(_map, _writtenMap);
		assert_map_equals(_map, _copiedMap, "#1 ds_map_read(), failed to correctly read map from encoded string");
			
		// Clean up
		ds_map_destroy(_map);
		ds_map_destroy(_copiedMap);
			
	})

	addFact("ds_map_replace_test", function() {

		//SB: ds_map_replace_list/map and ds_map_size
			
		var _output;
			
		var _map = ds_map_create();
		var _listToAdd = ds_list_create();
		var _listToReplace = ds_list_create();
		
		var _mapToAdd = ds_map_create();
		var _mapToReplace = ds_map_create();
		
		ds_map_add_list(_map, "List", _listToAdd);
		ds_map_replace_list(_map, "List", _listToReplace);
		assert_equals(_map[? "List"], _listToReplace, "DS Map Replace List");
		
		assert_map_size(_map, 1, "#1 ds_map_add/replace_map(), failed to add and replace a map");
		
		ds_map_add_map(_map, "Map", _mapToAdd);
		ds_map_replace_map(_map, "Map", _mapToReplace);
		assert_equals(_map[? "Map"], _mapToReplace, "DS Map Replace Map");
		
		assert_map_size(_map, 2, "#2 ds_map_add/replace_map(), failed to add and replace a map");
			
		// Clean up
		ds_list_destroy(_listToAdd);
		ds_list_destroy(_listToReplace);
		ds_map_destroy(_mapToAdd);
		ds_map_destroy(_mapToReplace);
		ds_map_destroy(_map);
	})

	addFact("ds_map_secure_save_load_test", function() {

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
		assert_false(_output, "#1 ds_map_secure_load(), loaded empty map (could be a ds_map_secure_save problem)");
		assert_map_size(_map, 1, "#1 ds_map_secure_load(), loaded wrong number of elements (could be a ds_map_secure_save problem)");
		_output = ds_map_exists(_map, "Three")
		assert_true(_output, "#1 ds_map_secure_load(), failed to load correct data (could be a ds_map_secure_save problem)");
		
		// ##### SAVE/LOAD BUFFER #####
		
		var _mapSaveBuffer = buffer_create(1024, buffer_grow, 2);
		ds_map_secure_save_buffer(_map, _mapSaveBuffer);
		ds_map_clear(_map);

		// Clean up
		ds_map_destroy(_map);
			
		buffer_seek(_mapSaveBuffer, 0, buffer_seek_start);
		
		_map = ds_map_secure_load_buffer(_mapSaveBuffer);
		
		_output = ds_map_empty(_map);
		assert_false(_output, "#1 ds_map_secure_load_buffer(), loaded empty map (could be a ds_map_secure_save_buffer problem)");
		assert_map_size(_map, 1, "#1 ds_map_secure_load_buffer(), loaded wrong number of elements (could be a ds_map_secure_save_buffer problem)");
		_output = ds_map_exists(_map, "Three")
		assert_true(_output, "#1 ds_map_secure_load_buffer(), failed to load correct data (could be a ds_map_secure_save_buffer problem)");
			
		// Clean up
		buffer_delete(_mapSaveBuffer);
		ds_map_destroy(_map);
	}, {
		test_filter: platform_not_browser
	})
	
}