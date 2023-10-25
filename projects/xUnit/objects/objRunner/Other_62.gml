/// @description Finish Framework

// Get the publisher create in the create event
var _resultPublisher = http_publisher_get("$$default$$");

// Check if the asyncId of the publisher matches
if (_resultPublisher.getRequestId() != async_load[? "id"]) return;

// Finish the game
// game_end();