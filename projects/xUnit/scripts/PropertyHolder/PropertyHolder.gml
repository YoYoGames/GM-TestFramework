
/// @function PropertyHolder()
/// @description This constructor represents a PropertyHolder.
function PropertyHolder() : IConfigurable() constructor {

	/// @ignore
	properties = {};

	/// @function addProperty(propName, defaultValue, validator, setter, getter, private)
	/// @description Adds a new property to the scope.
	/// @param {String} _propName The name of the property.
	/// @param {Any} _defaultValue The default value of the property.
	/// @param {Function} _validator The validator function for this property.
	/// @param {Function} _setter The setter function for this property.
	/// @param {Function} _getter The getter function for this property.
	/// @param {Enum.AccessMode} _access The access level of the property (none, read or write).
	/// @returns {Any}
	static addProperty = function(_propName, _defaultValue = undefined, _validator = undefined, _setter = undefined, _getter = undefined, _access = undefined) {

		if (variable_struct_exists(properties, _propName)) {
			log_warning("addProperty : redeclaration of property '{0}'", _propName);
			removeProperty(_propName);
		}
		
		properties[$ _propName] = new Property(self, _propName, _defaultValue, _validator, _setter, _getter, _access);
		return _defaultValue;
	}

	/// @function removeProperty(propName)
	/// @description Removes a property from the scope.
	/// @param {String} _propName The name of the property.
	static removeProperty = function(_propName) {
		
		if (!variable_struct_exists(properties, _propName)) {
			log_warning("removeProperty :: trying to remove unexisting property '{0}'", _propName);
			return;
		}
		
		var _property = properties[$ _propName];
		_property.release();
		
		variable_struct_remove(properties, _propName);
	}

	/// @function set(propName, val)
	/// @description Sets the value of a given property, applying restrictions, validations and custom setter (if available).
	/// @param {String} _propName The name of the property to be set.
	/// @param {Any} _val The value to set the property to.
	static set = function(_propName, _val) {
		
		// Check if property can be set
		if (!variable_struct_exists(properties, _propName))
			throw log_error("set :: trying to set '{0}', property doesn't exist.", _propName);
		
		// Set property
		properties[$ _propName].set(_val);
	}
	
	/// @function get(propName)
	/// @description Gets the value of a given property, applying restrictions and custom getter (if available).
	/// @param {Any} _propName The name of the property to get the value of.
	/// @returns {Any}
	static get = function(_propName) {
	
		// Check if property can be set
		if (!variable_struct_exists(properties, _propName))
			throw log_error("get :: trying to get '{0}', property doesn't exist.", _propName);

		// Get property
		return properties[$ _propName].get();
	}

	/// @function showProperties(all)
	/// @description Prints the available properties inside the scope.
	/// @param {Bool} _all Show all properies or only public ones.
	static showProperties = function(_all = false) {
		
		var _header = string("# '{0}' Property List ####################", instanceof(self));
		show_debug_message(_header);
		var _names = variable_struct_get_names(properties);
		var _i = 0;
		repeat (variable_struct_names_count(properties)) {
			var _name = _names[_i++];
			var _property = properties[$ _name];
			if (!_all && _property.private) continue;
			show_debug_message(properties[$ _name]);
		}
		var _footer = string_repeat("#", string_length(_header))
		show_debug_message(_footer);
	}

	/// @function config(configuration)
	/// @description Configures the current instance (function needs to be explicitly called at the end of the constructor)
	/// @param {Struct} configuration A configuration struct.
	static config = function(_configuration) {
		
		if (!is_struct(_configuration)) return;
		
		var _names = variable_struct_get_names(_configuration);
		var _i = 0;
		repeat (variable_struct_names_count(_configuration)) {
			var _name = _names[_i++];
			set(_name, _configuration[$ _name]);
		}
	}

}

