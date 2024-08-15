
function BasicJsonTestSuite() : TestSuite() constructor {
	
	// JSON TO/FROM DS_MAP
	
	addFact("json_decode_test #1", function() {
			
		// ========== BASIC STRUCTURE ==========
			
		var _output, _input = "{\"hello\":\"world\"}";
			
		_output = json_decode(_input);
		assert_greater_or_equal(_output, 0, "json_decode( string:local ), failed to decode a valid simple json string");
			
		ds_map_destroy(_output);
		
	});
	
	addFact("json_decode_test #2", function() {
			
		// ========== BASIC STRUCTURE ==========
			
		var _output, _input = "{\"hello\":\"world\"}";
			
		_output = json_decode(_input);
		assert_map_size(_output, 1, "json_decode( string:local ), failed to decode the correct number of keys");
			
		ds_map_destroy(_output);
		
	});
	
	addFact("json_decode_test #3", function() {
			
		// ========== BASIC STRUCTURE ==========
			
		var _output, _input = "{\"hello\":\"world\"}";
			
		_output = json_decode(_input);
		assert_map_equals_array(_output, ["hello", "world"], "json_decode( string:local ), failed to decode the correct structure");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #4", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
		assert_greater_or_equal(_output, 0, "json_decode( string:local ), failed to decode a valid complex json string");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #5", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
		assert_map_size(_output, 2, "json_decode( string:local ), failed to decode the correct number of keys");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #6", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
	
		var _nestedMap = _output[? "myObj"];
			
		assert_greater_or_equal(_nestedMap, 0, "json_decode( string:local ), failed to decode a nested map");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #7", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
	
		var _nestedMap = _output[? "myObj"];

		assert_not_equals(_output, _nestedMap, "json_decode( string: local ), parent and nested map cannot have the same id");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #8", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
	
		var _nestedMap = _output[? "myObj"];
			
		assert_map_size(_nestedMap, 4, "json_decode( string:local ), failed to decode nested map incorrect number of keys");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #9", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
	
		var _nestedMap = _output[? "myObj"];
			
		assert_map_equals_array(_nestedMap, [ "apples",	10,
											"oranges",	12,
											"potatoes", 100000,
											"avocados",	0], "json_decode( string:local ), failed to decode the correct nested map structure");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #10", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
			
		var _nestedList = _output[? "myArray"];
			
		assert_greater_or_equal(_nestedList, 0, "json_decode( string:local ), failed to decode the correct nested list");
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #11", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
			
		var _nestedList = _output[? "myArray"];

		assert_list_size(_nestedList, 9, "json_decode( string:local ), failed to decode nested list incorrect number of elements");	
			
		ds_map_destroy(_output);
		
	});

	addFact("json_decode_test #12", function() {
			
		// ========== COMPLEX STRUCTURE ==========
		
		var _output, _input;
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
			
		_output = json_decode(_input);
			
		var _nestedList = _output[? "myArray"];			

		assert_list_equals_array(_nestedList, [0, 1, 2, 2, 4, 0, 1, 5, 1], "json_decode( string:local ), failed to decode the correct nested list structure");
			
		ds_map_destroy(_output);
		
	});
	
	// JSON ENCODE TESTS
	
	addFact("json_encode_test #1", function() {

		var _map, _output, _jsonStr;

		// ========== BASIC STRUCTURE ==========
			
		// Preparation
		_map = ds_map_create();
		_map[? "myString"] = "hello world";
			
		_jsonStr = json_encode(_map);
		_output = json_decode(_jsonStr);
		
		assert_map_equals(_map, _output, "json_encode ( ds_map:local ), simple json encoding failed (maps are not equal)");
			
		ds_map_destroy(_map);
		ds_map_destroy(_output);
		
	});

	addFact("json_encode_test #2", function() {

		var _map, _output, _jsonStr;
			
			
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
		
		assert_map_equals(_map, _output, "json_encode ( ds_map:local ), complex json encoding with nested map failed (maps are not equal)");

		ds_map_destroy(_map);
		ds_map_destroy(_output);
		
	});

	/*
	addFact("json_encode_test #", function() {

		var _map, _output, _jsonStr;
			
		// ========== COMPLEX STRUCTURE (nested list) ==========
		
		_map = ds_map_create();
		ds_map_add(_map, "version", "2");
			
		var subList = ds_list_create();
		ds_list_add(subList, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
			
		ds_map_add_list(_map, "myArray", subList);
			
		_jsonStr = json_encode(_map);
		_output = json_decode(_jsonStr);
			
		assert_map_equals(_map, _output, "#2 json_encode ( ds_map:local ), complex json encoding with nested list failed (maps are not equal)");
			
		ds_map_destroy(_map);
		ds_map_destroy(_output);
		
	});
	*/

	// JSON TO/FROM STRUCTS
	
	addFact("json_parse_test #1", function() {

		var _output, _input;
			
		// ========== BASIC STRUCTURE ==========
			
		_input = "{\"hello\":\"world\"}";
		_output = json_parse(_input);
			
		assert_struct_equals(_output, { hello: "world" }, "json_parse( string:local ), failed to parse a simple struct");
		
	});

	addFact("json_parse_test #2", function() {

		var _output, _input;
			
		// ========== COMPLEX STRUCTURE ==========
			
		_input = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
		_output = json_parse(_input);
			
		assert_struct_equals(_output, {
			myObj: { apples: 10, oranges: 12, potatoes: 100000, avocados: 0 }, 
			myArray: [0, 1, 2, 2, 4, 0, 1, 5, 1] }, "json_parse( string:local ), failed to parse a complex struct");
			
	});
	
	// JSON STRINGIFY TESTS
	
	addFact("json_stringify_test #1", function() {

		var _struct, _output, _jsonStr;

		// ========== BASIC STRUCTURE ==========
			
		// Preparation
		_struct = { myString: "hello world" };
			
		_jsonStr = json_stringify(_struct);
		_output = json_parse(_jsonStr);
		
		assert_struct_equals(_struct, _output, "json_stringify ( struct:local ), simple json failed (structs are not equal)");
		
	});

	addFact("json_stringify_test #2", function() {

		var _struct, _output, _jsonStr;
			
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
			
		assert_struct_equals(_struct, _output, "json_stringify ( struct:local ), complex json with nested struct failed (structs are not equal)");
		
	});

	addFact("json_stringify_test #3", function() {

		var _struct, _output, _jsonStr;
	
		// ========== COMPLEX STRUCTURE (nested array) ==========
			
		_struct = {
			version: 2,
			myArray: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		}

		_jsonStr = json_stringify(_struct);
		_output = json_parse(_jsonStr);
			
		assert_struct_equals(_struct, _output, "json_stringify ( struct:local ), complex json with nested array failed (structs are not equal)");
			
	});
	
}