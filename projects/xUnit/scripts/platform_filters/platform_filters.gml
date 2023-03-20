
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

