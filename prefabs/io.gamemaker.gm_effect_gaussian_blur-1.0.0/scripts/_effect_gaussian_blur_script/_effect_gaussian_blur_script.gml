function _effect_gaussian_blur() constructor
{
	//Get uniforms
	static shader 						= _effect_gaussian_blur_shader;
	static write_shader					= _effect_gaussian_blur_write_shader;
	static mix_shader					= _effect_gaussian_blur_mix_shader;
	static u_sampledTexelSize 			= shader_get_uniform(shader,"g_sampledTexelSize");
	static u_blurDirection  			= shader_get_uniform(shader,"g_blurDirection");
	static u_textureSamplerAMix			= shader_get_sampler_index(mix_shader, "g_textureA");
	static u_textureSamplerBMix			= shader_get_sampler_index(mix_shader, "g_textureB");
	static u_interpolationValueMix		= shader_get_uniform(mix_shader,"g_interpolationValue");
	static u_textureSamplerAWrite		= shader_get_sampler_index(write_shader, "g_textureA");
	static u_interpolationValueWrite	= shader_get_uniform(write_shader, "g_interpolationValue");
	
	//Initalize surface variables
	g_numDownsamples = 2;
	g_numPasses = 8;
	g_intensity = 1.0;
	resources_initialised = false;
	should_draw = true;
	
	copy_cam = -1;
	clonedcam = -1;

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
		if(resources_initialised)
		{
			for(s = 0; s < num_surfaces; s++)
			{
				if(surface_exists(surfaces[s]))
				{
					surface_free(surfaces[s]);
					surfaces[s] = -1;
				}
			}			
			resources_initialised = false;
		}
		
		if (clonedcam != -1)
		{
			camera_destroy(clonedcam);
			clonedcam = -1;
		}
		
		if(copy_cam != -1)
		{
			camera_destroy(copy_cam);
			copy_cam = -1;
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
		var _draw_width = floor(surface_get_width(_draw_surface) / 2);
		var _draw_height = floor(surface_get_height(_draw_surface) / 2);
		
		should_draw = true;
		if(_draw_width == 0 || _draw_height == 0)
		{
			should_draw = false;
			return;
		}	
		
		g_intensity = clamp(g_intensity, 0.0, 1.0);
		
		// make sure we have a valid number of downsamples and passes since parameters can be set at runtime
		if(g_numDownsamples < 1)
		{
			show_debug_message("Gaussian blur effect cannot have less than one downsample! Defaulting to 1.");
			g_numDownsamples = 1;
		}
		else
		{
			var _check_width = _draw_width;
			var _check_height = _draw_height;
			for(d = 0; d < g_numDownsamples; d++)
			{
				_check_width = _check_width / 2;
				_check_height = _check_height / 2;
				if(_check_width < 1 || _check_height < 1)
				{
					show_debug_message("Gaussian blur effect cannot downsample more than {0} times at the current resolution!", d - 1);
					g_numDownsamples = d - 1;
					break;
				}
			}
		}
		
		if(g_numPasses < 1)
		{
			show_debug_message("Gaussian blur effect cannot have less than one pass! Defaulting to 1.");
			g_numPasses = 1;
		}
		
		// number of downsamples can be changed at runtime, need to check and update the surface arrays
		if(resources_initialised)
		{	
			if(num_surfaces != g_numDownsamples * 2)
			{
				for(s = 0; s < num_surfaces; s++)
				{
					if(surface_exists(surfaces[s]))
					{
						surface_free(surfaces[s]);
						surfaces[s] = -1;
					}
				
				}
			
				resources_initialised = false;
			}
			else if(!surface_exists(surfaces[0]))
			{
				// effect surfaces no longer exist so need to rebuild.
				// this can happen when application window is made fullscreen
				resources_initialised = false;
			}
		}
		num_surfaces = g_numDownsamples * 2;
		
		for(d = 0; d < g_numDownsamples; d++)
		{
			if(resources_initialised == false)
			{
				surfaces[d * 2] = surface_create(_draw_width, _draw_height);
				surfaces[d * 2 + 1] = surface_create(_draw_width, _draw_height);
				surface_widths[d] = _draw_width;
				surface_heights[d] = _draw_height;
			}
			else if (surface_widths[d] != _draw_width || surface_heights[d] != _draw_height)
			{
				surface_resize(surfaces[d * 2], _draw_width, _draw_height);
				surface_resize(surfaces[d * 2 + 1], _draw_width, _draw_height);
				surface_widths[d] = _draw_width;
				surface_heights[d] = _draw_height;
			}
			_draw_width = ceil(_draw_width / 2);
			_draw_height = ceil(_draw_height / 2);
		}
		
		resources_initialised = true;
		
		CloneCurrCam();
	}

	layer_end = function()
	{
		if ((event_type != ev_draw) || (event_number != 0))
			return;	// wrong event

		if(should_draw == false)
			return;
			
		if(g_intensity == 0.0)
			return;
			
		var _current_surface = surface_get_target();
		var _current_surface_index = 0;
		
		//Disable blending
		gpu_push_state();
		gpu_set_blendenable(false);
		gpu_set_texrepeat(false);
		gpu_set_tex_filter(true);
		
		var _source_width = surface_widths[0] * 2;
		var _source_height = surface_heights[0] * 2;
		
		for(i = 0; i < g_numDownsamples; i++;)
		{
			for(j = 0; j < g_numPasses; j++)
			{
				surface_set_target(surfaces[i * 2]);
				shader_set(_effect_gaussian_blur_shader);
				shader_set_uniform_f(u_sampledTexelSize, 1/_source_width, 1/_source_height);
				shader_set_uniform_f(u_blurDirection, 1.0, 0.0);
				draw_surface_stretched(_current_surface, 0, 0, surface_widths[i], surface_heights[i]);
				shader_reset();
				surface_reset_target();
			
				if(j == 0)
				{
					_source_width = surface_widths[i];
					_source_height = surface_heights[i];
				}
				_current_surface = surfaces[i * 2];
						
				surface_set_target(surfaces[i * 2 + 1]);
				shader_set(_effect_gaussian_blur_shader);
				shader_set_uniform_f(u_sampledTexelSize, 1/_source_width, 1/_source_height);
				shader_set_uniform_f(u_blurDirection, 0.0, 1.0);
			
				draw_surface_stretched(_current_surface, 0, 0, surface_widths[i], surface_heights[i]);
				shader_reset();
				surface_reset_target();
				_current_surface = surfaces[i * 2 + 1];
				_current_surface_index = i * 2 + 1;
			}
		}
		
		//Draw the final downsample blurred surface back to the main surface
		var _output_surface = surface_get_target();
		var _output_width = surface_get_width(_output_surface);
		var _output_height = surface_get_height(_output_surface);
		if(copy_cam == -1)
		{
			copy_cam = camera_create_view(0, 0, _output_width, _output_height);
		}
		else
		{
			camera_set_view_size(copy_cam, _output_width, _output_height);
		}
		
		camera_apply(copy_cam);
		
		var _surface_index = ((floor(g_intensity * g_numDownsamples) + 1) * 2) - 1;
		var _interTexInterpolation = (g_intensity * g_numDownsamples) - floor(g_intensity * g_numDownsamples);
		if(_surface_index > 1 && g_intensity < 1.0)
		{
			var _texA = surface_get_texture(surfaces[_surface_index - 2]);
			var _texB = surface_get_texture(surfaces[_surface_index]);
			shader_set(_effect_gaussian_blur_mix_shader);
		
			texture_set_stage(u_textureSamplerAMix, _texA);
			texture_set_stage(u_textureSamplerBMix, _texB);
			shader_set_uniform_f(u_interpolationValueMix, _interTexInterpolation);
			draw_surface_stretched(surfaces[_surface_index - 2], 0, 0, _output_width, _output_height);
		}
		else
		{
			if(g_intensity >= 1.0)
			{
				_interTexInterpolation = 1.0;
				_surface_index = num_surfaces - 1;
			}
			
			var _texA = surface_get_texture(surfaces[_surface_index]);
			shader_set(_effect_gaussian_blur_write_shader);
			
			gpu_set_blendenable(true);
			gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
			texture_set_stage(u_textureSamplerAWrite, _texA);
			shader_set_uniform_f(u_interpolationValueWrite, _interTexInterpolation);
			draw_surface_stretched(surfaces[_surface_index], 0, 0, _output_width, _output_height);
		}
		shader_reset(); 
		
		//Restore state`
		gpu_pop_state();

		camera_apply(clonedcam);				// finally, re-apply previous camera
	}
}