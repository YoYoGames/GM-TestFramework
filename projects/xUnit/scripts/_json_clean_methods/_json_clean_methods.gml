function _json_clean_methods(_k, _v) {
	if (is_method(_v)) return string(_v);
	return _v
}