function _effect_blend() constructor
{
	g_Blend = 1;

	surf_blend = -1;
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
		//Remove remaining surface
		if (surface_exists(surf_blend))
		{
			surface_free(surf_blend);
			surf_blend = -1;		
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
				
		if (!gmAffectsSingleLayerOnly)
			return;

		var _draw_surface = surface_get_target();
		var _draw_width = surface_get_width(_draw_surface);
		var _draw_height = surface_get_height(_draw_surface);

		if (!surface_exists(surf_blend))
	   	{
	   		surf_blend = surface_create(_draw_width, _draw_height);
	   	}
	   	else if ((surf_width != _draw_width) || (surf_height != _draw_height))
	   	{
	   		surface_resize(surf_blend, _draw_width, _draw_height);
	   	}
		
		surf_width = _draw_width;
		surf_height = _draw_height;

		CloneCurrCam();

		surface_set_target(surf_blend);
		draw_clear_alpha(0, 0);		

		camera_apply(clonedcam);				// re-apply previous camera as surface_set_target() resets the view
	}

	layer_end = function()
	{
		if ((event_type != ev_draw) || (event_number != 0))
			return;	// wrong event

		if (!gmAffectsSingleLayerOnly)
			return;
		
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

		gpu_push_state();

		gpu_set_blendmode(g_Blend);
		draw_surface(surf_blend, 0, 0);

		gpu_pop_state();		

		camera_apply(clonedcam);				// finally, re-apply previous camera
	}
}
