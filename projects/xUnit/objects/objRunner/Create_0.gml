
#macro FRAMEWORK_SHOULD_CATCH false

/// @description Start Framework
/// This is the entry point for the frameowork execution.
testFramework = new TestFrameworkRun();

// ################# TEST SUITE REGISTRATION #################

// Register your test suites here...
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
testFramework.addSuite(BasicShaderUniformsTestSuite); /* needs fix */
testFramework.addSuite(BasicStringTestSuite);
testFramework.addSuite(BasicSurfaceTestSuite);
testFramework.addSuite(BasicTilemapTestSuite); /* needs fix */
testFramework.addSuite(BasicVariableTestSuite);
testFramework.addSuite(BasicWeakRefsTestSuite);
testFramework.addSuite(ResourceAudioBuffersTestSuite); /* needs fix */
testFramework.addSuite(ResourceAudioEffectsTestSuite);
testFramework.addSuite(ResourceAudioEmittersTestSuite);
testFramework.addSuite(ResourceAudioGroupsTestSuite);
testFramework.addSuite(ResourceAudioListenersTestSuite);
testFramework.addSuite(ResourceAudioLoopPointsTestSuite);
testFramework.addSuite(ResourceAudioSynchronisationTestSuite); /* needs fix */
testFramework.addSuite(ResourceCameraTestSuite);
testFramework.addSuite(ResourceEventsTestSuite);
testFramework.addSuite(ResourceLayersTestSuite);
testFramework.addSuite(ResourceSequenceTestSuite);
testFramework.addSuite(ResourceTimeSourceTestSuite);

// ###########################################################

socket = undefined;
network_buffer = undefined; 
 
using_remote_server = config_get_param("remote_server"); 
if (using_remote_server) { 
 
	// Using remote server 
	socket = network_create_socket(network_socket_tcp); 
	network_buffer = buffer_create(1, buffer_grow, 1); 
	 
	var _url = config_get_param("remote_server_address"); 
	var _port = config_get_param("remote_server_port");
	 
	network_connect_raw_async(socket, _url, _port); 
} else { 
	testFramework.run(undefined, {}); 
}