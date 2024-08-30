// Values used in base64 tests
#macro kHelloWorld_Base64Test "Hello World!"
#macro kb64HelloWorld_Base64Test "SGVsbG8gV29ybGQh"
#macro kBigLorem_Base64Test "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed massa magna, sagittis varius vestibulum scelerisque, vehicula interdum sem. Integer id mauris id ex elementum ultrices. In a lectus mauris. In mollis ornare blandit. Etiam sollicitudin mauris eget massa posuere sagittis. Nullam vel quam a nunc tempor accumsan eget sed magna. Nam ut lacus ut diam varius vestibulum vitae in lacus. Nulla nunc lorem, accumsan quis placerat sed, elementum vitae sapien. Nam efficitur tortor sem, ac vehicula dui tincidunt ut. Pellentesque in facilisis massa, a fringilla ipsum. Ut volutpat dui metus, ac bibendum nunc vulputate eu. Integer eget turpis facilisis, congue quam id, posuere augue."
#macro kb64BigLorem_Base64Test "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gU2VkIG1hc3NhIG1hZ25hLCBzYWdpdHRpcyB2YXJpdXMgdmVzdGlidWx1bSBzY2VsZXJpc3F1ZSwgdmVoaWN1bGEgaW50ZXJkdW0gc2VtLiBJbnRlZ2VyIGlkIG1hdXJpcyBpZCBleCBlbGVtZW50dW0gdWx0cmljZXMuIEluIGEgbGVjdHVzIG1hdXJpcy4gSW4gbW9sbGlzIG9ybmFyZSBibGFuZGl0LiBFdGlhbSBzb2xsaWNpdHVkaW4gbWF1cmlzIGVnZXQgbWFzc2EgcG9zdWVyZSBzYWdpdHRpcy4gTnVsbGFtIHZlbCBxdWFtIGEgbnVuYyB0ZW1wb3IgYWNjdW1zYW4gZWdldCBzZWQgbWFnbmEuIE5hbSB1dCBsYWN1cyB1dCBkaWFtIHZhcml1cyB2ZXN0aWJ1bHVtIHZpdGFlIGluIGxhY3VzLiBOdWxsYSBudW5jIGxvcmVtLCBhY2N1bXNhbiBxdWlzIHBsYWNlcmF0IHNlZCwgZWxlbWVudHVtIHZpdGFlIHNhcGllbi4gTmFtIGVmZmljaXR1ciB0b3J0b3Igc2VtLCBhYyB2ZWhpY3VsYSBkdWkgdGluY2lkdW50IHV0LiBQZWxsZW50ZXNxdWUgaW4gZmFjaWxpc2lzIG1hc3NhLCBhIGZyaW5naWxsYSBpcHN1bS4gVXQgdm9sdXRwYXQgZHVpIG1ldHVzLCBhYyBiaWJlbmR1bSBudW5jIHZ1bHB1dGF0ZSBldS4gSW50ZWdlciBlZ2V0IHR1cnBpcyBmYWNpbGlzaXMsIGNvbmd1ZSBxdWFtIGlkLCBwb3N1ZXJlIGF1Z3VlLg=="
#macro kLyrics_Base64Test "now this is a story all about how my life got flipped turned upside down and I'd like to take a minute just sit right there I'll tell you how I become the prince of a town called Bel Air"
#macro kb64Lyrics_Base64Test "bm93IHRoaXMgaXMgYSBzdG9yeSBhbGwgYWJvdXQgaG93IG15IGxpZmUgZ290IGZsaXBwZWQgdHVybmVkIHVwc2lkZSBkb3duIGFuZCBJJ2QgbGlrZSB0byB0YWtlIGEgbWludXRlIGp1c3Qgc2l0IHJpZ2h0IHRoZXJlIEknbGwgdGVsbCB5b3UgaG93IEkgYmVjb21lIHRoZSBwcmluY2Ugb2YgYSB0b3duIGNhbGxlZCBCZWwgQWly"

