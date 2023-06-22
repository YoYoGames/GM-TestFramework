
// feather ignore GM2017

/// @function channel_get_name(buffer_channel)
/// @param {Real} buffer_channel The `buffer_channel_*` macro to get the name of.
/// @returns {String}
/// @pure
function channel_get_name(_buffer_channel) {
	static channel_names = [ "red", "green", "blue", "alpha" ];
	return channel_names[_buffer_channel];
}
