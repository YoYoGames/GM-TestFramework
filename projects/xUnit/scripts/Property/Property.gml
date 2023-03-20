

/// @function Property(_owner, name, value, validator, setter, getter, private)
/// @description This constructor represents a Property.
/// @param {Struct.PropertyHolder} _owner The owner of this property.
/// @param {String} _name The name of the property.
/// @param {Any} _value The initial value of the property.
/// @param {Function} _validator The validator function for this property.
/// @param {Function} _setter The setter function for this property.
/// @param {Function} _getter The getter function for this property.
/// @param {Bool} _accessThe access level of the property (none, read or write).
function Property(_owner, _name, _value = undefined, _validator = undefined, _setter = undefined, _getter = undefined, _access = AccessMode.Read | AccessMode.Write) constructor  {
	
	enum AccessMode { None = 0, Read = 1, Write = 2}
	
	owner = _owner;
	name = _name;
	validator = _validator;
	setter = _setter;
	getter = _getter;
	access = _access;

	owner[$ _name] = _value;

	static set = function(_value) {
		
		if (access & AccessMode.Write == 0)
			throw log_error("set :: writing to property '{0}' is not allowed.", name);
		
		// Check if there is a validator functions call it
		if (is_callable(validator) && !validator(_value))
			throw log_error("set :: trying to set property '{0}' with an invalid value: {1}", name, _value);
		
		// If there is a setter function call it (else set the value directly)
		var _setter = setter;
		if (is_callable(setter)) with (owner) { _setter(_value); }
		else owner[$ name] = _value;

	}
	
	static get = function() {
	
		// Check if property can be set
		if (access & AccessMode.Read == 0)
			throw log_error("get :: accessing property '{0}' is not allowed.", name);
		
		// If there is a setter function call it (else set the value directly)
		var _getter = getter;
		if (is_callable(getter)) with (owner) { return _getter(); }
		else return owner[$ name];
	}

	static release = function() {
		owner = undefined;
	}

	static toString = function() {
		
		var _name = name;
		var _access = access ? "PRIVATE": "PUBLIC";
		
		return string("[{0}] {1}", _access, _name);
	}

}

