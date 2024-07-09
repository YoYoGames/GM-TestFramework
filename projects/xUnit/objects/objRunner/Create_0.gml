/// @description Start Framework
/// This is the entry point for the frameowork execution.
testFramework = new TestFrameworkRun();

// ################# TEST SUITE REGISTRATION #################

// Register your test suites here...
testFramework.addSuite(BasicArrayTestSuite);
testFramework.addSuite(BasicBufferTestSuite);
testFramework.addSuite(BasicDataStructuresGridTestSuite);
testFramework.addSuite(BasicDataStructuresListTestSuite);
testFramework.addSuite(BasicDataStructuresMapTestSuite);
testFramework.addSuite(BasicDataStructuresPriorityTestSuite);
testFramework.addSuite(BasicDataStructuresQueueTestSuite);
testFramework.addSuite(BasicDataStructuresStackTestSuite);
testFramework.addSuite(BasicDataTypesTestSuite);
testFramework.addSuite(BasicDateTimeTestSuite);
testFramework.addSuite(BasicFileTestSuite);
testFramework.addSuite(BasicFiltersEffectsTestSuite);
testFramework.addSuite(BasicHandlesTestSuite);
testFramework.addSuite(BasicIniTestSuite);
testFramework.addSuite(BasicJsonTestSuite);
testFramework.addSuite(BasicMathTestSuite);
testFramework.addSuite(BasicMatrixTestSuite);
testFramework.addSuite(BasicNetworkTestSuite);
testFramework.addSuite(BasicRandomTestSuite);
testFramework.addSuite(BasicRoomTestSuite);
testFramework.addSuite(BasicScriptTestSuite);
testFramework.addSuite(BasicShaderTestSuite);
testFramework.addSuite(BasicStringTestSuite);
testFramework.addSuite(BasicSurfaceTestSuite);
testFramework.addSuite(BasicTilemapTestSuite);
testFramework.addSuite(BasicVariableTestSuite);
testFramework.addSuite(BasicWeakRefsTestSuite);
testFramework.addSuite(ResourceAudioEffectsTestSuite);
testFramework.addSuite(ResourceCameraTestSuite);
testFramework.addSuite(ResourceEventsTestSuite);
testFramework.addSuite(ResourceLayersTestSuite);
testFramework.addSuite(ResourceSequenceTestSuite);
testFramework.addSuite(ResourceTimeSourceTestSuite);


// ###########################################################

testFramework.run(undefined, {});

