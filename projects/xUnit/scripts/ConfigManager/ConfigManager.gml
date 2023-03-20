

/// @function ConfigManager()
/// @description This class loads and stores the default configurations for other classes.
function ConfigManager() constructor {

	configs = {};

	/// @function getConfig(struct)
	/// @description Get the type based configuration for a given struct.
	/// @param {Struct|String} _struct The struct to get the config for (configuration is based on type).
	/// @returns {Struct}
	static getConfig = function(_struct) {
		
		var _typeName = is_string(_struct) ? _struct : instanceof(_struct);
		return configs[$ _typeName];
	}

	/// @function setConfig(struct, defaultConfig)
	/// @description Sets the configuration for the type of a given struct.
	/// @param {Struct|String} _struct The struct to set the config for (configuration is based on type).
	/// @param {Struct} _config The default configuration.
	/// @param {Bool} _overwrite Whether the config should be updated or overwritten.
	static setConfig = function(_struct, _config, _overwrite = false) {
		
		var _typeName = is_string(_struct) ? _struct : instanceof(_struct);
		
		// Set the value 
		if (!variable_struct_exists(configs, _typeName) || _overwrite) {
			configs[$ _typeName] = _config;
			return;
		}
		
		// Update the value
		var _current = configs[$ _typeName];
		var _names = variable_struct_get_names(_config);
		var _count = array_length(_names);
		for (var _i = 0; _i < _count; _i++) {
			var _name = _names[_i];
			_current[$ _name] = _config[$ _name];
		}
	}

	/// @function loadFromFile(struct)
	/// @param {String} _struct The struct to get the config for (configuration is based on type).	
	static loadFromFile = function(_filename) {
		
		if (!file_exists(_filename))
			throw log_error("loadFromFile :: config file doesn't exist");
		
		// Load file into a buffer
		var _buffer = buffer_load(_filename);
		
		// Read text from the buffer and parse it to a struct
		var _json = buffer_read(_buffer, buffer_string);
		var _struct = json_parse(_json);
		
		// Unflatten the data
		configs = struct_unflatten(_struct);
		
		// Delete the buffer
		buffer_delete(_buffer);
	}
}

