function normalize(_vector) {
	
	var _magnitude = sqrt(_vector.x*_vector.x + _vector.y*_vector.y + _vector.z*_vector.z);
	var _result = new Vector3()
	
	_result.x = _vector.x / _magnitude;
	_result.y = _vector.y / _magnitude;
	_result.z = _vector.z / _magnitude;
	
	return _result

}