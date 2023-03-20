
function BasicSurfaceTestSuite() : TestSuite() constructor {


	addFact("surface_test", function() {

		var output;

		var surface = surface_create(1024, 768);
		output = surface_exists(surface);
		assert_true(output, "#1 surface_create(), failed to create a surface");
			
		output = surface_get_width(surface);
		assert_equals(output, 1024, "#2 surface_get_width(), failed to return the correct surface width");
			
		output = surface_get_height(surface);
		assert_equals(output, 768, "#3 surface_get_height(), failed to return the correct surface height");
			
		surface_resize(surface, 1280, 720);
			
		output = surface_get_width(surface);
		assert_equals(output, 1280, "#4.1 surface_resize(), failed to resize the surface");
		output = surface_get_height(surface);
		assert_equals(output, 720, "#4.2 surface_resize(), failed to resize the surface");
		
		surface_set_target(surface);
		output = surface_get_target();
		assert_equals(output, surface, "#5 surface_set/get_target(), failed set/get the target surface");
		
		draw_clear_alpha(c_green, 128);
		output = surface_getpixel(surface, 20, 20);
		assert_equals(output, 32768, "#5 surface_getpixel(), failed to return the correct color at specific point");
			
		output = surface_getpixel_ext(surface, 20, 20);
		assert_equals(output, 4278222848, "#6 surface_getpixel_ext(), failed to return the correct color+alpha at specific point");

		// If this is not HTML5
		if (os_browser == browser_not_a_browser) {
				
			surface_set_target_ext(2, surface);
			output = surface_get_target_ext(2);
			assert_equals(output, surface, "#7 surface_set/get_target_ext(), failed set/get the target surface (specified index)");
		}

		surface_reset_target();
		output = surface_get_target();
		assert_not_equals(output, surface, "#8 surface_reset_target(), failed to pop the surface correctly");

		output = surface_get_texture(surface);
		assert_not_equals(output, -1, "#9 surface_get_texture(), failed to get the surface texture correctly");

		// If this is not HTML5
		if (os_browser == browser_not_a_browser) {
		
			surface_save(surface, "surface.png");
			output = file_exists("surface.png");
			assert_true(output, "#10 surface_save(), failed to save the surface correctly");
			file_delete("surface.png");
			
			surface_save_part(surface, "surfacePart.png", 20, 20, 20, 20);
			output = file_exists("surfacePart.png");
			assert_true(output, "#11 surface_save_part(), failed to save the partial surface correctly");
			file_delete("surfacePart.png");
		
		}

		surface_free(surface);
		output = surface_exists(surface);
		assert_false(output, "#12 surface_free(), failed to free the surface correctly");

		surface_depth_disable(true);
		output = surface_get_depth_disable();
		assert_true(output, "#13 surface_depth_disable(), failed enabled the surface depth buffer");

		surface_depth_disable(false);
		output = surface_get_depth_disable();
		assert_false(output, "#14 surface_depth_disable(), failed disable the surface depth buffer");

		// HTML5 only
		if (os_browser != browser_not_a_browser) {
				
			surface = surface_create_ext("TestRig", 1024, 768);
			output = surface_exists(surface);
			assert_true(output, "#15 surface_create_ext(), failed to create the surface");

			surface_free(surface);
			output = surface_exists(surface);
			assert_false(output, "#16 surface_free(), failed to free the surface");
		}
	})
		
	addFact("surface_test_fails", function() {

		var output, surface;
			
		assert_throw(function() {
			var surface = surface_create(0, 0);
		}, "#1 surface_create(), (0) width, (0) height, should faild to create the surface");
			
		assert_throw(function() {
			var surface = surface_create(-1024, -768);
		}, "#2 surface_create(), (-) width, (-) height, should faild to create the surface");
			
		assert_throw(function() {
			surface_reset_target();
			surface_reset_target();
		}, "#3 surface_reset_target(), should fail if no target was previously set");
			
	})
	
}