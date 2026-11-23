// Tests for the buffer_utf8 data type and the optional size argument of buffer_read / buffer_peek (GameMaker-Bugs#16485)

/// @ignore
function buffer_utf8_test_bytes(_bytes) {
	// A fixed buffer holding exactly the given bytes, positioned at the start
	var _buff = buffer_create(array_length(_bytes), buffer_fixed, 1);
	for (var _i = 0; _i < array_length(_bytes); _i++) {
		buffer_write(_buff, buffer_u8, _bytes[_i]);
	}
	buffer_seek(_buff, buffer_seek_start, 0);
	return _buff;
}

/// @ignore
function buffer_utf8_test_written(_buff, _count) {
	// The first _count bytes of the buffer, as an array
	var _bytes = [];
	for (var _i = 0; _i < _count; _i++) {
		array_push(_bytes, buffer_peek(_buff, _i, buffer_u8));
	}
	return _bytes;
}

function BasicBufferUtf8TestSuite() : TestSuite() constructor {

	addFact("buffer_utf8 reads 1 to 4 byte characters", function() {
		// "A", "é", "€", "😀"
		var _buff = buffer_utf8_test_bytes([0x41, 0xC3, 0xA9, 0xE2, 0x82, 0xAC, 0xF0, 0x9F, 0x98, 0x80]);
		assert_equals(buffer_read(_buff, buffer_utf8), 65, "#buffer_read(buffer_utf8), should read a 1 byte character");
		assert_equals(buffer_tell(_buff), 1, "#buffer_read(buffer_utf8), should advance by 1 byte");
		assert_equals(buffer_read(_buff, buffer_utf8), 233, "#buffer_read(buffer_utf8), should read a 2 byte character");
		assert_equals(buffer_tell(_buff), 3, "#buffer_read(buffer_utf8), should advance by 2 bytes");
		assert_equals(buffer_read(_buff, buffer_utf8), 8364, "#buffer_read(buffer_utf8), should read a 3 byte character");
		assert_equals(buffer_tell(_buff), 6, "#buffer_read(buffer_utf8), should advance by 3 bytes");
		assert_equals(buffer_read(_buff, buffer_utf8), 128512, "#buffer_read(buffer_utf8), should read a 4 byte character");
		assert_equals(buffer_tell(_buff), 10, "#buffer_read(buffer_utf8), should advance by 4 bytes");
		buffer_delete(_buff);
	});

	addFact("buffer_utf8 returns a number that chr turns back into the character", function() {
		var _buff = buffer_utf8_test_bytes([0xE2, 0x82, 0xAC]);
		var _codepoint = buffer_read(_buff, buffer_utf8);
		assert_true(is_numeric(_codepoint), "#buffer_read(buffer_utf8), should return a number");
		assert_equals(chr(_codepoint), "€", "#buffer_read(buffer_utf8), chr of the result should be the character");
		buffer_delete(_buff);
	});

	addFact("buffer_peek with buffer_utf8 doesn't move the buffer", function() {
		var _buff = buffer_utf8_test_bytes([0x41, 0xC3, 0xA9, 0xF0, 0x9F, 0x98, 0x80]);
		assert_equals(buffer_peek(_buff, 1, buffer_utf8), 233, "#buffer_peek(buffer_utf8), should read the character at the offset");
		assert_equals(buffer_peek(_buff, 3, buffer_utf8), 128512, "#buffer_peek(buffer_utf8), should read a 4 byte character at the offset");
		assert_equals(buffer_tell(_buff), 0, "#buffer_peek(buffer_utf8), should not move the buffer");
		buffer_delete(_buff);
	});

	addFact("buffer_utf8 reads U+FFFD and advances one byte for malformed input", function() {
		var _cases = [
			[[0x80, 0x41], "a continuation byte where a character should start"],
			[[0xC0, 0x80], "0xC0, which can't start a character"],
			[[0xC1, 0xBF], "0xC1, which can't start a character"],
			[[0xF5, 0x80, 0x80, 0x80], "0xF5, which can't start a character"],
			[[0xFF, 0x41], "0xFF, which can't start a character"],
			[[0xC3, 0x41], "a missing continuation byte"],
			[[0xE2, 0x82, 0x41], "an invalid continuation byte"],
			[[0xE0, 0x80, 0x80], "an overlong 3 byte encoding"],
			[[0xF0, 0x8F, 0xBF, 0xBF], "an overlong 4 byte encoding"],
			[[0xED, 0xA0, 0x80], "a surrogate"],
			[[0xF4, 0x90, 0x80, 0x80], "a value above U+10FFFF"],
			[[0xE2, 0x82], "a sequence cut off by the end of the buffer"],
		];
		for (var _i = 0; _i < array_length(_cases); _i++) {
			var _buff = buffer_utf8_test_bytes(_cases[_i][0]);
			assert_equals(buffer_read(_buff, buffer_utf8), 65533, "#buffer_read(buffer_utf8), should read U+FFFD for " + _cases[_i][1]);
			assert_equals(buffer_tell(_buff), 1, "#buffer_read(buffer_utf8), should advance one byte for " + _cases[_i][1]);
			buffer_delete(_buff);
		}
	});

	addFact("buffer_utf8 carries on after a malformed byte", function() {
		// A stray continuation byte between "A" and "é"
		var _buff = buffer_utf8_test_bytes([0x41, 0xA9, 0xC3, 0xA9]);
		assert_equals(buffer_read(_buff, buffer_utf8), 65, "#buffer_read(buffer_utf8), should read the first character");
		assert_equals(buffer_read(_buff, buffer_utf8), 65533, "#buffer_read(buffer_utf8), should read U+FFFD for the stray byte");
		assert_equals(buffer_read(_buff, buffer_utf8), 233, "#buffer_read(buffer_utf8), should read the next character");
		assert_equals(buffer_tell(_buff), 4, "#buffer_read(buffer_utf8), should end after the last character");
		buffer_delete(_buff);
	});

	addFact("buffer_write with buffer_utf8 writes 1 to 4 bytes", function() {
		var _buff = buffer_create(16, buffer_fixed, 1);
		buffer_write(_buff, buffer_utf8, 65);
		assert_equals(buffer_tell(_buff), 1, "#buffer_write(buffer_utf8), should write 1 byte for U+0041");
		buffer_write(_buff, buffer_utf8, 233);
		assert_equals(buffer_tell(_buff), 3, "#buffer_write(buffer_utf8), should write 2 bytes for U+00E9");
		buffer_write(_buff, buffer_utf8, 8364);
		assert_equals(buffer_tell(_buff), 6, "#buffer_write(buffer_utf8), should write 3 bytes for U+20AC");
		buffer_write(_buff, buffer_utf8, 128512);
		assert_equals(buffer_tell(_buff), 10, "#buffer_write(buffer_utf8), should write 4 bytes for U+1F600");
		assert_array_equals(buffer_utf8_test_written(_buff, 10), [0x41, 0xC3, 0xA9, 0xE2, 0x82, 0xAC, 0xF0, 0x9F, 0x98, 0x80], "#buffer_write(buffer_utf8), should write the UTF-8 bytes");

		buffer_seek(_buff, buffer_seek_start, 0);
		assert_equals(buffer_read(_buff, buffer_utf8), 65, "#buffer_read(buffer_utf8), should read back U+0041");
		assert_equals(buffer_read(_buff, buffer_utf8), 233, "#buffer_read(buffer_utf8), should read back U+00E9");
		assert_equals(buffer_read(_buff, buffer_utf8), 8364, "#buffer_read(buffer_utf8), should read back U+20AC");
		assert_equals(buffer_read(_buff, buffer_utf8), 128512, "#buffer_read(buffer_utf8), should read back U+1F600");
		buffer_delete(_buff);
	});

	addFact("buffer_poke with buffer_utf8 writes at the offset without moving", function() {
		var _buff = buffer_create(8, buffer_fixed, 1);
		buffer_poke(_buff, 2, buffer_utf8, 8364);
		assert_equals(buffer_tell(_buff), 0, "#buffer_poke(buffer_utf8), should not move the buffer");
		assert_equals(buffer_peek(_buff, 2, buffer_u8), 0xE2, "#buffer_poke(buffer_utf8), should write the first byte at the offset");
		assert_equals(buffer_peek(_buff, 2, buffer_utf8), 8364, "#buffer_poke(buffer_utf8), should write the whole character");
		buffer_delete(_buff);
	});

	addFact("buffer_write with buffer_utf8 writes U+FFFD for a value that isn't a code point", function() {
		var _values = [-1, 0xD800, 0xDFFF, 0x110000];
		for (var _i = 0; _i < array_length(_values); _i++) {
			var _buff = buffer_create(8, buffer_fixed, 1);
			buffer_write(_buff, buffer_utf8, _values[_i]);
			assert_equals(buffer_tell(_buff), 3, "#buffer_write(buffer_utf8), should write 3 bytes for " + string(_values[_i]));
			assert_array_equals(buffer_utf8_test_written(_buff, 3), [0xEF, 0xBF, 0xBD], "#buffer_write(buffer_utf8), should write U+FFFD for " + string(_values[_i]));
			buffer_delete(_buff);
		}
	});

	addFact("buffer_sizeof buffer_utf8 matches buffer_text", function() {
		assert_equals(buffer_sizeof(buffer_utf8), buffer_sizeof(buffer_text), "#buffer_sizeof(buffer_utf8), should match buffer_text");
		assert_equals(buffer_utf8, 14, "#buffer_utf8, should be 14");
	});

	addFact("buffer_read with a size reads that many bytes", function() {
		var _types = [[buffer_text, "buffer_text"], [buffer_string, "buffer_string"]];
		for (var _t = 0; _t < array_length(_types); _t++) {
			var _type = _types[_t][0];
			var _name = _types[_t][1];
			var _buff = buffer_create(32, buffer_fixed, 1);
			buffer_write(_buff, buffer_text, "Hello, World");
			buffer_seek(_buff, buffer_seek_start, 0);
			assert_equals(buffer_read(_buff, _type, 5), "Hello", "#buffer_read(" + _name + ", 5), should read 5 bytes");
			assert_equals(buffer_tell(_buff), 5, "#buffer_read(" + _name + ", 5), should advance by 5 bytes");
			assert_equals(buffer_read(_buff, _type, 2), ", ", "#buffer_read(" + _name + ", 2), should read the next 2 bytes");
			assert_equals(buffer_read(_buff, _type, 0), "", "#buffer_read(" + _name + ", 0), should read an empty string");
			assert_equals(buffer_tell(_buff), 7, "#buffer_read(" + _name + ", 0), should not move the buffer");
			buffer_delete(_buff);
		}
	});

	addFact("buffer_peek with a size reads that many bytes without moving", function() {
		var _buff = buffer_create(32, buffer_fixed, 1);
		buffer_write(_buff, buffer_text, "Hello, World");
		buffer_seek(_buff, buffer_seek_start, 3);
		assert_equals(buffer_peek(_buff, 7, buffer_text, 5), "World", "#buffer_peek(buffer_text, 5), should read 5 bytes at the offset");
		assert_equals(buffer_peek(_buff, 0, buffer_string, 4), "Hell", "#buffer_peek(buffer_string, 4), should read 4 bytes at the offset");
		assert_equals(buffer_tell(_buff), 3, "#buffer_peek with a size, should not move the buffer");
		buffer_delete(_buff);
	});

	addFact("buffer_read with a size stops at the end of the buffer", function() {
		var _buff = buffer_utf8_test_bytes([0x61, 0x62, 0x63, 0x64]);
		buffer_seek(_buff, buffer_seek_start, 1);
		assert_equals(buffer_read(_buff, buffer_text, 10), "bcd", "#buffer_read(buffer_text, 10), should read to the end of the buffer");
		assert_equals(buffer_tell(_buff), 4, "#buffer_read(buffer_text, 10), should advance to the end of the buffer");
		assert_equals(buffer_peek(_buff, 2, buffer_text, 10), "cd", "#buffer_peek(buffer_text, 10), should read to the end of the buffer");
		buffer_delete(_buff);
	});

	addFact("buffer_read with a size stops the string at a zero byte but advances by the size", function() {
		var _buff = buffer_utf8_test_bytes([0x61, 0x62, 0x00, 0x63, 0x64, 0x65]);
		assert_equals(buffer_read(_buff, buffer_text, 5), "ab", "#buffer_read(buffer_text, 5), should stop the string at the zero byte");
		assert_equals(buffer_tell(_buff), 5, "#buffer_read(buffer_text, 5), should still advance by 5 bytes");
		assert_equals(buffer_read(_buff, buffer_text, 1), "e", "#buffer_read(buffer_text, 1), should read the byte after the span");
		buffer_delete(_buff);
	});

	addFact("buffer_read with a size counts bytes, not characters", function() {
		// "é" is 2 bytes: a size of 2 reads it, and a size of 1 cuts it but still advances by 1
		var _buff = buffer_utf8_test_bytes([0xC3, 0xA9, 0x41]);
		assert_equals(buffer_peek(_buff, 0, buffer_text, 2), "é", "#buffer_peek(buffer_text, 2), should read the 2 byte character");
		buffer_read(_buff, buffer_text, 1);
		assert_equals(buffer_tell(_buff), 1, "#buffer_read(buffer_text, 1), should advance by 1 byte");
		buffer_delete(_buff);
	});

	addFact("buffer_read without a size or with a negative size reads to the zero byte", function() {
		var _buff = buffer_create(32, buffer_fixed, 1);
		buffer_write(_buff, buffer_string, "abc");
		buffer_write(_buff, buffer_string, "def");
		buffer_seek(_buff, buffer_seek_start, 0);
		assert_equals(buffer_read(_buff, buffer_string), "abc", "#buffer_read(buffer_string), should read to the zero byte");
		assert_equals(buffer_tell(_buff), 4, "#buffer_read(buffer_string), should advance past the zero byte");
		assert_equals(buffer_read(_buff, buffer_string, -1), "def", "#buffer_read(buffer_string, -1), should read to the zero byte");
		assert_equals(buffer_tell(_buff), 8, "#buffer_read(buffer_string, -1), should advance past the zero byte");
		buffer_delete(_buff);
	});

	addFact("buffer_read ignores the size for other data types", function() {
		var _buff = buffer_utf8_test_bytes([0x01, 0x02, 0x03, 0x04]);
		assert_equals(buffer_read(_buff, buffer_u8, 4), 1, "#buffer_read(buffer_u8, 4), should read one byte");
		assert_equals(buffer_tell(_buff), 1, "#buffer_read(buffer_u8, 4), should advance by one byte");
		buffer_delete(_buff);
	});

	addFact("buffer_read reads a length-prefixed string", function() {
		var _buff = buffer_create(32, buffer_grow, 1);
		var _text = "Grüße";
		buffer_write(_buff, buffer_u16, string_byte_length(_text));
		buffer_write(_buff, buffer_text, _text);
		buffer_write(_buff, buffer_u8, 7);
		buffer_seek(_buff, buffer_seek_start, 0);
		var _len = buffer_read(_buff, buffer_u16);
		assert_equals(buffer_read(_buff, buffer_text, _len), _text, "#buffer_read(buffer_text, len), should read the length-prefixed string");
		assert_equals(buffer_read(_buff, buffer_u8), 7, "#buffer_read(buffer_u8), should read the value after the string");
		buffer_delete(_buff);
	});
}
