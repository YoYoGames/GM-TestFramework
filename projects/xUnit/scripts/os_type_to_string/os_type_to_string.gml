
// feather ignore GM2017

function os_type_to_string(_type) {
				 
	switch (_type) {
		case os_windows: return "windows";
		case os_macosx: return "macosx";
		case os_linux: return "linux";
		
		case os_ios: return "ios";
		case os_tvos: return "tvos";
		
		case os_android: return "android";

		case os_psvita: return "psvita";
		case os_ps3: return "ps3";
		case os_ps4: return "ps4";
		case os_ps5: return "ps5";
		
		case os_xboxone: return "xboxone";
		case os_xboxseriesxs: return "xboxseriesxs";
		
		case os_uwp: return "uwp";
		case os_winphone: return "winphone";
		
		case os_gxgames: return "gxgames";
		default: return "unknown";
	}
}
