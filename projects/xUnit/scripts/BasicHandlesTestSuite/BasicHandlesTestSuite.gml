function BasicHandlesTestSuite() : TestSuite() constructor {
    addFact("asset_reference_handles_test", function() {
        var test_data = [
            handle_testAnimationCurve, "handle_testAnimationCurve",
            handle_testFont, "handle_testFont",
            handle_testObject, "handle_testObject",
            handle_testParticleSystem, "handle_testParticleSystem",
            handle_testPath, "handle_testPath",
            handle_testRoom, "handle_testRoom",
            handle_testScript, "handle_testScript",
            handle_testFunction, "handle_testFunction",
            handle_testSequence, "handle_testSequence",
            handle_testShader, "handle_testShader",
            handle_testSound, "handle_testSound",
            handle_testSprite, "handle_testSprite",
            handle_testTileSet, "handle_testTileSet",
            handle_testTimeline, "handle_testTimeline",
            ];
            
        for (var i = 0; i < array_length(test_data); i += 2) {
            var asset = test_data[i + 0];
            var description = test_data[i + 1];
            var output = is_handle(asset);
            assert_true(output, $"is_handle({description}) should be true");
        }
    });
}
