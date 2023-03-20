
/// @function IConfigurable()
/// @description This constructor represents an IConfigurable interface.
function IConfigurable() constructor {
	
	/// @function config(configuration)
	/// @description Configures the current instance (function needs to be explicitly called at the end of the constructor)
	/// @param {Struct} configuration A configuration struct.
	static config = function(_configuration) {
		throw log_error("config :: function not implemented.");
	}
	
}

