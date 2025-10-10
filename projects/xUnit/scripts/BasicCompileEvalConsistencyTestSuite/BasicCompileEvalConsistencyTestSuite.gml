function BasicCompileEvalConsistencyTestSuite() : TestSuite() constructor {

#region === Binary Operators ===

    addFact("& - 0b & 0b", function() {
        var result_ct = 0b1011 & 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0b & 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b & 0b :: type mismatch");
    });

    addFact("& - 0b & 0x", function() {
        var result_ct = 0b1011 & 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0b & 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b & 0x :: type mismatch");
    });

    addFact("& - 0b & Unsigned-real", function() {
        var result_ct = 0b1011 & 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0b & Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b & Unsigned-real :: type mismatch");
    });

    addFact("& - 0b & Signed-real", function() {
        var result_ct = 0b1011 & 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0b & Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b & Signed-real :: type mismatch");
    });

    addFact("& - 0x & 0b", function() {
        var result_ct = 0xA7 & 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0x & 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x & 0b :: type mismatch");
    });

    addFact("& - 0x & 0x", function() {
        var result_ct = 0xA7 & 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0x & 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x & 0x :: type mismatch");
    });

    addFact("& - 0x & Unsigned-real", function() {
        var result_ct = 0xA7 & 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0x & Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x & Unsigned-real :: type mismatch");
    });

    addFact("& - 0x & Signed-real", function() {
        var result_ct = 0xA7 & 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "0x & Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x & Signed-real :: type mismatch");
    });

    addFact("& - Unsigned-real & 0b", function() {
        var result_ct = 167 & 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real & 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real & 0b :: type mismatch");
    });

    addFact("& - Unsigned-real & 0x", function() {
        var result_ct = 167 & 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real & 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real & 0x :: type mismatch");
    });

    addFact("& - Unsigned-real & Unsigned-real", function() {
        var result_ct = 167 & 167;
        var a = 167;
        var b = 167;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real & Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real & Unsigned-real :: type mismatch");
    });

    addFact("& - Unsigned-real & Signed-real", function() {
        var result_ct = 167 & 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real & Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real & Signed-real :: type mismatch");
    });

    addFact("& - Signed-real & 0b", function() {
        var result_ct = 1.5 & 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Signed-real & 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real & 0b :: type mismatch");
    });

    addFact("& - Signed-real & 0x", function() {
        var result_ct = 1.5 & 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Signed-real & 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real & 0x :: type mismatch");
    });

    addFact("& - Signed-real & Unsigned-real", function() {
        var result_ct = 1.5 & 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Signed-real & Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real & Unsigned-real :: type mismatch");
    });

    addFact("& - Signed-real & Signed-real", function() {
        var result_ct = 1.5 & 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a & b;

        assert_equals(result_ct == result_rt, true, "Signed-real & Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real & Signed-real :: type mismatch");
    });

    addFact("| - 0b | 0b", function() {
        var result_ct = 0b1011 | 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0b | 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b | 0b :: type mismatch");
    });

    addFact("| - 0b | 0x", function() {
        var result_ct = 0b1011 | 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0b | 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b | 0x :: type mismatch");
    });

    addFact("| - 0b | Unsigned-real", function() {
        var result_ct = 0b1011 | 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0b | Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b | Unsigned-real :: type mismatch");
    });

    addFact("| - 0b | Signed-real", function() {
        var result_ct = 0b1011 | 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0b | Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b | Signed-real :: type mismatch");
    });

    addFact("| - 0x | 0b", function() {
        var result_ct = 0xA7 | 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0x | 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x | 0b :: type mismatch");
    });

    addFact("| - 0x | 0x", function() {
        var result_ct = 0xA7 | 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0x | 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x | 0x :: type mismatch");
    });

    addFact("| - 0x | Unsigned-real", function() {
        var result_ct = 0xA7 | 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0x | Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x | Unsigned-real :: type mismatch");
    });

    addFact("| - 0x | Signed-real", function() {
        var result_ct = 0xA7 | 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "0x | Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x | Signed-real :: type mismatch");
    });

    addFact("| - Unsigned-real | 0b", function() {
        var result_ct = 167 | 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real | 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real | 0b :: type mismatch");
    });

    addFact("| - Unsigned-real | 0x", function() {
        var result_ct = 167 | 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real | 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real | 0x :: type mismatch");
    });

    addFact("| - Unsigned-real | Unsigned-real", function() {
        var result_ct = 167 | 167;
        var a = 167;
        var b = 167;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real | Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real | Unsigned-real :: type mismatch");
    });

    addFact("| - Unsigned-real | Signed-real", function() {
        var result_ct = 167 | 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real | Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real | Signed-real :: type mismatch");
    });

    addFact("| - Signed-real | 0b", function() {
        var result_ct = 1.5 | 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Signed-real | 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real | 0b :: type mismatch");
    });

    addFact("| - Signed-real | 0x", function() {
        var result_ct = 1.5 | 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Signed-real | 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real | 0x :: type mismatch");
    });

    addFact("| - Signed-real | Unsigned-real", function() {
        var result_ct = 1.5 | 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Signed-real | Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real | Unsigned-real :: type mismatch");
    });

    addFact("| - Signed-real | Signed-real", function() {
        var result_ct = 1.5 | 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a | b;

        assert_equals(result_ct == result_rt, true, "Signed-real | Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real | Signed-real :: type mismatch");
    });

    addFact("^ - 0b ^ 0b", function() {
        var result_ct = 0b1011 ^ 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0b ^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^ 0b :: type mismatch");
    });

    addFact("^ - 0b ^ 0x", function() {
        var result_ct = 0b1011 ^ 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0b ^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^ 0x :: type mismatch");
    });

    addFact("^ - 0b ^ Unsigned-real", function() {
        var result_ct = 0b1011 ^ 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0b ^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^ Unsigned-real :: type mismatch");
    });

    addFact("^ - 0b ^ Signed-real", function() {
        var result_ct = 0b1011 ^ 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0b ^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^ Signed-real :: type mismatch");
    });

    addFact("^ - 0x ^ 0b", function() {
        var result_ct = 0xA7 ^ 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0x ^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^ 0b :: type mismatch");
    });

    addFact("^ - 0x ^ 0x", function() {
        var result_ct = 0xA7 ^ 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0x ^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^ 0x :: type mismatch");
    });

    addFact("^ - 0x ^ Unsigned-real", function() {
        var result_ct = 0xA7 ^ 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0x ^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^ Unsigned-real :: type mismatch");
    });

    addFact("^ - 0x ^ Signed-real", function() {
        var result_ct = 0xA7 ^ 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "0x ^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^ Signed-real :: type mismatch");
    });

    addFact("^ - Unsigned-real ^ 0b", function() {
        var result_ct = 167 ^ 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^ 0b :: type mismatch");
    });

    addFact("^ - Unsigned-real ^ 0x", function() {
        var result_ct = 167 ^ 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^ 0x :: type mismatch");
    });

    addFact("^ - Unsigned-real ^ Unsigned-real", function() {
        var result_ct = 167 ^ 167;
        var a = 167;
        var b = 167;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^ Unsigned-real :: type mismatch");
    });

    addFact("^ - Unsigned-real ^ Signed-real", function() {
        var result_ct = 167 ^ 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^ Signed-real :: type mismatch");
    });

    addFact("^ - Signed-real ^ 0b", function() {
        var result_ct = 1.5 ^ 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^ 0b :: type mismatch");
    });

    addFact("^ - Signed-real ^ 0x", function() {
        var result_ct = 1.5 ^ 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^ 0x :: type mismatch");
    });

    addFact("^ - Signed-real ^ Unsigned-real", function() {
        var result_ct = 1.5 ^ 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^ Unsigned-real :: type mismatch");
    });

    addFact("^ - Signed-real ^ Signed-real", function() {
        var result_ct = 1.5 ^ 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a ^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^ Signed-real :: type mismatch");
    });

    addFact("<< - 0b << 0b", function() {
        var result_ct = 0b1011 << 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0b << 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b << 0b :: type mismatch");
    });

    addFact("<< - 0b << 0x", function() {
        var result_ct = 0b1011 << 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0b << 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b << 0x :: type mismatch");
    });

    addFact("<< - 0b << Unsigned-real", function() {
        var result_ct = 0b1011 << 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0b << Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b << Unsigned-real :: type mismatch");
    });

    addFact("<< - 0b << Signed-real", function() {
        var result_ct = 0b1011 << 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0b << Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b << Signed-real :: type mismatch");
    });

    addFact("<< - 0x << 0b", function() {
        var result_ct = 0xA7 << 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0x << 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x << 0b :: type mismatch");
    });

    addFact("<< - 0x << 0x", function() {
        var result_ct = 0xA7 << 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0x << 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x << 0x :: type mismatch");
    });

    addFact("<< - 0x << Unsigned-real", function() {
        var result_ct = 0xA7 << 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0x << Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x << Unsigned-real :: type mismatch");
    });

    addFact("<< - 0x << Signed-real", function() {
        var result_ct = 0xA7 << 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "0x << Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x << Signed-real :: type mismatch");
    });

    addFact("<< - Unsigned-real << 0b", function() {
        var result_ct = 167 << 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real << 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real << 0b :: type mismatch");
    });

    addFact("<< - Unsigned-real << 0x", function() {
        var result_ct = 167 << 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real << 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real << 0x :: type mismatch");
    });

    addFact("<< - Unsigned-real << Unsigned-real", function() {
        var result_ct = 167 << 167;
        var a = 167;
        var b = 167;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real << Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real << Unsigned-real :: type mismatch");
    });

    addFact("<< - Unsigned-real << Signed-real", function() {
        var result_ct = 167 << 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real << Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real << Signed-real :: type mismatch");
    });

    addFact("<< - Signed-real << 0b", function() {
        var result_ct = 1.5 << 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Signed-real << 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real << 0b :: type mismatch");
    });

    addFact("<< - Signed-real << 0x", function() {
        var result_ct = 1.5 << 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Signed-real << 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real << 0x :: type mismatch");
    });

    addFact("<< - Signed-real << Unsigned-real", function() {
        var result_ct = 1.5 << 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Signed-real << Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real << Unsigned-real :: type mismatch");
    });

    addFact("<< - Signed-real << Signed-real", function() {
        var result_ct = 1.5 << 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a << b;

        assert_equals(result_ct == result_rt, true, "Signed-real << Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real << Signed-real :: type mismatch");
    });

    addFact(">> - 0b >> 0b", function() {
        var result_ct = 0b1011 >> 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0b >> 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >> 0b :: type mismatch");
    });

    addFact(">> - 0b >> 0x", function() {
        var result_ct = 0b1011 >> 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0b >> 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >> 0x :: type mismatch");
    });

    addFact(">> - 0b >> Unsigned-real", function() {
        var result_ct = 0b1011 >> 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0b >> Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >> Unsigned-real :: type mismatch");
    });

    addFact(">> - 0b >> Signed-real", function() {
        var result_ct = 0b1011 >> 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0b >> Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >> Signed-real :: type mismatch");
    });

    addFact(">> - 0x >> 0b", function() {
        var result_ct = 0xA7 >> 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0x >> 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >> 0b :: type mismatch");
    });

    addFact(">> - 0x >> 0x", function() {
        var result_ct = 0xA7 >> 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0x >> 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >> 0x :: type mismatch");
    });

    addFact(">> - 0x >> Unsigned-real", function() {
        var result_ct = 0xA7 >> 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0x >> Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >> Unsigned-real :: type mismatch");
    });

    addFact(">> - 0x >> Signed-real", function() {
        var result_ct = 0xA7 >> 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "0x >> Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >> Signed-real :: type mismatch");
    });

    addFact(">> - Unsigned-real >> 0b", function() {
        var result_ct = 167 >> 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >> 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >> 0b :: type mismatch");
    });

    addFact(">> - Unsigned-real >> 0x", function() {
        var result_ct = 167 >> 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >> 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >> 0x :: type mismatch");
    });

    addFact(">> - Unsigned-real >> Unsigned-real", function() {
        var result_ct = 167 >> 167;
        var a = 167;
        var b = 167;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >> Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >> Unsigned-real :: type mismatch");
    });

    addFact(">> - Unsigned-real >> Signed-real", function() {
        var result_ct = 167 >> 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >> Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >> Signed-real :: type mismatch");
    });

    addFact(">> - Signed-real >> 0b", function() {
        var result_ct = 1.5 >> 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Signed-real >> 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >> 0b :: type mismatch");
    });

    addFact(">> - Signed-real >> 0x", function() {
        var result_ct = 1.5 >> 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Signed-real >> 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >> 0x :: type mismatch");
    });

    addFact(">> - Signed-real >> Unsigned-real", function() {
        var result_ct = 1.5 >> 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Signed-real >> Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >> Unsigned-real :: type mismatch");
    });

    addFact(">> - Signed-real >> Signed-real", function() {
        var result_ct = 1.5 >> 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a >> b;

        assert_equals(result_ct == result_rt, true, "Signed-real >> Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >> Signed-real :: type mismatch");
    });

    addFact("+ - 0b + 0b", function() {
        var result_ct = 0b1011 + 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0b + 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b + 0b :: type mismatch");
    });

    addFact("+ - 0b + 0x", function() {
        var result_ct = 0b1011 + 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0b + 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b + 0x :: type mismatch");
    });

    addFact("+ - 0b + Unsigned-real", function() {
        var result_ct = 0b1011 + 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0b + Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b + Unsigned-real :: type mismatch");
    });

    addFact("+ - 0b + Signed-real", function() {
        var result_ct = 0b1011 + 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0b + Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b + Signed-real :: type mismatch");
    });

    addFact("+ - 0x + 0b", function() {
        var result_ct = 0xA7 + 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0x + 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x + 0b :: type mismatch");
    });

    addFact("+ - 0x + 0x", function() {
        var result_ct = 0xA7 + 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0x + 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x + 0x :: type mismatch");
    });

    addFact("+ - 0x + Unsigned-real", function() {
        var result_ct = 0xA7 + 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0x + Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x + Unsigned-real :: type mismatch");
    });

    addFact("+ - 0x + Signed-real", function() {
        var result_ct = 0xA7 + 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "0x + Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x + Signed-real :: type mismatch");
    });

    addFact("+ - Unsigned-real + 0b", function() {
        var result_ct = 167 + 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real + 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real + 0b :: type mismatch");
    });

    addFact("+ - Unsigned-real + 0x", function() {
        var result_ct = 167 + 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real + 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real + 0x :: type mismatch");
    });

    addFact("+ - Unsigned-real + Unsigned-real", function() {
        var result_ct = 167 + 167;
        var a = 167;
        var b = 167;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real + Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real + Unsigned-real :: type mismatch");
    });

    addFact("+ - Unsigned-real + Signed-real", function() {
        var result_ct = 167 + 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real + Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real + Signed-real :: type mismatch");
    });

    addFact("+ - Signed-real + 0b", function() {
        var result_ct = 1.5 + 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Signed-real + 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real + 0b :: type mismatch");
    });

    addFact("+ - Signed-real + 0x", function() {
        var result_ct = 1.5 + 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Signed-real + 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real + 0x :: type mismatch");
    });

    addFact("+ - Signed-real + Unsigned-real", function() {
        var result_ct = 1.5 + 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Signed-real + Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real + Unsigned-real :: type mismatch");
    });

    addFact("+ - Signed-real + Signed-real", function() {
        var result_ct = 1.5 + 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a + b;

        assert_equals(result_ct == result_rt, true, "Signed-real + Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real + Signed-real :: type mismatch");
    });

    addFact("- - 0b - 0b", function() {
        var result_ct = 0b1011 - 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0b - 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b - 0b :: type mismatch");
    });

    addFact("- - 0b - 0x", function() {
        var result_ct = 0b1011 - 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0b - 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b - 0x :: type mismatch");
    });

    addFact("- - 0b - Unsigned-real", function() {
        var result_ct = 0b1011 - 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0b - Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b - Unsigned-real :: type mismatch");
    });

    addFact("- - 0b - Signed-real", function() {
        var result_ct = 0b1011 - 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0b - Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b - Signed-real :: type mismatch");
    });

    addFact("- - 0x - 0b", function() {
        var result_ct = 0xA7 - 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0x - 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x - 0b :: type mismatch");
    });

    addFact("- - 0x - 0x", function() {
        var result_ct = 0xA7 - 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0x - 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x - 0x :: type mismatch");
    });

    addFact("- - 0x - Unsigned-real", function() {
        var result_ct = 0xA7 - 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0x - Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x - Unsigned-real :: type mismatch");
    });

    addFact("- - 0x - Signed-real", function() {
        var result_ct = 0xA7 - 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "0x - Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x - Signed-real :: type mismatch");
    });

    addFact("- - Unsigned-real - 0b", function() {
        var result_ct = 167 - 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real - 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real - 0b :: type mismatch");
    });

    addFact("- - Unsigned-real - 0x", function() {
        var result_ct = 167 - 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real - 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real - 0x :: type mismatch");
    });

    addFact("- - Unsigned-real - Unsigned-real", function() {
        var result_ct = 167 - 167;
        var a = 167;
        var b = 167;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real - Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real - Unsigned-real :: type mismatch");
    });

    addFact("- - Unsigned-real - Signed-real", function() {
        var result_ct = 167 - 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real - Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real - Signed-real :: type mismatch");
    });

    addFact("- - Signed-real - 0b", function() {
        var result_ct = 1.5 - 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Signed-real - 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real - 0b :: type mismatch");
    });

    addFact("- - Signed-real - 0x", function() {
        var result_ct = 1.5 - 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Signed-real - 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real - 0x :: type mismatch");
    });

    addFact("- - Signed-real - Unsigned-real", function() {
        var result_ct = 1.5 - 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Signed-real - Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real - Unsigned-real :: type mismatch");
    });

    addFact("- - Signed-real - Signed-real", function() {
        var result_ct = 1.5 - 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a - b;

        assert_equals(result_ct == result_rt, true, "Signed-real - Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real - Signed-real :: type mismatch");
    });

    addFact("* - 0b * 0b", function() {
        var result_ct = 0b1011 * 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0b * 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b * 0b :: type mismatch");
    });

    addFact("* - 0b * 0x", function() {
        var result_ct = 0b1011 * 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0b * 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b * 0x :: type mismatch");
    });

    addFact("* - 0b * Unsigned-real", function() {
        var result_ct = 0b1011 * 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0b * Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b * Unsigned-real :: type mismatch");
    });

    addFact("* - 0b * Signed-real", function() {
        var result_ct = 0b1011 * 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0b * Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b * Signed-real :: type mismatch");
    });

    addFact("* - 0x * 0b", function() {
        var result_ct = 0xA7 * 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0x * 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x * 0b :: type mismatch");
    });

    addFact("* - 0x * 0x", function() {
        var result_ct = 0xA7 * 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0x * 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x * 0x :: type mismatch");
    });

    addFact("* - 0x * Unsigned-real", function() {
        var result_ct = 0xA7 * 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0x * Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x * Unsigned-real :: type mismatch");
    });

    addFact("* - 0x * Signed-real", function() {
        var result_ct = 0xA7 * 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "0x * Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x * Signed-real :: type mismatch");
    });

    addFact("* - Unsigned-real * 0b", function() {
        var result_ct = 167 * 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real * 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real * 0b :: type mismatch");
    });

    addFact("* - Unsigned-real * 0x", function() {
        var result_ct = 167 * 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real * 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real * 0x :: type mismatch");
    });

    addFact("* - Unsigned-real * Unsigned-real", function() {
        var result_ct = 167 * 167;
        var a = 167;
        var b = 167;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real * Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real * Unsigned-real :: type mismatch");
    });

    addFact("* - Unsigned-real * Signed-real", function() {
        var result_ct = 167 * 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real * Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real * Signed-real :: type mismatch");
    });

    addFact("* - Signed-real * 0b", function() {
        var result_ct = 1.5 * 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Signed-real * 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real * 0b :: type mismatch");
    });

    addFact("* - Signed-real * 0x", function() {
        var result_ct = 1.5 * 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Signed-real * 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real * 0x :: type mismatch");
    });

    addFact("* - Signed-real * Unsigned-real", function() {
        var result_ct = 1.5 * 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Signed-real * Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real * Unsigned-real :: type mismatch");
    });

    addFact("* - Signed-real * Signed-real", function() {
        var result_ct = 1.5 * 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a * b;

        assert_equals(result_ct == result_rt, true, "Signed-real * Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real * Signed-real :: type mismatch");
    });

    addFact("/ - 0b / 0b", function() {
        var result_ct = 0b1011 / 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0b / 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b / 0b :: type mismatch");
    });

    addFact("/ - 0b / 0x", function() {
        var result_ct = 0b1011 / 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0b / 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b / 0x :: type mismatch");
    });

    addFact("/ - 0b / Unsigned-real", function() {
        var result_ct = 0b1011 / 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0b / Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b / Unsigned-real :: type mismatch");
    });

    addFact("/ - 0b / Signed-real", function() {
        var result_ct = 0b1011 / 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0b / Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b / Signed-real :: type mismatch");
    });

    addFact("/ - 0x / 0b", function() {
        var result_ct = 0xA7 / 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0x / 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x / 0b :: type mismatch");
    });

    addFact("/ - 0x / 0x", function() {
        var result_ct = 0xA7 / 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0x / 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x / 0x :: type mismatch");
    });

    addFact("/ - 0x / Unsigned-real", function() {
        var result_ct = 0xA7 / 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0x / Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x / Unsigned-real :: type mismatch");
    });

    addFact("/ - 0x / Signed-real", function() {
        var result_ct = 0xA7 / 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "0x / Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x / Signed-real :: type mismatch");
    });

    addFact("/ - Unsigned-real / 0b", function() {
        var result_ct = 167 / 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real / 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real / 0b :: type mismatch");
    });

    addFact("/ - Unsigned-real / 0x", function() {
        var result_ct = 167 / 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real / 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real / 0x :: type mismatch");
    });

    addFact("/ - Unsigned-real / Unsigned-real", function() {
        var result_ct = 167 / 167;
        var a = 167;
        var b = 167;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real / Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real / Unsigned-real :: type mismatch");
    });

    addFact("/ - Unsigned-real / Signed-real", function() {
        var result_ct = 167 / 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real / Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real / Signed-real :: type mismatch");
    });

    addFact("/ - Signed-real / 0b", function() {
        var result_ct = 1.5 / 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Signed-real / 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real / 0b :: type mismatch");
    });

    addFact("/ - Signed-real / 0x", function() {
        var result_ct = 1.5 / 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Signed-real / 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real / 0x :: type mismatch");
    });

    addFact("/ - Signed-real / Unsigned-real", function() {
        var result_ct = 1.5 / 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Signed-real / Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real / Unsigned-real :: type mismatch");
    });

    addFact("/ - Signed-real / Signed-real", function() {
        var result_ct = 1.5 / 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a / b;

        assert_equals(result_ct == result_rt, true, "Signed-real / Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real / Signed-real :: type mismatch");
    });

    addFact("% - 0b % 0b", function() {
        var result_ct = 0b1011 % 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0b % 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b % 0b :: type mismatch");
    });

    addFact("% - 0b % 0x", function() {
        var result_ct = 0b1011 % 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0b % 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b % 0x :: type mismatch");
    });

    addFact("% - 0b % Unsigned-real", function() {
        var result_ct = 0b1011 % 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0b % Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b % Unsigned-real :: type mismatch");
    });

    addFact("% - 0b % Signed-real", function() {
        var result_ct = 0b1011 % 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0b % Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b % Signed-real :: type mismatch");
    });

    addFact("% - 0x % 0b", function() {
        var result_ct = 0xA7 % 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0x % 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x % 0b :: type mismatch");
    });

    addFact("% - 0x % 0x", function() {
        var result_ct = 0xA7 % 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0x % 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x % 0x :: type mismatch");
    });

    addFact("% - 0x % Unsigned-real", function() {
        var result_ct = 0xA7 % 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0x % Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x % Unsigned-real :: type mismatch");
    });

    addFact("% - 0x % Signed-real", function() {
        var result_ct = 0xA7 % 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "0x % Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x % Signed-real :: type mismatch");
    });

    addFact("% - Unsigned-real % 0b", function() {
        var result_ct = 167 % 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real % 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real % 0b :: type mismatch");
    });

    addFact("% - Unsigned-real % 0x", function() {
        var result_ct = 167 % 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real % 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real % 0x :: type mismatch");
    });

    addFact("% - Unsigned-real % Unsigned-real", function() {
        var result_ct = 167 % 167;
        var a = 167;
        var b = 167;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real % Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real % Unsigned-real :: type mismatch");
    });

    addFact("% - Unsigned-real % Signed-real", function() {
        var result_ct = 167 % 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real % Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real % Signed-real :: type mismatch");
    });

    addFact("% - Signed-real % 0b", function() {
        var result_ct = 1.5 % 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Signed-real % 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real % 0b :: type mismatch");
    });

    addFact("% - Signed-real % 0x", function() {
        var result_ct = 1.5 % 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Signed-real % 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real % 0x :: type mismatch");
    });

    addFact("% - Signed-real % Unsigned-real", function() {
        var result_ct = 1.5 % 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Signed-real % Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real % Unsigned-real :: type mismatch");
    });

    addFact("% - Signed-real % Signed-real", function() {
        var result_ct = 1.5 % 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a % b;

        assert_equals(result_ct == result_rt, true, "Signed-real % Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real % Signed-real :: type mismatch");
    });

    addFact("div - 0b div 0b", function() {
        var result_ct = 0b1011 div 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0b div 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b div 0b :: type mismatch");
    });

    addFact("div - 0b div 0x", function() {
        var result_ct = 0b1011 div 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0b div 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b div 0x :: type mismatch");
    });

    addFact("div - 0b div Unsigned-real", function() {
        var result_ct = 0b1011 div 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0b div Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b div Unsigned-real :: type mismatch");
    });

    addFact("div - 0b div Signed-real", function() {
        var result_ct = 0b1011 div 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0b div Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b div Signed-real :: type mismatch");
    });

    addFact("div - 0x div 0b", function() {
        var result_ct = 0xA7 div 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0x div 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x div 0b :: type mismatch");
    });

    addFact("div - 0x div 0x", function() {
        var result_ct = 0xA7 div 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0x div 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x div 0x :: type mismatch");
    });

    addFact("div - 0x div Unsigned-real", function() {
        var result_ct = 0xA7 div 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0x div Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x div Unsigned-real :: type mismatch");
    });

    addFact("div - 0x div Signed-real", function() {
        var result_ct = 0xA7 div 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "0x div Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x div Signed-real :: type mismatch");
    });

    addFact("div - Unsigned-real div 0b", function() {
        var result_ct = 167 div 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real div 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real div 0b :: type mismatch");
    });

    addFact("div - Unsigned-real div 0x", function() {
        var result_ct = 167 div 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real div 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real div 0x :: type mismatch");
    });

    addFact("div - Unsigned-real div Unsigned-real", function() {
        var result_ct = 167 div 167;
        var a = 167;
        var b = 167;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real div Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real div Unsigned-real :: type mismatch");
    });

    addFact("div - Unsigned-real div Signed-real", function() {
        var result_ct = 167 div 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real div Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real div Signed-real :: type mismatch");
    });

    addFact("div - Signed-real div 0b", function() {
        var result_ct = 1.5 div 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Signed-real div 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real div 0b :: type mismatch");
    });

    addFact("div - Signed-real div 0x", function() {
        var result_ct = 1.5 div 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Signed-real div 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real div 0x :: type mismatch");
    });

    addFact("div - Signed-real div Unsigned-real", function() {
        var result_ct = 1.5 div 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Signed-real div Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real div Unsigned-real :: type mismatch");
    });

    addFact("div - Signed-real div Signed-real", function() {
        var result_ct = 1.5 div 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a div b;

        assert_equals(result_ct == result_rt, true, "Signed-real div Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real div Signed-real :: type mismatch");
    });

    addFact("mod - 0b mod 0b", function() {
        var result_ct = 0b1011 mod 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0b mod 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b mod 0b :: type mismatch");
    });

    addFact("mod - 0b mod 0x", function() {
        var result_ct = 0b1011 mod 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0b mod 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b mod 0x :: type mismatch");
    });

    addFact("mod - 0b mod Unsigned-real", function() {
        var result_ct = 0b1011 mod 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0b mod Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b mod Unsigned-real :: type mismatch");
    });

    addFact("mod - 0b mod Signed-real", function() {
        var result_ct = 0b1011 mod 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0b mod Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b mod Signed-real :: type mismatch");
    });

    addFact("mod - 0x mod 0b", function() {
        var result_ct = 0xA7 mod 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0x mod 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x mod 0b :: type mismatch");
    });

    addFact("mod - 0x mod 0x", function() {
        var result_ct = 0xA7 mod 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0x mod 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x mod 0x :: type mismatch");
    });

    addFact("mod - 0x mod Unsigned-real", function() {
        var result_ct = 0xA7 mod 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0x mod Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x mod Unsigned-real :: type mismatch");
    });

    addFact("mod - 0x mod Signed-real", function() {
        var result_ct = 0xA7 mod 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "0x mod Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x mod Signed-real :: type mismatch");
    });

    addFact("mod - Unsigned-real mod 0b", function() {
        var result_ct = 167 mod 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real mod 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real mod 0b :: type mismatch");
    });

    addFact("mod - Unsigned-real mod 0x", function() {
        var result_ct = 167 mod 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real mod 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real mod 0x :: type mismatch");
    });

    addFact("mod - Unsigned-real mod Unsigned-real", function() {
        var result_ct = 167 mod 167;
        var a = 167;
        var b = 167;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real mod Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real mod Unsigned-real :: type mismatch");
    });

    addFact("mod - Unsigned-real mod Signed-real", function() {
        var result_ct = 167 mod 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real mod Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real mod Signed-real :: type mismatch");
    });

    addFact("mod - Signed-real mod 0b", function() {
        var result_ct = 1.5 mod 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Signed-real mod 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real mod 0b :: type mismatch");
    });

    addFact("mod - Signed-real mod 0x", function() {
        var result_ct = 1.5 mod 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Signed-real mod 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real mod 0x :: type mismatch");
    });

    addFact("mod - Signed-real mod Unsigned-real", function() {
        var result_ct = 1.5 mod 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Signed-real mod Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real mod Unsigned-real :: type mismatch");
    });

    addFact("mod - Signed-real mod Signed-real", function() {
        var result_ct = 1.5 mod 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a mod b;

        assert_equals(result_ct == result_rt, true, "Signed-real mod Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real mod Signed-real :: type mismatch");
    });

    addFact("== - 0b == 0b", function() {
        var result_ct = 0b1011 == 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0b == 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b == 0b :: type mismatch");
    });

    addFact("== - 0b == 0x", function() {
        var result_ct = 0b1011 == 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0b == 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b == 0x :: type mismatch");
    });

    addFact("== - 0b == Unsigned-real", function() {
        var result_ct = 0b1011 == 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0b == Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b == Unsigned-real :: type mismatch");
    });

    addFact("== - 0b == Signed-real", function() {
        var result_ct = 0b1011 == 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0b == Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b == Signed-real :: type mismatch");
    });

    addFact("== - 0x == 0b", function() {
        var result_ct = 0xA7 == 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0x == 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x == 0b :: type mismatch");
    });

    addFact("== - 0x == 0x", function() {
        var result_ct = 0xA7 == 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0x == 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x == 0x :: type mismatch");
    });

    addFact("== - 0x == Unsigned-real", function() {
        var result_ct = 0xA7 == 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0x == Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x == Unsigned-real :: type mismatch");
    });

    addFact("== - 0x == Signed-real", function() {
        var result_ct = 0xA7 == 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "0x == Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x == Signed-real :: type mismatch");
    });

    addFact("== - Unsigned-real == 0b", function() {
        var result_ct = 167 == 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real == 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real == 0b :: type mismatch");
    });

    addFact("== - Unsigned-real == 0x", function() {
        var result_ct = 167 == 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real == 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real == 0x :: type mismatch");
    });

    addFact("== - Unsigned-real == Unsigned-real", function() {
        var result_ct = 167 == 167;
        var a = 167;
        var b = 167;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real == Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real == Unsigned-real :: type mismatch");
    });

    addFact("== - Unsigned-real == Signed-real", function() {
        var result_ct = 167 == 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real == Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real == Signed-real :: type mismatch");
    });

    addFact("== - Signed-real == 0b", function() {
        var result_ct = 1.5 == 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Signed-real == 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real == 0b :: type mismatch");
    });

    addFact("== - Signed-real == 0x", function() {
        var result_ct = 1.5 == 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Signed-real == 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real == 0x :: type mismatch");
    });

    addFact("== - Signed-real == Unsigned-real", function() {
        var result_ct = 1.5 == 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Signed-real == Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real == Unsigned-real :: type mismatch");
    });

    addFact("== - Signed-real == Signed-real", function() {
        var result_ct = 1.5 == 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a == b;

        assert_equals(result_ct == result_rt, true, "Signed-real == Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real == Signed-real :: type mismatch");
    });

    addFact("!= - 0b != 0b", function() {
        var result_ct = 0b1011 != 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0b != 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b != 0b :: type mismatch");
    });

    addFact("!= - 0b != 0x", function() {
        var result_ct = 0b1011 != 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0b != 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b != 0x :: type mismatch");
    });

    addFact("!= - 0b != Unsigned-real", function() {
        var result_ct = 0b1011 != 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0b != Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b != Unsigned-real :: type mismatch");
    });

    addFact("!= - 0b != Signed-real", function() {
        var result_ct = 0b1011 != 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0b != Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b != Signed-real :: type mismatch");
    });

    addFact("!= - 0x != 0b", function() {
        var result_ct = 0xA7 != 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0x != 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x != 0b :: type mismatch");
    });

    addFact("!= - 0x != 0x", function() {
        var result_ct = 0xA7 != 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0x != 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x != 0x :: type mismatch");
    });

    addFact("!= - 0x != Unsigned-real", function() {
        var result_ct = 0xA7 != 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0x != Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x != Unsigned-real :: type mismatch");
    });

    addFact("!= - 0x != Signed-real", function() {
        var result_ct = 0xA7 != 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "0x != Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x != Signed-real :: type mismatch");
    });

    addFact("!= - Unsigned-real != 0b", function() {
        var result_ct = 167 != 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real != 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real != 0b :: type mismatch");
    });

    addFact("!= - Unsigned-real != 0x", function() {
        var result_ct = 167 != 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real != 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real != 0x :: type mismatch");
    });

    addFact("!= - Unsigned-real != Unsigned-real", function() {
        var result_ct = 167 != 167;
        var a = 167;
        var b = 167;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real != Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real != Unsigned-real :: type mismatch");
    });

    addFact("!= - Unsigned-real != Signed-real", function() {
        var result_ct = 167 != 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real != Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real != Signed-real :: type mismatch");
    });

    addFact("!= - Signed-real != 0b", function() {
        var result_ct = 1.5 != 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Signed-real != 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real != 0b :: type mismatch");
    });

    addFact("!= - Signed-real != 0x", function() {
        var result_ct = 1.5 != 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Signed-real != 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real != 0x :: type mismatch");
    });

    addFact("!= - Signed-real != Unsigned-real", function() {
        var result_ct = 1.5 != 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Signed-real != Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real != Unsigned-real :: type mismatch");
    });

    addFact("!= - Signed-real != Signed-real", function() {
        var result_ct = 1.5 != 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a != b;

        assert_equals(result_ct == result_rt, true, "Signed-real != Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real != Signed-real :: type mismatch");
    });

    addFact("< - 0b < 0b", function() {
        var result_ct = 0b1011 < 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0b < 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b < 0b :: type mismatch");
    });

    addFact("< - 0b < 0x", function() {
        var result_ct = 0b1011 < 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0b < 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b < 0x :: type mismatch");
    });

    addFact("< - 0b < Unsigned-real", function() {
        var result_ct = 0b1011 < 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0b < Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b < Unsigned-real :: type mismatch");
    });

    addFact("< - 0b < Signed-real", function() {
        var result_ct = 0b1011 < 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0b < Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b < Signed-real :: type mismatch");
    });

    addFact("< - 0x < 0b", function() {
        var result_ct = 0xA7 < 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0x < 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x < 0b :: type mismatch");
    });

    addFact("< - 0x < 0x", function() {
        var result_ct = 0xA7 < 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0x < 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x < 0x :: type mismatch");
    });

    addFact("< - 0x < Unsigned-real", function() {
        var result_ct = 0xA7 < 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0x < Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x < Unsigned-real :: type mismatch");
    });

    addFact("< - 0x < Signed-real", function() {
        var result_ct = 0xA7 < 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "0x < Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x < Signed-real :: type mismatch");
    });

    addFact("< - Unsigned-real < 0b", function() {
        var result_ct = 167 < 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real < 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real < 0b :: type mismatch");
    });

    addFact("< - Unsigned-real < 0x", function() {
        var result_ct = 167 < 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real < 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real < 0x :: type mismatch");
    });

    addFact("< - Unsigned-real < Unsigned-real", function() {
        var result_ct = 167 < 167;
        var a = 167;
        var b = 167;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real < Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real < Unsigned-real :: type mismatch");
    });

    addFact("< - Unsigned-real < Signed-real", function() {
        var result_ct = 167 < 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real < Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real < Signed-real :: type mismatch");
    });

    addFact("< - Signed-real < 0b", function() {
        var result_ct = 1.5 < 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Signed-real < 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real < 0b :: type mismatch");
    });

    addFact("< - Signed-real < 0x", function() {
        var result_ct = 1.5 < 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Signed-real < 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real < 0x :: type mismatch");
    });

    addFact("< - Signed-real < Unsigned-real", function() {
        var result_ct = 1.5 < 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Signed-real < Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real < Unsigned-real :: type mismatch");
    });

    addFact("< - Signed-real < Signed-real", function() {
        var result_ct = 1.5 < 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a < b;

        assert_equals(result_ct == result_rt, true, "Signed-real < Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real < Signed-real :: type mismatch");
    });

    addFact("> - 0b > 0b", function() {
        var result_ct = 0b1011 > 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0b > 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b > 0b :: type mismatch");
    });

    addFact("> - 0b > 0x", function() {
        var result_ct = 0b1011 > 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0b > 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b > 0x :: type mismatch");
    });

    addFact("> - 0b > Unsigned-real", function() {
        var result_ct = 0b1011 > 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0b > Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b > Unsigned-real :: type mismatch");
    });

    addFact("> - 0b > Signed-real", function() {
        var result_ct = 0b1011 > 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0b > Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b > Signed-real :: type mismatch");
    });

    addFact("> - 0x > 0b", function() {
        var result_ct = 0xA7 > 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0x > 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x > 0b :: type mismatch");
    });

    addFact("> - 0x > 0x", function() {
        var result_ct = 0xA7 > 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0x > 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x > 0x :: type mismatch");
    });

    addFact("> - 0x > Unsigned-real", function() {
        var result_ct = 0xA7 > 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0x > Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x > Unsigned-real :: type mismatch");
    });

    addFact("> - 0x > Signed-real", function() {
        var result_ct = 0xA7 > 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "0x > Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x > Signed-real :: type mismatch");
    });

    addFact("> - Unsigned-real > 0b", function() {
        var result_ct = 167 > 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real > 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real > 0b :: type mismatch");
    });

    addFact("> - Unsigned-real > 0x", function() {
        var result_ct = 167 > 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real > 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real > 0x :: type mismatch");
    });

    addFact("> - Unsigned-real > Unsigned-real", function() {
        var result_ct = 167 > 167;
        var a = 167;
        var b = 167;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real > Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real > Unsigned-real :: type mismatch");
    });

    addFact("> - Unsigned-real > Signed-real", function() {
        var result_ct = 167 > 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real > Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real > Signed-real :: type mismatch");
    });

    addFact("> - Signed-real > 0b", function() {
        var result_ct = 1.5 > 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Signed-real > 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real > 0b :: type mismatch");
    });

    addFact("> - Signed-real > 0x", function() {
        var result_ct = 1.5 > 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Signed-real > 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real > 0x :: type mismatch");
    });

    addFact("> - Signed-real > Unsigned-real", function() {
        var result_ct = 1.5 > 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Signed-real > Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real > Unsigned-real :: type mismatch");
    });

    addFact("> - Signed-real > Signed-real", function() {
        var result_ct = 1.5 > 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a > b;

        assert_equals(result_ct == result_rt, true, "Signed-real > Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real > Signed-real :: type mismatch");
    });

    addFact("<= - 0b <= 0b", function() {
        var result_ct = 0b1011 <= 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0b <= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b <= 0b :: type mismatch");
    });

    addFact("<= - 0b <= 0x", function() {
        var result_ct = 0b1011 <= 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0b <= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b <= 0x :: type mismatch");
    });

    addFact("<= - 0b <= Unsigned-real", function() {
        var result_ct = 0b1011 <= 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0b <= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b <= Unsigned-real :: type mismatch");
    });

    addFact("<= - 0b <= Signed-real", function() {
        var result_ct = 0b1011 <= 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0b <= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b <= Signed-real :: type mismatch");
    });

    addFact("<= - 0x <= 0b", function() {
        var result_ct = 0xA7 <= 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0x <= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x <= 0b :: type mismatch");
    });

    addFact("<= - 0x <= 0x", function() {
        var result_ct = 0xA7 <= 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0x <= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x <= 0x :: type mismatch");
    });

    addFact("<= - 0x <= Unsigned-real", function() {
        var result_ct = 0xA7 <= 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0x <= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x <= Unsigned-real :: type mismatch");
    });

    addFact("<= - 0x <= Signed-real", function() {
        var result_ct = 0xA7 <= 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "0x <= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x <= Signed-real :: type mismatch");
    });

    addFact("<= - Unsigned-real <= 0b", function() {
        var result_ct = 167 <= 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real <= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real <= 0b :: type mismatch");
    });

    addFact("<= - Unsigned-real <= 0x", function() {
        var result_ct = 167 <= 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real <= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real <= 0x :: type mismatch");
    });

    addFact("<= - Unsigned-real <= Unsigned-real", function() {
        var result_ct = 167 <= 167;
        var a = 167;
        var b = 167;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real <= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real <= Unsigned-real :: type mismatch");
    });

    addFact("<= - Unsigned-real <= Signed-real", function() {
        var result_ct = 167 <= 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real <= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real <= Signed-real :: type mismatch");
    });

    addFact("<= - Signed-real <= 0b", function() {
        var result_ct = 1.5 <= 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Signed-real <= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real <= 0b :: type mismatch");
    });

    addFact("<= - Signed-real <= 0x", function() {
        var result_ct = 1.5 <= 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Signed-real <= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real <= 0x :: type mismatch");
    });

    addFact("<= - Signed-real <= Unsigned-real", function() {
        var result_ct = 1.5 <= 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Signed-real <= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real <= Unsigned-real :: type mismatch");
    });

    addFact("<= - Signed-real <= Signed-real", function() {
        var result_ct = 1.5 <= 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a <= b;

        assert_equals(result_ct == result_rt, true, "Signed-real <= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real <= Signed-real :: type mismatch");
    });

    addFact(">= - 0b >= 0b", function() {
        var result_ct = 0b1011 >= 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0b >= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >= 0b :: type mismatch");
    });

    addFact(">= - 0b >= 0x", function() {
        var result_ct = 0b1011 >= 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0b >= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >= 0x :: type mismatch");
    });

    addFact(">= - 0b >= Unsigned-real", function() {
        var result_ct = 0b1011 >= 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0b >= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >= Unsigned-real :: type mismatch");
    });

    addFact(">= - 0b >= Signed-real", function() {
        var result_ct = 0b1011 >= 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0b >= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b >= Signed-real :: type mismatch");
    });

    addFact(">= - 0x >= 0b", function() {
        var result_ct = 0xA7 >= 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0x >= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >= 0b :: type mismatch");
    });

    addFact(">= - 0x >= 0x", function() {
        var result_ct = 0xA7 >= 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0x >= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >= 0x :: type mismatch");
    });

    addFact(">= - 0x >= Unsigned-real", function() {
        var result_ct = 0xA7 >= 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0x >= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >= Unsigned-real :: type mismatch");
    });

    addFact(">= - 0x >= Signed-real", function() {
        var result_ct = 0xA7 >= 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "0x >= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x >= Signed-real :: type mismatch");
    });

    addFact(">= - Unsigned-real >= 0b", function() {
        var result_ct = 167 >= 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >= 0b :: type mismatch");
    });

    addFact(">= - Unsigned-real >= 0x", function() {
        var result_ct = 167 >= 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >= 0x :: type mismatch");
    });

    addFact(">= - Unsigned-real >= Unsigned-real", function() {
        var result_ct = 167 >= 167;
        var a = 167;
        var b = 167;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >= Unsigned-real :: type mismatch");
    });

    addFact(">= - Unsigned-real >= Signed-real", function() {
        var result_ct = 167 >= 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real >= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real >= Signed-real :: type mismatch");
    });

    addFact(">= - Signed-real >= 0b", function() {
        var result_ct = 1.5 >= 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Signed-real >= 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >= 0b :: type mismatch");
    });

    addFact(">= - Signed-real >= 0x", function() {
        var result_ct = 1.5 >= 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Signed-real >= 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >= 0x :: type mismatch");
    });

    addFact(">= - Signed-real >= Unsigned-real", function() {
        var result_ct = 1.5 >= 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Signed-real >= Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >= Unsigned-real :: type mismatch");
    });

    addFact(">= - Signed-real >= Signed-real", function() {
        var result_ct = 1.5 >= 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a >= b;

        assert_equals(result_ct == result_rt, true, "Signed-real >= Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real >= Signed-real :: type mismatch");
    });

    addFact("&& - 0b && 0b", function() {
        var result_ct = 0b1011 && 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0b && 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b && 0b :: type mismatch");
    });

    addFact("&& - 0b && 0x", function() {
        var result_ct = 0b1011 && 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0b && 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b && 0x :: type mismatch");
    });

    addFact("&& - 0b && Unsigned-real", function() {
        var result_ct = 0b1011 && 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0b && Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b && Unsigned-real :: type mismatch");
    });

    addFact("&& - 0b && Signed-real", function() {
        var result_ct = 0b1011 && 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0b && Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b && Signed-real :: type mismatch");
    });

    addFact("&& - 0x && 0b", function() {
        var result_ct = 0xA7 && 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0x && 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x && 0b :: type mismatch");
    });

    addFact("&& - 0x && 0x", function() {
        var result_ct = 0xA7 && 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0x && 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x && 0x :: type mismatch");
    });

    addFact("&& - 0x && Unsigned-real", function() {
        var result_ct = 0xA7 && 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0x && Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x && Unsigned-real :: type mismatch");
    });

    addFact("&& - 0x && Signed-real", function() {
        var result_ct = 0xA7 && 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "0x && Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x && Signed-real :: type mismatch");
    });

    addFact("&& - Unsigned-real && 0b", function() {
        var result_ct = 167 && 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real && 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real && 0b :: type mismatch");
    });

    addFact("&& - Unsigned-real && 0x", function() {
        var result_ct = 167 && 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real && 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real && 0x :: type mismatch");
    });

    addFact("&& - Unsigned-real && Unsigned-real", function() {
        var result_ct = 167 && 167;
        var a = 167;
        var b = 167;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real && Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real && Unsigned-real :: type mismatch");
    });

    addFact("&& - Unsigned-real && Signed-real", function() {
        var result_ct = 167 && 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real && Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real && Signed-real :: type mismatch");
    });

    addFact("&& - Signed-real && 0b", function() {
        var result_ct = 1.5 && 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Signed-real && 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real && 0b :: type mismatch");
    });

    addFact("&& - Signed-real && 0x", function() {
        var result_ct = 1.5 && 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Signed-real && 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real && 0x :: type mismatch");
    });

    addFact("&& - Signed-real && Unsigned-real", function() {
        var result_ct = 1.5 && 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Signed-real && Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real && Unsigned-real :: type mismatch");
    });

    addFact("&& - Signed-real && Signed-real", function() {
        var result_ct = 1.5 && 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a && b;

        assert_equals(result_ct == result_rt, true, "Signed-real && Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real && Signed-real :: type mismatch");
    });

    addFact("|| - 0b || 0b", function() {
        var result_ct = 0b1011 || 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0b || 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b || 0b :: type mismatch");
    });

    addFact("|| - 0b || 0x", function() {
        var result_ct = 0b1011 || 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0b || 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b || 0x :: type mismatch");
    });

    addFact("|| - 0b || Unsigned-real", function() {
        var result_ct = 0b1011 || 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0b || Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b || Unsigned-real :: type mismatch");
    });

    addFact("|| - 0b || Signed-real", function() {
        var result_ct = 0b1011 || 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0b || Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b || Signed-real :: type mismatch");
    });

    addFact("|| - 0x || 0b", function() {
        var result_ct = 0xA7 || 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0x || 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x || 0b :: type mismatch");
    });

    addFact("|| - 0x || 0x", function() {
        var result_ct = 0xA7 || 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0x || 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x || 0x :: type mismatch");
    });

    addFact("|| - 0x || Unsigned-real", function() {
        var result_ct = 0xA7 || 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0x || Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x || Unsigned-real :: type mismatch");
    });

    addFact("|| - 0x || Signed-real", function() {
        var result_ct = 0xA7 || 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "0x || Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x || Signed-real :: type mismatch");
    });

    addFact("|| - Unsigned-real || 0b", function() {
        var result_ct = 167 || 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real || 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real || 0b :: type mismatch");
    });

    addFact("|| - Unsigned-real || 0x", function() {
        var result_ct = 167 || 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real || 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real || 0x :: type mismatch");
    });

    addFact("|| - Unsigned-real || Unsigned-real", function() {
        var result_ct = 167 || 167;
        var a = 167;
        var b = 167;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real || Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real || Unsigned-real :: type mismatch");
    });

    addFact("|| - Unsigned-real || Signed-real", function() {
        var result_ct = 167 || 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real || Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real || Signed-real :: type mismatch");
    });

    addFact("|| - Signed-real || 0b", function() {
        var result_ct = 1.5 || 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Signed-real || 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real || 0b :: type mismatch");
    });

    addFact("|| - Signed-real || 0x", function() {
        var result_ct = 1.5 || 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Signed-real || 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real || 0x :: type mismatch");
    });

    addFact("|| - Signed-real || Unsigned-real", function() {
        var result_ct = 1.5 || 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Signed-real || Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real || Unsigned-real :: type mismatch");
    });

    addFact("|| - Signed-real || Signed-real", function() {
        var result_ct = 1.5 || 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a || b;

        assert_equals(result_ct == result_rt, true, "Signed-real || Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real || Signed-real :: type mismatch");
    });

    addFact("^^ - 0b ^^ 0b", function() {
        var result_ct = 0b1011 ^^ 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0b ^^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^^ 0b :: type mismatch");
    });

    addFact("^^ - 0b ^^ 0x", function() {
        var result_ct = 0b1011 ^^ 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0b ^^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^^ 0x :: type mismatch");
    });

    addFact("^^ - 0b ^^ Unsigned-real", function() {
        var result_ct = 0b1011 ^^ 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0b ^^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^^ Unsigned-real :: type mismatch");
    });

    addFact("^^ - 0b ^^ Signed-real", function() {
        var result_ct = 0b1011 ^^ 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0b ^^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ^^ Signed-real :: type mismatch");
    });

    addFact("^^ - 0x ^^ 0b", function() {
        var result_ct = 0xA7 ^^ 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0x ^^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^^ 0b :: type mismatch");
    });

    addFact("^^ - 0x ^^ 0x", function() {
        var result_ct = 0xA7 ^^ 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0x ^^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^^ 0x :: type mismatch");
    });

    addFact("^^ - 0x ^^ Unsigned-real", function() {
        var result_ct = 0xA7 ^^ 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0x ^^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^^ Unsigned-real :: type mismatch");
    });

    addFact("^^ - 0x ^^ Signed-real", function() {
        var result_ct = 0xA7 ^^ 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "0x ^^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ^^ Signed-real :: type mismatch");
    });

    addFact("^^ - Unsigned-real ^^ 0b", function() {
        var result_ct = 167 ^^ 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^^ 0b :: type mismatch");
    });

    addFact("^^ - Unsigned-real ^^ 0x", function() {
        var result_ct = 167 ^^ 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^^ 0x :: type mismatch");
    });

    addFact("^^ - Unsigned-real ^^ Unsigned-real", function() {
        var result_ct = 167 ^^ 167;
        var a = 167;
        var b = 167;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^^ Unsigned-real :: type mismatch");
    });

    addFact("^^ - Unsigned-real ^^ Signed-real", function() {
        var result_ct = 167 ^^ 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ^^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ^^ Signed-real :: type mismatch");
    });

    addFact("^^ - Signed-real ^^ 0b", function() {
        var result_ct = 1.5 ^^ 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^^ 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^^ 0b :: type mismatch");
    });

    addFact("^^ - Signed-real ^^ 0x", function() {
        var result_ct = 1.5 ^^ 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^^ 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^^ 0x :: type mismatch");
    });

    addFact("^^ - Signed-real ^^ Unsigned-real", function() {
        var result_ct = 1.5 ^^ 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^^ Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^^ Unsigned-real :: type mismatch");
    });

    addFact("^^ - Signed-real ^^ Signed-real", function() {
        var result_ct = 1.5 ^^ 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a ^^ b;

        assert_equals(result_ct == result_rt, true, "Signed-real ^^ Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ^^ Signed-real :: type mismatch");
    });

    addFact("?? - 0b ?? 0b", function() {
        var result_ct = 0b1011 ?? 0b1011;
        var a = 0b1011;
        var b = 0b1011;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0b ?? 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ?? 0b :: type mismatch");
    });

    addFact("?? - 0b ?? 0x", function() {
        var result_ct = 0b1011 ?? 0xA7;
        var a = 0b1011;
        var b = 0xA7;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0b ?? 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ?? 0x :: type mismatch");
    });

    addFact("?? - 0b ?? Unsigned-real", function() {
        var result_ct = 0b1011 ?? 167;
        var a = 0b1011;
        var b = 167;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0b ?? Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ?? Unsigned-real :: type mismatch");
    });

    addFact("?? - 0b ?? Signed-real", function() {
        var result_ct = 0b1011 ?? 1.5;
        var a = 0b1011;
        var b = 1.5;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0b ?? Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0b ?? Signed-real :: type mismatch");
    });

    addFact("?? - 0x ?? 0b", function() {
        var result_ct = 0xA7 ?? 0b1011;
        var a = 0xA7;
        var b = 0b1011;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0x ?? 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ?? 0b :: type mismatch");
    });

    addFact("?? - 0x ?? 0x", function() {
        var result_ct = 0xA7 ?? 0xA7;
        var a = 0xA7;
        var b = 0xA7;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0x ?? 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ?? 0x :: type mismatch");
    });

    addFact("?? - 0x ?? Unsigned-real", function() {
        var result_ct = 0xA7 ?? 167;
        var a = 0xA7;
        var b = 167;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0x ?? Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ?? Unsigned-real :: type mismatch");
    });

    addFact("?? - 0x ?? Signed-real", function() {
        var result_ct = 0xA7 ?? 1.5;
        var a = 0xA7;
        var b = 1.5;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "0x ?? Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "0x ?? Signed-real :: type mismatch");
    });

    addFact("?? - Unsigned-real ?? 0b", function() {
        var result_ct = 167 ?? 0b1011;
        var a = 167;
        var b = 0b1011;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ?? 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ?? 0b :: type mismatch");
    });

    addFact("?? - Unsigned-real ?? 0x", function() {
        var result_ct = 167 ?? 0xA7;
        var a = 167;
        var b = 0xA7;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ?? 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ?? 0x :: type mismatch");
    });

    addFact("?? - Unsigned-real ?? Unsigned-real", function() {
        var result_ct = 167 ?? 167;
        var a = 167;
        var b = 167;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ?? Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ?? Unsigned-real :: type mismatch");
    });

    addFact("?? - Unsigned-real ?? Signed-real", function() {
        var result_ct = 167 ?? 1.5;
        var a = 167;
        var b = 1.5;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Unsigned-real ?? Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Unsigned-real ?? Signed-real :: type mismatch");
    });

    addFact("?? - Signed-real ?? 0b", function() {
        var result_ct = 1.5 ?? 0b1011;
        var a = 1.5;
        var b = 0b1011;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Signed-real ?? 0b :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ?? 0b :: type mismatch");
    });

    addFact("?? - Signed-real ?? 0x", function() {
        var result_ct = 1.5 ?? 0xA7;
        var a = 1.5;
        var b = 0xA7;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Signed-real ?? 0x :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ?? 0x :: type mismatch");
    });

    addFact("?? - Signed-real ?? Unsigned-real", function() {
        var result_ct = 1.5 ?? 167;
        var a = 1.5;
        var b = 167;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Signed-real ?? Unsigned-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ?? Unsigned-real :: type mismatch");
    });

    addFact("?? - Signed-real ?? Signed-real", function() {
        var result_ct = 1.5 ?? 1.5;
        var a = 1.5;
        var b = 1.5;
        var result_rt = a ?? b;

        assert_equals(result_ct == result_rt, true, "Signed-real ?? Signed-real :: value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, "Signed-real ?? Signed-real :: type mismatch");
    });
#endregion
#region === Unary Operators ===

    addFact("! - !0b", function() {
        var result_ct = !0b1011;
        var a = 0b1011;
        var result_rt = !a;

        var name = "!0b";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("! - !0x", function() {
        var result_ct = !0xA7;
        var a = 0xA7;
        var result_rt = !a;

        var name = "!0x";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("! - !Unsigned-real", function() {
        var result_ct = !167;
        var a = 167;
        var result_rt = !a;

        var name = "!Unsigned-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("! - !Signed-real", function() {
        var result_ct = !1.5;
        var a = 1.5;
        var result_rt = !a;

        var name = "!Signed-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("- - -0b", function() {
        var result_ct = -0b1011;
        var a = 0b1011;
        var result_rt = -a;

        var name = "-0b";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("- - -0x", function() {
        var result_ct = -0xA7;
        var a = 0xA7;
        var result_rt = -a;

        var name = "-0x";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("- - -Unsigned-real", function() {
        var result_ct = -167;
        var a = 167;
        var result_rt = -a;

        var name = "-Unsigned-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("- - -Signed-real", function() {
        var result_ct = -1.5;
        var a = 1.5;
        var result_rt = -a;

        var name = "-Signed-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("~ - ~0b", function() {
        var result_ct = ~0b1011;
        var a = 0b1011;
        var result_rt = ~a;

        var name = "~0b";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("~ - ~0x", function() {
        var result_ct = ~0xA7;
        var a = 0xA7;
        var result_rt = ~a;

        var name = "~0x";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("~ - ~Unsigned-real", function() {
        var result_ct = ~167;
        var a = 167;
        var result_rt = ~a;

        var name = "~Unsigned-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });

    addFact("~ - ~Signed-real", function() {
        var result_ct = ~1.5;
        var a = 1.5;
        var result_rt = ~a;

        var name = "~Signed-real";
        assert_equals(result_ct == result_rt, true, name + ": value mismatch");
        assert_equals(typeof(result_ct) == typeof(result_rt), true, name + ": type mismatch");
    });
#endregion
#region === Single-Arg Functions ===

    addFact("sin - Single Arg", function() {
        var result_ct = sin(167.0);
        var a = 167.0;
        var result_rt = sin(a);

        assert_equals(result_ct == result_rt, true, "sin(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "sin(167.0): type mismatch");
    });

    addFact("cos - Single Arg", function() {
        var result_ct = cos(167.0);
        var a = 167.0;
        var result_rt = cos(a);

        assert_equals(result_ct == result_rt, true, "cos(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "cos(167.0): type mismatch");
    });

    addFact("tan - Single Arg", function() {
        var result_ct = tan(167.0);
        var a = 167.0;
        var result_rt = tan(a);

        assert_equals(result_ct == result_rt, true, "tan(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "tan(167.0): type mismatch");
    });

    addFact("ceil - Single Arg", function() {
        var result_ct = ceil(167.0);
        var a = 167.0;
        var result_rt = ceil(a);

        assert_equals(result_ct == result_rt, true, "ceil(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "ceil(167.0): type mismatch");
    });

    addFact("floor - Single Arg", function() {
        var result_ct = floor(167.0);
        var a = 167.0;
        var result_rt = floor(a);

        assert_equals(result_ct == result_rt, true, "floor(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "floor(167.0): type mismatch");
    });

    addFact("abs - Single Arg", function() {
        var result_ct = abs(167.0);
        var a = 167.0;
        var result_rt = abs(a);

        assert_equals(result_ct == result_rt, true, "abs(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "abs(167.0): type mismatch");
    });

    addFact("sign - Single Arg", function() {
        var result_ct = sign(167.0);
        var a = 167.0;
        var result_rt = sign(a);

        assert_equals(result_ct == result_rt, true, "sign(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "sign(167.0): type mismatch");
    });

    addFact("frac - Single Arg", function() {
        var result_ct = frac(167.0);
        var a = 167.0;
        var result_rt = frac(a);

        assert_equals(result_ct == result_rt, true, "frac(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "frac(167.0): type mismatch");
    });

    addFact("sqr - Single Arg", function() {
        var result_ct = sqr(167.0);
        var a = 167.0;
        var result_rt = sqr(a);

        assert_equals(result_ct == result_rt, true, "sqr(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "sqr(167.0): type mismatch");
    });

    addFact("exp - Single Arg", function() {
        var result_ct = exp(167.0);
        var a = 167.0;
        var result_rt = exp(a);

        assert_equals(result_ct == result_rt, true, "exp(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "exp(167.0): type mismatch");
    });

    addFact("ln - Single Arg", function() {
        var result_ct = ln(167.0);
        var a = 167.0;
        var result_rt = ln(a);

        assert_equals(result_ct == result_rt, true, "ln(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "ln(167.0): type mismatch");
    });

    addFact("log2 - Single Arg", function() {
        var result_ct = log2(167.0);
        var a = 167.0;
        var result_rt = log2(a);

        assert_equals(result_ct == result_rt, true, "log2(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "log2(167.0): type mismatch");
    });

    addFact("log10 - Single Arg", function() {
        var result_ct = log10(167.0);
        var a = 167.0;
        var result_rt = log10(a);

        assert_equals(result_ct == result_rt, true, "log10(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "log10(167.0): type mismatch");
    });

    addFact("chr - Single Arg", function() {
        var result_ct = chr(167.0);
        var a = 167.0;
        var result_rt = chr(a);

        assert_equals(result_ct == result_rt, true, "chr(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "chr(167.0): type mismatch");
    });

    addFact("int64 - Single Arg", function() {
        var result_ct = int64(167.0);
        var a = 167.0;
        var result_rt = int64(a);

        assert_equals(result_ct == result_rt, true, "int64(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "int64(167.0): type mismatch");
    });

    addFact("real - Single Arg", function() {
        var result_ct = real(167.0);
        var a = 167.0;
        var result_rt = real(a);

        assert_equals(result_ct == result_rt, true, "real(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "real(167.0): type mismatch");
    });

    addFact("variable_get_hash - Single Arg", function() {
        var result_ct = variable_get_hash(167.0);
        var a = 167.0;
        var result_rt = variable_get_hash(a);

        assert_equals(result_ct == result_rt, true, "variable_get_hash(167.0): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "variable_get_hash(167.0): type mismatch");
    });
#endregion
#region === Multi-Arg Functions ===

    addFact("power - 2 Arg(s)", function() {
        var result_ct = power(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = power(a0, a1);

        assert_equals(result_ct == result_rt, true, "power(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "power(3, 7): type mismatch");
    });

    addFact("min - 2 Arg(s)", function() {
        var result_ct = min(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = min(a0, a1);

        assert_equals(result_ct == result_rt, true, "min(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "min(3, 7): type mismatch");
    });

    addFact("max - 2 Arg(s)", function() {
        var result_ct = max(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = max(a0, a1);

        assert_equals(result_ct == result_rt, true, "max(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "max(3, 7): type mismatch");
    });

    addFact("mean - 2 Arg(s)", function() {
        var result_ct = mean(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = mean(a0, a1);

        assert_equals(result_ct == result_rt, true, "mean(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "mean(3, 7): type mismatch");
    });

    addFact("median - 2 Arg(s)", function() {
        var result_ct = median(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = median(a0, a1);

        assert_equals(result_ct == result_rt, true, "median(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "median(3, 7): type mismatch");
    });

    addFact("clamp - 3 Arg(s)", function() {
        var result_ct = clamp(3, 7, 0.5);
		var a0 = 3;
		var a1 = 7;
		var a2 = 0.5;
        var result_rt = clamp(a0, a1, a2);

        assert_equals(result_ct == result_rt, true, "clamp(3, 7, 0.5): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "clamp(3, 7, 0.5): type mismatch");
    });

    addFact("lerp - 3 Arg(s)", function() {
        var result_ct = lerp(3, 7, 0.5);
		var a0 = 3;
		var a1 = 7;
		var a2 = 0.5;
        var result_rt = lerp(a0, a1, a2);

        assert_equals(result_ct == result_rt, true, "lerp(3, 7, 0.5): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "lerp(3, 7, 0.5): type mismatch");
    });

    addFact("logn - 2 Arg(s)", function() {
        var result_ct = logn(3, 7);
		var a0 = 3;
		var a1 = 7;
        var result_rt = logn(a0, a1);

        assert_equals(result_ct == result_rt, true, "logn(3, 7): value mismatch");
        assert_equals(typeof(result_ct), typeof(result_rt), "logn(3, 7): type mismatch");
    });
#endregion

}
