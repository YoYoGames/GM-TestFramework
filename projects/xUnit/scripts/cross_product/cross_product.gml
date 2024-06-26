function cross_product(_a, _b) {

	var _result = new Vector3();
	
	_result.x = _a.y * _b.z - _a.z * _b.y;
	_result.y = _a.z * _b.x - _a.x * _b.z;
	_result.z = _a.x * _b.y - _a.y * _b.x;
	
	return _result;

}