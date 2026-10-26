// Members that only exist as statics until a method writes them (GameMaker-Bugs#16301)
function ConstructorStaticShadowProbe() constructor {
	static list = undefined;
	static num = -1;
	static coalesce = undefined;
	static self_list = undefined;
	static cross = undefined;

	static get_list = function() {
		if (is_undefined(list)) list = [];
		return list;
	};

	static get_num = function() {
		if (num == -1) num = num + 6;
		return num;
	};

	static get_coalesce = function() {
		coalesce ??= [];
		return coalesce;
	};

	static get_self_list = function() {
		if (is_undefined(self.self_list)) self.self_list = [];
		return self.self_list;
	};

	static get_cross = function() {
		var _before = is_undefined(cross);
		make_cross();
		return _before && is_array(cross);
	};

	static make_cross = function() {
		cross = [];
	};

	static push_lazy = function(_value) {
		list ??= [];
		array_push(list, _value);
		return array_length(list);
	};
}

// Methods that share their name with a builtin function (GameMaker-Bugs#16304)
function ConstructorBuiltinNameProbe() constructor {
	static abs = function(_value) { return "member"; };
	static floor = function(_value) { return "member floor"; };
}

// A script function in a struct literal passed straight to a method or constructor (GameMaker-Bugs#16302)
function constructor_script_ref_target() {
	return 1;
}

function ConstructorScriptRefHolder() constructor {
	static take = function(_cfg) { return typeof(_cfg.fn); };
	static take_value = function(_value) { return typeof(_value); };
}

function ConstructorScriptRefCtor(_cfg) constructor {
	kind = typeof(_cfg.fn);
}

function constructor_script_ref_take(_cfg) {
	return typeof(_cfg.fn);
}

function BasicConstructorTestSuite() : TestSuite() constructor {

	// STATIC MEMBERS WRITTEN AND RE-READ IN THE SAME METHOD (GameMaker-Bugs#16301)

	addFact("static_shadow_read_test #1", function() {
		var _probe = new ConstructorStaticShadowProbe();
		var _result = _probe.get_list();
		assert_typeof(_result, "array", "#1.1 static member written then re-read in the same method should read the written value");
		assert_typeof(_probe.list, "array", "#1.2 static member written in a method should be set on the struct");
		assert_undefined(new ConstructorStaticShadowProbe().list, "#1.3 writing the member should not change the static");
	});

	addFact("static_shadow_read_test #2", function() {
		var _probe = new ConstructorStaticShadowProbe();
		assert_equals(_probe.get_num(), 5, "#2.1 static number read, written from its own value, then re-read should read the written value");
		assert_equals(new ConstructorStaticShadowProbe().num, -1, "#2.2 writing the member should not change the static");
	});

	addFact("static_shadow_read_test #3", function() {
		var _probe = new ConstructorStaticShadowProbe();
		assert_typeof(_probe.get_coalesce(), "array", "#3.1 static member ??= then re-read should read the written value");
	});

	addFact("static_shadow_read_test #4", function() {
		var _probe = new ConstructorStaticShadowProbe();
		assert_typeof(_probe.get_self_list(), "array", "#4.1 static member written then re-read through self. should read the written value");
	});

	addFact("static_shadow_read_test #5", function() {
		var _probe = new ConstructorStaticShadowProbe();
		assert_true(_probe.get_cross(), "#5.1 static member read, written by another method, then re-read should read the written value");
	});

	addFact("static_shadow_read_test #6", function() {
		var _probe = new ConstructorStaticShadowProbe();
		assert_equals(_probe.push_lazy(10), 1, "#6.1 lazy initialisation with ??= then array_push should push onto the new array");
		assert_equals(_probe.push_lazy(20), 2, "#6.2 second lazy push should push onto the same array");
		assert_array_equals(_probe.list, [10, 20], "#6.3 the struct should hold both pushed values");
	});

	// METHODS NAMED AFTER BUILTIN FUNCTIONS (GameMaker-Bugs#16304)

	addFact("builtin_named_method_test #1", function() {
		var _probe = new ConstructorBuiltinNameProbe();
		var _value = -3;
		assert_equals(_probe.abs(_value), "member", "#1.1 method named abs called with a variable argument should call the method");
		assert_equals(_probe.abs(-3), "member", "#1.2 method named abs called with a constant argument should call the method");
		assert_equals(_probe.floor(2.5), "member floor", "#1.3 method named floor called with a constant argument should call the method");
	});

	addFact("builtin_named_method_test #2", function() {
		var _probe = new ConstructorBuiltinNameProbe();
		assert_equals(_probe.abs(abs(-3)), "member", "#2.1 builtin abs as the argument of a method named abs should call the method");
		assert_equals(abs(-3), 3, "#2.2 builtin abs should still return the absolute value");
	});

	// SCRIPT FUNCTIONS IN STRUCT LITERALS PASSED TO METHODS AND CONSTRUCTORS (GameMaker-Bugs#16302)

	addFact("struct_literal_script_ref_test #1", function() {
		var _holder = new ConstructorScriptRefHolder();
		var _cfg = { fn: constructor_script_ref_target };
		assert_equals(typeof(constructor_script_ref_target), "ref", "#1.1 a script function should be a ref");
		assert_equals(_holder.take(_cfg), "ref", "#1.2 script function in a struct literal held in a local passed to a method should be a ref");
		assert_equals(_holder.take({ fn: constructor_script_ref_target }), "ref", "#1.3 script function in a struct literal passed straight to a method should be a ref");
	});

	addFact("struct_literal_script_ref_test #2", function() {
		var _cfg = { fn: constructor_script_ref_target };
		assert_equals(new ConstructorScriptRefCtor(_cfg).kind, "ref", "#2.1 script function in a struct literal held in a local passed to a constructor should be a ref");
		assert_equals(new ConstructorScriptRefCtor({ fn: constructor_script_ref_target }).kind, "ref", "#2.2 script function in a struct literal passed straight to a constructor should be a ref");
	});

	addFact("struct_literal_script_ref_test #3", function() {
		assert_equals(constructor_script_ref_take({ fn: constructor_script_ref_target }), "ref", "#3.1 script function in a struct literal passed straight to a function should be a ref");
	});

	addFact("struct_literal_script_ref_test #4", function() {
		var _holder = new ConstructorScriptRefHolder();
		assert_equals(_holder.take_value(constructor_script_ref_target), "ref", "#4.1 script function passed straight to a method should be a ref");
	});

}
