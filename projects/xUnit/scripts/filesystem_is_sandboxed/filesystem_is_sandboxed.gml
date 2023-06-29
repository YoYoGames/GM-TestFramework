
// feather ignore GM2017

/// @function filesystem_is_sandboxed()
/// @description Returns whether or not the filesystem is sandboxed.
/// @returns {Bool}
function filesystem_is_sandboxed() {
	static sandboxed = config_get_param("isSandboxed") ?? true;
	return sandboxed;
}