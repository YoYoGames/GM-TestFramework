
function BasicStringTestSuite() : TestSuite() constructor {
    
    // ANSI_CHAR TESTS
    {
	    addFact("ansi_char_test #1", function() {
    
	        // Check that the 'A' char can be correctly returned, and stored in a local variable
	        var aStr = ansi_char($41); // Hex $41 == 65 == ASCII 'A'
	        assert_equals(aStr, "A", "ansi_char( real const ),  ASCII 65 should equal 'A'");
	    });
    
	    addFact("ansi_char_test #2", function() {
        
	        // Check that the 'B' char can be correctly returned, as a literal
			assert_equals(ansi_char($42), "B", "ansi_char( real const ), ASCII 66 should equal 'B'"); // Hex $42 == 66 == ASCII 'B'
	    });
    
	    addFact("ansi_char_test #3", function() {
        
	        // Check that all the chars in "Hello" & "world" can be correctly returned and concatenated into strings
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        assert_equals(helloStr, "Hello", "ansi_char( real const ), String should equal 'Hello'");
	        assert_equals(worldStr, "world", "ansi_char( real const ), String should equal 'world'");
	    });
    
	    addFact("ansi_char_test #4", function() {
			
			// Check that the space char can be correctly returned
	        var space = ansi_char($20); // Hex $20 == 32 == ASCII ' '
	        assert_equals(space, " ", "ansi_char( real const ), ASCII 32 should equal ' ' (space)");
	    });
    
	    addFact("ansi_char_test #5", function() {
			
			// Check that the exclamation mark char can be correctly returned
	        var exclamation = ansi_char($21); // Hex $21 == 33 == ASCII '!'
	        assert_equals(exclamation, "!", "ansi_char( real const ), ASCII 33 should equal '!' (exclamation mark)");
	    });
    
	    addFact("ansi_char_test #6", function() {
        
			// Check that all the chars in "Hello world!" can be correctly returned, and concatenated into one string
	        var fullStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F) + ansi_char($20) + ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64) + ansi_char($21);
	        assert_equals(fullStr, "Hello world!", "ansi_char( real const ), String should equal 'Hello world!'");
	    });
    
	    addFact("ansi_char_test #7", function() {
        
			// Check that strings created using the returned chars can be correctly concatenated
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        var space = ansi_char($20);
	        var exclamation = ansi_char($21);
        
	        var concatTest = helloStr + space + worldStr + exclamation;
	        assert_equals(concatTest, "Hello world!", "ansi_char( real const ), Concatenated string should equal 'Hello world!'");
	    });
    
	    addFact("ansi_char_test #8", function() {
			
			// Check that strings created using the returned chars can be correctly concatenated using +=
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        var space = ansi_char($20);
	        var exclamation = ansi_char($21);
        
	        var concatQuickTest = helloStr;
	        concatQuickTest += space;
	        concatQuickTest += worldStr;
	        concatQuickTest += exclamation;
	        assert_equals(concatQuickTest, "Hello world!", "ansi_char( real const ) Concatenated string should equal 'Hello world!'");
	    });
	}

    // CHR TESTS
    {
	    addFact("chr_test #1", function() {
        
	        // Check that the 'A' char can be correctly returned, and stored in a local variable
	        var aStr = chr(65);
	        assert_equals(aStr, "A", "chr( real const ), ASCII 65 should equal 'A'");
	    });
    
	    addFact("chr_test #2", function() {
        
	        // Check that the 'B' char can be correctly returned, as a literal
	        assert_equals(chr(66), "B", "chr( real const ), ASCII 66 should equal 'B'");
	    });
    
	    addFact("chr_test #3", function() {
        
			// Check that all the chars in "Hello" & "world" can be correctly returned and concatenated into strings
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        assert_equals(helloStr, "Hello", "chr( real const ), String should equal 'Hello'");
	        assert_equals(worldStr, "world", "chr( real const ), String should equal 'world'");
	    });
    
	    addFact("chr_test #4", function() {
			
			// Check that the space char can be correctly returned
	        var space = chr(32);
	        assert_equals(space, " ", "chr( real const ), ASCII 32 should equal ' ' (space)");
	    });
    
	    addFact("chr_test #5", function() {
			
			// Check that the exclamation mark char can be correctly returned
	        var exclamation = chr(33);
	        assert_equals(exclamation, "!", "chr( real const ), ASCII 33 should equal '!' (exclamation mark)");
	    });
    
	    addFact("chr_test #6", function() {
			
			// Check that all the chars in "Hello world!" can be correctly returned, and concatenated into one string
	        var fullStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111) + chr(32) + chr(119) + chr(111) + chr(114) + chr(108) + chr(100) + chr(33);
	        assert_equals(fullStr, "Hello world!", "chr( real const ), String should equal 'Hello world!'");
	    });
    
	    addFact("chr_test #7", function() {
			
			// Check that strings created using the returned chars can be correctly concatenated
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        var space = chr(32);
	        var exclamation = chr(33);
        
	        var concatTest = helloStr + space + worldStr + exclamation;
	        assert_equals(concatTest, "Hello world!", "chr( real const ), Concatenated string should equal 'Hello world!'");
	    });
		
	    addFact("chr_test #8", function() {
			
			// Check that strings created using the returned chars can be correctly concatenated using +=
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        var space = chr(32);
	        var exclamation = chr(33);
        
	        var concatQuickTest = helloStr;
	        concatQuickTest += space;
	        concatQuickTest += worldStr; 
	        concatQuickTest += exclamation;
	        assert_equals(concatQuickTest, "Hello world!", "chr( real const ) Concatenated string should equal 'Hello world!'");
	    });
	}
	
    // CHR UNICODE TESTS
    {
	    addFact("chr_unicode_test #1", function() {
			
			// Check that the '€' char can be correctly returned
	        var euro = chr(8364);
	        assert_equals(euro, "€", "chr( real const ), Unicode 8364 should equal '€' (euro sign)");
	    });
    
	    addFact("chr_unicode_test #2", function() {
			
			// Check that the '€' char can be correctly returned with a local variable input
	        var euroOrd = 8364;
	        var euroChar = chr(euroOrd);
	        assert_equals(euroChar, "€", "chr( real local ), Unicode 8364 should equal '€' (euro sign)");
	    });
    
	    addFact("chr_unicode_test #3", function() {
        
			// Check that the '老' char can be correctly returned
	        var u8001ChrLit = chr(32769);
	        assert_equals(u8001ChrLit, "老", "chr( real local ), Unicode 32769 should equal '老' (U+8001)");
	    });
		
		addFact("chr_unicode_test #4", function() {
			
			// Check that the '老' char can be correctly returned with a local variable input
	        var u8001 = 32769;
	        var u8001Chr = chr(u8001);
	        assert_equals(u8001Chr, "老", "chr( real local ), Unicode 32769 should equal '老' (U+8001)");
	    });
		
		addFact("chr_unicode_test #5", function() {
			
			// Check that the '₹' char can be correctly returned
	        var indianRupee = chr(8377);
	        assert_equals(indianRupee, "₹", "chr( real const ), Unicode 8377 should equal '₹' (indian rupee)");
	    });
    
	    addFact("chr_unicode_test #6", function() {
			
			// Check that the '₹' char can be correctly returned with a local variable input
	        var indianRupeeOrd = 8377;
	        var indianRupeeChar = chr(indianRupeeOrd);
	        assert_equals(indianRupeeChar, "₹", "chr( real local ), Unicode 8377 should equal '₹' (indian rupee)")
	    });
		
		addFact("chr_unicode_test #7", function() {
			
			// Check that the '₨' char can be correctly returned
	        var rupee = chr(8360);
	        assert_equals(rupee, "₨", "chr( real const ), Unicode 8360 should equal '₨' (rupee)");
	    });
    
	    addFact("chr_unicode_test #8", function() {
			
			// Check that the '₨' char can be correctly returned with a local variable input
	        var rupeeOrd = 8360;
	        var rupeeChar = chr(rupeeOrd);
	        assert_equals(rupeeChar, "₨", "chr( real local ), Unicode 8360 should equal '₨' (rupee)");
	    });
		
		addFact("chr_unicode_test #9", function() {
			
			// Check that the 'θ' char can be correctly returned
	        var theta = chr(952);
	        assert_equals(theta, "θ", "chr( real const ), Unicode 952 should equal 'θ' (theta)");
	    });
		
	    addFact("chr_unicode_test #10", function() {
			
			// Check that the 'θ' char can be correctly returned with a local variable input
	        var thetaOrd = 952;
	        var thetaChar = chr(thetaOrd);
	        assert_equals(thetaChar, "θ", "chr( real local ), Unicode 952 should equal 'θ' (theta)");
	    });
		
		addFact("chr_unicode_test #11", function() {
			
			// Check that the '🙂' char can be correctly returned
	        var smileyFace = chr(128578);
	        assert_equals(smileyFace, "🙂", "chr( real const ), Unicode 128578 should equal '🙂' (smiley face emoji)");
	    });
		
	    addFact("chr_unicode_test #12", function() {
			
			// Check that the '🙂' char can be correctly returned with a local variable input
	        var smileyFaceOrd = 128578;
	        var smileyFaceChar = chr(smileyFaceOrd);
	        assert_equals(smileyFaceChar, "🙂", "chr( real local ), Unicode 128578 should equal '🙂' (smiley face emoji)");
	    });
	}
	
	// STRING ESCAPE CHARACTER TESTS
	{
	    addFact("string_escape_character_test #1", function() {
        
			// Check 1-byte UTF-8 char
	        var aUChar = "\u41";
	        assert_equals(aUChar, "A", "Unicode \\u41 should equal 'A'");
	    });
    
	    addFact("string_escape_character_test #2", function() {
			
			// Check 2-byte UTF-8 char
	        var euroUChar = "\u20AC";
	        assert_equals(euroUChar, "€", "Unicode \\u20AC should equal '€' (euro sign)");
	    });
    
	    addFact("string_escape_character_test #3", function() {
			
			// Check 3-byte UTF-8 char
	        var u8001UChar = "\u8001";
	        assert_equals(u8001UChar, "老", "Unicode \\u8001 should equal '老' (U+8001)");
	    });
    
	    addFact("string_escape_character_test #4", function() {
			
			// Check 4-byte UTF-8 char
	        var u1F642UChar = "\u1F642";
	        assert_equals(u1F642UChar, "🙂", "Unicode \\u1F642 should equal '🙂' (smiley face emoji)");
	    });
    
	    addFact("string_escape_character_test #5", function() {
			
			// Check a variety of chars with different byte lengths in the same string
	        var variousChars = "\u1F642\u8001\u20AC\u41";
	        assert_equals(variousChars, "🙂老€A", "String of escape characters should equal '🙂老€A'");
	    });
    
	    addFact("string_escape_character_test #6", function() {
			
			// Check a variety of chars with different byte lengths in the same string
	        var smileyString = "\u1F642\u1F642\u1F642\u8001\u1F642\u1F642";
	        assert_equals(smileyString, "🙂🙂🙂老🙂🙂", "String of escape characters should equal '🙂🙂🙂老🙂🙂'");
	    });

	    addFact("string_escape_character_test #7", function() {
			
			// Check a variety of chars with different byte lengths in the same string
	        var smileyEuros = "\u20AC\u1F642\u20AC\u1F642\u20AC\u1F642\u20AC";
	        assert_equals(smileyEuros, "€🙂€🙂€🙂€", "String of escape characters should equal '€🙂€🙂€🙂€'");
	    });
	}
	
	// ORD TESTS
	{
		addFact("ord_test #1", function() {
			
			// Check that '0' returns the correct character code
			var zeroChar = ord("0");
			assert_equals(zeroChar, 48, "ord( string const ), ASCII '0' (zero) Should equal 48");
	    });
	
		addFact("ord_test #2", function() {
			
			// Check that 'A' returns the correct character code
			var uppercaseA = ord("A");
			assert_equals(uppercaseA, 65, "ord( string const ), ASCII 'A' Should equal 65");
	    });
	
		addFact("ord_test #3", function() {
			
			// Check that 'a' returns the correct character code
			var lowercaseA = ord("a");
			assert_equals(lowercaseA, 97, "ord( string const ), ASCII 'a' Should equal 97");
	    });
	
		addFact("ord_test #4", function() {
			
			// Check that '£' returns the correct character code
			var poundSymbol = ord("£");
			assert_equals(poundSymbol, 163, "ord( string const ), ASCII '£' (pound sign) Should equal 163");
	    });
	
		addFact("ord_test #5", function() {
			
			// Check that '€' returns the correct character code
			var euroSymbol = ord("€");
			assert_equals(euroSymbol, 8364, "ord( string const ), Unicode '€' (euro sign) Should equal 8364");
	    });
	
		addFact("ord_test #6", function() {
			
			// Check that '₹' returns the correct character code
			var indianRupee = ord("₹");
			assert_equals(indianRupee, 8377, "ord( string const ), Unicode '₹' (indian rupee) Should equal 8377");
	    });
	
		addFact("ord_test #7", function() {
			
			// Check that '₨' returns the correct character code
			var rupee = ord("₨");
			assert_equals(rupee, 8360, "ord( string const ), Unicode '₨' (rupee) Should equal 8377");
	    });
	
		addFact("ord_test #8", function() {
			
			// Check that 'θ' returns the correct character code
			var theta = ord("θ");
			assert_equals(theta, 952, "ord( string const ), Unicode 'θ' (theta) Should equal 8377");
	    });
	
		addFact("ord_test #9", function() {
			
			// Check that '🙂' returns the correct character code
			var smileyOrdLit = ord("🙂");
			assert_equals(smileyOrdLit, 128578, "ord( string const ), Unicode '🙂' (theta) Should equal 128578");
	    });
	
		addFact("ord_test #10", function() {
			
			// Check that '0' returns the correct character code from a local variable
			var zeroChar = "0";
			var zeroOrd = ord(zeroChar);
			assert_equals(zeroOrd, 48, "ord( string local ), ASCII '0' (zero) Should equal 48");
	    });
	
		addFact("ord_test #11", function() {
			
			// Check that 'A' returns the correct character code from a local variable
			var uppercaseA = "A";
			var uppercaseAOrd = ord(uppercaseA);
			assert_equals(uppercaseAOrd, 65, "ord( string local ), ASCII 'A' Should equal 65");
	    });
	
		addFact("ord_test #12", function() {
			
			// Check that 'a' returns the correct character code from a local variable
			var lowercaseA = "a";
			var lowercaseAOrd = ord(lowercaseA);
			assert_equals(lowercaseAOrd, 97, "ord( string local ), ASCII 'a' Should equal 97");
	    });
	
		addFact("ord_test #13", function() {
			
			// Check that '£' returns the correct character code from a local variable
			var poundSymbol = "£";
			var poundSymbolOrd = ord(poundSymbol);
			assert_equals(poundSymbolOrd, 163, "ord( string local ), ASCII '£' (pound sign) Should equal 163");
	    });
	
		addFact("ord_test #14", function() {
			
			// Check that '€' returns the correct character code from a local variable
			var euroSymbol = "€";
			var euroSymbolOrd = ord(euroSymbol);
			assert_equals(euroSymbolOrd, 8364, "ord( string local ), Unicode '€' (euro sign) Should equal 8364");
	    });
	
		addFact("ord_test #15", function() {
			
			// Check that '₹' returns the correct character code from a local variable
			var indianRupee = "₹";
			var indianRupeeOrd = ord(indianRupee);
			assert_equals(indianRupeeOrd, 8377, "ord( string local ), Unicode '₹' (indian rupee) Should equal 8377");
	    });
	
		addFact("ord_test #16", function() {
			
			// Check that '₨' returns the correct character code from a local variable
			var rupee = "₨";
			var rupeeOrd = ord(rupee);
			assert_equals(rupeeOrd, 8360, "ord( string local ), Unicode '₨' (rupee) Should equal 8377");
	    });
	
		addFact("ord_test #17", function() {
			
			// Check that 'θ' returns the correct character code from a local variable
			var theta = "θ";
			var thetaOrd = ord(theta);
			assert_equals(thetaOrd, 952, "ord( string local ), Unicode 'θ' (theta) Should equal 8377");
	    });
	
		addFact("ord_test #18", function() {
			
			// Check that '🙂' returns the correct character code from a local variable
			var smileyVar = "🙂";
			var smileyOrdVar = ord(smileyVar);
			assert_equals(smileyOrdVar, 128578, "ord( string local ), Unicode '🙂' (theta) Should equal 128578");
	    });
	}
	
	// STRING_BYTE_AT TESTS
	{
		addFact("string_byte_at_test #1", function() {
        
			var vstring = "hello World!";
			
			// Check that the correct byte is returned with standard inputs
			var res = string_byte_at(vstring, 7);
			assert_equals(res, 87, "string_byte_at( string local , real const ), 7th byte in 'hello World!' should be 87 ('W')");
	    });
	
		addFact("string_byte_at_test #2", function() {
        
			var vstring = "hello World!";
			
			// Check that using a decimal index above .5 will round down to the nearest integer
			var res = string_byte_at(vstring, 7.6);
			assert_equals(res, 87, "string_byte_at( string local , real const ), 7.6th (rounded down to 7th) byte in 'hello World!' should be 87 ('W')");
	    });
	
		addFact("string_byte_at_test #3", function() {
        
			var vstring = "hello World!";
			
			// Check that using a decimal index below .5 will round down to the nearest integer
			var res = string_byte_at(vstring, 7.2);
			assert_equals(res, 87, "string_byte_at( string local , real const ), 7.2th (rounded down to 7th) byte in 'hello World!' should be 87 ('W')");
	    });
	
		addFact("string_byte_at_test #4", function() {
        
			var vstring = "hello World!";
			
			// Check that using an index of 0 will be clamped to 1
			var res = string_byte_at(vstring, 0);
			assert_equals(res, 104, "string_byte_at( string local , real const ), first byte in 'hello World!' should be 104 ('h')");
	    });
		
		addFact("string_byte_at_test #5", function() {
        
			var vstring = "hello World!";
			
			// Check that using an index of 1 returns the first byte
			var res = string_byte_at(vstring, 1);
			assert_equals(res, 104, "string_byte_at( string local , real const ), first byte in 'hello World!' should be 104 ('h')");
	    });
	
		addFact("string_byte_at_test #6", function() {
        
			var vstring = "hello World!";
			
			// Check that using an index over the amount of bytes in the string will be clamped to the last byte in the string
			var res = string_byte_at(vstring, 100);
			assert_equals(res, 33, "string_byte_at( string local , real const ), 100th (clamped to last) byte in 'hello World!' should be 33 ('!')");
	    });
	
		addFact("string_byte_at_test #7", function() {
        
			var vstring = "hello World!";
			
			// Check that using a negative index will be clamped to the first byte in the string 
			var res = string_byte_at(vstring, -2);
			assert_equals(res, 104, "string_byte_at( string local , real const ), -2nd (clamped to first) byte in 'hello World!' should be 104 ('h')");
	    });
	
		addFact("string_byte_at_test #8", function() {
        
			#macro kString_StringByteAtTest "Hello World!"
			
			// Check that the function works with a macro input
			var res = string_byte_at(kString_StringByteAtTest, 7);
			assert_equals(res, 87, "string_byte_at( string macro , real const ), 7th byte in 'hello World!' should be 87 ('W')");
	    });
	
		addFact("string_byte_at_test #9", function() {
        
			global.gstring = "Hello World!";
			
			// Check that the function works with a global input
			var res = string_byte_at(global.gstring, 7);
			assert_equals(res, 87, "string_byte_at( string global , real const ), 7th byte in 'hello World!' should be 87 ('W')");
	    });
	
		addFact("string_byte_at_test #10", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
			
			// Check that the function works with an instance input
			var res = string_byte_at(_oTest.ostring, 7);
			assert_equals(res, 87, "string_byte_at( string instance , real const ), 7th byte in 'hello World!' should be 87 ('W')");
		
			instance_destroy(_oTest);
	    });
	
		addFact("string_byte_at_test #11", function() {
        
			// Check that a 1-byte UTF-8 is returned correctly
			var res = string_byte_at("!£水🙂a", 1); 
			assert_equals(res, 0x21, 
			"string_byte_at( string const , real const ), first byte in '!£水🙂a' should be 0x21 ('!')");
	    });
	
		addFact("string_byte_at_test #12", function() {
        
			// Check that the 1st byte of a 2-byte UTF-8 is returned correctly
			var res = string_byte_at("!£水🙂a", 2);
			assert_equals(res, 0xc2, 
			"string_byte_at( string const , real const ), 2nd byte in '!£水🙂a' should be 0xc2 (first byte of '£')"); // '£' = 0xc2 0xa3
	    });
	
		addFact("string_byte_at_test #13", function() {
        
			// Check that the 1st byte of a 3-byte UTF-8 is returned correctly
			var res = string_byte_at("!£水🙂a", 4);
			assert_equals(res, 0xe6, 
			"string_byte_at( string const , real const ), 4th byte in '!£水🙂a' should be 0xe6 (first byte of '水')"); // '水' = 0xe6 0xb0 0xb4
	    });
	
		addFact("string_byte_at_test #14", function() {
        
			// Check that the 1st byte of a 4-byte UTF-8 is returned correctly
			var res = string_byte_at("!£水🙂a", 7);
			assert_equals(res, 0xf0, 
			"string_byte_at( string const , real const ), 7th byte in '!£水🙂a' should be 0xf0 (first byte of '🙂')"); // "🙂" = 0xf0 0x9f 0x99 0x82
	    });
	
		addFact("string_byte_at_test #15", function() {
        
			// Check that a 1-byte UTF-8 is returned correctly at the end of a string of different byte-length UTF-8s
			var res = string_byte_at("!£水🙂a", 11);
			assert_equals(res, 0x61, 
			"string_byte_at( string const , real const ), 11th byte in '!£水🙂a' should be 0x61 ('a')"); // 0x61 = 'a'
	    });
	}

	// STRING_BYTE_LENGTH TESTS
	{
		addFact("string_byte_length_test #1", function() {
			
			// Check correct byte length is returned for standard input
			var helloWorldStr = "Hello world!";
			var helloWorldByteLen = string_byte_length(helloWorldStr);
			assert_equals(helloWorldByteLen, 12, "string_byte_length( string local ), 'Hello world!' as a UTF-8 string should be 12 bytes long");
	    });
	
		addFact("string_byte_length_test #2", function() {
			
			// Check correct byte length is returned for string literal input
			var literalHWByteLen = string_byte_length("Hello world!");
			assert_equals(literalHWByteLen, 12, "string_byte_length( string const ), 'Hello world!' as a UTF-8 string should be 12 bytes long");
	    });
	
		addFact("string_byte_length_test #3", function() {
			
			// Check correct byte length is returned for a string containing a 2-byte UTF-8 char
			var poundPrice = "£99.99";
			var poundPriceLen = string_byte_length(poundPrice);
			assert_equals(poundPriceLen, 7, "string_byte_length( string local ), '£99.99' as a UTF-8 string should be 7 bytes long");
	    });
	
		addFact("string_byte_length_test #4", function() {
			
			// Check correct byte length is returned for a string containing a 3-byte UTF-8 char
			var euroPrice = "€59.99";
			var euroPriceLen = string_byte_length(euroPrice);
			assert_equals(euroPriceLen, 8, "string_byte_length( string local ), '€59.99' as a UTF-8 string should be 8 bytes long");
	    });
	
		addFact("string_byte_length_test #5", function() {
			
			// Check correct byte length is returned for a string containing a variety of multi-byte UTF-8 chars
			var someSymbols = "‰ˆ‡†•";
			var someSymbolsLen = string_byte_length(someSymbols);
			assert_equals(someSymbolsLen, 14, "string_byte_length( string local ), '‰ˆ‡†•' as a UTF-8 string should be 14 bytes long");
	    });
	
		addFact("string_byte_length_test #6", function() {
			
			// Check correct byte length is returned for a string containing a variety of multi-byte UTF-8 chars
			var aikido = "合気道";
			var aikidoLen = string_byte_length(aikido);
			assert_equals(aikidoLen, 9, "string_byte_length( string local ), '合気道' as a UTF-8 string should be 9 bytes long");
	    });
	
		addFact("string_byte_length_test #7", function() {
			
			// Check correct byte length is returned for a string containing a variety of multi-byte UTF-8 chars
			var kotegaeshi = "小手返";
			var kotegaeshiLen = string_byte_length(kotegaeshi);
			assert_equals(kotegaeshiLen, 9, "string_byte_length( string local ), '小手返' as a UTF-8 string should be 9 bytes long");
	    });
	
		addFact("string_byte_length_test #8", function() {
			
			// Check correct byte length is returned for a string containing an emoji (4-byte UTF-8 char)
			var smileyFace = "🙂";
			var smileyFaceLen = string_byte_length(smileyFace);
			assert_equals(smileyFaceLen, 4, "string_byte_length( string local ), '🙂' as a UTF-8 string should be 4 bytes long");
	    });
	
		addFact("string_byte_length_test #9", function() {
			
			// Check correct byte length is returned for a string literal containing an emoji (4-byte UTF-8 char)
			assert_equals(string_byte_length("🙂"), 4, "string_byte_length( string const ), '🙂' as a UTF-8 string should be 4 bytes long");
	    });
	
		addFact("string_byte_length_test #10", function() {
			
			// Check correct byte length is returned for a string containing several emojis
			var emojiString = "💩👏✔";
			var emojiLen = string_byte_length(emojiString);
			assert_equals(emojiLen, 11, "string_byte_length( string local ), '💩👏✔' as a UTF-8 string should be 11 bytes long");
	    });
	}
	
	// STRING_CHAR_AT TESTS
	{
		addFact("string_char_at_test #1", function() {
        
			var vstring = "hello World!";
		
			// Check that char is returned correctly for standard input
			var res = string_char_at(vstring, 7);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "W", "string_char_at( string local , real const ), 7th char in 'hello World!' should be 'W'");
	    });
	
		addFact("string_char_at_test #2", function() {
        
			var vstring = "hello World!";
		
			// Check that using a decimal index above .5 will round down to the nearest integer
			var res = string_char_at(vstring, 7.6);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "W", "string_char_at( string local , real const ), 7.6th (rounded down to 7th) char in 'hello World!' should be 'W'");
	    });
	
		addFact("string_char_at_test #3", function() {
        
			var vstring = "hello World!";
		
			// Check that using a decimal index below .5 will round down to the nearest integer
			var res = string_char_at(vstring, 7.2);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "W", "string_char_at( string local , real const ), 7.2th (rounded down to 7th) char in 'hello World!' should be 'W'");
	    });
	
		addFact("string_char_at_test #4", function() {
        
			var vstring = "hello World!";
		
			// Check that using an index of 0 will be clamped to 1
			var res = string_char_at(vstring, 0);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "h", "string_char_at( string local , real const ), first char in 'hello World!' should be 'h'");
	    });
	
		addFact("string_char_at_test #5", function() {
        
			var vstring = "hello World!";
		
			// Check that using an index over the amount of chars in the string will be clamped to the last char in the string
			var res = string_char_at(vstring, 100);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "", "string_char_at( string local , real const ), 100th char in 'hello World!' should be ''");
	    });
	
		addFact("string_char_at_test #6", function() {
        
			var vstring = "hello World!";
		
			// Check that using a negative index will be clamped to the first byte in the string 
			var res = string_char_at(vstring, -2);
			assert_true(is_string(res), "string_char_at( string local , real const ), should return a string");
			assert_equals(res, "h", "string_char_at( string local , real const ), -2nd (clamped to first) char in 'hello World!' should be 'h'");
	    });
	
		addFact("string_char_at_test #7", function() {
			
			// Check that the correct char is returned with an int64 input
			var res = string_char_at(int64(1234), 2);
			assert_true(is_string(res), "string_char_at( int64 const , real const ), should return a string");
			assert_equals(res, "2", "string_char_at( int64 const , real const ), 2nd char in 1234 should be '2'");
	    });
	
		addFact("string_char_at_test #8", function() {
        
			// Check that the correct char is returned with a real input
			var res = string_char_at(1.234, 2);
			assert_true(is_string(res), "string_char_at( real const , real const ), should return a string");
			assert_equals(res, ".", "string_char_at( real const , real const ), 2nd char in 1.234 should be '.'");
	    });
	
		addFact("string_char_at_test #9", function() {
        
			var vstring = "hello World!";
		
			// Check that the correct char is returned with a bool input
			var res = string_char_at(true, 1);
			assert_true(is_string(res), "string_char_at( bool const , real const ), should return a string");
			assert_equals(res, "1", "string_char_at( bool const , real const ), 1st char in a true bool should be '1'");
	    });
	
		addFact("string_char_at_test #10", function() {
        
			#macro kString_StringCharAtTest "Hello World!"
		
			// Check that the function works with a macro input
			var res = string_char_at(kString_StringCharAtTest, 7);
			assert_equals(res, "W", "string_char_at( string macro , real const ), 7th char in 'hello World!' should be 'W'");
	    });
	
		addFact("string_char_at_test #11", function() {
        
			global.gstring = "Hello World!";
		
			// Check that the function works with a global input
			var res = string_char_at(global.gstring, 7);
			assert_equals(res, "W", "string_char_at( string global , real const ), 7th char in 'hello World!' should be 'W'");
	    });
	
		addFact("string_char_at_test #12", function() {
        
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			// Check that the function works with an instance input
			var res = string_char_at(_oTest.ostring, 7);
			assert_equals(res, "W", "string_char_at( string instance , real const ), 7th char in 'hello World!' should be 'W'");
		
			instance_destroy(_oTest);
	    });
	
		
		addFact("string_char_at_test #13", function() {
        
			// Check that a 1-byte UTF-8 is returned correctly
			var res = string_char_at("!£水🙂a", 1);
			assert_equals(res, "!", "string_char_at( string const , real const ), first char in '!£水🙂a' should be '!'");
	    });
	
		addFact("string_char_at_test #14", function() {
        
			// Check that a 2-byte UTF-8 is returned correctly
			var res = string_char_at("!£水🙂a", 2);
			assert_equals(res, "£", "string_char_at( string const , real const ), 2nd char in '!£水🙂a' should be '£'");
	    });
	
		addFact("string_char_at_test #15", function() {
        
			// Check that a 3-byte UTF-8 is returned correctly
			var res = string_char_at("!£水🙂a", 3);
			assert_equals(res, "水", "string_char_at( string const , real const ), 3rd char in '!£水🙂a' should be '水'");
	    });
	
		addFact("string_char_at_test #16", function() {
        
			// Check that a 4-byte UTF-8 is returned correctly
			var res = string_char_at("!£水🙂a", 4);
			assert_equals(res, "🙂", "#tring_char_at( string const , real const ), 4th char in '!£水🙂a' should be '🙂'");
	    });
	
		addFact("string_char_at_test #17", function() {
        
			// Check that a 1-byte UTF-8 is returned correctly at the end of a string of different byte-length UTF-8s
			var res = string_char_at("!£水🙂a", 5);
			assert_equals(res, "a", "string_char_at( string const , real const ), 5th char in '!£水🙂a' should be 'a'");
	    });
	}
	
	// STRING_COPY TESTS
	{
		addFact("string_copy_test #1", function() {
			
			// Check that a substring can be copied from the start of the input string correctly
			var helloWorldStr = "Hello World";
			var helloStr = string_copy(helloWorldStr, 1, 5);
			assert_equals(helloStr, "Hello", "string_copy( string local , real const , real const ), The first 5 chars of 'Hello World' should be 'hello'");
	    });
	
		addFact("string_copy_test #2", function() {
			
			// Check that a substring can be copied from the middle of the input string correctly
			var helloWorldStr = "Hello World";
			var worldStr = string_copy(helloWorldStr, 7, 5);
			assert_equals(worldStr, "World", "string_copy( string local , real const , real const ), 5 chars from the 7th char of 'Hello World' should be 'World'");
	    });
	
		addFact("string_copy_test #3", function() {
        
			// Check that a string with a 2-byte UTF-8 char can be copied correctly
			var fullPriceStr = "£12.34";
			var poundPriceStr = string_copy(fullPriceStr, 1, 3);
			var pencePriceStr = string_copy(fullPriceStr, 5, 2);
			assert_equals(poundPriceStr, "£12", "string_copy( string local , real const , real const ), The first 3 chars of '£12.34' should be '£12'");
			assert_equals(pencePriceStr, "34", "string_copy( string local , real const , real const ), 2 chars from the 5th char of '£12.34' should be '34'");
	    });
	
		addFact("string_copy_test #4", function() {
			
			// Check that a string with a 3-byte UTF-8 char can be copied correctly
			var fullEuroStr = "€56.78";
			var euroPriceStr = string_copy(fullEuroStr, 1, 3);
			var centsPriceStr = string_copy(fullEuroStr, 5, 2);
			assert_equals(euroPriceStr, "€56", "string_copy( string local , real const , real const ), The first 3 chars of '€56.78' should be '€56'");
			assert_equals(centsPriceStr, "78", "string_copy( string local , real const , real const ), 2 chars from the 5th char of '£12.34' should be '78'");
	    });
	
		addFact("string_copy_test #5", function() {
			
			// Check that a string with several 3-byte UTF-8 chars can be copied correctly
			var aikido = "合気道";
			var aiki = string_copy(aikido, 1, 2);
			assert_equals(aiki, "合気", "string_copy( string local , real const , real const ), The first 2 chars from '合気道' should be '合気'");
	    });
	
		addFact("string_copy_test #6", function() {
			
			// Check that a string with several 3-byte UTF-8 chars and regular chars can be copied correctly
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestStr = string_copy(kotegaeshi, 5, 4);
			assert_equals(kotegaeshiTestStr, "Test", "string_copy( string local , real const , real const ), 4 chars from the 5th char of '小手返 Test' should be 'Test'");
	    });
	
		addFact("string_copy_test #7", function() {
			
			// Check that a string with a 4-byte UTF-8 char can be copied correctly
			var smileyTestString = "This is a test 🙂";
			var smileyString = string_copy(smileyTestString, 16, 1);
			assert_equals(smileyString, "🙂", "string_copy( string local , real const , real const ), The 16th char of 'This is a test 🙂' should be '🙂'");
	    });
	
		addFact("string_copy_test #8", function() {
			
			// Check that a string literal with a 4-byte UTF-8 char can be copied correctly
			var smileyPosLiteral = string_copy("This is a test 🙂", 16, 1);
			assert_equals(smileyPosLiteral, "🙂", "string_copy( string const , real const , real const ), The 16th char of 'This is a test 🙂' should be '🙂'");
	    });
	
		addFact("string_copy_test #9", function() {
			
			// Check that a string with several 4-byte UTF-8 chars can be copied correctly
			var emojiString = "✔✔✔💩👏";
			var clapEmojiStr = string_copy(emojiString, 5, 1);
			assert_equals(clapEmojiStr, "👏", "string_copy( string local , real const , real const ), The 5th char of '✔✔✔💩👏' should be '👏'");
	    });
	
		addFact("string_copy_test #10", function() {
			
			// Check that a string with several 4-byte UTF-8 chars and regular chars can be copied correctly
			var emojiString = "✔✔✔💩👏 hello world";
			var clapEmojiStr = string_copy(emojiString, 5, 13);
			assert_equals(clapEmojiStr, "👏 hello world", "string_copy( string local , real const , real const ), 5 chars from the 13th char of '✔✔✔💩👏' should be '👏 hello world'");
	    });
	}
	
	// STRING_COUNT TESTS
	{
		addFact("string_count_test #1", function() {
			
			// Check single chars are correctly counted
			var helloWorldStr = "Hello World";
			var numLs = string_count("l", helloWorldStr);
			var numOs = string_count("o", helloWorldStr);
			assert_equals(numLs, 3, "string_count( string const , string local ), 'Hello World' should have 3 'l's");
			assert_equals(numOs, 2, "string_count( string const , string local ), 'Hello World' should have 2 'o's");
	    });
	
		addFact("string_count_test #2", function() {
			
			// Check strings are correctly counted
			var helloWorldStr = "Hello World";
			var numHellos = string_count("Hello", helloWorldStr);
			var numWorlds = string_count("World", helloWorldStr);
			assert_equals(numHellos, 1, "string_count( string const , string local ), 'Hello World' should have 1 'Hello'");
			assert_equals(numWorlds, 1, "string_count( string const , string local ), 'Hello World' should have 1 'World'");
	    });
	
		addFact("string_count_test #3", function() {
        
			// Check 2-byte UTF-8 symbol is correctly counted
			var poundStr = "£12.34";
			var numPounds = string_count("£", poundStr);
			assert_equals(numPounds, 1, "string_count( string const , string local ), '£12.34' should have 1 '£'");
	    });
	
		addFact("string_count_test #4", function() {
			
			// Check regular char is correctly counted in string with a 2-byte UTF-8 symbol
			var ninesStr = "£999.99";
			var numNines = string_count("9", ninesStr);
			assert_equals(numNines, 5, "string_count( string const , string local ), '£999.99' should have 5 '9's");
	    });
	
		addFact("string_count_test #5", function() {
			
			// Check 3-byte UTF-8 symbol is correctly counted
			var euroStr = "€12.34";
			var numEuros = string_count("€", euroStr);
			assert_equals(numEuros, 1, "string_count( string const , string local ), '€12.34' should have 1 '€'");
	    });
	
		addFact("string_count_test #6", function() {
			
			// Check regular char is correctly counted in string with a 3-byte UTF-8 symbol
			var fivesStr = "€12555.55";
			var numFives = string_count("5", fivesStr);
			assert_equals(numFives, 5, "string_count( string const , string local ), '€12555.55' should have 5 '5's");
	    });
		
		addFact("string_count_test #7", function() {
			
			// Check 3-byte UTF-8 symbols are correctly counted in string with other 3-byte UTF-8 symbols
			var aikido = "合気道合気道合気道合気道";
			var numAi = string_count("合", aikido);
			assert_equals(numAi, 4, "string_count( string const , string local ), '合気道合気道合気道合気道' should have 4 '合's");
	    });
	
		addFact("string_count_test #8", function() {
			
			// Check 4-byte UTF-8 symbol is correctly counted
			var smileyString = "This is a test 🙂";
			var numSmileys = string_count("🙂", smileyString);
			assert_equals(numSmileys, 1, "string_count( string const , string local ), 'This is a test 🙂' should have 1 '🙂'");
	    });
	
		addFact("string_count_test #9", function() {
			
			// Check 4-byte UTF-8 symbol is correctly counted in string with other 4-byte UTF-8 symbols
			var emojiString = "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎";
			var numDiamonds = string_count("💎", emojiString);
			assert_equals(numDiamonds, 4, "string_count( string const , string local ), The string should have 4 '💎's");
	    });
	}
	
	// STRING_DELETE TESTS
	{
		addFact("string_delete_test #1", function() {
        
			var vstring = "Hello World!";
		
			// Check single char can be correctly deleted
			var res = string_delete(vstring, 7, 1);
			assert_equals(res, 
			"Hello orld!", "string_delete( string local , real const , real const ), 'Hello World!' with the 7th char deleted should be 'Hello orld!'");
	    });
	
		addFact("string_delete_test #2", function() {
        
			var vstring = "Hello World!";
		
			// Check multiple chars can be correctly deleted
			var res = string_delete(vstring, 7, 2);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 2 chars from the 7th char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #3", function() {
        
			var vstring = "Hello World!";
		
			// Check that using a count over the amount of chars in the string will delete all chars from the index onwards
			var res = string_delete(vstring, 7, 50);
			assert_equals(res, "Hello ", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 50 chars from the 7th char deleted should be 'Hello '");
	    });
	
		addFact("string_delete_test #4", function() {
        
			var vstring = "Hello World!";
		
			// Check that using a count of 0 will leave the string unchanged
			var res = string_delete(vstring, 7, 0);
			assert_equals(res, "Hello World!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 0 chars from the 7th char deleted should be 'Hello World!'");
	    });
	
		addFact("string_delete_test #5", function() {
        
			var vstring = "Hello World!";
		
			// Check that using a count of -1 will become 1
			var res = string_delete(vstring, 7, -1);
			assert_equals(res, "Hello orld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with -1 (becomes +1) chars from the 7th char deleted should be 'Hello orld!'");
	    });
	
		addFact("string_delete_test #6", function() {
        
			var vstring = "Hello World!";
		
			// Check that using an index beyond the size of the string will leave the string unchanged
			var res = string_delete(vstring, 100, 1);
			assert_equals(res, "Hello World!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with the 100th char deleted should be 'Hello World!'");
	    });
	
		addFact("string_delete_test #7", function() {
        
			var vstring = "Hello World!";
		
			// Check that using an index of 0 will delete the first character
			var res = string_delete(vstring, 0, 1);
			assert_equals(res, "ello World!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with the first char deleted should be 'ello World!'");
	    });
	
		addFact("string_delete_test #8", function() {
        
			var vstring = "Hello World!";
		
			// Check that using a negative index leave the string unchanged
			var res = string_delete(vstring, -1, 1);
			assert_equals(res, "Hello World", 
			"string_delete( string local , real const , real const ), 'Hello World!' with the -1th char deleted should be 'Hello World!'");
	    });
	
		addFact("string_delete_test #9", function() {
        
			var vstring = "Hello World!";
		
			// Check that a count with a decimal place below .5 will be rounded down to the nearest integer
			var res = string_delete(vstring, 7, 2.4);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 2.4 chars (rounded to 2) from the 7th char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #10", function() {
        
			var vstring = "Hello World!";
		
			// Check that a count with a decimal place above .5 will be rounded down to the nearest integer
			var res = string_delete(vstring, 7, 2.6);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 2.6 chars (rounded to 2) from the 7th char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #11", function() {
        
			var vstring = "Hello World!";
		
			// Check that an index with a decimal place below .5 will be rounded down to the nearest integer
			var res = string_delete(vstring, 7.2, 2);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 2 chars from the 7.2th (rounded to 7th) char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #12", function() {
        
			var vstring = "Hello World!";
		
			// Check that an index with a decimal place above .5 will be rounded down to the nearest integer
			var res = string_delete(vstring, 7.6, 2);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , real const ), 'Hello World!' with 2 chars from the 7.2th (rounded to 7th) char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #13", function() {
        
			var vstring = "Hello World!";
		
			// Check that a number in a string can be used as a valid index
			var res = string_delete(vstring, "7", 2);
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , string const , real const ), 'Hello World!' with 2 chars from the 7th char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #14", function() {
        
			var vstring = "Hello World!";
		
			// Check that a number in a string can be used as a valid count
			var res = string_delete(vstring, 7, "2");
			assert_equals(res, "Hello rld!", 
			"string_delete( string local , real const , string const ), 'Hello World!' with 2 chars from the 7th char deleted should be 'Hello rld!'");
	    });
	
		addFact("string_delete_test #15", function() {
        
			// Check that deleting a char from an empty string does nothing
			var res = string_delete("", 1, 1);
			assert_equals(res, "", 
			"string_delete( string const , real const , string const ), '' with the first char deleted should be ''");
	    });
	
		addFact("string_delete_test #16", function() {
        
			// Check that an int64 can be used as a valid input string
			var res = string_delete(int64(1234), 2, 1);
			assert_true(is_string(res), "string_delete( int64 const , real const, real const ), should return a string");
			assert_equals(res, "134", 
			"string_delete( int64 const , real const , real const ), 1234 with the 2nd char deleted should be '134'");
	    });
	
		addFact("string_delete_test #17", function() {
        
			// Check that a real can be used as a valid input string
			var res = string_delete(1.234, 2, 1);
			assert_true(is_string(res), "string_delete( real const , real const, real const ), should return a string");
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "123", 
			"string_delete( real const , real const, real const ), 1.234 with the 2nd char deleted should be '123'"); 
	    });
	
		addFact("string_delete_test #18", function() {
			
			// Check that a bool can be used as a valid input string
			var res = string_delete(true, 1, 1);
			assert_true(is_string(res), "string_delete( bool const , real const, real const ), should return a string");
			assert_equals(res, "", 
			"string_delete( bool const , real const, real const ), a true bool with the first char deleted should be ''");
	    });
	
		addFact("string_delete_test #19", function() {
        
			#macro kString_StringDeleteTest "Hello World!"
		
			// Check that the function works correctly with a macro input
			var res = string_delete(kString_StringDeleteTest, 7, 1);
			assert_equals(res, "Hello orld!", 
			"string_delete( string macro , real const , real const ), 'Hello World!' with the 7th char deleted should be 'Hello orld!'");
	    });
	
		addFact("string_delete_test #20", function() {
        
			global.gstring = "Hello World!";
		
			// Check that the function works correctly with a global input
			var res = string_delete(global.gstring, 7, 1);
			assert_equals(res, "Hello orld!", 
			"string_delete( string global , real const , real const ), 'Hello World!' with the 7th char deleted should be 'Hello orld!'");
	    });
	
		addFact("string_delete_test #21", function() {
        
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			// Check that the function works correctly with an instance input
			var res = string_delete(_oTest.ostring, 7, 1);
			assert_equals(res, "Hello orld!", 
			"string_delete( string instance , real const , real const ), 'Hello World!' with the 7th char deleted should be 'Hello orld!'");
		
			instance_destroy(_oTest);
	    });
	
		addFact("string_delete_test #22", function() {
        
			// Check that 2-byte UTF-8 chars can be deleted correctly
			var res = string_delete("Price: £3.99", 1, 8);
			assert_equals(res, "3.99", "string_delete( string const , real const , real const ), 2 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #23", function() {
        
			// Check that 3-byte UTF-8 chars can be deleted correctly
			var res = string_delete("Mizu (水)", 5, 4);
			assert_equals(res, "Mizu", "string_delete( string const , real const , real const ), 3 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #24", function() {
        
			// Check that 4-byte UTF-8 chars can be deleted correctly
			var res = string_delete("🙂", 1, 1);
			assert_equals(res, "", "string_delete( string const , real const , real const ), 4 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #25", function() {
        
			// Check that a standard char can be deleted in a string with 2 4-byte UTF-8 chars
			var res = string_delete("🙂x🙂", 2, 1);
			assert_equals(res, "🙂🙂", "string_delete( string const , real const , real const ), 2x4 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #26", function() {
        
			// Check that a standard char can be deleted in a string with 3 4-byte UTF-8 chars
			var res = string_delete("🙂x🙂x🙂", 4, 1);
			assert_equals(res, "🙂x🙂🙂", "string_delete( string const , real const , real const ), 3x4 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #27", function() {
        
			// Check that a standard char can be deleted in a string with 4 4-byte UTF-8 chars
			var res = string_delete("🙂x🙂x🙂x🙂", 6, 1);
			assert_equals(res, "🙂x🙂x🙂🙂", "string_delete( string const , real const , real const ), 4x4 byte UTF8 incorrectly deleted");
	    });
	
		addFact("string_delete_test #28", function() {
        
			// Check that a 4-byte UTF-8 char can be deleted in a string with multiple other 4-byte UTF-8 chars
			var res = string_delete("🙂x🙂x🙂x🙂", 5, 1);
			assert_equals(res, "🙂x🙂xx🙂", "string_delete( string const , real const , real const ), 4x4 byte UTF8 incorrectly deleted");
	    });
	}
	
	// STRING_DIGITS TESTS
	{
		addFact("string_digits_test #1", function() {
        
			var vstring1 = "321!HeLlO WoRlD!123";
		
			// check that digits are correctly isolated in a standard string
			var res = string_digits(vstring1);
			assert_equals(res, "321123", "string_digits( string local ), incorrect value returned for string with letters & digits");
	    });
	
		addFact("string_digits_test #2", function() {
        
			var vstring2 = "!£水🙂";
		
			// check no digits are found in a string of symbols
			var res = string_digits(vstring2);
			assert_equals(res, "", "string_digits( string local ), incorrect value returned for string with no digits");
	    });
	
		addFact("string_digits_test #3", function() {
        
			var vstring3 = "";
		
			// check no digits are found in on empty string
			var res = string_digits(vstring3);
			assert_equals(res, "", "string_digits( string local ), incorrect value returned for empty string");
	    });
	
		addFact("string_digits_test #4", function() {
        
			var vstring4 = "1234";
		
			// check that digits are correctly isolated in a string of only digits
			var res = string_digits(vstring4);
			assert_equals(res, "1234", "string_digits( string local ), incorrect value returned for string with only digits");
	    });
	
		addFact("string_digits_test #5", function() {
        		
			// check that digits are correctly isolated from a real input
			var res = string_digits(1234);
			assert_equals(res, "1234", "string_digits( real const ), incorrect value returned for real input");
	    });
	
		addFact("string_digits_test #6", function() {
        		
			// check that digits are correctly isolated from a real input with a decimal place
			var res = string_digits(1.234);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "123", "string_digits( real const ), incorrect value returned for decimal real input");
	    });
	
		addFact("string_digits_test #7", function() {
        		
			#macro kString_StringDigitsTest "321!Hello World!123"
		
			// Check that the function works correctly with a macro input
			var res = string_digits(kString_StringDigitsTest);
			assert_equals(res, "321123", "string_digits( string macro ), incorrect value returned for macro string");
	    });
	
		addFact("string_digits_test #8", function() {
        		
			global.gstring = "321!Hello World!123";
		
			// Check that the function works correctly with a global input
			var res = string_digits(global.gstring);
			assert_equals(res, "321123", "string_digits( string global ), incorrect value returned for global string");
	    });
	
		addFact("string_digits_test #9", function() {
        		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			// Check that the function works correctly with an instance input
			var res = string_digits(_oTest.ostring);
			assert_equals(res, "321123", "string_digits( string instance ), incorrect value returned for instance string");
			
			instance_destroy(_oTest);
	    });
	}
	
	// STRING_FORMAT TESTS
	{
		addFact("string_format_test #1", function() {
        		
			// Check that formatting a number to the number of places it already has just turns the number to a string
			var testNum = 123456;
			var testStr = string_format(testNum, 6, 0);
			assert_equals(testStr, "123456", 
			"string_format( real local , real const , real const ), formatting 123456 to 6 places should return '123456'");
		});
	
		addFact("string_format_test #2", function() {
        		
			// Check that all digits can be formatted correctly
			var testStr2 = string_format(123456789, 9, 0);
			assert_equals(testStr2, "123456789", 
			"string_format( real const , real const , real const ), formatting literal 123456789 to 9 places should return '123456789'");
		});
	
		addFact("string_format_test #3", function() {
        		
			// Check that formatting a non-decimal number with decimal places adds trailing decimal 0s
			var testStr3 = string_format(123, 3, 3);
			assert_equals(testStr3, "123.000", 
			"string_format( real const , real const , real const ), formatting 123 to 3 places & 3 decimal places should return '123.000'");
		});
	
		addFact("string_format_test #4", function() {
        		
			var fracNum = 123.456;
			
			// Check that formatting a number with decimal places works correcly
			var fracStr = string_format(fracNum, 3, 3);
			assert_equals(fracStr, "123.456", 
			"string_format( real local , real const , real const ), formatting 123.456 to 3 places & 3 decimal places should return '123.456'");
		});
	
		addFact("string_format_test #5", function() {
        		
			var fracNum = 123.456;
			
			// Check that places and decimal places beyond a decimal number will add leading spaces and trailing 0s
			var fracStr2 = string_format(fracNum, 6, 6);
			assert_equals(fracStr2, "   123.456000", 
			"string_format( real local , real const , real const ), formatting 123.456 to 6 places & 6 decimal places should return '   123.456000'");
		});
	
		addFact("string_format_test #6", function() {
        		
			var fracNum = 123.456;
			
			// Check that not including decimal places for a decimal number will cut off the decimals
			var fracStr3 = string_format(fracNum, 3, 0);
			assert_equals(fracStr3, "123", 
			"string_format( real local , real const , real const ), formatting 123.456 to 3 places should return '123'");
		});
	}
	
	// STRING_HASH_TO_NEWLINE TESTS
	{
		addFact("string_hash_to_newline_test #1", function() {

			// check that hashes are correctly converted to new lines for a standard string input
			var helloWorldOld = "Hello#World";
			var helloWorldNew = string_hash_to_newline(helloWorldOld);
			assert_equals(helloWorldNew, "Hello\r\nWorld", "string_hash_to_newline( string local ), 'Hello#World' should become 'Hello\\r\\nWorld'");
		});
	
		addFact("string_hash_to_newline_test #2", function() {
        	
			// check that hashes are correctly converted to new lines for a string with a 2-byte UTF-8 character
			var priceString  = "£99#99";
			var priceSplit = string_hash_to_newline(priceString);
			assert_equals(priceSplit, "£99\r\n99", "string_hash_to_newline( string local ), '£99#99' should become '£99\\r\\n99'");
		});
	
		addFact("string_hash_to_newline_test #3", function() {
        	
			// check that hashes are correctly converted to new lines for a string with a 3-byte UTF-8 character
			var euroString = "€99#99";
			var euroSplit = string_hash_to_newline(euroString);
			assert_equals(euroSplit, "€99\r\n99", "string_hash_to_newline( string local ), '€99#99' should become '€99\\r\\n99'");
		});
	
		addFact("string_hash_to_newline_test #4", function() {
        	
			// check that hashes are correctly converted to new lines for a string with 4-byte UTF-8 characters
			var emojiString = "👏👏#👏";
			var emojiSplit = string_hash_to_newline(emojiString);
			assert_equals(emojiSplit, "👏👏\r\n👏", "string_hash_to_newline( string local ), '👏👏#👏' should become '👏👏\\r\\n👏'");
		});
	}
	
	// STRING_INSERT TESTS
	{
		addFact("string_insert_test #1", function() {
        		
			var vstring = "Hello World!";
		
			// Check that inserting a substring at the start of a standard string works correctly
			var res = string_insert("xx", vstring, 1);
			assert_equals(res, "xxHello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 1 should be 'xxHello World!'");
		});
	
		addFact("string_insert_test #2", function() {
        		
			var vstring = "Hello World!";
		
			// Check that inserting a substring in the middle of a standard string works correctly
			var res = string_insert("xx", vstring, 2);
			assert_equals(res, "Hxxello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 2 should be 'Hxxello World!'");
		});
	
		addFact("string_insert_test #3", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using an index over the string length inserts at the end of the string
			var res = string_insert("xx", vstring, 50);
			assert_equals(res, "Hello World!xx", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 50 (over string length) should be 'Hello World!xx' (inserts at end of string)");
		});
	
		addFact("string_insert_test #4", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using an index of 0 inserts at the start of the string
			var res = string_insert("xx", vstring, 0);
			assert_equals(res, "xxHello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 0 (clamps to index 1) should be 'xxHello World!'");
		});
	
		addFact("string_insert_test #5", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using an index of -1 inserts at the start of the string
			var res = string_insert("xx", vstring, -1);
			assert_equals(res, "xxHello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index -1 (clamps to index 1) should be 'xxHello World!'");
		});
	
		addFact("string_insert_test #6", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using a decimal index below .5 will round down to the nearest integer
			var res = string_insert("xx", vstring, 2.4);
			assert_equals(res, "Hxxello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 2.4 (rounds down to index 2) should be 'Hxxello World!'");
		});
	
		addFact("string_insert_test #7", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using a decimal index above .5 will round down to the nearest integer
			var res = string_insert("xx", vstring, 2.6);
			assert_equals(res, "Hxxello World!", 
			"string_insert( string const , string local , real const ), 'Hello World!' with 'xx' inserted at index 2.6 (rounds down to index 2) should be 'Hxxello World!'");
		});
	
		addFact("string_insert_test #8", function() {
        		
			var vstring = "Hello World!";
		
			// Check that using a string index can be used correctly
			var res = string_insert("xx", vstring, "2");
			assert_equals(res, "Hxxello World!", 
			"string_insert( string const , string local , string const ), 'Hello World!' with 'xx' inserted at index '2' should be 'Hxxello World!'");
		});
	
		addFact("string_insert_test #9", function() {
			
			// Check that inserting into an empty string works correctly
			var res = string_insert("xx", "", 1);
			assert_equals(res, "xx", 
			"string_insert( string const , string const , real const ), '' with 'xx' inserted at index 1 should be 'xx'");
		});
	
		addFact("string_insert_test #10", function() {
        		
			// Check that inserting into an empty string at an index over 1 works correctly
			var res = string_insert("xx", "", 10);
			assert_equals(res, "xx", 
			"string_insert( string const , string const , real const ), '' with 'xx' inserted at index 10 should be 'xx'");
		});
	
		addFact("string_insert_test #11", function() {
        		
			// Check that inserting into an empty string at a negative index works correctly
			var res = string_insert("xx", "", -10);
			assert_equals(res, "xx", 
			"string_insert( string const , string const , real const ), '' with 'xx' inserted at index -10 should be 'xx'");
		});
	
		addFact("string_insert_test #12", function() {
        		
			var vstring = "Hello World!";
		
			// Check that an int64 can be correctly inserted into
			var res = string_insert("xx", int64(1234), 1);
			assert_true(is_string(res), "string_insert( string const , int64 local , real const ), should return string");
			assert_equals(res, "xx1234", 
			"string_insert( string const , int64 local , real const ), an int64 value of 1234 with 'xx' inserted at index 1 should be 'xx1234'");
		});
	
		addFact("string_insert_test #13", function() {
        		
			var vstring = "Hello World!";
		
			// Check that a decimal real can be correctly inserted into
			var res = string_insert("xx", 1.234, 1);
			assert_true(is_string(res), "string_insert( string const , real local , real const ), should return string");
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "xx1.23", 
			"string_insert( string const , real local , real const ), 1.234 with 'xx' inserted at index 1 should be 'xx1.23'");
		});
	
		addFact("string_insert_test #14", function() {
        		
			var vstring = "Hello World!";
		
			// Check that a bool can be correctly inserted into
			var res = string_insert("xx", true, 1);
			assert_true(is_string(res), "string_insert( string const , bool local , real const ), should return string");
			assert_equals(res, "xx1", 
			"string_insert( string const , bool local , real const ), a true bool with 'xx' inserted at index 1 should be 'xx1'");
		});
	
		addFact("string_insert_test #15", function() {
        		
			#macro kString_StringInsertTest "Hello World!"
		
			// Check that the function works correctly with a macro input
			var res = string_insert("xx", kString_StringInsertTest, 8);
			assert_equals(res, "Hello Wxxorld!", 
			"string_insert( string const , string macro , real const ), 'Hello World!' with 'xx' inserted at index 8 should be 'Hello Wxxorld!'");
		});
	
		addFact("string_insert_test #16", function() {
        		
			global.gstring = "Hello World!";
		
			// Check that the function works correctly with a global input
			var res = string_insert("xx", global.gstring, 8);
			assert_equals(res, "Hello Wxxorld!", 
			"string_insert( string const , string global , real const ), 'Hello World!' with 'xx' inserted at index 8 should be 'Hello Wxxorld!'");
		});
	
		addFact("string_insert_test #17", function() {
        		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			// Check that the function works correctly with a instance input
			var res = string_insert("xx", _oTest.ostring, 8);
			assert_equals(res, "Hello Wxxorld!", 
			"string_insert( string const , string instance , real const ), 'Hello World!' with 'xx' inserted at index 8 should be 'Hello Wxxorld!'");
		
			instance_destroy(_oTest)
		});
	
		addFact("string_insert_test #18", function() {

			// Check that a 2-byte UTF-8 value can be correctly inserted
			var res = string_insert("£", "Price: 3.99", 8);
			assert_equals(res, "Price: £3.99", 
			"string_insert( string const , string const , real const ), 2-byte UTF8 '£' incorrectly inserted");
		});
	
		addFact("string_insert_test #19", function() {

			// Check that a 3-byte UTF-8 value can be correctly inserted
			var res = string_insert("水", "Mizu () is the kanji symbol for water", 7);
			assert_equals(res, "Mizu (水) is the kanji symbol for water", 
			"string_insert( string const , string const , real const ), 3-byte UTF8 '水' incorrectly inserted");
		});
	
		addFact("string_insert_test #20", function() {

			// Check that a 4-byte UTF-8 value can be correctly inserted
			var res = string_insert("🙂", "", 1);
			assert_equals(res, "🙂", 
			"string_insert( string const , string const , real const ), 4-byte UTF8 '🙂' incorrectly inserted into empty string");
		});
		
		addFact("string_insert_test #21", function() {

			// Check that a 4-byte UTF-8 value can be correctly inserted into a local string
			var aString = "aaa";
			var res = string_insert("🙂", aString, 2);
			assert_equals(res, "a🙂aa", 
			"string_insert( string const , string local , real const ), 'aaa' with '🙂' inserted at index 8 should be 'a🙂aa'");
		});
	
		addFact("string_insert_test #22", function() {
			
			// Check that a regular char can be correctly inserted into a string with multiple 4-byte UTF-8 chars in it
			var smileyString = "🙂🙂🙂";
			var res = string_insert("a", smileyString, 2);
			assert_equals(res, "🙂a🙂🙂", 
			"string_insert( string const , string local , real const ), '🙂🙂🙂' with 'a' inserted at index 8 should be '🙂a🙂🙂'");
		});
	
		addFact("string_insert_test #23", function() {
			
			// Check that several regular chars can be correctly inserted into a string with multiple 4-byte UTF-8 chars in it
			var smileyString = "🙂🙂🙂";
			var res = string_insert("aa", smileyString, 3);
			assert_equals(res, "🙂🙂aa🙂", 
			"string_insert( string const , string local , real const ), '🙂🙂🙂' with 'aa' inserted at index 8 should be '🙂aa🙂🙂'");
		});
	
		addFact("string_insert_test #24", function() {
			
			// Check that a 4-byte UTF-8 char can be correctly inserted into a string with multiple 4-byte UTF-8 chars in it
			var smileyString = "🙂🙂🙂";
			var res = string_insert("🙂", smileyString, 3);
			assert_equals(res, "🙂🙂🙂🙂", 
			"string_insert( string const , string local , real const ), '🙂🙂🙂' with '🙂' inserted at index 8 should be '🙂🙂🙂🙂'");
		});
	
		addFact("string_insert_test #25", function() {
			
			// Check that multiple 4-byte UTF-8 chars can be correctly inserted into a string with multiple 4-byte UTF-8 chars in it
			var smileyString = "🙂🙂🙂";
			var res = string_insert("🙂🙂", smileyString, 3);
			assert_equals(res, "🙂🙂🙂🙂🙂", 
			"string_insert( string const , string local , real const ), '🙂🙂🙂' with '🙂🙂' inserted at index 8 should be '🙂🙂🙂🙂🙂'");
		});
	}
	
	// STRING_LAST_POS_EXT TESTS
	{
		addFact("string_last_pos_ext_test #1", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that substrings within a standard string can be found correctly
			var helloPos = string_last_pos_ext("Hello", helloWorldStr, numChars);
			var worldPos = string_last_pos_ext("world", helloWorldStr, numChars);
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, numChars);
			assert_equals(helloPos, 13, 
			"string_last_pos_ext( string const , string local , real local ), 'Hello' should be found in 'Hello world!Hello world!' at char 13");
			assert_equals(worldPos, 19, 
			"string_last_pos_ext( string const , string local , real local ), 'world' should be found in 'Hello world!Hello world!' at char 19");
			assert_equals(exclamationPos, 24, 
			"string_last_pos_ext( string const , string local , real local ), '!' should be found in 'Hello world!Hello world!' at char 24");
		});
	
		addFact("string_last_pos_ext_test #2", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that substrings within a standard string can be found correctly when starting halfway through it
			var helloPos = string_last_pos_ext("Hello", helloWorldStr, (numChars/2));
			var worldPos = string_last_pos_ext("world", helloWorldStr, (numChars/2));
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2));
			assert_equals(helloPos, 1, 
			"string_last_pos_ext( string const , string local , real const ), 'Hello' should be found in 'Hello world!Hello world!' at char 1 when starting halfway through");
			assert_equals(worldPos, 7, 
			"string_last_pos_ext( string const , string local , real const ), 'world' should be found in 'Hello world!Hello world!' at char 7 when starting halfway through");
			assert_equals(exclamationPos, 12, 
			"string_last_pos_ext( string const , string local , real const ), '!' should be found in 'Hello world!Hello world!' at char 12 when starting halfway through");
		});
	
		addFact("string_last_pos_ext_test #3", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that a substring is not found when starting before any occurences of it
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2)-1);
			assert_equals(exclamationPos, 0, 
			"string_last_pos_ext( string const , string local , real const ), '!' should not be found in 'Hello world!Hello world!' when starting before halfway");
		});
	
		addFact("string_last_pos_ext_test #4", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that a substring is not found when it doesn't exist in the string
			var longPos = string_last_pos_ext(helloWorldStr, "!", numChars);
			assert_equals(longPos, 0, 
			"string_last_pos_ext( string local , string const , real local ), 'Hello world!Hello world!' should not be found in '!'");
		});
	
		addFact("string_last_pos_ext_test #5", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that a string can be found in itself
			var samePos = string_last_pos_ext(helloWorldStr, helloWorldStr, numChars);
			assert_equals(samePos, 1, 
			"string_last_pos_ext( string local , string local , real local ), string should be found in itself at char 1");
		});
	
		addFact("string_last_pos_ext_test #6", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that a substring can't be found when starting at the first char
			var zeroPos = string_last_pos_ext("Hello", helloWorldStr, 0);
			assert_equals(zeroPos, 0, 
			"string_last_pos_ext( string const , string local , real const ), string should not be found in when starting at char 0");
		});
	
		addFact("string_last_pos_ext_test #7", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			// Check that a substring can't be found when starting at a negative value
			var negPos = string_last_pos_ext("Hello", helloWorldStr, -1);
			assert_equals(negPos, 0, 
			"string_last_pos_ext( string const , string local , real const ), string should not be found in when starting at char -1");
		});
	
		addFact("string_last_pos_ext_test #8", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
		
			// Check that a substring cannot be found when letter cases don't match
			var helloNil = string_last_pos_ext("hello", helloWorldStr, numChars);
			assert_equals(helloNil, 0, 
			"string_last_pos_ext( string const , string local , real local ), 'hello' should not be found in 'Hello world!Hello world!'");
		});
	
		addFact("string_last_pos_ext_test #9", function() {
		
			
			var poundPrice = "£99.99";
			var numChars = string_length(poundPrice);
			
			// Check that a 2-byte UTF-8 char can be found
			var poundPos = string_last_pos_ext("£", poundPrice, numChars);
			assert_equals(poundPos, 1, 
			"string_last_pos_ext( string const , string local , real local ), '£' should be found in '£99.99' at char 1");
			var periodCharPos = string_last_pos_ext(".", poundPrice, numChars);
			assert_equals(periodCharPos, 4, 
			"string_last_pos_ext( string const , string local , real local ), '.' should be found in '£99.99' at char 4");
		});
	
		addFact("string_last_pos_ext_test #10", function() {

			var euroPrice = "€59.99";
			var numChars = string_length(euroPrice);
			
			// Check that a 3-byte UTF-8 char can be found
			var euroPos = string_last_pos_ext("€", euroPrice, numChars);
			assert_equals(euroPos, 1, 
			"string_last_pos_ext( string const , string local , real local ), '€' should be found in '€59.99' at char 1");
			var euroPeriodCharPos = string_last_pos_ext(".", euroPrice, numChars);
			assert_equals(euroPeriodCharPos, 4, 
			"string_last_pos_ext( string const , string local , real local ), '.' should be found in '€59.99' at char 4");
		});
	
		addFact("string_last_pos_ext_test #11", function() {

			var aikido = "合気道";
			var numChars = string_length(aikido);
			
			// Check that several 3-byte UTF-8 chars can be found
			var aiPos = string_last_pos_ext("合", aikido, numChars);
			var kiPos = string_last_pos_ext("気", aikido, numChars);
			var doPos = string_last_pos_ext("道", aikido, numChars);
			assert_equals(aiPos, 1, "string_last_pos_ext( string const , string local , real local ), '合' should be found in '合気道' at char 1");
			assert_equals(kiPos, 2, "string_last_pos_ext( string const , string local , real local ), '気' should be found in '合気道' at char 2");
			assert_equals(doPos, 3, "string_last_pos_ext( string const , string local , real local ), '道' should be found in '合気道' at char 3");
		});
	
		addFact("string_last_pos_ext_test #12", function() {

			var kotegaeshi = "小手返 Test";
			var numChars = string_length(kotegaeshi);
			
			// Check that a regular substring can be found in a string with 3-byte UTF-8 chars
			var kotegaeshiTestPos = string_last_pos_ext("Test", kotegaeshi, numChars);
			assert_equals(kotegaeshiTestPos, 5, 
			"string_last_pos_ext( string const , string local , real local ), 'test' should be found in '小手返 Test' at char 5");
		});
	
		addFact("string_last_pos_ext_test #13", function() {

			// Check that a 4-byte UTF-8 char can be found
			var smileyString = "This is a test 🙂";
			var smileyPos = string_last_pos_ext("🙂", smileyString, string_length(smileyString));
			assert_equals(smileyPos, 16, 
			"string_last_pos_ext( string const , string local , real const ), '🙂' should be found in 'This is a test 🙂' at char 16");
		});
	
		addFact("string_last_pos_ext_test #14", function() {
			
			// Check that a 4-byte UTF-8 char literal can be found
			var smileyPosLiteral = string_last_pos_ext("🙂", "This is a test 🙂", 16);
			assert_equals(smileyPosLiteral, 16, 
			"string_last_pos_ext( string const , string const , real const ), '🙂' should be found in 'This is a test 🙂' (as literal) at char 16");
		});
	
		addFact("string_last_pos_ext_test #15", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars
			var emojiString = "✔✔✔💩👏";
			var res = string_last_pos_ext("👏", emojiString, string_length(emojiString));
			assert_equals(res, 5, 
			"string_last_pos_ext( string const , string local , real const ), '👏' should be found in '✔✔✔💩👏' at char 5");
		});
	
		addFact("string_last_pos_ext_test #16", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_last_pos_ext("👏", moreEmojiString, string_length(moreEmojiString));
			assert_equals(res, 8, 
			"string_last_pos_ext( string const , string local , real const ), '👏' should be found in '✔✔✔💩😀😁😂👏' at char 8");
		});
	
		addFact("string_last_pos_ext_test #17", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars & regular chars
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_last_pos_ext("👏", emojiString3, string_length(emojiString3));
			assert_equals(res, 10, 
			"string_last_pos_ext( string const , string local , real const ), '👏' should be found in '✔✔✔💩😀aa😁😂👏' at char 10");
		});
	
		addFact("string_last_pos_ext_test #18", function() {
			
			// Check that a regular substring can be found in a string of 4-byte UTF-8 chars
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_last_pos_ext("aa", emojiString4, string_length(emojiString4));
			assert_equals(res, 9, 
			"string_last_pos_ext( string const , string local , real const ), 'aa' should be found in '✔✔✔💩😀😁😂👏aa' at char 9");
		});
	}
	
	// STRING_LAST_POS TESTS
	{
		addFact("string_last_pos_test #1", function() {
			
			// Check that substrings within a standard string can be found correctly
			var helloWorldStr = "Hello world!Hello world!";
			var helloPos = string_last_pos("Hello", helloWorldStr);
			var worldPos = string_last_pos("world", helloWorldStr);
			var exclamationPos = string_last_pos("!", helloWorldStr);
			assert_equals(helloPos, 13, 
			"string_last_pos( string const , string local ), 'Hello' should be found in 'Hello world!Hello world!' at char 13");
			assert_equals(worldPos, 19, 
			"string_last_pos( string const , string local ), 'world' should be found in 'Hello world!Hello world!' at char 19");
			assert_equals(exclamationPos, 24, 
			"string_last_pos( string const , string local ), '!' should be found in 'Hello world!Hello world!' at char 24");
		});
	
		addFact("string_last_pos_test #2", function() {
		
			var helloWorldStr = "Hello world!Hello world!";
		
			// Check that a substring that isn't in the input string isn't found
			var helloNil = string_last_pos("hello", helloWorldStr);
			assert_equals(helloNil, 0, 
			"string_last_pos( string const , string local ), 'hello' should not be found in 'Hello world!Hello world!'");
		});
	
		addFact("string_last_pos_test #3", function() {
		
			// Check that a 2-byte UTF-8 char can be found
			var poundPrice = "£99.99";
			var poundPos = string_last_pos("£", poundPrice);
			assert_equals(poundPos, 1, 
			"string_last_pos( string const , string local ), '£' should be found in '£99.99' at char 1");
			var periodCharPos = string_last_pos(".", poundPrice);
			assert_equals(periodCharPos, 4, 
			"string_last_pos( string const , string local ), '.' should be found in '£99.99' at char 4");
		});
	
		addFact("string_last_pos_test #4", function() {
			
			// Check that a 3-byte UTF-8 char can be found
			var euroPrice = "€59.99";
			var euroPos = string_last_pos("€", euroPrice);
			assert_equals(euroPos, 1, 
			"string_last_pos( string const , string local ), '€' should be found in '€59.99' at char 1");
			var euroPeriodCharPos = string_last_pos(".", euroPrice);
			assert_equals(euroPeriodCharPos, 4, 
			"string_last_pos( string const , string local ), '.' should be found in '€59.99' at char 4");
		});
	
		addFact("string_last_pos_test #5", function() {
			
			// Check that a several 3-byte UTF-8 chars can be found
			var aikido = "合気道";
			var aiPos = string_last_pos("合", aikido);
			var kiPos = string_last_pos("気", aikido);
			var doPos = string_last_pos("道", aikido);
			assert_equals(aiPos, 1, "string_last_pos( string const , string local ), '合' should be found in '合気道' at char 1");
			assert_equals(kiPos, 2, "string_last_pos( string const , string local ), '気' should be found in '合気道' at char 2");
			assert_equals(doPos, 3, "string_last_pos( string const , string local ), '道' should be found in '合気道' at char 3");
		});
	
		addFact("string_last_pos_test #6", function() {
			
			// Check that a regular substring can be found in a string with 3-byte UTF-8 chars
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_last_pos("Test", kotegaeshi);
			assert_equals(kotegaeshiTestPos, 5, 
			"string_last_pos( string const , string local ), 'test' should be found in '小手返 Test' at char 5");
		});
	
		addFact("string_last_pos_test #7", function() {
		
			// Check that a 4-byte UTF-8 char can be found
			var smileyString = "This is a test 🙂";
			var smileyPos = string_last_pos("🙂", smileyString);
			assert_equals(smileyPos, 16, "string_last_pos( string const , string local ), '🙂' should be found in 'This is a test 🙂' at char 16");
		});
	
		addFact("string_last_pos_test #8", function() {
		
		// Check that a 4-byte UTF-8 char literal can be found
			var smileyPosLiteral = string_last_pos("🙂", "This is a test 🙂");
			assert_equals(smileyPosLiteral, 16, "string_last_pos( string const , string const ), '🙂' should be found in 'This is a test 🙂' (as literal) at char 16");
		});
	
		addFact("string_last_pos_test #9", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars
			var emojiString = "✔✔✔💩👏";
			var res = string_last_pos("👏", emojiString);
			assert_equals(res, 5, "string_last_pos( string const , string local ), '👏' should be found in '✔✔✔💩👏' at char 5");
		});
	
		addFact("string_last_pos_test #10", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_last_pos("👏", moreEmojiString);
			assert_equals(res, 8, "string_last_pos( string const , string local ), '👏' should be found in '✔✔✔💩😀😁😂👏' at char 8");
		});
	
		addFact("string_last_pos_test #11", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars & regular chars
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_last_pos("👏", emojiString3);
			assert_equals(res, 10, "string_last_pos( string const , string local ), '👏' should be found in '✔✔✔💩😀aa😁😂👏' at char 10");
		});
	
		addFact("string_last_pos_test #12", function() {
			
			// Check that a regular substring can be found in a string of 4-byte UTF-8 chars
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_last_pos("aa", emojiString4);
			assert_equals(res, 9, "string_last_pos( string const , string local ), 'aa' should be found in '✔✔✔💩😀😁😂👏aa' at char 9");
		});
	}
	
	// STRING_LENGTH TESTS
	{
		addFact("string_length_test #1", function() {
			
			// Check that the length of a regular string literal is correctly returned
			var helloWorldLen = string_length("Hello world!");
			assert_equals(helloWorldLen, 12, "string_length( string const ), should return length of 12 for string literal 'Hello world!'");
		});
	
		addFact("string_length_test #2", function() {
			
			// Check that the length of a regular string is correctly returned
			var helloWorldStr = "Hello world!";
			var hw2Len = string_length(helloWorldStr);
			assert_equals(hw2Len, 12, "string_length( string local ), should return length of 12 for string 'Hello world!'");
		});
	
		addFact("string_length_test #3", function() {
			
			// Check that the length of a long string is correctly returned
			var longSentence = "The quick brown fox jumped over the lazy dog!";
			var sentenceLen = string_length(longSentence);
			assert_equals(sentenceLen, 45, 
			"string_length( string local ), should return length of 45 for string 'The quick brown fox jumped over the lazy dog!'");
		});
	
		addFact("string_length_test #4", function() {
		
			// Check that the length of a string containg a 2-byte UTF-8 char is correctly returned
			var poundPrice = "£99.99";
			var poundPriceLen = string_length(poundPrice);
			assert_equals(poundPriceLen, 6, "string_length( string local ), should return length of 6 for string '£99.99'");
		});
	
		addFact("string_length_test #5", function() {
			
			// Check that the length of a string containg a 3-byte UTF-8 char is correctly returned
			var euroPrice = "€59.99";
			var euroPriceLen = string_length(euroPrice);
			assert_equals(euroPriceLen, 6, "string_length( string local ), should return length of 6 for string '€59.99'");
		});
	
		addFact("string_length_test #6", function() {
			
			// Check that the length of a string containg several 3-byte UTF-8 chars is correctly returned
			var someSymbols = "‰ˆ‡†•";
			var someSymbolsLen = string_length(someSymbols);
			assert_equals(someSymbolsLen, 5, "string_length( string local ), should return length of 5 for string '‰ˆ‡†•'");
		});
	
		addFact("string_length_test #7", function() {
			
			// Check that the length of a string containg several 3-byte UTF-8 chars is correctly returned
			var aikido = "合気道";
			var aikidoLen = string_length(aikido);
			assert_equals(aikidoLen, 3, "string_length( string local ), should return length of 3 for string '合気道'");
		});
	
		addFact("string_length_test #8", function() {
			
			// Check that the length of a string containg several 3-byte UTF-8 chars is correctly returned
			var kotegaeshi = "小手返";
			var kotegaeshiLen = string_length(kotegaeshi);
			assert_equals(kotegaeshiLen, 3, "string_length( string local ), should return length of 3 for string '小手返'");
		});
	
		addFact("string_length_test #9", function() {
		
			// Check that the length of a string containg a 4-byte UTF-8 char is correctly returned
			var smileyFace = "🙂";
			var smileyFaceLen = string_length(smileyFace);
			assert_equals(smileyFaceLen, 1, "string_length( string local ), should return length of 1 for string '🙂'");
		});
	
		addFact("string_length_test #10", function() { // KNOWN FAIL: https://github.com/YoYoGames/GameMaker-Bugs/issues/7369
			
			// Check that the length of a literal string containg a 4-byte UTF-8 char is correctly returned
			assert_equals(string_length("🙂"), 1, "string_length( string const ), Sshould return length of 1 for string literal '🙂'");
		});
	
		addFact("string_length_test #11", function() {
			
			// Check that the length of a string containg several 4-byte UTF-8 chars is correctly returned
			var emojiString = "💩👏✔";
			var emojiLen = string_length(emojiString);
			assert_equals(emojiLen, 3, "string_length( string local ), should return length of 3 for string '💩👏✔'");
		});
	}
	
	// STRING_LETTERSDIGITS_TESTS
	{
		addFact("string_lettersdigits_test #1", function() {
			
			var vstring1 = "321!HeLlO WoRlD!123";
		
			// Check that letters and digits are correctly isolated
			var res = string_lettersdigits(vstring1);
			assert_equals(res, "321HeLlOWoRlD123", "string_lettersdigits( string local ), '321!HeLlO WoRlD!123' should return '321HeLlOWoRlD123' ");
		});
	
		addFact("string_lettersdigits_test #2", function() {
			
			var vstring2 = "!£水🙂";
		
			// Check that a string with no letters or digits returns and empty string
			var res = string_lettersdigits(vstring2);
			assert_equals(res, "", "string_lettersdigits( string local ), '!£水🙂' should return ''");
		});
	
		addFact("string_lettersdigits_test #3", function() {
			
			var vstring3 = "";
		
			// Check that an empty string remains unchanged
			var res = string_lettersdigits(vstring3);
			assert_equals(res, "", "string_lettersdigits( string local ), empty string '' should return ''");
		});
	
		addFact("string_lettersdigits_test #4", function() {
			
			var vstring4 = "abcd";
		
			// Check that a string with only letters remains unchanged
			var res = string_lettersdigits(vstring4);
			assert_equals(res, "abcd", "string_lettersdigits( string local ), all-letter string 'abcd' should return 'abcd'");
		});
	
		addFact("string_lettersdigits_test #5", function() {
			
			var vstring5 = "1234";
		
			// Check that a string with only digits remains unchanged
			var res = string_lettersdigits(vstring5);
			assert_equals(res, "1234", "string_lettersdigits( string local ), all-number string '1234' should return '1234'");
		});
	
		addFact("string_lettersdigits_test #6", function() {
			
			// Check that a real gets converted to a string
			var res = string_lettersdigits(1234);
			assert_equals(res, "1234", "string_lettersdigits( real const ), real 1234 should return '1234'");
		});
	
		addFact("string_lettersdigits_test #7", function() {
			
			// Check that a decimal real gets converted to a string, removing the decimal point
			var res = string_lettersdigits(1.234);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "123", "string_lettersdigits( real const ), real 1.234 should return '123'");
		});
	
		addFact("string_lettersdigits_test #8", function() {
			
			#macro kString_StringLettersdigitsTest "321!Hello World!123"
		
			// Check that the function works correctly with a macro input
			var res = string_lettersdigits(kString_StringLettersdigitsTest);
			assert_equals(res, "321HelloWorld123", "string_lettersdigits( string macro ), '321!Hello World!123' should return '321HelloWorld123'");
		});
	
		addFact("string_lettersdigits_test #9", function() {
			
			global.gstring = "321!Hello World!123";
		
			// Check that the function works correctly with a global input
			var res = string_lettersdigits(global.gstring);
			assert_equals(res, "321HelloWorld123", "string_lettersdigits( string global ), '321!Hello World!123' should return '321HelloWorld123'");
		});
	
		addFact("string_lettersdigits_test #10", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			// Check that the function works correctly with an instance input
			var res = string_lettersdigits(_oTest.ostring);
			assert_equals(res, "321HelloWorld123", "string_lettersdigits( string instance ), '321!Hello World!123' should return '321HelloWorld123'");
		
			instance_destroy(_oTest);
		});
	}
	
	// STRING_LETTERS TESTS
	{
		addFact("string_letters_test #1", function() {
			
			var vstring1 = "321!HeLlO WoRlD!123";
		
			// Check that letters are correctly isolated
			var res = string_letters(vstring1);
			assert_equals(res, "HeLlOWoRlD", "string_letters( string local ), '321!HeLlO WoRlD!123' should return 'HeLlOWoRlD'");
		});
	
		addFact("string_letters_test #2", function() {
			
			var vstring2 = "!£水🙂";
		
			// Check that a string with no letters  returns and empty string
			var res = string_letters(vstring2);
			assert_equals(res, "", "string_letters( string local ), '!£水🙂' should return ''");
		});
	
		addFact("string_letters_test #3", function() {
			
			var vstring3 = "";
		
			// Check that an empty string remains unchanged
			var res = string_letters(vstring3);
			assert_equals(res, "", "string_letters( string local ), empty string '' should return ''");
		});
	
		addFact("string_letters_test #4", function() {
			
			var vstring4 = "abcd";
		
			// Check that a string with only letters remains unchanged
			var res = string_letters(vstring4);
			assert_equals(res, "abcd", "string_letters( string local ), all-letter string 'abcd' should return 'abcd'");
		});
	
		addFact("string_letters_test #5", function() {
			
			// Check that a real gets converted to a string
			var res = string_letters(1234);
			assert_equals(res, "", "string_letters( real const ), real 1234 should return ''");
		});
	
		addFact("string_letters_test #6", function() {
			
			// Check that a decimal real gets converted to a string, removing the decimal point
			var res = string_letters(1.234);
			assert_equals(res, "", "string_letters( real const ), real 1.234 should return ''");
		});
	
		addFact("string_letters_test #7", function() {
			
			#macro kString_StringLettersTest "321!Hello World!123"
		
			// Check that the function works correctly with a macro input
			var res = string_letters(kString_StringLettersTest);
			assert_equals(res, "HelloWorld", "string_letters( string macro ), '321!Hello World!123' should return 'HelloWorld'");
		});
	
		addFact("string_letters_test #8", function() {
			
			global.gstring = "321!Hello World!123";
		
			// Check that the function works correctly with a global input
			var res = string_letters(global.gstring);
			assert_equals(res, "HelloWorld", "string_letters( string global ), '321!Hello World!123' should return 'HelloWorld'");
		});
	
		addFact("string_letters_test #9", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			// Check that the function works correctly with an instance input
			var res = string_letters(_oTest.ostring);
			assert_equals(res, "HelloWorld", "string_letters( string instance ), '321!Hello World!123' should return 'HelloWorld'");
		
			instance_destroy(_oTest);
		});
	}

	// STRING_LOWER TESTS
	{
		addFact("string_lower_test #1", function() {
			
			var vstring = "HeLlO WoRlD!";
		
			// Check that a standard string is correctly converted to lowercase
			var res = string_lower(vstring);
			assert_equals(res, "hello world!", "string_lower( string local ), 'HeLlO WoRlD!' should return 'hello world!'");
		});
	
		addFact("string_lower_test #2", function() {
			
			var vstring2 = "!£水🙂";
		
			// Check that a string of symbols remains unchanged
			var res = string_lower(vstring2);
			assert_equals(res, "!£水🙂", "string_lower( string local ), '!£水🙂' should return '!£水🙂'");
		});
	
		addFact("string_lower_test #3", function() {
			
			// Check that an empty string remains unchanged
			var res = string_lower("");
			assert_equals(res, "", "string_lower( string const ), empty string '' should return ''");
		});
	
		addFact("string_lower_test #4", function() {
			
			// Check that a single uppercase char is correctly converted to lowercase
			var res = string_lower("H");
			assert_equals(res, "h", "string_lower( string const ),  uppercase string 'H' should return 'h'");
		});
	
		addFact("string_lower_test #5", function() {
			
			// Check that a single lowercase char remains unchanged
			var res = string_lower("h");
			assert_equals(res, "h", "string_lower( string const ), lowercase string 'h' should return 'h'");
		});
	
		addFact("string_lower_test #6", function() {
			
			// Check that a real gets converted to a string
			var res = string_lower(1234);
			assert_equals(res, "1234", "string_lower( real local ), real 1234 should return '1234'");
		});
	
		addFact("string_lower_test #7", function() {
			
			// Check that a decimal real gets converted to a string
			var res = string_lower(1.234);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "1.23", "string_lower( real local ), real 1.234 should return '1.23'");
		});
	
		addFact("string_lower_test #8", function() {
			
			// Check that a int64 gets converted to a string
			var res = string_lower(int64(1234));
			assert_equals(res, "1234", "string_lower( int64 local ), int64 1234 should return '1234'");
		});
	
		addFact("string_lower_test #9", function() {
			
			// Check that letters in a string with 3-byte UTF-8 chars in it get converted to lowercase correctly
			var u8001 = "老aA老aAa";
			var u8001Chr = string_lower(u8001);
			assert_equals(u8001Chr, "老aa老aaa", "string_lower( string local ), '老aA老aAa' should return '老aa老aaa'");
		});
	}
	
	// STRING_ORD_AT TESTS
	{
		addFact("string_ord_at_test #1", function() {
			
			var vstring = "hello World!";
			
			// Check that the correct character code is returned from a standard string
			var res = string_ord_at(vstring, 7);
			assert_equals(res, 87, "string_ord_at( string local , real const ), ord at index 7 in 'hello World' should be 87 ('W')");
		});
	
		addFact("string_ord_at_test #2", function() {
			
			var vstring = "hello World!";
			
			// Check that using a decimal index above .5 will round down to the nearest integer
			var res = string_ord_at(vstring, 7.6);
			assert_equals(res, 87, "string_ord_at( string local , real const ), ord at index 7.6 (rounds down to 7) in 'hello World' should be 87 ('W')");
		});
	
		addFact("string_ord_at_test #3", function() {
			
			var vstring = "hello World!";
			
			// Check that using a decimal index below .5 will round down to the nearest integer
			var res = string_ord_at(vstring, 7.2);
			assert_equals(res, 87, "string_ord_at( string local , real const ), ord at index 7.2 (rounds down to 7) in 'hello World' should be 87 ('W')"); // 'W'
		});
	
		addFact("string_ord_at_test #4", function() {
			
			var vstring = "hello World!";
			
			// Check that using an index of 0 will be clamped to 1
			var res = string_ord_at(vstring, 0);
			assert_equals(res, 104, "string_ord_at( string local , real const ), ord at index 0 (clamps to 1) in 'hello World' should be 104 ('h')"); // 'h'
		});
	
		addFact("string_ord_at_test #5", function() {
			
			var vstring = "hello World!";
			
			// Check that using an index beyond the size of the string will return -1
			var res = string_ord_at(vstring, 100);
			assert_equals(res, -1, "string_ord_at( string local , real const ), ord at index 100 in 'hello World' should be -1 (none found)");
		});
	
		addFact("string_ord_at_test #6", function() {
			
			var vstring = "hello World!";
			
			// Check that using a negative index will be clamped to 1
			var res = string_ord_at(vstring, -2);
			assert_equals(res, 104, "string_ord_at( string local , real const ), ord at index -2 (clamps to 1) in 'hello World' should be 104 ('h')");
		});
	
		addFact("string_ord_at_test #7", function() {
			
			var vstring = "hello World!";
			
			// Check that the correct character code is returned with an int64 input
			var res = string_ord_at(int64(1234), 2);
			assert_equals(res, 50, "string_ord_at( int64 const , real const ), ord at index 2 in 1234 (int64) should be 50 ('2')"); // '2'
		});
	
		addFact("string_ord_at_test #8", function() {
			
			var vstring = "hello World!";
			
			// Check that the correct character code is returned with a decimal real input
			var res = string_ord_at(1.234, 2);
			assert_equals(res, 46, "string_ord_at( real const , real const ), ord at index 2 in 1.234 (real) should be 46 ('.')"); // '.'
		});
	
		addFact("string_ord_at_test #9", function() {
			
			var vstring = "hello World!";
			
			// Check that the correct character code is returned with a bool input
			var res = string_ord_at(true, 1);
			assert_equals(res, 49, "string_ord_at( bool const , real const ), ord at index 2 in true (bool) should be 49 ('1')"); // '1'
		});
	
		addFact("string_ord_at_test #10", function() {
			
			#macro kString_StringOrdAtTest "Hello World!"
			
			// Check that the function works correctly with a macro input
			var res = string_ord_at(kString_StringOrdAtTest, 7);
			assert_equals(res, 87, "string_ord_at( string macro , real const ), ord at index 7 in 'Hello World!' should be 87 ('W')");
		});
	
		addFact("string_ord_at_test #11", function() {
			
			global.gstring = "Hello World!";
			
			// Check that the function works correctly with a global input
			var res = string_ord_at(global.gstring, 7);
			assert_equals(res, 87, "string_ord_at( string global , real const ), ord at index 7 in 'Hello World!' should be 87 ('W')");
		});
	
		addFact("string_ord_at_test #12", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
			
			// Check that the function works correctly with an instance input
			var res = string_ord_at(_oTest.ostring, 7);
			assert_equals(res, 87, "string_ord_at( string instance , real const ), ord at index 7 in 'Hello World!' should be 87 ('W')");
		
			instance_destroy(_oTest);
		});
	
		addFact("string_ord_at_test #13", function() {
			
			// Check that the character code for 1-byte UTF-8 char is returned correctly
			var res = string_ord_at("!£水🙂a", 1);
			assert_equals(res, 33, "string_ord_at( string const , real const ), ord at index 1 in '!£水🙂a' should be 33 ('!')");
		});
	
		addFact("string_ord_at_test #14", function() {
			
			// Check that the character code for 2-byte UTF-8 char is returned correctly
			var res = string_ord_at("!£水🙂a", 2);
			assert_equals(res, 163, "string_ord_at( string const , real const ), ord at index 2 in '!£水🙂a' should be 163 ('£')");
		});
	
		addFact("string_ord_at_test #15", function() {
			
			// Check that the character code for 3-byte UTF-8 char is returned correctly
			var res = string_ord_at("!£水🙂a", 3);
			assert_equals(res, 27700, "string_ord_at( string const , real const ), ord at index 3 in '!£水🙂a' should be 27700 ('水')");
		});
	
		addFact("string_ord_at_test #16", function() {
			
			// Check that the character code for 4-byte UTF-8 char is returned correctly
			var res = string_ord_at("!£水🙂a", 4);
			assert_equals(res, 128578, "string_ord_at( string const , real const ), ord at index 4 in '!£水🙂a' should be 128578 ('🙂')");
		});
	
		addFact("string_ord_at_test #17", function() {
			
			// Check that the character code for a 1-byte UTF-8 is returned correctly at the end of a string of different byte-length UTF-8s
			var res = string_ord_at("!£水🙂a", 5);
			assert_equals(res, 97, "string_ord_at( string const , real const ), ord at index 5 in '!£水🙂a' should be 97 ('a')");
		});
	}
	
	// STRING_POS_EXT TESTS
	{
		addFact("string_pos_ext_test #1", function() {
			
			
			var helloWorldStr = "Hello world!Hello world!";
			
			// Check that substrings within a standard string can be found correctly
			var helloPos = string_pos_ext("Hello", helloWorldStr, 0);
			var worldPos = string_pos_ext("world", helloWorldStr, 0);
			var exclamationPos = string_pos_ext("!", helloWorldStr, 0);
			assert_equals(helloPos, 1, "string_pos( string const , string local , real const ), 'Hello' should be found at the 1st char");
			assert_equals(worldPos, 7, "string_pos( string const , string local , real const ), 'world' should be found at the 7th char");
			assert_equals(exclamationPos, 12, "string_pos( string const , string local , real const ), 'world' should be found at the 12th char");
		});
	
		addFact("string_pos_ext_test #2", function() {
			
			
			var helloWorldStr = "Hello world!Hello world!";
			
			// Check that substrings within a standard string can be found correctly when starting halfway through it
			var helloPos = string_pos_ext("Hello", helloWorldStr, 13);
			var worldPos = string_pos_ext("world", helloWorldStr, 13);
			var exclamationPos = string_pos_ext("!", helloWorldStr, 13);
			assert_equals(helloPos, 13, 
			"string_pos( string const , string local , real const ), 'Hello' should be found at the 13th char (with start_pos of 13)");
			assert_equals(worldPos, 19, 
			"string_pos( string const , string local , real const ), 'world' should be found at the 19th char (with start_pos of 13)");
			assert_equals(exclamationPos, 24, 
			"string_pos( string const , string local , real const ), '!' (exclamation mark) should be found at the 24th char (with start_pos of 13)");
		});
	
		addFact("string_pos_ext_test #3", function() {
		
			var helloWorldStr = "Hello world!Hello world!";
		
			// Check that a substring is not found when it doesn't exist in the string
			var helloNil = string_pos_ext( "hello", helloWorldStr, 0);
			assert_equals(helloNil, 0, "string_pos( string const , string local , real const ), 'hello' should not be found in 'Hello world!'");
		});
	
		addFact("string_pos_ext_test #4", function() {
		
			// Check that a 2-byte UTF-8 char can be found
			var poundPrice = "£99.99";
			var poundPos = string_pos_ext("£", poundPrice,0);
			assert_equals(poundPos, 1, "string_pos( string const , string local , real const ), '€' (pound sign) should be found at the 1st char");
			var periodCharPos = string_pos_ext(".", poundPrice,0);
			assert_equals(periodCharPos, 4, "string_pos( string const , string local , real const ), '.' (full stop) should be found at the 4th char");
		});
	
		addFact("string_pos_ext_test #5", function() {
			
			// Check that a 3-byte UTF-8 char can be found
			var euroPrice = "€59.99";
			var euroPos = string_pos_ext("€", euroPrice,0);
			assert_equals(euroPos, 1, "string_pos( string const , string local , real const ), '€' (euro sign) should be found at the 1st char");
			var euroPeriodCharPos = string_pos_ext(".", euroPrice,0);
			assert_equals(euroPeriodCharPos, 4, "string_pos( string const , string local , real const ), '.' (full stop) should be found at the 4th char");
		});
	
		addFact("string_pos_ext_test #6", function() {
		
			// Check that several 3-byte UTF-8 chars can be found
			var aikido = "合気道";
			var aiPos = string_pos_ext("合", aikido, 0);
			var kiPos = string_pos_ext("気", aikido, 0);
			var doPos = string_pos_ext("道", aikido, 0);
			assert_equals(aiPos, 1, "string_pos( string const , string local , real const ), '合' should be found at the 1st char");
			assert_equals(kiPos, 2, "string_pos( string const , string local , real const ), '気' should be found at the 2nd char");
			assert_equals(doPos, 3, "string_pos( string const , string local , real const ), '道' should be found at the 3rd char");
		});
	
		addFact("string_pos_ext_test #7", function() {
			
			// Check that a regular substring can be found in a string with 3-byte UTF-8 chars
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_pos_ext("Test", kotegaeshi, 0);
			assert_equals(kotegaeshiTestPos, 5, "string_pos( string const , string local , real const ), 'test' should be found at the 5th char");
		});
	
		addFact("string_pos_ext_test #8", function() {
		
			// Check that a 4-byte UTF-8 char can be found
			var smileyString = "This is a test 🙂";
			var smileyPos = string_pos_ext("🙂", smileyString, 0);
			assert_equals(smileyPos, 16, 
			"string_pos( string const , string const , real const ), '🙂' (smiley face emoji) should be found at the 16th char");
		});
	
		addFact("string_pos_ext_test #9", function() {
			
			// Check that a 4-byte UTF-8 char literal can be found
			var smileyPosLiteral = string_pos_ext("🙂", "This is a test 🙂", 0);
			assert_equals(smileyPosLiteral, 16, 
			"string_pos( string const , string const , real const ), '🙂' (smiley face emoji) should be found at the 16th char (in string literal)");
		});
	
		addFact("string_pos_ext_test #10", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars
			var emojiString = "✔✔✔💩👏";
			var res = string_pos_ext("👏", emojiString, 0);
			assert_equals(res, 5, "string_pos( string const , string local , real const ), '👏' (clap emoji) should be found at the 5th char");
		});
	
		addFact("string_pos_ext_test #11", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_pos_ext("👏", moreEmojiString, 0);
			assert_equals(res, 8, "string_pos( string const , string local , real const ), '👏' (clap emoji) should be found at the 8th char");
		});
	
		addFact("string_pos_ext_test #12", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_pos_ext("👏", emojiString3, 0);
			assert_equals(res, 10, "string_pos( string const , string local , real const ), '👏' (clap emoji) should be found at the 10th char");
		});
	
		addFact("string_pos_ext_test #13", function() {
			
			// Check that a regular substring can be found in a string of 4-byte UTF-8 chars
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_pos_ext("aa", emojiString4, 0);
			assert_equals(res, 9, "string_pos_ext( string const , string local , real const ), 'aa' should be found at the 9th char");
		});
	}
	
	// STRING_POS TESTS
	{
		addFact("string_pos_test #1", function() {
		
			var helloWorldStr = "Hello world!";
			
			// Check that substrings within a standard string can be found correctly
			var helloPos = string_pos("Hello", helloWorldStr);
			var worldPos = string_pos("world", helloWorldStr);
			var exclamationPos = string_pos("!", helloWorldStr);
			assert_equals(helloPos, 1, "string_pos( string const , string local ), 'Hello' should be found at the 1st char");
			assert_equals(worldPos, 7, "string_pos( string const , string local ), 'world' should be found at the 7th char");
			assert_equals(exclamationPos, 12, "string_pos( string const , string local ), '!' (exclamation mark) should be found at the 12th char");
		});
	
		addFact("string_pos_test #2", function() {
		
		
			var helloWorldStr = "Hello world!";
		
			// Check that a substring that isn't in the input string isn't found
			var helloNil = string_pos("hello", helloWorldStr);
			assert_equals(helloNil, 0, "string_pos( string const , string local ), 'hello' should not be found in 'Hello world!'");
		});
	
		addFact("string_pos_test #3", function() {
		
			// Check that a 2-byte UTF-8 char can be found
			var poundPrice = "£99.99";
			var poundPos = string_pos("£", poundPrice);
			assert_equals(poundPos, 1, "string_pos( string const , string local ), '£' (pound sign) should be found at the 1st char");
			var periodCharPos = string_pos(".", poundPrice);
			assert_equals(periodCharPos, 4, "string_pos( string const , string local ), '.' (full stop) should be found at the 4th char");
		});
	
		addFact("string_pos_test #4", function() {
			
			// Check that a 3-byte UTF-8 char can be found
			var euroPrice = "€59.99";
			var euroPos = string_pos("€", euroPrice);
			assert_equals(euroPos, 1, "string_pos( string const , string local ), '€' (euro sign) should be found at the 1st char");
			var euroPeriodCharPos = string_pos(".", euroPrice);
			assert_equals(euroPeriodCharPos, 4, "string_pos( string const , string local ), '.' (full stop) should be found at the 4th char");
		});
	
		addFact("string_pos_test #5", function() {
			
			// Check that a several 3-byte UTF-8 chars can be found
			var aikido = "合気道";
			var aiPos = string_pos("合", aikido);
			var kiPos = string_pos("気", aikido);
			var doPos = string_pos("道", aikido);
			assert_equals(aiPos, 1, "string_pos( string const , string local ), '合' should be found at the 1st char");
			assert_equals(kiPos, 2, "string_pos( string const , string local ), '気' should be found at the 2nd char");
			assert_equals(doPos, 3, "string_pos( string const , string local ), '道' should be found at the 3rd char");
		});
	
		addFact("string_pos_test #6", function() {
			
			// Check that a regular substring can be found in a string with 3-byte UTF-8 chars
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_pos("Test", kotegaeshi);
			assert_equals(kotegaeshiTestPos, 5, "string_pos( string const , string local ), 'test' should be found at the 5th char");
		});
	
		addFact("string_pos_test #7", function() {
		
			// Check that a 4-byte UTF-8 char can be found
			var smileyString = "This is a test 🙂";
			var smileyPos = string_pos("🙂", smileyString);
			assert_equals(smileyPos, 16, "string_pos( string const , string local ), '🙂' (smiley face emoji) should be found at the 16th char");
		});
	
		addFact("string_pos_test #8", function() {
			
			// Check that a 4-byte UTF-8 char literal can be found
			var smileyPosLiteral = string_pos("🙂", "This is a test 🙂");
			assert_equals(smileyPosLiteral, 16, 
			"string_pos( string const , string const ), '🙂' (smiley face emoji) should be found at the 16th char (in string literal)");
		});
	
		addFact("string_pos_test #9", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a string of other 4-byte UTF-8 chars
			var emojiString = "✔✔✔💩👏";
			var res = string_pos("👏", emojiString);
			assert_equals(res, 5, "string_pos( string const , string local ), '👏' (clap emoji) should be found at the 5th char");
		});
	
		addFact("string_pos_test #10", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_pos("👏", moreEmojiString);
			assert_equals(res, 8, "string_pos( string const , string local ), '👏' (clap emoji) should be found at the 8th char");
		});
	
		addFact("string_pos_test #11", function() {
			
			// Check that a 4-byte UTF-8 char can be found in a long string of other 4-byte UTF-8 chars
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_pos("👏", emojiString3);
			assert_equals(res, 10, "string_pos( string const , string local ), '👏' (clap emoji) should be found at the 10th char");
		});
	
		addFact("string_pos_test #12", function() {
			
			// Check that a regular substring can be found in a string of 4-byte UTF-8 chars
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_pos("aa", emojiString4);
			assert_equals(res, 9, "string_pos( string const , string local ), 'aa' should be found at the 9th char");
		});
	}
	
	// STRING_REPEAT TESTS
	{
		addFact("string_repeat_test #1", function() {
		
			var vstring1 = "HeLlO WoRlD!";
		
			// Check that a standard string can be correctly repeated
			var res = string_repeat(vstring1, 2);
			assert_equals(res, "HeLlO WoRlD!HeLlO WoRlD!", "string_repeat( string local , real const ), string incorrectly repeated");
		});
	
		addFact("string_repeat_test #2", function() {
		
			var vstring2 = "!£水🙂";
		
			// Check that a string of symbols can be correctly repeated
			var res = string_repeat(vstring2, 2);
			assert_equals(res, "!£水🙂!£水🙂", "#2ring_repeat( string local , real const ), symbol string incorrectly repeated");
		});
	
		addFact("string_repeat_test #3", function() {
		
			var vstring3 = "";
		
			// Check that a repeated empty string will remain unchanged
			var res = string_repeat(vstring3, 2);
			assert_equals(res, "", "string_repeat( string local , real const ), empty string incorrectly repeated");
		});
	
		addFact("string_repeat_test #4", function() {
		
			// Check that a real value is correctly repeated
			var res = string_repeat(1234, 2);
			assert_equals(res, "12341234", "string_repeat( real local , real const ), real incorrectly repeated");
		});
	
		addFact("string_repeat_test #5", function() {
		
			// Check that a decimal real value is correctly repeated
			var res = string_repeat(1.234, 2);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "1.231.23", "string_repeat( real local , real const ), real with decimal incorrectly repeated");
		});
	
		addFact("string_repeat_test #6", function() {
		
			var vstring1 = "HeLlO WoRlD!";
		
			// Check that a count value of 1 leaves the string unchanged
			var res = string_repeat(vstring1, 1);
			assert_equals(res, "HeLlO WoRlD!", "string_repeat( string local , real const ), string should remain unchanged when count is 1");
		});
	
		addFact("string_repeat_test #7", function() {
		
			var vstring2 = "!£水🙂";
		
			// Check that a count value of 0 will return an empty string
			var res = string_repeat(vstring2, 0);
			assert_equals(res,  "", "string_repeat( string local , real const ), should return empty string '' when repeated 0 times");
		});
	
		addFact("string_repeat_test #8", function() {
		
			var vstring3 = "";
		
			// Check that a count value of -1 will return an empty string
			var res = string_repeat(vstring3, -1);
			assert_equals(res, "", "string_repeat( string local , real const ), should return empty string '' when repeated -1 times");
		});
	
		addFact("string_repeat_test #9", function() {
		
			#macro kString_StringRepeatTest "Hello World!"
		
			// Check that the function works correctly with a macro input
			var res = string_repeat(kString_StringRepeatTest, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", 
			"string_repeat( string macro , real const ), macro string failed to be correctly repeated 3 times");
		});
	
		addFact("string_repeat_test #10", function() {
		
			global.gstring = "Hello World!";
		
			// Check that the function works correctly with a global input
			var res = string_repeat(global.gstring, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", 
			"string_repeat( string global , real const ), global string failed to be correctly repeated 3 times");
		});
	
		addFact("string_repeat_test #11", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			// Check that the function works correctly with an instance input
			var res = string_repeat(_oTest.ostring, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", 
			"string_repeat( string instance , real const ), instance string failed to be correctly repeated 3 times");
		
			instance_destroy(_oTest);
		});
	}

	// STRING_REPLACE_ALL TESTS
	{
		addFact("string_replace_all_test #1", function() {
		
			// Check that replacing a substring within a standard string works correctly
			var res = string_replace_all("Hello Earth!", "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace_all( string const , string const , string const ), failed to correctly replace 'Earth' with 'World'");
		});
	
		addFact("string_replace_all_test #2", function() {
		
			// Check that replacing 2 instances of a substring works correctly
			var res = string_replace_all("Hello Earth!Earth", "Earth", "World");
			assert_equals(res, "Hello World!World", 
			"string_replace_all( string const , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World'");
		});
	
		addFact("string_replace_all_test #3", function() {
		
			// Check that replacing many instances of a substring works correctly
			var res = string_replace_all("Hello EarthEarthEarthEarthEarthEarthEarth", "Earth", "World");
			assert_equals(res, "Hello WorldWorldWorldWorldWorldWorldWorld", 
			"string_replace_all( string const , string const , string const ), failed to correctly replace multiple instances of 'Earth' with 'World'");
		});
	
		addFact("string_replace_all_test #4", function() {
		
			// Check that replacing a substring with an empty string works correctly 
			var res = string_replace_all("Hello Earth!Earth", "Earth", "");
			assert_equals(res, "Hello !", 
			"string_replace_all( string const , string const , string const ), failed to correctly replace 2 instances of 'Earth' with empty string ''");
		});
	
		addFact("string_replace_all_test #5", function() {
		
			// Check that replacing an empty string does nothing
			var res = string_replace_all("Hello Earth!Earth", "", "World");
			assert_equals(res, "Hello Earth!Earth", 
			"string_replace_all( string const , string const , string const ), replacing empty string '' should result in no change");
		});
	
		addFact("string_replace_all_test #6", function() {
		
			// Check that replacing a substring with a real value works correctly
			var res = string_replace_all("Hello Earth!Earth", "Earth", 1234);
			assert_equals(res, "Hello 1234!1234", 
			"string_replace_all( string const , string const , real const ), failed to correctly replace 2 instances of 'Earth' with real 1234");
		});
	
		addFact("string_replace_all_test #7", function() {
		
			// Check that replacing a substring with a decimal real value works correctly
			var res = string_replace_all("Hello Earth!Earth", "Earth", 1.234);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "Hello 1.23!1.23", 
			"string_replace_all( string const , string const , real const ), failed to correctly replace 2 instances of 'Earth' with real 1.234");
		});
	
		addFact("string_replace_all_test #8", function() {
		
			// Check that replacing a substring with an int64 value works correctly
			var res = string_replace_all("Hello Earth!Earth", "Earth", int64(1234));
			assert_equals(res, "Hello 1234!1234", 
			"string_replace_all( string const , string const , int64 const ), failed to correctly replace 2 instances of 'Earth' with int64 1234");
		});
	
		addFact("string_replace_all_test #9", function() {
		
			// Check that replacing a substring that doesn't exist within the string does nothing
			var res = string_replace_all("", "two", "three");
			assert_equals(res, "", 
			"string_replace_all( string const , string const , string const ), replacing strings within empty string '' should result in no change");
		});
	
		addFact("string_replace_all_test #10", function() {
		
			// Check that using all empty strings does nothing
			var res = string_replace_all("", "", "");
			assert_equals(res, "", 
			"string_replace_all( string const , string const , string const ), replacing empty strings within empty string '' should result in no change");
		});
	
		addFact("string_replace_all_test #11", function() {
		
			var vstring = "Hello EarthEarth!";
		
			// Check that using a string stored in a local variable works correctly
			var res = string_replace_all(vstring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", 
			"string_replace_all( string local , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World' in local variable");
		});
	
		addFact("string_replace_all_test #12", function() {
		
			#macro kString_StringReplaceAllTest "Hello EarthEarth!"
		
			// Check that the function works correctly with a macro input
			var res = string_replace_all(kString_StringReplaceAllTest, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", 
			"string_replace_all( string macro , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World'");
		});
	
		addFact("string_replace_all_test #13", function() {
		
			global.gstring = "Hello EarthEarth!";
		
			// Check that the function works correctly with a global input
			var res = string_replace_all(global.gstring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", 
			"string_replace_all( string global , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World'");
		});
	
		addFact("string_replace_all_test #14", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello EarthEarth!";
		
			// Check that the function works correctly with an instance input
			var res = string_replace_all(_oTest.ostring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", 
			"string_replace_all( string instance , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World'");
		
			instance_destroy(_oTest);
		});
	
		addFact("string_replace_all_test #15", function() {
		
			// check that replacing a 1-byte UTF-8 char with a 1-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "!", "A");
			assert_equals(res, "A£水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 1-byte UTF-8 char with 1-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #16", function() {
		
			// check that replacing a 1-byte UTF-8 char with a 2-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "!", "£");
			assert_equals(res, "££水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 1-byte UTF-8 char with 2-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #17", function() {
		
			// check that replacing a 1-byte UTF-8 char with a 3-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "!", "水");
			assert_equals(res, "水£水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 1-byte UTF-8 char with 3-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #18", function() {
		
			// check that replacing a 1-byte UTF-8 char a with 4-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "!", "🙂");
			assert_equals(res, "🙂£水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 1-byte UTF-8 char with 4-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #19", function() {
		
			// check that replacing a 2-byte UTF-8 char a with 1-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "£", "A");
			assert_equals(res, "!A水🙂",
			"string_replace_all( string const , string const , string const ), failed to replace 2-byte UTF-8 char with 1-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #20", function() {
		
			// check that replacing a 2-byte UTF-8 char a with 2-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "£", "θ");
			assert_equals(res, "!θ水🙂",
			"string_replace_all( string const , string const , string const ), failed to replace 2-byte UTF-8 char with 2-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #21", function() {
		
			// check that replacing a 2-byte UTF-8 char a with 3-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "£", "水");
			assert_equals(res, "!水水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 2-byte UTF-8 char with 3-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #22", function() {
		
			// check that replacing a 2-byte UTF-8 char a with 4-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "£", "🙂");
			assert_equals(res, "!🙂水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 2-byte UTF-8 char with 4-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #23", function() {
		
			// check that replacing a 3-byte UTF-8 char a with 1-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "水", "A");
			assert_equals(res, "!£A🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 3-byte UTF-8 char with 1-byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #24", function() {
		
			// check that replacing a 3-byte UTF-8 char a with 2-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "水", "£");
			assert_equals(res, "!££🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 3 byte UTF-8 char with 2 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #25", function() {
		
			// check that replacing a 3-byte UTF-8 char a with 3-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "水", "月");
			assert_equals(res, "!£月🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 3 byte UTF-8 char with 3 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #26", function() {
		
			// check that replacing a 3-byte UTF-8 char a with 4-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "水", "🙂");
			assert_equals(res, "!£🙂🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 3 byte UTF-8 char with 4 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #27", function() {
		
			// check that replacing a 4-byte UTF-8 char a with 1-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "🙂", "A");
			assert_equals(res, "!£水A", 
			"string_replace_all( string const , string const , string const ), failed to replace 4 byte UTF-8 char with 1 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #28", function() {
		
			// check that replacing a  4-byte UTF-8 char a with 2-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "🙂", "£");
			assert_equals(res, "!£水£", 
			"string_replace_all( string const , string const , string const ), failed to replace 4 byte UTF-8 char with 2 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #29", function() {
		
			// check that replacing a  4-byte UTF-8 char a with 3-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "🙂", "水");
			assert_equals(res, "!£水水", 
			"string_replace_all( string const , string const , string const ), failed to replace 4 byte UTF-8 char with 3 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #30", function() {
		
			// check that replacing a  4-byte UTF-8 char a with 4-byte UTF-8 char works correctly
			var res = string_replace_all("!£水🙂", "🙂", "😢");
			assert_equals(res, "!£水😢", 
			"string_replace_all( string const , string const , string const ), failed to replace 4 byte UTF-8 char with 4 byte UTF-8 char");
		});
	
		addFact("string_replace_all_test #31", function() {
		
			// Check that replacing a whole string with an empty string works correctly
			var res = string_replace_all("!£水🙂", "!£水🙂", "");
			assert_equals(res, "", 
			"string_replace_all( string const , string const , string const ), failed to replace whole string with empty string ''");
		});
	
		addFact("string_replace_all_test #32", function() {
		
			// Check that replacing a substring with several symbols an empty string multiple times works correctly
			var res = string_replace_all("!£水🙂!!£水🙂!£水🙂", "!£水🙂", "");
			assert_equals(res, "!", 
			"string_replace_all( string const , string const , string const ), failed to correctly replace multible instances of '!£水🙂' with empty string ''");
		});
	
		addFact("string_replace_all_test #33", function() {
		
			// Check that replacing a 1 byte + 2 byte string with 3 byte + 4 byte string works correctly
			var res = string_replace_all("!£水🙂!!£水🙂", "!£", "水🙂");
			assert_equals(res, "水🙂水🙂!水🙂水🙂", 
			"string_replace_all( string const , string const , string const ), failed to replace 1 byte + 2 byte string with 3 byte + 4 byte string");
		});
	}
	
	// STRING_REPLACE TESTS
	{
		addFact("string_replace_test #1", function() {
		
			// Check that replacing a substring within a standard string works correctly
			var res = string_replace("Hello Earth!", "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace( string const , string const , string const ), failed to correctly replace 'Earth' with 'World'");
		});
	
		addFact("string_replace_test #2", function() {
		
			// Check that only the first instance of the substring is replaced
			var res = string_replace("Hello Earth!Earth", "Earth", "World");
			assert_equals(res, "Hello World!Earth", 
			"string_replace( string const , string const , string const ), failed to correctly replace the first instance of 'Earth' with 'World'");
		});
	
		addFact("string_replace_test #3", function() {
		
			// Check that using string_replace twice to replace the same substring will get rid of both instances of it
			var res = string_replace("Hello Earth!Earth", "Earth", "World");
			res = string_replace(res, "Earth", "World");
			assert_equals(res, "Hello World!World", 
			"string_replace( string const , string const , string const ), failed to correctly replace 2 instances of 'Earth' with 'World' by using function twice");
		});
	
		addFact("string_replace_test #4", function() {
		
			// Check that replacing a substring with an empty string works correctly 
			var res = string_replace("Hello Earth!Earth", "Earth", "");
			assert_equals(res, "Hello !Earth", 
			"string_replace( string const , string const , string const ), failed to correctly replace 'Earth' with empty string ''");
		});
	
		addFact("string_replace_test #5", function() {
		
			// Check that replacing an empty string does nothing
			var res = string_replace("Hello Earth!Earth", "", "World");
			assert_equals(res, "Hello Earth!Earth", 
			"string_replace( string const , string const , string const ), replacing empty string '' should result in no change");
		});
	
		addFact("string_replace_test #6", function() {
		
			// Check that replacing a substring with a real value works correctly
			var res = string_replace("Hello Earth!Earth", "Earth", 1234);
			assert_equals(res, "Hello 1234!Earth",
			"string_replace( string const , string const , real const ), failed to correctly replace 'Earth' with real 1234");
		});
	
		addFact("string_replace_test #7", function() {
		
			// Check that replacing a substring with a decimal real value works correctly
			var res = string_replace("Hello Earth!Earth", "Earth", 1.234);
			assert_equals(res, "Hello 1.23!Earth", 
			"string_replace( string const , string const , real const ), failed to correctly replace 'Earth' with real 1.234");
		});
	
		addFact("string_replace_test #8", function() {
		
			// Check that replacing a substring with an int64 value works correcty
			var res = string_replace("Hello Earth!Earth", "Earth", int64(1234));
			assert_equals(res, "Hello 1234!Earth", 
			"string_replace( string const , string const , int64 const ), failed to correctly replace 'Earth' with int64 1234");
		});
	
		addFact("string_replace_test #9", function() {
		
			// Check that replacing a substring that doesn't exist within the string does nothing
			var res = string_replace("", "two", "three");
			assert_equals(res, "", 
			"string_replace( string const , string const , string const ), replacing strings within empty string '' should result in no change");
		});
	
		addFact("string_replace_test #10", function() {
			
			// Check that using all empty strings does nothing
			var res = string_replace("", "", "");
			assert_equals(res, "", 
			"string_replace( string const , string const , string const ), replacing empty strings within empty string '' should result in no change");
		});
	
		addFact("string_replace_test #11", function() {
		
			var vstring = "Hello Earth!";
		
			// Check that replacing a substring within a local string works correctly
			var res = string_replace(vstring, "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace( string local , string const , string const ), failed to correctly replace 'Earth' with 'World' in local variable");
		});
	
		addFact("string_replace_test #12", function() {
		
			#macro kString_StringReplaceTest "Hello Earth!"
		
			// Check that the function works correctly with a macro input
			var res = string_replace(kString_StringReplaceTest, "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace( string macro , string const , string const ), failed to correctly replace 'Earth' with 'World'");
		});
	
		addFact("string_replace_test #13", function() {
		
			global.gstring = "Hello Earth!";
		
			// Check that the function works correctly with a global input
			var res = string_replace(global.gstring, "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace( string global , string const , string const ), failed to correctly replace 'Earth' with 'World'");
		});
	
		addFact("string_replace_test #14", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello Earth!";
		
			// Check that the function works correctly with an instance input
			var res = string_replace(_oTest.ostring, "Earth", "World");
			assert_equals(res, "Hello World!", 
			"string_replace( string instance , string const , string const ), failed to correctly replace 'Earth' with 'World'");
		
			instance_destroy(_oTest);
		});
	
		addFact("string_replace_test #15", function() {
		
			// Check that replacing a 4-byte UTF-8 char with another 4-byte UTF-8 char works correctly
			var string1 = "🙂";
			var string2 = "😬";
			var res = string_replace(string1, "🙂", string2);
			assert_equals(res, "😬", 
			"string_replace( string local , string const , string local ), failed to replace a smiley face emoji with a grimace emoji");
		});
	
		addFact("string_replace_test #16", function() {
			
			// Check that replacing a 4-byte UTF-8 char with a standard string works correctly
			var longSmileyString = "The quick brown 🙂 jumped over the lazy dog!";
			var res = string_replace(longSmileyString, "🙂", "fox");
			assert_equals(res, "The quick brown fox jumped over the lazy dog!", 
			"string_replace( string local , string const , string const ), failed to replace a smiley face emoji with a string");
		});
	
		addFact("string_replace_test #17", function() {
			
			// Check that replacing a standard string with a 4-byte UTF-8 char works correctly
			var longFoxString = "The quick brown fox jumped over the lazy dog!";
			var res = string_replace(longFoxString, "fox", "🙂");
			assert_equals(res, "The quick brown 🙂 jumped over the lazy dog!", 
			"string_replace( string local , string const , string const ), failed to replace a string with a smiley face emoji");
		});
	}
	
	// STRING_SET_BYTE TESTS
	{
		addFact("string_set_byte_at_test #1", function() {

			// Check that setting a byte at an index outside the string will throw an error
			assert_throw(function() {
				return string_set_byte_at("hello", 100, 87);
			}, "string_set_byte_at( string const , real const , real const ), using an out of range index should throw an error");
	
		})

		addFact("string_set_byte_at_test #2", function() {

			// Check that setting a byte at a negative index will throw an error
			assert_throw(function() {
				return string_set_byte_at("hello", -2, 87);
			}, "string_set_byte_at( string const , real const , real const ), using a negative index should throw an error");
		})

		addFact("string_set_byte_at_test #3", function() {

			// Check that setting a byte at a index of 0 will throw an error
			assert_throw(function() {
				return string_set_byte_at("hello", 0, 87);
			}, "string_set_byte_at( string const , real const , real const ), using an index of 0 should throw an error");
		})
	
		addFact("string_set_byte_at_test #4", function() {

			var vstring = "hello Porld!";
		
			// Check that setting a byte works correctly for a standard string
			var res = string_set_byte_at(vstring, 7, 87);
			assert_equals(res, "hello World!", 
			"string_set_byte_at( string local , real const , real const ), failed to set the 7th byte in 'hello Porld!' to 87 ('W')");
		})
	
		addFact("string_set_byte_at_test #5", function() {

			var vstring = "hello Porld!";
		
			// Check that using a decimal index above .5 will round down to the nearest integer
			var res = string_set_byte_at(vstring, 7.6, 87);
			assert_equals(res, "hello World!", 
			"string_set_byte_at( string local , real const , real const ), failed to set the 7.6th (rounded down to 7th) byte in 'hello Porld!' to 87 ('W')");
		})
	
		addFact("string_set_byte_at_test #6", function() {

			var vstring = "hello Porld!";
		
			// Check that using a decimal index below .5 will round down to the nearest integer
			var res = string_set_byte_at(vstring, 7.2, 87);
			assert_equals(res, "hello World!", 
			"string_set_byte_at( string local , real const , real const ), failed to set the 7.2th (rounded down to 7th) byte in 'hello Porld!' to 87 ('W')");
		})
	
		addFact("string_set_byte_at_test #7", function() {
		
			// Check that setting a byte works correctly for an int64 input
			var res = string_set_byte_at(int64(1234), 2, 32); 
			assert_true(is_string(res), "string_set_byte_at( int64 const , real const , real const ), should be string");
			assert_equals(res, "1 34", 
			"string_set_byte_at( int64 const , real const , real const ), failed to set the 2nd byte in 1234 (int64) to 32 (' ')");
		})
	
		addFact("string_set_byte_at_test #8", function() {
		
			// Check that setting a byte works correctly for an decimal real input
			var res = string_set_byte_at(1.234, 2, 32); 
			assert_true(is_string(res), "string_set_byte_at( real const , real const , real const ), should be string");
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "1 23", 
			"string_set_byte_at( real const , real const , real const ), failed to set the 2nd byte in 1.234 to 32 (' ')");
		})
	
		addFact("string_set_byte_at_test #9", function() {
		
			// Check that setting a byte works correctly for a boolean input
			var res = string_set_byte_at(true, 1, 32); 
			assert_true(is_string(res), "string_set_byte_at( bool const , real const , real const ), should be string");
			assert_equals(res, " ", 
			"string_set_byte_at( bool const , real const , real const ), failed to set the 1st byte in a true bool to 32 (' ')");
		})
	
		addFact("string_set_byte_at_test #10", function() {
		
			// Check that setting a byte to a value that uses more than a byte will only use the first byte of the value
			var res = string_set_byte_at("Eyup World", 7, 2080); // 2080 -> 100000100000 -> cast to char -> 00100000 -> 32 -> ' '
			assert_true(is_string(res), "string_set_byte_at( string const , real const , real const ), should be string");
			assert_equals(res,"Eyup W rld", 
			"string_set_byte_at( string const , real const , real const ), failed to set the 7th byte in 'Eyup World' to 2080, (which becomes 32 (' ') when cast to char)");
		})
	
		addFact("string_set_byte_at_test #11", function() {
		
			// Check that a a string byte value will be correctly converted
			var res = string_set_byte_at("Eyup World", 7, "32");
			assert_true(is_string(res), "string_set_byte_at( string const , real const , string const ), should be string");
			assert_equals(res,"Eyup W rld", 
			"string_set_byte_at( string const , real const , string const ), failed to set the 7th byte in 'Eyup World' to '32' (' ')");
		})
	
		addFact("string_set_byte_at_test #12", function() {
		
			// Check that setting 1 byte of a 2-byte UTF-8 char works correctly
			var twoByteUTF8 = "£";
			var res = string_set_byte_at(twoByteUTF8, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string local , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string local , real const , real const ), failed to set the 2nd byte in '£' (2-byte UTF) to 87 ('W')");
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #13", function() {
		
			// Check that setting 1 byte of a 3-byte UTF-8 char works correctly
			var threeByteUTF8 = "小";
			var res = string_set_byte_at(threeByteUTF8, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string local , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string local , real const , real const ), failed to set the 2nd byte in '小' (3-byte UTF) to 87 ('W')");
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #14", function() {
		
			// Check that setting 1 byte of a 4-byte UTF-8 char works correctly
			var fourByteUTF8 = "🙂";
			var res = string_set_byte_at(fourByteUTF8, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string local , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string local , real const , real const ), failed to set the 2nd byte in '🙂' (4-byte UTF) to 87 ('W')");
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #15", function() {
		
			// Check that a 4-byte UTF-8 char can be formed by setting each byte individually
			var res = "xxxx";
			res = string_set_byte_at(res, 1, 240);
			res = string_set_byte_at(res, 2, 159);
			res = string_set_byte_at(res, 3, 152);
			res = string_set_byte_at(res, 4, 131);
			assert_true(is_string(res), "string_set_byte_at( string local , real const , real const ), should be string");
			assert_equals(res, "😃", 
			"string_set_byte_at( string local , real const , real const ), failed to change 'xxxx' into '😃' (4-byte UTF) by setting each byte");
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #16", function() {

			#macro kString_StringSetByteAtTest "Hello World!"
		
			// Check that the function works correctly with a macro input
			var res = string_set_byte_at(kString_StringSetByteAtTest, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string macro , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string macro , real const , real const ), failed to set the 2nd byte in 'Hello World!' to 87 ('W')");
		})
	
		addFact("string_set_byte_at_test #17", function() {

			global.gstring = "Hello World!";
		
			// Check that the function works correctly with a global input
			var res = string_set_byte_at(global.gstring, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string global , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string global , real const , real const ), failed to set the 2nd byte in 'Hello World!' to 87 ('W')");
		})
	
		addFact("string_set_byte_at_test #18", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			// Check that the function works correctly with an instance input
			var res = string_set_byte_at(_oTest.ostring, 2, 87);
			assert_true(is_string(res), "string_set_byte_at( string instance , real const , real const ), should be string");
			assert_equals(string_byte_at(res, 2), 87, 
			"string_set_byte_at( string instance , real const , real const ), failed to set the 2nd byte in 'Hello World!' to 87 ('W')");
		
			instance_destroy(_oTest);
		})
	}
	
	// STRING_UPPER TESTS
	{
		addFact("string_upper_test #1", function() {
		
			var vstring = "HeLlO WoRlD!";
		
			// Check that a standard string is correctly converted to uppercase
			var res = string_upper(vstring);
			assert_equals(res, "HELLO WORLD!", "string_upper( string local ), 'HeLlO WoRlD!' should return 'HELLO WORLD!'");
		})
	
		addFact("string_upper_test #2", function() {
		
			var vstring2 = "!£水🙂";
		
			// Check that a string of symbols remains unchanged
			var res = string_upper(vstring2);
			assert_equals(res, "!£水🙂", "string_upper( string local ), '!£水🙂' should return '!£水🙂'");
		})
	
		addFact("string_upper_test #3", function() {
		
			// Check that an empty string remains unchanged
			var res = string_upper("");
			assert_equals(res, "", "string_upper( string const ), empty string '' should return ''");
		})
	
		addFact("string_upper_test #4", function() {
		
			// Check that a single lowercase char is correctly converted to uppercase
			var res = string_upper("h");
			assert_equals(res, "H", "string_upper( string const ), lowercase string 'h' should return 'H'");
		})
	
		addFact("string_upper_test #5", function() {
		
			// Check that a single uppercase char remains unchanged
			var res = string_upper("H");
			assert_equals(res, "H", "string_upper( string const ), uppercase string 'H' should return 'H'");
		})
	
		addFact("string_upper_test #6", function() {
		
			// Check that a real gets converted to a string
			var res = string_upper(1234);
			assert_equals(res, "1234", "string_upper( real const ), real 1234 should return '1234'");
		})
	
		addFact("string_upper_test #7", function() {
		
			// Check that a decimal real gets converted to a string
			var res = string_upper(1.234);
			// Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			assert_equals(res, "1.23", "string_upper( real const ), real 1.234 should return '1.23'");
		})
	
		addFact("string_upper_test #8", function() {
		
			// Check that a int64 gets converted to a string
			var res = string_upper(int64(1234));
			assert_equals(res, "1234", "string_upper( int64 const ), int64 1234 should return '1234'");
		})
	
		addFact("string_upper_test #9", function() {
			
			// Check that letters in a string with 3-byte UTF-8 chars in it get converted to lowercase correctly
			var u8001 = "老Aa老AaA";
			var u8001Chr = string_upper(u8001);
			assert_equals(u8001Chr, "老AA老AAA", "string_upper( string local ), '老Aa老AaA' should return '老AA老AAA'");
		})
	}
	
	// STRING TESTS
	{
		addFact("string_test #1", function() {
			
			// Check that various types of data can be formatted correctly
			var _format = "{0} {1} {2}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ]", "string(), failed to correctly format a string with mixed types");
		}, {
			test_filter: runtime_not_gmrt
		})
		
		addFact("string_test #2", function() {
			
			// Check that including more arguments than placeholders in the format will only format the expected arguments
			var _format = "{0} {1}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello", "string(), failed to correctly format a string with less placeholders than arguments");
		})
	
		addFact("string_test #3", function() {
			
			// Check that including fewer arguments than placeholders in the format will include the placeholders where arguments are missing
			var _format = "{0} {1} {2} {3}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ] {3}", "string(), failed to correctly format a string with more placeholders than arguments");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_test #4", function() {
			
			// Check that repeating placeholders works correctly
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ] 12 hello [  ]", "string(), failed to correctly format a string with repeated placeholders");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_test #4.1", function() {
			
			// Check that repeating placeholders works correctly
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello  12 hello ", "string(), failed to correctly format a string with repeated placeholders");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_test #5", function() {
			
			// Check that formatting non-latic characters works correctly
			var _format = "{0}{1}";
			var _result = string(_format, "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合気道合気道合気道", "string(), failed to correctly format a string with non-latin characters");
		})
	
		addFact("string_test #6", function() {
			
			// Check that formatting emoji characters works correctly
			var _format = "{0} {1} {2} {3}";
			var _result = string(_format, "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", 
			"string(), failed to correctly format a string with emoji characters");		
		})
	}
	
	// STRING_EXT TESTS
	{
		addFact("string_ext_test #1", function() {
			
			// Check that various types of data can be formatted correctly
			var _format = "{0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ]", "string_ext(), failed to correctly format a string with mixed types");
		}, {
			test_filter: runtime_not_gmrt
		});
		
		addFact("string_ext_test #1.1", function() {
			
			// Check that various types of data can be formatted correctly
			var _format = "{0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello ", "string_ext(), failed to correctly format a string with mixed types");
		}, {
			test_filter: runtime_gmrt
		});
	
		addFact("string_ext_test #2", function() {
			
			// Check that including more arguments than placeholders in the format will only format the expected arguments
			var _format = "{0} {1}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello", "string_ext(), failed to correctly format a string with less placeholders than arguments");
		})
	
		addFact("string_ext_test #3", function() {
			
			// Check that including fewer arguments than placeholders in the format will include the placeholders where arguments are missing
			var _format = "{0} {1} {2} {3}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ] {3}", "string_ext(), failed to correctly format a string with more placeholders than arguments");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_ext_test #4", function() {
			
			// Check that repeating placeholders works correctly
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ] 12 hello [  ]", "string_ext(), failed to correctly format a string with repeated placeholders");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_ext_test #4.1", function() {
			
			// Check that repeating placeholders works correctly
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello  12 hello ", "string_ext(), failed to correctly format a string with repeated placeholders");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_ext_test #5", function() {
			
			// Check that formatting non-latic characters works correctly
			var _format = "{0}{1}";
			var _result = string_ext(_format, ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合気道合気道合気道", "string_ext(), failed to correctly format a string with non-latin characters");
		})
	
		addFact("string_ext_test #6", function() {
			
			// Check that formatting emoji characters works correctly
			var _format = "{0} {1} {2} {3}";
			var _result = string_ext(_format, ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", 
			"string_ext(), failed to correctly format a string with emoji characters");		
		})
	}
	
	// STRING_CONCAT TESTS
	{
		addFact("string_concat_test #1", function() {
			
			// Check that concatenating various data types works correctly
			var _result = string_concat(12, "hello", []);
			assert_equals(_result, "12hello[  ]", "string_concat(), failed to correctly concat a string with mixed types");
		}, {
			test_filter: runtime_not_gmrt
		})
		
		addFact("string_concat_test #1.1", function() {
			
			// Check that concatenating various data types works correctly
			var _result = string_concat(12, "hello", []);
			assert_equals(_result, "12hello", "string_concat(), failed to correctly concat a string with mixed types");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_concat_test #2", function() {
			
			// Check that concatenating non-latin characters works correctly
			var _result = string_concat("合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合気道合気道合気道", "string_concat(), failed to correctly concat a string with non-latin characters");
		})
	
		addFact("string_concat_test #3", function() {
			
			// Check that concatenating emoji characters works correctly
			var _result = string_concat("🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎", 
			"string_concat(), failed to correctly concat a string with emoji characters");		
		})
	
		addFact("string_concat_test #4", function() {
		
			var _string = "foo";
			
			// Check that concatenating a literal and local string works correctly
			var _result = string_concat(_string, " bar");
			assert_equals(_result, "foo bar", "string_concat(), failed to correctly concat a local string and a string literal");
		})
	
		addFact("string_concat_test #5", function() {
		
			var _string = "foo";
			
			// Check that concatenating local and literal string works correctly
			var _result = string_concat("bar ", _string);
			assert_equals(_result, "bar foo", "string_concat(), failed to correctly concat a string literal and a local string");
		})
	}
	
	// STRING_CONCAT_EXT TESTS
	{
		addFact("string_concat_ext_test #1", function() {
			
			// Check that concatenating various data types works correctly
			var _result = string_concat_ext([12, "hello", []]);
			assert_equals(_result, "12hello[  ]", "string_concat_ext(), failed to correctly concat a string with mixed types");
		}, {
			test_filter: runtime_not_gmrt
		})
		
		addFact("string_concat_ext_test #1.1", function() {
			
			// Check that concatenating various data types works correctly
			var _result = string_concat_ext([12, "hello", []]);
			assert_equals(_result, "12hello", "string_concat_ext(), failed to correctly concat a string with mixed types");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_concat_ext_test #2", function() {
			
			// Check that concatenating non-latin characters works correctly
			var _result = string_concat_ext(["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合気道合気道合気道", "string_concat_ext(), failed to correctly concat a string with non-latin characters");
		})
	
		addFact("string_concat_ext_test #3", function() {
			
			// Check that concatenating emoji characters works correctly
			var _result = string_concat_ext(["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎",
			"string_concat_ext(), failed to correctly concat a string with emoji characters");		
		})
	
		addFact("string_concat_ext_test #4", function() {
		
			var _string = "foo";
			
			// Check that concatenating a literal and local string works correctly
			var _result = string_concat_ext([_string, " bar"]);
			assert_equals(_result, "foo bar", "string_concat_ext(), failed to correctly concat a local string and a string literal");
		})
	
		addFact("string_concat_ext_test #5", function() {
		
			var _string = "foo";
			
			// Check that concatenating local and literal string works correctly
			var _result = string_concat_ext(["bar ", _string]);
			assert_equals(_result, "bar foo", "string_concat_ext(), failed to correctly concat a string literal and a local string");
		})
	}

	// STRING_JOIN TESTS
	{
		addFact("string_join_test #1", function() {
			
			// Check that joining various data types works correctly
			var _result = string_join(",", 12, "hello", []);
			assert_equals(_result, "12,hello,[  ]", 
			"string_join(), failed to correctly join a string with mixed types, using a comma.");
		}, {
			test_filter: runtime_not_gmrt
		})

		addFact("string_join_test #1.1", function() {
			
			// Check that joining various data types works correctly
			var _result = string_join(",", 12, "hello", []);
			assert_equals(_result, "12,hello,", 
			"string_join(), failed to correctly join a string with mixed types, using a comma.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_test #2", function() {
			
			// Check that joining non-latin characters works correctly
			var _result = string_join(",", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合,気道合気道合気道", 
			"string_join(), failed to correctly join a string with non-latin characters, using a comma");
		})
	
		addFact("string_join_test #3", function() {
			
			// Check that joining emoji characters works correctly
			var _result = string_join(",", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", 
			"string_join(), failed to correctly join a string with emoji characters, using a comma");
		})
	
		addFact("string_join_test #4", function() {
			
			// Check that using a non-latin delimiter works correctly
			var _result = string_join("道", 12, "hello", []);
			assert_equals(_result, "12道hello道[  ]", 
			"string_join(), failed to correctly join a string with mixed types, using a non-latin character.");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_join_test #4.1", function() {
			
			// Check that using a non-latin delimiter works correctly
			var _result = string_join("道", 12, "hello", []);
			assert_equals(_result, "12道hello道", 
			"string_join(), failed to correctly join a string with mixed types, using a non-latin character.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_test #5", function() {
			
			// Check that using a non-latin delimiter with non-latin strings works correctly
			var _result = string_join("道", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合道気道合気道合気道", 
			"string_join(), failed to correctly join a string with non-latin characters, using a non-latin character.");
		})
	
		addFact("string_join_test #6", function() {
			
			// Check that using a non-latin delimiter with strings containing emoji characters works correctly
			var _result = string_join("道", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", 
			"string_join(), failed to correctly join a string with emoji characters, using a non-latin character.");
		})
	
		addFact("string_join_test #7", function() {
			
			// Check that using an emoji delimiter works correctly
			var _result = string_join("🙂", 12, "hello", []);
			assert_equals(_result, "12🙂hello🙂[  ]", 
			"string_join(), failed to correctly join a string with mixed types, using an emoji character.");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_join_test #7.1", function() {
			
			// Check that using an emoji delimiter works correctly
			var _result = string_join("🙂", 12, "hello", []);
			assert_equals(_result, "12🙂hello🙂", 
			"string_join(), failed to correctly join a string with mixed types, using an emoji character.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_test #8", function() {
			
			// Check that using an emoji delimiter with non-latin strings works correctly
			var _result = string_join("🙂", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合🙂気道合気道合気道",  
			"string_join(), failed to correctly join a string with non-latin characters, using an emoji character.");
		})
	
		addFact("string_join_test #9", function() {
			
			// Check that using an emoji delimiter with strings containing emoji characters works correctly
			var _result = string_join("🙂", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", 
			"string_join(), failed to correctly join a string with emoji characters, using an emoji character.");
		})
	
		addFact("string_join_test #10", function() {
		
			var _string = "foo";
			
			// Check that joining a literal and local string works correctly
			var _result = string_join(",", "bar", _string);
			assert_equals(_result, "bar,foo", "string_join(), failed to correctly join a string literal and a local string");
		})
	
		addFact("string_join_test #11", function() {
		
			var _string = "foo";
			
			// Check that joining a local and literal string works correctly
			var _result = string_join(",", _string, "bar");
			assert_equals(_result, "foo,bar", "string_join(), failed to correctly join a local string and a string literal");
		})
	}
	
	// STRING_JOIN_EXT TESTS
	{
		addFact("string_join_ext_test #1", function() {
			
			// Check that joining various data types works correctly
			var _result = string_join_ext(",", [12, "hello", []]);
			assert_equals(_result, "12,hello,[  ]", 
			"string_join_ext(), failed to correctly join a string with mixed types, using a comma.");
		}, {
			test_filter: runtime_not_gmrt
		})
		
		addFact("string_join_ext_test #1.1", function() {
			
			// Check that joining various data types works correctly
			var _result = string_join_ext(",", [12, "hello", []]);
			assert_equals(_result, "12,hello,", 
			"string_join_ext(), failed to correctly join a string with mixed types, using a comma.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_ext_test #2", function() {
			
			// Check that joining non-latin characters works correctly
			var _result = string_join_ext(",", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合,気道合気道合気道", 
			"string_join_ext(), failed to correctly join a string with non-latin characters, using a comma");
		})
	
		addFact("string_join_ext_test #3", function() {
			
			// Check that joining emoji characters works correctly
			var _result = string_join_ext(",", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", 
			"string_join_ext(), failed to correctly join a string with emoji characters, using a comma");
		})
	
		addFact("string_join_ext_test #4", function() {
			
			// Check that using a non-latin delimiter works correctly
			var _result = string_join_ext("道", [12, "hello", []]);
			assert_equals(_result, "12道hello道[  ]", 
			"string_join_ext(), failed to correctly join a string with mixed types, using a non-latin character.");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_join_ext_test #4.1", function() {
			
			// Check that using a non-latin delimiter works correctly
			var _result = string_join_ext("道", [12, "hello", []]);
			assert_equals(_result, "12道hello道", 
			"string_join_ext(), failed to correctly join a string with mixed types, using a non-latin character.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_ext_test #5", function() {
			
			// Check that using a non-latin delimiter with non-latin strings works correctly
			var _result = string_join_ext("道", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合道気道合気道合気道", 
			"string_join_ext(), failed to correctly join a string with non-latin characters, using a non-latin character.");
		})
	
		addFact("string_join_ext_test #6", function() {
			
			// Check that using a non-latin delimiter with strings containing emoji characters works correctly
			var _result = string_join_ext("道", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", 
			"string_join_ext(), failed to correctly join a string with emoji characters, using a non-latin character.");
		})
	
		addFact("string_join_ext_test #7", function() {
			
			// Check that using an emoji delimiter works correctly
			var _result = string_join_ext("🙂", [12, "hello", []]);
			assert_equals(_result, "12🙂hello🙂[  ]", 
			"string_join_ext(), failed to correctly join a string with mixed types, using an emoji character.");
		}, {
			test_filter: runtime_not_gmrt
		})
	
		addFact("string_join_ext_test #7.1", function() {
			
			// Check that using an emoji delimiter works correctly
			var _result = string_join_ext("🙂", [12, "hello", []]);
			assert_equals(_result, "12🙂hello🙂", 
			"string_join_ext(), failed to correctly join a string with mixed types, using an emoji character.");
		}, {
			test_filter: runtime_gmrt
		})
	
		addFact("string_join_ext_test #8", function() {
			
			// Check that using an emoji delimiter with non-latin strings works correctly
			var _result = string_join_ext("🙂", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合🙂気道合気道合気道", 
			"string_join_ext(), failed to correctly join a string with non-latin characters, using an emoji character.");
		})
	
		addFact("string_join_ext_test #9", function() {
			
			// Check that using an emoji delimiter with strings containing emoji characters works correctly
			var _result = string_join_ext("🙂", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", 
			"string_join_ext(), failed to correctly join a string with emoji characters, using an emoji character.");
		})
	
		addFact("string_join_ext_test #10", function() {
		
			var _string = "foo";
			
			// Check that joining a literal and local string works correctly
			var _result = string_join_ext(",", [_string, "bar"]);
			assert_equals(_result, "foo,bar", "string_join_ext(), failed to correctly concat a local string and a string literal");
		})
	
		addFact("string_join_ext_test #11", function() {
		
			var _string = "foo";
			
			// Check that joining a local and literal string works correctly
			var _result = string_join_ext(",", ["bar", _string]);
			assert_equals(_result, "bar,foo", "string_join_ext(), failed to correctly concat a string literal and a local string");
		})
	}
	
	// STRING_SPLIT TESTS
	{
		// Check that a string can be split with a delimiter of ','
		addFact("string_split_test #1", function() {
		
			var _input = "hello,great,world";
			var _result = string_split(_input, ",", true);
			assert_array_length(_result, 3, "string_split(), failed to correctly split string into correct number of elements (with comma delimiter)");
			assert_array_equals(_result, ["hello", "great", "world"],"string_split(), failed to correctly split string with latin characters (with comma delimiter)");
		})
		
		// Check that a string can be split with a delimiter of '\n'
		addFact("string_split_test #2", function() {
		
			var _input = "1test\n2test,\n3test,,,,\n4test\n5test。\n6test，\n7test，，\n8test\n9test";
			var _result = string_split(_input, "\n", true);
			assert_array_length(_result, 9, "string_split(), failed to correctly split string into correct number of elements (with \\n delimiter)");
		
			assert_array_equals(_result, ["1test", "2test,", "3test,,,,", "4test", "5test。", "6test，", "7test，，", "8test", "9test"],
				"string_split(), failed to correctly split string with non-latin characters (with \\n delimiter)");
		})
	}
	
	// STRING_SPLIT_EXT TESTS
	{
		addFact("string_split_ext_test #1", function() {
		
			// Check that a string can be correctly split with multiple delimiters
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], false);
			assert_array_length(_result, 6, "string_split_ext(), failed to correctly split string into correct number of elements.");
			assert_array_equals(_result, ["he", "", "o", "great", "wor", "d"],"string_split_ext(), failed to correctly split string with latin characters.");
		})
	
		addFact("string_split_ext_test #2", function() {
			
			// Check that a string can be correctly split with multiple delimiters, removing empty entries
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], true);
			assert_array_length(_result, 5, "string_split_ext(), failed to correctly split string into correct number of elements (removing empty entries)");
			assert_array_equals(_result, ["he", "o", "great", "wor", "d"],"string_split_ext(), failed to correctly split string with latin characters (removing empty entries)");
		})
	
		addFact("string_split_ext_test #3", function() {
			
			// Check that a string can be correctly split with multiple delimiters, with a max of 3 splits
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], false, 3);
			assert_array_length(_result, 4, "string_split_ext(), failed to correctly split string into correct number of elements (with max splits of 3)");
			assert_array_equals(_result, ["he", "", "o", "great,world"],"string_split_ext(), failed to correctly split string with latin characters (with max splits of 3)");
		})
	}
	
	// STRING_STARTS_WITH_TESTS
	{
		addFact("string_starts_with_test #1", function() {
			
			// Check that a standard substring can be identified at the start of a string
			var _input = "hello world";
			var _result = string_starts_with(_input, "hello");
			assert_true(_result, "string_starts_with( string local , string const ), failed to correctly detect start of the basic string");
		})
	
		addFact("string_starts_with_test #2", function() {
			
			// Check that a substring of emojis can be identified at the start of a string
			var _input = "🏡🔠👸👟🕔🕝💎"
			var _result = string_starts_with(_input, "🏡🔠👸");
			assert_true(_result, "string_starts_with( string local , string const ), failed to correctly detect start of the string, containing emoji characters");
		})
	}
	
	// STRING_ENDS_WITH_TESTS
	{
		addFact("string_ends_with_test #1", function() {
			
			// Check that a standard substring can be identified at the end of a string
			var _input = "hello world";
			var _result = string_ends_with(_input, "world");
			assert_true(_result, "string_ends_with( string local , string const ), failed to correctly detect end of the basic string");
		})
	
		addFact("string_ends_with_test #2", function() {
			
			// Check that a substring of emojis can be identified at the end of a string
			var _input = "🏡🔠👸👟🕔🕝💎";
			var _result = string_ends_with(_input, "🕔🕝💎");
			assert_true(_result, "string_ends_with( string local , string const ), failed to correctly detect end of the string, containing emoji characters");
		})
	}

	// STRING_TRIM_START TESTS
	{
		addFact("string_trim_start_test #1", function() {
			
			// Check that a standard string is correctly trimmed
			var _input = "		 	sometext				";
			var _result = string_trim_start(_input);
			assert_equals(_result, "sometext				", 
			"string_trim_start( string local ), failed to correctly trim the start of the basic string");
		})
		
		addFact("string_trim_start_test #2", function() {
			
			// Check that a string containing non-latin characters is correctly trimmed
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim_start(_input);
			assert_equals(_result, "秧秧秧秧秧秧秧秧                  ", 
			"string_trim_start( string local ), failed to correctly trim the start of the string, containing non-latin characters");
		})
	}
	
	// STRING_TRIM_END TESTS
	{
		addFact("string_trim_end_test #1", function() {
		
			// Check that a standard string is correctly trimmed
			var _input = "		 	sometext				";
			var _result = string_trim_end(_input);
			assert_equals(_result, "		 	sometext", 
			"string_trim_end( string local ), failed to correctly trim the end of the basic string");
		})
	
		addFact("string_trim_end_test #2", function() {
			
			// Check that a string containing non-latin characters is correctly trimmed
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim_end(_input);
			assert_equals(_result, "                  秧秧秧秧秧秧秧秧", 
			"string_trim_end( string local ), failed to correctly trim the end of the string, containing non-latin characters");
		})
	}
	
	// STRING_TRIM TESTS
	{
		addFact("string_trim_test #1", function() {
			
			// Check that a standard string is correctly trimmed
			var _input = "		 	sometext				";
			var _result = string_trim(_input);
			assert_equals(_result, "sometext", 
			"string_trim_end( string local ), failed to correctly trim the basic string");
		})
		
		addFact("string_trim_test #2", function() {
			
			// Check that a string containing non-latin characters is correctly trimmed
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim(_input);
			assert_equals(_result, "秧秧秧秧秧秧秧秧", 
			"string_trim_end( string local ), failed to correctly trim the string, containing non-latin characters");
		})
	}
	
	// STRING_FOREACH TESTS
	{
		addFact("string_foreach_test #1", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧sometext";
			
			// Check that the function is correctly run for each character in the string
			string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
				assert_equals(_char, string_char_at(in, _pos), 
				"string_foreach( string local , function ), failed to correctly traverse the string.");
			}));
		})
	
		addFact("string_foreach_test #2", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧sometext";
			
			// Check that the function is correctly run for each character in the string, when starting from the end and traversing backwards
			string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
				assert_equals(_char, string_char_at(in, _pos), 
				"string_foreach( string local , function ), failed to correctly traverse the string from the end.");
			}), -1, -infinity);	
		})
	}
	
}

