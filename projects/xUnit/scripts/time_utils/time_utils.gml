
function time_utils() {
	throw log_error("time_utils :: you cannot call this function");
}

function time_get_unix_timestamp() {
	return date_second_span(date_create_datetime(1970,1,1,0,0,0), date_current_datetime());
}