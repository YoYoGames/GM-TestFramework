
// feather ignore GM2017

function platform_filters() {
	throw log_error("platform_filters :: you cannot call this function");
}

function platform_not_browser() {
	return os_browser == browser_not_a_browser;
}

function platform_browser() {
	return os_browser != browser_not_a_browser;
}

function platform_android() {
	return os_type == os_android && platform_not_browser();
}

function platform_ios() {
	return os_type == os_ios && platform_not_browser();
}

function platform_mobile() {
	return platform_android() || platform_ios();
}

function platform_windows() {
	return os_type == os_windows && platform_not_browser();
}

function platform_macosx() {
	return os_type == os_macosx && platform_not_browser();
}

function platform_linux() {
	return os_type == os_linux && platform_not_browser();
}

function platform_desktop() {
	return platform_windows() || platform_macosx() || platform_linux();
}

function platform_console() {
	return os_type == os_ps4 || os_type == os_ps5 || os_type == os_switch || os_type == os_xboxone || os_type == os_xboxseriesxs;
}

function platform_not_console() {
	return !platform_console();
}

function runtime_gmrt() {
	static _version_parts = string_split(GM_runtime_version, ".");
	static _major = real(_version_parts[0]);
	return _major < 2000;
}

function runtime_not_gmrt() {
	static _version_parts = string_split(GM_runtime_version, ".");
	static _major = real(_version_parts[0]);
	return _major >= 2000;
}