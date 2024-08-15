
/// @function RunForAllBufferTypes()
/// @description This function will run the provided test function for every possible buffer type, passing a created buffer of that type with a random size and alignment into the function, along with the current type, buffer size, name of the type, and buffer alignment for use in the test.
/// @param {Function} testFunc The function to run for each buffer type (should have the arguments testBuffer, iType, iSize, iTypeString, iAlignment)
function RunForAllBufferTypes(testFunc) {
    var iTypeData = [
    [ buffer_fixed, "buffer_fixed" ],
    [ buffer_grow,  "buffer_grow" ],
    [ buffer_wrap,  "buffer_wrap" ],
    [ buffer_fast,  "buffer_fast" ],
    [ buffer_vbuffer, "buffer_vbuffer" ]
    ];
    
    for (var i = 0; i < array_length(iTypeData); i++) {
        var iType = iTypeData[i][0];
        var iTypeString = iTypeData[i][1];
        
        var iSize = power(2, choose(6, 7, 8, 9, 12));
        var iAlignment = choose(1, 2, 4, 8);			
        var testBuffer = buffer_create(iSize, iType, iAlignment);
        
        testFunc(testBuffer, iType, iSize, iTypeString, iAlignment);
    }
    
    if (buffer_exists(testBuffer))
    {
        buffer_delete(testBuffer);
    }
}

/// @function RunForAllBufferDataTypes()
/// @description This function will run the provided test function for every possible buffer data type, passing a created buffer, the current type, a value of that type, the name of the type, and the size of the type into the function to be used in the test.
/// @param {Function} testFunc The function to run for each buffer data type (should have the arguments testBuffer, type, value, typeString, and typeSize)
function RunForAllBufferDataTypes(testFunc) {
    
    var data = [
    [ buffer_bool, true, "buffer_bool" ],
    
    [ buffer_u8, 10, "buffer_u8" ],
    [ buffer_u16, 14532, "buffer_u16" ],
    [ buffer_u32, 2930471932, "buffer_u32" ],
    [ buffer_u64, 14738282109100, "buffer_u64" ],
    
    [ buffer_s8, -10, "buffer_s8" ],
    [ buffer_s16, -27145, "buffer_s16" ],
    [ buffer_s32, -2102943143, "buffer_s32" ],
    
    [ buffer_f16, -2.34, "buffer_f16" ],
    [ buffer_f32, -493200.1934, "buffer_f32" ],
    [ buffer_f64, -147382821091.992, "buffer_f64" ],
    [ buffer_string, "Hello world, this is a test string!", "buffer_string" ],
    ];
    
    var dataLength = array_length(data);
    for (var i = 0; i < dataLength; i++) {
        
        var current = data[i];
        
        var type = current[0];
        var value = current[1];
        var typeString = current[2];
        var typeSize = buffer_sizeof(type);
        var testBuffer = buffer_create(1, buffer_grow, 1);
        
        if (platform_browser() && type == buffer_f16) continue;
    
        testFunc(testBuffer, type, value, typeString, typeSize);
    }
    
    if (buffer_exists(testBuffer))
    {
        buffer_delete(testBuffer);
    }
}


