
// feather ignore GM2017

/// @function ds_queue_to_array(queue)
/// @param {Id.DsQueue} queue The queue to be converted into an array.
/// @returns {Array<Any>}
/// @pure
function ds_queue_to_array(_queue) {

	var _output = [];
	
	repeat (ds_queue_size(_queue)) {
		var _value =  ds_queue_dequeue(_queue);
		array_push(_output,_value);
		ds_queue_enqueue(_queue, _value);
	}

	return _output;
}
