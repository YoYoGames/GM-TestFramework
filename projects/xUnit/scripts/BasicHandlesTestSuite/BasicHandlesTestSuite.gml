function BasicHandlesTestSuite() : TestSuite() constructor {
    addTheory("asset_reference_handles_test", [
        [handle_testAnimationCurve, "handle_testAnimationCurve"],
        [handle_testFont, "handle_testFont"],
        [handle_testObject, "handle_testObject"],
        [handle_testParticleSystem, "handle_testParticleSystem"],
        [handle_testPath, "handle_testPath"],
        [handle_testRoom, "handle_testRoom"],
        //[handle_testScript, "handle_testScript"],
        [handle_testFunction, "handle_testFunction"],
        [handle_testSequence, "handle_testSequence"],
        [handle_testShader, "handle_testShader"],
        [handle_testSound, "handle_testSound"],
        [handle_testSprite, "handle_testSprite"],
        [handle_testTileSet, "handle_testTileSet"],
        [handle_testTimeline, "handle_testTimeline"],
    ], function(asset, name) {            
        var output = is_handle(asset);
        assert_true(output, $"is_handle({name}) should be true");
    });
}
