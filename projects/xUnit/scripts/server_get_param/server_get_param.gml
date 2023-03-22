
// feather ignore GM2017

/// @function server_get_param(param)
/// @description Returns parameter of the local server.
/// @param {String} param This is the paramenter to retrieve: 'ip', 'port', 'endpoint'.
/// @returns {Any}
function server_get_param(_param) {
	static serverConfig = config_get("Server");
	return serverConfig[$ _param];
}

