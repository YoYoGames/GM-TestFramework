

function BasicRoomTestSuite() : TestSuite() constructor {

	addTestAsync("room_goto_test", objTestAsyncRoomChange, {
		
		ev_create: function() {
			
			// At this point in time the room is ALWAYS 'rmEmpty'
			// This is an internal room where all the tests start
			
			// Create your object (make sure it is persistent)
			
			room_goto(room0);
		},
		
		ev_room_start: function() {
			
			assert_true(room == room0, "The room didn't change!");
			
			// Check if your object exists (it should if it is persistent)
			
			// The test only ends when you call this
			test_end(); // Be sure to call this
		},
		
		ev_room_end: function() {
			
			// You can add code here too!
			
		},
	}, {
		// Make sure we give this test a timeout (1 second is enough for this test)
		test_timeout_millis: 1000 
	});
}

