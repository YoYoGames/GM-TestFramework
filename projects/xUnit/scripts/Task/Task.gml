
/// @function Task(name)
/// @description This class represents a task.
function Task() : PropertyHolder() constructor {
	
	enum TaskState { None = 0, Running, Finished };
	
	static stateStrings = [ "None", "Running", "Finished" ];
		
	/// @ignore
	preRunFunc = function() {
		// Does nothing just skip to the run
		runFunc();
	};
	/// @ignore
	runFunc = function() {
		// Does nothing just skip to the post run
		postRunFunc();
	}	
	/// @ignore
	postRunFunc = function() {	
		// Execute finishing logic
		doFinish();
		
	};
	/// @ignore
	callbackFunc = undefined;

	// Used for internal purposes (should use getters) 
	/// @ignore 
	state = TaskState.None;
	/// @ignore
	diagnostics = {};

	/// @function run(callbackFunc, resultBag)
	/// @description Runs the current test.
	/// @param {Function} callbackFunc The function to be called at the end of execution.
	/// @param {Any} resultBag The result collector that is carried along between nested tests.
	static run = function(_callbackFunc = undefined) {
		
		if (isRunning()) throw log_error("run :: Task is already running");

		callbackFunc = _callbackFunc;
		
		doReset();
		doRun();
	}

	/// @function doRun()
	/// @description Internal running logic for the test.
	/// @ignore
	static doRun = function() {
		
		state = TaskState.Running;
		
		if (FRAMEWORK_SHOULD_CATCH) {
			try {
				preRunFunc();
			}
			catch(_error) {
				pushDiagnostic(_error, "exception");
				doFinish();
			}
		}
		else {
			preRunFunc();
		}
	}

	/// @function doReset()
	/// @description Internal reset logic for the test.
	/// @ignore
	static doReset = function() {
		state = TaskState.None;
		diagnostics = {};
	}

	/// @function doFinish()
	/// @description Internal finish logic for the test.
	/// @ignore
	doFinish = function() {
			
		state = TaskState.Finished;
		
		doCleanup();
		
		// If we are in debug mode
		if (FRAMEWORK_DEBUG && hasDiagnostics("exception")) {
			log_error(getDiagnostics("exception"));
		}
		
		// Call the callback method (if there is one)
		if (is_method(callbackFunc)) callbackFunc(self);
	}

	/// @function doCleanup()
	/// @description Internal cleanup logic for the test.
	/// @ignore
	static doCleanup = function() {
	
		// This is reserved to cleanup (NOT USED AT THE MOMENT)
		// Can be used when GameMaker becomes multithread.

	}

	/// @function getState()
	/// @description Gets the test state value.
	/// @returns {Real}
	static getState = function() {
		return state;
	}
	
	/// @function getStateString()
	/// @description Gets the test state string value.
	/// @returns {String}
	static getStateString = function() {
		return stateStrings[state];
	}
	
	/// @function isRunning()
	/// @description Returns whether or not the current task is running.
	/// @returns {Bool}
	static isRunning = function() {
		return state == TaskState.Running;
	}

	/// @function pushDiagnostic(diagnostic, tag)
	/// @param {Struct} diagnostic The diagnostic being pushed into the diagnostic bag.
	/// @param {String} tag The tag to be applied to the current diagnostic (allows filtering).
	static pushDiagnostic = function(_diagnostic, _tag) {
		
		if (!variable_struct_exists(diagnostics, _tag)) {
			diagnostics[$ _tag] = [];
		}
		
		array_push(diagnostics[$ _tag], _diagnostic);
	}

	/// @function getDiagnostics(tag)
	/// @description Gets the test execution diagnostics for a specific tag.
	/// @param {String} [tag] The diagnostics tag.
	/// @returns {Struct|Array|Any}
	static getDiagnostics = function(_tag = undefined) {
		return !is_undefined(_tag) ? diagnostics[$ _tag] : diagnostics;
	}

	/// @function hasDiagnostics(tag)
	/// @description Checks if the current test has generated any diagnostics.
	/// @param {String} [tag] The diagnostics tag.
	/// @returns {Bool}
	static hasDiagnostics = function(_tag = undefined) {
		// If there is a tag
		return (!is_undefined(_tag) ?
			// Check errors for tag
			array_length(diagnostics[$ _tag]) :
			// Check any error
			variable_struct_names_count(diagnostics)) > 0;
	}
	
	config(config_get(self));

}
