

function BasicJsonTestSuite() : TestSuite() constructor {
	
	// JSON TO/FROM DS_MAP

	addFact("json_decode_test", function() {
			
		// ========== BASIC STRUCTURE ==========
			
		var _output, _input = "{\"hello\":\"world\"}";
			
		_output = json_decode(_input);
		assert_greater_or_equal(_output, 0, "#1 json_decode( string:local ), failed to decode a valid simple json string");
			
		assert_map_size(_output, 1, "#2 json_decode( string:local ), failed to decode the correct number of keys");
			
		assert_map_equals_array(_output, ["hello", "world"], "#3 json_decode( string:local ), failed to decode the correct structure");
			
		ds_map_destroy(_output);
			
		// ========== COMPLEX STRUCTURE ==========
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
		assert_greater_or_equal(_output, 0, "#4 json_decode( string:local ), failed to decode a valid complex json string");
			
		assert_map_size(_output, 2, "#5 json_decode( string:local ), failed to decode the correct number of keys");
			
		var _nestedMap = _output[? "myObj"];
			
		assert_greater_or_equal(_nestedMap, 0, "#5 json_decode( string:local ), failed to decode a nested map");
		assert_not_equals(_output, _nestedMap, "#6 json_decode( string: local ), parent and nested map cannot have the same id");
			
		assert_map_size(_nestedMap, 4, "#7 json_decode( string:local ), failed to decode nested map incorrect number of keys");
			
		assert_map_equals_array(_nestedMap, [ "apples",	10,
											"oranges",	12,
											"potatoes", 100000,
											"avocados",	0], "#8 json_decode( string:local ), failed to decode the correct nested map structure");
			
			
		var _nestedList = _output[? "myArray"];
			
		assert_greater_or_equal(_nestedList, 0, "#8 json_decode( string:local ), failed to decode the correct nested list");

		assert_list_size(_nestedList, 9, "#9 json_decode( string:local ), failed to decode nested list incorrect number of elements");			

		assert_list_equals_array(_nestedList, [0, 1, 2, 2, 4, 0, 1, 5, 1], "#9 json_decode( string:local ), failed to decode the correct nested list structure");
			
		ds_map_destroy(_output);
	})

	addFact("json_encode_test", function() {

		var _map, _output, _jsonStr;

		// ========== BASIC STRUCTURE ==========
			
		// Preparation
		_map = ds_map_create();
		_map[? "myString"] = "hello world";
			
		_jsonStr = json_encode(_map);
		_output = json_decode(_jsonStr);
		
		assert_map_equals(_map, _output, "#1 json_encode ( ds_map:local ), simple json encoding failed (maps are not equal)");
			
		ds_map_destroy(_map);
		ds_map_destroy(_output);
			
			
		// ========== COMPLEX STRUCTURE (nested map) ==========
			
		_map = ds_map_create();
		ds_map_add(_map, "version", "1");
			
		var _nestedMap = ds_map_create();
		ds_map_add(_nestedMap, "webSocket", 1);
		ds_map_add(_nestedMap, "ipv4Address", "1.1.1.1");
		ds_map_add(_nestedMap, "ipv6Address", "0000:0000:0000:0000:0000:0000:0000:0000");
		ds_map_add(_nestedMap, "header", "You are receiving a packet");
		ds_map_add(_nestedMap, "body", "A packet of cheese and onion crisps");
			
		ds_map_add_map(_map, "myObj", _nestedMap);
			
		_jsonStr = json_encode(_map);
		_output = json_decode(_jsonStr);
		
		assert_map_equals(_map, _output, "#2 json_encode ( ds_map:local ), complex json encoding with nested map failed (maps are not equal)");

		ds_map_destroy(_map);
		ds_map_destroy(_output);
			
			
		// ========== COMPLEX STRUCTURE (nested list) ==========
		
		//_map = ds_map_create();
		//ds_map_add(_map, "version", "2");
		//	
		//var subList = ds_list_create();
		//ds_list_add(subList, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
		//	
		//ds_map_add_list(_map, "myArray", subList);
		//	
		//_jsonStr = json_encode(_map);
		//_output = json_decode(_jsonStr);
		//	
		//assert_map_equals(_map, _output, "#2 json_encode ( ds_map:local ), complex json encoding with nested list failed (maps are not equal)");
		//	
		//ds_map_destroy(_map);
		//ds_map_destroy(_output);

	})

	// JSON TO/FROM STRUCTS

	addFact("json_parse_test", function() {

		var _output, _input;
			
		// ========== BASIC STRUCTURE ==========
			
		_input = "{\"hello\":\"world\"}";
		_output = json_parse(_input);
			
		assert_struct_equals(_output, { hello: "world" }, "#1 json_parse( string:local ), failed to parse a simple struct");
			
		// ========== COMPLEX STRUCTURE ==========
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
		_output = json_parse(_input);
			
		assert_struct_equals(_output, {
			myObj: { apples: 10, oranges: 12, potatoes: 100000, avocados: 0 }, 
			myArray: [0, 1, 2, 2, 4, 0, 1, 5, 1] }, "#2 json_parse( string:local ), failed to parse a complex struct");
			
	})

	addFact("json_stringify_test", function() {

		var _struct, _output, _jsonStr;

		// ========== BASIC STRUCTURE ==========
			
		// Preparation
		_struct = { myString: "hello world" };
			
		_jsonStr = json_stringify(_struct);
		_output = json_parse(_jsonStr);
		
		assert_struct_equals(_struct, _output, "#1 json_stringify ( struct:local ), simple json failed (structs are not equal)");
			
		// ========== COMPLEX STRUCTURE (nested struct) ==========
			
		_struct = {
			version: 1,
			myObj: {
				webSocket: 1,
				ipv4Address: "1.1.1.1",
				ipv6Address: "0000:0000:0000:0000:0000:0000:0000:0000",
				header: "You are receiving a packet",
				body: "A packet of cheese and onion crisps"
			}
		}
			
		_jsonStr = json_stringify(_struct);
		_output = json_parse(_jsonStr);
			
		assert_struct_equals(_struct, _output, "#2 json_stringify ( struct:local ), complex json with nested struct failed (structs are not equal)");
	
		// ========== COMPLEX STRUCTURE (nested array) ==========
			
		_struct = {
			version: 2,
			myArray: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		}

		_jsonStr = json_stringify(_struct);
		_output = json_parse(_jsonStr);
			
		assert_struct_equals(_struct, _output, "#2 json_stringify ( struct:local ), complex json with nested array failed (structs are not equal)");
			
	})
	
}