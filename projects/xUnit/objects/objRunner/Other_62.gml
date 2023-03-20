/// @description Finish Framework

// Get the publisher create in the create event
var _resultPublisher = publisher_get("$$default$$", HttpPublisher);

// Check if the asyncId of the publisher matches
if (_resultPublisher.asyncId != async_load[? "id"]) return;

// Finish the game
game_end();