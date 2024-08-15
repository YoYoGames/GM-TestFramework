
/// @function HttpPublisher(configuration)
/// @description This class implements the logic to publish data through and http request.
/// @param {Struct} configuration The configuration to be used for this Publisher.
function HttpPublisher(_configuration = undefined) : IPublisher() constructor {
	
	// @ignore
	ip = addProperty("ip", "127.0.0.1", is_string);
	// @ignore
	endpoint = addProperty("endpoint", "tests", is_string);
	// @ignore
	port = addProperty("port", 8080, is_numeric);
	
	// @ignore
	requestId = undefined;
	
	/// @function publish(data)
	/// @description This function should implement the logic for publishing some data.
	/// @param {Any} data The data being publish
	static publish = function(_data) {
		
		var _url = string("http://{0}:{1}/{2}", ip, port, endpoint);
		
		var _body = {};
		_body.targetName = os_type_to_string(os_type);
		_body.isSandboxed = GM_is_sandboxed;
		_body.isCompiled = code_is_compiled();
		_body.isBrowser = platform_browser();
		_body.data = _data;
		
		var _headers = ds_map_create();
		_headers[? "content-type"] = "application/json";
	
		requestId = http_request(_url, "POST", _headers, json_stringify(_body));
	}
	
	/// @function getRequestId()
	/// @description Returns the request id of the http request.
	/// @returns {Real|Undefined}
	static getRequestId = function() {
		return requestId;
	}
	
	config(config_get(self));
	config(_configuration)
}

