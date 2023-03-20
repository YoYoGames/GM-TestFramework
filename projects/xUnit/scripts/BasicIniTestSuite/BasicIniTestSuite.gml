
function BasicIniTestSuite() : TestSuite() constructor {

	addFact("ini_file_test", function() {

		var _output, _directory = working_directory + "testDir";

		if (platform_not_browser()) {

			// Make sure test directory doesn't exist
			if (directory_exists(_directory)) directory_destroy(_directory);
			directory_create(_directory);
		}
		
		var _filename = "testFile.ini"	
		var _filePath = string("{0}\\{1}", _directory, _filename);

		// Open file
		ini_open(_filePath);

						
		// Section doesn't exist
		_output = ini_section_exists("TestSection");
		assert_false(_output, "#2 ini_section_exists ( section ) should not detect a nonexistent section");
			
			
		// Write test
		ini_write_real("TestSection", "TestKey1", 10);
		ini_write_string("TestSection", "TestKey2", "some text");
		ini_write_string("OtherSection", "TestKey1", "some other text");
		ini_close();
			
		ini_open(_filePath);
			
			
		// Section exist
		_output = ini_section_exists("TestSection");
		assert_true(_output, "#3 ini_section_exists ( section ) failed to detect existing section");
			
			
		// Key doesn't exist
		_output = ini_key_exists("TestSection", "MissingKey");
		assert_false(_output, "#4 ini_key_exists ( section, key ) should not detect a nonexistent key");
			
			
		// Key exists
		_output = ini_read_real("TestSection", "TestKey1", -1);
		assert_equals(_output, 10, "#5.1 ini_read_real ( section, key ), failed to return the stored real value.");
			
		_output = ini_read_string("TestSection", "TestKey2", "default");
		assert_equals(_output, "some text", "#5.2 ini_read_string ( section, key ), failed to return the stored string value.");
			
		_output = ini_read_string("OtherSection", "TestKey1", "default");
		assert_equals(_output, "some other text", "#5.3 ini_read_string ( section, key ), failed to return the stored string value.");
			
			
		// Key doesn't exist (default)
		_output = ini_read_real("TestSection", "MissingKey1", -1);
		assert_equals(_output, -1, "#6.1 ini_read_real ( section, key ), missing key should have returned default real value.");
			
		_output = ini_read_string("TestSection", "MissingKey2", "default");
		assert_equals(_output, "default", "#6.2 ini_read_string ( section, key ), missing key should have returned default string value.");


		// Delete section
		ini_section_delete("TestSection");
		_output = ini_section_exists("TestSection");
		assert_false(_output, "#7 ini_section_exists ( section ) should not detect a deleted section");


		// Delete key
		ini_key_delete("OtherSection", "TestKey1");
		_output = ini_key_exists("OtherSection", "TestKey1");
		assert_false(_output, "#8 ini_key_exists ( section ) should not detect a deleted key");
			
		// Close (read/write error)
		ini_close();
		assert_throw(function() {
				
			ini_write_real("TestSection", "TestKey", 12);
			return ini_read_real("TestSection", "TestKey", -1);
			
		}, "#9 ini_close (), didn't manage to close the file (can still read/write)");

		file_delete(_filePath);

		if (platform_not_browser()) directory_destroy(_directory);			
	})
	
	addFact("ini_open_from_string_test", function() {
		
		var _output;
		var _input = "[owner]\n" +
					"name = John Doe\n" + 
					"organization = YoYo Games Limited\n" + 
					"\n" + 
					"[data]\n" + 
					"server = 192.168.1.0\n" +
					"port = 143\n" +
					"file = \"testFile.dat\"\n";
		
		ini_open_from_string(_input);
		
		_output = ini_section_exists("owner");
		assert_true(_output, "#1 ini_section_exists ( section ), failed to detect section of temporary file");
			
		_output = ini_section_exists("data");
		assert_true(_output, "#2 ini_section_exists ( section ), failed to detect section of temporary file");
			
		_output = ini_key_exists("data", "server");
		assert_true(_output, "#3 ini_key_exists ( section, key ), failed to detect section of temporary file");
			
		_output = ini_read_string("data", "server", "");
		assert_equals(_output, "192.168.1.0", "#4 ini_read_string ( section, key, ... ), failed to read correct value of temporary file");
			
		_output = ini_read_real("data", "port", -1);
		assert_equals(_output, 143, "#5 ini_read_real ( section, key, ... ), failed to read correct value of temporary file");
			
		_output = ini_close();
		assert_not_equals(_output, "", "#6 ini_close ( ), shouldn't have returned an empty string");
			
	});
	
}