
/// @function IPublisher()
/// @description This interface represents the implementation for a publisher.
function IPublisher() : PropertyHolder() constructor {

	/// @function publish(data)
	/// @description This function should implement the logic for publishing some data.
	/// @param {Any} data The data being publish
	static publish = function() {
		throw log_error("publish :: method was not implemented")
	}
}

