function _effect_recursive_blur() constructor
{
	//Get uniforms
	static shader 					= _effect_recursive_blur_shader;
	static u_RecursiveBlurRadius 	= shader_get_uniform(shader,"g_RecursiveBlurRadius");
	static u_RecursiveBlurGamma 	= shader_get_uniform(shader,"g_RecursiveBlurGamma");
	static u_pSurfaceTexelSizeID  	= shader_get_uniform(shader,"gm_pSurfaceTexelSize");

	//Initialize values for uniforms
	g_RecursiveBlurRadius = 64;
	g_RecursiveBlurQuality = 5;
	g_RecursiveBlurGamma = 0;

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
		if(currcam!=clonedcam)
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

		//Number of blur passes
		var _num = g_RecursiveBlurQuality;
		//Compute radius multiplier
		var _mult = power(g_RecursiveBlurRadius, 1 / _num);
		//Starting radius
		var _radius = _mult;

		//Disable blending
		gpu_push_state();
		gpu_set_blendenable(false);
		gpu_set_texrepeat(false);

		//Iterate through passes
		repeat(_num)
		{
			//Apply blur shader pass
			surface_set_target(surf_pong);
			shader_set(_effect_recursive_blur_shader);
			shader_set_uniform_f(u_pSurfaceTexelSizeID, 1/surf_width, 1/surf_height);
			shader_set_uniform_f(u_RecursiveBlurRadius, _radius);
			shader_set_uniform_f(u_RecursiveBlurGamma, g_RecursiveBlurGamma);
			draw_surface(surf_ping,0,0);
			shader_reset();
			surface_reset_target();

			camera_apply(tempcam);		// need to do this every iteration as the surface_reset_target() resets the camera settings

			//Multiply (and flip) radius
			_radius *= -_mult;

			//Swap ping/pong surfaces
			var _surf = surf_ping;
			surf_ping = surf_pong;
			surf_pong = _surf;
		}

		camera_apply(tempcam);	// we need to reapply this as the surface_reset_target() resets the camera settings
		
		//Draw the final surface with alpha-correct blending
		gpu_set_blendenable(true);
		gpu_set_blendmode_ext_sepalpha(bm_one,bm_inv_src_alpha,bm_one,bm_one);
		draw_surface(surf_ping,0,0);
		//Restore state
		gpu_pop_state();

		camera_apply(clonedcam);				// finally, re-apply previous camera
	}
}
