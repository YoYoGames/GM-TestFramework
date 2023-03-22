
// feather ignore GM2017

/// @function config_manager_get()
/// @description Returns a default configuration manager.
/// @returns {Struct.ConfigManager}
function config_manager_get() {
	static configManager = new ConfigManager();
	return configManager;
}

/// @function config_manager_load(_filename)
/// @description Loads the given file data into the default configuration manager.
/// @param {String} _filename The path to the configuration file to be loaded.
function config_manager_load(_filename) {
	
	var _configManager = config_manager_get();
	_configManager.loadFromFile(_filename);
	
	return _configManager;
}

/// @function config_get(struct)
/// @description Get the type based configuration for a given struct (from the default configuration manager).
/// @param {Struct|String} _struct The struct to get the config for (configuration is based on type).
/// @returns {Struct}
function config_get(_struct_name) {
	
	var _configManager = config_manager_get();
	return _configManager.getConfig(_struct_name);
}

/// @function config_set(struct, config)
/// @description Sets the configuration for the type of a given struct (in the default configuration manager).
/// @param {Struct|String} _struct The struct to set the config for (configuration is based on type).
/// @param {Struct} _config The default configuration.
function config_set(_struct_name, _config) {
	
	var _configManager = config_manager_get();
	_configManager.setConfig(_struct_name, _config);
}

