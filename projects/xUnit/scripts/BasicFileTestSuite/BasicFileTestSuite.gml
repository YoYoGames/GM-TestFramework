
function BasicFileTestSuite() : TestSuite() constructor {
	
	// DIRECTORY & FILES
	addFact("directory_test", function() {
			
		var value, directory = working_directory + "NONEXISTENT_DIRECTORY";
			
		// Test directory_exists
		value = directory_exists(directory);
		assert_false(value, "#1 directory_exists( 'NONEXISTENT_DIRECTORY' ), should not exist");
			
		value = directory_exists(working_directory);
		assert_true(value, "#1 directory_exists( working_directory ), should exist");
			
		directory = working_directory + "testDir";
			
		// Test directory_create simple
		directory_create(directory);
		value = directory_exists(directory);
		assert_true(value, "#2 directory_create( directory ), failed to create simple directory");
			
		// Test directory_destroy simple
		directory_destroy(directory);
		value = directory_exists(directory);
		assert_false(value, "#3 directory_destroy( directory ), failed to destroy simple directory");
			
			
		directory = working_directory + "testDir/nestedDir";
			
		// Test directory_create nested
		directory_create(directory);
		value = directory_exists(directory);
		assert_true(value, "#4 directory_create( direcotry ), failed to create nested directory");
			
		// Test directory_destroy nested
		directory_destroy(directory);
		value = directory_exists(directory);
		assert_false(value, "#5 directory_destroy( directory ), failed to destroy nested directory");
			
	}, { test_filter: platform_not_browser });

	addFact("file_test", function() {

		var value, directory = working_directory + "testDir";

		if (platform_not_browser()) {

			// Make sure test directory doesn't exist
			if (directory_exists(directory)) directory_destroy(directory);
			directory_create(directory);	
		}
		
		var firstFilename = "first.txt", secondFilename = "second.doc";
			
		var firstPath = string("{0}\\{1}", directory, firstFilename);
		var secondPath = string("{0}\\{1}", directory, secondFilename);
			
		// Test file_exists on non existing files
		value = file_exists(firstPath);
		assert_false(value, "#1.1 file_exists( filepath ), file should not exist yet");
		value = file_exists(secondPath);
		assert_false(value, "#1.2 file_exists( filepath ), file should not exist yet");
			
		// Create files
		var firstFile = file_text_open_write(firstPath);
		file_text_writeln(firstFile);
		file_text_close(firstFile);
			
		var secondFile = file_text_open_write(secondPath);
		file_text_writeln(secondFile);
		file_text_close(secondFile);
			
		// Test file_exists on existing files
		value = file_exists(firstPath);
		assert_true(value, "#2.1 file_text_open_write ( filepath ), failed creating file");
		value = file_exists(secondPath);
		assert_true(value, "#2.2 file_text_open_write ( filepath ), failed creating file");
			

		if (platform_not_browser()) {

			// Create a nested directory
			var nestedDirectory = "nestedDir";
			var nestedPath = string("{0}\\{1}", directory, nestedDirectory);
			directory_create(nestedPath);

			// Test file_find on 'file' type
			var first = file_find_first("testDir\\*.*", 0);
			var second = file_find_next();
			var third = file_find_next();
			
			assert_equals(first, firstFilename, "#3.1 file_find_first ( filename_pattern ), failed to identify first file");
			assert_equals(second, secondFilename, "#3.2 file_find_next (), failed to identify second file");
			assert_equals(third, "", "#3.3 file_find_next (), there are no more files");
			file_find_close();
	
			
			// There is no good way to test this
			
			// Test file_find on 'directory' type
			// first = file_find_first("testDir\\*", fa_directory);
			// second = file_find_next();
			// assert_equals(first, nestedDirectory, "#4.1 file_find_first (), failed to identify first directory");
			// assert_equals(second, "", "#4.2 file_find_next (), there are no more directories");
			// file_find_close();
		
		}
			
		// Test file_delete
		file_delete(secondPath);
		value = file_exists(secondPath);
		assert_false(value, "#5 file_delete ( filepath ), failed to delete (file still exists after deletion)");
			
		// Test file_rename
		var renamedPath = string("{0}\\{1}", directory, "renamed.txt");
		file_rename(firstPath, renamedPath);
		value = file_exists(firstPath);
		assert_false(value, "#6.1 file_rename ( oldName, newName ), failed to rename (old file still exists)");
		value = file_exists(renamedPath);
		assert_true(value, "#6.2 file_rename ( oldName, newName ), failed to rename (new file doesn't exist)");
			
		// Test file_copy
		var copiedPath = string("{0}\\{1}", directory, "copied.txt");
		file_copy(renamedPath, copiedPath);
		value = file_exists(renamedPath);
		assert_true(value, "#7.1 file_copy ( oldName, newName ), failed to copy (old file doesn't exist)");
		value = file_exists(copiedPath);
		assert_true(value, "#7.2 file_copy ( oldName, newName ), failed to rename (new file doesn't exist)");
		
		// Clean up
		
		file_delete(renamedPath);
		file_delete(copiedPath);
		
		if (platform_not_browser()) directory_destroy(directory);
			
		// Removing this for now because file_attributes does not allow you to check attribute of a directory, according to current Runner implementation.
		//var fileAttributes = file_attributes(firstDirectory, fa_directory);
		//assert_true(fileAttributes, "Directory had correct file attributes");
		//file_attributes(fname,fa_readonly);
		//file_attributes(fname,fa_hidden);
		//file_attributes(fname,fa_sysfile);
		//file_attributes(fname,fa_volumeid);
		//file_attributes(fname,fa_archive);

	})

	addFact("file_exists_not_sandboxed", function() {

		var _output = file_exists("c:\\windows\\explorer.exe");
			
		// Check if not running on HTML5 runner.
		if (os_browser == browser_not_a_browser)
		{
			assert_true(_output, "#1 file_exists( 'c:/windows/explorer.exe' ), failed to find a file outside of the sandbox");
		}
		else
		{
			assert_false(_output, "#1 file_exists( 'c:/windows/explorer.exe' ), should not find the file on HTML5");
		}			
			

	}, { test_filter: function() { return platform_windows() && !filesystem_is_sandboxed() } });

	// BINARY FILES

	addFact("file_bin_test", function() {

		var _output, directory = working_directory + "testDir";
			
		// Make sure test directory doesn't exist
		if (directory_exists(directory)) directory_destroy(directory);
		directory_create(directory);
			
		var _fileHandle, filename = "fileTest.bin";
			
		var filePath = string("{0}\\{1}", directory, filename);

		//#1 file_bin_open ( filename, write )
		_fileHandle = file_bin_open(filePath, 1);
		assert_greater(_fileHandle, 0, "#1 file_bin_open ( filename, write ), was unable to open file.");
			
		// Write some data into the file
		file_bin_write_byte(_fileHandle, 0101);
		file_bin_write_byte(_fileHandle, 1100);
		file_bin_write_byte(_fileHandle, 0001);
		file_bin_write_byte(_fileHandle, 1000);
		// Close file
		file_bin_close(_fileHandle);
			
		//#2 file_bin_open ( filename, read )
		_fileHandle = file_bin_open(filePath, 0);
		assert_greater(_fileHandle, 0, "#2 file_bin_open ( filename, read ), was unable to open file.");
			
		//#3 file_bin_size ( file )
		_output = file_bin_size(_fileHandle);
		assert_equals(_output, 4, "#3 file_bin_size ( file ), wrong file size.");
			
		//#4 file_bin_read_byte ( file )
		_output = file_bin_read_byte(_fileHandle)
		assert_equals(_output, 0101, "#4 file_bin_read_byte ( file ), wrong data read/write");
			
		//#5 file_bin_read_seek/position ( file )
		file_bin_seek(_fileHandle, 3);
		_output = file_bin_position(_fileHandle)
		assert_equals(_output, 3, "#5 file_bin_read_seek/position ( file ), failed to seek or get position");
			
		file_bin_close(_fileHandle);
			
		//#6 file_bin_open ( filename, read/write )
		_fileHandle = file_bin_open(filePath, 2);
		assert_greater(_fileHandle, 0, "#6 file_bin_open ( filename, read/write ), was unable to open file.");
			
		//#7 file_bin_rewrite ( file )
		file_bin_rewrite(_fileHandle);
		_output = file_bin_size(_fileHandle)
		assert_equals(_output, 0, "#7 file_bin_rewrite ( file ), file size should be zero");
			
		//#8 file_bin_close ( file )
		file_bin_close(_fileHandle);
		assert_throw(method({ handle: _fileHandle }, function() {
				
			file_bin_read_byte(handle);
				
			file_bin_write_byte(handle, 1010);
				
		}), "#8 file_bin_close ( file ), didn't manage to close the file (can still read/write)");
			
		directory_destroy(directory);
	
	}, { test_filter: platform_not_browser });

	// TEXT FILES

	addFact("file_text_test", function() {

		//SB: file_text_open_write/read/append/from_string, file_text_write_string/real/ln, file_text_close, file_delete/copy/exists/rename
			
		var value, directory = working_directory + "testDir";

		if (platform_not_browser()) {

			// Make sure test directory doesn't exist
			if (directory_exists(directory)) directory_destroy(directory);
			directory_create(directory);
		}

		var filename = "testFile.txt"	
		var filePath = string("{0}\\{1}", directory, filename);

		// Test file creation (file_text_open_write + file_text_close)
		var _fileHandle = file_text_open_write(filePath);
		file_text_close(_fileHandle);
			
		value = file_exists(filePath);
		assert_true(value, "#1 file_text_open_write( filename ), failed to create a file.");
			
		_fileHandle = file_text_open_write(filePath);
			
		// Write some values to the file (string & real)
		file_text_write_string(_fileHandle, "Hello World");
		file_text_writeln(_fileHandle);
		file_text_write_real(_fileHandle, 500);
		file_text_close(_fileHandle);
			
		// Open the file in read mode
		_fileHandle = file_text_open_read(filePath);
			
		// Perfom the read routine
		while (!file_text_eof(_fileHandle)) {
				
			value = file_text_read_string(_fileHandle);
			assert_equals(value, "Hello World", "#2.1 file_text_read_string (file), failed to read the correct string");
			file_text_readln(_fileHandle);
				
			while(!file_text_eoln(_fileHandle)) {
					
				value = file_text_read_real(_fileHandle);
				assert_equals(value, 500, "#2.2 file_text_read_real (file), failed to read the correct real");
					
				file_text_readln(_fileHandle);
					
				value = file_text_eoln(_fileHandle);
				assert_true(value, "#2.3 file_text_eoln (file), failed to detect the end of the line");
			}
		}
			
		value = file_text_eof(_fileHandle);
		assert_true(value, "#2.4 file_text_eof (file), failed to detect the end of the file");
		file_text_close(_fileHandle);
			
			
			
		// Open the file in append mode
		_fileHandle = file_text_open_append(filePath);
		file_text_writeln(_fileHandle);
		file_text_write_string(_fileHandle, "Appended Text");
		file_text_close(_fileHandle);
			
		// Open the file in read mode
		_fileHandle = file_text_open_read(filePath);
			
		// Perfom the read routine (again)
		while (!file_text_eof(_fileHandle)) {
				
			value = file_text_read_string(_fileHandle);
			assert_equals(value, "Hello World", "#3.1 file_text_read_string (file), failed to read the correct string");
				
			file_text_readln(_fileHandle);
				
			value = file_text_read_real(_fileHandle);
			assert_equals(value, 500, "#3.2 file_text_read_real (file), failed to read the correct real");
					
			file_text_readln(_fileHandle);
				
			value = file_text_read_string(_fileHandle);
			assert_equals(value, "Appended Text", "#3.4 file_text_open_append (file), failed to appended text correctly");
		}
			
		// Open the file in read mode
		file_text_close(_fileHandle);
			
		assert_throw(method({ handle: _fileHandle }, function() {
				
			file_text_read_real(handle);
				
			file_text_write_string(handle, "Some Text");
				
		}), "#4 file_text_close ( file ), didn't manage to close the file (can still read/write)");
			
		// Clean up
		file_delete(filePath);
		if (platform_not_browser()) directory_destroy(directory);

	})

	addFact("file_text_open_from_string_test", function() {

		var input, _output, _file;
				
		//#1 Open file from string (test string, real, eoln)
		input = "This is a test\n30\nTo see if this works";
			
		_file = file_text_open_from_string(input);
		assert_not_equals(_file, -1, "#1.0 file_text_open_from_string(), failed to create temporary file");
			
		_output = file_text_eof(_file);
		assert_false(_output, "#1.1 file_text_eof (file), shouldn't be at the eof after opening a filled file");
			
		_output = file_text_read_string(_file);
		assert_equals(_output, "This is a test", "#1.2 file_text_read_string (file), failed to read string from temp file");
			
		_output = file_text_read_real(_file);
		assert_equals(_output, 30, "#1.3 file_text_read_real (file), failed to read real from temp file");
						
		_output = file_text_eoln(_file);
		assert_true(_output, "#1.4 file_text_eoln (file), failed to detect end of line");
		file_text_close(_file);
			

		//#2 file_text_open_from_string( string const ) - empty string
		input = "";
		_file = file_text_open_from_string("");
		_output = file_text_read_string(_file);
		assert_equals(_output, "", "#2 file_text_open_from_string( '' ), should read empty string ('')");
		file_text_close(_file);

		//#3 file_text_open_from_string( string const ) - single 4-byte utf-8 char
		input = "🙂";
		_file = file_text_open_from_string(input);
		_output = file_text_read_string(_file);
		assert_equals(_output, "🙂", "#3 file_text_open_from_string( string:local ), failed to read single 4-byte utf-8 char")
		file_text_close(_file);
			
		//#4 file_text_open_from_string( string const ) - complex utf-8 string
		_file = file_text_open_from_string("!£水🙂");
		_output = file_text_read_string(_file);
		assert_equals(_output, "!£水🙂", "#4 file_text_open_from_string( string:local), failed to read complex utf-8 string")
		file_text_close(_file);
			
	})

	// FILENAMES

	addFact("filename_test_simulated", function() {

		var _output, filename = "/foo/bar/pathname/to/the/fileTest.txt";
			
		_output = filename_name(filename);
		assert_equals(_output, "fileTest.txt", "#1.0 filename_name ( forward_path ) failed");
			
		_output = filename_path(filename);
		assert_equals(_output, "/foo/bar/pathname/to/the/", "#1.1 filename_path ( forward_path ) failed");
			
		_output = filename_path("");
		assert_equals(_output, "", "#1.15 filename_path ( '' ) failed");
			
		_output = filename_dir(filename);
		assert_equals(_output, "/foo/bar/pathname/to/the", "#1.2 filename_dir ( forward_path ) failed");

		_output = filename_ext(filename);
		assert_equals(_output, ".txt", "#1.3 filename_ext ( forward_path ) failed");
			
		_output = filename_change_ext(filename, ".doc");
		assert_equals(_output, filename_path(filename) + "fileTest.doc", "#1.4 filename_change_ext ( forward_path ) failed");
			
			
		filename = @"\foo\bar\pathname\to\the\fileTest.txt";
			
		_output = filename_name(filename);
		assert_equals(_output, "fileTest.txt", "#2.0 filename_name ( backslash_path ) failed");
			
		_output = filename_path(filename);
		assert_equals(_output, @"\foo\bar\pathname\to\the\", "#2.1 filename_path ( backslash_path ) failed");
			
		_output = filename_dir(filename);
		assert_equals(_output, @"\foo\bar\pathname\to\the", "#2.2 filename_dir ( backslash_path ) failed");
			
		_output = filename_ext(filename);
		assert_equals(_output, ".txt", "#2.3 filename_ext ( backslash_path ) failed");
			
		_output = filename_change_ext(filename, ".doc");
		assert_equals(_output, filename_path(filename) + "fileTest.doc", "#2.4 filename_change_ext ( backslash_path ) failed");
			
	})

	addFact("filename_test_windows", function() {
		
		// RK :: directory functions not supported on HTML5
		if (os_browser != browser_not_a_browser) return;

		var fileWrite = file_text_open_write("testFile.txt");
		file_text_write_string(fileWrite, "Hello World");
		file_text_close(fileWrite);
		
		var fileName = filename_name(file_find_first("*.txt", 0));
		assert_equals(fileName, "testFile.txt", "Filename didn't work correctly");
		file_find_close();
			
		// The project these land in is named after the test file itself.
		// During the test framework run, each test is considered its own unique project.
		var localAppDataPath = environment_get_variable("localappdata");
		var projectName = game_project_name;
		
		var filePath = filename_path("testFile.txt");
		assert_equals(filePath, localAppDataPath + "\\" + projectName + "\\", "filename_path didn't work correctly"); //NOTE
			
		var fileDirectory = filename_dir("testFile.txt");
		assert_equals(fileDirectory, localAppDataPath + "\\" + projectName, "filename_dir didn't work correctly"); //NOTE
			
		var fileDrive = filename_drive(localAppDataPath + "\\" + projectName + "\\testFile.txt");
		assert_equals(fileDrive, "C:", "filename_drive didnt' work correctly");
			
		var fileExt = filename_ext("testFile.txt");
		assert_equals(fileExt, ".txt", "filename_ext didnt' work correctly");
			
		var fileFullPath = filePath + "testFile.txt";
		var newFilename = filename_change_ext(fileFullPath, ".doc");
		assert_equals(newFilename, filePath + "testFile.doc", "filename_change_ext didn't work correctly");
			
		file_delete("testFile.txt");

	}, { test_filter: platform_windows });

	addFact("filename_test_macos", function() {
		
		// RK :: directory functions not supported on HTML5
		if (os_browser != browser_not_a_browser) return;
			
		var fileWrite = file_text_open_write("testFile.txt");
		file_text_write_string(fileWrite, "Hello World");
		file_text_close(fileWrite);
		
		var fileName = filename_name(file_find_first("*.txt", 0));
		assert_equals(fileName, "testFile.txt", "Filename didn't work correctly");
		file_find_close();
			
		// The project these land in is named after the test file itself.
		// During the test framework run, each test is considered its own unique project.
			
		// Bundle name in macOSX VM is always the same despite what it was set to in the IDE
		var bundleName = code_is_compiled() ? "com.yoyogames.olympus" : "com.yoyogames.macyoyorunner";
		var localAppDataPath = environment_get_variable("HOME") + "/Library/Application Support/";
			
		var filePath = filename_path("testFile.txt");
		assert_equals(filePath, localAppDataPath + bundleName + "/", "filename_path didn't work correctly");
			
		var fileDirectory = filename_dir("testFile.txt");
		assert_equals(fileDirectory, localAppDataPath + bundleName, "filename_dir didn't work correctly");
			
		var fileExt = filename_ext("testFile.txt");
		assert_equals(fileExt, ".txt", "filename_ext didn't work correctly");
			
		var fileFullPath = filePath + "testFile.txt";
		var newFilename = filename_change_ext(fileFullPath, ".doc");
		assert_equals(newFilename, filePath + "testFile.doc", "filename_change_ext didn't work correctly");
			
		file_delete("testFile.txt");

	}, { test_filter: platform_macosx });

	// CSV FILES

	addFact("load_csv_test", function() {

		var _file, _output;
			
		// Test 6x6 grid

		_file = load_csv("testTable.csv");
		assert_not_equals(_file, -1, "#1 load_csv, failed to correctly load the file");
			
		_output = ds_grid_width(_file);
		assert_equals(_output, 6, "#2 ds_grid_width, failed return the correct width of the csv file.");
			
		_output = ds_grid_height(_file);
		assert_equals(_output, 6, "#2 ds_grid_height, failed return the correct height of the csv file.");
			
		assert_grid_equals_array(_file,
			[ 0,  0,  0,  0,  0,  0,
				0,  1,  2,  3,  4,  5,
				0,  2,  4,  6,  8,  10,
				0,  3,  6,  9,  12, 15,
				0,  4,  8,  12, 16, 20,
				0,  5,  10, 15, 20, 25 ], "#3 load_csv, failed to load the correct file (grid) structure.");
			
			
		ds_grid_destroy(_file);
			
		// Test 1x36 grid
			
		_file = load_csv("testList.csv");
		assert_not_equals(_file, -1, "#1 load_csv, failed to correctly load the file");
			
		_output = ds_grid_width(_file);
		assert_equals(_output, 36, "#2 ds_grid_width, failed return the correct width of the csv file.");
			
		_output = ds_grid_height(_file);
		assert_equals(_output, 1, "#2 ds_grid_height, failed return the correct height of the csv file.");
			
		assert_grid_equals_array(_file,
			[ 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 2, 4, 6, 8, 10, 0, 3, 6, 9, 12, 15, 0, 4, 8, 12, 16, 20, 0, 5, 10, 15, 20, 25 ],
			"#3 load_csv, failed to load the correct file (grid) structure.");
			
			
		ds_grid_destroy(_file);

	})

}