function BasicBase64TestSuite() : TestSuite() constructor {

    // BASE64 ENCODE
    
    addFact("base64_encode_test #1", function() {
    
        // Encode a string and check that it has been encoded to the correct value
        var b64HW = base64_encode("Hello World!");
        assert_equals(b64HW, "SGVsbG8gV29ybGQh", "b64HW should equal SGVsbG8gV29ybGQh");
        
    });
    
    addFact("base64_encode_test #2", function() {
        
        var sBigString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet est placerat in egestas erat imperdiet sed euismod nisi. Orci porta non pulvinar neque. Turpis massa sed elementum tempus egestas. Habitasse platea dictumst vestibulum rhoncus est pellentesque. Tellus orci ac auctor augue mauris augue neque gravida in. Vel quam elementum pulvinar etiam non quam. Proin sagittis nisl rhoncus mattis rhoncus. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Elit ut aliquam purus sit amet luctus. Ornare arcu odio ut sem nulla pharetra diam. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant.";
        var sB64BigString = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdCwgc2VkIGRvIGVpdXNtb2QgdGVtcG9yIGluY2lkaWR1bnQgdXQgbGFib3JlIGV0IGRvbG9yZSBtYWduYSBhbGlxdWEuIEFtZXQgZXN0IHBsYWNlcmF0IGluIGVnZXN0YXMgZXJhdCBpbXBlcmRpZXQgc2VkIGV1aXNtb2QgbmlzaS4gT3JjaSBwb3J0YSBub24gcHVsdmluYXIgbmVxdWUuIFR1cnBpcyBtYXNzYSBzZWQgZWxlbWVudHVtIHRlbXB1cyBlZ2VzdGFzLiBIYWJpdGFzc2UgcGxhdGVhIGRpY3R1bXN0IHZlc3RpYnVsdW0gcmhvbmN1cyBlc3QgcGVsbGVudGVzcXVlLiBUZWxsdXMgb3JjaSBhYyBhdWN0b3IgYXVndWUgbWF1cmlzIGF1Z3VlIG5lcXVlIGdyYXZpZGEgaW4uIFZlbCBxdWFtIGVsZW1lbnR1bSBwdWx2aW5hciBldGlhbSBub24gcXVhbS4gUHJvaW4gc2FnaXR0aXMgbmlzbCByaG9uY3VzIG1hdHRpcyByaG9uY3VzLiBQaGFyZXRyYSBtYWduYSBhYyBwbGFjZXJhdCB2ZXN0aWJ1bHVtIGxlY3R1cyBtYXVyaXMgdWx0cmljZXMgZXJvcyBpbi4gRWxpdCB1dCBhbGlxdWFtIHB1cnVzIHNpdCBhbWV0IGx1Y3R1cy4gT3JuYXJlIGFyY3Ugb2RpbyB1dCBzZW0gbnVsbGEgcGhhcmV0cmEgZGlhbS4gVmVsaXQgc2VkIHVsbGFtY29ycGVyIG1vcmJpIHRpbmNpZHVudCBvcm5hcmUgbWFzc2EgZWdldCBlZ2VzdGFzLiBSaG9uY3VzIGFlbmVhbiB2ZWwgZWxpdCBzY2VsZXJpc3F1ZSBtYXVyaXMgcGVsbGVudGVzcXVlIHB1bHZpbmFyIHBlbGxlbnRlc3F1ZSBoYWJpdGFudC4=";
        
        // Encode a large string and check that it has been encoded to the correct value
        var b64BigStr = base64_encode(sBigString);
        assert_equals(b64BigStr, sB64BigString, "The two encoded strings should be equal");
        
    });
    
    addFact("base64_encode_test #3", function() {
        
        // Encode a macro string and check that it has been encoded to the correct value
        var b64HelloWorld = base64_encode(kHelloWorld_Base64Test);
        assert_equals(b64HelloWorld, "SGVsbG8gV29ybGQh", "\"Hello World!\" in base64 == \"SGVsbG8gV29ybGQh\"");
    });
    
    addFact("base64_encode_test #4", function() {
        
        // Encode a large macro string and check that it has been encoded to the correct value
        var b64BigLorem = base64_encode(kBigLorem_Base64Test);
        assert_equals(b64BigLorem, kb64BigLorem_Base64Test, "The kBigLorem_Base64Test in base64 == kb64BigLorem_Base64Test");
    });
    
    addFact("base64_encode_test #5", function() {
        
        // Encode a small string and check that it has been encoded to the correct value
        var singleChar = "a";
        var b64SingleChar = base64_encode(singleChar);
        assert_equals(b64SingleChar, "YQ==", "a in base64 should be YQ==");
    });
    
    addFact("base64_encode_test #6", function() {
        
        // Encode a small string and check that it has been encoded to the correct value
        var twoChars = "Aa";
        var b64TwoChars = base64_encode(twoChars);
        assert_equals(b64TwoChars, "QWE=", "a in base64 should be QWE=");
    });
    
    addFact("base64_encode_test #7", function() {
        
        // Encode a small string and check that it has been encoded to the correct value
        var threeChars = "AaB";
        var b64ThreeChars = base64_encode(threeChars);
        assert_equals(b64ThreeChars, "QWFC", "a in base64 should be QWFC");
    });
    
    addFact("base64_encode_test #8", function() {
        
        // Encode a small string and check that it has been encoded to the correct value
        var fourChars = "AaBb";
        var b64FourChars = base64_encode(fourChars);
        assert_equals(b64FourChars, "QWFCYg==", "a in base64 should be QWFCYg==");
    });
    
    // BASE64 DECODE
    
    addFact("base64_decode_test #1", function() {
        
        var sBigString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet est placerat in egestas erat imperdiet sed euismod nisi. Orci porta non pulvinar neque. Turpis massa sed elementum tempus egestas. Habitasse platea dictumst vestibulum rhoncus est pellentesque. Tellus orci ac auctor augue mauris augue neque gravida in. Vel quam elementum pulvinar etiam non quam. Proin sagittis nisl rhoncus mattis rhoncus. Pharetra magna ac placerat vestibulum lectus mauris ultrices eros in. Elit ut aliquam purus sit amet luctus. Ornare arcu odio ut sem nulla pharetra diam. Velit sed ullamcorper morbi tincidunt ornare massa eget egestas. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant.";
        var sB64BigString = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdCwgc2VkIGRvIGVpdXNtb2QgdGVtcG9yIGluY2lkaWR1bnQgdXQgbGFib3JlIGV0IGRvbG9yZSBtYWduYSBhbGlxdWEuIEFtZXQgZXN0IHBsYWNlcmF0IGluIGVnZXN0YXMgZXJhdCBpbXBlcmRpZXQgc2VkIGV1aXNtb2QgbmlzaS4gT3JjaSBwb3J0YSBub24gcHVsdmluYXIgbmVxdWUuIFR1cnBpcyBtYXNzYSBzZWQgZWxlbWVudHVtIHRlbXB1cyBlZ2VzdGFzLiBIYWJpdGFzc2UgcGxhdGVhIGRpY3R1bXN0IHZlc3RpYnVsdW0gcmhvbmN1cyBlc3QgcGVsbGVudGVzcXVlLiBUZWxsdXMgb3JjaSBhYyBhdWN0b3IgYXVndWUgbWF1cmlzIGF1Z3VlIG5lcXVlIGdyYXZpZGEgaW4uIFZlbCBxdWFtIGVsZW1lbnR1bSBwdWx2aW5hciBldGlhbSBub24gcXVhbS4gUHJvaW4gc2FnaXR0aXMgbmlzbCByaG9uY3VzIG1hdHRpcyByaG9uY3VzLiBQaGFyZXRyYSBtYWduYSBhYyBwbGFjZXJhdCB2ZXN0aWJ1bHVtIGxlY3R1cyBtYXVyaXMgdWx0cmljZXMgZXJvcyBpbi4gRWxpdCB1dCBhbGlxdWFtIHB1cnVzIHNpdCBhbWV0IGx1Y3R1cy4gT3JuYXJlIGFyY3Ugb2RpbyB1dCBzZW0gbnVsbGEgcGhhcmV0cmEgZGlhbS4gVmVsaXQgc2VkIHVsbGFtY29ycGVyIG1vcmJpIHRpbmNpZHVudCBvcm5hcmUgbWFzc2EgZWdldCBlZ2VzdGFzLiBSaG9uY3VzIGFlbmVhbiB2ZWwgZWxpdCBzY2VsZXJpc3F1ZSBtYXVyaXMgcGVsbGVudGVzcXVlIHB1bHZpbmFyIHBlbGxlbnRlc3F1ZSBoYWJpdGFudC4=";
        
        // Decode a large string and check that it has been decoded to the correct value
        var bigStr = base64_decode(sB64BigString);
        assert_equals(bigStr, sBigString, "The two decoded strings should be equal");
    });
    
    addFact("base64_decode_test #2", function() {
        
        // Decode a string and check that it has been decoded to the correct value
        var hw = base64_decode("SGVsbG8gV29ybGQh");
        assert_equals(hw, "Hello World!", "hw should equal Hello World!");
    });
    
    addFact("base64_decode_test #3", function() {
        // Encode a macro string to be decoded
        var b64HelloWorld = base64_encode(kHelloWorld_Base64Test);
        
        // Decode the encoded macro string and check that it has been decoded to the correct value
        var asciiHelloWorld = base64_decode(b64HelloWorld);
        assert_equals(asciiHelloWorld, kHelloWorld_Base64Test, "asciiHelloWorld == kHelloWorld_Base64Test");
    });
    
    addFact("base64_decode_test #4", function() {
        // Encode a large macro string to be decoded
        var b64BigLorem = base64_encode(kBigLorem_Base64Test);
        
        // Decode the encoded large macro string and check that it has been decoded to the correct value
        var asciiBigLorem = base64_decode(b64BigLorem);
        assert_equals(asciiBigLorem, kBigLorem_Base64Test, "Translating b64BigLorem back should be the original kBigLorem_Base64Test");
    });
    
    addFact("base64_decode_test #5", function() {
        
        // Decode the pre-prepared macro string and check that it has been decoded to the correct value
        var lyrics = base64_decode(kb64Lyrics_Base64Test);
        assert_equals(lyrics, kLyrics_Base64Test, "Translating from base64 first without ever encoding kLyrics_Base64Test into base64.");
    });
    
    addFact("base64_decode_test #6", function() {
        
        // Decode the pre-prepared large macro string and check that it has been decoded to the correct value
        var asciiBigLorem = base64_decode(kb64BigLorem_Base64Test);
        assert_equals(asciiBigLorem, kBigLorem_Base64Test, "Translating kb64BigLorem_Base64Test should equal kBigLorem_Base64Test");
    });
    
}