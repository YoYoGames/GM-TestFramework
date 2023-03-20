
// feather ignore GM2017

/// @function logger_get(name)
/// @description Returns a logger with the specified name. All calls to this function with a given name return the same logger instance.
/// @param {String} name The name of the logger to be fetched.
/// @returns {Struct.Logger}
function logger_get(_name) {
	
	static loggers = {  };
	
	if (variable_struct_exists(loggers, _name)) return loggers[$ _name];
	
	var _logger = new Logger();
	loggers[$ _name] = _logger;
	
	return _logger;
}

/// @function log_debug(message, args...)
/// @description Logs a message debug message on the default logger.
/// @param {String} message The message to be logged.
/// @param {Any} args... A set of arguments to be replaced in the logged message.
function log_debug(_message) {

	static defaultLogger = logger_get("$$default$$");
	
	var _args = array_create(argument_count - 1);
	for (var _i = argument_count - 1; _i >= 1; _i--) {
		_args[_i - 1] = argument[_i];
	}
	
	return defaultLogger.debug(_message, _args);
}

/// @function log_info(message, args...)
/// @description Logs a message info message on the default logger.
/// @param {String} message The message to be logged.
/// @param {Any} args... A set of arguments to be replaced in the logged message.
function log_info(_message) {

	static defaultLogger = logger_get("$$default$$");
	
	var _args = array_create(argument_count - 1);
	for (var _i = argument_count - 1; _i >= 1; _i--) {
		_args[_i - 1] = argument[_i];
	}
	
	return defaultLogger.info(_message, _args);
}

/// @function log_warning(message, args...)
/// @description Logs a message warning message on the default logger.
/// @param {String} message The message to be logged.
/// @param {Any} args... A set of arguments to be replaced in the logged message.
function log_warning(_message) {

	static defaultLogger = logger_get("$$default$$");
	
	var _args = array_create(argument_count - 1);
	for (var _i = argument_count - 1; _i >= 1; _i--) {
		_args[_i - 1] = argument[_i];
	}
	
	return defaultLogger.warning(_message, _args);
}

/// @function log_error(message, args...)
/// @description Logs a message error message on the default logger.
/// @param {String} message The message to be logged.
/// @param {Any} args... A set of arguments to be replaced in the logged message.
function log_error(_message) {

	static defaultLogger = logger_get("$$default$$");
	
	var _args = array_create(argument_count - 1);
	for (var _i = argument_count - 1; _i >= 1; _i--) {
		_args[_i - 1] = argument[_i];
	}
	
	return defaultLogger.error(_message, _args);
}

/// @function log_critical(message, args...)
/// @description Logs a message critical message on the default logger.
/// @param {String} message The message to be logged.
/// @param {Any} args... A set of arguments to be replaced in the logged message.
function log_critical(_message) {

	static defaultLogger = logger_get("$$default$$");
	
	var _args = array_create(argument_count - 1);
	for (var _i = argument_count - 1; _i >= 1; _i--) {
		_args[_i - 1] = argument[_i];
	}
	
	return defaultLogger.critical(_message, _args);
}

