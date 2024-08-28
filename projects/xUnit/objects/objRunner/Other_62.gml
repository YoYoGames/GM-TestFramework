/// @description Finish Framework

var _singleResult = http_publisher_get("$$single_result$$");

// Check if the asyncId of the publisher matches
if (_singleResult.getRequestId() == async_load[? "id"]) {
	show_debug_message(json_encode(async_load));
}


// Get the publisher create in the create event
var _resultPublisher = http_publisher_get("$$default$$");

// Check if the asyncId of the publisher matches
if (_resultPublisher.getRequestId() != async_load[? "id"]) return;

// Finish the game
game_end();