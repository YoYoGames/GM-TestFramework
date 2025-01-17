
#macro FRAMEWORK_SHOULD_CATCH false

#macro SINGLE_TEST_MODE false

// If single test mode is set to true this will be the path to the test being run
single_test_path = "BasicArrayTestSuite@array_copy test #1";

/// @description Start Framework
/// This is the entry point for the frameowork execution.
testFramework = new TestFrameworkRun();

// ################# TEST SUITE REGISTRATION #################

// Register your test suites here...
testFramework.addSuite(BasicAccessorExpressionsTestSuite);
testFramework.addSuite(BasicArrayTestSuite);
testFramework.addSuite(BasicAudioTestSuite);
testFramework.addSuite(BasicBase64TestSuite);
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
testFramework.addSuite(BasicNameofTestSuite);
testFramework.addSuite(BasicNetworkTestSuite);
testFramework.addSuite(BasicRandomTestSuite);
testFramework.addSuite(BasicRoomTestSuite);
testFramework.addSuite(BasicScriptTestSuite);
testFramework.addSuite(BasicShaderTestSuite);
testFramework.addSuite(BasicShaderUniformsTestSuite);
testFramework.addSuite(BasicStringTestSuite);
testFramework.addSuite(BasicSurfaceTestSuite);
testFramework.addSuite(BasicTilemapTestSuite);
testFramework.addSuite(BasicVariableTestSuite);
testFramework.addSuite(BasicWeakRefsTestSuite);
testFramework.addSuite(ResourceAudioBuffersTestSuite);
testFramework.addSuite(ResourceAudioEffectsTestSuite);
testFramework.addSuite(ResourceAudioEmittersTestSuite);
testFramework.addSuite(ResourceAudioGroupsTestSuite);
testFramework.addSuite(ResourceAudioListenersTestSuite);
testFramework.addSuite(ResourceAudioLoopPointsTestSuite);
testFramework.addSuite(ResourceAudioSynchronisationTestSuite);
testFramework.addSuite(ResourceCameraTestSuite);
testFramework.addSuite(ResourceEventsTestSuite);
testFramework.addSuite(ResourceLayersTestSuite);
testFramework.addSuite(ResourceSequenceTestSuite);
testFramework.addSuite(ResourceSpriteTestSuite);
testFramework.addSuite(ResourceTimeSourceTestSuite);

socket = undefined;
network_buffer = undefined; 
using_remote_server = false;

// ###########################################################

// Only update the remote server flag if this is NOT a single test mode
if (!SINGLE_TEST_MODE) {
	using_remote_server = config_get_param("remote_server");
}

if (using_remote_server) { 
 
	// Using remote server 
	socket = network_create_socket(network_socket_tcp); 
	network_buffer = buffer_create(1, buffer_grow, 1); 
	 
	var _url = config_get_param("remote_server_address"); 
	var _port = config_get_param("remote_server_port");
	 
	network_connect_raw_async(socket, _url, _port); 
} else {
	
	if (SINGLE_TEST_MODE) {
		var _test = testFramework.findTestByPath(single_test_path);
		_test.run(function(_test) {
	
			show_debug_message(_test.getResultData());
	
		}, { suite: "Unknown", results_to_publish: [] });
	} 
	else {		
		testFramework.run(undefined, {});
	}
}