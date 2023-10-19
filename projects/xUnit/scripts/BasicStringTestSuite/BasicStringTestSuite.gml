

function BasicStringTestSuite() : TestSuite() constructor {

	addFact("ansi_char_test", function() {

		// ansi_char test
		//show_debug_message("Begin ansi_char test")
			
		// Basic ASCII test
		var aStr = ansi_char($41)
		assert_equals(aStr, "A", "ASCII 65 == 'A'")
			
		// Literals
		assert_equals(ansi_char($42), "B", "ASCII 66 == 'B'")
			
		// Hello world test
		var helloStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F) 
		var worldStr = ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64)
		assert_equals(helloStr, "Hello", "Hello str Test")
		assert_equals(worldStr, "world", "world str Test")
			
		var space = ansi_char($20)
		assert_equals(space, " ", "Space char test")
			
		var exclamation = ansi_char($21)
		assert_equals(exclamation, "!", "Exclamation char test")
			
		var fullStr = ansi_char($48) + ansi_char($65) + ansi_char($6C) + ansi_char($6C) + ansi_char($6F) + ansi_char($20) + ansi_char($77) + ansi_char($6F) + ansi_char($72) + ansi_char($6C) + ansi_char($64) + ansi_char($21)
		assert_equals(fullStr, "Hello world!", "Hello world string test")
			
		var concatTest = helloStr + space + worldStr + exclamation
		assert_equals(concatTest, "Hello world!", "Concat Hello world string test")
			
		var concatQuickTest = helloStr
		concatQuickTest += space
		concatQuickTest += worldStr 
		concatQuickTest += exclamation
		assert_equals(concatQuickTest, "Hello world!", "Concat hello world string test")
			
		//show_debug_message("End ansi_char test")
	})

	addFact("chr_test", function() {

		// chr test
		//show_debug_message("Begin chr test");
			
		// Basic ASCII test
		var aStr = chr(65);
		assert_equals(aStr, "A", "ASCII 65 == 'A'");
			
		// Literals
		assert_equals(chr(66), "B", "ASCII 66 == 'B'");
			
		// Hello world test
		var helloStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111);
		var worldStr = chr(119) + chr(111) + chr(114) + chr(108) + chr(100);
		assert_equals(helloStr, "Hello", "Hello str Test");
		assert_equals(worldStr, "world", "world str Test");
			
		var space = chr(32);
		assert_equals(space, " ", "Space char test");
			
		var exclamation = chr(33);
		assert_equals(exclamation, "!", "Exclamation char test");
			
		var fullStr = chr(72) + chr(101) + chr(108) + chr(108) + chr(111) + chr(32) + chr(119) + chr(111) + chr(114) + chr(108) + chr(100) + chr(33);
		assert_equals(fullStr, "Hello world!", "Hello world string test");
			
		var concatTest = helloStr + space + worldStr + exclamation;
		assert_equals(concatTest, "Hello world!", "Concat Hello world string test");
			
		var concatQuickTest = helloStr;
		concatQuickTest += space;
		concatQuickTest += worldStr; 
		concatQuickTest += exclamation;
		assert_equals(concatQuickTest, "Hello world!", "Concat hello world string test");
			
		// Unicode tests
		var euro = chr(8364); //Unicode euro test
		assert_equals(euro, "€", "Euro sign test");
			
		var indianRupee = chr(8377);
		assert_equals(indianRupee, "₹", "Indian Rupee sign test");
			
		var rupee = chr(8360);
		assert_equals(rupee, "₨", "Rupee sign test");
			
		var theta = chr(952);
		assert_equals(theta, "θ", "Theta test");
			
		var smileyFace = chr(128578);
		assert_equals(smileyFace, "🙂", "Smiley face literal test");
			
		var euroOrd = 8364;
		var euroChar = chr(euroOrd); //Unicode euro test
		assert_equals(euroChar, "€", "Euro sign test");
			
		var u8001 = 32769;
		var u8001Chr = chr(u8001);
		assert_equals(u8001Chr, "老", "u8001 is 老");
			
		var u8001ChrLit = chr(32769);
		assert_equals(u8001ChrLit, "老", "u8001 is 老");
			
		var indianRupeeOrd = 8377;
		var indianRupeeChar = chr(indianRupeeOrd);
		assert_equals(indianRupeeChar, "₹", "Indian Rupee sign test")
			
		var rupeeOrd = 8360;
		var rupeeChar = chr(rupeeOrd);
		assert_equals(rupeeChar, "₨", "Rupee sign test");
			
		var thetaOrd = 952;
		var thetaChar = chr(thetaOrd)
		assert_equals(thetaChar, "θ", "Theta test");
			
		var smileyFaceOrd = 128578;
		var smileyFaceChar = chr(smileyFaceOrd);
		assert_equals(smileyFaceChar, "🙂", "Smiley face var test");
			
		var aUChar = "\u41";
		assert_equals(aUChar, "A", "A char");
			
		var euroUChar = "\u20AC";
		assert_equals(euroUChar, "€", "Euro symbol");
			
		var u8001UChar = "\u8001";
		assert_equals(u8001UChar, "老", "u8001 symbol");
			
		var u1F642UChar = "\u1F642";
		assert_equals(u1F642UChar, "🙂", "Smiley face u char test");
			
		var variousChars = "\u1F642\u8001\u20AC\u41";
		assert_equals(variousChars, "🙂老€A", "Various char string was successful");
			
		var smileyString = "\u1F642\u1F642\u1F642\u8001\u1F642\u1F642";
		assert_equals(smileyString, "🙂🙂🙂老🙂🙂", "Various char string was successful");
			
		var smileyEuros = "\u20AC\u1F642\u20AC\u1F642\u20AC\u1F642\u20AC";
		assert_equals(smileyEuros, "€🙂€🙂€🙂€", "Various char string was successful");
			
		//show_debug_message("End chr test");
	})

	addFact("ord_test", function() {

		// ord test
			
		//show_debug_message("Begin ord test");
			
		// Basic test
		{
			var zeroChar = ord("0");
			assert_equals(zeroChar, 48, "ASCII Zero == 48");
			
			var uppercaseA = ord("A");
			assert_equals(uppercaseA, 65, "ASCII A == 65");
			
			var lowercaseA = ord("a");
			assert_equals(lowercaseA, 97, "ASCII a == 97");
			
			// Extended char set
			var poundSymbol = ord("£");
			assert_equals(poundSymbol, 163, "£ sign == 163");
			
			var euroSymbol = ord("€");
			assert_equals(euroSymbol, 8364, "€ sign == 8364");
			
			var indianRupee = ord("₹");
			assert_equals(indianRupee, 8377, "Indian Rupee sign test");
			
			var rupee = ord("₨");
			assert_equals(rupee, 8360, "Rupee sign test");
			
			var theta = ord("θ");
			assert_equals(theta, 952, "Theta test");
			
			var smileyOrdLit = ord("🙂");
			assert_equals(smileyOrdLit, 128578, "Smiley face ord literal test");
		}
			
		{
			var zeroChar = "0";
			var zeroOrd = ord(zeroChar);
			assert_equals(zeroOrd, 48, "ASCII Zero == 48");
			
			var uppercaseA = "A";
			var uppercaseAOrd = ord(uppercaseA);
			assert_equals(uppercaseAOrd, 65, "ASCII A == 65");
			
			var lowercaseA = "a";
			var lowercaseAOrd = ord(lowercaseA);
			assert_equals(lowercaseAOrd, 97, "ASCII a == 97");
			
			// Extended char set
			var poundSymbol = "£";
			var poundSymbolOrd = ord(poundSymbol);
			assert_equals(poundSymbolOrd, 163, "£ sign == 163");
			
			var euroSymbol = "€";
			var euroSymbolOrd = ord(euroSymbol);
			assert_equals(euroSymbolOrd, 8364, "€ sign == 8364");
			
			var indianRupee = "₹";
			var indianRupeeOrd = ord(indianRupee);
			assert_equals(indianRupeeOrd, 8377, "Indian Rupee sign test");
			
			var rupee = "₨";
			var rupeeOrd = ord(rupee);
			assert_equals(rupeeOrd, 8360, "Rupee sign test");
			
			var theta = "θ";
			var thetaOrd = ord(theta);
			assert_equals(thetaOrd, 952, "Theta test");
			
			var smileyVar = "🙂";
			var smileyOrdVar = ord(smileyVar);
			assert_equals(smileyOrdVar, 128578, "Smiley face var ord test");
		}
			
		//show_debug_message("End ord test");
	})

	addFact("string_byte_at_test", function() {

		//string_byte_at test
		//show_debug_message("start string_byte_at() test");
			
		var vstring = "hello World!"
			
		var res;
			
		//#1 string_byte_at( string local , real const )
		res = string_byte_at(vstring, 7);
		assert_equals(res, 87, "#1 string_byte_at( string local , real const )") // 'W'
			
		//#2 string_byte_at( string local , real const )
		res = string_byte_at(vstring, 7.6);
		assert_equals(res, 87, "#2 string_byte_at( string local , real const )") // 'W'
			
		//#3 string_byte_at( string local , real const )
		res = string_byte_at(vstring, 7.2);
		assert_equals(res, 87, "#3 string_byte_at( string local , real const )") // 'W'
			
		//#4 string_byte_at( string local , real const )
		res = string_byte_at(vstring, 0);
		assert_equals(res, 104, "#4 string_byte_at( string local , real const )") // 'h'
			
		//#5 string_byte_at( string local , real const )
		res = string_byte_at(vstring, 100);
		assert_equals(res, 33, "#5 string_byte_at( string local , real const )") // '!'
			
		//#6 string_byte_at( string local , real const )
		res = string_byte_at(vstring, -2);
		assert_equals(res, 104, "#6 string_byte_at( string local , real const )") // 'h'
			
			
		#macro kString_StringByteAtTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#7 string_byte_at( string macro , real const )
		res = string_byte_at(kString_StringByteAtTest, 7);
		assert_equals(res, 87, "#7 string_byte_at( string macro , real const )")
			
		//#8 string_byte_at( string global , real const )
		res = string_byte_at(global.gstring, 7);
		assert_equals(res, 87, "#8 string_byte_at( string global , real const )")
			
		//#9 string_byte_at( string instance , real const )
		res = string_byte_at(_oTest.ostring, 7);
		assert_equals(res, 87, "#9 string_byte_at( string instance , real const )")
			
			
		// UTF-8 tests 2/3/4 bytes
			
		//#10 string_byte_at( string const , real const )
		res = string_byte_at("!£水🙂a", 1); // ! - 0x21
		assert_equals(res, 0x21, "#10 string_byte_at( string const , real const )")
			
		//#11 string_byte_at( string const , real const )
		res = string_byte_at("!£水🙂a", 2); // £ - 0xc2 0xa3
		assert_equals(res, 0xc2, "#11 string_byte_at( string const , real const )")
			
		//#12 string_byte_at( string const , real const )
		res = string_byte_at("!£水🙂a", 4); // 水 - 0xe6 0xb0 0xb4
		assert_equals(res, 0xe6, "#12 string_byte_at( string const , real const )")
			
		//#13 string_byte_at( string const , real const )
		res = string_byte_at("!£水🙂a", 7); // 🙂 - 0xf0 0x9f 0x99 0x82
		assert_equals(res, 0xf0, "#13 string_byte_at( string const , real const )")
			
		//#14 string_byte_at( string const , real const )
		res = string_byte_at("!£水🙂a", 11); // a - 0x61
		assert_equals(res, 0x61, "#14 string_byte_at( string const , real const )")
			
		instance_destroy(_oTest);
			
		//show_debug_message("end string_byte_at() test");
	})

	addFact("string_byte_length_test", function() {

		// string_byte_length test
		//show_debug_message("Begin string_byte_length test")
			
		// Hello world test
		var helloWorldStr = "Hello world!"
		var helloWorldByteLen = string_byte_length(helloWorldStr)
		assert_equals(helloWorldByteLen, 12, "Hello world!, as an ascii string, is 12 bytes")
			
		var literalHWByteLen = string_byte_length("Hello world!")
		assert_equals(literalHWByteLen, 12, "Literal Hello world!, as an ascii string, is 12 bytes")
			
		// UTF8 tests
		var poundPrice = "£99.99"
		var poundPriceLen = string_byte_length(poundPrice)
		assert_equals(poundPriceLen, 7, "Pound price string is 7 bytes long")
			
		var euroPrice = "€59.99"
		var euroPriceLen = string_byte_length(euroPrice)
		assert_equals(euroPriceLen, 8, "Euro price string is 8 bytes long")
			
		var someSymbols = "‰ˆ‡†•"
		var someSymbolsLen = string_byte_length(someSymbols)
		assert_equals(someSymbolsLen, 14, "Byte length of someSymbols string is 14")
			
		var aikido = "合気道"
		var aikidoLen = string_byte_length(aikido)
		assert_equals(aikidoLen, 9, "Aikido is 9 bytes")
			
		var kotegaeshi = "小手返"
		var kotegaeshiLen = string_byte_length(kotegaeshi)
		assert_equals(kotegaeshiLen, 9, "kotegaeshi is 9 bytes")
			
		// Emoji!
		var smileyFace = "🙂"
		var smileyFaceLen = string_byte_length(smileyFace)
		assert_equals(smileyFaceLen, 4, "1 Smiley face is 4 bytes")
			
		assert_equals(string_byte_length("🙂"), 4, "Smiley face literal")
			
		var emojiString = "💩👏✔"
		var emojiLen = string_byte_length(emojiString)
		assert_equals(emojiLen, 11, "Emoji len is 11 bytes long")
			
		//show_debug_message("End string_byte_length test")
	})

	addFact("string_char_at_test", function() {

		//string_char_at test
		//show_debug_message("start string_char_at() test");
			
		var vstring = "hello World!"
			
		var res;
			
		//#1 string_char_at( real local , real const )
		res = string_char_at(vstring, 7);
		assert_true(is_string(res), "#1 string_char_at( real local , real const )")
		assert_equals(res, "W", "#1 string_char_at( real local , real const )")
			
		//#2 string_char_at( string local , real const )
		res = string_char_at(vstring, 7.6);
		assert_true(is_string(res), "#2 string_char_at( string local , real const )")
		assert_equals(res, "W", "#2 string_char_at( string local , real const )")
			
		//#3 string_char_at( string local , real const )
		res = string_char_at(vstring, 7.2);
		assert_true(is_string(res), "#3 string_char_at( string local , real const )")
		assert_equals(res, "W", "#3 string_char_at( string local , real const )")
			
		//#4 string_char_at( string local , real const )
		res = string_char_at(vstring, 0);
		assert_true(is_string(res), "#4 string_char_at( string local , real const )")
		assert_equals(res, "h", "#4 string_char_at( string local , real const )")
			
		//#5 string_char_at( string local , real const )
		res = string_char_at(vstring, 100);
		assert_true(is_string(res), "#5 string_char_at( string local , real const )")
		assert_equals(res, "", "#5 string_char_at( string local , real const )")
			
		//#6 string_char_at( string local , real const )
		res = string_char_at(vstring, -2);
		assert_true(is_string(res), "#6 string_char_at( string local , real const )")
		assert_equals(res, "h", "#6 string_char_at( string local , real const )")
			
			
		//#7 string_char_at( int64 const , real const )
		res = string_char_at(int64(1234), 2);
		assert_true(is_string(res), "#7 string_char_at( int64 const , real const )")
		assert_equals(res, "2", "#7 string_char_at( int64 const , real const )")
			
		//#8 string_char_at( real const , real const )
		res = string_char_at(1.234, 2);
		assert_true(is_string(res), "#8 string_char_at( real const , real const )")
		assert_equals(res, ".", "#8 string_char_at( real const , real const )")
			
		//#9 string_char_at( bool const , real const )
		res = string_char_at(true, 1);
		assert_true(is_string(res), "#9 string_char_at( bool const , real const )")
		assert_equals(res, "1", "#9 string_char_at( bool const , real const )")
			
		#macro kString_StringCharAtTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#10 string_char_at( string macro , real const )
		res = string_char_at(kString_StringCharAtTest, 7);
		assert_equals(res, "W", "#10 string_char_at( string macro , real const )")
			
		//#11 string_char_at( string global , real const )
		res = string_char_at(global.gstring, 7);
		assert_equals(res, "W", "#11 string_char_at( string global , real const )")
			
		//#12 string_char_at( string instance , real const )
		res = string_char_at(_oTest.ostring, 7);
		assert_equals(res, "W", "#12 string_char_at( string instance , real const )")
			
			
		// UTF-8 tests 2/3/4 bytes
			
		//#13 string_char_at( string const , real const )
		res = string_char_at("!£水🙂a", 1);
		assert_equals(res, "!", "#13 string_char_at( string const , real const )")
			
		//#14 string_char_at( string const , real const )
		res = string_char_at("!£水🙂a", 2);
		assert_equals(res, "£", "#14 string_char_at( string const , real const )")
			
		//#15 string_char_at( string const , real const )
		res = string_char_at("!£水🙂a", 3);
		assert_equals(res, "水", "#15 string_char_at( string const , real const )")
			
		//#16 string_char_at( string const , real const )
		res = string_char_at("!£水🙂a", 4);
		assert_equals(res, "🙂", "#16 string_char_at( string const , real const )")
			
		//#17 string_char_at( string const , real const )
		res = string_char_at("!£水🙂a", 5);
		assert_equals(res, "a", "#17 string_char_at( string const , real const )")
			
		instance_destroy(_oTest);
	})

	addFact("string_copy_test", function() {

		// String copy test
		//show_debug_message("Begin string_copy test");
			
		var helloWorldStr = "Hello World";
		var helloStr = string_copy(helloWorldStr, 1, 5);
		assert_equals(helloStr, "Hello", "String copy the first five characters");
			
		var worldStr = string_copy(helloWorldStr, 7, 5);
		assert_equals(worldStr, "World", "String copy the five characters from the 7th index");
			
		// UTF8
		var fullPriceStr = "£12.34";
		var poundPriceStr = string_copy(fullPriceStr, 1, 3);
		var pencePriceStr = string_copy(fullPriceStr, 5, 2);
		assert_equals(poundPriceStr, "£12", "Copied three characters to make the \"£12\" string");
		assert_equals(pencePriceStr, "34", "Copied two characters to make the \"34\" string");
			
		var fullEuroStr = "€56.78";
		var euroPriceStr = string_copy(fullEuroStr, 1, 3);
		var centsPriceStr = string_copy(fullEuroStr, 5, 2);
		assert_equals(euroPriceStr, "€56", "Copied three characters to make the \"€56\" string");
		assert_equals(centsPriceStr, "78", "Copied two characters to make the \"78\" string");
			
		var aikido = "合気道";
		var aiki = string_copy(aikido, 1, 2);
		assert_equals(aiki, "合気", "Copying the first two chars ai and ki");
			
		var kotegaeshi = "小手返 Test";
		var kotegaeshiTestStr = string_copy(kotegaeshi, 5, 4);
		assert_equals(kotegaeshiTestStr, "Test", "Copy \"Test\" from kotegaeshi string");
			
		// Emoji
		var smileyTestString = "This is a test 🙂";
		var smileyString = string_copy(smileyTestString, 16, 1);
		assert_equals(smileyString, "🙂", "Copy the smiley face");
			
		var smileyPosLiteral = string_copy("This is a test 🙂", 16, 1);
		assert_equals(smileyPosLiteral, "🙂", "Copy the smiley face from a string literal");
			
		var emojiString = "✔✔✔💩👏";
		var clapEmojiStr = string_copy(emojiString, 5, 1);
		assert_equals(clapEmojiStr, "👏", "Copy the clap emoji");
			
		emojiString = "✔✔✔💩👏 hello world";
		clapEmojiStr = string_copy(emojiString, 5, 13);
		assert_equals(clapEmojiStr, "👏 hello world", "Copy the hello world as well, after the clap emoji");
			
		//show_debug_message("End string_copy test");
	})

	addFact("string_count_test", function() {

		// string_count test
		//show_debug_message("Begin string_count test");
			
		// Basic tests
		var helloWorldStr = "Hello World";
		var numLs = string_count("l", helloWorldStr);
		var numOs = string_count("o", helloWorldStr);
		assert_equals(numLs, 3, "3 Ls in \"Hello World\"");
		assert_equals(numOs, 2, "2 Os in \"Hello World\"");
			
		var numHellos = string_count("Hello", helloWorldStr);
		var numWorlds = string_count("World", helloWorldStr);
		assert_equals(numHellos, 1, "One \"Hello\" in \"Hello World\"");
		assert_equals(numWorlds, 1, "One \"World\" in \"Hello World\"");
			
		var poundStr = "£12.34";
		var numPounds = string_count("£", poundStr);
		assert_equals(numPounds, 1, "One pound glyph in poundStr");
			
		var ninesStr = "£999.99";
		var numNines = string_count("9", ninesStr);
		assert_equals(numNines, 5, "Five nines in ninesStr");
			
		var euroStr = "€12.34";
		var numEuros = string_count("€", euroStr);
		assert_equals(numEuros, 1, "One euro glyph in euroStr");
			
		var fivesStr = "€12555.55"
		var numFives = string_count("5", fivesStr);
		assert_equals(numFives, 5, "Five fives in fivesStr");
			
		var aikido = "合気道合気道合気道合気道";
		var numAi = string_count("合", aikido);
		assert_equals(numAi, 4, "Four Ai glyphs in aikido string");
			
		var smileyString = "This is a test 🙂";
		var numSmileys = string_count("🙂", smileyString);
		assert_equals(numSmileys, 1, "Only one smiley in smileyString");
			
		var emojiString = "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎";
		var numDiamonds = string_count("💎", emojiString);
		assert_equals(numDiamonds, 4, "Four diamond emoji in emojiString");
			
		//show_debug_message("End string_count test");
	})

	addFact("string_delete_test", function() {

		//string_delete test
		//show_debug_message("start string_delete() test");
			
		var vstring = "Hello World!"
			
		var res;
			
		//#1 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7, 1);
		assert_equals(res, "Hello orld!", "#1 string_delete( string local , real const , real const )")
			
		//#2 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7, 2);
		assert_equals(res, "Hello rld!", "#2 string_delete( string local , real const , real const )")
			
		//#3 string_delete( string local , real const , real const ) - delete count > ramining string length
		res = string_delete(vstring, 7, 50);
		assert_equals(res, "Hello ", "#3 string_delete( string local , real const , real const ) - delete count > ramining string length")
			
		//#4 string_delete( string local , real const , real const ) - delete zero count
		res = string_delete(vstring, 7, 0);
		assert_equals(res, "Hello World!", "#4 string_delete( string local , real const , real const ) - delete zero count")
			
		//#5 string_delete( string local , real const , real const ) - delete negative count
		res = string_delete(vstring, 7, -1);
		assert_equals(res, "Hello World!", "#5 string_delete( string local , real const , real const ) - delete negative count")
			
		//#6 string_delete( string local , real const , real const ) - index > string length
		res = string_delete(vstring, 100, 1);
		assert_equals(res, "Hello World!", "#6 string_delete( string local , real const , real const ) - index > string length")
			
		//#7 string_delete( string local , real const , real const ) - zero index
		res = string_delete(vstring, 0, 1);
		assert_equals(res, "Hello World!", "#7 string_delete( string local , real const , real const ) - zero index")
			
		//#8 string_delete( string local , real const , real const ) - negative index
		res = string_delete(vstring, -1, 1);
		assert_equals(res, "Hello World!", "#8 string_delete( string local , real const , real const ) - negative index")
			
		//#9 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7, 2.4);
		assert_equals(res, "Hello rld!", "#9 string_delete( string local , real const , real const )")
			
		//#10 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7, 2.6);
		assert_equals(res, "Hello rld!", "#10 string_delete( string local , real const , real const )")
			
		//#11 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7.2, 2);
		assert_equals(res, "Hello rld!", "#11 string_delete( string local , real const , real const )")
			
		//#12 string_delete( string local , real const , real const )
		res = string_delete(vstring, 7.6, 2);
		assert_equals(res, "Hello rld!", "#12 string_delete( string local , real const , real const )")
			
		//#13 string_delete( string local , string const , real const )
		res = string_delete(vstring, "7", 2);
		assert_equals(res, "Hello rld!", "#13 string_delete( string local , string const , real const )")
			
		//#14 string_delete( string local , real const , string const )
		res = string_delete(vstring, 7, "2");
		assert_equals(res, "Hello rld!", "#14 string_delete( string local , real const , string const )")
			
			
		//#15 string_delete( string local , real const , real const ) - empty string
		res = string_delete("", 1, 1);
		assert_equals(res, "", "#15 string_delete( string local , real const , real const ) - empty string")
			
			
		//#16 string_delete( int64 local , real const , real const )
		res = string_delete(int64(1234), 2, 1);
		assert_true(is_string(res), "#16 string_delete( int64 local , real const , real const )")
		assert_equals(res, "134", "#16 string_delete( int64 local , real const , real const )")
			
		//#17 string_delete( real local , real const , real const )
		res = string_delete(1.234, 2, 1);
		assert_true(is_string(res), "#17 string_delete( real local , real const , real const )")
		assert_equals(res, "123", "#17 string_delete( real local , real const , real const )") // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#18 string_delete( bool local , real const , real const )
		res = string_delete(true, 1, 1);
		assert_true(is_string(res), "#18 string_delete( bool local , real const , real const )")
		assert_equals(res, "", "#18 string_delete( bool local , real const , real const )")
			
			
		#macro kString_StringDeleteTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#19 string_delete( string macro , real const , real const )
		res = string_delete(kString_StringDeleteTest, 7, 1);
		assert_equals(res, "Hello orld!", "#19 string_delete( string macro , real const , real const )")
			
		//#20 string_delete( string global , real const , real const )
		res = string_delete(global.gstring, 7, 1);
		assert_equals(res, "Hello orld!", "#20 string_delete( string global , real const , real const )")
			
		//#21 string_delete( string instance , real const , real const )
		res = string_delete(_oTest.ostring, 7, 1);
		assert_equals(res, "Hello orld!", "#21 string_delete( string instance , real const , real const )")
			
			
		//#22 string_delete( string const , real const , real const ) - 2 byte UTF8
		res = string_delete("Price: £3.99", 1, 8);
		assert_equals(res, "3.99", "#22 string_delete( string const , real const , real const ) - 2 byte UTF8")
			
		//#23 string_delete( string const , real const , real const ) - 3 byte UTF8
		res = string_delete("Mizu (水)", 5, 4);
		assert_equals(res, "Mizu", "#23 string_delete( string const , real const , real const ) - 3 byte UTF8")
			
		//#24 string_delete( string const , real const , real const ) - 4 byte UTF8
		res = string_delete("🙂", 1, 1);
		assert_equals(res, "", "#24 string_delete( string const , real const , real const ) - 4 byte UTF8")
			
		// #25
		res = string_delete("🙂x🙂", 2, 1);
		assert_equals(res, "🙂🙂", "#25 string_delete( string const , real const , real const ) - 2x4 byte UTF8")
			
		// #26
		res = string_delete("🙂x🙂x🙂", 4, 1);
		assert_equals(res, "🙂x🙂🙂", "#26 string_delete( string const , real const , real const ) - 2x4 byte UTF8")
			
		// #27
		res = string_delete("🙂x🙂x🙂x🙂", 6, 1);
		assert_equals(res, "🙂x🙂x🙂🙂", "#27 string_delete( string const , real const , real const ) - 4x4 byte UTF8")
			
		// #28
		res = string_delete("🙂x🙂x🙂x🙂", 5, 1);
		assert_equals(res, "🙂x🙂xx🙂", "#28 string_delete( string const , real const , real const ) - 4x4 byte UTF8")
			
		instance_destroy(_oTest)
	})

	addFact("string_digits_test", function() {

		//string_digits test
		//show_debug_message("start string_digits() test");
			
		var vstring1 = "321!HeLlO WoRlD!123"
		var vstring2 = "!£水🙂"
		var vstring3 = ""
		var vstring4 = "1234"
			
		var res;
			
		//#1 string_digits( string local )
		res = string_digits(vstring1);
		assert_equals(res, "321123", "#1 string_digits( string local )");
			
		//#2 string_digits( string local ) - no digits
		res = string_digits(vstring2);
		assert_equals(res, "", "#2 string_digits( string local ) - no digits");
			
		//#3 string_digits( string local ) - empty string
		res = string_digits(vstring3);
		assert_equals(res, "", "#3 string_digits( string local ) - empty string");
			
		//#4 string_digits( string local ) - all digits
		res = string_digits(vstring4);
		assert_equals(res, "1234", "#4 string_digits( string local ) - all letters");
			
		//#5 string_digits( real const )
		res = string_digits(1234);
		assert_equals(res, "1234", "#5 string_digits( real const )");
			
		//#6 string_digits( real const )
		res = string_digits(1.234);
		assert_equals(res, "123", "#6 string_digits( real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
			
		#macro kString_StringDigitsTest "321!Hello World!123"
		global.gstring = "321!Hello World!123";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "321!Hello World!123";
			
		//#7 string_digits( string macro )
		res = string_digits(kString_StringDigitsTest);
		assert_equals(res, "321123", "#7 string_digits( string macro )")
			
		//#8 string_digits( string global )
		res = string_digits(global.gstring);
		assert_equals(res, "321123", "#8 string_digits( string global )")
			
		//#9 string_digits( string instance )
		res = string_digits(_oTest.ostring);
		assert_equals(res, "321123", "#9 string_digits( string instance )")
			
			
		instance_destroy(_oTest)
	})

	addFact("string_format_test", function() {

		// string_format test
		//show_debug_message("Begin string_format test")
			
		// Basic Test
		// With vars
		var testNum = 123456
		var testStr = string_format(testNum, 6, 0)
		assert_equals(testStr, "123456", "Simple string format test with vars")
			
		// With literals
		var testStr2 = string_format(123456789, 9, 0)
		assert_equals(testStr2, "123456789", "Simple string format test with literals")
			
		// Fractional formatting
		var testStr3 = string_format(123, 3, 3)
		assert_equals(testStr3, "123.000", "String format adding zeros to a whole number")
			
		var fracNum = 123.456
			
		var fracStr = string_format(fracNum, 3, 3)
		assert_equals(fracStr, "123.456", "Simple fractional string format")
			
		var fracStr2 = string_format(fracNum, 6, 6)
		assert_equals(fracStr2, "   123.456000", "Fractional string with padding on the left and right of the decimal point")
			
		var fracStr3 = string_format(fracNum, 3, 0)
		assert_equals(fracStr3, "123", "Fractional string with decimal part discarded")
			
		//show_debug_message("End string_format test")
	})

	addFact("string_hash_to_newline_test", function() {

		// string_hash_to_newline test
		//show_debug_message("Begin string_hash_to_newline test");
			
		// Basic tests
		var helloWorldOld = "Hello#World";
		var helloWorldNew = string_hash_to_newline(helloWorldOld);
		assert_equals(helloWorldNew, "Hello\r\nWorld", "Hello#World to Hello\\r\\nWorld");
			
		var priceString  = "£99#99";
		var priceSplit = string_hash_to_newline(priceString);
		assert_equals(priceSplit, "£99\r\n99", "£99#99 to £99\\r\\n99");
			
		var euroString = "€99#99";
		var euroSplit = string_hash_to_newline(euroString);
		assert_equals(euroSplit, "€99\r\n99", "€99#99 to €99\\r\\n99");
			
		var emojiString = "👏👏#👏";
		var emojiSplit = string_hash_to_newline(emojiString);
		assert_equals(emojiSplit, "👏👏\r\n👏", "👏👏#👏 to 👏👏\\r\\n👏")
			
		//show_debug_message("End string_hash_to_newline test");
	})

	addFact("string_insert_test", function() {

		//string_insert test
		//show_debug_message("start string_insert() test");
			
		var vstring = "Hello World!"
			
		var res;
			
		//#1 string_insert( string const , string local , real const )
		res = string_insert("xx", vstring, 1);
		assert_equals(res, "xxHello World!", "#1 string_insert( string const , string local , real const )")
			
		//#2 string_insert( string const , string local , real const )
		res = string_insert("xx", vstring, 2);
		assert_equals(res, "Hxxello World!", "#2 string_insert( string const , string local , real const )")
			
		//#3 string_insert( string const , string local , real const ) - insert count > ramining string length
		res = string_insert("xx", vstring, 50);
		assert_equals(res, "Hello World!xx", "#3 string_insert( string const , string local , real const ) - insert count > ramining string length")
			
		//#4 string_insert( string const , string local , real const ) - insert zero count
		res = string_insert("xx", vstring, 0);
		assert_equals(res, "xxHello World!", "#4 string_insert( string const , string local , real const ) - insert zero count")
			
		//#5 string_insert( string const , string local , real const ) - insert negative count
		res = string_insert("xx", vstring, -1);
		assert_equals(res, "xxHello World!", "#5 string_insert( string const , string local , real const ) - insert negative count")
			
		//#6 string_insert( string const , string local , real const ) - index > string length
		res = string_insert("xx", vstring, 1);
		assert_equals(res, "xxHello World!", "#6 string_insert( string const , string local , real const ) - index > string length")
			
		//#7 string_insert( string const , string local , real const )
		res = string_insert("xx", vstring, 2.4);
		assert_equals(res, "Hxxello World!", "#7 string_insert( string const , string local , real const )")
			
		//#8 string_insert( string const , string local , real const )
		res = string_insert("xx", vstring, 2.6);
		assert_equals(res, "Hxxello World!", "#8 string_insert( string const , string local , real const )")
			
		//#9 string_insert( string const , string local , string const )
		res = string_insert("xx", vstring, "2");
		assert_equals(res, "Hxxello World!", "#9 string_insert( string const , string local , string const )")
			
			
		//#10 string_insert( string const , string const , real const ) - empty string
		res = string_insert("xx", "", 1);
		assert_equals(res, "xx", "#10 string_insert( string const , string const , real const ) - empty string")
			
		//#11 string_insert( string const , string const , real const ) - empty string
		res = string_insert("xx", "", 10);
		assert_equals(res, "xx", "#11 string_insert( string const , string const , real const ) - empty string")
			
		//#12 string_insert( string const , string const , real const ) - empty string
		res = string_insert("xx", "", -10);
		assert_equals(res, "xx", "#12 string_insert( string const , string const , real const ) - empty string")
			
			
		//#13 string_insert( string const , int64 local , real const )
		res = string_insert("xx", int64(1234), 1);
		assert_true(is_string(res), "#13 string_insert( string const , int64 local , real const )")
		assert_equals(res, "xx1234", "#13 string_insert( string const , int64 local , real const )")
			
		//#14 string_insert( string const , real local , real const )
		res = string_insert("xx", 1.234, 1);
		assert_true(is_string(res), "#14 string_insert( string const , real local , real const )")
		assert_equals(res, "xx1.23", "#14 string_insert( string const , real local , real const )") // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#15 string_insert( string const , bool local , real const )
		res = string_insert("xx", true, 1);
		assert_true(is_string(res), "#15 string_insert( string const , bool local , real const )")
		assert_equals(res, "xx1", "#15 string_insert( string const , bool local , real const )")
			
			
		#macro kString_StringInsertTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#16 string_insert( string const , string macro , real const )
		res = string_insert("xx", kString_StringInsertTest, 8);
		assert_equals(res, "Hello Wxxorld!", "#16 string_insert( string const , string macro , real const )")
			
		//#17 string_insert( string const , string global , real const )
		res = string_insert("xx", global.gstring, 8);
		assert_equals(res, "Hello Wxxorld!", "#17 string_insert( string const , string global , real const )")
			
		//#18 string_insert( string const , string instance , real const )
		res = string_insert("xx", _oTest.ostring, 8);
		assert_equals(res, "Hello Wxxorld!", "#18 string_insert( string const , string instance , real const )")
			
			
		//#20 string_insert( string const , string const , real const ) - 2 byte UTF8
		res = string_insert("£", "Price: 3.99", 8);
		assert_equals(res, "Price: £3.99", "#20 string_insert( string const , string const , real const ) - 2 byte UTF8")
			
		//#21 string_insert( string const , string const , real const ) - 3 byte UTF8
		res = string_insert("水", "Mizu () is the kanji symbol for water", 7);
		assert_equals(res, "Mizu (水) is the kanji symbol for water", "#21 string_insert( string const , string const , real const ) - 3 byte UTF8")
			
		//#22 string_insert( string const , string const , real const ) - 4 byte UTF8
		res = string_insert("🙂", "", 1);
		assert_equals(res, "🙂", "#22 string_insert( string const , string const , real const ) - 4 byte UTF8")
			
		var aString = "aaa";
		res = string_insert("🙂", aString, 2);
		assert_equals(res, "a🙂aa", "#23");
			
		var smileyString = "🙂🙂🙂";
		res = string_insert("a", smileyString, 2);
		assert_equals(res, "🙂a🙂🙂", "#24");
			
		res = string_insert("aa", smileyString, 3);
		assert_equals(res, "🙂🙂aa🙂", "#25");
			
		res = string_insert("🙂", smileyString, 3);
		assert_equals(res, "🙂🙂🙂🙂", "#26");
			
		res = string_insert("🙂🙂", smileyString, 3);
		assert_equals(res, "🙂🙂🙂🙂🙂", "#27");
			
		instance_destroy(_oTest)
	})

	addFact("string_last_pos_ext_test", function() {

		// string_last_pos_ext test
		//show_debug_message("Begin string_last_pos_ext test");
			
		// Basic tests
		var helloWorldStr = "Hello world!Hello world!";
		var numChars = string_length(helloWorldStr);
			
		var helloPos = string_last_pos_ext("Hello", helloWorldStr, numChars);
		var worldPos = string_last_pos_ext("world", helloWorldStr, numChars);
		var exclamationPos = string_last_pos_ext("!", helloWorldStr, numChars);
		assert_equals(helloPos, 13, "Hello Pos is 13 char in");
		assert_equals(worldPos, 19, "World Pos is 19 char in");
		assert_equals(exclamationPos, 24, "Exclamation is at 24 chars in");
			
		helloPos = string_last_pos_ext("Hello", helloWorldStr, (numChars/2));
		worldPos = string_last_pos_ext("world", helloWorldStr, (numChars/2));
		exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2));
		assert_equals(helloPos, 1, "Hello Pos is 1 char in");
		assert_equals(worldPos, 7, "World Pos is 7 char in");
		assert_equals(exclamationPos, 12, "Exclamation is at 12 chars in");
			
		exclamationPos = string_last_pos_ext("!", helloWorldStr, (numChars/2)-1);
		assert_equals(exclamationPos, 0, "Exclamation not found");
			
		var longPos = string_last_pos_ext(helloWorldStr, "!", numChars);
		assert_equals(longPos, 0, "Long string not found in short one");
			
		var samePos = string_last_pos_ext(helloWorldStr, helloWorldStr, numChars);
		assert_equals(samePos, 1, "String found in itself");
			
		var zeroPos = string_last_pos_ext("Hello", helloWorldStr, 0);
		assert_equals(zeroPos, 0, "Hello not found with start_pos zero");
			
		var negPos = string_last_pos_ext("Hello", helloWorldStr, -1);
		assert_equals(negPos, 0, "Hello not found with negative start_pos");
			
		// Test zero
		var helloNil = string_last_pos_ext("hello", helloWorldStr, numChars);
		assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
			
		// UTF8 tests
		var poundPrice = "£99.99";
		numChars = string_length(poundPrice);
		var poundPos = string_last_pos_ext("£", poundPrice, numChars);
		assert_equals(poundPos, 1, "Pound glyph is the first char");
		var periodCharPos = string_last_pos_ext(".", poundPrice, numChars);
		assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
			
		var euroPrice = "€59.99";
		numChars = string_length(euroPrice);
		var euroPos = string_last_pos_ext("€", euroPrice, numChars);
		assert_equals(euroPos, 1, "Euro glyph is the first char");
		var euroPeriodCharPos = string_last_pos_ext(".", euroPrice, numChars);
		assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
			
		var aikido = "合気道";
		numChars = string_length(aikido);
		var aiPos = string_last_pos_ext("合", aikido, numChars);
		var kiPos = string_last_pos_ext("気", aikido, numChars);
		var doPos = string_last_pos_ext("道", aikido, numChars);
		assert_equals(aiPos, 1, "Ai is the first char");
		assert_equals(kiPos, 2, "Ki is the second char");
		assert_equals(doPos, 3, "Do is the third char");
			
		var kotegaeshi = "小手返 Test";
		numChars = string_length(kotegaeshi);
		var kotegaeshiTestPos = string_last_pos_ext("Test", kotegaeshi, numChars);
		assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
			
		// Emoji!
		var smileyString = "This is a test 🙂";
		var smileyPos = string_last_pos_ext("🙂", smileyString, string_length(smileyString));
		assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
			
		var smileyPosLiteral = string_last_pos_ext("🙂", "This is a test 🙂", 16);
		assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
			
		var emojiString = "✔✔✔💩👏";
		var res = string_last_pos_ext("👏", emojiString, string_length(emojiString));
		assert_equals(res, 5, "Clap emoji the 5th char");
			
		var moreEmojiString = "✔✔✔💩😀😁😂👏";
		res = string_last_pos_ext("👏", moreEmojiString, string_length(moreEmojiString));
		assert_equals(res, 8, "Clap emoji the 8th char");
			
		var emojiString3 = "✔✔✔💩😀aa😁😂👏";
		res = string_last_pos_ext("👏", emojiString3, string_length(emojiString3));
		assert_equals(res, 10, "Clap emoji the 10th char");
			
		var emojiString4 = "✔✔✔💩😀😁😂👏aa";
		res = string_last_pos_ext("aa", emojiString4, string_length(emojiString4));
		assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
			
		//show_debug_message("End string_last_pos_ext test");
	})

	addFact("string_last_pos_test", function() {

		// string_last_pos test
		//show_debug_message("Begin string_last_pos test");
			
		// Basic tests
		var helloWorldStr = "Hello world!Hello world!";
		var helloPos = string_last_pos("Hello", helloWorldStr);
		var worldPos = string_last_pos("world", helloWorldStr);
		var exclamationPos = string_last_pos("!", helloWorldStr);
		assert_equals(helloPos, 13, "Hello Pos is 13 char in");
		assert_equals(worldPos, 19, "World Pos is 19 char in");
		assert_equals(exclamationPos, 24, "Exclamation is at 24 chars in");
			
		// Test zero
		var helloNil = string_last_pos("hello", helloWorldStr);
		assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
			
		// UTF8 tests
		var poundPrice = "£99.99";
		var poundPos = string_last_pos("£", poundPrice);
		assert_equals(poundPos, 1, "Pound glyph is the first char");
		var periodCharPos = string_last_pos(".", poundPrice);
		assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
			
		var euroPrice = "€59.99";
		var euroPos = string_last_pos("€", euroPrice);
		assert_equals(euroPos, 1, "Euro glyph is the first char");
		var euroPeriodCharPos = string_last_pos(".", euroPrice);
		assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
			
		var aikido = "合気道";
		var aiPos = string_last_pos("合", aikido);
		var kiPos = string_last_pos("気", aikido);
		var doPos = string_last_pos("道", aikido);
		assert_equals(aiPos, 1, "Ai is the first char");
		assert_equals(kiPos, 2, "Ki is the second char");
		assert_equals(doPos, 3, "Do is the third char");
			
		var kotegaeshi = "小手返 Test";
		var kotegaeshiTestPos = string_last_pos("Test", kotegaeshi);
		assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
			
		// Emoji!
		var smileyString = "This is a test 🙂";
		var smileyPos = string_last_pos("🙂", smileyString);
		assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
			
		var smileyPosLiteral = string_last_pos("🙂", "This is a test 🙂");
		assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
			
		var emojiString = "✔✔✔💩👏";
		var res = string_last_pos("👏", emojiString);
		assert_equals(res, 5, "Clap emoji the 5th char");
			
		var moreEmojiString = "✔✔✔💩😀😁😂👏";
		res = string_last_pos("👏", moreEmojiString);
		assert_equals(res, 8, "Clap emoji the 8th char");
			
		var emojiString3 = "✔✔✔💩😀aa😁😂👏";
		res = string_last_pos("👏", emojiString3);
		assert_equals(res, 10, "Clap emoji the 10th char");
			
		var emojiString4 = "✔✔✔💩😀😁😂👏aa";
		res = string_last_pos("aa", emojiString4);
		assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
			
		//show_debug_message("End string_last_pos test");
	})

	addFact("string_length_test", function() {

		// string_length test
			
		//show_debug_message("Begin string_length test")
			
		// Basic ASCII tests
			
		var helloWorldLen = string_length("Hello world!")
		assert_equals(helloWorldLen, 12, "Hello world! is 12 chars")
			
		var helloWorldStr = "Hello world!"
		var hw2Len = string_length(helloWorldStr)
		assert_equals(hw2Len, 12, "Hello world! as a var is 12 chars")
			
		var longSentence = "The quick brown fox jumped over the lazy dog!"
		var sentenceLen = string_length(longSentence)
		assert_equals(sentenceLen, 45, "This sentence is 45 chars long")
			
		// UTF8 tests
		var poundPrice = "£99.99"
		var poundPriceLen = string_length(poundPrice)
		assert_equals(poundPriceLen, 6, "Pound price string is 6 chars long")
			
		var euroPrice = "€59.99"
		var euroPriceLen = string_length(euroPrice)
		assert_equals(euroPriceLen, 6, "Euro price string is 6 chars long")
			
		var someSymbols = "‰ˆ‡†•"
		var someSymbolsLen = string_length(someSymbols)
		assert_equals(someSymbolsLen, 5, "Lenght of someSymbols string is 5")
			
		var aikido = "合気道"
		var aikidoLen = string_length(aikido)
		assert_equals(aikidoLen, 3, "Aikido is 3 chars")
			
		var kotegaeshi = "小手返"
		var kotegaeshiLen = string_length(kotegaeshi)
		assert_equals(kotegaeshiLen, 3, "kotegaeshi is 3 chars")
			
		// Emoji!
		var smileyFace = "🙂"
		var smileyFaceLen = string_length(smileyFace)
		assert_equals(smileyFaceLen, 1, "1 Smiley face is 1 char")
			
		assert_equals(string_length("🙂"), 1, "Smiley face literal")
			
		var emojiString = "💩👏✔"
		var emojiLen = string_length(emojiString)
		assert_equals(emojiLen, 3, "Emoji len is 3 chars long")
			
		//show_debug_message("End string_length test")
	})

	addFact("string_lettersdigits_test", function() {

		//string_lettersdigits test
		//show_debug_message("start string_lettersdigits() test");
			
		var vstring1 = "321!HeLlO WoRlD!123"
		var vstring2 = "!£水🙂"
		var vstring3 = ""
		var vstring4 = "abcd"
		var vstring5 = "1234"
			
		var res;
			
		//#1 string_lettersdigits( string local )
		res = string_lettersdigits(vstring1);
		assert_equals(res, "321HeLlOWoRlD123", "#1 string_lettersdigits( string local )");
			
		//#2 string_lettersdigits( string local ) - no letters
		res = string_lettersdigits(vstring2);
		assert_equals(res, "", "#2 string_lettersdigits( string local ) - no letters");
			
		//#3 string_lettersdigits( string local ) - empty string
		res = string_lettersdigits(vstring3);
		assert_equals(res, "", "#3 string_lettersdigits( string local ) - empty string");
			
		//#4 string_lettersdigits( string local ) - all letters
		res = string_lettersdigits(vstring4);
		assert_equals(res, "abcd", "#4 string_lettersdigits( string local ) - all letters");
			
		//#5 string_lettersdigits( string local ) - all digits
		res = string_lettersdigits(vstring5);
		assert_equals(res, "1234", "#5 string_lettersdigits( string local ) - all digits");
			
		//#6 string_lettersdigits( real const )
		res = string_lettersdigits(1234);
		assert_equals(res, "1234", "#6 string_lettersdigits( real const )");
			
		//#7 string_lettersdigits( real const )
		res = string_lettersdigits(1.234);
		assert_equals(res, "123", "#7 string_lettersdigits( real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
			
		#macro kString_StringLettersdigitsTest "321!Hello World!123"
		global.gstring = "321!Hello World!123";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "321!Hello World!123";
			
		//#8 string_lettersdigits( string macro )
		res = string_lettersdigits(kString_StringLettersdigitsTest);
		assert_equals(res, "321HelloWorld123", "#8 string_lettersdigits( string macro )")
			
		//#9 string_lettersdigits( string global )
		res = string_lettersdigits(global.gstring);
		assert_equals(res, "321HelloWorld123", "#9 string_lettersdigits( string global )")
			
		//#10 string_lettersdigits( string instance )
		res = string_lettersdigits(_oTest.ostring);
		assert_equals(res, "321HelloWorld123", "#10 string_lettersdigits( string instance )")
			
		instance_destroy(_oTest);
	})

	addFact("string_letters_test", function() {

		//string_letters test
		//show_debug_message("start string_letters() test");
			
		var vstring1 = "321!HeLlO WoRlD!123"
		var vstring2 = "!£水🙂"
		var vstring3 = ""
		var vstring4 = "abcd"
			
		var res;
			
		//#1 string_letters( string local )
		res = string_letters(vstring1);
		assert_equals(res, "HeLlOWoRlD", "#1 string_letters( string local )");
			
		//#2 string_letters( string local ) - no letters
		res = string_letters(vstring2);
		assert_equals(res, "", "#2 string_letters( string local ) - no letters");
			
		//#3 string_letters( string local ) - empty string
		res = string_letters(vstring3);
		assert_equals(res, "", "#3 string_letters( string local ) - empty string");
			
		//#4 string_letters( string local ) - all letters
		res = string_letters(vstring4);
		assert_equals(res, "abcd", "#4 string_letters( string local ) - all letters");
			
		//#5 string_letters( real const )
		res = string_letters(1234);
		assert_equals(res, "", "#5 string_letters( real const )");
			
		//#6 string_letters( real const )
		res = string_letters(1.234);
		assert_equals(res, "", "#6 string_letters( real const )");
			
			
		#macro kString_StringLettersTest "321!Hello World!123"
		global.gstring = "321!Hello World!123";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "321!Hello World!123";
			
		//#7 string_letters( string macro )
		res = string_letters(kString_StringLettersTest);
		assert_equals(res, "HelloWorld", "#7 string_letters( string macro )")
			
		//#8 string_letters( string global )
		res = string_letters(global.gstring);
		assert_equals(res, "HelloWorld", "#8 string_letters( string global )")
			
		//#9 string_letters( string instance )
		res = string_letters(_oTest.ostring);
		assert_equals(res, "HelloWorld", "#9 string_letters( string instance )")
			
			
		instance_destroy(_oTest)
	})

	addFact("string_lower_test", function() {

		//string_lower test
		//show_debug_message("start string_lower() test");
			
		var vstring = "HeLlO WoRlD!"
		var vstring2 = "!£水🙂"
			
		var res;
			
		//#1 string_lower( string local )
		res = string_lower(vstring);
		assert_equals(res, "hello world!", "#1 string_lower( string local )");
			
		//#2 string_lower( string local )
		res = string_lower(vstring2);
		assert_equals(res, "!£水🙂", "#2 string_lower( string local )");
			
		//#3 string_lower( string const ) - empty string
		res = string_lower("");
		assert_equals(res, "", "#3 string_lower( string const ) - empty string");
			
		//#4 string_lower( string const ) - single uppercase character
		res = string_lower("H");
		assert_equals(res, "h", "#4 string_lower( string const ) - single uppercase character");
			
		//#5 string_lower( string const ) - single lowercase character
		res = string_lower("h");
		assert_equals(res, "h", "#5 string_lower( string const ) - single lowercase character");
			
		//#6 string_lower( real local )
		res = string_lower(1234);
		assert_equals(res, "1234", "#6 string_lower( real local )");
			
		//#7 string_lower( real local )
		res = string_lower(1.234);
		assert_equals(res, "1.23", "#7 string_lower( real local )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#8 string_lower( real local )
		res = string_lower(int64(1234));
		assert_equals(res, "1234", "#8 string_lower( int64 local )");
			
		var u8001 = "老aA老aAa";
		var u8001Chr = string_lower(u8001);
		assert_equals(u8001Chr, "老aa老aaa", "#9 老aA老aAa to lower is 老aa老aaa");
			
		//show_debug_message("end string_lower() test");
	})

	addFact("string_ord_at_test", function() {

		//string_ord_at test
		//show_debug_message("start string_ord_at() test");
			
		var vstring = "hello World!"
			
		var res;
			
		//#1 string_ord_at( real local , real const )
		res = string_ord_at(vstring, 7);
		assert_equals(res, 87, "#1 string_ord_at( real local , real const )") // 'W'
			
		//#2 string_ord_at( real local , real const )
		res = string_ord_at(vstring, 7.6);
		assert_equals(res, 87, "#2 string_ord_at( real local , real const )") // 'W'
			
		//#3 string_ord_at( real local , real const )
		res = string_ord_at(vstring, 7.2);
		assert_equals(res, 87, "#3 string_ord_at( real local , real const )") // 'W'
			
		//#4 string_ord_at( real local , real const )
		res = string_ord_at(vstring, 0);
		assert_equals(res, 104, "#4 string_ord_at( real local , real const )") // 'h'
			
		//#5 string_ord_at( real local , real const )
		res = string_ord_at(vstring, 100);
		assert_equals(res, -1, "#5 string_ord_at( real local , real const )")
			
		//#6 string_ord_at( real local , real const )
		res = string_ord_at(vstring, -2);
		assert_equals(res, 104, "#6 string_ord_at( real local , real const )") // 'h'
			
			
		//#7 string_ord_at( int64 const , real const )
		res = string_ord_at(int64(1234), 2);
		assert_equals(res, 50, "#7 string_ord_at( int64 const , real const )") // '2'
			
		//#8 string_ord_at( real const , real const )
		res = string_ord_at(1.234, 2);
		assert_equals(res, 46, "#8 string_ord_at( real const , real const )") // '.'
			
		//#9 string_ord_at( bool const , real const )
		res = string_ord_at(true, 1);
		assert_equals(res, 49, "#9 string_ord_at( bool const , real const )") // '1'
			
			
		#macro kString_StringOrdAtTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#10 string_ord_at( string macro , real const )
		res = string_ord_at(kString_StringOrdAtTest, 7);
		assert_equals(res, 87, "#10 string_ord_at( string macro , real const )")
			
		//#11 string_ord_at( string global , real const )
		res = string_ord_at(global.gstring, 7);
		assert_equals(res, 87, "#11 string_ord_at( string global , real const )")
			
		//#12 string_ord_at( string instance , real const )
		res = string_ord_at(_oTest.ostring, 7);
		assert_equals(res, 87, "#12 string_ord_at( string instance , real const )")
			
			
		// UTF-8 tests 2/3/4 bytes
			
		//#13 string_ord_at( string const , real const )
		res = string_ord_at("!£水🙂a", 1);
		assert_equals(res, 33, "#13 string_ord_at( string const , real const )")
			
		//#14 string_ord_at( string const , real const )
		res = string_ord_at("!£水🙂a", 2);
		assert_equals(res, 163, "#14 string_ord_at( string const , real const )")
			
		//#15 string_ord_at( string const , real const )
		res = string_ord_at("!£水🙂a", 3);
		assert_equals(res, 27700, "#15 string_ord_at( string const , real const )")
			
		//#16 string_ord_at( string const , real const )
		res = string_ord_at("!£水🙂a", 4);
		assert_equals(res, 128578, "#16 string_ord_at( string const , real const )")
			
		//#17 string_ord_at( string const , real const )
		res = string_ord_at("!£水🙂a", 5);
		assert_equals(res, 97, "#17 string_ord_at( string const , real const )")
			
			
		instance_destroy(_oTest);
	})

	addFact("string_pos_ext_test", function() {

		// string_pos_ext test
		//show_debug_message("Begin string_pos_ext test");
			
		// Basic tests
		var helloWorldStr = "Hello world!Hello world!";
		var helloPos = string_pos_ext("Hello", helloWorldStr, 0);
		var worldPos = string_pos_ext("world", helloWorldStr, 0);
		var exclamationPos = string_pos_ext("!", helloWorldStr, 0);
		assert_equals(helloPos, 1, "#1.0 Hello Pos is 1 char in");
		assert_equals(worldPos, 7, "#1.1 World Pos is 7 char in");
		assert_equals(exclamationPos, 12, "#1.2 Exclamation is at 12 chars in");
		helloPos = string_pos_ext("Hello", helloWorldStr, 13);
		worldPos = string_pos_ext("world", helloWorldStr, 13);
		exclamationPos = string_pos_ext("!", helloWorldStr, 13);
		assert_equals(helloPos, 13, "#1.3 Hello Pos is 13 char in");
		assert_equals(worldPos, 19, "#1.4 World Pos is 19 char in");
		assert_equals(exclamationPos, 24, "#1.5 Exclamation is at 24 chars in");
			
		// Test zero
		var helloNil = string_pos_ext( "hello", helloWorldStr, 0);
		assert_equals(helloNil, 0, "#1.6 hello is not featured in the Hello world! string");
			
		// UTF8 tests
		var poundPrice = "£99.99";
		var poundPos = string_pos_ext("£", poundPrice,0);
		assert_equals(poundPos, 1, "#2.0 Pound glyph is the first char");
		var periodCharPos = string_pos_ext(".", poundPrice,0);
		assert_equals(periodCharPos, 4, "#2.1 Period char is the fourth character in poundPrice");
			
		var euroPrice = "€59.99";
		var euroPos = string_pos_ext("€", euroPrice,0);
		assert_equals(euroPos, 1, "#2.2 Euro glyph is the first char");
		var euroPeriodCharPos = string_pos_ext(".", euroPrice,0);
		assert_equals(euroPeriodCharPos, 4, "#2.4 Period char is the fourth character in euroPrice");
			
		var aikido = "合気道";
		var aiPos = string_pos_ext("合", aikido, 0);
		var kiPos = string_pos_ext("気", aikido, 0);
		var doPos = string_pos_ext("道", aikido, 0);
		assert_equals(aiPos, 1, "#2.5 Ai is the first char");
		assert_equals(kiPos, 2, "#2.6 Ki is the second char");
		assert_equals(doPos, 3, "#2.7 Do is the third char");
			
		var kotegaeshi = "小手返 Test";
		var kotegaeshiTestPos = string_pos_ext("Test", kotegaeshi, 0);
		assert_equals(kotegaeshiTestPos, 5, "#2.8 Test is 5 chars in");
			
		// Emoji!
		var smileyString = "This is a test 🙂";
		var smileyPos = string_pos_ext("🙂", smileyString, 0);
		assert_equals(smileyPos, 16, "#3.0 Smiley face is 16 chars in");
			
		var smileyPosLiteral = string_pos_ext("🙂", "This is a test 🙂", 0);
		assert_equals(smileyPosLiteral, 16, "#3.1 Smiley face is 16 chars in a literal string");
			
		var emojiString = "✔✔✔💩👏";
		var res = string_pos_ext("👏", emojiString, 0);
		assert_equals(res, 5, "#3.2 Clap emoji the 5th char");
			
		var moreEmojiString = "✔✔✔💩😀😁😂👏";
		res = string_pos_ext("👏", moreEmojiString, 0);
		assert_equals(res, 8, "#3.3 Clap emoji the 8th char");
			
		var emojiString3 = "✔✔✔💩😀aa😁😂👏";
		res = string_pos_ext("👏", emojiString3, 0);
		assert_equals(res, 10, "#3.4 Clap emoji the 10th char");
			
		var emojiString4 = "✔✔✔💩😀😁😂👏aa";
		res = string_pos_ext("aa", emojiString4, 0);
		assert_equals(res, 9, "#3.5 \"aa\" is the 9th and 10th char");
			
		//show_debug_message("End string_pos_ext test");
	})

	addFact("string_pos_test", function() {

		// string_pos test
		//show_debug_message("Begin string_pos test");
			
		// Basic tests
		var helloWorldStr = "Hello world!";
		var helloPos = string_pos("Hello", helloWorldStr);
		var worldPos = string_pos("world", helloWorldStr);
		var exclamationPos = string_pos("!", helloWorldStr);
		assert_equals(helloPos, 1, "Hello Pos is 1 char in");
		assert_equals(worldPos, 7, "World Pos is 7 char in");
		assert_equals(exclamationPos, 12, "Exclamation is at 12 chars in");
			
		// Test zero
		var helloNil = string_pos("hello", helloWorldStr);
		assert_equals(helloNil, 0, "hello is not featured in the Hello world! string");
			
		// UTF8 tests
		var poundPrice = "£99.99";
		var poundPos = string_pos("£", poundPrice);
		assert_equals(poundPos, 1, "Pound glyph is the first char");
		var periodCharPos = string_pos(".", poundPrice);
		assert_equals(periodCharPos, 4, "Period char is the fourth character in poundPrice");
			
		var euroPrice = "€59.99";
		var euroPos = string_pos("€", euroPrice);
		assert_equals(euroPos, 1, "Euro glyph is the first char");
		var euroPeriodCharPos = string_pos(".", euroPrice);
		assert_equals(euroPeriodCharPos, 4, "Period char is the fourth character in euroPrice");
			
		var aikido = "合気道";
		var aiPos = string_pos("合", aikido);
		var kiPos = string_pos("気", aikido);
		var doPos = string_pos("道", aikido);
		assert_equals(aiPos, 1, "Ai is the first char");
		assert_equals(kiPos, 2, "Ki is the second char");
		assert_equals(doPos, 3, "Do is the third char");
			
		var kotegaeshi = "小手返 Test";
		var kotegaeshiTestPos = string_pos("Test", kotegaeshi);
		assert_equals(kotegaeshiTestPos, 5, "Test is 5 chars in");
			
		// Emoji!
		var smileyString = "This is a test 🙂";
		var smileyPos = string_pos("🙂", smileyString);
		assert_equals(smileyPos, 16, "Smiley face is 16 chars in");
			
		var smileyPosLiteral = string_pos("🙂", "This is a test 🙂");
		assert_equals(smileyPosLiteral, 16, "Smiley face is 16 chars in a literal string");
			
		var emojiString = "✔✔✔💩👏";
		var res = string_pos("👏", emojiString);
		assert_equals(res, 5, "Clap emoji the 5th char");
			
		var moreEmojiString = "✔✔✔💩😀😁😂👏";
		res = string_pos("👏", moreEmojiString);
		assert_equals(res, 8, "Clap emoji the 8th char");
			
		var emojiString3 = "✔✔✔💩😀aa😁😂👏";
		res = string_pos("👏", emojiString3);
		assert_equals(res, 10, "Clap emoji the 10th char");
			
		var emojiString4 = "✔✔✔💩😀😁😂👏aa";
		res = string_pos("aa", emojiString4);
		assert_equals(res, 9, "\"aa\" is the 9th and 10th char");
			
		//show_debug_message("End string_pos test");
	})

	addFact("string_repeat_test", function() {

		//string_repeat test
		//show_debug_message("start string_repeat() test");
			
		var vstring1 = "HeLlO WoRlD!"
		var vstring2 = "!£水🙂"
		var vstring3 = ""
			
		var res;
			
		//#1 string_repeat( string local , real const )
		res = string_repeat(vstring1, 2);
		assert_equals(res, "HeLlO WoRlD!HeLlO WoRlD!", "#1 string_repeat( string local , real const )");
			
		//#2 string_repeat( string local , real const )
		res = string_repeat(vstring2, 2);
		assert_equals(res, "!£水🙂!£水🙂", "#2 string_repeat( string local , real const )");
			
		//#3 string_repeat( string local , real const ) - empty string
		res = string_repeat(vstring3, 2);
		assert_equals(res, "", "#3 string_repeat( string local , real const ) - empty string");
			
		//#4 string_repeat( real const , real const )
		res = string_repeat(1234, 2);
		assert_equals(res, "12341234", "#4 string_repeat( real local , real const )");
			
		//#5 string_repeat( real const , real const )
		res = string_repeat(1.234, 2);
		assert_equals(res, "1.231.23", "#5 string_repeat( real local , real const )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#6 string_repeat( string local , real const ) - one count
		res = string_repeat(vstring1, 1);
		assert_equals(res, "HeLlO WoRlD!", "#6 string_repeat( string local , real const )");
			
		//#7 string_repeat( string local , real const ) - zero count
		res = string_repeat(vstring1, 0);
		assert_equals(res, "", "#7 string_repeat( string local , real const )");
			
		//#8 string_repeat( string local , real const ) - negative count
		res = string_repeat(vstring1, -1);
		assert_equals(res, "", "#8 string_repeat( string local , real const )");
			
		#macro kString_StringRepeatTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#19 string_repeat( string macro , real const )
		res = string_repeat(kString_StringRepeatTest, 3);
		assert_equals(res, "Hello World!Hello World!Hello World!", "#19 string_repeat( string macro , real const )")
			
		//#20 string_repeat( string global , real const )
		res = string_repeat(global.gstring, 3);
		assert_equals(res, "Hello World!Hello World!Hello World!", "#20 string_repeat( string global , real const )")
			
		//#21 string_repeat( string instance , real const )
		res = string_repeat(_oTest.ostring, 3);
		assert_equals(res, "Hello World!Hello World!Hello World!", "#21 string_repeat( string instance , real const )")
			
			
		instance_destroy(_oTest);
	})

	addFact("string_replace_all_test", function() {

		//string_replace_all test
		//show_debug_message("start string_replace_all() test");
			
		var res;
			
		//#1 string_replace_all( string const , string const , string const )
		res = string_replace_all("Hello Earth!", "Earth", "World");
		assert_equals(res, "Hello World!", "#1 string_replace_all( string const , string const , string const )")
			
		//#2 string_replace_all( string const , string const , string const )
		res = string_replace_all("Hello Earth!Earth", "Earth", "World");
		assert_equals(res, "Hello World!World", "#2 string_replace_all( string const , string const , string const )")
			
		//#3 string_replace_all( string const , string const , string const )
		res = string_replace_all("Hello EarthEarthEarthEarthEarthEarthEarth", "Earth", "World");
		assert_equals(res, "Hello WorldWorldWorldWorldWorldWorldWorld", "#3 string_replace_all( string const , string const , string const )")
			
		//#4 string_replace_all( string const , string const , string const ) - empty replacement string
		res = string_replace_all("Hello Earth!Earth", "Earth", "");
		assert_equals(res, "Hello !", "#4 string_replace_all( string const , string const , string const ) - empty replacement string")
			
		//#5 string_replace_all( string const , string const , string const ) - empty search pattern
		res = string_replace_all("Hello Earth!Earth", "", "World");
		assert_equals(res, "Hello Earth!Earth", "#5 string_replace_all( string const , string const , string const ) - empty search pattern")
			
		//#6 string_replace_all( string const , string const , real const )
		res = string_replace_all("Hello Earth!Earth", "Earth", 1234);
		assert_equals(res, "Hello 1234!1234", "#6 string_replace_all( string const , string const , real const )")
			
		//#7 string_replace_all( string const , string const , real const )
		res = string_replace_all("Hello Earth!Earth", "Earth", 1.234);
		assert_equals(res, "Hello 1.23!1.23", "#7 string_replace_all( string const , string const , real const )")
			
		//#8 string_replace_all( string const , string const , real const )
		res = string_replace_all("Hello Earth!Earth", "Earth", int64(1234));
		assert_equals(res, "Hello 1234!1234", "#8 string_replace_all( string const , string const , real const )")
			
		//#9 string_replace_all( string const , string const , string const ) - empty source strings
		res = string_replace_all("", "two", "three");
		assert_equals(res, "", "#9 string_replace_all( string const , string const , string const ) - empty source strings")
			
		//#10 string_replace_all( string const , string const , string const ) - all empty strings
		res = string_replace_all("", "", "");
		assert_equals(res, "", "#10 string_replace_all( string const , string const , string const ) - all empty strings")
			
			
		var vstring = "Hello EarthEarth!";
		#macro kString_StringReplaceAllTest "Hello EarthEarth!"
		global.gstring = "Hello EarthEarth!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello EarthEarth!";
			
		//#11 string_replace_all( string local , string const , string const )
		res = string_replace_all(vstring, "Earth", "World");
		assert_equals(res, "Hello WorldWorld!", "#11 string_replace_all( string local , string const , string const )")
			
		//#12 string_replace_all( string macro , string const , string const )
		res = string_replace_all(kString_StringReplaceAllTest, "Earth", "World");
		assert_equals(res, "Hello WorldWorld!", "#12 string_replace_all( string macro , string const , string const )")
			
		//#13 string_replace_all( string global , string const , string const )
		res = string_replace_all(global.gstring, "Earth", "World");
		assert_equals(res, "Hello WorldWorld!", "#13 string_replace_all( string global , string const , string const )")
			
		//#14 string_replace_all( string instance , string const , string const )
		res = string_replace_all(_oTest.ostring, "Earth", "World");
		assert_equals(res, "Hello WorldWorld!", "#14 string_replace_all( string instance , string const , string const )")
			
			
			
			
			
		//#15 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 1 byte UTF-8 char
		res = string_replace_all("!£水🙂", "!", "A");
		assert_equals(res, "A£水🙂", "#15 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 1 byte UTF-8 char")
			
		//#16 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 2 byte UTF-8 char
		res = string_replace_all("!£水🙂", "!", "£");
		assert_equals(res, "££水🙂", "#16 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 2 byte UTF-8 char")
			
		//#17 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 3 byte UTF-8 char
		res = string_replace_all("!£水🙂", "!", "水");
		assert_equals(res, "水£水🙂", "#17 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 3 byte UTF-8 char")
			
		//#18 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 4 byte UTF-8 char
		res = string_replace_all("!£水🙂", "!", "🙂");
		assert_equals(res, "🙂£水🙂", "#18 string_replace_all( string const , string const , string const ) - replace 1 byte UTF-8 char with 4 byte UTF-8 char")
			
			
		//#19 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 1 byte UTF-8 char
		res = string_replace_all("!£水🙂", "£", "A");
		assert_equals(res, "!A水🙂", "#19 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 1 byte UTF-8 char")
			
		//#20 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 2 byte UTF-8 char
		res = string_replace_all("!£水🙂", "£", "€");
		assert_equals(res, "!€水🙂", "#20 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 2 byte UTF-8 char")
			
		//#21 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 3 byte UTF-8 char
		res = string_replace_all("!£水🙂", "£", "水");
		assert_equals(res, "!水水🙂", "#21 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 3 byte UTF-8 char")
			
		//#22 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 4 byte UTF-8 char
		res = string_replace_all("!£水🙂", "£", "🙂");
		assert_equals(res, "!🙂水🙂", "#22 string_replace_all( string const , string const , string const ) - replace 2 byte UTF-8 char with 4 byte UTF-8 char")
			
			
		//#23 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 1 byte UTF-8 char
		res = string_replace_all("!£水🙂", "水", "A");
		assert_equals(res, "!£A🙂", "#23 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 1 byte UTF-8 char")
			
		//#24 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 2 byte UTF-8 char
		res = string_replace_all("!£水🙂", "水", "£");
		assert_equals(res, "!££🙂", "#24 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 2 byte UTF-8 char")
			
		//#25 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 3 byte UTF-8 char
		res = string_replace_all("!£水🙂", "水", "月");
		assert_equals(res, "!£月🙂", "#25 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 3 byte UTF-8 char")
			
		//#26 string_replace_all( string const , string const , string const ) - replace 3 byte UTF-8 char with 4 byte UTF-8 char
		res = string_replace_all("!£水🙂", "水", "🙂");
		assert_equals(res, "!£🙂🙂", "#26 string_replace_all( string const , string const , string const ) - all empty strings - replace 3 byte UTF-8 char with 4 byte UTF-8 char")
			
			
		//#27 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 1 byte UTF-8 char
		res = string_replace_all("!£水🙂", "🙂", "A");
		assert_equals(res, "!£水A", "#27 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 1 byte UTF-8 char")
			
		//#28 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 2 byte UTF-8 char
		res = string_replace_all("!£水🙂", "🙂", "£");
		assert_equals(res, "!£水£", "#28 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 2 byte UTF-8 char")
			
		//#29 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 3 byte UTF-8 char
		res = string_replace_all("!£水🙂", "🙂", "水");
		assert_equals(res, "!£水水", "#29 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 3 byte UTF-8 char")
			
		//#30 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 4 byte UTF-8 char
		res = string_replace_all("!£水🙂", "🙂", "😢");
		assert_equals(res, "!£水😢", "#30 string_replace_all( string const , string const , string const ) - replace 4 byte UTF-8 char with 4 byte UTF-8 char")
			
			
		//#31 string_replace_all( string const , string const , string const ) - empty replace string
		res = string_replace_all("!£水🙂", "!£水🙂", "");
		assert_equals(res, "", "#31 string_replace_all( string const , string const , string const ) - empty replace string")
			
		//#32 string_replace_all( string const , string const , string const ) - empty replace string (multiple instances)
		res = string_replace_all("!£水🙂!!£水🙂!£水🙂", "!£水🙂", "");
		assert_equals(res, "!", "#32 string_replace_all( string const , string const , string const ) - empty replace string (multiple instances)")
			
		//#33 string_replace_all( string const , string const , string const ) - replace 1 byte + 2 byte string with 3byte + 4 byte string
		res = string_replace_all("!£水🙂!!£水🙂", "!£", "水🙂");
		assert_equals(res, "水🙂水🙂!水🙂水🙂", "#33 string_replace_all( string const , string const , string const ) - replace 1 byte + 2 byte string with 3byte + 4 byte string")
			
			
		instance_destroy(_oTest);
	})

	addFact("string_replace_test", function() {

		//string_replace test
		//show_debug_message("start string_replace() test");
			
		var res;
			
		//#1 string_replace( string const , string const , string const )
		res = string_replace("Hello Earth!", "Earth", "World");
		assert_equals(res, "Hello World!", "#1 string_replace( string const , string const , string const )")
			
		//#2 string_replace( string const , string const , string const )
		res = string_replace("Hello Earth!Earth", "Earth", "World");
		assert_equals(res, "Hello World!Earth", "#2 string_replace( string const , string const , string const )")
			
		//#3 string_replace( string const , string const , string const )
		res = string_replace("Hello Earth!Earth", "Earth", "World");
		res = string_replace(res, "Earth", "World");
		assert_equals(res, "Hello World!World", "#3 string_replace( string const , string const , string const )")
			
		//#4 string_replace( string const , string const , string const ) - empty replacement string
		res = string_replace("Hello Earth!Earth", "Earth", "");
		assert_equals(res, "Hello !Earth", "#4 string_replace( string const , string const , string const ) - empty replacement string")
			
		//#5 string_replace( string const , string const , string const ) - empty search pattern
		res = string_replace("Hello Earth!Earth", "", "World");
		assert_equals(res, "Hello Earth!Earth", "#5 string_replace( string const , string const , string const ) - empty search pattern")
			
		//#7 string_replace( string const , string const , real const )
		res = string_replace("Hello Earth!Earth", "Earth", 1234);
		assert_equals(res, "Hello 1234!Earth", "#6 string_replace( string const , string const , real const )")
			
		//#8 string_replace( string const , string const , real const )
		res = string_replace("Hello Earth!Earth", "Earth", 1.234);
		assert_equals(res, "Hello 1.23!Earth", "#7 string_replace( string const , string const , real const )")
			
		//#9 string_replace( string const , string const , real const )
		res = string_replace("Hello Earth!Earth", "Earth", int64(1234));
		assert_equals(res, "Hello 1234!Earth", "#8 string_replace( string const , string const , real const )")
			
		//#10 string_replace( string const , string const , string const ) - empty source strings
		res = string_replace("", "two", "three");
		assert_equals(res, "", "#9 string_replace( string const , string const , string const ) - empty source strings")
			
		//#11 string_replace( string const , string const , string const ) - all empty strings
		res = string_replace("", "", "");
		assert_equals(res, "", "#10 string_replace( string const , string const , string const ) - all empty strings")
			
			
		var vstring = "Hello Earth!";
		#macro kString_StringReplaceTest "Hello Earth!"
		global.gstring = "Hello Earth!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello Earth!";
			
		//#12 string_replace( string local , string const , string const )
		res = string_replace(vstring, "Earth", "World");
		assert_equals(res, "Hello World!", "#11 string_replace( string local , string const , string const )")
			
		//#13 string_replace( string macro , string const , string const )
		res = string_replace(kString_StringReplaceTest, "Earth", "World");
		assert_equals(res, "Hello World!", "#12 string_replace( string macro , string const , string const )")
			
		//#14 string_replace( string global , string const , string const )
		res = string_replace(global.gstring, "Earth", "World");
		assert_equals(res, "Hello World!", "#13 string_replace( string global , string const , string const )")
			
		//#15 string_replace( string instance , string const , string const )
		res = string_replace(_oTest.ostring, "Earth", "World");
		assert_equals(res, "Hello World!", "#14 string_replace( string instance , string const , string const )")
			
		var string1 = "🙂";
		var string2 = "😬";
		res = string_replace(string1, "🙂", string2);
		assert_equals(res, "😬", "Replace smiley face with a grimace");
			
		var longSmileyString = "The quick brown 🙂 jumped over the lazy dog!";
		res = string_replace(longSmileyString, "🙂", "fox");
		assert_equals(res, "The quick brown fox jumped over the lazy dog!", "Replacing a smiley with a string of chars");
			
		var longFoxString = "The quick brown fox jumped over the lazy dog!";
		res = string_replace(longFoxString, "fox", "🙂");
		assert_equals(res, "The quick brown 🙂 jumped over the lazy dog!", "Replacing a string of chars with a smiley face");
			
		instance_destroy(_oTest);
	})

	addFact("string_set_byte_at_failure_test_1", function() {

		//string_set_byte_at failure test
		assert_throw(function() {
			return string_set_byte_at("hello", 100, 87); // 'W'
		}, "#1 Using 'string_set_byte_at' with out of range index (should throw error)");
	
	})

	addFact("string_set_byte_at_failure_test_2", function() {

		//string_set_byte_at failure test
		assert_throw(function() {
			return string_set_byte_at("hello", -2, 87); // 'W'
		}, "#1 Using 'string_set_byte_at' with negative index (should throw error)");
	})

	addFact("string_set_byte_at_failure_test_3", function() {

		//string_set_byte_at failure test
		assert_throw(function() {
			return string_set_byte_at("hello", 0, 87); // 'W'
		}, "#1 Using 'string_set_byte_at' with index 0 (should throw error)");
	})

	addFact("string_set_byte_at_test", function() {

		//string_set_byte_at test
		//show_debug_message("start string_set_byte_at() test");
			
		var vstring = "hello Porld!"
			
		var res;
			
			
		//#1 string_set_byte_at( string local , real const , real const )
		res = string_set_byte_at(vstring, 7, 87); // 'W'
		assert_equals(res, "hello World!", "#1 string_set_byte_at( string local , real const , real const )")
			
		//#2 string_set_byte_at( string local , real const , real const )
		res = string_set_byte_at(vstring, 7.6, 87); // 'W'
		assert_equals(res, "hello World!", "#2 string_set_byte_at( rstrstringingeal local , real const , real const )")
			
		//#3 string_set_byte_at( string local , real const , real const )
		res = string_set_byte_at(vstring, 7.2, 87); // 'W'
		assert_equals(res, "hello World!", "#3 string_set_byte_at( string local , real const , real const )")
			
			
		//#4 string_set_byte_at( int64 local , real const , real const )
		res = string_set_byte_at(int64(1234), 2, 32); // ' '
		assert_true(is_string(res), "#4 string_set_byte_at( int64 local , real const , real const )")
		assert_equals(res, "1 34", "#4 string_set_byte_at( int64 local , real const , real const )")
			
		//#5 string_set_byte_at( real local , real const , real const )
		res = string_set_byte_at(1.234, 2, 32); // ' '
		assert_true(is_string(res), "#5 string_set_byte_at( real local , real const , real const )")
		assert_equals(res, "1 23", "#5 string_set_byte_at( real local , real const , real const )") // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#6 string_set_byte_at( bool local , real const , real const )
		res = string_set_byte_at(true, 1, 32); // ' '
		assert_true(is_string(res), "#6 string_set_byte_at( bool local , real const , real const )")
		assert_equals(res, " ", "#6 string_set_byte_at( bool local , real const , real const )")
			
			
		//#7 string_set_byte_at( string const , real const , real const ) - int larger than char
		res = string_set_byte_at("Eyup World", 7, 2080); // 100000100000 -> cast to char -> 00100000 -> 32 -> ' '
		assert_true(is_string(res), "#7 string_set_byte_at( string const , real const , real const )")
		assert_equals(res,"Eyup W rld", "#7 string_set_byte_at( string const , real const , real const )")
			
		//#8 string_set_byte_at( string const , real const , string const )
		res = string_set_byte_at("Eyup World", 7, "32"); // ' '
		assert_true(is_string(res), "#8 string_set_byte_at( string const , real const , string const )")
		assert_equals(res,"Eyup W rld", "#8 string_set_byte_at( string const , real const , string const )")
			
		if(browser_not_a_browser)
		{
			//#9 string_set_byte_at( string local , real const , real const )
			var twoByteUTF8 = "£";
			res = string_set_byte_at(twoByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#9 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#9 string_set_byte_at( string local , real const , real const )")
			
			//#10 string_set_byte_at( string local , real const , real const )
			var threeByteUTF8 = "小";
			res = string_set_byte_at(threeByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#10 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#10 string_set_byte_at( string local , real const , real const )")
			
			//#11 string_set_byte_at( string local , real const , real const )
			var fourByteUTF8 = "🙂";
			res = string_set_byte_at(fourByteUTF8, 2, 87); // 'W'
			assert_true(is_string(res), "#11 string_set_byte_at( string local , real const , real const )")
			assert_equals(string_byte_at(res, 2), 87, "#11 string_set_byte_at( string local , real const , real const )")
			
			//#12 string_set_byte_at( string const , real const , real const ) - set bytes to create utf-8 4-byte char
			res = "xxxx";
			res = string_set_byte_at(res, 1, 240);
			res = string_set_byte_at(res, 2, 159);
			res = string_set_byte_at(res, 3, 152);
			res = string_set_byte_at(res, 4, 131);
			assert_true(is_string(res), "#12 string_set_byte_at( string const , real const , real const )")
			assert_equals(res, "😃", "#12 string_set_byte_at( string const , real const , real const )")
		}
			
		#macro kString_StringSetByteAtTest "Hello World!"
		global.gstring = "Hello World!";
		var _oTest = instance_create_depth(0, 0, 0, oTest);
		_oTest.ostring = "Hello World!";
			
		//#13 string_set_byte_at( string macro , real const )
		res = string_set_byte_at(kString_StringSetByteAtTest, 2, 87);
		assert_true(is_string(res), "#13 string_set_byte_at( string macro , real const , real const )")
		assert_equals(string_byte_at(res, 2), 87, "#13 string_set_byte_at( string macro , real const , real const )")
			
		//#14 string_set_byte_at( string global , real const )
		res = string_set_byte_at(global.gstring, 2, 87);
		assert_true(is_string(res), "#14 string_set_byte_at( string global , real const , real const )")
		assert_equals(string_byte_at(res, 2), 87, "#14 string_set_byte_at( string global , real const , real const )")
			
		//#15 string_set_byte_at( string instance , real const )
		res = string_set_byte_at(_oTest.ostring, 2, 87);
		assert_true(is_string(res), "#15 string_set_byte_at( string instance , real const , real const )")
		assert_equals(string_byte_at(res, 2), 87, "#15 string_set_byte_at( string instance , real const , real const )")
			
			
		instance_destroy(_oTest);
	})

	addFact("string_upper_test", function() {

		//string_upper test
		//show_debug_message("start string_upper() test");
			
		var vstring = "HeLlO WoRlD!"
		var vstring2 = "!£水🙂"
			
		var res;
			
		//#1 string_upper( string local )
		res = string_upper(vstring);
		assert_equals(res, "HELLO WORLD!", "#1 string_upper( string local )");
			
		//#2 string_upper( string local )
		res = string_upper(vstring2);
		assert_equals(res, "!£水🙂", "#2 string_upper( string local )");
			
		//#3 string_upper( string const ) - empty string
		res = string_upper("");
		assert_equals(res, "", "#3 string_upper( string const ) - empty string");
			
		//#4 string_upper( string const ) - single lowercase character
		res = string_upper("h");
		assert_equals(res, "H", "#4 string_upper( string const ) - single lowercase character");
			
		//#5 string_upper( string const ) - single uppercase character
		res = string_upper("H");
		assert_equals(res, "H", "#5 string_upper( string const ) - single uppercase character");
			
		//#6 string_upper( real local )
		res = string_upper(1234);
		assert_equals(res, "1234", "#6 string_upper( real local )");
			
		//#7 string_upper( real local )
		res = string_upper(1.234);
		assert_equals(res, "1.23", "#7 string_upper( real local )"); // Note: truncated to 2 decimal place string before byte set, hence '4' is dropped from string
			
		//#8 string_upper( real local )
		res = string_upper(int64(1234));
		assert_equals(res, "1234", "#8 string_upper( int64 local )");
			
		var u8001 = "老Aa老AaA";
		var u8001Chr = string_upper(u8001);
		assert_equals(u8001Chr, "老AA老AAA", "#9 老Aa老AaA upper is 老AA老AAA");
			
		//show_debug_message("end string_upper() test");
	})
	
	addFact("string", function() {
		
		var _format = "{0} {1} {2}";
		var _result = string(_format, 12, "hello", []);
		assert_equals(_result, "12 hello [  ]", "#1 string : failed to correctly _format a string with mixed types");
		
		_format = "{0} {1}";
		_result = string(_format, 12, "hello", []);
		assert_equals(_result, "12 hello", "#2 string : failed to correctly _format a string with less placeholders than arguments");
		
		_format = "{0} {1} {2} {3}";
		_result = string(_format, 12, "hello", []);
		assert_equals(_result, "12 hello [  ] {3}", "#3 string : failed to correctly _format a string with more placeholders than arguments");
		
		_format = "{0} {1} {2} {0} {1} {2}";
		_result = string(_format, 12, "hello", []);
		assert_equals(_result, "12 hello [  ] 12 hello [  ]", "#4 string : failed to correctly _format a string with repeated placeholders");
		
		_format = "{0}{1}";
		_result = string(_format, "合気道合", "気道合気道合気道");
		assert_equals(_result, "合気道合気道合気道合気道", "#5 string : failed to correctly _format a string with non-latin characters");
		
		_format = "{0} {1} {2} {3}";
		_result = string(_format, "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", "#6 string : failed to correctly _format a string with emoji characters");		

	})
	
	addFact("string_ext", function() {

		var _format = "{0} {1} {2}";
		var _result = string_ext(_format, [12, "hello", []]);
		assert_equals(_result, "12 hello [  ]", "#1 string_ext : failed to correctly _format a string with mixed types");
		
		_format = "{0} {1}";
		_result = string_ext(_format, [12, "hello", []]);
		assert_equals(_result, "12 hello", "#2 string_ext : failed to correctly _format a string with less placeholders than arguments");
		
		_format = "{0} {1} {2} {3}";
		_result = string_ext(_format, [12, "hello", []]);
		assert_equals(_result, "12 hello [  ] {3}", "#3 string_ext : failed to correctly _format a string with more placeholders than arguments");
		
		_format = "{0} {1} {2} {0} {1} {2}";
		_result = string_ext(_format, [12, "hello", []]);
		assert_equals(_result, "12 hello [  ] 12 hello [  ]", "#4 string_ext : failed to correctly _format a string with repeated placeholders");
		
		_format = "{0}{1}";
		_result = string_ext(_format, ["合気道合", "気道合気道合気道"]);
		assert_equals(_result, "合気道合気道合気道合気道", "#5 string_ext : failed to correctly _format a string with non-latin characters");
		
		_format = "{0} {1} {2} {3}";
		_result = string_ext(_format, ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎 👣💎🎤🌊💎🕥🌑👵🎿 🎐📪👺🌸🍓 💎", "#6 string_ext : failed to correctly _format a string with emoji characters");		
	
	})

	addFact("string_concat", function() {
		
		var _result = string_concat(12, "hello", []);
		assert_equals(_result, "12hello[  ]", "#1 string_concat : failed to correctly concat a string with mixed types");
		
		_result = string_concat("合気道合", "気道合気道合気道");
		assert_equals(_result, "合気道合気道合気道合気道", "#2 string_concat : failed to correctly concat a string with non-latin characters");
		
		_result = string_concat("🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎", "#3 string_concat : failed to correctly concat a string with emoji characters");		

	})
	
	addFact("string_concat_ext", function() {

		var _result = string_concat_ext([12, "hello", []]);
		assert_equals(_result, "12hello[  ]", "#1 string_concat_ext : failed to correctly concat a string with mixed types");
		
		_result = string_concat_ext(["合気道合", "気道合気道合気道"]);
		assert_equals(_result, "合気道合気道合気道合気道", "#2 string_concat_ext : failed to correctly concat a string with non-latin characters");
		
		_result = string_concat_ext(["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎👣💎🎤🌊💎🕥🌑👵🎿🎐📪👺🌸🍓💎", "#3 string_concat_ext : failed to correctly concat a string with emoji characters");		

	})
	
	addFact("string_join", function() {
		
		var _result = string_join(",", 12, "hello", []);
		assert_equals(_result, "12,hello,[  ]", "#1 string_join : failed to correctly join a string with mixed types, using a comma.");
		
		_result = string_join(",", "合気道合", "気道合気道合気道");
		assert_equals(_result, "合気道合,気道合気道合気道", "#2 string_join : failed to correctly join a string with non-latin characters, using a comma");
		
		_result = string_join(",", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", "#3 string_join : failed to correctly join a string with emoji characters, using a comma");
		
		_result = string_join("道", 12, "hello", []);
		assert_equals(_result, "12道hello道[  ]", "#4 string_join : failed to correctly join a string with mixed types, using a non-latin character.");
		
		_result = string_join("道", "合気道合", "気道合気道合気道");
		assert_equals(_result, "合気道合道気道合気道合気道", "#5 string_join : failed to correctly join a string with non-latin characters, using a non-latin character.");
		
		_result = string_join("道", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", "#6 string_join : failed to correctly join a string with emoji characters, using a non-latin character.");
		
		_result = string_join("🙂", 12, "hello", []);
		assert_equals(_result, "12🙂hello🙂[  ]", "#7 string_join : failed to correctly join a string with mixed types, using an emoji character.");
		
		_result = string_join("🙂", "合気道合", "気道合気道合気道");
		assert_equals(_result, "合気道合🙂気道合気道合気道", "#8 string_join : failed to correctly join a string with non-latin characters, using an emoji character.");
		
		_result = string_join("🙂", "🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎");
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", "#9 string_join : failed to correctly join a string with emoji characters, using an emoji character.");
		
	})
	
	addFact("string_join_ext", function() {

		var _result = string_join_ext(",", [12, "hello", []]);
		assert_equals(_result, "12,hello,[  ]", "#1 string_join_ext : failed to correctly join a string with mixed types, using a comma.");
		
		_result = string_join_ext(",", ["合気道合", "気道合気道合気道"]);
		assert_equals(_result, "合気道合,気道合気道合気道", "#2 string_join_ext : failed to correctly join a string with non-latin characters, using a comma");
		
		_result = string_join_ext(",", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎,👣💎🎤🌊💎🕥🌑👵🎿,🎐📪👺🌸🍓,💎", "#3 string_join_ext : failed to correctly join a string with emoji characters, using a comma");
		
		_result = string_join_ext("道", [12, "hello", []]);
		assert_equals(_result, "12道hello道[  ]", "#4 string_join_ext : failed to correctly join a string with mixed types, using a non-latin character.");
		
		_result = string_join_ext("道", ["合気道合", "気道合気道合気道"]);
		assert_equals(_result, "合気道合道気道合気道合気道", "#5 string_join_ext : failed to correctly join a string with non-latin characters, using a non-latin character.");
		
		_result = string_join_ext("道", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎道👣💎🎤🌊💎🕥🌑👵🎿道🎐📪👺🌸🍓道💎", "#6 string_join_ext : failed to correctly join a string with emoji characters, using a non-latin character.");
		
		_result = string_join_ext("🙂", [12, "hello", []]);
		assert_equals(_result, "12🙂hello🙂[  ]", "#7 string_join_ext : failed to correctly join a string with mixed types, using an emoji character.");
		
		_result = string_join_ext("🙂", ["合気道合", "気道合気道合気道"]);
		assert_equals(_result, "合気道合🙂気道合気道合気道", "#8 string_join_ext : failed to correctly join a string with non-latin characters, using an emoji character.");
		
		_result = string_join_ext("🙂", ["🏡🔠👸👟🕔🕝💎", "👣💎🎤🌊💎🕥🌑👵🎿", "🎐📪👺🌸🍓", "💎"]);
		assert_equals(_result, "🏡🔠👸👟🕔🕝💎🙂👣💎🎤🌊💎🕥🌑👵🎿🙂🎐📪👺🌸🍓🙂💎", "#9 string_join_ext : failed to correctly join a string with emoji characters, using an emoji character.");

	})
	
	addFact("string_split", function() {
	
		var _input = "hello,great,world";
		var _result = string_split(_input, ",", true);
		assert_array_length(_result, 3, "#1 string_split : failed to correctly split string into correct number of elements.");
		
		assert_array_equals(_result, ["hello", "great", "world"],"#2 string_split : failed to correctly split string with latin characters.");
		
		_input = "1test\n2test,\n3test,,,,\n4test\n5test。\n6test，\n7test，，\n8test\n9test"
		_result = string_split(_input, "\n", true);
		assert_array_length(_result, 9, "#3 string_split : failed to correctly split string into correct number of elements.");
		
		assert_array_equals(_result, ["1test", "2test,", "3test,,,,", "4test", "5test。", "6test，", "7test，，", "8test", "9test"],
			"#4 string_split : failed to correctly split string with non-latin characters.");
			
	})
	
	addFact("string_split_ext", function() {
	
		var _input = "hello,great,world";
		var _result = string_split_ext(_input, [",", "l"], false);
		assert_array_length(_result, 6, "#1 string_split_ext : failed to correctly split string into correct number of elements.");
		
		assert_array_equals(_result, ["he", "", "o", "great", "wor", "d"],"#2 string_split_ext : failed to correctly split string with latin characters.");
		
		
		_input = "hello,great,world";
		_result = string_split_ext(_input, [",", "l"], true);
		assert_array_length(_result, 5, "#3 string_split_ext : failed to correctly split string into correct number of elements (remove empty).");
		
		assert_array_equals(_result, ["he", "o", "great", "wor", "d"],"#4 string_split_ext : failed to correctly split string with latin characters.");
		

		_input = "hello,great,world";
		_result = string_split_ext(_input, [",", "l"], false, 3);
		assert_array_length(_result, 4, "#5 string_split_ext : failed to correctly split string into correct number of elements (max splits).");
		
		assert_array_equals(_result, ["he", "", "o", "great,world"],"#6 string_split_ext : failed to correctly split string with latin characters.");
	
	})
	
	addFact("string_starts_with", function() {
	
		var _input = "hello world";
		var _result = string_starts_with(_input, "hello");
		assert_true(_result, "#1 string_starts_with : failed to correctly detect start of the string, latin characters");
		
		_input = "🏡🔠👸👟🕔🕝💎"
		_result = string_starts_with(_input, "🏡🔠👸");
		assert_true(_result, "#2 string_starts_with : failed to correctly detect start of the string, emoji characters");
	
	})
	
	addFact("string_ends_with", function() {
	
		var _input = "hello world";
		var _result = string_ends_with(_input, "world");
		assert_true(_result, "#1 string_ends_with : failed to correctly detect end of the string, latin characters");
		
		_input = "🏡🔠👸👟🕔🕝💎"
		_result = string_ends_with(_input, "🕔🕝💎");
		assert_true(_result, "#2 string_ends_with : failed to correctly detect end of the string, emoji characters");
	
	})
		
	addFact("string_trim_start", function() {
		
		var _input = "		 	sometext				";
		var _result = string_trim_start(_input);
		assert_equals(_result, "sometext				", "#1 string_trim_start : failed to correctly trim the start of the string, latin characters");
		
		_input = "                  秧秧秧秧秧秧秧秧                  ";
		_result = string_trim_start(_input);
		assert_equals(_result, "秧秧秧秧秧秧秧秧                  ", "#2 string_trim_start : failed to correctly trim the start of the string, non-latin characters");
		
	})
	
	addFact("string_trim_end", function() {
	
		var _input = "		 	sometext				";
		var _result = string_trim_end(_input);
		assert_equals(_result, "		 	sometext", "#1 string_trim_end : failed to correctly trim the end of the string, latin characters");
		
		_input = "                  秧秧秧秧秧秧秧秧                  ";
		_result = string_trim_end(_input);
		assert_equals(_result, "                  秧秧秧秧秧秧秧秧", "#2 string_trim_end : failed to correctly trim the end of the string, non-latin characters");
	
	})
	
	addFact("string_trim", function() {
	
		var _input = "		 	sometext				";
		var _result = string_trim(_input);
		assert_equals(_result, "sometext", "#1 string_trim_end : failed to correctly trim the string, latin characters");
		
		_input = "                  秧秧秧秧秧秧秧秧                  ";
		_result = string_trim(_input);
		assert_equals(_result, "秧秧秧秧秧秧秧秧", "#2 string_trim_end : failed to correctly trim the string, non-latin characters");
	
	})
	
	addFact("string_foreach", function() {
	
		var _input = "                  秧秧秧秧秧秧秧秧sometext";
		
		string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
			assert_equals(_char, string_char_at(in, _pos), "#1 string_foreach : failed to traverse correctly the string.");
		}));
		
		
		string_foreach(_input, method( {in: _input}, function(_char, _pos) { 
			assert_equals(_char, string_char_at(in, _pos), "#2 string_foreach : failed to traverse correctly the string.");
		}), -1, -infinity);	
	
	})
	
}

