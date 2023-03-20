
// feather ignore GM2017

/// @function publisher_get(name, type)
/// @description Creates and/or fetches a publisher given a name.
/// @param {String} name This is the id to be given to the publisher.
/// @param {Function} type If the publisher doesn't exits a new one is created using this constructor.
function publisher_get(_name, _type = undefined) {
	
	static publishers = {};
	
	if (!variable_struct_exists(publishers, _name)) {
		if (is_undefined(_type)) {
			throw log_error("publisher_get :: no 'type' was provided for non-existing publisher.");
		}
		publishers[$ _name] = new _type();
	}
	
	return publishers[$ _name];
}

