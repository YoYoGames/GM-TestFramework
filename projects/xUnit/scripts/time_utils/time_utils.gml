
function time_utils() {
	throw log_error("time_utils :: you cannot call this function");
}

function time_get_epoch() {
	var _current_timezone = date_get_timezone();
	date_set_timezone(timezone_utc);
	var _epoch = date_create_datetime(1970, 1, 1, 0, 0, 0);
	date_set_timezone(_current_timezone);
	return _epoch;
}

function time_get_unix_timestamp(_datetime = date_current_datetime()) {
	
	static _epoch = time_get_epoch();
	
	var _result = date_second_span(_epoch, _datetime);
	
	return _result;
}