function BasicBufferTestSuite() : TestSuite() constructor {

    addFact("buffer_exists_test", function() {
        
        // For all buffer types, create a buffer then check that it exists
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_exists(testBuffer);
            assert_true(output, string("buffer_exists({0}, {1}, {2}), failed to create a buffer", iSize, iTypeString, iAlignment));
        })
    });
    
    addFact("buffer_get_type_test", function() {
        
        // For all buffer types, create a buffer then check that its type can be correctly identified
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_get_type(testBuffer);
            assert_equals(output, iType, string("buffer_get_type({0}, {1}, {2}), failed to identify correct type", iSize, iTypeString, iAlignment));
        })
    });
    
    addFact("buffer_get_alignment_test", function() {
        
        // For all buffer types, create a buffer then check that its alignment can be correctly identified
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_get_alignment(testBuffer);
            assert_equals(output, iAlignment, string("buffer_get_alignment({0}, {1}, {2}), failed to identify correct alignment", iSize, iTypeString, iAlignment));
        })
    });
    
    addFact("buffer_get_size_test", function() {
        
        // For all buffer types, create a buffer then check that its size can be correctly identified
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_get_size(testBuffer);
            assert_equals(output, iSize, string("buffer_get_size({0}, {1}, {2}), failed to identify correct size", iSize, iTypeString, iAlignment));
        })
    });
    
    addFact("buffer_get_address_test", function() {
        
        // For all buffer types, create a buffer then check that its address can be correctly identified
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_get_address(testBuffer);
            assert_not_equals(output, pointer_invalid, string("buffer_get_address(), failed to return a valid address (type: {0})", iTypeString));
        })
    });
    
    addFact("buffer_tell_test", function() {
        
        // For all buffer types, create a buffer then check that its initial "seek" position can be correctly identified
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var output = buffer_tell(testBuffer);
            assert_equals(output, 0, string("buffer_tell(), failed to return correct value ({0}, {1}, {2})", iSize, iTypeString, iAlignment));
        })
    });
    
    addFact("buffer_seek_test #1", function() {
        
        // For all buffer types, create a buffer, change its "seek" position to a random distance from the start of the buffer, 
        // then check it has been correctly moved to that position
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var input = irandom(iSize);
            buffer_seek(testBuffer, buffer_seek_start, input);
            var output = buffer_tell(testBuffer);
            assert_equals(output, input, string("buffer_seek(buffer_seek_start), failed to return correct value (size: {0}, offset: {1})", iSize, input));
        })
    });
    
    addFact("buffer_seek_test #2", function() {
        
        // For all buffer types, create a buffer, change its "seek" position to a random distance from the end of the buffer, 
        // then check it has been correctly moved to that position
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var input = irandom(iSize);
            buffer_seek(testBuffer, buffer_seek_end, input);
            var output = buffer_tell(testBuffer);
            assert_equals(output, iSize-input, string("buffer_seek(buffer_seek_end), failed to return correct value (size: {0}, offset: {1})", iSize, input));
        })
    });
    
    addFact("buffer_seek_test #3", function() {
        
        // For all buffer types, create a buffer, change its "seek" position to the middle of the buffer, 
        // then check it has been correctly moved to that position
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            buffer_seek(testBuffer, buffer_seek_start, iSize/2); // Place in the middle of the buffer
            
            var input = irandom_range(-iSize/2, iSize/2);
            buffer_seek(testBuffer, buffer_seek_relative, input);
            var output = buffer_tell(testBuffer);
            assert_equals(output, (iSize/2) + input, string("buffer_seek(buffer_seek_relative), failed to return correct value (size: {0}, offset-middle: {1})", iSize, input));
            
        })
    });
    
    addFact("buffer_resize_test", function() {
        
        // For all buffer types, create a buffer, resize it to a random size, 
        // then check it has been correctly resized to the value provided
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            var input = power(2, choose(6, 7, 8, 9, 12));
            buffer_resize(testBuffer, input);
            var output = buffer_get_size(testBuffer)
            assert_equals(output, input, string("buffer_resize(), failed to return correct value (type: {0})", iTypeString));
        })
    });
    
    addFact("buffer_delete_test", function() {
        
        // For all buffer types, create a buffer, delete it, then check that it no longer exists.
        RunForAllBufferTypes(function(testBuffer, iType, iSize, iTypeString, iAlignment) {
        
            buffer_delete(testBuffer);
            var output = buffer_exists(testBuffer);
            assert_false(output, string("buffer_delete(), failed to delete a buffer (type: {0})", iTypeString));
        })
    });

    addFact("buffer_fill_test #1", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the buffer with the value "a" and check that it has been correctly filled
        var input = "a";
        buffer_fill(testBuffer, 0, buffer_text, input, 512);
        output = buffer_peek(testBuffer, 0, buffer_u8);
        assert_equals(output, ord(input), "buffer_fill(), failed to fill the entire buffer (start)");
        output = buffer_peek(testBuffer, 511, buffer_u8);
        assert_equals(output, ord(input), "buffer_fill(), failed to fill the entire buffer (end)");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
    addFact("buffer_fill_test #2", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the buffer with the value "b" and check that it has been correctly filled
        var input = "b";
        buffer_fill(testBuffer, 256, buffer_text, input, 512);
        output = buffer_peek(testBuffer, 256, buffer_u8);
        assert_equals(output, ord(input), "buffer_fill(), failed to fill the entire buffer, using offset (offset)");
        output = buffer_peek(testBuffer, 511, buffer_u8);
        assert_equals(output, ord(input), "buffer_fill(), failed to fill the entire buffer, using offset (end)");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
	addFact("buffer_crc32_test", function() {

		// Create a buffer and write the numbers 0-255 to it
		var output, testBuffer = buffer_create(256, buffer_grow, 1);
		for(var i = 0; i < 256; ++i) buffer_write( testBuffer, buffer_u8, i);
        
        // Get a crc32 checksum hash from the buffer, and check it has the correct value    
		output = buffer_crc32(testBuffer, 32, 64);
		assert_equals(output, 0xE809C6C8, "buffer_crc32");
        
        // Clean up
		buffer_delete(testBuffer);
	});
    
    addFact("buffer_md5_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the first half of the buffer with value "a", and the second with "b"
        var input = "a";
        buffer_fill(testBuffer, 0, buffer_text, input, 512);
        input = "b";
        buffer_fill(testBuffer, 256, buffer_text, input, 512);
        
        // Get a MD5 hash from the buffer, and check it has the correct value    
        output = buffer_md5(testBuffer, 0, 512);
        assert_equals(output, "c079f6826f66954147e7b57e224fd3e2", "buffer_md5(), failed to return the correct value");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
    addFact("buffer_sha1_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the first half of the buffer with value "a", and the second with "b"
        var input = "a";
        buffer_fill(testBuffer, 0, buffer_text, input, 512);
        input = "b";
        buffer_fill(testBuffer, 256, buffer_text, input, 512);
        
        // Get a SHA-1 hash from the buffer, and check it has the correct value  
        output = buffer_sha1(testBuffer, 0, 512);
        assert_equals(output, "127ea4584777256b3b1ddcfb2395ff0b59f851c5", "buffer_sha1(), failed to return the correct value");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
    addFact("buffer_base64_encode_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the first half of the buffer with value "a", and the second with "b"
        var input = "a";
        buffer_fill(testBuffer, 0, buffer_text, input, 512);
        input = "b";
        buffer_fill(testBuffer, 256, buffer_text, input, 512);
        
        // convert the data from the buffer into base64 and check it has the correct value (using pre-baked string)
        var base64String = "YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmI=";
        output = buffer_base64_encode(testBuffer, 0, 512);
        assert_equals(output, base64String, "buffer_base64_encode(), failed to return the correct value");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
    addFact("buffer_base64_decode_test", function() {
        // Decode a pre-baked base64 string into a buffer
        var base64String = "YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmI=";
        var decodedBuffer = buffer_base64_decode(base64String);
        
        // Check that it was created succesfully, and contains the correct data
        var output = buffer_exists(decodedBuffer);
        assert_true(output, string("buffer_base64_decode(), failed to create a buffer"));
        output = buffer_get_size(decodedBuffer);
        assert_equals(output, 512, "buffer_base64_decode(), failed to decode the correct data (size check)");
        output = buffer_peek(decodedBuffer, 0, buffer_u8);
        assert_equals(output, ord("a"), "buffer_base64_decode(), failed to decode the correct data");
        output = buffer_peek(decodedBuffer, 255, buffer_u8);
        assert_equals(output, ord("a"), "buffer_base64_decode(), failed to decode the correct data");
        output = buffer_peek(decodedBuffer, 256, buffer_u8);
        assert_equals(output, ord("b"), "buffer_base64_decode(), failed to decode the correct data");
        output = buffer_peek(decodedBuffer, 511, buffer_u8);
        assert_equals(output, ord("b"), "buffer_base64_decode(), failed to decode the correct data");
        
        // Clean up
        buffer_delete(decodedBuffer);
    });
    
    addFact("buffer_base64_decode_ext_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
        
        // Decode a pre-baked base64 string into the created buffer, with an offset of 512
        var base64String = "YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmI=";
        buffer_base64_decode_ext(testBuffer, base64String, 512);
        
        // Check that the size of the buffer has increased
        output = buffer_get_size(testBuffer);
        assert_equals(output, 1024, "buffer_base64_decode_ext(), failed to resize output buffer");
        
        // Clean up
        buffer_delete(testBuffer);
    });
    
    addFact("buffer_compress_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the buffer with the value "a"
        buffer_fill(testBuffer, 0, buffer_text, "a", 512);
    
        // Compress the buffer and check that the compressed buffer exists
        var compressedBuffer = buffer_compress(testBuffer, 0, 512);
        output = buffer_exists(compressedBuffer);
        assert_true(output, "buffer_compress(), failed to create a new buffer");
        
        // Clean up
        buffer_delete(testBuffer);
        buffer_delete(compressedBuffer);
    });
    
    addFact("buffer_decompress_test", function() {
        // Create a buffer and check it has been created successfully
        var testBuffer = buffer_create(512, buffer_grow, 1);
        var output = buffer_exists(testBuffer);
        assert_true(output, string("buffer_exists(), failed to create a buffer"));
        if (!output) return;
            
        // Fill the buffer with the value "a"
        buffer_fill(testBuffer, 0, buffer_text, "a", 512);
        
        // Compress the buffer
        var compressedBuffer = buffer_compress(testBuffer, 0, 512);
        
        // Decompress the compressed buffer then check that the decompressed buffer exists & is the right size
        var decompressedBuffer = buffer_decompress(compressedBuffer);
        output = buffer_exists(decompressedBuffer);
        assert_true(output, "buffer_decompress(), failed to create a new buffer");
        output = buffer_get_size(decompressedBuffer);
        assert_equals(output, 512, "buffer_decompress(), failed to decompress the correct data (size check)");
        
        // Check that the data in the decompressed buffer matches the original uncompressed buffer
        var val1, val2, failed = false
        for (var i = 0; i < buffer_get_size(decompressedBuffer) && !failed; i++) {
            
            val1 = buffer_peek(testBuffer, i, buffer_u8);
            val2 = buffer_peek(decompressedBuffer, i, buffer_u8);
            failed = !assert_equals(val1, val2, string("buffer_decompress(), failed to decompress the correct data (pos: {0})", i));
        }	
        
        // Clean up
        buffer_delete(testBuffer);	
        buffer_delete(compressedBuffer);	
        buffer_delete(decompressedBuffer);
    });
    
    addFact("buffer_poke_test", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
        math_set_epsilon(0.01);
        
        // For all buffer data types, create a buffer, use buffer_poke to write data into it, then check that the seek position has not moved
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
        
            buffer_poke(testBuffer, 0, type, value);
            var output = buffer_tell(testBuffer);
            assert_equals(output, 0, "buffer_poke(), moved the buffer cursor (type: "+typeString+")");
        })
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
    });
    
	addFact("buffer_write_test #1", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
        math_set_epsilon(0.01);
        
        // For all buffer data types, create a buffer, write some data to it, then check that the data was correctly written
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
        
            buffer_write(testBuffer, type, value);
            var output = buffer_peek(testBuffer, 0, type);
            assert_equals(output, value, "buffer_write/peek(), failed to write/peek the correct value (type: "+typeString+")");
        });
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
    });
    
    addFact("buffer_write_test #2", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
        math_set_epsilon(0.01);
        
        // For all buffer data types, create a buffer, write some data to it, then check that the seek position has moved to the correct position
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
            
            buffer_write(testBuffer, type, value);
            var pos = 0;
            // For text type the size depends on the string/text size.
            if (type == buffer_string) {
                pos = string_length(value) + 1; // + terminator char
            }
            else if (type == buffer_text) {
                pos =  string_length(value);
            }
            else {
                pos =  typeSize;
            }
            var output = buffer_tell(testBuffer);
            assert_equals(output, pos, "buffer_write(), failed to move buffer cursor after write (type: "+typeString+")");
            
        });
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
    });
    
    addFact("buffer_read_test #1", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
        math_set_epsilon(0.01);
        
        // For all buffer data types, create a buffer, write some data to it, then read it and check that it is read correctly
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
        
            buffer_write(testBuffer, type, value);
            buffer_seek(testBuffer, buffer_seek_start, 0)
            var output = buffer_read(testBuffer, type);
            assert_equals(output, value, "buffer_read(), failed to read the correct value (type: "+typeString+")");
        });
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
    });
    
    addFact("buffer_read_test #2", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
        math_set_epsilon(0.01);
        
        // For all buffer data types, create a buffer, write some data to it, read it, then check that the seek position has moved to the correct place
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
        
            buffer_write(testBuffer, type, value);
            buffer_seek(testBuffer, buffer_seek_start, 0)
            var pos = 0;
            // For text type the size depends on the string/text size.
            if (type == buffer_string) {
                pos = string_length(value) + 1; // + terminator char
            }
            else if (type == buffer_text) {
                pos =  string_length(value);
            }
            else {
                pos =  typeSize;
            }
            buffer_read(testBuffer, type);
            var output = buffer_tell(testBuffer);
            assert_equals(output, pos, "buffer_read(), failed to move buffer cursor after read (type: "+typeString+")");
            
        });
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
    });

	addFact("buffer_sizeof_test", function() {
        // Set lower epsilon value to ensure rounding errors don't interfere with test results
		math_set_epsilon(0.01);
			
        // For all buffer data types, create a buffer, then check that the size of the buffer is correct for the type of data
        RunForAllBufferDataTypes (function(testBuffer, type, value, typeString, typeSize) {
				
			var output = buffer_sizeof(type);
			assert_equals(output, typeSize, "buffer_sizeof(), failed to detect the correct size for type (type: "+typeString+")");
		});
        
        // Reset to default epsilon value
        math_set_epsilon(0.00001);
	})

	addFact("buffer_get_surface_test", function() {
        // Create a buffer and a surface
		var testBuffer = buffer_create(1, buffer_grow, 1);
		var testSurface = surface_create(1024, 1024);
			
        // Write the surface to the buffer, then check that it has the correct size
		buffer_get_surface(testBuffer, testSurface, 0);
		var output = buffer_get_size(testBuffer);
		assert_equals(output, 4194304, "buffer_get_surface(), failed to load surface into buffer (size is incorrect)");
        
        // Clean up
        buffer_delete(testBuffer);
        surface_free(testSurface);
	});
    
    addFact("buffer_set_surface_test", function() {
        // Create a buffer and a surface
        var testBuffer = buffer_create(4194304, buffer_grow, 1);
        var testSurface = surface_create(512, 512);
        
        // Fill the buffer with 8-bit integers with a value of 255, which should translate as white pixels when written to a surface
        buffer_fill(testBuffer, 0, buffer_u8, 255, 4194304);
        
        // Write the buffer to the surface, then check that the pixel at 0,0 is white
        buffer_set_surface(testBuffer, testSurface, 0);
        var output = surface_getpixel(testSurface, 0, 0);
        assert_equals(output, c_white, "buffer_set_surface(), failed to set surface from buffer (pixel data at 0,0 is incorrect)");
        
        // Clean up
        buffer_delete(testBuffer);
        surface_free(testSurface);
        
    });
    
    addFact("buffer_create_from_vertex_buffer_test", function() {
        // Create vertex format and vertex buffer
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_colour();
        vertex_format_add_texcoord();
        var vertexFormat = vertex_format_end();
        var vertexBuffer = vertex_create_buffer();
        
        // Add a vertex to the vertex buffer, using the defined vertex format
        vertex_begin(vertexBuffer, vertexFormat);
        vertex_position_3d(vertexBuffer, 0, 0, 0);
        vertex_normal(vertexBuffer, 0, 0, 0);
        vertex_colour(vertexBuffer, 0, 1);
        vertex_texcoord(vertexBuffer, 0, 1 - 0);
        vertex_end(vertexBuffer);
        
        // Create a buffer from the vertex buffer, then check that it exists
        var createdBuffer = buffer_create_from_vertex_buffer(vertexBuffer, buffer_grow, 1);
        var output = buffer_exists(createdBuffer);
        assert_true(output, "buffer_create_from_vertex_buffer(), failed to create buffer");
        
        // Clean up
        buffer_delete(createdBuffer);
        vertex_delete_buffer(vertexBuffer);
        vertex_format_delete(vertexFormat);
        
    });
    
    addFact("buffer_create_from_vertex_buffer_ext_test", function() {
        // Create vertex format and vertex buffer
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_colour();
        vertex_format_add_texcoord();
        var vertexFormat = vertex_format_end();
        var vertexBuffer = vertex_create_buffer();
        
        // Add a vertex to the vertex buffer, using the defined vertex format
        vertex_begin(vertexBuffer, vertexFormat);
        vertex_position_3d(vertexBuffer, 0, 0, 0);
        vertex_normal(vertexBuffer, 0, 0, 0);
        vertex_colour(vertexBuffer, 0, 1);
        vertex_texcoord(vertexBuffer, 0, 1 - 0);
        vertex_end(vertexBuffer);
        
        // Create a buffer from the vertex buffer, then check that it exists
        var createdExtBuffer = buffer_create_from_vertex_buffer_ext(vertexBuffer, buffer_grow, 1, 0, vertex_get_number(vertexBuffer));
        var output = buffer_exists(createdExtBuffer);
        assert_true(output, "buffer_create_from_vertex_buffer_ext(), failed to create buffer");
        
        // Clean up
        buffer_delete(createdExtBuffer);
        vertex_delete_buffer(vertexBuffer);
        vertex_format_delete(vertexFormat);
    });
    
    addFact("buffer_copy_from_vertex_buffer_test", function() {
        // Create vertex format and vertex buffer
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_normal();
        vertex_format_add_colour();
        vertex_format_add_texcoord();
        var vertexFormat = vertex_format_end();
        var vertexBuffer = vertex_create_buffer();
        
        // Add a vertex to the vertex buffer, using the defined vertex format
        vertex_begin(vertexBuffer, vertexFormat);
        vertex_position_3d(vertexBuffer, 0, 0, 0);
        vertex_normal(vertexBuffer, 0, 0, 0);
        vertex_colour(vertexBuffer, 0, 1);
        vertex_texcoord(vertexBuffer, 0, 1 - 0);
        vertex_end(vertexBuffer);
        
        // Create a buffer and copy the data from the vertex buffer into it, then check that the size has changed
        var copiedBuffer = buffer_create(1, buffer_grow, 1);
        buffer_copy_from_vertex_buffer(vertexBuffer, 0, vertex_get_number(vertexBuffer), copiedBuffer, 0);
        var output = buffer_get_size(copiedBuffer);
        assert_not_equals(output, 1, "buffer_copy_from_vertex_buffer(), failed to copy data into buffer (buffer didn't resize)");
        
        // Clean up
        buffer_delete(copiedBuffer);
        vertex_delete_buffer(vertexBuffer);
        vertex_format_delete(vertexFormat);
    });
    
    addFact("buffer_save_test", function() {
        // Create a buffer and fill half of it with 8-bit integers with a value of 10
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        
        // Save the buffer to a file called "Buffer.sav", then check that the file exists
        buffer_save(testBuffer, "Buffer.sav");
        var output = file_exists("Buffer.sav");
        assert_true(output, "buffer_save(), failed to create the file");
        
        // Clean up
        file_delete("Buffer.sav");
        buffer_delete(testBuffer);
        
    }, { test_filter: platform_not_console });
    
    addFact("buffer_save_ext_test", function() {
        // Create a buffer and fill the second half of it with 8-bit integers with a value of 10
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        
        // Save the second half of the buffer to a file called "BufferExt.sav", then check that the file exists
        buffer_save_ext(testBuffer, "BufferExt.sav", 256, 512);
        var output = file_exists("BufferExt.sav");
        assert_true(output, "buffer_save_ext(), failed to create the file");
        
        // Clean up
        file_delete("BufferExt.sav");
        buffer_delete(testBuffer);
        
    }, { test_filter: platform_not_console });
    
    addFact("buffer_load_test #1", function() {
        // Create a buffer, fill the second half of it with 8-bit integers with a value of 10, and save it to a file called "Buffer.sav"
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        buffer_save(testBuffer, "Buffer.sav");
        
        // Load the buffer from the file and check that the loaded buffer exists, and has the correct size & data
        var loadedBuffer = buffer_load("Buffer.sav");
        var output = buffer_exists(loadedBuffer);
        assert_true(output, "buffer_load(), failed to create the buffer");
        output = buffer_get_size(loadedBuffer);
        assert_equals(output, 512, "buffer_load(), loaded buffer size doesn't match (after buffer_save)");
        output = buffer_peek(loadedBuffer, 256, buffer_u8);
        assert_equals(output, 10, "buffer_load(), loaded buffer data doesn't match (after buffer_save)");
        
        // Clean up
        file_delete("Buffer.sav");
        buffer_delete(testBuffer);
        buffer_delete(loadedBuffer);
        
    }, { test_filter: platform_not_console });
    
    addFact("buffer_load_test #2", function() {
        // Create a buffer, fill the second half of it with 8-bit integers with a value of 10, and save that half to a file called "BufferExt.sav"
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        buffer_save_ext(testBuffer, "BufferExt.sav", 256, 512);
        
        // Load the buffer from the file and check that the loaded buffer exists, and has the correct size & data
        var loadedBuffer = buffer_load("BufferExt.sav");
        var output = buffer_exists(loadedBuffer);
        assert_true(output, "buffer_load(), failed to create the buffer");
        var output = buffer_get_size(loadedBuffer);
        assert_equals(output, 256, "buffer_load(), loaded buffer size doesn't match (after buffer_save_ext)");
        output = buffer_peek(loadedBuffer, 0, buffer_u8);
        assert_equals(output, 10, "buffer_load(), loaded buffer data doesn't match (after buffer_save_ext)");
        
        // Clean up
        file_delete("BufferExt.sav");
        buffer_delete(testBuffer);
        buffer_delete(loadedBuffer);
        
    }, { test_filter: platform_not_console });
    
    addFact("buffer_load_ext_test", function() {
        // Create a buffer, fill the second half of it with 8-bit integers with a value of 10, and save it to a file called "Buffer.sav"
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        buffer_save(testBuffer, "Buffer.sav");
        
        //Create another buffer and load the file into it with an offset of 256 bytes, then check that its size & data are correct
        var loadedBuffer = buffer_create(1, buffer_grow, 1);
        buffer_load_ext(loadedBuffer, "Buffer.sav", 256);
        var output = buffer_get_size(loadedBuffer);
        assert_equals(output, 768, "buffer_load_ext(), loaded buffer size doesn't match");
        output = buffer_peek(loadedBuffer, 512, buffer_u8);
        assert_equals(output, 10, "buffer_load_ext(), loaded buffer data doesn't match");
        
        // Clean up
        file_delete("Buffer.sav");
        buffer_delete(testBuffer);
        buffer_delete(loadedBuffer);
        
    }, { test_filter: platform_not_console });
    
    addFact("buffer_load_partial_test", function() {
        // Create a buffer, fill the second half of it with 8-bit integers with a value of 10, and save it to a file called "Buffer.sav"
        var testBuffer = buffer_create(512, buffer_grow, 1);
        buffer_fill(testBuffer, 256, buffer_u8, 10, 512);
        buffer_save(testBuffer, "Buffer.sav");
        
        // Create another buffer and load the file into it, with an offset of 256 bytes, then check that its size & data are correct
        var loadedBuffer = buffer_create(1, buffer_grow, 1);
        buffer_load_partial(loadedBuffer, "Buffer.sav", 0, 512, 256);
        var output = buffer_get_size(loadedBuffer);
        assert_equals(output, 512 + 256, "buffer_load_partial(), loaded buffer size doesn't match");
        output = buffer_peek(loadedBuffer, 512, buffer_u8);
        assert_equals(output, 10, "buffer_load_partial(), loaded buffer data doesn't match");
        
        // Clean up
        file_delete("Buffer.sav");
        buffer_delete(testBuffer);
        buffer_delete(loadedBuffer);
        
    }, { test_filter: platform_not_console });

	// #### ASYNC ####

	addTestAsync("buffer_save_async_test", objTestAsyncSaveLoad, {
			
		ev_create: function() {
			
            // Create a buffer and fill it with the value "a"
			var bufferID = buffer_create(1024, buffer_grow, 1);
			buffer_fill(bufferID, 0, buffer_text, "a", 1024);
			
            // Save the buffer asynchronously to the file "AsyncBuffer.sav" and delete the buffer
			requestID = buffer_save_async(bufferID, "AsyncBuffer.sav", 0, 1024);
			buffer_delete(bufferID);
			
		},
			
		ev_async_save_load: function() {
            
            // Check if the load event matches the ID returned by buffer_save_async, and if it does, check if it's status is true
			var _asyncLoad = async_load;
			if (_asyncLoad[? "id"] != requestID) exit;
			assert_true(_asyncLoad[? "status"], "buffer_save_async(), fail to save the file");
				
            // Clean up & end test
			file_delete("AsyncBuffer.sav");
			test_end();
		},
		
	}, { test_filter: platform_not_console, test_timeout_millis: 3000 });
		
	addTestAsync("buffer_save_async_group_test", objTestAsyncSaveLoad, {
			
		ev_create: function() { 
            
            // Create a buffer and fill it with the value "a"
			var bufferID = buffer_create(1024, buffer_grow, 1);
			buffer_fill(bufferID, 0, buffer_text, "a", 1024);
			
            // Start a buffer group and set various platform-specific options
			buffer_async_group_begin("Test");
			buffer_async_group_option("subtitle","Test");
			buffer_async_group_option("showdialog", false);
			buffer_async_group_option("savepadindex", 1);
			buffer_async_group_option("saveslotsize", buffer_seek(bufferID, buffer_seek_end, 0));
            
            // save the buffer asynchronusly with those options to the file "AsyncBuffer.sav", end the group, then delete the buffer
			buffer_save_async(bufferID, "AsyncBuffer.sav", 0, 1024);
			requestID = buffer_async_group_end();
			buffer_delete(bufferID);
			
		},
			
		ev_async_save_load: function() {
				
            // Check if the load event matches the ID returned by buffer_save_async, and if it does, check if it's status is true
			var _asyncLoad = async_load;
			if (_asyncLoad[? "id"] != requestID) exit;
			assert_true(_asyncLoad[? "status"], "buffer_async_group_begin/end(), fail to save the file");
				
            // Clean up & end test
			file_delete("asyncBuffer.sav");
			test_end();
		}
			
    }, { test_filter: platform_not_console, test_timeout_millis: 3000 });
		
	addTestAsync("buffer_load_async_test", objTestAsyncSaveLoad, {
			
		ev_create: function() {
			
            // Create a buffer and fill it with the value "a"
			bufferID = buffer_create(1024, buffer_grow, 1);
			buffer_fill(bufferID, 0, buffer_text, "a", 1024);
            
            // Save it to the file "AsyncBuffer.sav", then load it asynchronusly
			buffer_save(bufferID, "AsyncBuffer.sav");
			requestID = buffer_load_async(bufferID, "AsyncBuffer.sav", 0, 1024);
			
		},
			
		ev_async_save_load: function() {
				
            // Check if the load event matches the ID returned by buffer_load_async, and if it does, check if it's status is true
			var _asyncLoad = async_load;
			if (_asyncLoad[? "id"] != requestID) exit;
			assert_true(_asyncLoad[? "status"], "buffer_load_async(), fail to load the file");
				
            // Clean up & end test
			file_delete("asyncBuffer.sav");
			buffer_delete(bufferID);
			test_end();
		}
			
    }, { test_filter: platform_not_console, test_timeout_millis: 3000 });
		
	config({
		suite_filter: platform_not_browser
	})
		
}