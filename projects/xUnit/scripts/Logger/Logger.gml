
// feather ignore GM2017

/// @function Logger(configuration)
/// @description This class defines functions and classes which implement a flexible event logging system.
/// @param {Struct} configuration The logger configuration (see logger_* macros)
function Logger(_configuration = undefined) : PropertyHolder() constructor {

	#macro logger_level level
	#macro logger_time_format timeFormat
	#macro logger_message_format messageFormat

	enum LoggerLevel { NotSet = 0, Debug = 10, Info = 20, Warning = 30, Error = 40, Critical = 50 }
	
	/// @ignore
	level = addProperty("level", LoggerLevel.Debug, is_numeric);
	/// @ignore
	levelNames = { };
	levelNames[$ LoggerLevel.Debug] = "DEBUG";
	levelNames[$ LoggerLevel.Info] = "INFO";
	levelNames[$ LoggerLevel.Warning] = "WARNING";
	levelNames[$ LoggerLevel.Error] = "ERROR";
	levelNames[$ LoggerLevel.Critical] = "CRITICAL";
	
	/// @ignore
	timeFormat = addProperty("timeFormat", "{3}:{4}:{5}", is_string, setTimeFormat); 
	/// @ignore
	static timeFormatPlaceholder = struct_from_entries([ 
		["{Y}", "{0}"], 
		["{m}", "{1}"], 
		["{d}", "{2}"], 
		["{H}", "{3}"], 
		["{M}", "{4}"], 
		["{S}", "{5}"]
	]);
	
	/// @ignore
	messageFormat = addProperty("messageFormat", "[{2}]: {0}", is_string, setFormat);
	/// @ignore
	static messageFormatPlaceholder = struct_from_entries([ 
		["{message}", "{0}"], 
		["{time}", "{1}"], 
		["{level}", "{2}"], 
	]);
	
	/// @function log(level, message, args...)
	/// @description Logs a message with integer level 'level' on this logger.
	/// @param {Real} The level of the logged message.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static log = function(_level, _message, _args = undefined) {
		
		if (_level < level) return;
		
		var _timeString = "";
		if (!is_undefined(timeFormat)) {
			_timeString = string(timeFormat, current_year, current_month, current_day, current_hour, current_minute, current_second)
		}
		
		if (!is_string(_message)) _message = string(_message);
		if (is_array(_args)) _message = string_ext(_message, _args);

		var _messageString = _message;
		if (!is_undefined(messageFormat)) {
			_messageString = string(messageFormat, _message, _timeString, levelNames[$ _level]);
		}
		show_debug_message(messageFormat, _message, _timeString, levelNames[$ _level]);
		
		return _messageString;
	}
	
	/// @function debug(message, args...)
	/// @description Logs a message debug message on this logger.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static debug = function(_message, _args = undefined) {
		return log(LoggerLevel.Debug, _message, _args);
	}
	
	/// @function info(message, args...)
	/// @description Logs a message debug message on this logger.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static info = function(_message, _args = undefined) {
		return log(LoggerLevel.Info, _message, _args);
	}

	/// @function warning(message, args...)
	/// @description Logs a message debug message on this logger.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static warning = function(_message, _args = undefined) {
		return log(LoggerLevel.Warning, _message, _args);
	}
	
	/// @function error(message, args...)
	/// @description Logs a message debug message on this logger.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static error = function(_message, _args = undefined) {
		return log(LoggerLevel.Error, _message, _args);
	}
	
	/// @function critical(message, args...)
	/// @description Logs a message debug message on this logger.
	/// @param {String} message The message to be logged.
	/// @param {Array} args A set of arguments to be replaced in the logged message.
	static critical = function(_message, _args = undefined) {
		return log(LoggerLevel.Critical, _message, _args);
	}

	/// @function basicConfig(level, format, timeFormat)
	/// @description Sets the basic configuration to be used with the logger.
	/// @param {Real} level The threshould level to be used. 
	/// @param {String} format The message format to be used.
	/// @param {String} timeFormat THe time format to be used.
	static basicConfig = function(_level, _format = undefined, _timeFormat = undefined) {

		level = _level;

		// Only update time format if it is not undefined
		if (!is_undefined(_format)) setFormat(_format);

		// Only update time format if it is not undefined
		if (!is_undefined(_timeFormat)) setTimeFormat(_timeFormat);
	}

	/// @function setLevel(level)
	/// @description Sets the minimum threshold value to be used.
	/// @param {Real} level The threshould level to be used. 
	static setLevel = function(_level) {
		level = _level;
	}

	/// @function setFormat(format)
	/// @description Sets the log message format.
	/// @param {String} format The log message format (accepts placeholders {message}, {time} and {level}).
	static setFormat = function(_format) {
		
		static messagePlaceholders = variable_struct_get_names(messageFormatPlaceholder);
		static messagePlaceholdersCount = array_length(messagePlaceholders);
		
		for (var _i = 0; _i < messagePlaceholdersCount; ++_i) {
			var _name = messagePlaceholders[_i];
			_format = string_replace_all(_format, _name, messageFormatPlaceholder[$ _name]);
		}
		messageFormat = _format;
	}

	/// @function setTimeFormat(format)
	/// @description Sets the log time format.
	/// @param {String} format The log time format (accepts placeholders {Y}, {m}, {d}, {H}, {M} and {S}).
	static setTimeFormat = function(_format) {
			
		static timePlaceholders = variable_struct_get_names(timeFormatPlaceholder);
		static timePlaceholdersCount = array_length(timePlaceholders);
	
		for (var _i = 0; _i < timePlaceholdersCount; ++_i) {
			var _name = timePlaceholders[_i];
			_format = string_replace_all(_format, _name, timeFormatPlaceholder[$ _name]);
		}
		timeFormat = _format;
	}

	config(config_get(self));
	config(_configuration);
}

