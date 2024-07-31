
function BasicSurfaceTestSuite() : TestSuite() constructor {
    
    addFact("surface_create #1", function() {
    
        // Create a surface and check that it exists
        var surface = surface_create(1024, 768);
        var output = surface_exists(surface);
        assert_true(output, "failed to create a surface");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_create #2", function() {
        
        // Create a surface with a width and height of 0, which should throw an error
        assert_throw(function() {
        var surface = surface_create(0, 0);
        }, "failed to throw error despite invalid width and height arguments of 0,0");
        
    })
    
    addFact("surface_create #3", function() {
        
        // Create a surface with a negative width and height, which should throw an error
        assert_throw(function() {
        var surface = surface_create(-1024, -768);
        }, "failed to throw error despite invalid negative width and height arguments");
        
    })
    
    addFact("surface_free", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Free the surface and check it no longer exists
        surface_free(surface);
        var output = surface_exists(surface);
        assert_false(output, "failed to free the surface");
    })
    
    addFact("surface_get_width", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Get the width of the surface and check it matches the width it was created with
        var output = surface_get_width(surface);
        assert_equals(output, 1024, "failed to return the correct surface width");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_get_height", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Get the height of the surface and check it matches the height it was created with
        var output = surface_get_height(surface);
        assert_equals(output, 768, "failed to return the correct surface height");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_resize", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Resize the surface and then check it's width and height match what it was resized to
        surface_resize(surface, 1280, 720);
        var output_width = surface_get_width(surface);
        var output_height = surface_get_height(surface);
        var output = output_width == 1280 && output_height == 720
        assert_true(output, "failed to resize the surface");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_set/get", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Set the surface to the current draw target then get the current draw target to check that they match
        surface_set_target(surface);
        var output = surface_get_target();
        assert_equals(output, surface, "failed to set/get the target surface");
        
        // Reset draw target and free surface once test is finished
        surface_reset_target();
        surface_free(surface);
    })
    
    addFact("surface_get #2", function() {
        
        // Get the current draw target and check that it returns -1, as no target has been set
        var output = surface_get_target();
        assert_equals(output, -1, "failed to return -1 when no draw target is set");
    })
    
    addFact("surface_getpixel", function() {
        
        // Create a surface for the test and set it as the draw target
        var surface = surface_create(1024, 768);
        surface_set_target(surface);
        
        // Fill the surface with transparent green and check if the pixel at 20,20 matches the shade of green set (which is 32768 without alpha)
        draw_clear_alpha(c_green, 128);
        var output = surface_getpixel(surface, 20, 20);
        assert_equals(output, 32768, "failed to return the correct color at specific point");
        
        // Reset draw target and free surface once test is finished
        surface_reset_target();
        surface_free(surface);
    })
    
    addFact("surface_getpixel_ext", function() {
        
        // Create a surface for the test and set it as the draw target
        var surface = surface_create(1024, 768);
        surface_set_target(surface);
        
        // Fill the surface with transparent green and check if the pixel at 20,20 matches the shade of green set (which is 4278222848 with alpha)
        draw_clear_alpha(c_green, 128);
        var output = surface_getpixel_ext(surface, 20, 20);
        assert_equals(output, 4278222848, "failed to return the correct color+alpha at specific point");
        
        // Reset draw target and free surface once test is finished
        surface_reset_target();
        surface_free(surface);
    })
    
    addFact("surface_set/get_target_ext", function() {
        
        // Create a surface for the test and set it as the draw target
        var surface = surface_create(1024, 768);
        surface_set_target(surface);
        
        // Assign the surface to render target 2 then get the surface assigned to render target 2 to check they match
        surface_set_target_ext(2, surface);
        var output = surface_get_target_ext(2);
        assert_equals(output, surface, "failed set/get the target surface (specified index)");
        
        // Reset draw target and free surface once test is finished
        surface_reset_target();
        surface_free(surface);
    }, 
        {
        // Doesn't work on HTML5 or console
        test_filter: platform_not_browser,
        test_filter: platform_not_console
    });
    
    addFact("surface_reset_target #1", function() {
        
        // Create a surface for the test and set it as the draw target
        var surface = surface_create(1024, 768);
        surface_set_target(surface)
        
        // Reset the draw target then check that its no longer drawing to the surface
        surface_reset_target();
        var output = surface_get_target();
        assert_not_equals(output, surface, "failed to pop the surface correctly");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_reset_target #2", function() {
        
        // Check that resetting the draw target when no draw target is set throws an error
        assert_throw(function() {
        surface_reset_target();
            surface_reset_target();
        }, "should fail if no target was previously set");
    })
    
    addFact("surface_get_texture", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Get the surface as a texture and check that te returned value is not -1
        // (could be improved by comparing against an expected buffer file)
        var output = surface_get_texture(surface);
        assert_not_equals(output, -1, "failed to get the surface texture correctly");
        
        // Free surface once test is finished
        surface_free(surface);
    })
    
    addFact("surface_save", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Save the surface to the file "surface.png", then check that "surface.png" exists
        // (could be improved by comparing against an expected image file)
        surface_save(surface, "surface.png");
        var output = file_exists("surface.png");
        assert_true(output, "failed to save the surface correctly");
        
        // delete the file and free the surface once test is finished
        file_delete("surface.png");
        surface_free(surface);
    }, 
    {
        // Doesn't work on HTML5
        test_filter: platform_not_browser
    });
    
    addFact("surface_save_part", function() {
        
        // Create a surface for the test
        var surface = surface_create(1024, 768);
        
        // Save part of the surface to the file "surfacePart.png", then check that "surfacePart.png" exists
        // (could be improved by comparing against an expected image file)
        surface_save_part(surface, "surfacePart.png", 20, 20, 20, 20);
        var output = file_exists("surfacePart.png");
        assert_true(output, "failed to save the partial surface correctly");
        file_delete("surfacePart.png");
        
        // Free surface once test is finished
        surface_free(surface);
    }, 
    {
        // Doesn't work on HTML5
        test_filter: platform_not_browser
    });
    
    addFact("surface_depth_disable #1", function() {
        
        // enable automatic depth buffer generation and then check if it's been enabled
        surface_depth_disable(true);
        var output = surface_get_depth_disable();
        assert_true(output, "failed to enabled the surface depth buffer");
    })
    
    addFact("surface_depth_disable #2", function() {
        
        // disable automatic depth buffer generation and then check if it's been disabled
        surface_depth_disable(false);
        var output = surface_get_depth_disable();
        assert_false(output, "failed to disable the surface depth buffer");
    })
    
    addFact("surface_create_ext", function() {
        
        // Create a surface and attach it to the canvas element "TestRig", then check that it exists
        // (testing of this function could be imrpoved by checking if it's been attached to the canvas element)
        var surface = surface_create_ext("TestRig", 1024, 768);
        var output = surface_exists(surface);
        assert_true(output, "failed to create the surface");
        
        // Free surface once test is finished
        surface_free(surface);
    }, 
        { 
        // Only works on HTML5
        test_filter: platform_browser
    });
    
}
