function BasicBufferTestSuite() : TestSuite() constructor {

		// SHOULD NOT BE HERE!!!
		addFact("base64_test", function() {

			// Base64 Test
			
			#macro kHelloWorld_Base64Test "Hello World!"
			
			var b64HelloWorld = base64_encode(kHelloWorld_Base64Test);
			assert_equals(b64HelloWorld, "SGVsbG8gV29ybGQh", "#1 \"Hello World!\" in base64 == \"SGVsbG8gV29ybGQh\"");
			
			var asciiHelloWorld = base64_decode(b64HelloWorld);
			assert_equals(asciiHelloWorld, kHelloWorld_Base64Test, "#2 asciiHelloWorld == kHelloWorld_Base64Test");
			
			// Big macro string
			
			#macro kBigLorem_Base64Test "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed massa magna, sagittis varius vestibulum scelerisque, vehicula interdum sem. Integer id mauris id ex elementum ultrices. In a lectus mauris. In mollis ornare blandit. Etiam sollicitudin mauris eget massa posuere sagittis. Nullam vel quam a nunc tempor accumsan eget sed magna. Nam ut lacus ut diam varius vestibulum vitae in lacus. Nulla nunc lorem, accumsan quis placerat sed, elementum vitae sapien. Nam efficitur tortor sem, ac vehicula dui tincidunt ut. Pellentesque in facilisis massa, a fringilla ipsum. Ut volutpat dui metus, ac bibendum nunc vulputate eu. Integer eget turpis facilisis, congue quam id, posuere augue."
			
			#macro kb64BigLorem_Base64Test "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gU2VkIG1hc3NhIG1hZ25hLCBzYWdpdHRpcyB2YXJpdXMgdmVzdGlidWx1bSBzY2VsZXJpc3F1ZSwgdmVoaWN1bGEgaW50ZXJkdW0gc2VtLiBJbnRlZ2VyIGlkIG1hdXJpcyBpZCBleCBlbGVtZW50dW0gdWx0cmljZXMuIEluIGEgbGVjdHVzIG1hdXJpcy4gSW4gbW9sbGlzIG9ybmFyZSBibGFuZGl0LiBFdGlhbSBzb2xsaWNpdHVkaW4gbWF1cmlzIGVnZXQgbWFzc2EgcG9zdWVyZSBzYWdpdHRpcy4gTnVsbGFtIHZlbCBxdWFtIGEgbnVuYyB0ZW1wb3IgYWNjdW1zYW4gZWdldCBzZWQgbWFnbmEuIE5hbSB1dCBsYWN1cyB1dCBkaWFtIHZhcml1cyB2ZXN0aWJ1bHVtIHZpdGFlIGluIGxhY3VzLiBOdWxsYSBudW5jIGxvcmVtLCBhY2N1bXNhbiBxdWlzIHBsYWNlcmF0IHNlZCwgZWxlbWVudHVtIHZpdGFlIHNhcGllbi4gTmFtIGVmZmljaXR1ciB0b3J0b3Igc2VtLCBhYyB2ZWhpY3VsYSBkdWkgdGluY2lkdW50IHV0LiBQZWxsZW50ZXNxdWUgaW4gZmFjaWxpc2lzIG1hc3NhLCBhIGZyaW5naWxsYSBpcHN1bS4gVXQgdm9sdXRwYXQgZHVpIG1ldHVzLCBhYyBiaWJlbmR1bSBudW5jIHZ1bHB1dGF0ZSBldS4gSW50ZWdlciBlZ2V0IHR1cnBpcyBmYWNpbGlzaXMsIGNvbmd1ZSBxdWFtIGlkLCBwb3N1ZXJlIGF1Z3VlLg=="
			
			var b64BigLorem = base64_encode(kBigLorem_Base64Test);
			assert_equals(b64BigLorem, kb64BigLorem_Base64Test, "#3 The kBigLorem_Base64Test in base64 == kb64BigLorem_Base64Test")
			
			// Translate immediately back
			
			var asciiBigLorem = base64_decode(b64BigLorem);
			assert_equals(asciiBigLorem, kBigLorem_Base64Test, "#4 Translating b64BigLorem back should be the original kBigLorem_Base64Test");
			
			// Translate pre-prepared macro
			asciiBigLorem = "";
			asciiBigLorem = base64_decode(kb64BigLorem_Base64Test);
			assert_equals(asciiBigLorem, kBigLorem_Base64Test, "#5 Translating kb64BigLorem_Base64Test should equal kBigLorem_Base64Test");
			
			// Decode first
			
			#macro kb64Lyrics_Base64Test "bm93IHRoaXMgaXMgYSBzdG9yeSBhbGwgYWJvdXQgaG93IG15IGxpZmUgZ290IGZsaXBwZWQgdHVybmVkIHVwc2lkZSBkb3duIGFuZCBJJ2QgbGlrZSB0byB0YWtlIGEgbWludXRlIGp1c3Qgc2l0IHJpZ2h0IHRoZXJlIEknbGwgdGVsbCB5b3UgaG93IEkgYmVjb21lIHRoZSBwcmluY2Ugb2YgYSB0b3duIGNhbGxlZCBCZWwgQWly"
			#macro kLyrics_Base64Test "now this is a story all about how my life got flipped turned upside down and I'd like to take a minute just sit right there I'll tell you how I become the prince of a town called Bel Air"
			
			var lyrics = base64_decode(kb64Lyrics_Base64Test);
			assert_equals(lyrics, kLyrics_Base64Test, "#6 Translating from base64 first without ever encoding kLyrics_Base64Test into base64.");
			
			// Variables, no macros 
			
			var sBigString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet est placerat in egestas erat imperdiet sed euismod nisi. Orci porta non pulvinar neque. Turpis massa sed elementum tempus egestas. Habitasse platea dictumst vestibulum rhoncus est pellentesque. Tellus orci ac auctor augue mauris augue neque gravida in. Vel quam elementum pulvinar etiam non quam. Proin sagittis nisl rhoncus mattis rhoncus. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Elit ut aliquam purus sit amet luctus. Ornare arcu odio ut sem nulla pharetra diam. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant.";
			var sB64BigString = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdCwgc2VkIGRvIGVpdXNtb2QgdGVtcG9yIGluY2lkaWR1bnQgdXQgbGFib3JlIGV0IGRvbG9yZSBtYWduYSBhbGlxdWEuIEFtZXQgZXN0IHBsYWNlcmF0IGluIGVnZXN0YXMgZXJhdCBpbXBlcmRpZXQgc2VkIGV1aXNtb2QgbmlzaS4gT3JjaSBwb3J0YSBub24gcHVsdmluYXIgbmVxdWUuIFR1cnBpcyBtYXNzYSBzZWQgZWxlbWVudHVtIHRlbXB1cyBlZ2VzdGFzLiBIYWJpdGFzc2UgcGxhdGVhIGRpY3R1bXN0IHZlc3RpYnVsdW0gcmhvbmN1cyBlc3QgcGVsbGVudGVzcXVlLiBUZWxsdXMgb3JjaSBhYyBhdWN0b3IgYXVndWUgbWF1cmlzIGF1Z3VlIG5lcXVlIGdyYXZpZGEgaW4uIFZlbCBxdWFtIGVsZW1lbnR1bSBwdWx2aW5hciBldGlhbSBub24gcXVhbS4gUHJvaW4gc2FnaXR0aXMgbmlzbCByaG9uY3VzIG1hdHRpcyByaG9uY3VzLiBQaGFyZXRyYSBtYWduYSBhYyBwbGFjZXJhdCB2ZXN0aWJ1bHVtIGxlY3R1cyBtYXVyaXMgdWx0cmljZXMgZXJvcyBpbi4gRWxpdCB1dCBhbGlxdWFtIHB1cnVzIHNpdCBhbWV0IGx1Y3R1cy4gT3JuYXJlIGFyY3Ugb2RpbyB1dCBzZW0gbnVsbGEgcGhhcmV0cmEgZGlhbS4gVmVsaXQgc2VkIHVsbGFtY29ycGVyIG1vcmJpIHRpbmNpZHVudCBvcm5hcmUgbWFzc2EgZWdldCBlZ2VzdGFzLiBSaG9uY3VzIGFlbmVhbiB2ZWwgZWxpdCBzY2VsZXJpc3F1ZSBtYXVyaXMgcGVsbGVudGVzcXVlIHB1bHZpbmFyIHBlbGxlbnRlc3F1ZSBoYWJpdGFudC4=";
			
			var b64BigStr = base64_encode(sBigString);
			var bigStr = base64_decode(sB64BigString);
			
			assert_equals(b64BigStr, sB64BigString, "#7 The two encoded strings should be equal");
			assert_equals(bigStr, sBigString, "#8 The two decoded strings should be equal");
			
			// Intrinsic
			
			var b64HW = base64_encode("Hello World!");
			assert_equals(b64HW, "SGVsbG8gV29ybGQh", "#9 b64HW should equal SGVsbG8gV29ybGQh")
			
			var hw = base64_decode("SGVsbG8gV29ybGQh");
			assert_equals(hw, "Hello World!", "#10 hw should equal Hello World!");
			
			// Small strings
			
			var singleChar = "a";
			var b64SingleChar = base64_encode(singleChar);
			assert_equals(b64SingleChar, "YQ==", "#11 a in base64 should be YQ==");
			
			var twoChars = "Aa";
			var b64TwoChars = base64_encode(twoChars);
			assert_equals(b64TwoChars, "QWE=", "#12 a in base64 should be QWE=");
			
			var threeChars = "AaB";
			var b64ThreeChars = base64_encode(threeChars);
			assert_equals(b64ThreeChars, "QWFC", "#13 a in base64 should be QWFC");
			
			var fourChars = "AaBb";
			var b64FourChars = base64_encode(fourChars);
			assert_equals(b64FourChars, "QWFCYg==", "#14 a in base64 should be QWFCYg==");
			
			//show_debug_message("End Base64 Tests");
		})

		addFact("buffer_general_type_test", function() {
		
			var _testBuffer, input, _output, iSize, _iType, iAlignment;
			
			var iTypeData = [
				[ buffer_fixed, "buffer_fixed" ],
				[ buffer_grow,  "buffer_grow" ],
				[ buffer_wrap,  "buffer_wrap" ],
				[ buffer_fast,  "buffer_fast" ],
				[ buffer_vbuffer, "buffer_vbuffer" ]
			];
			
			for (var i = 0; i < array_length(iTypeData); i++) {
			
				_iType = iTypeData[i][0];
				var iTypeString = iTypeData[i][1];

				iSize = power(2, choose(6, 7, 8, 9, 12));
				iAlignment = choose(1, 2, 4, 8);			
				_testBuffer = buffer_create(iSize, _iType, iAlignment);

				_output = buffer_exists(_testBuffer);
				assert_true(_output, string("#1.1 buffer_exists({0}, {1}, {2}), failed to create a buffer", iSize, iTypeString, iAlignment));
				
				// Early exit if we don't have a buffer to work with
				if (!_output) continue;
			
				_output = buffer_get_type(_testBuffer);
				assert_equals(_output, _iType, string("#1.2 buffer_get_type({0}, {1}, {2}), failed to identify correct type", iSize, iTypeString, iAlignment));
			
				_output = buffer_get_alignment(_testBuffer);
				assert_equals(_output, iAlignment, string("#1.3 buffer_get_alignment({0}, {1}, {2}), failed to identify correct alignment", iSize, iTypeString, iAlignment));
			
				_output = buffer_get_size(_testBuffer);
				assert_equals(_output, iSize, string("#1.4 buffer_get_size({0}, {1}, {2}), failed to identify correct size", iSize, iTypeString, iAlignment));

				_output = buffer_get_address(_testBuffer);
				assert_not_equals(_output, pointer_invalid, string("#1.5 buffer_get_address(), failed to return a valid address (type: {0})", iTypeString));

				_output = buffer_tell(_testBuffer);
				assert_equals(_output, 0, string("#1.6 buffer_tell(), failed to return correct value ({0}, {1}, {2})", iSize, iTypeString, iAlignment));
				
				input = irandom(iSize);
				buffer_seek(_testBuffer, buffer_seek_start, input);
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, input, string("#1.7 buffer_seek(buffer_seek_start), failed to return correct value (size: {0}, offset: {1})", iSize, input));
								
				input = irandom(iSize);
				buffer_seek(_testBuffer, buffer_seek_end, input);
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, iSize-input, string("#1.8 buffer_seek(buffer_seek_end), failed to return correct value (size: {0}, offset: {1})", iSize, input));
				
				buffer_seek(_testBuffer, buffer_seek_start, iSize/2); // Place in the middle of the buffer
				
				input = irandom_range(-iSize/2, iSize/2);
				buffer_seek(_testBuffer, buffer_seek_relative, input);
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, (iSize/2) + input, string("#1.9 buffer_seek(buffer_seek_relative), failed to return correct value (size: {0}, offset-middle: {1})", iSize, input));
				
				input = power(2, choose(6, 7, 8, 9, 12));
				buffer_resize(_testBuffer, input);
				_output = buffer_get_size(_testBuffer)
				assert_equals(_output, input, string("#1.10 buffer_resize(), failed to return correct value (type: {0})", iTypeString));
				
				buffer_delete(_testBuffer);
				_output = buffer_exists(_testBuffer);
				assert_false(_output, string("#1.11 buffer_delete(), failed to delete a buffer (type: {0})", iTypeString));
			}

		})

		addFact("buffer_crc32_test", function() {

			// Check crc32
			var _output, _testBuffer = buffer_create(256, buffer_grow, 1);
			for(var i = 0; i < 256; ++i) buffer_write( _testBuffer, buffer_u8, i);
			
			_output = buffer_crc32(_testBuffer, 32, 64);
			assert_equals(_output, 0xE809C6C8, "#1.0 buffer_crc32");
			
			buffer_delete(_testBuffer);
		})

		addFact("buffer_encoding_test", function() {
	
			var input, _output, _testBuffer;
			
			_testBuffer = buffer_create(512, buffer_grow, 1);
			
			_output = buffer_exists(_testBuffer);
			assert_true(_output, string("#1 buffer_exists(), failed to create a buffer"));

			// Early exit if we don't have a buffer to work with.
			if (!_output) return;
			
			// Fill the entire buffer with value "a"
			input = "a";
			buffer_fill(_testBuffer, 0, buffer_text, input, 512);
			_output = buffer_peek(_testBuffer, 0, buffer_u8);
			assert_equals(_output, ord(input), "#2.1 buffer_fill(), failed to fill the entire buffer (start)");
			_output = buffer_peek(_testBuffer, 511, buffer_u8);
			assert_equals(_output, ord(input), "#2.2 buffer_fill(), failed to fill the entire buffer (end)");
			
			// Fill the buffer with "b" from middle to end
			input = "b";
			buffer_fill(_testBuffer, 256, buffer_text, input, 512);
			_output = buffer_peek(_testBuffer, 256, buffer_u8);
			assert_equals(_output, ord(input), "#3.1 buffer_fill(), failed to fill the entire buffer, using offset (offset)");
			_output = buffer_peek(_testBuffer, 511, buffer_u8);
			assert_equals(_output, ord(input), "#3.2 buffer_fill(), failed to fill the entire buffer, using offset (end)");
			
			// Check md5
			_output = buffer_md5(_testBuffer, 0, 512);
			assert_equals(_output, "c079f6826f66954147e7b57e224fd3e2", "#4 buffer_md5(), failed to return the correct value");
			
			// Check sha1
			_output = buffer_sha1(_testBuffer, 0, 512);
			assert_equals(_output, "127ea4584777256b3b1ddcfb2395ff0b59f851c5", "#5 buffer_sha1(), failed to return the correct value");
			
			// Check base64 encode - decode (using pre-baked string)
			var base64String = "YWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWFhYWJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmJiYmI=";

			_output = buffer_base64_encode(_testBuffer, 0, 512);
			assert_equals(_output, base64String, "#6 buffer_base64_encode(), failed to return the correct value");

			var _decodedBuffer = buffer_base64_decode(base64String);
			
			_output = buffer_exists(_decodedBuffer);
			assert_true(_output, string("#7 buffer_base64_decode(), failed to create a buffer"));

			_output = buffer_get_size(_decodedBuffer);
			assert_equals(_output, 512, "#8.4 buffer_base64_decode(), failed to decode the correct data (size check)");
			_output = buffer_peek(_decodedBuffer, 0, buffer_u8);
			assert_equals(_output, ord("a"), "#8.1 buffer_base64_decode(), failed to decode the correct data");
			_output = buffer_peek(_decodedBuffer, 255, buffer_u8);
			assert_equals(_output, ord("a"), "#8.2 buffer_base64_decode(), failed to decode the correct data");
			_output = buffer_peek(_decodedBuffer, 256, buffer_u8);
			assert_equals(_output, ord("b"), "#8.3 buffer_base64_decode(), failed to decode the correct data");
			_output = buffer_peek(_decodedBuffer, 511, buffer_u8);
			assert_equals(_output, ord("b"), "#8.4 buffer_base64_decode(), failed to decode the correct data");
			buffer_delete(_decodedBuffer);
			
			buffer_base64_decode_ext(_testBuffer, base64String, 512);
			
			_output = buffer_get_size(_testBuffer);
			assert_equals(_output, 1024, "#8 buffer_base64_decode_ext(), failed to resize output buffer");
			
			// Check buffer compression 
			var compressedBuffer = buffer_compress(_testBuffer, 0, 768);
			
			_output = buffer_exists(compressedBuffer);
			assert_true(_output, "#9 buffer_compress(), failed to create a new buffer");
			
			var decompressedBuffer = buffer_decompress(compressedBuffer);
			buffer_delete(compressedBuffer);
			
			_output = buffer_exists(decompressedBuffer);
			assert_true(_output, "#10 buffer_decompress(), failed to create a new buffer");
			
			_output = buffer_get_size(decompressedBuffer);
			assert_equals(_output, 768, "#11 buffer_decompress(), failed to decompress the correct data (size check)");
			
			// Validate original buffer
			var val1, val2, failed = false
			for (var i = 0; i < buffer_get_size(decompressedBuffer) && !failed; i++) {
			
				val1 = buffer_peek(_testBuffer, i, buffer_u8);
				val2 = buffer_peek(decompressedBuffer, i, buffer_u8);
				failed = !assert_equals(val1, val2, string("#12 buffer_decompress(), failed to decompress the correct data (pos: {0})", i));
			}			
			
			// Clean (and check buffer delete)
			buffer_delete(decompressedBuffer);
			buffer_delete(_testBuffer);
			_output = buffer_exists(decompressedBuffer);
			assert_false(_output, "#13 buffer_delete(), failed to delete the buffer");
			
		})

		addFact("buffer_position_test", function() {

			//SB: buffer_poke, buffer_peek, buffer_read, buffer_write
			math_set_epsilon(0.01);
			
			var input, _output, _testBuffer = buffer_create(1, buffer_grow, 1);
			
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

			var pos = 0, dataLength = array_length(data);
			for (var i = 0; i < dataLength; i++) {
				
				var current = data[i];
				
				var type = current[0];
				var value = current[1];
				var typeSize = buffer_sizeof(type);
				
				
				if (platform_browser() && type == buffer_f16) continue;
				
				buffer_poke(_testBuffer, pos, type, value);
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, pos, "#1 buffer_poke(), moved the buffer cursor (type: "+current[2]+")");
				
				buffer_write(_testBuffer, type, value);
				_output = buffer_peek(_testBuffer, pos, type);
				assert_equals(_output, value, "#2 buffer_write/peek(), failed to write/peek the correct value (type: "+current[2]+")");
				
				// For text type the size depends on the string/text size.
				if (type == buffer_string) {
					pos += string_length(value) + 1; // + terminator char
				}
				if (type == buffer_text) {
					pos += string_length(value);
				}
				else {
					pos += typeSize;
				}
				
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, pos, "#3 buffer_write(), failed to move buffer cursor after write (type: "+current[2]+")");
				
			}
			
			buffer_seek(_testBuffer, buffer_seek_start, 0);
			
			pos = 0;
			for (var i = 0; i < dataLength; i++) {
				
				var current = data[i];
				
				var type = current[0];
				var value = current[1];
				var typeSize = buffer_sizeof(type);
				
				_output = buffer_read(_testBuffer, type);
				assert_equals(_output, value, "#4 buffer_read(), failed to read the correct value (type: "+current[2]+")");
				
				// For text type the size depends on the string/text size.
				if (type == buffer_string) {
					pos += string_length(value) + 1; // + terminator char
				}
				if (type == buffer_text) {
					pos += string_length(value);
				}
				else {
					pos += typeSize;
				}
				
				_output = buffer_tell(_testBuffer);
				assert_equals(_output, pos, "#3 buffer_read(), failed to move buffer cursor after read (type: "+current[2]+")");
				
			}
			
			buffer_delete(_testBuffer);
			
		})

		addFact("buffer_sizeof_test", function() {

			//SB: buffer_write, buffer_read, buffer_sizeof, buffer_u8, buffer_s8, buffer_u16, buffer_s16, buffer_u32, buffer_s32, buffer_u64, buffer_f16, buffer_f32, buffer_f64, buffer_bool, buffer_text, buffer_string
			
			math_set_epsilon(0.01);
			
			var input, _output;
			
			var data = [
				[ buffer_bool, 1, "buffer_bool" ],
				
				[ buffer_u8, 1, "buffer_u8" ],
				[ buffer_u16, 2, "buffer_u16" ],
				[ buffer_u32, 4, "buffer_u32" ],
				[ buffer_u64, 8, "buffer_u64" ],
				
				[ buffer_s8, 1, "buffer_s8" ],
				[ buffer_s16, 2, "buffer_s16" ],
				[ buffer_s32, 4, "buffer_s32" ],
				
				[ buffer_f16, 2, "buffer_f16" ],
				[ buffer_f32, 4, "buffer_f32" ],
				[ buffer_f64, 8, "buffer_f64" ],
				
				[ buffer_text, 0, "buffer_text" ],
				[ buffer_string, 0, "buffer_string" ],
			];
			
			var pos = 0, dataLength = array_length(data);
			for (var i = 0; i < dataLength; i++) {
				
				var current = data[i];
				
				var type = current[0];
				var typeSize = current[1];
				
				_output = buffer_sizeof(type);
				assert_equals(_output, typeSize, "#3 buffer_sizeof(), failed to detect the correct size for type (type: "+current[2]+")");
			}

		})

		addFact("buffer_surface_test", function() {
			
			var _output, _testBuffer, testSurface;
			
			_testBuffer = buffer_create(1, buffer_grow, 1);
			testSurface = surface_create(1024, 1024);
			
			buffer_get_surface(_testBuffer, testSurface, 0);
			_output = buffer_get_size(_testBuffer);
			assert_equals(_output, 4194304, "#1 buffer_get_surface(), failed to load surface into buffer");
			
			buffer_fill(_testBuffer, 0, buffer_u8, 255, 4194304);
			
			surface_free(testSurface);
			
			testSurface = surface_create(512, 512);
			buffer_set_surface(_testBuffer, testSurface, 0);
			_output = surface_getpixel(testSurface, 0, 0);
			assert_equals(_output, c_white, "#2 buffer_set_surface(), failed to set surface from buffer");
			
			buffer_delete(_testBuffer);
			surface_free(testSurface);
		})

		addFact("buffer_from_vertex_buffer_test", function() {
			
			vertex_format_begin();
			vertex_format_add_position_3d();
			vertex_format_add_normal();
			vertex_format_add_colour();
			vertex_format_add_texcoord();
			var vertexFormat = vertex_format_end();
			var vertexBuffer = vertex_create_buffer();
			
			vertex_begin(vertexBuffer, vertexFormat);
			vertex_position_3d(vertexBuffer, 0, 0, 0);
			vertex_normal(vertexBuffer, 0, 0, 0);
			vertex_colour(vertexBuffer, 0, 1);
			vertex_texcoord(vertexBuffer, 0, 1 - 0);
			vertex_end(vertexBuffer);
			
			var _output, createdBuffer, createdExtBuffer, copiedBuffer;
	
			createdBuffer = buffer_create_from_vertex_buffer(vertexBuffer, buffer_grow, 1);
			_output = buffer_exists(createdBuffer);
			assert_true(_output, "#1 buffer_create_from_vertex_buffer(), failed to create buffer");
			
			createdExtBuffer = buffer_create_from_vertex_buffer_ext(vertexBuffer, buffer_grow, 1, 0, vertex_get_number(vertexBuffer));
			_output = buffer_exists(createdExtBuffer);
			assert_true(_output, "#1 buffer_create_from_vertex_buffer_ext(), failed to create buffer");
			
			copiedBuffer = buffer_create(1, buffer_grow, 1);
			buffer_copy_from_vertex_buffer(vertexBuffer, 0, vertex_get_number(vertexBuffer), copiedBuffer, 0);
			_output = buffer_get_size(copiedBuffer);
			assert_not_equals(_output, 1, "#3 buffer_copy_from_vertex_buffer(), failed to copy data into buffer (buffer didn't resize)");
			
			buffer_delete(createdExtBuffer);
			buffer_delete(createdBuffer);
			buffer_delete(copiedBuffer);
			
		});

		addFact("buffer_save_load_test", function() {

			//SB: buffer_save, buffer_save_ext, buffer_load, buffer_load_ext, buffer_load_partial, buffer_async_group_begin, buffer_async_group_option, buffer_async_group_end, buffer_load_async, buffer_save_async

			var _output, _loadedBuffer, _testBuffer = buffer_create(512, buffer_grow, 1);
			buffer_fill(_testBuffer, 256, buffer_u8, 10, 512);
			
			buffer_save(_testBuffer, "Buffer.sav");
			_output = file_exists("Buffer.sav");
			assert_true(_output, "#1 buffer_save(), failed to create the file");
			
			_loadedBuffer = buffer_load("Buffer.sav");
			_output = buffer_exists(_loadedBuffer);
			assert_true(_output, "#2 buffer_load(), failed to create the buffer");
			
			_output = buffer_get_size(_loadedBuffer);
			assert_equals(_output, 512, "#2.1 buffer_load(), loaded buffer size doesn't match (after buffer_save)");
			_output = buffer_peek(_loadedBuffer, 256, buffer_u8);
			assert_equals(_output, 10, "#2.2 buffer_load(), loaded buffer data doesn't match (after buffer_save)");
			
			buffer_delete(_loadedBuffer);
	
			buffer_save_ext(_testBuffer, "BufferExt.sav", 256, 512);
			_output = file_exists("BufferExt.sav");
			assert_true(_output, "#3 buffer_save_ext(), failed to create the file");
			
			_loadedBuffer = buffer_load("BufferExt.sav");
			_output = buffer_get_size(_loadedBuffer);
			assert_equals(_output, 256, "#3.1 buffer_load(), loaded buffer size doesn't match (after buffer_save_ext)");
			_output = buffer_peek(_loadedBuffer, 0, buffer_u8);
			assert_equals(_output, 10, "#3.2 buffer_load(), loaded buffer data doesn't match (after buffer_save_ext)");
			
			buffer_delete(_loadedBuffer);
			
			_loadedBuffer = buffer_create(1, buffer_grow, 1);
			buffer_load_ext(_loadedBuffer, "Buffer.sav", 256);

			_output = buffer_get_size(_loadedBuffer);
			assert_equals(_output, 768, "#4.1 buffer_load_ext(), loaded buffer size doesn't match");
			_output = buffer_peek(_loadedBuffer, 512, buffer_u8);
			assert_equals(_output, 10, "#4.2 buffer_load_ext(), loaded buffer data doesn't match");

			buffer_delete(_loadedBuffer);
			
			_loadedBuffer = buffer_create(1, buffer_grow, 1);
			buffer_load_partial(_loadedBuffer, "Buffer.sav", 0, 512, 256);

			_output = buffer_get_size(_loadedBuffer);
			assert_equals(_output, 512 + 256, "#4.1 buffer_load_partial(), loaded buffer size doesn't match");
			_output = buffer_peek(_loadedBuffer, 512, buffer_u8);
			assert_equals(_output, 10, "#4.2 buffer_load_partial(), loaded buffer data doesn't match");
			
			buffer_delete(_loadedBuffer);
			buffer_delete(_testBuffer);
			
			file_delete("Buffer.sav");
			file_delete("BufferExt.sav");
			
		})

		// #### ASYNC ####

		addTestAsync("buffer_save_async_test", objTestAsyncSaveLoad, {
			
			ev_create: function() {
			
				var bufferID = buffer_create(1024, buffer_grow, 1);
				buffer_fill(bufferID, 0, buffer_text, "a", 1024);
			
				requestID = buffer_save_async(bufferID, "AsyncBuffer.sav", 0, 1024);
				
				buffer_delete(bufferID);
			
			},
			
			ev_async_save_load: function() {
				
				var _asyncLoad = async_load;

				if (_asyncLoad[? "id"] != requestID) exit;
			
				assert_true(_asyncLoad[? "status"], "#1 buffer_save_async(), fail to save the file");
				
				file_delete("AsyncBuffer.sav");
				
				test_end();
			},
		
		});
		
		addTestAsync("buffer_save_async_group_test", objTestAsyncSaveLoad, {
			
			ev_create: function() {
			
				var bufferID = buffer_create(1024, buffer_grow, 1);
				buffer_fill(bufferID, 0, buffer_text, "a", 1024);
			
				buffer_async_group_begin("Test");
				buffer_async_group_option("subtitle","Test");
				buffer_async_group_option("showdialog", false);
				buffer_async_group_option("savepadindex", 1);
				buffer_async_group_option("saveslotsize", buffer_seek(bufferID, buffer_seek_end, 0));
				buffer_save_async(bufferID, "asyncBuffer.sav", 0, 1024);
				requestID = buffer_async_group_end();
				
				buffer_delete(bufferID);
			
			},
			
			ev_async_save_load: function() {
				
				var _asyncLoad = async_load;
				
				if (_asyncLoad[? "id"] != requestID) exit;
			
				assert_true(_asyncLoad[? "status"], "#1 buffer_async_group_begin/end(), fail to save the file");
				
				file_delete("asyncBuffer.sav");
				
				test_end();
			}
			
		}, { test_filter: platform_not_browser });
		
		
		addTestAsync("buffer_load_async_test", objTestAsyncSaveLoad, {
			
			ev_create: function() {
			
				bufferID = buffer_create(1024, buffer_grow, 1);
				buffer_fill(bufferID, 0, buffer_text, "a", 1024);
				buffer_save(bufferID, "asyncBuffer.sav");
			
				requestID = buffer_load_async(bufferID, "asyncBuffer.sav", 0, 1024);
			
			},
			
			ev_async_save_load: function() {
				
				var _asyncLoad = async_load;
				
				if (_asyncLoad[? "id"] != requestID) exit;
			
				assert_true(_asyncLoad[? "status"], "#1 buffer_load_async(), fail to load the file");
				
				file_delete("asyncBuffer.sav");
				buffer_delete(bufferID);
				
				test_end();
			}
			
		});
		
}