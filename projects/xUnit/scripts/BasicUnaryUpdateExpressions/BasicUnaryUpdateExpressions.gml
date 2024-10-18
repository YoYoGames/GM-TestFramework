// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BasicUnaryUpdateExpressions() : TestSuite() constructor {
	
	addFact("Direct Variable Unary Update", function() {
        x = 0
		assert_equals(x,   0, "Direct variable get failed.");
        assert_equals(x++, 0, "Direct variable PlusPlus Suffix failed.");
		assert_equals(++x, 2, "Direct variable PlusPlus Prefix failed.");
		assert_equals(x--, 2, "Direct variable MinusMinus Suffix failed.");
		assert_equals(--x, 0, "Direct variable MinusMinus Prefix failed.");
		assert_equals(x,   0, "Direct variable get failed.");
    });
	
	addFact("Self Variable Unary Update", function() {
        self.x = 0
		assert_equals(self.x,   0, "Self variable get failed.");
        assert_equals(self.x++, 0, "Self variable PlusPlus Suffix failed.");
		assert_equals(++self.x, 2, "Self variable PlusPlus Prefix failed.");
		assert_equals(self.x--, 2, "Self variable MinusMinus Suffix failed.");
		assert_equals(--self.x, 0, "Self variable MinusMinus Prefix failed.");
		assert_equals(self.x,   0, "Self variable get failed.");
    });
	
	addFact("Other Variable Unary Update", function() {
        other.x = 0
		assert_equals(other.x,   0, "Other variable get failed.");
        assert_equals(other.x++, 0, "Other variable PlusPlus Suffix failed.");
		assert_equals(++other.x, 2, "Other variable PlusPlus Prefix failed.");
		assert_equals(other.x--, 2, "Other variable MinusMinus Suffix failed.");
		assert_equals(--other.x, 0, "Other variable MinusMinus Prefix failed.");
		assert_equals(other.x,   0, "Other variable get failed.");
    });
	
	addFact("Global Variable Unary Update", function() {
        global.x = 0
		assert_equals(global.x,   0, "Other variable get failed.");
        assert_equals(global.x++, 0, "Other variable PlusPlus Suffix failed.");
		assert_equals(++global.x, 2, "Other variable PlusPlus Prefix failed.");
		assert_equals(global.x--, 2, "Other variable MinusMinus Suffix failed.");
		assert_equals(--global.x, 0, "Other variable MinusMinus Prefix failed.");
		assert_equals(global.x,   0, "Other variable get failed.");
		struct_remove(global, "x")
    });
	
	addFact("Local Variable Unary Update", function() {
		var _struct = {};
        _struct.x = 0
		assert_equals(_struct.x,   0, "Local variable get failed.");
        assert_equals(_struct.x++, 0, "Local variable PlusPlus Suffix failed.");
		assert_equals(++_struct.x, 2, "Local variable PlusPlus Prefix failed.");
		assert_equals(_struct.x--, 2, "Local variable MinusMinus Suffix failed.");
		assert_equals(--_struct.x, 0, "Local variable MinusMinus Prefix failed.");
		assert_equals(_struct.x,   0, "Local variable get failed.");
    });
	
	addFact("Static Internal Variable Unary Update", function() {
		(function(){
			static __struct = {}
	        __struct.x = 0
			assert_equals(__struct.x,   0, "Static internal get failed.");
	        assert_equals(__struct.x++, 0, "Static internal PlusPlus Suffix failed.");
			assert_equals(++__struct.x, 2, "Static internal PlusPlus Prefix failed.");
			assert_equals(__struct.x--, 2, "Static internal MinusMinus Suffix failed.");
			assert_equals(--__struct.x, 0, "Static internal MinusMinus Prefix failed.");
			assert_equals(__struct.x,   0, "Static internal get failed.");
		})()
    });
	
	addFact("Static External Variable Unary Update", function() {
		var _func = function(){ static __struct = 0 }
		_func.__struct = 0
		assert_equals(_func.__struct,   0, "Static external variable get failed.");
		assert_equals(_func.__struct++, 0, "Static external variable PlusPlus Suffix failed.");
		assert_equals(++_func.__struct, 2, "Static external variable PlusPlus Prefix failed.");
		assert_equals(_func.__struct--, 2, "Static external variable MinusMinus Suffix failed.");
		assert_equals(--_func.__struct, 0, "Static external variable MinusMinus Prefix failed.");
		assert_equals(_func.__struct,   0, "Static external variable get failed.");
    });
	
	addFact("Unique Variable Unary Update", function() {
		score = 0
		assert_equals(score,   0, "Static variable get failed.");
        assert_equals(score++, 0, "Static variable PlusPlus Suffix failed.");
		assert_equals(++score, 2, "Static variable PlusPlus Prefix failed.");
		assert_equals(score--, 2, "Static variable MinusMinus Suffix failed.");
		assert_equals(--score, 0, "Static variable MinusMinus Prefix failed.");
		assert_equals(score,   0, "Static variable get failed.");
    });
	
	addFact("Dynamic Expression Variable Unary Update", function() {
		speed = 1;
		hspeed = 0;
		vspeed = 0;
		
		assert_equals(hspeed,   0, "hspeed variable failed.");
		assert_equals(speed,   0, "speed was not updated when hspeed was updated");
		
        assert_equals(hspeed++, 0, "hspeed variable PlusPlus Suffix failed.");
        assert_equals(speed++, 1, "speed variable PlusPlus Suffix failed.");
		assert_equals(++hspeed, 3, "hspeed variable PlusPlus Prefix failed.");
		assert_equals(++speed, 4, "speed variable PlusPlus Prefix failed.");
		assert_equals(hspeed--, 4, "hspeed variable MinusMinus Suffix failed.");
		assert_equals(speed--, 3, "speed variable MinusMinus Suffix failed.");
		assert_equals(--hspeed, 1, "hspeed variable MinusMinus Prefix failed.");
		assert_equals(--speed, 0, "speed variable MinusMinus Prefix failed.");
		assert_equals(hspeed,   0, "hspeed variable get failed.");
		assert_equals(speed,   0, "speed variable get failed.");
		
		hspeed = 0;
		vspeed = 0;
		
    });
	
	addFact("Array without @ accessor Unary Update", function() {
		var _target = [];
		_target[0] = 0;
		assert_equals(_target[0]  , 0, "Array without @ accessor get failed.");
        assert_equals(++_target[0], 1, "Array without @ accessor PlusPlus Suffix failed.");
		assert_equals(_target[0]++, 1, "Array without @ accessor PlusPlus Prefix failed.");
		assert_equals(--_target[0], 1, "Array without @ accessor MinusMinus Suffix failed.");
		assert_equals(_target[0]--, 1, "Array without @ accessor MinusMinus Prefix failed.");
		assert_equals(_target[0]  , 0, "Array without @ accessor get failed.");
    });
	
	addFact("Array with @ accessor Unary Update", function() {
		var _target = [];
		_target[@ 0] = 0;
		assert_equals(_target[@ 0]  , 0, "Array with @ accessor get failed.");
        assert_equals(++_target[@ 0], 1, "Array with @ accessor PlusPlus Suffix failed.");
		assert_equals(_target[@ 0]++, 1, "Array with @ accessor PlusPlus Prefix failed.");
		assert_equals(--_target[@ 0], 1, "Array with @ accessor MinusMinus Suffix failed.");
		assert_equals(_target[@ 0]--, 1, "Array with @ accessor MinusMinus Prefix failed.");
		assert_equals(_target[@ 0]  , 0, "Array with @ accessor get failed.");
    });
	
	addFact("List Unary Update", function() {
		var _target = ds_list_create();
		_target[| 0] = 0;
		assert_equals(_target[| 0]  , 0, "List get failed.");
        assert_equals(++_target[| 0], 1, "List PlusPlus Suffix failed.");
		assert_equals(_target[| 0]++, 1, "List PlusPlus Prefix failed.");
		assert_equals(--_target[| 0], 1, "List MinusMinus Suffix failed.");
		assert_equals(_target[| 0]--, 1, "List MinusMinus Prefix failed.");
		assert_equals(_target[| 0]  , 0, "List get failed.");
		ds_list_destroy(_target);
    });
	
	addFact("Map Unary Update", function() {
		var _target = ds_map_create();
		_target[? "key"] = 0;
		assert_equals(_target[? "key"]  , 0, "Map get failed.");
        assert_equals(++_target[? "key"], 1, "Map PlusPlus Suffix failed.");
		assert_equals(_target[? "key"]++, 1, "Map PlusPlus Prefix failed.");
		assert_equals(--_target[? "key"], 1, "Map MinusMinus Suffix failed.");
		assert_equals(_target[? "key"]--, 1, "Map MinusMinus Prefix failed.");
		assert_equals(_target[? "key"]  , 0, "Map get failed.");
		ds_map_destroy(_target)
    });
	
	addFact("Grid Unary Update", function() {
		var _target = ds_grid_create(1,1)
		_target[# 0, 0] = 0;
		assert_equals(_target[# 0, 0]  , 0, "Static variable get failed.");
        assert_equals(++_target[# 0, 0], 1, "Static variable PlusPlus Suffix failed.");
		assert_equals(_target[# 0, 0]++, 1, "Static variable PlusPlus Prefix failed.");
		assert_equals(--_target[# 0, 0], 1, "Static variable MinusMinus Suffix failed.");
		assert_equals(_target[# 0, 0]--, 1, "Static variable MinusMinus Prefix failed.");
		assert_equals(_target[# 0, 0]  , 0, "Static variable get failed.");
		ds_grid_destroy(_target)
    });
	
	addFact("Struct Bracket Accessor :Const: Unary Update", function() {
		var _target = {};
		_target[$ "key"] = 0;
		assert_equals(_target[$ "key"]  , 0, "Struct bracket accessor :Const: get failed.");
        assert_equals(++_target[$ "key"], 1, "Struct bracket accessor :Const: PlusPlus Suffix failed.");
		assert_equals(_target[$ "key"]++, 1, "Struct bracket accessor :Const: PlusPlus Prefix failed.");
		assert_equals(--_target[$ "key"], 1, "Struct bracket accessor :Const: MinusMinus Suffix failed.");
		assert_equals(_target[$ "key"]--, 1, "Struct bracket accessor :Const: MinusMinus Prefix failed.");
		assert_equals(_target[$ "key"]  , 0, "Struct bracket accessor :Const: get failed.");
    });
	
	addFact("Struct Bracket Accessor :Dynamic: Unary Update", function() {
		var _target = {};
		var _key = "key"
		_target[$ _key] = 0;
		assert_equals(_target[$ _key]  , 0, "Struct bracket accessor :Dynamic: get failed.");
        assert_equals(++_target[$ _key], 1, "Struct bracket accessor :Dynamic: PlusPlus Suffix failed.");
		assert_equals(_target[$ _key]++, 1, "Struct bracket accessor :Dynamic: PlusPlus Prefix failed.");
		assert_equals(--_target[$ _key], 1, "Struct bracket accessor :Dynamic: MinusMinus Suffix failed.");
		assert_equals(_target[$ _key]--, 1, "Struct bracket accessor :Dynamic: MinusMinus Prefix failed.");
		assert_equals(_target[$ _key]  , 0, "Struct bracket accessor :Dynamic: get failed.");
    });
	
	addFact("Array Unary Update", function() {
		score = 0
		assert_equals(score  , 0, "Static variable get failed.");
        assert_equals(score++, 0, "Static variable PlusPlus Suffix failed.");
		assert_equals(++score, 2, "Static variable PlusPlus Prefix failed.");
		assert_equals(score--, 2, "Static variable MinusMinus Suffix failed.");
		assert_equals(--score, 0, "Static variable MinusMinus Prefix failed.");
		assert_equals(score  , 0, "Static variable get failed.");
    });
	
	//addFact("Function Call Unary Update", function() {
	//	var _func = function(){ return 0 }
	//	
	//	assert_equals(_func()  , 0, "Function call get failed.");
    //    assert_equals(++_func(), 0, "Function call PlusPlus Suffix failed.");
	//	assert_equals(_func()++, 2, "Function call PlusPlus Prefix failed.");
	//	assert_equals(--_func(), 2, "Function call MinusMinus Suffix failed.");
	//	assert_equals(_func()--, 0, "Function call MinusMinus Prefix failed.");
	//	assert_equals(_func()  , 0, "Function call get failed.");
    //});
	
}