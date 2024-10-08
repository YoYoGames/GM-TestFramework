
// feather ignore GM2017

/// @function publisher_get(name, type)
/// @description Creates and/or fetches a publisher given a name.
/// @param {String} name This is the id to be given to the publisher.
/// @param {Function} type If the publisher doesn't exits a new one is created using this constructor.
function publisher_get(_name, _type = undefined, _config = {}) {
	
	static publishers = {};
	
	if (!variable_struct_exists(publishers, _name)) {
		if (is_undefined(_type)) {
			throw log_error("publisher_get :: no 'type' was provided for non-existing publisher.");
		}
		publishers[$ _name] = new _type(_config);
	}
	
	return publishers[$ _name];
}

/// @function http_publisher_get(name)
/// @description Creates and/or fetches an http publisher given a name.
/// @param {String} name This is the id to be given to the http publisher.
/// @returns {Struct.HttpPublisher}
function http_publisher_get(_name, _config = {}) {
	return publisher_get(_name, HttpPublisher, _config);
}

