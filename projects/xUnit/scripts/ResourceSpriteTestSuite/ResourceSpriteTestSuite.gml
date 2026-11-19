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

	addTestAsync("texturegroup_add loads an image file", objTestAsync, {

		ev_create: function() {
			// A dynamic texture group from an included image: texturegroup_load should fetch it
			texturegroup_add("xunit_tg_image", "spriteAdd.png", {sprites: {xunit_tg_image_sprite: {width: 64, height: 64, frames: [{x: 0, y: 0}]}}});
			var _sprites = texturegroup_get_sprites("xunit_tg_image");
			assert_equals(array_length(_sprites), 1, "#texturegroup_get_sprites(), should list the group's one sprite");
			if (array_length(_sprites) != 1) return test_end();

			sprite = _sprites[0];
			assert_equals(sprite_get_width(sprite), 64, "#sprite_get_width(), should be the width given to texturegroup_add");
			assert_equals(texturegroup_load("xunit_tg_image"), 0, "#texturegroup_load(), should return 0 when the load starts");
			frames = 0;
		},
		ev_step: function() {
			// Ends when the group is fetched, and fails as soon as it drops back to unloaded (the load failed)
			frames += 1;
			var _status = texturegroup_get_status("xunit_tg_image");
			if (_status == texturegroup_status_fetched) {
				return test_end();
			}
			if ((frames > 2) && (_status == texturegroup_status_unloaded)) {
				assert_equals(_status, texturegroup_status_fetched, "#texturegroup_get_status(), the group should load, not drop back to unloaded");
				return test_end();
			}
		},
		ev_cleanup: function() {
			texturegroup_delete("xunit_tg_image");
		}
	}, { test_timeout_millis: 5000 });

	addTestAsync("texturegroup_add with a file that isn't an image", objTestAsync, {

		ev_create: function() {
			// testList.csv can't be decoded: loading the group should start, then fail and leave it unloaded, not crash
			texturegroup_add("xunit_tg_not_image", "testList.csv", {sprites: {xunit_tg_not_image_sprite: {width: 16, height: 16, frames: [{x: 0, y: 0}]}}});
			texturegroup_load("xunit_tg_not_image");
			assert_equals(texturegroup_get_status("xunit_tg_not_image"), texturegroup_status_loading, "#texturegroup_load(), should start loading the group");
			frames = 0;
		},
		ev_step: function() {
			frames += 1;
			var _status = texturegroup_get_status("xunit_tg_not_image");
			if ((frames > 2) && (_status != texturegroup_status_loading)) {
				assert_equals(_status, texturegroup_status_unloaded, "#texturegroup_get_status(), a group whose file can't be decoded should end up unloaded");
				return test_end();
			}
		},
		ev_cleanup: function() {
			texturegroup_delete("xunit_tg_not_image");
		}
	}, { test_timeout_millis: 5000 });

	addFact("texturegroup_load with a group that doesn't exist", function() {
		assert_equals(texturegroup_load("xunit_tg_no_such_group"), -1, "#texturegroup_load(), should return -1 for a group that doesn't exist");
	});

	addFact("texturegroup_add keeps its buffer until the group is deleted", function() {
		var _buffer = buffer_load("spriteAdd.png");
		texturegroup_add("xunit_tg_buffer_lifetime", _buffer, {sprites: {xunit_tg_buffer_lifetime_sprite: {width: 64, height: 64, frames: [{x: 0, y: 0}]}}});

		var _deleted = true;
		try {
			buffer_delete(_buffer);
		} catch (_e) {
			_deleted = false;
		}
		assert_false(_deleted, "#buffer_delete(), should fail while a texture group uses the buffer");
		assert_true(buffer_exists(_buffer), "#buffer_exists(), the buffer should still exist while the group uses it");

		texturegroup_delete("xunit_tg_buffer_lifetime");
		buffer_delete(_buffer);
		assert_false(buffer_exists(_buffer), "#buffer_delete(), should free the buffer once its texture group is deleted");
	});

	addTestAsync("texturegroup_add loads an image buffer, and a reload reads the buffer again", objTestAsync, {

		ev_create: function() {
			// textureGroupRed.png and textureGroupBlue.png are 16x16, one solid colour each
			buffer = buffer_load("textureGroupRed.png");
			texturegroup_add("xunit_tg_buffer", buffer, {sprites: {xunit_tg_buffer_sprite: {width: 16, height: 16, frames: [{x: 0, y: 0}]}}});
			sprite = texturegroup_get_sprites("xunit_tg_buffer")[0];
			assert_equals(texturegroup_load("xunit_tg_buffer"), 0, "#texturegroup_load(), should return 0 when the load starts");
			stage = 0;
			frames = 0;
		},
		ev_step: function() {
			frames += 1;
			var _status = texturegroup_get_status("xunit_tg_buffer");

			if (stage == 1) {
				// Reload once the unload has taken effect
				if (_status != texturegroup_status_unloaded) return;
				texturegroup_load("xunit_tg_buffer");
				stage = 2;
				frames = 0;
				return;
			}

			if ((frames > 2) && (_status == texturegroup_status_unloaded)) {
				assert_equals(_status, texturegroup_status_fetched, "#texturegroup_get_status(), the group should load, not drop back to unloaded");
				return test_end();
			}
			if (_status != texturegroup_status_fetched) return;

			// Draw the sprite and read back its middle pixel
			var _surface = surface_create(16, 16);
			surface_set_target(_surface);
			draw_clear_alpha(c_black, 1);
			draw_sprite(sprite, 0, 0, 0);
			surface_reset_target();
			var _pixel = surface_getpixel(_surface, 8, 8);
			surface_free(_surface);

			if (stage == 0) {
				assert_equals(_pixel, c_red, "#draw_sprite(), the group should draw the buffer's first image (red)");
				// Change what the buffer holds and unload the group; it is loaded again once the unload has happened
				buffer_load_ext(buffer, "textureGroupBlue.png", 0);
				texturegroup_unload("xunit_tg_buffer");
				stage = 1;
			} else {
				assert_equals(_pixel, c_blue, "#draw_sprite(), a reload should read the buffer's new contents (blue)");
				return test_end();
			}
		},
		ev_cleanup: function() {
			texturegroup_delete("xunit_tg_buffer");
			if (buffer_exists(buffer)) buffer_delete(buffer);
		}
	}, { test_timeout_millis: 5000 });

	// GameMaker-Bugs#16449: deleting the sprite a texture group added over one of the game's own sprites used to leave the
	// game's sprite pointing at the freed one, and texturegroup_delete then crashed
	addFact("sprite_delete on a texturegroup_add override restores the game's sprite", function() {
		var _held = sprAlphaTest;
		var _width = sprite_get_width(sprAlphaTest);
		var _overrideWidth = (_width == 17) ? 19 : 17;
		texturegroup_add("xunit_tg_override_delete", "spriteAdd.png", {sprites: {sprAlphaTest: {width: _overrideWidth, height: _overrideWidth, frames: [{x: 0, y: 0}]}}});
		try {
			var _override = asset_get_index("sprAlphaTest");
			assert_equals(sprite_get_width(_override), _overrideWidth, "#asset_get_index(), should find the texture group's sprite once it overrides the game's one");

			sprite_delete(_override);
			assert_equals(asset_get_index("sprAlphaTest"), _held, "#asset_get_index(), should find the game's sprite again once the override is deleted");
			assert_true(sprite_exists(_held), "#sprite_exists(), the game's sprite should still exist");
			assert_equals(sprite_get_width(_held), _width, "#sprite_get_width(), the game's sprite should have its own width back");
		} finally {
			texturegroup_delete("xunit_tg_override_delete");
		}
		assert_equals(asset_get_index("sprAlphaTest"), _held, "#texturegroup_delete(), the game's sprite should keep its name");
		assert_equals(sprite_get_width(_held), _width, "#texturegroup_delete(), should leave the game's sprite as it is");
	});

	// A later group's override replaces an earlier group's one, so deleting the earlier group afterwards leaves the later
	// group's override in place, and deleting that brings back the game's sprite
	addFact("texturegroup_delete leaves a later group's override of the same sprite in place", function() {
		var _held = sprAlphaTest;
		var _width = sprite_get_width(sprAlphaTest);
		var _widthA = (_width == 17) ? 19 : 17;
		var _widthB = (_width == 21) ? 23 : 21;
		texturegroup_add("xunit_tg_override_a", "spriteAdd.png", {sprites: {sprAlphaTest: {width: _widthA, height: _widthA, frames: [{x: 0, y: 0}]}}});
		try {
			texturegroup_add("xunit_tg_override_b", "spriteAdd.png", {sprites: {sprAlphaTest: {width: _widthB, height: _widthB, frames: [{x: 0, y: 0}]}}});
			try {
				texturegroup_delete("xunit_tg_override_a");
				assert_equals(sprite_get_width(asset_get_index("sprAlphaTest")), _widthB, "#texturegroup_delete(), the later group's override should still be found by name");
				assert_equals(sprite_get_width(_held), _widthB, "#texturegroup_delete(), the game's handle should still give the later group's override");
			} finally {
				texturegroup_delete("xunit_tg_override_b");
			}
		} finally {
			if (texturegroup_exists("xunit_tg_override_a")) texturegroup_delete("xunit_tg_override_a");
		}
		assert_equals(asset_get_index("sprAlphaTest"), _held, "#texturegroup_delete(), the game's sprite should keep its name");
		assert_equals(sprite_get_width(_held), _width, "#texturegroup_delete(), should bring back the game's sprite");
	});

	addFact("texturegroup_get_sprites leaves out a sprite deleted with sprite_delete", function() {
		texturegroup_add("xunit_tg_get_sprites_deleted", "spriteAdd.png", {sprites: {
			xunit_tg_get_sprites_deleted_a: {width: 16, height: 16, frames: [{x: 0, y: 0}]},
			xunit_tg_get_sprites_deleted_b: {width: 16, height: 16, frames: [{x: 16, y: 0}]}
		}});
		try {
			sprite_delete(asset_get_index("xunit_tg_get_sprites_deleted_a"));
			var _sprites = texturegroup_get_sprites("xunit_tg_get_sprites_deleted");
			assert_equals(array_length(_sprites), 1, "#texturegroup_get_sprites(), should list only the sprite that still exists");
			assert_equals(_sprites[0], asset_get_index("xunit_tg_get_sprites_deleted_b"), "#texturegroup_get_sprites(), should list the sprite that wasn't deleted");
		} finally {
			texturegroup_delete("xunit_tg_get_sprites_deleted");
		}
	});

}
