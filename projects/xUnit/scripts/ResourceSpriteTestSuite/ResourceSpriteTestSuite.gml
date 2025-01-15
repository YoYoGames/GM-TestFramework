function ResourceSpriteTestSuite() : TestSuite() constructor {
	
	addFact("sprite_add", function() {
		
		var _sprite = sprite_add("spriteAdd.png", 1, false, false, 0, 0);
		assert_true(sprite_exists(_sprite), test_current().name + ", didn't return a valid sprite");
		assert_true(sprite_get_number(_sprite) == 1, test_current().name + ", added sprite doesnt' have the correct number of subimages");

		var _sprite_width = 64;
		var _sprite_height = 64;
		assert_true(sprite_get_width(_sprite) == _sprite_width, test_current().name + ", added sprite doesn't have the correct width");
		assert_true(sprite_get_height(_sprite) == _sprite_height, test_current().name + ", added sprite doesn't have the correct height");

		var _surface = surface_create(_sprite_width, _sprite_height);
		surface_set_target(_surface);
		gpu_push_state();
		gpu_set_blendenable(false);
		draw_sprite(_sprite, 0, 0, 0);
		gpu_pop_state();
		surface_reset_target();

		var _buffer = buffer_create(buffer_sizeof(buffer_u32) * _sprite_width * _sprite_height, buffer_fixed, 1);
		buffer_get_surface(_buffer, _surface, 0);

		var _color = buffer_peek(_buffer, 0, buffer_u32);
		assert_equals(_color, 0x00_3F_7F_FF, test_current().name + ", added sprite doesn't preserve color when alpha is 0");

		sprite_delete(_sprite);
		assert_false(sprite_exists(_sprite), test_current().name + ", failed to delete added sprite");

		surface_free(_surface);
		buffer_delete(_buffer);
	});
	
}
