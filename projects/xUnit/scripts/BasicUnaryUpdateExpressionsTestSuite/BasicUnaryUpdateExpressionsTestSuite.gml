

function BasicUnaryUpdateExpressionsTestSuite() : TestSuite() constructor {

	// Each fact seeds the exact precondition value directly instead of chaining through
	// prior operations, so a failure localises to one read/write instead of a sequence.
	// "Get (Final)" facts are the exception: they run the natural op chain from the
	// initial value and assert only the net result, to keep the round-trip check.

	// VARIABLE TARGETS

	addFact("Direct Variable Unary Update - Get", function() {
		x = 0;

		assert_equals(x, 0, "Direct variable get failed.");
	});

	addFact("Direct Variable Unary Update - PlusPlus Suffix", function() {
		x = 0;

		assert_equals(x++, 0, "Direct variable PlusPlus Suffix failed.");
	});

	addFact("Direct Variable Unary Update - PlusPlus Prefix", function() {
		x = 1;

		assert_equals(++x, 2, "Direct variable PlusPlus Prefix failed.");
	});

	addFact("Direct Variable Unary Update - MinusMinus Suffix", function() {
		x = 2;

		assert_equals(x--, 2, "Direct variable MinusMinus Suffix failed.");
	});

	addFact("Direct Variable Unary Update - MinusMinus Prefix", function() {
		x = 1;

		assert_equals(--x, 0, "Direct variable MinusMinus Prefix failed.");
	});

	addFact("Direct Variable Unary Update - Get (Final)", function() {
		x = 0;
		x++;
		++x;
		x--;
		--x;

		assert_equals(x, 0, "Direct variable get failed.");
	});

	addFact("Self Variable Unary Update - Get", function() {
		self.x = 0;

		assert_equals(self.x, 0, "Self variable get failed.");
	});

	addFact("Self Variable Unary Update - PlusPlus Suffix", function() {
		self.x = 0;

		assert_equals(self.x++, 0, "Self variable PlusPlus Suffix failed.");
	});

	addFact("Self Variable Unary Update - PlusPlus Prefix", function() {
		self.x = 1;

		assert_equals(++self.x, 2, "Self variable PlusPlus Prefix failed.");
	});

	addFact("Self Variable Unary Update - MinusMinus Suffix", function() {
		self.x = 2;

		assert_equals(self.x--, 2, "Self variable MinusMinus Suffix failed.");
	});

	addFact("Self Variable Unary Update - MinusMinus Prefix", function() {
		self.x = 1;

		assert_equals(--self.x, 0, "Self variable MinusMinus Prefix failed.");
	});

	addFact("Self Variable Unary Update - Get (Final)", function() {
		self.x = 0;
		self.x++;
		++self.x;
		self.x--;
		--self.x;

		assert_equals(self.x, 0, "Self variable get failed.");
	});

	addFact("Other Variable Unary Update - Get", function() {
		other.x = 0;

		assert_equals(other.x, 0, "Other variable get failed.");
	});

	addFact("Other Variable Unary Update - PlusPlus Suffix", function() {
		other.x = 0;

		assert_equals(other.x++, 0, "Other variable PlusPlus Suffix failed.");
	});

	addFact("Other Variable Unary Update - PlusPlus Prefix", function() {
		other.x = 1;

		assert_equals(++other.x, 2, "Other variable PlusPlus Prefix failed.");
	});

	addFact("Other Variable Unary Update - MinusMinus Suffix", function() {
		other.x = 2;

		assert_equals(other.x--, 2, "Other variable MinusMinus Suffix failed.");
	});

	addFact("Other Variable Unary Update - MinusMinus Prefix", function() {
		other.x = 1;

		assert_equals(--other.x, 0, "Other variable MinusMinus Prefix failed.");
	});

	addFact("Other Variable Unary Update - Get (Final)", function() {
		other.x = 0;
		other.x++;
		++other.x;
		other.x--;
		--other.x;

		assert_equals(other.x, 0, "Other variable get failed.");
	});

	addFact("Global Variable Unary Update - Get", function() {
		global.x = 0;

		assert_equals(global.x, 0, "Global variable get failed.");

		struct_remove(global, "x");
	});

	addFact("Global Variable Unary Update - PlusPlus Suffix", function() {
		global.x = 0;

		assert_equals(global.x++, 0, "Global variable PlusPlus Suffix failed.");

		struct_remove(global, "x");
	});

	addFact("Global Variable Unary Update - PlusPlus Prefix", function() {
		global.x = 1;

		assert_equals(++global.x, 2, "Global variable PlusPlus Prefix failed.");

		struct_remove(global, "x");
	});

	addFact("Global Variable Unary Update - MinusMinus Suffix", function() {
		global.x = 2;

		assert_equals(global.x--, 2, "Global variable MinusMinus Suffix failed.");

		struct_remove(global, "x");
	});

	addFact("Global Variable Unary Update - MinusMinus Prefix", function() {
		global.x = 1;

		assert_equals(--global.x, 0, "Global variable MinusMinus Prefix failed.");

		struct_remove(global, "x");
	});

	addFact("Global Variable Unary Update - Get (Final)", function() {
		global.x = 0;
		global.x++;
		++global.x;
		global.x--;
		--global.x;

		assert_equals(global.x, 0, "Global variable get failed.");

		struct_remove(global, "x");
	});

	addFact("Local Variable Unary Update - Get", function() {
		var _struct = {};
		_struct.x = 0;

		assert_equals(_struct.x, 0, "Local variable get failed.");
	});

	addFact("Local Variable Unary Update - PlusPlus Suffix", function() {
		var _struct = {};
		_struct.x = 0;

		assert_equals(_struct.x++, 0, "Local variable PlusPlus Suffix failed.");
	});

	addFact("Local Variable Unary Update - PlusPlus Prefix", function() {
		var _struct = {};
		_struct.x = 1;

		assert_equals(++_struct.x, 2, "Local variable PlusPlus Prefix failed.");
	});

	addFact("Local Variable Unary Update - MinusMinus Suffix", function() {
		var _struct = {};
		_struct.x = 2;

		assert_equals(_struct.x--, 2, "Local variable MinusMinus Suffix failed.");
	});

	addFact("Local Variable Unary Update - MinusMinus Prefix", function() {
		var _struct = {};
		_struct.x = 1;

		assert_equals(--_struct.x, 0, "Local variable MinusMinus Prefix failed.");
	});

	addFact("Local Variable Unary Update - Get (Final)", function() {
		var _struct = {};
		_struct.x = 0;
		_struct.x++;
		++_struct.x;
		_struct.x--;
		--_struct.x;

		assert_equals(_struct.x, 0, "Local variable get failed.");
	});

	addFact("Static Internal Variable Unary Update - Get", function() {
		(function() {
			static __struct = {};
			__struct.x = 0;

			assert_equals(__struct.x, 0, "Static internal variable get failed.");
		})();
	});

	addFact("Static Internal Variable Unary Update - PlusPlus Suffix", function() {
		(function() {
			static __struct = {};
			__struct.x = 0;

			assert_equals(__struct.x++, 0, "Static internal variable PlusPlus Suffix failed.");
		})();
	});

	addFact("Static Internal Variable Unary Update - PlusPlus Prefix", function() {
		(function() {
			static __struct = {};
			__struct.x = 1;

			assert_equals(++__struct.x, 2, "Static internal variable PlusPlus Prefix failed.");
		})();
	});

	addFact("Static Internal Variable Unary Update - MinusMinus Suffix", function() {
		(function() {
			static __struct = {};
			__struct.x = 2;

			assert_equals(__struct.x--, 2, "Static internal variable MinusMinus Suffix failed.");
		})();
	});

	addFact("Static Internal Variable Unary Update - MinusMinus Prefix", function() {
		(function() {
			static __struct = {};
			__struct.x = 1;

			assert_equals(--__struct.x, 0, "Static internal variable MinusMinus Prefix failed.");
		})();
	});

	addFact("Static Internal Variable Unary Update - Get (Final)", function() {
		(function() {
			static __struct = {};
			__struct.x = 0;
			__struct.x++;
			++__struct.x;
			__struct.x--;
			--__struct.x;

			assert_equals(__struct.x, 0, "Static internal variable get failed.");
		})();
	});

	addFact("Static External Variable Unary Update - Get", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 0;

		assert_equals(_func.__struct, 0, "Static external variable get failed.");
	});

	addFact("Static External Variable Unary Update - PlusPlus Suffix", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 0;

		assert_equals(_func.__struct++, 0, "Static external variable PlusPlus Suffix failed.");
	});

	addFact("Static External Variable Unary Update - PlusPlus Prefix", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 1;

		assert_equals(++_func.__struct, 2, "Static external variable PlusPlus Prefix failed.");
	});

	addFact("Static External Variable Unary Update - MinusMinus Suffix", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 2;

		assert_equals(_func.__struct--, 2, "Static external variable MinusMinus Suffix failed.");
	});

	addFact("Static External Variable Unary Update - MinusMinus Prefix", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 1;

		assert_equals(--_func.__struct, 0, "Static external variable MinusMinus Prefix failed.");
	});

	addFact("Static External Variable Unary Update - Get (Final)", function() {
		var _func = function() { static __struct = 0; };
		_func.__struct = 0;
		_func.__struct++;
		++_func.__struct;
		_func.__struct--;
		--_func.__struct;

		assert_equals(_func.__struct, 0, "Static external variable get failed.");
	});

	addFact("Unique Variable Unary Update - Get", function() {
		score = 0;

		assert_equals(score, 0, "Unique variable get failed.");
	});

	addFact("Unique Variable Unary Update - PlusPlus Suffix", function() {
		score = 0;

		assert_equals(score++, 0, "Unique variable PlusPlus Suffix failed.");
	});

	addFact("Unique Variable Unary Update - PlusPlus Prefix", function() {
		score = 1;

		assert_equals(++score, 2, "Unique variable PlusPlus Prefix failed.");
	});

	addFact("Unique Variable Unary Update - MinusMinus Suffix", function() {
		score = 2;

		assert_equals(score--, 2, "Unique variable MinusMinus Suffix failed.");
	});

	addFact("Unique Variable Unary Update - MinusMinus Prefix", function() {
		score = 1;

		assert_equals(--score, 0, "Unique variable MinusMinus Prefix failed.");
	});

	addFact("Unique Variable Unary Update - Get (Final)", function() {
		score = 0;
		score++;
		++score;
		score--;
		--score;

		assert_equals(score, 0, "Unique variable get failed.");
	});

	// hspeed and speed are two names for the same underlying motion state (with vspeed
	// pinned to 0 so direction stays at 0 and speed == hspeed throughout). Each fact below
	// seeds hspeed directly to the exact value that name would hold at that point in the
	// original chained sequence, so both names can still be exercised independently.

	addFact("Dynamic Expression Variable Unary Update - Get (hspeed)", function() {
		hspeed = 0;
		vspeed = 0;

		assert_equals(hspeed, 0, "hspeed variable get failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - Get (speed)", function() {
		speed = 1;
		hspeed = 0;
		vspeed = 0;

		assert_equals(speed, 0, "speed variable was not updated when hspeed was updated.");
	});

	addFact("Dynamic Expression Variable Unary Update - PlusPlus Suffix (hspeed)", function() {
		hspeed = 0;
		vspeed = 0;

		assert_equals(hspeed++, 0, "hspeed variable PlusPlus Suffix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - PlusPlus Suffix (speed)", function() {
		hspeed = 1;
		vspeed = 0;

		assert_equals(speed++, 1, "speed variable PlusPlus Suffix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - PlusPlus Prefix (hspeed)", function() {
		hspeed = 2;
		vspeed = 0;

		assert_equals(++hspeed, 3, "hspeed variable PlusPlus Prefix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - PlusPlus Prefix (speed)", function() {
		hspeed = 3;
		vspeed = 0;

		assert_equals(++speed, 4, "speed variable PlusPlus Prefix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - MinusMinus Suffix (hspeed)", function() {
		hspeed = 4;
		vspeed = 0;

		assert_equals(hspeed--, 4, "hspeed variable MinusMinus Suffix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - MinusMinus Suffix (speed)", function() {
		hspeed = 3;
		vspeed = 0;

		assert_equals(speed--, 3, "speed variable MinusMinus Suffix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - MinusMinus Prefix (hspeed)", function() {
		hspeed = 2;
		vspeed = 0;

		assert_equals(--hspeed, 1, "hspeed variable MinusMinus Prefix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - MinusMinus Prefix (speed)", function() {
		hspeed = 1;
		vspeed = 0;

		assert_equals(--speed, 0, "speed variable MinusMinus Prefix failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - Get (Final) (hspeed)", function() {
		hspeed = 0;
		vspeed = 0;

		assert_equals(hspeed, 0, "hspeed variable get failed.");
	});

	addFact("Dynamic Expression Variable Unary Update - Get (Final) (speed)", function() {
		hspeed = 0;
		vspeed = 0;

		assert_equals(speed, 0, "speed variable get failed.");

		hspeed = 0;
		vspeed = 0;
	});

	// ACCESSOR TARGETS

	addFact("Array without symbolic accessor Unary Update - Get", function() {
		var _target = [];
		_target[0] = 0;

		assert_equals(_target[0], 0, "Array without @ accessor get failed.");
	});

	addFact("Array without symbolic accessor Unary Update - PlusPlus Prefix", function() {
		var _target = [];
		_target[0] = 0;

		assert_equals(++_target[0], 1, "Array without @ accessor PlusPlus Prefix failed.");
	});

	addFact("Array without symbolic accessor Unary Update - PlusPlus Suffix", function() {
		var _target = [];
		_target[0] = 1;

		assert_equals(_target[0]++, 1, "Array without @ accessor PlusPlus Suffix failed.");
	});

	addFact("Array without symbolic accessor Unary Update - MinusMinus Prefix", function() {
		var _target = [];
		_target[0] = 2;

		assert_equals(--_target[0], 1, "Array without @ accessor MinusMinus Prefix failed.");
	});

	addFact("Array without symbolic accessor Unary Update - MinusMinus Suffix", function() {
		var _target = [];
		_target[0] = 1;

		assert_equals(_target[0]--, 1, "Array without @ accessor MinusMinus Suffix failed.");
	});

	addFact("Array without symbolic accessor Unary Update - Get (Final)", function() {
		var _target = [];
		_target[0] = 0;
		++_target[0];
		_target[0]++;
		--_target[0];
		_target[0]--;

		assert_equals(_target[0], 0, "Array without @ accessor get failed.");
	});

	addFact("Array with symbolic accessor Unary Update - Get", function() {
		var _target = [];
		_target[@ 0] = 0;

		assert_equals(_target[@ 0], 0, "Array with @ accessor get failed.");
	});

	addFact("Array with symbolic accessor Unary Update - PlusPlus Prefix", function() {
		var _target = [];
		_target[@ 0] = 0;

		assert_equals(++_target[@ 0], 1, "Array with @ accessor PlusPlus Prefix failed.");
	});

	addFact("Array with symbolic accessor Unary Update - PlusPlus Suffix", function() {
		var _target = [];
		_target[@ 0] = 1;

		assert_equals(_target[@ 0]++, 1, "Array with @ accessor PlusPlus Suffix failed.");
	});

	addFact("Array with symbolic accessor Unary Update - MinusMinus Prefix", function() {
		var _target = [];
		_target[@ 0] = 2;

		assert_equals(--_target[@ 0], 1, "Array with @ accessor MinusMinus Prefix failed.");
	});

	addFact("Array with symbolic accessor Unary Update - MinusMinus Suffix", function() {
		var _target = [];
		_target[@ 0] = 1;

		assert_equals(_target[@ 0]--, 1, "Array with @ accessor MinusMinus Suffix failed.");
	});

	addFact("Array with symbolic accessor Unary Update - Get (Final)", function() {
		var _target = [];
		_target[@ 0] = 0;
		++_target[@ 0];
		_target[@ 0]++;
		--_target[@ 0];
		_target[@ 0]--;

		assert_equals(_target[@ 0], 0, "Array with @ accessor get failed.");
	});

	// Array (instance variable): distinct from the two local-var array facts above -
	// the array here is stored on the test instance itself, not a local.

	addFact("Array Unary Update - Get", function() {
		arr = [0];

		assert_equals(arr[0], 0, "Array instance variable get failed.");
	});

	addFact("Array Unary Update - PlusPlus Prefix", function() {
		arr = [0];

		assert_equals(++arr[0], 1, "Array instance variable PlusPlus Prefix failed.");
	});

	addFact("Array Unary Update - PlusPlus Suffix", function() {
		arr = [1];

		assert_equals(arr[0]++, 1, "Array instance variable PlusPlus Suffix failed.");
	});

	addFact("Array Unary Update - MinusMinus Prefix", function() {
		arr = [2];

		assert_equals(--arr[0], 1, "Array instance variable MinusMinus Prefix failed.");
	});

	addFact("Array Unary Update - MinusMinus Suffix", function() {
		arr = [1];

		assert_equals(arr[0]--, 1, "Array instance variable MinusMinus Suffix failed.");
	});

	addFact("Array Unary Update - Get (Final)", function() {
		arr = [0];
		++arr[0];
		arr[0]++;
		--arr[0];
		arr[0]--;

		assert_equals(arr[0], 0, "Array instance variable get failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - Get", function() {
		var _target = {};
		_target[$ "key"] = 0;

		assert_equals(_target[$ "key"], 0, "Struct bracket accessor :Const: get failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - PlusPlus Prefix", function() {
		var _target = {};
		_target[$ "key"] = 0;

		assert_equals(++_target[$ "key"], 1, "Struct bracket accessor :Const: PlusPlus Prefix failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - PlusPlus Suffix", function() {
		var _target = {};
		_target[$ "key"] = 1;

		assert_equals(_target[$ "key"]++, 1, "Struct bracket accessor :Const: PlusPlus Suffix failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - MinusMinus Prefix", function() {
		var _target = {};
		_target[$ "key"] = 2;

		assert_equals(--_target[$ "key"], 1, "Struct bracket accessor :Const: MinusMinus Prefix failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - MinusMinus Suffix", function() {
		var _target = {};
		_target[$ "key"] = 1;

		assert_equals(_target[$ "key"]--, 1, "Struct bracket accessor :Const: MinusMinus Suffix failed.");
	});

	addFact("Struct Bracket Accessor :Const: Unary Update - Get (Final)", function() {
		var _target = {};
		_target[$ "key"] = 0;
		++_target[$ "key"];
		_target[$ "key"]++;
		--_target[$ "key"];
		_target[$ "key"]--;

		assert_equals(_target[$ "key"], 0, "Struct bracket accessor :Const: get failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - Get", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 0;

		assert_equals(_target[$ _key], 0, "Struct bracket accessor :Dynamic: get failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - PlusPlus Prefix", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 0;

		assert_equals(++_target[$ _key], 1, "Struct bracket accessor :Dynamic: PlusPlus Prefix failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - PlusPlus Suffix", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 1;

		assert_equals(_target[$ _key]++, 1, "Struct bracket accessor :Dynamic: PlusPlus Suffix failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - MinusMinus Prefix", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 2;

		assert_equals(--_target[$ _key], 1, "Struct bracket accessor :Dynamic: MinusMinus Prefix failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - MinusMinus Suffix", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 1;

		assert_equals(_target[$ _key]--, 1, "Struct bracket accessor :Dynamic: MinusMinus Suffix failed.");
	});

	addFact("Struct Bracket Accessor :Dynamic: Unary Update - Get (Final)", function() {
		var _target = {};
		var _key = "key";
		_target[$ _key] = 0;
		++_target[$ _key];
		_target[$ _key]++;
		--_target[$ _key];
		_target[$ _key]--;

		assert_equals(_target[$ _key], 0, "Struct bracket accessor :Dynamic: get failed.");
	});

	// DATA STRUCTURE TARGETS

	addFact("List Unary Update - Get", function() {
		var _target = ds_list_create();
		_target[| 0] = 0;

		assert_equals(_target[| 0], 0, "List get failed.");

		ds_list_destroy(_target);
	});

	addFact("List Unary Update - PlusPlus Prefix", function() {
		var _target = ds_list_create();
		_target[| 0] = 0;

		assert_equals(++_target[| 0], 1, "List PlusPlus Prefix failed.");

		ds_list_destroy(_target);
	});

	addFact("List Unary Update - PlusPlus Suffix", function() {
		var _target = ds_list_create();
		_target[| 0] = 1;

		assert_equals(_target[| 0]++, 1, "List PlusPlus Suffix failed.");

		ds_list_destroy(_target);
	});

	addFact("List Unary Update - MinusMinus Prefix", function() {
		var _target = ds_list_create();
		_target[| 0] = 2;

		assert_equals(--_target[| 0], 1, "List MinusMinus Prefix failed.");

		ds_list_destroy(_target);
	});

	addFact("List Unary Update - MinusMinus Suffix", function() {
		var _target = ds_list_create();
		_target[| 0] = 1;

		assert_equals(_target[| 0]--, 1, "List MinusMinus Suffix failed.");

		ds_list_destroy(_target);
	});

	addFact("List Unary Update - Get (Final)", function() {
		var _target = ds_list_create();
		_target[| 0] = 0;
		++_target[| 0];
		_target[| 0]++;
		--_target[| 0];
		_target[| 0]--;

		assert_equals(_target[| 0], 0, "List get failed.");

		ds_list_destroy(_target);
	});

	addFact("Map Unary Update - Get", function() {
		var _target = ds_map_create();
		_target[? "key"] = 0;

		assert_equals(_target[? "key"], 0, "Map get failed.");

		ds_map_destroy(_target);
	});

	addFact("Map Unary Update - PlusPlus Prefix", function() {
		var _target = ds_map_create();
		_target[? "key"] = 0;

		assert_equals(++_target[? "key"], 1, "Map PlusPlus Prefix failed.");

		ds_map_destroy(_target);
	});

	addFact("Map Unary Update - PlusPlus Suffix", function() {
		var _target = ds_map_create();
		_target[? "key"] = 1;

		assert_equals(_target[? "key"]++, 1, "Map PlusPlus Suffix failed.");

		ds_map_destroy(_target);
	});

	addFact("Map Unary Update - MinusMinus Prefix", function() {
		var _target = ds_map_create();
		_target[? "key"] = 2;

		assert_equals(--_target[? "key"], 1, "Map MinusMinus Prefix failed.");

		ds_map_destroy(_target);
	});

	addFact("Map Unary Update - MinusMinus Suffix", function() {
		var _target = ds_map_create();
		_target[? "key"] = 1;

		assert_equals(_target[? "key"]--, 1, "Map MinusMinus Suffix failed.");

		ds_map_destroy(_target);
	});

	addFact("Map Unary Update - Get (Final)", function() {
		var _target = ds_map_create();
		_target[? "key"] = 0;
		++_target[? "key"];
		_target[? "key"]++;
		--_target[? "key"];
		_target[? "key"]--;

		assert_equals(_target[? "key"], 0, "Map get failed.");

		ds_map_destroy(_target);
	});

	addFact("Grid Unary Update - Get", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 0;

		assert_equals(_target[# 0, 0], 0, "Grid get failed.");

		ds_grid_destroy(_target);
	});

	addFact("Grid Unary Update - PlusPlus Prefix", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 0;

		assert_equals(++_target[# 0, 0], 1, "Grid PlusPlus Prefix failed.");

		ds_grid_destroy(_target);
	});

	addFact("Grid Unary Update - PlusPlus Suffix", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 1;

		assert_equals(_target[# 0, 0]++, 1, "Grid PlusPlus Suffix failed.");

		ds_grid_destroy(_target);
	});

	addFact("Grid Unary Update - MinusMinus Prefix", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 2;

		assert_equals(--_target[# 0, 0], 1, "Grid MinusMinus Prefix failed.");

		ds_grid_destroy(_target);
	});

	addFact("Grid Unary Update - MinusMinus Suffix", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 1;

		assert_equals(_target[# 0, 0]--, 1, "Grid MinusMinus Suffix failed.");

		ds_grid_destroy(_target);
	});

	addFact("Grid Unary Update - Get (Final)", function() {
		var _target = ds_grid_create(1, 1);
		_target[# 0, 0] = 0;
		++_target[# 0, 0];
		_target[# 0, 0]++;
		--_target[# 0, 0];
		_target[# 0, 0]--;

		assert_equals(_target[# 0, 0], 0, "Grid get failed.");

		ds_grid_destroy(_target);
	});

}
