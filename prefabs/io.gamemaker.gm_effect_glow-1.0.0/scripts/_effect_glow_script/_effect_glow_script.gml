function _effect_glow() constructor
{
	//Get uniforms
	static shader = _effect_glow_shader;
	static u_GlowRadius = shader_get_uniform(shader,"g_GlowRadius");
	static u_GlowGamma = shader_get_uniform(shader,"g_GlowGamma");
	static u_pSurfaceTexelSize  = shader_get_uniform(shader,"gm_pSurfaceTexelSize");

	//Initialize values for uniforms
	g_GlowRadius = 256;
	g_GlowQuality = 5;
	g_GlowIntensity = 0.5;
	g_GlowAlpha = 1;
	g_GlowGamma = 0;

	//Initalize surface variables
	surf_ping = -1;
	surf_pong = -1;
	surf_width = 1;
	surf_height = 1;
	
	clonedcam = -1;
	tempcam = -1;

	CloneCurrCam = function()
	{
		if (clonedcam == -1)
		{
			clonedcam = camera_create();
		}

		var currcam = camera_get_active();
		camera_copy_transforms(clonedcam, currcam);
	}

	cleanup = function()
	{
		//Remove remaining surfaces
		if (surface_exists(surf_ping))
		{
			surface_free(surf_ping);
			surf_ping = -1;
		}
		if (surface_exists(surf_pong))
		{
			surface_free(surf_pong);
			surf_pong = -1;
		}

		//Remove cameras
		if (tempcam != -1)
		{
			camera_destroy(tempcam);
			tempcam = -1;
		}
		if (clonedcam != -1)
		{
			camera_destroy(clonedcam);
			clonedcam = -1;
		}
	}

	room_end = function()
	{
		cleanup();
	}

	layer_begin = function()
	{
		if ((event_type != ev_draw) || (event_number != 0))
			return;	// wrong event

		var _draw_surface = surface_get_target();
		var _draw_width = surface_get_width(_draw_surface);
		var _draw_height = surface_get_height(_draw_surface);

		//Make sure surfaces exist and at the correct size
		if (!surface_exists(surf_ping))
		{
			surf_ping = surface_create(_draw_width, _draw_height);
		}
		else if ((surf_width != _draw_width)  || (surf_height != _draw_height))
		{
			surface_resize(surf_ping, _draw_width, _draw_height);
		}
		if (!surface_exists(surf_pong))
		{
			surf_pong = surface_create(_draw_width, _draw_height);
		}
		else if ((surf_width != _draw_width)  || (surf_height != _draw_height))
		{
			surface_resize(surf_pong, _draw_width, _draw_height);
		}
		//Update size variable
		surf_width = _draw_width;
		surf_height = _draw_height;		

		CloneCurrCam();		

		//Clear the ping surface and draw this layer to it.
		surface_set_target(surf_ping);
		draw_clear_alpha(0, 0);		

		//Draw the surface if we're not in single layer mode
		if (!gmAffectsSingleLayerOnly)
		{
			draw_surface(_draw_surface,0,0);
		}
		else
		{
			camera_apply(clonedcam);				// re-apply previous camera as surface_set_target() resets the view						
		}
	}

	layer_end = function()
	{
		if ((event_type != ev_draw) || (event_number != 0))
			return;	// wrong event

		//Finish that layer's surface
		surface_reset_target();
		
		if (tempcam == -1)
		{
			tempcam = camera_create_view(0, 0, surf_width, surf_height);
		}
		else
		{
			camera_set_view_size(tempcam, surf_width, surf_height);		// make sure this is up-to-date
		}
		camera_apply(tempcam);

		//Number of glow passes
		var _num = g_GlowQuality;
		//Compute radius multiplier
		var _mult = power(g_GlowRadius, 1 / _num);
		//Starting radius
		var _radius = _mult;
		//Colour for glow intensity
		var _colour = merge_colour(c_black, c_white, g_GlowIntensity);

		//Draw backing surface
		draw_surface_ext(surf_ping,0,0,1,1,0,-1,g_GlowAlpha);
		//bm_max is perfect for glow effects
		gpu_push_state();
		gpu_set_blendmode(bm_max);

		//Iterate through passes
		repeat(_num)
		{
			//Apply glow blur pass
			surface_set_target(surf_pong);
			draw_clear(0);
			shader_set(_effect_glow_shader);
			shader_set_uniform_f(u_pSurfaceTexelSize, 1/surf_width, 1/surf_height);
			shader_set_uniform_f(u_GlowRadius, _radius);
			shader_set_uniform_f(u_GlowGamma, g_GlowGamma);
			draw_surface(surf_ping,0,0);
			shader_reset();
			surface_reset_target();

			camera_apply(tempcam);		// need to do this every iteration as the surface_reset_target() resets the camera settings

			//Draw this level
			draw_surface_ext(surf_pong,0,0,1,1,0,_colour,1);

			//Multiply (and flip) radius
			_radius *= -_mult;

			//Swap ping/pong surfaces
			var _surf = surf_ping;
			surf_ping = surf_pong;
			surf_pong = _surf;
		}

		//Restore state
		gpu_pop_state();		
		
		camera_apply(clonedcam);				// finally, re-apply previous camera (in case there weren't any passes for some reason)		
	}
}