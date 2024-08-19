
function BasicStringTestSuite() : TestSuite() constructor {
    
    // ANSI_CHAR TESTS - PROGRESS: FINISHED
    {
	    addFact("ansi_char_test #1", function() {
    
	        // Check that the 'A' char can be correctly returned, with a local variable input
	        var aStr = ansi_char($41); // Hex $41 == 65 == ASCII 'A'
	        assert_equals(aStr, "A", "ASCII 65 (as local variable) should equal 'A'");
	    });
    
	    addFact("ansi_char_test #2", function() {
        
	        // Check that the 'B' char can be correctly returned, with a literal input
			assert_equals(ansi_char($42), "B", "ASCII 66 (as literal value) should equal 'B'"); // Hex $42 == 66 == ASCII 'B'
	    });
    
	    addFact("ansi_char_test #3", function() {
        
	        // Check that all the chars in "Hello" & "world" can be correctly returned, and concatenated
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        assert_equals(helloStr, "Hello", "String (as local variable) should equal 'Hello'");
	        assert_equals(worldStr, "world", "String (as local variable) should equal 'world'");
	    });
    
	    addFact("ansi_char_test #4", function() {
			
			// Check that the space char can be correctly returned
	        var space = ansi_char($20); // Hex $20 == 32 == ASCII ' '
	        assert_equals(space, " ", "ASCII 32 (as local variable) should equal ' '");
	    });
    
	    addFact("ansi_char_test #5", function() {
			
			// Check that the exclamation mark char can be correctly returned
	        var exclamation = ansi_char($21); // Hex $21 == 33 == ASCII '!'
	        assert_equals(exclamation, "!", "ASCII 33 (as local variable) should equal '!'");
	    });
    
	    addFact("ansi_char_test #6", function() {
        
			// Check that all the chars in "Hello world!" can be correctly returned, and concatenated
	        var fullStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F) + ansi_char($20) + ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64) + ansi_char($21);
	        assert_equals(fullStr, "Hello world!", "String (as local variable) should equal 'Hello word!'");
	    });
    
	    addFact("ansi_char_test #7", function() {
        
			// Check that the returned chars stored in local variables can be correctly concatenated
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        var space = ansi_char($20);
	        var exclamation = ansi_char($21);
        
	        var concatTest = helloStr + space + worldStr + exclamation;
	        assert_equals(concatTest, "Hello world!", "String (as concatenated local variable) should equal 'Hello word!'");
	    });
    
	    addFact("ansi_char_test #8", function() {
			
			// Check that the returned chars stored in local variables can be correctly concatenated using +=
	        var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F);
	        var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64);
	        var space = ansi_char($20);
	        var exclamation = ansi_char($21);
        
	        var concatQuickTest = helloStr;
	        concatQuickTest += space;
	        concatQuickTest += worldStr;
	        concatQuickTest += exclamation;
	        assert_equals(concatQuickTest, "Hello world!", "String (as concatenated local variable) should equal 'Hello word!'");
	    });
	}

    // CHR TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES
    {
	    addFact("chr_test #1", function() {
        
	        // Basic ASCII test
	        var aStr = chr(65);
	        assert_equals(aStr, "A", "ASCII 65 == 'A'");
	    });
    
	    addFact("chr_test #2", function() {
        
	        // Literals
	        assert_equals(chr(66), "B", "ASCII 66 == 'B'");
	    });
    
	    addFact("chr_test #3", function() {
        
	        // Hello world test
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        assert_equals(helloStr, "Hello", "Hello str Test");
	        assert_equals(worldStr, "world", "world str Test");
	    });
    
	    addFact("chr_test #4", function() {
        
	        var space = chr(32);
	        assert_equals(space, " ", "Space char test");
	    });
    
	    addFact("chr_test #5", function() {
        
	        var exclamation = chr(33);
	        assert_equals(exclamation, "!", "Exclamation char test");
	    });
    
	    addFact("chr_test #6", function() {
        
	        var fullStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111) + chr(32) + chr(119) + chr(111) + chr(114) + chr(108) + chr(100) + chr(33);
	        assert_equals(fullStr, "Hello world!", "Hello world string test");
	    });
    
	    addFact("chr_test #7", function() {
        
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        var space = chr(32);
	        var exclamation = chr(33);
        
	        var concatTest = helloStr + space + worldStr + exclamation;
	        assert_equals(concatTest, "Hello world!", "Concat Hello world string test");
	    });
    
	    addFact("chr_test #8", function() {
        
	        var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
	        var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
	        var space = chr(32);
	        var exclamation = chr(33);
        
	        var concatQuickTest = helloStr;
	        concatQuickTest += space;
	        concatQuickTest += worldStr; 
	        concatQuickTest += exclamation;
	        assert_equals(concatQuickTest, "Hello world!", "Concat hello world string test");
	    });
	}
	
    // CHR UNICODE TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES
    {
	    addFact("chr_unicode_test #1", function() {
        
	        var euro = chr(8364); //Unicode euro test
	        assert_equals(euro, "€", "Euro sign test");
	    });
    
	    addFact("chr_unicode_test #2", function() {
        
	        var indianRupee = chr(8377);
	        assert_equals(indianRupee, "₹", "Indian Rupee sign test");
	    });
    
	    addFact("chr_unicode_test #3", function() {
        
	        var rupee = chr(8360);
	        assert_equals(rupee, "₨", "Rupee sign test");
	    });
    
	    addFact("chr_unicode_test #4", function() {
        
	        var theta = chr(952);
	        assert_equals(theta, "θ", "Theta test");
	    });
    
	    addFact("chr_unicode_test #5", function() {
        
	        var smileyFace = chr(128578);
	        assert_equals(smileyFace, "🙂", "Smiley face literal test");
	    });
    
	    addFact("chr_unicode_test #6", function() {
        
	        var euroOrd = 8364;
	        var euroChar = chr(euroOrd); //Unicode euro test
	        assert_equals(euroChar, "€", "Euro sign test");
	    });
    
	    addFact("chr_unicode_test #7", function() {
        
	        var u8001 = 32769;
	        var u8001Chr = chr(u8001);
	        assert_equals(u8001Chr, "老", "u8001 is 老");
	    });
    
	    addFact("chr_unicode_test #8", function() {
        
	        var u8001 = 32769;
	        var u8001Chr = chr(u8001);
	        assert_equals(u8001Chr, "老", "u8001 is 老");
	    });
    
	    addFact("chr_unicode_test #9", function() {
        
	        var u8001ChrLit = chr(32769);
	        assert_equals(u8001ChrLit, "老", "u8001 is 老");
	    });
    
	    addFact("chr_unicode_test #10", function() {
        
	        var indianRupeeOrd = 8377;
	        var indianRupeeChar = chr(indianRupeeOrd);
	        assert_equals(indianRupeeChar, "₹", "Indian Rupee sign test")
	    });
    
	    addFact("chr_unicode_test #11", function() {
        
	        var rupeeOrd = 8360;
	        var rupeeChar = chr(rupeeOrd);
	        assert_equals(rupeeChar, "₨", "Rupee sign test");
	    });
    
	    addFact("chr_unicode_test #12", function() {
        
	        var thetaOrd = 952;
	        var thetaChar = chr(thetaOrd);
	        assert_equals(thetaChar, "θ", "Theta test");
	    });
    
	    addFact("chr_unicode_test #14", function() {
        
	        var smileyFaceOrd = 128578;
	        var smileyFaceChar = chr(smileyFaceOrd);
	        assert_equals(smileyFaceChar, "🙂", "Smiley face var test");
	    });
    
	    addFact("chr_unicode_test #14", function() {
        
	        var aUChar = "\u41";
	        assert_equals(aUChar, "A", "A char");
	    });
    
	    addFact("chr_unicode_test #15", function() {
        
	        var euroUChar = "\u20AC";
	        assert_equals(euroUChar, "€", "Euro symbol");
	    });
    
	    addFact("chr_unicode_test #16", function() {
        
	        var u8001UChar = "\u8001";
	        assert_equals(u8001UChar, "老", "u8001 symbol");
	    });
    
	    addFact("chr_unicode_test #17", function() {
        
	        var u1F642UChar = "\u1F642";
	        assert_equals(u1F642UChar, "🙂", "Smiley face u char test");
	    });
    
	    addFact("chr_unicode_test #18", function() {
        
	        var variousChars = "\u1F642\u8001\u20AC\u41";
	        assert_equals(variousChars, "🙂老€A", "Various char string was successful");
	    });
    
	    addFact("chr_unicode_test #19", function() {
        
	        var smileyString = "\u1F642\u1F642\u1F642\u8001\u1F642\u1F642";
	        assert_equals(smileyString, "🙂🙂🙂老🙂🙂", "Various char string was successful");
	    });
    
	    addFact("chr_unicode_test #20", function() {
        
	        var smileyEuros = "\u20AC\u1F642\u20AC\u1F642\u20AC\u1F642\u20AC";
	        assert_equals(smileyEuros, "€🙂€🙂€🙂€", "Various char string was successful");
	    });
	
		addFact("ord_test #1", function() {
        
			var zeroChar = ord("0");
			assert_equals(zeroChar, 48, "ASCII Zero == 48");
	    });
	
		addFact("ord_test #2", function() {
        
			var uppercaseA = ord("A");
			assert_equals(uppercaseA, 65, "ASCII A == 65");
	    });
	
		addFact("ord_test #3", function() {
        
			var lowercaseA = ord("a");
			assert_equals(lowercaseA, 97, "ASCII a == 97");
	    });
	
		addFact("ord_test #4", function() {
        
			var poundSymbol = ord("£");
			assert_equals(poundSymbol, 163, "£ sign == 163");
	    });
	
		addFact("ord_test #5", function() {
        
			var euroSymbol = ord("€");
			assert_equals(euroSymbol, 8364, "€ sign == 8364");
	    });
	
		addFact("ord_test #6", function() {
        
			var indianRupee = ord("₹");
			assert_equals(indianRupee, 8377, "Indian Rupee sign test");
	    });
	
		addFact("ord_test #7", function() {
        
			var rupee = ord("₨");
			assert_equals(rupee, 8360, "Rupee sign test");
	    });
	
		addFact("ord_test #8", function() {
        
			var theta = ord("θ");
			assert_equals(theta, 952, "Theta test");
	    });
	
		addFact("ord_test #9", function() {
        
			var smileyOrdLit = ord("🙂");
			assert_equals(smileyOrdLit, 128578, "Smiley face ord literal test");
	    });
	
		addFact("ord_test #10", function() {
        
			var zeroChar = "0";
			var zeroOrd = ord(zeroChar);
			assert_equals(zeroOrd, 48, "ASCII Zero == 48");
	    });
	
		addFact("ord_test #11", function() {
        
			var uppercaseA = "A";
			var uppercaseAOrd = ord(uppercaseA);
			assert_equals(uppercaseAOrd, 65, "ASCII A == 65");
	    });
	
		addFact("ord_test #12", function() {
        
			var lowercaseA = "a";
			var lowercaseAOrd = ord(lowercaseA);
			assert_equals(lowercaseAOrd, 97, "ASCII a == 97");
	    });
	
		addFact("ord_test #13", function() {
        
			var poundSymbol = "£";
			var poundSymbolOrd = ord(poundSymbol);
			assert_equals(poundSymbolOrd, 163, "£ sign == 163");
	    });
	
		addFact("ord_test #14", function() {
        
			var euroSymbol = "€";
			var euroSymbolOrd = ord(euroSymbol);
			assert_equals(euroSymbolOrd, 8364, "€ sign == 8364");
	    });
	
		addFact("ord_test #15", function() {
        
			var indianRupee = "₹";
			var indianRupeeOrd = ord(indianRupee);
			assert_equals(indianRupeeOrd, 8377, "Indian Rupee sign test");
	    });
	
		addFact("ord_test #15", function() {
        
			var rupee = "₨";
			var rupeeOrd = ord(rupee);
			assert_equals(rupeeOrd, 8360, "Rupee sign test");
	    });
	
		addFact("ord_test #15", function() {
        
			var theta = "θ";
			var thetaOrd = ord(theta);
			assert_equals(thetaOrd, 952, "Theta test");
	    });
	
		addFact("ord_test #15", function() {
        
			var smileyVar = "🙂";
			var smileyOrdVar = ord(smileyVar);
			assert_equals(smileyOrdVar, 128578, "Smiley face var ord test");
	    });
	}
	
	// STRING_BYTE_AT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_byte_at_test #1", function() {
        
			var vstring = "hello World!";
		
			//#1 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, 7);
			assert_equals(res, 87, "string_byte_at( string local , real const )"); // 87 = 'W'
	    });
	
		addFact("string_byte_at_test #2", function() {
        
			var vstring = "hello World!";
		
			//#2 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, 7.6);
			assert_equals(res, 87, "string_byte_at( string local , real const )"); // 87 = 'W'
	    });
	
		addFact("string_byte_at_test #3", function() {
        
			var vstring = "hello World!";
		
			//#3 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, 7.2);
			assert_equals(res, 87, "string_byte_at( string local , real const )"); // 87 = 'W'
	    });
	
		addFact("string_byte_at_test #4", function() {
        
			var vstring = "hello World!";
		
			//#4 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, 0);
			assert_equals(res, 104, "string_byte_at( string local , real const )"); // 104 = 'h'
	    });
	
		addFact("string_byte_at_test #5", function() {
        
			var vstring = "hello World!";
		
			//#5 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, 100);
			assert_equals(res, 33, "#5 string_byte_at( string local , real const )"); // 33 = '!'
	    });
	
		addFact("string_byte_at_test #6", function() {
        
			var vstring = "hello World!";
		
			//#6 string_byte_at( string local , real const )
			var res = string_byte_at(vstring, -2);
			assert_equals(res, 104, "#6 string_byte_at( string local , real const )"); // 104 = 'h'
	    });
	
		addFact("string_byte_at_test #7", function() {
        
			#macro kString_StringByteAtTest "Hello World!"
		
			//#7 string_byte_at( string macro , real const )
			var res = string_byte_at(kString_StringByteAtTest, 7);
			assert_equals(res, 87, "string_byte_at( string macro , real const )");
	    });
	
		addFact("string_byte_at_test #8", function() {
        
			global.gstring = "Hello World!";
		
			//#8 string_byte_at( string global , real const )
			var res = string_byte_at(global.gstring, 7);
			assert_equals(res, 87, "string_byte_at( string global , real const )");
	    });
	
		addFact("string_byte_at_test #9", function() {
        
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#9 string_byte_at( string instance , real const )
			var res = string_byte_at(_oTest.ostring, 7);
			assert_equals(res, 87, "string_byte_at( string instance , real const )");
		
			instance_destroy(_oTest);
	    });
	
		addFact("string_byte_at_test #10", function() {
        
			//#10 string_byte_at( string const , real const )
			var res = string_byte_at("!£水🙂a", 1); 
			assert_equals(res, 0x21, "string_byte_at( string const , real const )"); // 0x21 = !
	    });
	
		addFact("string_byte_at_test #11", function() {
        
			//#11 string_byte_at( string const , real const )
			var res = string_byte_at("!£水🙂a", 2);
			assert_equals(res, 0xc2, "string_byte_at( string const , real const )"); // 0xc2 0xa3 = '£'
	    });
	
		addFact("string_byte_at_test #12", function() {
        
			//#12 string_byte_at( string const , real const )
			var res = string_byte_at("!£水🙂a", 4);
			assert_equals(res, 0xe6, "string_byte_at( string const , real const )"); // 0xe6 0xb0 0xb4 = '水'
	    });
	
		addFact("string_byte_at_test #13", function() {
        
			//#13 string_byte_at( string const , real const )
			var res = string_byte_at("!£水🙂a", 7);
			assert_equals(res, 0xf0, "string_byte_at( string const , real const )"); // 0xf0 0x9f 0x99 0x82 = "🙂"
	    });
	
		addFact("string_byte_at_test #14", function() {
        
			//#14 string_byte_at( string const , real const )
			res = string_byte_at("!£水🙂a", 11);
			assert_equals(res, 0x61, "#14 string_byte_at( string const , real const )"); // 0x61 = 'a'
	    });
	}

	// STRING_BYTE_LENGTH TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_byte_length_test #1", function() {
        
			var helloWorldStr = "Hello world!";
			var helloWorldByteLen = string_byte_length(helloWorldStr);
			assert_equals(helloWorldByteLen, 12, "Hello world!, as an ascii string, is 12 bytes");
	    });
	
		addFact("string_byte_length_test #2", function() {
        
			var literalHWByteLen = string_byte_length("Hello world!");
			assert_equals(literalHWByteLen, 12, "Literal Hello world!, as an ascii string, is 12 bytes");
	    });
	
		// UTF8 tests
		addFact("string_byte_length_test #3", function() {
        
			var poundPrice = "£99.99";
			var poundPriceLen = string_byte_length(poundPrice);
			assert_equals(poundPriceLen, 7, "Pound price string is 7 bytes long");
	    });
	
		addFact("string_byte_length_test #4", function() {
        
			var euroPrice = "€59.99";
			var euroPriceLen = string_byte_length(euroPrice);
			assert_equals(euroPriceLen, 8, "Euro price string is 8 bytes long");
	    });
	
		addFact("string_byte_length_test #5", function() {
        
			var someSymbols = "‰ˆ‡†•";
			var someSymbolsLen = string_byte_length(someSymbols);
			assert_equals(someSymbolsLen, 14, "Byte length of someSymbols string is 14");
	    });
	
		addFact("string_byte_length_test #6", function() {
        
			var aikido = "合気道";
			var aikidoLen = string_byte_length(aikido);
			assert_equals(aikidoLen, 9, "Aikido is 9 bytes");
	    });
	
		addFact("string_byte_length_test #7", function() {
        
			var kotegaeshi = "小手返";
			var kotegaeshiLen = string_byte_length(kotegaeshi);
			assert_equals(kotegaeshiLen, 9, "kotegaeshi is 9 bytes");
	    });
	
		// Emoji!
		addFact("string_byte_length_test #8", function() {
        
			var smileyFace = "🙂";
			var smileyFaceLen = string_byte_length(smileyFace);
			assert_equals(smileyFaceLen, 4, "1 Smiley face is 4 bytes");
	    });
	
		addFact("string_byte_length_test #9", function() {
        
			assert_equals(string_byte_length("🙂"), 4, "Smiley face literal");
	    });
	
		addFact("string_byte_length_test #10", function() {
        
			var emojiString = "💩👏✔";
			var emojiLen = string_byte_length(emojiString);
			assert_equals(emojiLen, 11, "Emoji len is 11 bytes long");
	    });
	}
	
	// STRING_CHAR_AT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_char_at_test #1", function() {
        
			var vstring = "hello World!";
		
			//#1 string_char_at( real local , real const )
			var res = string_char_at(vstring, 7);
			assert_true(is_string(res), "string_char_at( real local , real const )");
			assert_equals(res, "W", "string_char_at( real local , real const )");
	    });
	
		addFact("string_char_at_test #2", function() {
        
			var vstring = "hello World!";
		
			//#2 string_char_at( string local , real const )
			var res = string_char_at(vstring, 7.6);
			assert_true(is_string(res), "string_char_at( string local , real const )");
			assert_equals(res, "W", "string_char_at( string local , real const )");
	    });
	
		addFact("string_char_at_test #3", function() {
        
			var vstring = "hello World!";
		
			//#3 string_char_at( string local , real const )
			var res = string_char_at(vstring, 7.2);
			assert_true(is_string(res), "string_char_at( string local , real const )");
			assert_equals(res, "W", "string_char_at( string local , real const )");
	    });
	
		addFact("string_char_at_test #4", function() {
        
			var vstring = "hello World!";
		
			//#4 string_char_at( string local , real const )
			var res = string_char_at(vstring, 0);
			assert_true(is_string(res), "string_char_at( string local , real const )");
			assert_equals(res, "h", "string_char_at( string local , real const )");
	    });
	
		addFact("string_char_at_test #5", function() {
        
			var vstring = "hello World!";
		
			//#5 string_char_at( string local , real const )
			var res = string_char_at(vstring, 100);
			assert_true(is_string(res), "string_char_at( string local , real const )");
			assert_equals(res, "", "string_char_at( string local , real const )");
	    });
	
		addFact("string_char_at_test #6", function() {
        
			var vstring = "hello World!";
		
			//#6 string_char_at( string local , real const )
			var res = string_char_at(vstring, -2);
			assert_true(is_string(res), "string_char_at( string local , real const )");
			assert_equals(res, "h", "string_char_at( string local , real const )");
	    });
	
		addFact("string_char_at_test #7", function() {
        
			var vstring = "hello World!";
		
			//#7 string_char_at( int64 const , real const )
			var res = string_char_at(int64(1234), 2);
			assert_true(is_string(res), "string_char_at( int64 const , real const )");
			assert_equals(res, "2", "string_char_at( int64 const , real const )");
	    });
	
		addFact("string_char_at_test #8", function() {
        
			var vstring = "hello World!";
		
			//#8 string_char_at( real const , real const )
			var res = string_char_at(1.234, 2);
			assert_true(is_string(res), "string_char_at( real const , real const )");
			assert_equals(res, ".", "string_char_at( real const , real const )");
	    });
	
		addFact("string_char_at_test #9", function() {
        
			var vstring = "hello World!";
		
			//#9 string_char_at( bool const , real const )
			var res = string_char_at(true, 1);
			assert_true(is_string(res), "string_char_at( bool const , real const )");
			assert_equals(res, "1", "string_char_at( bool const , real const )");
	    });
	
		addFact("string_char_at_test #10", function() {
        
			#macro kString_StringCharAtTest "Hello World!"
		
			//#10 string_char_at( string macro , real const )
			var res = string_char_at(kString_StringCharAtTest, 7);
			assert_equals(res, "W", "string_char_at( string macro , real const )");
	    });
	
		addFact("string_char_at_test #11", function() {
        
			global.gstring = "Hello World!";
		
			//#11 string_char_at( string global , real const )
			var res = string_char_at(global.gstring, 7);
			assert_equals(res, "W", "string_char_at( string global , real const )");
	    });
	
		addFact("string_char_at_test #12", function() {
        
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#12 string_char_at( string instance , real const )
			var res = string_char_at(_oTest.ostring, 7);
			assert_equals(res, "W", "string_char_at( string instance , real const )");
		
			instance_destroy(_oTest);
	    });
	
		// UTF-8 tests 2/3/4 bytes
		addFact("string_char_at_test #13", function() {
        
			//#13 string_char_at( string const , real const )
			var res = string_char_at("!£水🙂a", 1);
			assert_equals(res, "!", "string_char_at( string const , real const )");
	    });
	
		addFact("string_char_at_test #14", function() {
        
			//#14 string_char_at( string const , real const )
			var res = string_char_at("!£水🙂a", 2);
			assert_equals(res, "£", "string_char_at( string const , real const )");
	    });
	
		addFact("string_char_at_test #15", function() {
        
			//#15 string_char_at( string const , real const )
			var res = string_char_at("!£水🙂a", 3);
			assert_equals(res, "水", "string_char_at( string const , real const )");
	    });
	
		addFact("string_char_at_test #16", function() {
        
			//#16 string_char_at( string const , real const )
			var res = string_char_at("!£水🙂a", 4);
			assert_equals(res, "🙂", "#tring_char_at( string const , real const )");
	    });
	
		addFact("string_char_at_test #17", function() {
        
			//#17 string_char_at( string const , real const )
			var res = string_char_at("!£水🙂a", 5);
			assert_equals(res, "a", "string_char_at( string const , real const )");
	    });
	}
	
	// STRING_COPY TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_copy_test #1", function() {
        
			var helloWorldStr = "Hello World";
			var helloStr = string_copy(helloWorldStr, 1, 5);
			assert_equals(helloStr, "Hello", "String copy the first five characters");
	    });
	
		addFact("string_copy_test #2", function() {
        
			var helloWorldStr = "Hello World";
			var worldStr = string_copy(helloWorldStr, 7, 5);
			assert_equals(worldStr, "World", "String copy the five characters from the 7th index");
	    });
	
		// UTF8
		addFact("string_copy_test #3", function() {
        
			var fullPriceStr = "£12.34";
			var poundPriceStr = string_copy(fullPriceStr, 1, 3);
			var pencePriceStr = string_copy(fullPriceStr, 5, 2);
			assert_equals(poundPriceStr, "£12", "Copied three characters to make the \"£12\" string");
			assert_equals(pencePriceStr, "34", "Copied two characters to make the \"34\" string");
	    });
	
		addFact("string_copy_test #4", function() {
        
			var fullEuroStr = "€56.78";
			var euroPriceStr = string_copy(fullEuroStr, 1, 3);
			var centsPriceStr = string_copy(fullEuroStr, 5, 2);
			assert_equals(euroPriceStr, "€56", "Copied three characters to make the \"€56\" string");
			assert_equals(centsPriceStr, "78", "Copied two characters to make the \"78\" string");
	    });
	
		addFact("string_copy_test #5", function() {
        
			var aikido = "合気道";
			var aiki = string_copy(aikido, 1, 2);
			assert_equals(aiki, "合気", "Copying the first two chars ai and ki");
	    });
	
		addFact("string_copy_test #6", function() {
        
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestStr = string_copy(kotegaeshi, 5, 4);
			assert_equals(kotegaeshiTestStr, "Test", "Copy \"Test\" from kotegaeshi string");
	    });
	
		// Emoji
		addFact("string_copy_test #7", function() {
        
			var smileyTestString = "This is a test 🙂";
			var smileyString = string_copy(smileyTestString, 16, 1);
			assert_equals(smileyString, "🙂", "Copy the smiley face");
	    });
	
		addFact("string_copy_test #8", function() {
        
			var smileyPosLiteral = string_copy("This is a test 🙂", 16, 1);
			assert_equals(smileyPosLiteral, "🙂", "Copy the smiley face from a string literal");
	    });
	
		addFact("string_copy_test #9", function() {
        
			var emojiString = "✔✔✔💩👏";
			var clapEmojiStr = string_copy(emojiString, 5, 1);
			assert_equals(clapEmojiStr, "👏", "Copy the clap emoji");
	    });
	
		addFact("string_copy_test #10", function() {
        
			var emojiString = "✔✔✔💩👏 hello world";
			var clapEmojiStr = string_copy(emojiString, 5, 13);
			assert_equals(clapEmojiStr, "👏 hello world", "Copy the hello world as well, after the clap emoji");
	    });
	}
	
	// STRING_COUNT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_count_test #1", function() {
        
			var helloWorldStr = "Hello World";
			var numLs = string_count("l", helloWorldStr);
			var numOs = string_count("o", helloWorldStr);
			assert_equals(numLs, 3, "3 Ls in \"Hello World\"");
			assert_equals(numOs, 2, "2 Os in \"Hello World\"");
	    });
	
		addFact("string_count_test #2", function() {
        
			var numHellos = string_count("Hello", helloWorldStr);
			var numWorlds = string_count("World", helloWorldStr);
			assert_equals(numHellos, 1, "One \"Hello\" in \"Hello World\"");
			assert_equals(numWorlds, 1, "One \"World\" in \"Hello World\"");
	    });
	
		addFact("string_count_test #3", function() {
        
			var poundStr = "£12.34";
			var numPounds = string_count("£", poundStr);
			assert_equals(numPounds, 1, "One pound glyph in poundStr");
	    });
	
		addFact("string_count_test #4", function() {
        
			var ninesStr = "£999.99";
			var numNines = string_count("9", ninesStr);
			assert_equals(numNines, 5, "Five nines in ninesStr");
	    });
	
		addFact("string_count_test #5", function() {
        
			var euroStr = "€12.34";
			var numEuros = string_count("€", euroStr);
			assert_equals(numEuros, 1, "One euro glyph in euroStr");
	    });
	
		addFact("string_count_test #6", function() {
        
			var fivesStr = "€12555.55"
			var numFives = string_count("5", fivesStr);
			assert_equals(numFives, 5, "Five fives in fivesStr");
	    });
	
		addFact("string_count_test #7", function() {
        
			var aikido = "合気道合気道合気道合気道";
			var numAi = string_count("合", aikido);
			assert_equals(numAi, 4, "Four Ai glyphs in aikido string");
	    });
	
		addFact("string_count_test #7", function() {
        
			var smileyString = "This is a test 🙂";
			var numSmileys = string_count("🙂", smileyString);
			assert_equals(numSmileys, 1, "Only one smiley in smileyString");
	    });
	
		addFact("string_count_test #8", function() {
        
			var emojiString = "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎";
			var numDiamonds = string_count("💎", emojiString);
			assert_equals(numDiamonds, 4, "Four diamond emoji in emojiString");
	    });
	}
	
	// STRING_DELETE TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_delete_test #1", function() {
        
			var vstring = "Hello World!";
		
			//#1 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7, 1);
			assert_equals(res, "Hello orld!", "string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #2", function() {
        
			var vstring = "Hello World!";
		
			//#2 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7, 2);
			assert_equals(res, "Hello rld!", "#2 string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #3", function() {
        
			var vstring = "Hello World!";
		
			//#3 string_delete( string local , real const , real const ) - delete count > ramining string length
			var res = string_delete(vstring, 7, 50);
			assert_equals(res, "Hello ", "#3 string_delete( string local , real const , real const ) - delete count > ramining string length");
	    });
	
		addFact("string_delete_test #4", function() {
        
			var vstring = "Hello World!";
		
			//#4 string_delete( string local , real const , real const ) - delete zero count
			var res = string_delete(vstring, 7, 0);
			assert_equals(res, "Hello World!", "#4 string_delete( string local , real const , real const ) - delete zero count");
	    });
	
		addFact("string_delete_test #5", function() {
        
			var vstring = "Hello World!";
		
			//#5 string_delete( string local , real const , real const ) - delete negative count
			var res = string_delete(vstring, 7, -1);
			assert_equals(res, "Hello orld!", "#5 string_delete( string local , real const , real const ) - delete negative count");
	    });
	
		addFact("string_delete_test #6", function() {
        
			var vstring = "Hello World!";
		
			//#6 string_delete( string local , real const , real const ) - index > string length
			var res = string_delete(vstring, 100, 1);
			assert_equals(res, "Hello World!", "#6 string_delete( string local , real const , real const ) - index > string length");
	    });
	
		addFact("string_delete_test #7", function() {
        
			var vstring = "Hello World!";
		
			//#7 string_delete( string local , real const , real const ) - zero index
			var res = string_delete(vstring, 0, 1);
			assert_equals(res, "Hello World!", "#7 string_delete( string local , real const , real const ) - zero index");
	    });
	
		addFact("string_delete_test #8", function() {
        
			var vstring = "Hello World!";
		
			//#8 string_delete( string local , real const , real const ) - negative index
			var res = string_delete(vstring, -1, 1);
			assert_equals(res, "Hello World", "#8 string_delete( string local , real const , real const ) - negative index");
	    });
	
		addFact("string_delete_test #9", function() {
        
			var vstring = "Hello World!";
		
			//#9 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7, 2.4);
			assert_equals(res, "Hello rld!", "#9 string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #10", function() {
        
			var vstring = "Hello World!";
		
			//#10 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7, 2.6);
			assert_equals(res, "Hello rld!", "#10 string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #11", function() {
        
			var vstring = "Hello World!";
		
			//#11 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7.2, 2);
			assert_equals(res, "Hello rld!", "#11 string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #12", function() {
        
			var vstring = "Hello World!";
		
			//#12 string_delete( string local , real const , real const )
			var res = string_delete(vstring, 7.6, 2);
			assert_equals(res, "Hello rld!", "#12 string_delete( string local , real const , real const )");
	    });
	
		addFact("string_delete_test #13", function() {
        
			var vstring = "Hello World!";
		
			//#13 string_delete( string local , string const , real const )
			var res = string_delete(vstring, "7", 2);
			assert_equals(res, "Hello rld!", "#13 string_delete( string local , string const , real const )");
	    });
	
		addFact("string_delete_test #14", function() {
        
			var vstring = "Hello World!";
		
			//#14 string_delete( string local , real const , string const )
			var res = string_delete(vstring, 7, "2");
			assert_equals(res, "Hello rld!", "#14 string_delete( string local , real const , string const )");
	    });
	
		addFact("string_delete_test #15", function() {
        
			var vstring = "Hello World!";
		
			//#15 string_delete( string local , real const , real const ) - empty string
			var res = string_delete("", 1, 1);
			assert_equals(res, "", "#15 string_delete( string local , real const , real const ) - empty string");
	    });
	
		addFact("string_delete_test #16", function() {
        
			var vstring = "Hello World!";
		
			//#16 string_delete( int64 local , real const , real const )
			var res = string_delete(int64(1234), 2, 1);
			assert_true(is_string(res), "#16 string_delete( int64 local , real const , real const )");
			assert_equals(res, "134", "#16 string_delete( int64 local , real const , real const )");
	    });
	
		addFact("string_delete_test #17", function() {
        
			var vstring = "Hello World!";
		
			//#17 string_delete( real local , real const , real const )
			var res = string_delete(1.234, 2, 1);
			assert_true(is_string(res), "#17 string_delete( real local , real const , real const )");
			assert_equals(res, "123", "#17 string_delete( real local , real const , real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
	    });
	
		addFact("string_delete_test #18", function() {
        
			var vstring = "Hello World!";
		
			//#18 string_delete( bool local , real const , real const )
			var res = string_delete(true, 1, 1);
			assert_true(is_string(res), "#18 string_delete( bool local , real const , real const )");
			assert_equals(res, "", "#18 string_delete( bool local , real const , real const )");
	    });
	
		addFact("string_delete_test #19", function() {
        
			#macro kString_StringDeleteTest "Hello World!"
		
			//#19 string_delete( string macro , real const , real const )
			var res = string_delete(kString_StringDeleteTest, 7, 1);
			assert_equals(res, "Hello orld!", "#19 string_delete( string macro , real const , real const )");
	    });
	
		addFact("string_delete_test #20", function() {
        
			global.gstring = "Hello World!";
		
			//#20 string_delete( string global , real const , real const )
			var res = string_delete(global.gstring, 7, 1);
			assert_equals(res, "Hello orld!", "#20 string_delete( string global , real const , real const )");
	    });
	
		addFact("string_delete_test #21", function() {
        
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#21 string_delete( string instance , real const , real const )
			var res = string_delete(_oTest.ostring, 7, 1);
			assert_equals(res, "Hello orld!", "#21 string_delete( string instance , real const , real const )");
		
			instance_destroy(_oTest);
	    });
	
		addFact("string_delete_test #22", function() {
        
			//#22 string_delete( string const , real const , real const ) - 2 byte UTF8
			var res = string_delete("Price: £3.99", 1, 8);
			assert_equals(res, "3.99", "#22 string_delete( string const , real const , real const ) - 2 byte UTF8");
	    });
	
		addFact("string_delete_test #23", function() {
        
			//#23 string_delete( string const , real const , real const ) - 3 byte UTF8
			var res = string_delete("Mizu (水)", 5, 4);
			assert_equals(res, "Mizu", "#23 string_delete( string const , real const , real const ) - 3 byte UTF8");
	    });
	
		addFact("string_delete_test #24", function() {
        
			//#24 string_delete( string const , real const , real const ) - 4 byte UTF8
			var res = string_delete("🙂", 1, 1);
			assert_equals(res, "", "#24 string_delete( string const , real const , real const ) - 4 byte UTF8");
	    });
	
		addFact("string_delete_test #25", function() {
        
			// #25
			var res = string_delete("🙂x🙂", 2, 1);
			assert_equals(res, "🙂🙂", "#25 string_delete( string const , real const , real const ) - 2x4 byte UTF8");
	    });
	
		addFact("string_delete_test #26", function() {
        
			// #26
			var res = string_delete("🙂x🙂x🙂", 4, 1);
			assert_equals(res, "🙂x🙂🙂", "#26 string_delete( string const , real const , real const ) - 2x4 byte UTF8");
	    });
	
		addFact("string_delete_test #27", function() {
        
			// #27
			var res = string_delete("🙂x🙂x🙂x🙂", 6, 1);
			assert_equals(res, "🙂x🙂x🙂🙂", "#27 string_delete( string const , real const , real const ) - 4x4 byte UTF8");
	    });
	
		addFact("string_delete_test #27", function() {
        
			// #28
			var res = string_delete("🙂x🙂x🙂x🙂", 5, 1);
			assert_equals(res, "🙂x🙂xx🙂", "#28 string_delete( string const , real const , real const ) - 4x4 byte UTF8");
	    });
	}
	
	// STRING_DIGITS TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_digits_test #1", function() {
        
			var vstring1 = "321!HeLlO WoRlD!123";
		
			//#1 string_digits( string local )
			var res = string_digits(vstring1);
			assert_equals(res, "321123", "#1 string_digits( string local )");
	    });
	
		addFact("string_digits_test #2", function() {
        
			var vstring2 = "!£水🙂";
		
			//#2 string_digits( string local ) - no digits
			var res = string_digits(vstring2);
			assert_equals(res, "", "#2 string_digits( string local ) - no digits");
	    });
	
		addFact("string_digits_test #3", function() {
        
			var vstring3 = "";
		
			//#3 string_digits( string local ) - empty string
			var res = string_digits(vstring3);
			assert_equals(res, "", "#3 string_digits( string local ) - empty string");
	    });
	
		addFact("string_digits_test #4", function() {
        
			var vstring4 = "1234";
		
			//#4 string_digits( string local ) - all digits
			var res = string_digits(vstring4);
			assert_equals(res, "1234", "#4 string_digits( string local ) - all letters");
	    });
	
		addFact("string_digits_test #5", function() {
        		
			//#5 string_digits( real const )
			var res = string_digits(1234);
			assert_equals(res, "1234", "#5 string_digits( real const )");
	    });
	
		addFact("string_digits_test #6", function() {
        		
			//#6 string_digits( real const )
			var res = string_digits(1.234);
			assert_equals(res, "123", "#6 string_digits( real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
	    });
	
		addFact("string_digits_test #7", function() {
        		
			#macro kString_StringDigitsTest "321!Hello World!123";
		
			//#7 string_digits( string macro )
			var res = string_digits(kString_StringDigitsTest);
			assert_equals(res, "321123", "#7 string_digits( string macro )");
	    });
	
		addFact("string_digits_test #8", function() {
        		
			global.gstring = "321!Hello World!123";
		
			//#8 string_digits( string global )
			var res = string_digits(global.gstring);
			assert_equals(res, "321123", "#8 string_digits( string global )");
	    });
	
		addFact("string_digits_test #9", function() {
        		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			//#9 string_digits( string instance )
			var res = string_digits(_oTest.ostring);
			assert_equals(res, "321123", "#9 string_digits( string instance )");
			
			instance_destroy(_oTest);
	    });
	}
	
	// STRING_FORMAT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_format_test #1", function() {
        		
			// With vars
			var testNum = 123456;
			var testStr = string_format(testNum, 6, 0);
			assert_equals(testStr, "123456", "Simple string format test with vars");
		});
	
		addFact("string_format_test #2", function() {
        		
			// With literals
			var testStr2 = string_format(123456789, 9, 0);
			assert_equals(testStr2, "123456789", "Simple string format test with literals");
		});
	
		addFact("string_format_test #3", function() {
        		
			// Fractional formatting
			var testStr3 = string_format(123, 3, 3);
			assert_equals(testStr3, "123.000", "String format adding zeros to a whole number");
		});
	
		addFact("string_format_test #4", function() {
        		
			var fracNum = 123.456;
			
			var fracStr = string_format(fracNum, 3, 3);
			assert_equals(fracStr, "123.456", "Simple fractional string format");
		});
	
		addFact("string_format_test #5", function() {
        		
			var fracNum = 123.456;
			
			var fracStr2 = string_format(fracNum, 6, 6);
			assert_equals(fracStr2, "   123.456000", "Fractional string with padding on the left and right of the decimal point");
		});
	
		addFact("string_format_test #6", function() {
        		
			var fracNum = 123.456;
			
			var fracStr3 = string_format(fracNum, 3, 0);
			assert_equals(fracStr3, "123", "Fractional string with decimal part discarded");
		});
	}
	
	// STRING_HASH_TO_NEWLINE TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_hash_to_newline_test #1", function() {

			var helloWorldOld = "Hello#World";
			var helloWorldNew = string_hash_to_newline(helloWorldOld);
			assert_equals(helloWorldNew, "Hello\r\nWorld", "Hello#World to Hello\\r\\nWorld");
		});
	
		addFact("string_hash_to_newline_test #2", function() {
        		
			var priceString  = "£99#99";
			var priceSplit = string_hash_to_newline(priceString);
			assert_equals(priceSplit, "£99\r\n99", "£99#99 to £99\\r\\n99");
		});
	
		addFact("string_hash_to_newline_test #3", function() {
        		
			var euroString = "€99#99";
			var euroSplit = string_hash_to_newline(euroString);
			assert_equals(euroSplit, "€99\r\n99", "€99#99 to €99\\r\\n99");
		});
	
		addFact("string_hash_to_newline_test #4", function() {
        		
			var emojiString = "👏👏#👏";
			var emojiSplit = string_hash_to_newline(emojiString);
			assert_equals(emojiSplit, "👏👏\r\n👏", "👏👏#👏 to 👏👏\\r\\n👏");
		});
	}
	
	// STRING_INSERT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_insert_test #1", function() {
        		
			var vstring = "Hello World!";
		
			//#1 string_insert( string const , string local , real const )
			var res = string_insert("xx", vstring, 1);
			assert_equals(res, "xxHello World!", "#1 string_insert( string const , string local , real const )");
		});
	
		addFact("string_insert_test #2", function() {
        		
			var vstring = "Hello World!";
		
			//#2 string_insert( string const , string local , real const )
			var res = string_insert("xx", vstring, 2);
			assert_equals(res, "Hxxello World!", "#2 string_insert( string const , string local , real const )");
		});
	
		addFact("string_insert_test #3", function() {
        		
			var vstring = "Hello World!";
		
			//#3 string_insert( string const , string local , real const ) - insert count > ramining string length
			var res = string_insert("xx", vstring, 50);
			assert_equals(res, "Hello World!xx", "#3 string_insert( string const , string local , real const ) - insert count > ramining string length");
		});
	
		addFact("string_insert_test #4", function() {
        		
			var vstring = "Hello World!";
		
			//#4 string_insert( string const , string local , real const ) - insert zero count
			var res = string_insert("xx", vstring, 0);
			assert_equals(res, "xxHello World!", "#4 string_insert( string const , string local , real const ) - insert zero count");
		});
	
		addFact("string_insert_test #5", function() {
        		
			var vstring = "Hello World!";
		
			//#5 string_insert( string const , string local , real const ) - insert negative count
			var res = string_insert("xx", vstring, -1);
			assert_equals(res, "xxHello World!", "#5 string_insert( string const , string local , real const ) - insert negative count");
		});
	
		addFact("string_insert_test #6", function() {
        		
			var vstring = "Hello World!";
		
			//#6 string_insert( string const , string local , real const ) - index > string length
			var res = string_insert("xx", vstring, 1);
			assert_equals(res, "xxHello World!", "#6 string_insert( string const , string local , real const ) - index > string length");
		});
	
		addFact("string_insert_test #7", function() {
        		
			var vstring = "Hello World!";
		
			//#7 string_insert( string const , string local , real const )
			var res = string_insert("xx", vstring, 2.4);
			assert_equals(res, "Hxxello World!", "#7 string_insert( string const , string local , real const )");
		});
	
		addFact("string_insert_test #8", function() {
        		
			var vstring = "Hello World!";
		
			//#8 string_insert( string const , string local , real const )
			var res = string_insert("xx", vstring, 2.6);
			assert_equals(res, "Hxxello World!", "#8 string_insert( string const , string local , real const )");
		});
	
		addFact("string_insert_test #9", function() {
        		
			var vstring = "Hello World!";
		
			//#9 string_insert( string const , string local , string const )
			var res = string_insert("xx", vstring, "2");
			assert_equals(res, "Hxxello World!", "#9 string_insert( string const , string local , string const )");
		});
	
		addFact("string_insert_test #10", function() {
        		
			var vstring = "Hello World!";
		
			//#10 string_insert( string const , string const , real const ) - empty string
			var res = string_insert("xx", "", 1);
			assert_equals(res, "xx", "#10 string_insert( string const , string const , real const ) - empty string");
		});
	
		addFact("string_insert_test #11", function() {
        		
			var vstring = "Hello World!";
		
			//#11 string_insert( string const , string const , real const ) - empty string
			var res = string_insert("xx", "", 10);
			assert_equals(res, "xx", "#11 string_insert( string const , string const , real const ) - empty string");
		});
	
		addFact("string_insert_test #12", function() {
        		
			var vstring = "Hello World!";
		
			//#12 string_insert( string const , string const , real const ) - empty string
			var res = string_insert("xx", "", -10);
			assert_equals(res, "xx", "#12 string_insert( string const , string const , real const ) - empty string");
		});
	
		addFact("string_insert_test #13", function() {
        		
			var vstring = "Hello World!";
		
			//#13 string_insert( string const , int64 local , real const )
			var res = string_insert("xx", int64(1234), 1);
			assert_true(is_string(res), "#13 string_insert( string const , int64 local , real const )");
			assert_equals(res, "xx1234", "#13 string_insert( string const , int64 local , real const )");
		});
	
		addFact("string_insert_test #14", function() {
        		
			var vstring = "Hello World!";
		
			//#14 string_insert( string const , real local , real const )
			var res = string_insert("xx", 1.234, 1);
			assert_true(is_string(res), "#14 string_insert( string const , real local , real const )");
			assert_equals(res, "xx1.23", "#14 string_insert( string const , real local , real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		});
	
		addFact("string_insert_test #15", function() {
        		
			var vstring = "Hello World!";
		
			//#15 string_insert( string const , bool local , real const )
			var res = string_insert("xx", true, 1);
			assert_true(is_string(res), "#15 string_insert( string const , bool local , real const )");
			assert_equals(res, "xx1", "#15 string_insert( string const , bool local , real const )");
		});
	
		addFact("string_insert_test #16", function() {
        		
			#macro kString_StringInsertTest "Hello World!"
		
			//#16 string_insert( string const , string macro , real const )
			var res = string_insert("xx", kString_StringInsertTest, 8);
			assert_equals(res, "Hello Wxxorld!", "#16 string_insert( string const , string macro , real const )");
		});
	
		addFact("string_insert_test #17", function() {
        		
			global.gstring = "Hello World!";
		
			//#17 string_insert( string const , string global , real const )
			var res = string_insert("xx", global.gstring, 8);
			assert_equals(res, "Hello Wxxorld!", "#17 string_insert( string const , string global , real const )");
		});
	
		addFact("string_insert_test #18", function() {
        		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#18 string_insert( string const , string instance , real const )
			var res = string_insert("xx", _oTest.ostring, 8);
			assert_equals(res, "Hello Wxxorld!", "#18 string_insert( string const , string instance , real const )");
		
			instance_destroy(_oTest)
		});
	
		addFact("string_insert_test #19", function() {

			//#20 string_insert( string const , string const , real const ) - 2 byte UTF8
			var res = string_insert("£", "Price: 3.99", 8);
			assert_equals(res, "Price: £3.99", "#20 string_insert( string const , string const , real const ) - 2 byte UTF8");
		});
	
		addFact("string_insert_test #20", function() {

			//#21 string_insert( string const , string const , real const ) - 3 byte UTF8
			var res = string_insert("水", "Mizu () is the kanji symbol for water", 7);
			assert_equals(res, "Mizu (水) is the kanji symbol for water", "#21 string_insert( string const , string const , real const ) - 3 byte UTF8");
		});
	
		addFact("string_insert_test #21", function() {

			//#22 string_insert( string const , string const , real const ) - 4 byte UTF8
			var res = string_insert("🙂", "", 1);
			assert_equals(res, "🙂", "#22 string_insert( string const , string const , real const ) - 4 byte UTF8");
		});
	
		addFact("string_insert_test #22", function() {

			var aString = "aaa";
			var res = string_insert("🙂", aString, 2);
			assert_equals(res, "a🙂aa", "#23");
		});
	
		addFact("string_insert_test #23", function() {

			var smileyString = "🙂🙂🙂";
			var res = string_insert("a", smileyString, 2);
			assert_equals(res, "🙂a🙂🙂", "#24");
		});
	
		addFact("string_insert_test #24", function() {

			var res = string_insert("aa", smileyString, 3);
			assert_equals(res, "🙂🙂aa🙂", "#25");
		});
	
		addFact("string_insert_test #25", function() {

			var res = string_insert("🙂", smileyString, 3);
			assert_equals(res, "🙂🙂🙂🙂", "#26");
		});
	
		addFact("string_insert_test #26", function() {

			var res = string_insert("🙂🙂", smileyString, 3);
			assert_equals(res, "🙂🙂🙂🙂🙂", "#27");
		});
	}
	
	// STRING_LAST_POS_EXT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_last_pos_ext_test #1", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var helloPos = string_last_pos_ext("Hello", helloWorldStr, numChars);
			var worldPos = string_last_pos_ext("world", helloWorldStr, numChars);
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, numChars);
			assert_equals(helloPos, 13, "Hello Pos is 13 char in");
			assert_equals(worldPos, 19, "World Pos is 19 char in");
			assert_equals(exclamationPos, 24, "Exclamation is at 24 chars in");
		});
	
		addFact("string_last_pos_ext_test #2", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var helloPos = string_last_pos_ext("Hello", helloWorldStr, (numChars/2));
			var worldPos = string_last_pos_ext("world", helloWorldStr, (numChars/2));
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2));
			assert_equals(helloPos, 1, "Hello Pos is 1 char in");
			assert_equals(worldPos, 7, "World Pos is 7 char in");
			assert_equals(exclamationPos, 12, "Exclamation is at 12 chars in");
		});
	
		addFact("string_last_pos_ext_test #3", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2)-1);
			assert_equals(exclamationPos, 0, "Exclamation not found");
		});
	
		addFact("string_last_pos_ext_test #4", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var longPos = string_last_pos_ext(helloWorldStr, "!", numChars);
			assert_equals(longPos, 0, "Long string not found in short one");
		});
	
		addFact("string_last_pos_ext_test #5", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var samePos = string_last_pos_ext(helloWorldStr, helloWorldStr, numChars);
			assert_equals(samePos, 1, "String found in itself");
		});
	
		addFact("string_last_pos_ext_test #6", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var zeroPos = string_last_pos_ext("Hello", helloWorldStr, 0);
			assert_equals(zeroPos, 0, "Hello not found with start_pos zero");
		});
	
		addFact("string_last_pos_ext_test #7", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
			
			var negPos = string_last_pos_ext("Hello", helloWorldStr, -1);
			assert_equals(negPos, 0, "Hello not found with negative start_pos");
		});
	
		addFact("string_last_pos_ext_test #8", function() {

			var helloWorldStr = "Hello world!Hello world!";
			var numChars = string_length(helloWorldStr);
		
			// Test zero
			var helloNil = string_last_pos_ext("hello", helloWorldStr, numChars);
			assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
		});
	
		addFact("string_last_pos_ext_test #9", function() {
		
			// UTF8 tests
			var poundPrice = "£99.99";
			var numChars = string_length(poundPrice);
		
			var poundPos = string_last_pos_ext("£", poundPrice, numChars);
			assert_equals(poundPos, 1, "Pound glyph is the first char");
			var periodCharPos = string_last_pos_ext(".", poundPrice, numChars);
			assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
		});
	
		addFact("string_last_pos_ext_test #10", function() {

			var euroPrice = "€59.99";
			var numChars = string_length(euroPrice);
		
			var euroPos = string_last_pos_ext("€", euroPrice, numChars);
			assert_equals(euroPos, 1, "Euro glyph is the first char");
			var euroPeriodCharPos = string_last_pos_ext(".", euroPrice, numChars);
			assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
		});
	
		addFact("string_last_pos_ext_test #11", function() {

			var aikido = "合気道";
			var numChars = string_length(aikido);
		
			var aiPos = string_last_pos_ext("合", aikido, numChars);
			var kiPos = string_last_pos_ext("気", aikido, numChars);
			var doPos = string_last_pos_ext("道", aikido, numChars);
			assert_equals(aiPos, 1, "Ai is the first char");
			assert_equals(kiPos, 2, "Ki is the second char");
			assert_equals(doPos, 3, "Do is the third char");
		});
	
		addFact("string_last_pos_ext_test #12", function() {

			var kotegaeshi = "小手返 Test";
			var numChars = string_length(kotegaeshi);
		
			var kotegaeshiTestPos = string_last_pos_ext("Test", kotegaeshi, numChars);
			assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
		});
	
		addFact("string_last_pos_ext_test #13", function() {

			// Emoji!
			var smileyString = "This is a test 🙂";
			var smileyPos = string_last_pos_ext("🙂", smileyString, string_length(smileyString));
			assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
		});
	
		addFact("string_last_pos_ext_test #14", function() {

			var smileyPosLiteral = string_last_pos_ext("🙂", "This is a test 🙂", 16);
			assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
		});
	
		addFact("string_last_pos_ext_test #15", function() {

			var emojiString = "✔✔✔💩👏";
			var res = string_last_pos_ext("👏", emojiString, string_length(emojiString));
			assert_equals(res, 5, "Clap emoji the 5th char");
		});
	
		addFact("string_last_pos_ext_test #16", function() {

			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_last_pos_ext("👏", moreEmojiString, string_length(moreEmojiString));
			assert_equals(res, 8, "Clap emoji the 8th char");
		});
	
		addFact("string_last_pos_ext_test #17", function() {

			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_last_pos_ext("👏", emojiString3, string_length(emojiString3));
			assert_equals(res, 10, "Clap emoji the 10th char");
		});
	
		addFact("string_last_pos_ext_test #18", function() {

			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_last_pos_ext("aa", emojiString4, string_length(emojiString4));
			assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
		});
	}
	
	// STRING_LAST_POS TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_last_pos_test #1", function() {
		
			// Basic tests
			var helloWorldStr = "Hello world!Hello world!";
			var helloPos = string_last_pos("Hello", helloWorldStr);
			var worldPos = string_last_pos("world", helloWorldStr);
			var exclamationPos = string_last_pos("!", helloWorldStr);
			assert_equals(helloPos, 13, "Hello Pos is 13 char in");
			assert_equals(worldPos, 19, "World Pos is 19 char in");
			assert_equals(exclamationPos, 24, "Exclamation is at 24 chars in");
		});
	
		addFact("string_last_pos_test #2", function() {
		
			var helloWorldStr = "Hello world!Hello world!";
		
			// Test zero
			var helloNil = string_last_pos("hello", helloWorldStr);
			assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
		});
	
		addFact("string_last_pos_test #3", function() {
		
			// UTF8 tests
			var poundPrice = "£99.99";
			var poundPos = string_last_pos("£", poundPrice);
			assert_equals(poundPos, 1, "Pound glyph is the first char");
			var periodCharPos = string_last_pos(".", poundPrice);
			assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
		});
	
		addFact("string_last_pos_test #4", function() {
		
			var euroPrice = "€59.99";
			var euroPos = string_last_pos("€", euroPrice);
			assert_equals(euroPos, 1, "Euro glyph is the first char");
			var euroPeriodCharPos = string_last_pos(".", euroPrice);
			assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
		});
	
		addFact("string_last_pos_test #5", function() {
		
			var aikido = "合気道";
			var aiPos = string_last_pos("合", aikido);
			var kiPos = string_last_pos("気", aikido);
			var doPos = string_last_pos("道", aikido);
			assert_equals(aiPos, 1, "Ai is the first char");
			assert_equals(kiPos, 2, "Ki is the second char");
			assert_equals(doPos, 3, "Do is the third char");
		});
	
		addFact("string_last_pos_test #6", function() {
		
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_last_pos("Test", kotegaeshi);
			assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
		});
	
		addFact("string_last_pos_test #7", function() {
		
			// Emoji!
			var smileyString = "This is a test 🙂";
			var smileyPos = string_last_pos("🙂", smileyString);
			assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
		});
	
		addFact("string_last_pos_test #8", function() {
		
			var smileyPosLiteral = string_last_pos("🙂", "This is a test 🙂");
			assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
		});
	
		addFact("string_last_pos_test #9", function() {
		
			var emojiString = "✔✔✔💩👏";
			var res = string_last_pos("👏", emojiString);
			assert_equals(res, 5, "Clap emoji the 5th char");
		});
	
		addFact("string_last_pos_test #10", function() {
		
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_last_pos("👏", moreEmojiString);
			assert_equals(res, 8, "Clap emoji the 8th char");
		});
	
		addFact("string_last_pos_test #11", function() {
		
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_last_pos("👏", emojiString3);
			assert_equals(res, 10, "Clap emoji the 10th char");
		});
	
		addFact("string_last_pos_test #12", function() {
		
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_last_pos("aa", emojiString4);
			assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
		});
	}
	
	// STRING_LENGTH TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_length_test #1", function() {
		
			// Basic ASCII tests
			var helloWorldLen = string_length("Hello world!")
			assert_equals(helloWorldLen, 12, "Hello world! is 12 chars")
		});
	
		addFact("string_length_test #2", function() {
		
			var helloWorldStr = "Hello world!"
			var hw2Len = string_length(helloWorldStr)
			assert_equals(hw2Len, 12, "Hello world! as a var is 12 chars")
		});
	
		addFact("string_length_test #3", function() {
		
			var longSentence = "The quick brown fox jumped over the lazy dog!"
			var sentenceLen = string_length(longSentence)
			assert_equals(sentenceLen, 45, "This sentence is 45 chars long")
		});
	
		addFact("string_length_test #4", function() {
		
			// UTF8 tests
			var poundPrice = "£99.99"
			var poundPriceLen = string_length(poundPrice)
			assert_equals(poundPriceLen, 6, "Pound price string is 6 chars long")
		});
	
		addFact("string_length_test #5", function() {
		
			var euroPrice = "€59.99"
			var euroPriceLen = string_length(euroPrice)
			assert_equals(euroPriceLen, 6, "Euro price string is 6 chars long")
		});
	
		addFact("string_length_test #6", function() {
		
			var someSymbols = "‰ˆ‡†•"
			var someSymbolsLen = string_length(someSymbols)
			assert_equals(someSymbolsLen, 5, "Lenght of someSymbols string is 5")
		});
	
		addFact("string_length_test #7", function() {
		
			var aikido = "合気道"
			var aikidoLen = string_length(aikido)
			assert_equals(aikidoLen, 3, "Aikido is 3 chars")
		});
	
		addFact("string_length_test #8", function() {
		
			var kotegaeshi = "小手返"
			var kotegaeshiLen = string_length(kotegaeshi)
			assert_equals(kotegaeshiLen, 3, "kotegaeshi is 3 chars")
		});
	
		addFact("string_length_test #9", function() {
		
			// Emoji!
			var smileyFace = "🙂"
			var smileyFaceLen = string_length(smileyFace)
			assert_equals(smileyFaceLen, 1, "1 Smiley face is 1 char")
		});
	
		addFact("string_length_test #10", function() {
			
			assert_equals(string_length("🙂"), 1, "Smiley face literal")
		});
	
		addFact("string_length_test #11", function() {
			
			var emojiString = "💩👏✔"
			var emojiLen = string_length(emojiString)
			assert_equals(emojiLen, 3, "Emoji len is 3 chars long")
		});
	
		addFact("string_length_test #12", function() {
			
			var emojiString = "💩👏✔"
			var emojiLen = string_length(emojiString)
			assert_equals(emojiLen, 3, "Emoji len is 3 chars long")
		});
	}
	
	// STRING_LETTERSDIGITS_TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_lettersdigits_test #1", function() {
			
			var vstring1 = "321!HeLlO WoRlD!123"
		
			//#1 string_lettersdigits( string local )
			var res = string_lettersdigits(vstring1);
			assert_equals(res, "321HeLlOWoRlD123", "#1 string_lettersdigits( string local )");
		});
	
		addFact("string_lettersdigits_test #2", function() {
			
			var vstring2 = "!£水🙂"
		
			//#2 string_lettersdigits( string local ) - no letters
			var res = string_lettersdigits(vstring2);
			assert_equals(res, "", "#2 string_lettersdigits( string local ) - no letters");
		});
	
		addFact("string_lettersdigits_test #3", function() {
			
			var vstring3 = ""
		
			//#3 string_lettersdigits( string local ) - empty string
			var res = string_lettersdigits(vstring3);
			assert_equals(res, "", "#3 string_lettersdigits( string local ) - empty string");
		});
	
		addFact("string_lettersdigits_test #4", function() {
			
			var vstring4 = "abcd"
		
			//#4 string_lettersdigits( string local ) - all letters
			var res = string_lettersdigits(vstring4);
			assert_equals(res, "abcd", "#4 string_lettersdigits( string local ) - all letters");
		});
	
		addFact("string_lettersdigits_test #5", function() {
			
			var vstring5 = "1234"
		
			//#5 string_lettersdigits( string local ) - all digits
			var res = string_lettersdigits(vstring5);
			assert_equals(res, "1234", "#5 string_lettersdigits( string local ) - all digits");
		});
	
		addFact("string_lettersdigits_test #6", function() {
			
			//#6 string_lettersdigits( real const )
			var res = string_lettersdigits(1234);
			assert_equals(res, "1234", "#6 string_lettersdigits( real const )");
		});
	
		addFact("string_lettersdigits_test #7", function() {
			
			//#7 string_lettersdigits( real const )
			var res = string_lettersdigits(1.234);
			assert_equals(res, "123", "#7 string_lettersdigits( real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		});
	
		addFact("string_lettersdigits_test #8", function() {
			
			#macro kString_StringLettersdigitsTest "321!Hello World!123"
		
			//#8 string_lettersdigits( string macro )
			var res = string_lettersdigits(kString_StringLettersdigitsTest);
			assert_equals(res, "321HelloWorld123", "#8 string_lettersdigits( string macro )")
		});
	
		addFact("string_lettersdigits_test #9", function() {
			
			global.gstring = "321!Hello World!123";
		
			//#9 string_lettersdigits( string global )
			var res = string_lettersdigits(global.gstring);
			assert_equals(res, "321HelloWorld123", "#9 string_lettersdigits( string global )")
		});
	
		addFact("string_lettersdigits_test #10", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			//#10 string_lettersdigits( string instance )
			var res = string_lettersdigits(_oTest.ostring);
			assert_equals(res, "321HelloWorld123", "#10 string_lettersdigits( string instance )")
		
			instance_destroy(_oTest);
		});
	}
	
	// STRING_LETTERS TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_lettersdigits_test #1", function() {
			
			var vstring1 = "321!HeLlO WoRlD!123"
		
			//#1 string_letters( string local )
			var res = string_letters(vstring1);
			assert_equals(res, "HeLlOWoRlD", "#1 string_letters( string local )");
		});
	
		addFact("string_lettersdigits_test #2", function() {
			
			var vstring2 = "!£水🙂"
		
			//#2 string_letters( string local ) - no letters
			var res = string_letters(vstring2);
			assert_equals(res, "", "#2 string_letters( string local ) - no letters");
		});
	
		addFact("string_lettersdigits_test #3", function() {
			
			var vstring3 = ""
		
			//#3 string_letters( string local ) - empty string
			var res = string_letters(vstring3);
			assert_equals(res, "", "#3 string_letters( string local ) - empty string");
		});
	
		addFact("string_lettersdigits_test #4", function() {
			
			var vstring4 = "abcd"
		
			//#4 string_letters( string local ) - all letters
			var res = string_letters(vstring4);
			assert_equals(res, "abcd", "#4 string_letters( string local ) - all letters");
		});
	
		addFact("string_lettersdigits_test #5", function() {
			
			//#5 string_letters( real const )
			var res = string_letters(1234);
			assert_equals(res, "", "#5 string_letters( real const )");
		});
	
		addFact("string_lettersdigits_test #6", function() {
			
			//#6 string_letters( real const )
			var res = string_letters(1.234);
			assert_equals(res, "", "#6 string_letters( real const )");
		});
	
		addFact("string_lettersdigits_test #7", function() {
			
			#macro kString_StringLettersTest "321!Hello World!123"
		
			//#7 string_letters( string macro )
			var res = string_letters(kString_StringLettersTest);
			assert_equals(res, "HelloWorld", "#7 string_letters( string macro )")
		});
	
		addFact("string_lettersdigits_test #8", function() {
			
			global.gstring = "321!Hello World!123";
		
			//#8 string_letters( string global )
			var res = string_letters(global.gstring);
			assert_equals(res, "HelloWorld", "#8 string_letters( string global )")
		});
	
		addFact("string_lettersdigits_test #9", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "321!Hello World!123";
		
			//#9 string_letters( string instance )
			var res = string_letters(_oTest.ostring);
			assert_equals(res, "HelloWorld", "#9 string_letters( string instance )")
		
			instance_destroy(_oTest)
		});
	}

	// STRING_LOWER TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_lower_test #1", function() {
			
			var vstring = "HeLlO WoRlD!"
		
			//#1 string_lower( string local )
			var res = string_lower(vstring);
			assert_equals(res, "hello world!", "#1 string_lower( string local )");
		});
	
		addFact("string_lower_test #2", function() {
			
			var vstring2 = "!£水🙂"
		
			//#2 string_lower( string local )
			var res = string_lower(vstring2);
			assert_equals(res, "!£水🙂", "#2 string_lower( string local )");
		});
	
		addFact("string_lower_test #3", function() {
			
			//#3 string_lower( string const ) - empty string
			var res = string_lower("");
			assert_equals(res, "", "#3 string_lower( string const ) - empty string");
		});
	
		addFact("string_lower_test #4", function() {
			
			//#4 string_lower( string const ) - single uppercase character
			var res = string_lower("H");
			assert_equals(res, "h", "#4 string_lower( string const ) - single uppercase character");
		});
	
		addFact("string_lower_test #5", function() {
			
			//#5 string_lower( string const ) - single lowercase character
			var res = string_lower("h");
			assert_equals(res, "h", "#5 string_lower( string const ) - single lowercase character");
		});
	
		addFact("string_lower_test #6", function() {
			
			//#6 string_lower( real local )
			var res = string_lower(1234);
			assert_equals(res, "1234", "#6 string_lower( real local )");
		});
	
		addFact("string_lower_test #7", function() {
			
			//#7 string_lower( real local )
			var res = string_lower(1.234);
			assert_equals(res, "1.23", "#7 string_lower( real local )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		});
	
		addFact("string_lower_test #8", function() {
			
			//#8 string_lower( real local )
			var res = string_lower(int64(1234));
			assert_equals(res, "1234", "#8 string_lower( int64 local )");
		});
	
		addFact("string_lower_test #9", function() {
			
			var u8001 = "老aA老aAa";
			var u8001Chr = string_lower(u8001);
			assert_equals(u8001Chr, "老aa老aaa", "#9 老aA老aAa to lower is 老aa老aaa");
		});
	}
	
	// STRING_ORD_AT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_ord_at_test #1", function() {
			
			var vstring = "hello World!"
		
			//#1 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, 7);
			assert_equals(res, 87, "#1 string_ord_at( real local , real const )") // 'W'
		});
	
		addFact("string_ord_at_test #2", function() {
			
			var vstring = "hello World!"
		
			//#2 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, 7.6);
			assert_equals(res, 87, "#2 string_ord_at( real local , real const )") // 'W'
		});
	
		addFact("string_ord_at_test #3", function() {
			
			var vstring = "hello World!"
		
			//#3 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, 7.2);
			assert_equals(res, 87, "#3 string_ord_at( real local , real const )") // 'W'
		});
	
		addFact("string_ord_at_test #4", function() {
			
			var vstring = "hello World!"
		
			//#4 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, 0);
			assert_equals(res, 104, "#4 string_ord_at( real local , real const )") // 'h'
		});
	
		addFact("string_ord_at_test #5", function() {
			
			var vstring = "hello World!"
		
			//#5 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, 100);
			assert_equals(res, -1, "#5 string_ord_at( real local , real const )")
		});
	
		addFact("string_ord_at_test #6", function() {
			
			var vstring = "hello World!"
		
			//#6 string_ord_at( real local , real const )
			var res = string_ord_at(vstring, -2);
			assert_equals(res, 104, "#6 string_ord_at( real local , real const )") // 'h'
		});
	
		addFact("string_ord_at_test #7", function() {
			
			var vstring = "hello World!"
		
			//#7 string_ord_at( int64 const , real const )
			var res = string_ord_at(int64(1234), 2);
			assert_equals(res, 50, "#7 string_ord_at( int64 const , real const )") // '2'
		});
	
		addFact("string_ord_at_test #8", function() {
			
			var vstring = "hello World!"
		
			//#8 string_ord_at( real const , real const )
			var res = string_ord_at(1.234, 2);
			assert_equals(res, 46, "#8 string_ord_at( real const , real const )") // '.'
		});
	
		addFact("string_ord_at_test #9", function() {
			
			var vstring = "hello World!"
		
			//#9 string_ord_at( bool const , real const )
			var res = string_ord_at(true, 1);
			assert_equals(res, 49, "#9 string_ord_at( bool const , real const )") // '1'
		});
	
		addFact("string_ord_at_test #10", function() {
			
			#macro kString_StringOrdAtTest "Hello World!"
		
			//#10 string_ord_at( string macro , real const )
			var res = string_ord_at(kString_StringOrdAtTest, 7);
			assert_equals(res, 87, "#10 string_ord_at( string macro , real const )")
		});
	
		addFact("string_ord_at_test #11", function() {
			
			global.gstring = "Hello World!";
		
			//#11 string_ord_at( string global , real const )
			var res = string_ord_at(global.gstring, 7);
			assert_equals(res, 87, "#11 string_ord_at( string global , real const )")
		});
	
		addFact("string_ord_at_test #12", function() {
			
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#12 string_ord_at( string instance , real const )
			var res = string_ord_at(_oTest.ostring, 7);
			assert_equals(res, 87, "#12 string_ord_at( string instance , real const )")
		
			instance_destroy(_oTest);
		});
	
		addFact("string_ord_at_test #13", function() {
			
			// UTF-8 tests 2/3/4 bytes
			//#13 string_ord_at( string const , real const )
			var res = string_ord_at("!£水🙂a", 1);
			assert_equals(res, 33, "#13 string_ord_at( string const , real const )")
		});
	
		addFact("string_ord_at_test #14", function() {
			
			//#14 string_ord_at( string const , real const )
			var res = string_ord_at("!£水🙂a", 2);
			assert_equals(res, 163, "#14 string_ord_at( string const , real const )")
		});
	
		addFact("string_ord_at_test #15", function() {
			
			//#15 string_ord_at( string const , real const )
			var res = string_ord_at("!£水🙂a", 3);
			assert_equals(res, 27700, "#15 string_ord_at( string const , real const )")
		});
	
		addFact("string_ord_at_test #16", function() {
			
			//#16 string_ord_at( string const , real const )
			var res = string_ord_at("!£水🙂a", 4);
			assert_equals(res, 128578, "#16 string_ord_at( string const , real const )")
		});
	
		addFact("string_ord_at_test #17", function() {
			
			//#17 string_ord_at( string const , real const )
			var res = string_ord_at("!£水🙂a", 5);
			assert_equals(res, 97, "#17 string_ord_at( string const , real const )")
		});
	}
	
	// STRING_POS_EXT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_pos_ext_test #1", function() {
			
			// Basic tests
			var helloWorldStr = "Hello world!Hello world!";
		
			var helloPos = string_pos_ext("Hello", helloWorldStr, 0);
			var worldPos = string_pos_ext("world", helloWorldStr, 0);
			var exclamationPos = string_pos_ext("!", helloWorldStr, 0);
			assert_equals(helloPos, 1, "#1.0 Hello Pos is 1 char in");
			assert_equals(worldPos, 7, "#1.1 World Pos is 7 char in");
			assert_equals(exclamationPos, 12, "#1.2 Exclamation is at 12 chars in");
		});
	
		addFact("string_pos_ext_test #2", function() {
			
			// Basic tests
			var helloWorldStr = "Hello world!Hello world!";
		
			var helloPos = string_pos_ext("Hello", helloWorldStr, 13);
			var worldPos = string_pos_ext("world", helloWorldStr, 13);
			var exclamationPos = string_pos_ext("!", helloWorldStr, 13);
			assert_equals(helloPos, 13, "#1.3 Hello Pos is 13 char in");
			assert_equals(worldPos, 19, "#1.4 World Pos is 19 char in");
			assert_equals(exclamationPos, 24, "#1.5 Exclamation is at 24 chars in");
		});
	
		addFact("string_pos_ext_test #3", function() {
		
			var helloWorldStr = "Hello world!Hello world!";
		
			// Test zero
			var helloNil = string_pos_ext( "hello", helloWorldStr, 0);
			assert_equals(helloNil, 0, "#1.6 hello is not featured in the Hello world! string");
		});
	
		addFact("string_pos_ext_test #4", function() {
		
			// UTF8 tests
			var poundPrice = "£99.99";
			var poundPos = string_pos_ext("£", poundPrice,0);
			assert_equals(poundPos, 1, "#2.0 Pound glyph is the first char");
			var periodCharPos = string_pos_ext(".", poundPrice,0);
			assert_equals(periodCharPos, 4, "#2.1 Period char is the fourth character in poundPrice");
		});
	
		addFact("string_pos_ext_test #5", function() {
		
			var euroPrice = "€59.99";
			var euroPos = string_pos_ext("€", euroPrice,0);
			assert_equals(euroPos, 1, "#2.2 Euro glyph is the first char");
			var euroPeriodCharPos = string_pos_ext(".", euroPrice,0);
			assert_equals(euroPeriodCharPos, 4, "#2.4 Period char is the fourth character in euroPrice");
		});
	
		addFact("string_pos_ext_test #6", function() {
		
			var aikido = "合気道";
			var aiPos = string_pos_ext("合", aikido, 0);
			var kiPos = string_pos_ext("気", aikido, 0);
			var doPos = string_pos_ext("道", aikido, 0);
			assert_equals(aiPos, 1, "#2.5 Ai is the first char");
			assert_equals(kiPos, 2, "#2.6 Ki is the second char");
			assert_equals(doPos, 3, "#2.7 Do is the third char");
		});
	
		addFact("string_pos_ext_test #7", function() {
		
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_pos_ext("Test", kotegaeshi, 0);
			assert_equals(kotegaeshiTestPos, 5, "#2.8 Test is 5 chars in");
		});
	
		addFact("string_pos_ext_test #8", function() {
		
			// Emoji!
			var smileyString = "This is a test 🙂";
			var smileyPos = string_pos_ext("🙂", smileyString, 0);
			assert_equals(smileyPos, 16, "#3.0 Smiley face is 16 chars in");
		});
	
		addFact("string_pos_ext_test #9", function() {
		
			var smileyPosLiteral = string_pos_ext("🙂", "This is a test 🙂", 0);
			assert_equals(smileyPosLiteral, 16, "#3.1 Smiley face is 16 chars in a literal string");
		});
	
		addFact("string_pos_ext_test #10", function() {
		
			var emojiString = "✔✔✔💩👏";
			var res = string_pos_ext("👏", emojiString, 0);
			assert_equals(res, 5, "#3.2 Clap emoji the 5th char");
		});
	
		addFact("string_pos_ext_test #11", function() {
		
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_pos_ext("👏", moreEmojiString, 0);
			assert_equals(res, 8, "#3.3 Clap emoji the 8th char");
		});
	
		addFact("string_pos_ext_test #12", function() {
		
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_pos_ext("👏", emojiString3, 0);
			assert_equals(res, 10, "#3.4 Clap emoji the 10th char");
		});
	
		addFact("string_pos_ext_test #13", function() {
		
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_pos_ext("aa", emojiString4, 0);
			assert_equals(res, 9, "#3.5 \"aa\" is the 9th and 10th char");
		});
	}
	
	// STRING_POS TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_pos_test #1", function() {
		
			// Basic tests
			var helloWorldStr = "Hello world!";
		
			var helloPos = string_pos("Hello", helloWorldStr);
			var worldPos = string_pos("world", helloWorldStr);
			var exclamationPos = string_pos("!", helloWorldStr);
			assert_equals(helloPos, 1, "Hello Pos is 1 char in");
			assert_equals(worldPos, 7, "World Pos is 7 char in");
			assert_equals(exclamationPos, 12, "Exclamation is at 12 chars in");
		});
	
		addFact("string_pos_test #2", function() {
		
		
			var helloWorldStr = "Hello world!";
		
			// Test zero
			var helloNil = string_pos("hello", helloWorldStr);
			assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
		});
	
		addFact("string_pos_test #3", function() {
		
			// UTF8 tests
			var poundPrice = "£99.99";
			var poundPos = string_pos("£", poundPrice);
			assert_equals(poundPos, 1, "Pound glyph is the first char");
			var periodCharPos = string_pos(".", poundPrice);
			assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
		});
	
		addFact("string_pos_test #4", function() {
		
			var euroPrice = "€59.99";
			var euroPos = string_pos("€", euroPrice);
			assert_equals(euroPos, 1, "Euro glyph is the first char");
			var euroPeriodCharPos = string_pos(".", euroPrice);
			assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
		});
	
		addFact("string_pos_test #5", function() {
		
			var aikido = "合気道";
			var aiPos = string_pos("合", aikido);
			var kiPos = string_pos("気", aikido);
			var doPos = string_pos("道", aikido);
			assert_equals(aiPos, 1, "Ai is the first char");
			assert_equals(kiPos, 2, "Ki is the second char");
			assert_equals(doPos, 3, "Do is the third char");
		});
	
		addFact("string_pos_test #6", function() {
		
			var kotegaeshi = "小手返 Test";
			var kotegaeshiTestPos = string_pos("Test", kotegaeshi);
			assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
		});
	
		addFact("string_pos_test #7", function() {
		
			// Emoji!
			var smileyString = "This is a test 🙂";
			var smileyPos = string_pos("🙂", smileyString);
			assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
		});
	
		addFact("string_pos_test #8", function() {
		
			var smileyPosLiteral = string_pos("🙂", "This is a test 🙂");
			assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
		});
	
		addFact("string_pos_test #9", function() {
		
			var emojiString = "✔✔✔💩👏";
			var res = string_pos("👏", emojiString);
			assert_equals(res, 5, "Clap emoji the 5th char");
		});
	
		addFact("string_pos_test #10", function() {
		
			var moreEmojiString = "✔✔✔💩😀😁😂👏";
			var res = string_pos("👏", moreEmojiString);
			assert_equals(res, 8, "Clap emoji the 8th char");
		});
	
		addFact("string_pos_test #11", function() {
		
			var emojiString3 = "✔✔✔💩😀aa😁😂👏";
			var res = string_pos("👏", emojiString3);
			assert_equals(res, 10, "Clap emoji the 10th char");
		});
	
		addFact("string_pos_test #12", function() {
		
			var emojiString4 = "✔✔✔💩😀😁😂👏aa";
			var res = string_pos("aa", emojiString4);
			assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
		});
	}
	
	// STRING_REPEAT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_repeat_test #1", function() {
		
			var vstring1 = "HeLlO WoRlD!"
		
			//#1 string_repeat( string local , real const )
			var res = string_repeat(vstring1, 2);
			assert_equals(res, "HeLlO WoRlD!HeLlO WoRlD!", "#1 string_repeat( string local , real const )");
		});
	
		addFact("string_repeat_test #2", function() {
		
			var vstring2 = "!£水🙂"
		
			//#2 string_repeat( string local , real const )
			var res = string_repeat(vstring2, 2);
			assert_equals(res, "!£水🙂!£水🙂", "#2 string_repeat( string local , real const )");
		});
	
		addFact("string_repeat_test #3", function() {
		
			var vstring3 = ""
		
			//#3 string_repeat( string local , real const ) - empty string
			var res = string_repeat(vstring3, 2);
			assert_equals(res, "", "#3 string_repeat( string local , real const ) - empty string");
		});
	
		addFact("string_repeat_test #4", function() {
		
			//#4 string_repeat( real const , real const )
			var res = string_repeat(1234, 2);
			assert_equals(res, "12341234", "#4 string_repeat( real local , real const )");
		});
	
		addFact("string_repeat_test #5", function() {
		
			//#5 string_repeat( real const , real const )
			var res = string_repeat(1.234, 2);
			assert_equals(res, "1.231.23", "#5 string_repeat( real local , real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		});
	
		addFact("string_repeat_test #6", function() {
		
			var vstring1 = "HeLlO WoRlD!"
		
			//#6 string_repeat( string local , real const ) - one count
			var res = string_repeat(vstring1, 1);
			assert_equals(res, "HeLlO WoRlD!", "#6 string_repeat( string local , real const )");
		});
	
		addFact("string_repeat_test #7", function() {
		
			var vstring2 = "!£水🙂"
		
			//#7 string_repeat( string local , real const ) - zero count
			var res = string_repeat(vstring1, 0);
			assert_equals(res, "", "#7 string_repeat( string local , real const )");
		});
	
		addFact("string_repeat_test #8", function() {
		
			var vstring3 = ""
		
			//#8 string_repeat( string local , real const ) - negative count
			var res = string_repeat(vstring1, -1);
			assert_equals(res, "", "#8 string_repeat( string local , real const )");
		});
	
		addFact("string_repeat_test #9", function() {
		
			#macro kString_StringRepeatTest "Hello World!"
		
			//#19 string_repeat( string macro , real const )
			var res = string_repeat(kString_StringRepeatTest, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", "#19 string_repeat( string macro , real const )")
		});
	
		addFact("string_repeat_test #10", function() {
		
			global.gstring = "Hello World!";
		
			//#20 string_repeat( string global , real const )
			var res = string_repeat(global.gstring, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", "#20 string_repeat( string global , real const )")
		});
	
		addFact("string_repeat_test #11", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#21 string_repeat( string instance , real const )
			var res = string_repeat(_oTest.ostring, 3);
			assert_equals(res, "Hello World!Hello World!Hello World!", "#21 string_repeat( string instance , real const )")
		
			instance_destroy(_oTest);
		});
	}

	// STRING_REPLACE_ALL TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_replace_all_test #1", function() {
		
			//#1 string_replace_all( string const , string const , string const )
			var res = string_replace_all("Hello Earth!", "Earth", "World");
			assert_equals(res, "Hello World!", "#1 string_replace_all( string const , string const , string const )")
		});
	
		addFact("string_replace_all_test #2", function() {
		
			//#2 string_replace_all( string const , string const , string const )
			var res = string_replace_all("Hello Earth!Earth", "Earth", "World");
			assert_equals(res, "Hello World!World", "#2 string_replace_all( string const , string const , string const )")
		});
	
		addFact("string_replace_all_test #3", function() {
		
			//#3 string_replace_all( string const , string const , string const )
			var res = string_replace_all("Hello EarthEarthEarthEarthEarthEarthEarth", "Earth", "World");
			assert_equals(res, "Hello WorldWorldWorldWorldWorldWorldWorld", "#3 string_replace_all( string const , string const , string const )")
		});
	
		addFact("string_replace_all_test #4", function() {
		
			//#4 string_replace_all( string const , string const , string const ) - empty replacement string
			var res = string_replace_all("Hello Earth!Earth", "Earth", "");
			assert_equals(res, "Hello !", "#4 string_replace_all( string const , string const , string const ) - empty replacement string")
		});
	
		addFact("string_replace_all_test #5", function() {
		
			//#5 string_replace_all( string const , string const , string const ) - empty search pattern
			var res = string_replace_all("Hello Earth!Earth", "", "World");
			assert_equals(res, "Hello Earth!Earth", "#5 string_replace_all( string const , string const , string const ) - empty search pattern")
		});
	
		addFact("string_replace_all_test #6", function() {
		
			//#6 string_replace_all( string const , string const , real const )
			var res = string_replace_all("Hello Earth!Earth", "Earth", 1234);
			assert_equals(res, "Hello 1234!1234", "#6 string_replace_all( string const , string const , real const )")
		});
	
		addFact("string_replace_all_test #7", function() {
		
			//#7 string_replace_all( string const , string const , real const )
			var res = string_replace_all("Hello Earth!Earth", "Earth", 1.234);
			assert_equals(res, "Hello 1.23!1.23", "#7 string_replace_all( string const , string const , real const )")
		});
	
		addFact("string_replace_all_test #8", function() {
		
			//#8 string_replace_all( string const , string const , real const )
			var res = string_replace_all("Hello Earth!Earth", "Earth", int64(1234));
			assert_equals(res, "Hello 1234!1234", "#8 string_replace_all( string const , string const , real const )")
		});
	
		addFact("string_replace_all_test #9", function() {
		
			//#9 string_replace_all( string const , string const , string const ) - empty source strings
			var res = string_replace_all("", "two", "three");
			assert_equals(res, "", "#9 string_replace_all( string const , string const , string const ) - empty source strings")
		});
	
		addFact("string_replace_all_test #10", function() {
		
			//#10 string_replace_all( string const , string const , string const ) - all empty strings
			var res = string_replace_all("", "", "");
			assert_equals(res, "", "#10 string_replace_all( string const , string const , string const ) - all empty strings")
		});
	
		addFact("string_replace_all_test #11", function() {
		
			var vstring = "Hello EarthEarth!";
		
			//#11 string_replace_all( string local , string const , string const )
			var res = string_replace_all(vstring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", "#11 string_replace_all( string local , string const , string const )")
		});
	
		addFact("string_replace_all_test #12", function() {
		
			#macro kString_StringReplaceAllTest "Hello EarthEarth!"
		
			//#12 string_replace_all( string macro , string const , string const )
			var res = string_replace_all(kString_StringReplaceAllTest, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", "#12 string_replace_all( string macro , string const , string const )")
		});
	
		addFact("string_replace_all_test #13", function() {
		
			global.gstring = "Hello EarthEarth!";
		
			//#13 string_replace_all( string global , string const , string const )
			var res = string_replace_all(global.gstring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", "#13 string_replace_all( string global , string const , string const )")
		});
	
		addFact("string_replace_all_test #14", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello EarthEarth!";
		
			//#14 string_replace_all( string instance , string const , string const )
			var res = string_replace_all(_oTest.ostring, "Earth", "World");
			assert_equals(res, "Hello WorldWorld!", "#14 string_replace_all( string instance , string const , string const )")
		
			instance_destroy(_oTest);
		});
	
		addFact("string_replace_all_test #15", function() {
		
			//#15 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 1 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "!", "A");
			assert_equals(res, "A£水🙂", "#15 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 1 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #16", function() {
		
			//#16 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 2 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "!", "£");
			assert_equals(res, "££水🙂", "#16 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 2 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #17", function() {
		
			//#17 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 3 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "!", "水");
			assert_equals(res, "水£水🙂", "#17 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 3 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #18", function() {
		
			//#18 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 4 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "!", "🙂");
			assert_equals(res, "🙂£水🙂", "#18 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 4 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #19", function() {
		
			//#19 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 1 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "£", "A");
			assert_equals(res, "!A水🙂", "#19 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 1 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #20", function() {
		
			//#20 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 2 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "£", "€");
			assert_equals(res, "!€水🙂", "#20 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 2 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #21", function() {
		
			//#21 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 3 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "£", "水");
			assert_equals(res, "!水水🙂", "#21 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 3 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #22", function() {
		
			//#22 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 4 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "£", "🙂");
			assert_equals(res, "!🙂水🙂", "#22 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 4 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #23", function() {
		
			//#23 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 1 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "水", "A");
			assert_equals(res, "!£A🙂", "#23 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 1 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #24", function() {
		
			//#24 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 2 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "水", "£");
			assert_equals(res, "!££🙂", "#24 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 2 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #25", function() {
		
			//#25 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 3 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "水", "月");
			assert_equals(res, "!£月🙂", "#25 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 3 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #26", function() {
		
			//#26 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 4 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "水", "🙂");
			assert_equals(res, "!£🙂🙂", "#26 string_replace_all( string const , string const , string const ) - all empty strings - replace 3 byte UTF-8 char with 4 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #27", function() {
		
			//#27 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 1 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "🙂", "A");
			assert_equals(res, "!£水A", "#27 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 1 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #28", function() {
		
			//#28 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 2 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "🙂", "£");
			assert_equals(res, "!£水£", "#28 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 2 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #29", function() {
		
			//#29 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 3 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "🙂", "水");
			assert_equals(res, "!£水水", "#29 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 3 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #30", function() {
		
			//#30 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 4 byte UTF-8 char
			var res = string_replace_all("!£水🙂", "🙂", "😢");
			assert_equals(res, "!£水😢", "#30 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 4 byte UTF-8 char")
		});
	
		addFact("string_replace_all_test #31", function() {
		
			//#31 string_replace_all( string const , string const , string const ) - empty replace string
			var res = string_replace_all("!£水🙂", "!£水🙂", "");
			assert_equals(res, "", "#31 string_replace_all( string const , string const , string const ) - empty replace string")
		});
	
		addFact("string_replace_all_test #32", function() {
		
			//#32 string_replace_all( string const , string const , string const ) - empty replace string (multiple instances)
			var res = string_replace_all("!£水🙂!!£水🙂!£水🙂", "!£水🙂", "");
			assert_equals(res, "!", "#32 string_replace_all( string const , string const , string const ) - empty replace string (multiple instances)")
		});
	
		addFact("string_replace_all_test #33", function() {
		
			//#33 string_replace_all( string const , string const , string const ) - replace 1 byte + 2 byte string with 3byte + 4 byte string
			var res = string_replace_all("!£水🙂!!£水🙂", "!£", "水🙂");
			assert_equals(res, "水🙂水🙂!水🙂水🙂", "#33 string_replace_all( string const , string const , string const ) - replace 1 byte + 2 byte string with 3byte + 4 byte string")
		});
	}
	
	// STRING_REPLACE TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_replace_test #1", function() {
		
			//#1 string_replace( string const , string const , string const )
			var res = string_replace("Hello Earth!", "Earth", "World");
			assert_equals(res, "Hello World!", "#1 string_replace( string const , string const , string const )")
		});
	
		addFact("string_replace_test #2", function() {
		
			//#2 string_replace( string const , string const , string const )
			var res = string_replace("Hello Earth!Earth", "Earth", "World");
			assert_equals(res, "Hello World!Earth", "#2 string_replace( string const , string const , string const )")
		});
	
		addFact("string_replace_test #3", function() {
		
			//#3 string_replace( string const , string const , string const )
			var res = string_replace("Hello Earth!Earth", "Earth", "World");
			res = string_replace(res, "Earth", "World");
			assert_equals(res, "Hello World!World", "#3 string_replace( string const , string const , string const )")
		});
	
		addFact("string_replace_test #4", function() {
		
			//#4 string_replace( string const , string const , string const ) - empty replacement string
			var res = string_replace("Hello Earth!Earth", "Earth", "");
			assert_equals(res, "Hello !Earth", "#4 string_replace( string const , string const , string const ) - empty replacement string")
		});
	
		addFact("string_replace_test #5", function() {
		
			//#5 string_replace( string const , string const , string const ) - empty search pattern
			var res = string_replace("Hello Earth!Earth", "", "World");
			assert_equals(res, "Hello Earth!Earth", "#5 string_replace( string const , string const , string const ) - empty search pattern")
		});
	
		addFact("string_replace_test #6", function() {
		
			//#6 string_replace( string const , string const , real const )
			var res = string_replace("Hello Earth!Earth", "Earth", 1234);
			assert_equals(res, "Hello 1234!Earth", "#6 string_replace( string const , string const , real const )")
		});
	
		addFact("string_replace_test #7", function() {
		
			//#7 string_replace( string const , string const , real const )
			var res = string_replace("Hello Earth!Earth", "Earth", 1.234);
			assert_equals(res, "Hello 1.23!Earth", "#7 string_replace( string const , string const , real const )")
		});
	
		addFact("string_replace_test #8", function() {
		
			//#8 string_replace( string const , string const , real const )
			var res = string_replace("Hello Earth!Earth", "Earth", int64(1234));
			assert_equals(res, "Hello 1234!Earth", "#8 string_replace( string const , string const , real const )")
		});
	
		addFact("string_replace_test #9", function() {
		
			//#9 string_replace( string const , string const , string const ) - empty source strings
			var res = string_replace("", "two", "three");
			assert_equals(res, "", "#9 string_replace( string const , string const , string const ) - empty source strings")
		});
	
		addFact("string_replace_test #10", function() {
		
			//#10 string_replace( string const , string const , string const ) - all empty strings
			var res = string_replace("", "", "");
			assert_equals(res, "", "#10 string_replace( string const , string const , string const ) - all empty strings")
		});
	
		addFact("string_replace_test #11", function() {
		
			//#11 string_replace( string const , string const , string const ) - empty source strings
			var res = string_replace("", "two", "three");
			assert_equals(res, "", "#11 string_replace( string const , string const , string const ) - empty source strings")
		});
	
		addFact("string_replace_test #12", function() {
		
			var vstring = "Hello Earth!";
		
			//#12 string_replace( string local , string const , string const )
			var res = string_replace(vstring, "Earth", "World");
			assert_equals(res, "Hello World!", "#12 string_replace( string local , string const , string const )")
		});
	
		addFact("string_replace_test #13", function() {
		
			#macro kString_StringReplaceTest "Hello Earth!"
		
			//#13 string_replace( string macro , string const , string const )
			var res = string_replace(kString_StringReplaceTest, "Earth", "World");
			assert_equals(res, "Hello World!", "#13 string_replace( string macro , string const , string const )")
		});
	
		addFact("string_replace_test #14", function() {
		
			global.gstring = "Hello Earth!";
		
			//#14 string_replace( string global , string const , string const )
			var res = string_replace(global.gstring, "Earth", "World");
			assert_equals(res, "Hello World!", "#14 string_replace( string global , string const , string const )")
		});
	
		addFact("string_replace_test #15", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello Earth!";
		
			//#15 string_replace( string instance , string const , string const )
			var res = string_replace(_oTest.ostring, "Earth", "World");
			assert_equals(res, "Hello World!", "#15 string_replace( string instance , string const , string const )")
		
			instance_destroy(_oTest);
		});
	
		addFact("string_replace_test #16", function() {
		
			var string1 = "🙂";
			var string2 = "😬";
			var res = string_replace(string1, "🙂", string2);
			assert_equals(res, "😬", "Replace smiley face with a grimace");
		});
	
		addFact("string_replace_test #17", function() {
		
			var longSmileyString = "The quick brown 🙂 jumped over the lazy dog!";
			var res = string_replace(longSmileyString, "🙂", "fox");
			assert_equals(res, "The quick brown fox jumped over the lazy dog!", "Replacing a smiley with a string of chars");
		});
	
		addFact("string_replace_test #17", function() {
		
			var longFoxString = "The quick brown fox jumped over the lazy dog!";
			var res = string_replace(longFoxString, "fox", "🙂");
			assert_equals(res, "The quick brown 🙂 jumped over the lazy dog!", "Replacing a string of chars with a smiley face");
		});
	}
	
	// STRING_SET_BYTE TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_set_byte_at_test #1", function() {

			//string_set_byte_at failure test
			assert_throw(function() {
				return string_set_byte_at("hello", 100, 87); // 'W'
			}, "#1 Using 'string_set_byte_at' with out of range index (should throw error)");
	
		})

		addFact("string_set_byte_at_test #2", function() {

			//string_set_byte_at failure test
			assert_throw(function() {
				return string_set_byte_at("hello", -2, 87); // 'W'
			}, "#1 Using 'string_set_byte_at' with negative index (should throw error)");
		})

		addFact("string_set_byte_at_test #3", function() {

			//string_set_byte_at failure test
			assert_throw(function() {
				return string_set_byte_at("hello", 0, 87); // 'W'
			}, "#1 Using 'string_set_byte_at' with index 0 (should throw error)");
		})
	
		addFact("string_set_byte_at_test #4", function() {

			var vstring = "hello Porld!"
		
			//#1 string_set_byte_at( string local , real const , real const )
			var res = string_set_byte_at(vstring, 7, 87); // 'W'
			assert_equals(res, "hello World!", "#1 string_set_byte_at( string local , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #5", function() {

			var vstring = "hello Porld!"
		
			//#2 string_set_byte_at( string local , real const , real const )
			var res = string_set_byte_at(vstring, 7.6, 87); // 'W'
			assert_equals(res, "hello World!", "#2 string_set_byte_at( rstrstringingeal local , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #6", function() {

			var vstring = "hello Porld!"
		
			//#3 string_set_byte_at( string local , real const , real const )
			var res = string_set_byte_at(vstring, 7.2, 87); // 'W'
			assert_equals(res, "hello World!", "#3 string_set_byte_at( string local , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #7", function() {
		
			//#4 string_set_byte_at( int64 local , real const , real const )
			var res = string_set_byte_at(int64(1234), 2, 32); // ' '
			assert_true(is_string(res), "#4 string_set_byte_at( int64 local , real const , real const )")
			assert_equals(res, "1 34", "#4 string_set_byte_at( int64 local , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #8", function() {
		
			//#5 string_set_byte_at( real local , real const , real const )
			var res = string_set_byte_at(1.234, 2, 32); // ' '
			assert_true(is_string(res), "#5 string_set_byte_at( real local , real const , real const )")
			assert_equals(res, "1 23", "#5 string_set_byte_at( real local , real const , real const )") // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		})
	
		addFact("string_set_byte_at_test #9", function() {
		
			//#6 string_set_byte_at( bool local , real const , real const )
			var res = string_set_byte_at(true, 1, 32); // ' '
			assert_true(is_string(res), "#6 string_set_byte_at( bool local , real const , real const )")
			assert_equals(res, " ", "#6 string_set_byte_at( bool local , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #10", function() {
		
			//#7 string_set_byte_at( string const , real const , real const ) - int larger than char
			var res = string_set_byte_at("Eyup World", 7, 2080); // 100000100000 -> cast to char -> 00100000 -> 32 -> ' '
			assert_true(is_string(res), "#7 string_set_byte_at( string const , real const , real const )")
			assert_equals(res,"Eyup W rld", "#7 string_set_byte_at( string const , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #11", function() {
		
			//#8 string_set_byte_at( string const , real const , string const )
			var res = string_set_byte_at("Eyup World", 7, "32"); // ' '
			assert_true(is_string(res), "#8 string_set_byte_at( string const , real const , string const )")
			assert_equals(res,"Eyup W rld", "#8 string_set_byte_at( string const , real const , string const )")
		})
	
		addFact("string_set_byte_at_test #12", function() {
		
			//#9 string_set_byte_at( string local , real const , real const )
			var twoByteUTF8 = "£";
			var res = string_set_byte_at(twoByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#9 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#9 string_set_byte_at( string local , real const , real const )")
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #13", function() {
		
			//#10 string_set_byte_at( string local , real const , real const )
			var threeByteUTF8 = "小";
			var res = string_set_byte_at(threeByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#10 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#10 string_set_byte_at( string local , real const , real const )")
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #14", function() {
		
			//#11 string_set_byte_at( string local , real const , real const )
			var fourByteUTF8 = "🙂";
			var res = string_set_byte_at(fourByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#11 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#11 string_set_byte_at( string local , real const , real const )")
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #15", function() {
		
			//#12 string_set_byte_at( string const , real const , real const ) - set bytes to create utf-8 4-byte char
			var res = "xxxx";
			res = string_set_byte_at(res, 1, 240);
			res = string_set_byte_at(res, 2, 159);
			res = string_set_byte_at(res, 3, 152);
			res = string_set_byte_at(res, 4, 131);
			assert_true(is_string(res), "#12 string_set_byte_at( string const , real const , real const )")
			assert_equals(res, "😃", "#12 string_set_byte_at( string const , real const , real const )")
		},
		{
			test_filter: platform_not_browser,
		});
	
		addFact("string_set_byte_at_test #16", function() {

			#macro kString_StringSetByteAtTest "Hello World!"
		
			//#13 string_set_byte_at( string macro , real const )
			var res = string_set_byte_at(kString_StringSetByteAtTest, 2, 87);
			assert_true(is_string(res), "#13 string_set_byte_at( string macro , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#13 string_set_byte_at( string macro , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #17", function() {

			global.gstring = "Hello World!";
		
			//#14 string_set_byte_at( string global , real const )
			var res = string_set_byte_at(global.gstring, 2, 87);
			assert_true(is_string(res), "#14 string_set_byte_at( string global , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#14 string_set_byte_at( string global , real const , real const )")
		})
	
		addFact("string_set_byte_at_test #18", function() {
		
			var _oTest = instance_create_depth(0, 0, 0, oTest);
			_oTest.ostring = "Hello World!";
		
			//#15 string_set_byte_at( string instance , real const )
			var res = string_set_byte_at(_oTest.ostring, 2, 87);
			assert_true(is_string(res), "#15 string_set_byte_at( string instance , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#15 string_set_byte_at( string instance , real const , real const )")
		
			instance_destroy(_oTest);
		})
	}
	
	// STRING_UPPER TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_upper_test #1", function() {
		
			var vstring = "HeLlO WoRlD!"
		
			//#1 string_upper( string local )
			var res = string_upper(vstring);
			assert_equals(res, "HELLO WORLD!", "#1 string_upper( string local )");
		})
	
		addFact("string_upper_test #2", function() {
		
			var vstring2 = "!£水🙂"
		
			//#2 string_upper( string local )
			var res = string_upper(vstring2);
			assert_equals(res, "!£水🙂", "#2 string_upper( string local )");
		})
	
		addFact("string_upper_test #3", function() {
		
			//#3 string_upper( string const ) - empty string
			var res = string_upper("");
			assert_equals(res, "", "#3 string_upper( string const ) - empty string");
		})
	
		addFact("string_upper_test #4", function() {
		
			//#4 string_upper( string const ) - single lowercase character
			var res = string_upper("h");
			assert_equals(res, "H", "#4 string_upper( string const ) - single lowercase character");
		})
	
		addFact("string_upper_test #5", function() {
		
			//#5 string_upper( string const ) - single uppercase character
			var res = string_upper("H");
			assert_equals(res, "H", "#5 string_upper( string const ) - single uppercase character");
		})
	
		addFact("string_upper_test #6", function() {
		
			//#6 string_upper( real local )
			var res = string_upper(1234);
			assert_equals(res, "1234", "#6 string_upper( real local )");
		})
	
		addFact("string_upper_test #7", function() {
		
			//#7 string_upper( real local )
			var res = string_upper(1.234);
			assert_equals(res, "1.23", "#7 string_upper( real local )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
		})
	
		addFact("string_upper_test #8", function() {
		
			//#8 string_upper( real local )
			var res = string_upper(int64(1234));
			assert_equals(res, "1234", "#8 string_upper( int64 local )");
		})
	
		addFact("string_upper_test #9", function() {
		
			var u8001 = "老Aa老AaA";
			var u8001Chr = string_upper(u8001);
			assert_equals(u8001Chr, "老AA老AAA", "#9 老Aa老AaA upper is 老AA老AAA");
		})
	}
	
	// STRING TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_test #1", function() {
		
			var _format = "{0} {1} {2}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ]", "#1 string : failed to correctly _format a string with mixed types");
		})
	
		addFact("string_test #2", function() {
		
			var _format = "{0} {1}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello", "#2 string : failed to correctly _format a string with less placeholders than arguments");
		})
	
		addFact("string_test #3", function() {
		
			var _format = "{0} {1} {2} {3}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ] {3}", "#3 string : failed to correctly _format a string with more placeholders than arguments");
		})
	
		addFact("string_test #4", function() {
		
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string(_format, 12, "hello", []);
			assert_equals(_result, "12 hello [  ] 12 hello [  ]", "#4 string : failed to correctly _format a string with repeated placeholders");
		})
	
		addFact("string_test #5", function() {
		
			var _format = "{0}{1}";
			var _result = string(_format, "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合気道合気道合気道", "#5 string : failed to correctly _format a string with non-latin characters");
		})
	
		addFact("string_test #6", function() {
		
			var _format = "{0} {1} {2} {3}";
			var _result = string(_format, "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", "#6 string : failed to correctly _format a string with emoji characters");		
		})
	}
	
	// STRING_EXT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_ext_test #1", function() {
		
			var _format = "{0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ]", "#1 string_ext : failed to correctly _format a string with mixed types");
		})
	
		addFact("string_ext_test #2", function() {
		
			var _format = "{0} {1}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello", "#2 string_ext : failed to correctly _format a string with less placeholders than arguments");
		})
	
		addFact("string_ext_test #3", function() {
		
			var _format = "{0} {1} {2} {3}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ] {3}", "#3 string_ext : failed to correctly _format a string with more placeholders than arguments");
		})
	
		addFact("string_ext_test #4", function() {
		
			var _format = "{0} {1} {2} {0} {1} {2}";
			var _result = string_ext(_format, [12, "hello", []]);
			assert_equals(_result, "12 hello [  ] 12 hello [  ]", "#4 string_ext : failed to correctly _format a string with repeated placeholders");
		})
	
		addFact("string_ext_test #5", function() {
		
			var _format = "{0}{1}";
			var _result = string_ext(_format, ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合気道合気道合気道", "#5 string_ext : failed to correctly _format a string with non-latin characters");
		})
	
		addFact("string_ext_test #6", function() {
		
			var _format = "{0} {1} {2} {3}";
			var _result = string_ext(_format, ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", "#6 string_ext : failed to correctly _format a string with emoji characters");		
		})
	}
	
	// STRING_CONCAT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_concat_test #1", function() {
		
			var _result = string_concat(12, "hello", []);
			assert_equals(_result, "12hello[  ]", "#1 string_concat : failed to correctly concat a string with mixed types");
		})
	
		addFact("string_concat_test #2", function() {
		
			var _result = string_concat("合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合気道合気道合気道", "#2 string_concat : failed to correctly concat a string with non-latin characters");
		})
	
		addFact("string_concat_test #3", function() {
		
			var _result = string_concat("🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎", "#3 string_concat : failed to correctly concat a string with emoji characters");		
		})
	
		addFact("string_concat_test #4", function() {
		
			var _string = "foo";
		
			var _result = string_concat(_string, " bar");
			assert_equals(_result, "foo bar", "#4 string_concat : failed to correctly concat a string when arguments are variable and string");
		})
	
		addFact("string_concat_test #5", function() {
		
			var _string = "foo";
		
			var _result = string_concat("bar ", _string);
			assert_equals(_result, "bar foo", "#5 string_concat : failed to correctly concat a string when arguments are string and variable");
		})
	}
	
	// STRING_CONCAT_EXT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_concat_ext_test #1", function() {
		
			var _result = string_concat_ext([12, "hello", []]);
			assert_equals(_result, "12hello[  ]", "#1 string_concat_ext : failed to correctly concat a string with mixed types");
		})
	
		addFact("string_concat_ext_test #2", function() {
		
			var _result = string_concat_ext(["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合気道合気道合気道", "#2 string_concat_ext : failed to correctly concat a string with non-latin characters");
		})
	
		addFact("string_concat_ext_test #3", function() {
		
			var _result = string_concat_ext(["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎", "#3 string_concat_ext : failed to correctly concat a string with emoji characters");		
		})
	
		addFact("string_concat_ext_test #4", function() {
		
			var _string = "foo";
		
			var _result = string_concat_ext([_string, " bar"]);
			assert_equals(_result, "foo bar", "#4 string_concat_ext : failed to correctly concat a string when arguments are variable and string");
		})
	
		addFact("string_concat_ext_test #5", function() {
		
			var _string = "foo";
		
			var _result = string_concat_ext(["bar ", _string]);
			assert_equals(_result, "bar foo", "#5 string_concat_ext : failed to correctly concat a string when arguments are string and variable");
		})
	}

	// STRING_JOIN TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_join_test #1", function() {
		
			var _result = string_join(",", 12, "hello", []);
			assert_equals(_result, "12,hello,[  ]", "#1 string_join : failed to correctly join a string with mixed types, using a comma.");
		})
	
		addFact("string_join_test #2", function() {
		
			var _result = string_join(",", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合,気道合気道合気道", "#2 string_join : failed to correctly join a string with non-latin characters, using a comma");
		})
	
		addFact("string_join_test #3", function() {
		
			var _result = string_join(",", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", "#3 string_join : failed to correctly join a string with emoji characters, using a comma");
		})
	
		addFact("string_join_test #4", function() {
		
			var _result = string_join("道", 12, "hello", []);
			assert_equals(_result, "12道hello道[  ]", "#4 string_join : failed to correctly join a string with mixed types, using a non-latin character.");
		})
	
		addFact("string_join_test #5", function() {
		
			var _result = string_join("道", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合道気道合気道合気道", "#5 string_join : failed to correctly join a string with non-latin characters, using a non-latin character.");
		})
	
		addFact("string_join_test #6", function() {
		
			var _result = string_join("道", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", "#6 string_join : failed to correctly join a string with emoji characters, using a non-latin character.");
		})
	
		addFact("string_join_test #7", function() {
		
			var _result = string_join("🙂", 12, "hello", []);
			assert_equals(_result, "12🙂hello🙂[  ]", "#7 string_join : failed to correctly join a string with mixed types, using an emoji character.");
		})
	
		addFact("string_join_test #8", function() {
		
			var _result = string_join("🙂", "合気道合", "気道合気道合気道");
			assert_equals(_result, "合気道合🙂気道合気道合気道", "#8 string_join : failed to correctly join a string with non-latin characters, using an emoji character.");
		})
	
		addFact("string_join_test #9", function() {
		
			var _result = string_join("🙂", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", "#9 string_join : failed to correctly join a string with emoji characters, using an emoji character.");
		})
	
		addFact("string_join_test #10", function() {
		
			var _string = "foo";
		
			var _result = string_join(",", "bar", _string);
			assert_equals(_result, "bar,foo", "#11 string_join : failed to correctly concat a string when arguments are string and variable");
		})
	
		addFact("string_join_test #11", function() {
		
			var _string = "foo";
		
			var _result = string_join(",", _string, "bar");
			assert_equals(_result, "foo,bar", "#10 string_join : failed to correctly concat a string when arguments are variable and string");
		})
	}
	
	// STRING_JOIN TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_join_ext_test #1", function() {
		
			var _result = string_join_ext(",", [12, "hello", []]);
			assert_equals(_result, "12,hello,[  ]", "#1 string_join_ext : failed to correctly join a string with mixed types, using a comma.");
		})
	
		addFact("string_join_ext_test #2", function() {
		
			var _result = string_join_ext(",", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合,気道合気道合気道", "#2 string_join_ext : failed to correctly join a string with non-latin characters, using a comma");
		})
	
		addFact("string_join_ext_test #3", function() {
		
			var _result = string_join_ext(",", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", "#3 string_join_ext : failed to correctly join a string with emoji characters, using a comma");
		})
	
		addFact("string_join_ext_test #4", function() {
		
			var _result = string_join_ext("道", [12, "hello", []]);
			assert_equals(_result, "12道hello道[  ]", "#4 string_join_ext : failed to correctly join a string with mixed types, using a non-latin character.");
		})
	
		addFact("string_join_ext_test #5", function() {
		
			var _result = string_join_ext("道", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合道気道合気道合気道", "#5 string_join_ext : failed to correctly join a string with non-latin characters, using a non-latin character.");
		})
	
		addFact("string_join_ext_test #6", function() {
		
			var _result = string_join_ext("道", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", "#6 string_join_ext : failed to correctly join a string with emoji characters, using a non-latin character.");
		})
	
		addFact("string_join_ext_test #7", function() {
		
			var _result = string_join_ext("🙂", [12, "hello", []]);
			assert_equals(_result, "12🙂hello🙂[  ]", "#7 string_join_ext : failed to correctly join a string with mixed types, using an emoji character.");
		})
	
		addFact("string_join_ext_test #8", function() {
		
			var _result = string_join_ext("🙂", ["合気道合", "気道合気道合気道"]);
			assert_equals(_result, "合気道合🙂気道合気道合気道", "#8 string_join_ext : failed to correctly join a string with non-latin characters, using an emoji character.");
		})
	
		addFact("string_join_ext_test #9", function() {
		
			var _result = string_join_ext("🙂", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
			assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", "#9 string_join_ext : failed to correctly join a string with emoji characters, using an emoji character.");
		})
	
		addFact("string_join_ext_test #10", function() {
		
			var _string = "foo";
		
			var _result = string_join_ext(",", [_string, "bar"]);
			assert_equals(_result, "foo,bar", "#10 string_join_ext : failed to correctly concat a string when arguments are variable and string");
		})
	
		addFact("string_join_ext_test #11", function() {
		
			var _string = "foo";
		
			var _result = string_join_ext(",", ["bar", _string]);
			assert_equals(_result, "bar,foo", "#11 string_join_ext : failed to correctly concat a string when arguments are string and variable");
		})
	}
	
	// STRING_SPLIT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_split_test #1", function() {
		
			var _input = "hello,great,world";
			var _result = string_split(_input, ",", true);
			assert_array_length(_result, 3, "#1 string_split : failed to correctly split string into correct number of elements.");
			assert_array_equals(_result, ["hello", "great", "world"],"#2 string_split : failed to correctly split string with latin characters.");
		})
	
		addFact("string_split_test #2", function() {
		
			var _input = "1test\n2test,\n3test,,,,\n4test\n5test。\n6test，\n7test，，\n8test\n9test"
			var _result = string_split(_input, "\n", true);
			assert_array_length(_result, 9, "#3 string_split : failed to correctly split string into correct number of elements.");
		
			assert_array_equals(_result, ["1test", "2test,", "3test,,,,", "4test", "5test。", "6test，", "7test，，", "8test", "9test"],
				"#4 string_split : failed to correctly split string with non-latin characters.");
		})
	}
	
	// STRING_SPLIT_EXT TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_split_ext_test #1", function() {
		
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], false);
			assert_array_length(_result, 6, "#1 string_split_ext : failed to correctly split string into correct number of elements.");
			assert_array_equals(_result, ["he", "", "o", "great", "wor", "d"],"#2 string_split_ext : failed to correctly split string with latin characters.");
		})
	
		addFact("string_split_ext_test #2", function() {
		
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], true);
			assert_array_length(_result, 5, "#3 string_split_ext : failed to correctly split string into correct number of elements (remove empty).");
			assert_array_equals(_result, ["he", "o", "great", "wor", "d"],"#4 string_split_ext : failed to correctly split string with latin characters.");
		})
	
		addFact("string_split_ext_test #3", function() {
		
			var _input = "hello,great,world";
			var _result = string_split_ext(_input, [",", "l"], false, 3);
			assert_array_length(_result, 4, "#5 string_split_ext : failed to correctly split string into correct number of elements (max splits).");
			assert_array_equals(_result, ["he", "", "o", "great,world"],"#6 string_split_ext : failed to correctly split string with latin characters.");
		})
	}
	
	// STRING_STARTS_WITH_TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_starts_with_test #1", function() {
		
			var _input = "hello world";
			var _result = string_starts_with(_input, "hello");
			assert_true(_result, "#1 string_starts_with : failed to correctly detect start of the string, latin characters");
		})
	
		addFact("string_starts_with_test #2", function() {
		
			var _input = "🏡🔠👸👟🕔🕝💎"
			var _result = string_starts_with(_input, "🏡🔠👸");
			assert_true(_result, "#2 string_starts_with : failed to correctly detect start of the string, emoji characters");
		})
	}
	
	// STRING_ENDS_WITH_TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_ends_with_test #1", function() {
		
			var _input = "hello world";
			var _result = string_ends_with(_input, "world");
			assert_true(_result, "#1 string_ends_with : failed to correctly detect end of the string, latin characters");
		})
	
		addFact("string_ends_with_test #2", function() {
		
			var _input = "🏡🔠👸👟🕔🕝💎"
			var _result = string_ends_with(_input, "🕔🕝💎");
			assert_true(_result, "#2 string_ends_with : failed to correctly detect end of the string, emoji characters");
		})
	}

	// STRING_TRIM_START TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_trim_start_test #1", function() {
		
			var _input = "		 	sometext				";
			var _result = string_trim_start(_input);
			assert_equals(_result, "sometext				", "#1 string_trim_start : failed to correctly trim the start of the string, latin characters");
		})
	
		addFact("string_trim_start_test #2", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim_start(_input);
			assert_equals(_result, "秧秧秧秧秧秧秧秧                  ", "#2 string_trim_start : failed to correctly trim the start of the string, non-latin characters");
		})
	}
	
	// STRING_TRIM_END TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_trim_end_test #1", function() {
		
			var _input = "		 	sometext				";
			var _result = string_trim_end(_input);
			assert_equals(_result, "		 	sometext", "#1 string_trim_end : failed to correctly trim the end of the string, latin characters");
		})
	
		addFact("string_trim_end_test #2", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim_end(_input);
			assert_equals(_result, "                  秧秧秧秧秧秧秧秧", "#2 string_trim_end : failed to correctly trim the end of the string, non-latin characters");
		})
	}
	
	// STRING_TRIM TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_trim_test #1", function() {
		
			var _input = "		 	sometext				";
			var _result = string_trim(_input);
			assert_equals(_result, "sometext", "#1 string_trim_end : failed to correctly trim the string, latin characters");
		})
	
		addFact("string_trim_test #2", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧                  ";
			var _result = string_trim(_input);
			assert_equals(_result, "秧秧秧秧秧秧秧秧", "#2 string_trim_end : failed to correctly trim the string, non-latin characters");
		})
	}
	
	// STRING_FOREACH TESTS - PROGRESS: COMMENTS & ASSERTS NEED UPDATES, AND CHECK SEMICOLONS
	{
		addFact("string_foreach_test #1", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧sometext";
		
			string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
				assert_equals(_char, string_char_at(in, _pos), "#1 string_foreach : failed to traverse correctly the string.");
			}));
		})
	
		addFact("string_foreach_test #2", function() {
		
			var _input = "                  秧秧秧秧秧秧秧秧sometext";
		
			string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
				assert_equals(_char, string_char_at(in, _pos), "#2 string_foreach : failed to traverse correctly the string.");
			}), -1, -infinity);	
		})
	}
	
}

