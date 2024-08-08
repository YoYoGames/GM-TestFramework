/// @function create_ini_file()
/// @description This function will create the directory "TestDir" and return a path to "TestFile.ini" within it
/// @returns {String}
function create_ini_file() {
    var _directory = working_directory + "TestDir";
    
    if (platform_not_browser()) {
        
        // Make sure test directory doesn't exist
        if (directory_exists(_directory)) 
        {
            directory_destroy(_directory);
        } 
        
        directory_create(_directory);   
    }
    
    var _filename = "TestFile.ini";
    var _file_path = string("{0}\\{1}", _directory, _filename);
    
    return _file_path;
}

/// @function delete_ini_file(file_path)
/// @description This function will delete the ini file at the provided file path, as well as the directory it's located within
/// @param {String} file_path The file path that the ini file is located at
function delete_ini_file(_file_path) {
    file_delete(_file_path);
    
    var _directory = string_copy(_file_path, 0, string_last_pos("\\", _file_path)-1);
    if (platform_not_browser()) 
    {
        // Check that the directory is empty
        if (file_find_first(_directory + "\\*", fa_none) == "")
        { 
            directory_destroy(_directory); 
        }
    }
}


function BasicIniTestSuite() : TestSuite() constructor {
    
    addFact("ini_open", function() {
    // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Write a string to it, then check that the string has been written to ensure it was opened correctly
        ini_write_string("test", "test", "test");
        assert_equals(ini_close(), "[test]\r\ntest=\"test\"\r\n", "failed to open ini file");
        
        // Close and delete the file once test is finished
        ini_close()
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_section_exists #1", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Check that a nonexistant section is recognised as nonexistant
        var _output = ini_section_exists("TestSection");
        assert_false(_output, "should not detect a nonexistent section");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_section_exists #2", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Write a section to the file then check that it exists
        ini_write_real("TestSection", "TestKey", 10);
        var _output = ini_section_exists("TestSection");
        assert_true(_output, "failed to detect existing section");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_section_exists #3", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Check that the first section can be detected
        var _output = ini_section_exists("owner");
        assert_true(_output, "failed to detect section of temporary file");
        
        // Close the file once test is finished
        ini_close();
    })
    
    addFact("ini_section_exists #4", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Check that the second section can be detected
        var _output = ini_section_exists("data");
        assert_true(_output, "failed to detect section of temporary file");
        
        // Close the file once test is finished
        ini_close();
    })
    
    addFact("ini_section_delete", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Create and delete a section, then check that it no longer exists
        ini_write_real("TestSection", "TestKey", 10);
        ini_section_delete("TestSection");
        var _output = ini_section_exists("TestSection");
        assert_false(_output, "failed to delete section");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_key_exists #1", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Check that a nonexistant key is recognised as nonexistant
        var _output = ini_key_exists("TestSection", "MissingKey");
        assert_false(_output, "should not detect a nonexistent key");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_key_exists #2", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Check that the "server" key can be detected
        var _output = ini_key_exists("data", "server");
        assert_true(_output, "failed to detect section of temporary file");
        
        // Close the file once test is finished
        ini_close();
    })
    
    addFact("ini_key_delete", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Create and delete a key, then check that it no longer exists
        ini_write_real("TestSection", "TestKey", 10);
        ini_key_delete("TestSection", "TestKey");
        var _output = ini_key_exists("TestSection", "TestKey");
        assert_false(_output, "should not detect a deleted key");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_real #1", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Write a real to the file then read it's value to check that they match
        ini_write_real("TestSection", "TestKey", 10);
        var _output = ini_read_real("TestSection", "TestKey", -1);
        assert_equals(_output, 10, "failed to return the stored real value.");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_real #2", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Check that reading a nonexistant key returns the default real value
        var _output = ini_read_real("TestSection", "MissingKey", -1);
        assert_equals(_output, -1, "missing key should have returned default real value.");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_real #3", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Read the value of "port" and check it matches the value it was created with 
        var _output = ini_read_real("data", "port", -1);
        assert_equals(_output, 143, "failed to read correct value of temporary file");
    })
    
    addFact("ini_read_string #1", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Write a string to the file then read it's value to check that they match
        ini_write_string("TestSection", "TestKey", "some text");
        var _output = ini_read_string("TestSection", "TestKey", "default");
        assert_equals(_output, "some text", "failed to return the stored string value.");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_string #2", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Write two strings to the file then read the value of the second to check it matches
        ini_write_string("TestSection1", "TestKey1", "some text");
        ini_write_string("TestSection2", "TestKey2", "some other text");
        var _output = ini_read_string("TestSection2", "TestKey2", "default");
        assert_equals(_output, "some other text", "failed to return the second stored string value.");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_string #3", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Check that reading a nonexistant key returns the default string value
        var _output = ini_read_string("TestSection", "MissingKey", "default");
        assert_equals(_output, "default", "missing key should have returned default string value.");
        
        // Close and delete the file once test is finished
        ini_close();
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_read_string #4", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Read the value of "server" and check it matches the value it was created with 
        var _output = ini_read_string("data", "server", "");
        assert_equals(_output, "192.168.1.0", "failed to read correct value of temporary file");
    })
    
    addFact("ini_close #1", function() {
        // Create and open ini file
        var _ini_file_path = create_ini_file();
        ini_open(_ini_file_path);
        
        // Close the file then try writing to it/reading from it and check that it throws an error
        ini_close();
        assert_throw(function() {
            
            ini_write_real("TestSection", "TestKey", 12);
            return ini_read_real("TestSection", "TestKey", -1);
            
        }, "didn't manage to close the file (can still read/write)");
        
        // Delete the file once test is finished
        delete_ini_file(_ini_file_path);
    })
    
    addFact("ini_close #2", function() {
        // Create and open temporary ini file from string
        var _input = "[owner]\n" +
        "name = John Doe\n" + 
        "organization = YoYo Games Limited\n" + 
        "\n" + 
        "[data]\n" + 
        "server = 192.168.1.0\n" +
        "port = 143\n" +
        "file = \"testFile.dat\"\n";
        ini_open_from_string(_input);
        
        // Close the temporary file and check that it returns its contents
        var _output = ini_close();
        assert_not_equals(_output, "", "#6 ini_close ( ), shouldn't have returned an empty string");
    })
    
    config({ suite_filter: platform_not_console });
}
