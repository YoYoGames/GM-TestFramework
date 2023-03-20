
function performEventTest(_objectIndex, _eventType, _eventNumber) {

	if (!variable_global_exists("eventData")) return;

	var _func = global.eventData[0]
	var _object = global.eventData[1];
	var _event = global.eventData[2];
	var _subEvent = global.eventData[3];

	assert_equals(_object, _objectIndex, string("{0}, failed with wrong object '{1}'", _func, object_get_name(_objectIndex)));
	assert_equals(_event, _eventType, string("{0}, failed with wrong event type '{1}'", _func, event_to_string(_eventType)));
	assert_equals(_subEvent, _eventNumber, string("{0}, failed with wrong event sub-type '{1}'", _func, event_to_string(_eventNumber)));
}

performEventTest(object_index, event_type, event_number);

