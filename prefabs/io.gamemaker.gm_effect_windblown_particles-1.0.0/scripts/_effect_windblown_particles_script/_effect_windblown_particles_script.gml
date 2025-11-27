// Simple particle system with blowing wind effect
// Note that this is *not* supposed to be an even vaguely accurate simulation
// There are also still a lot of optimisations possible
function _effect_windblown_particles() constructor
{			
	param_num_particles = 100;			
	param_particle_spawn_time = 100;			// measured in milliseconds
	param_particle_spawn_all_at_start = 0;
	param_warmup_frames = 0;
	param_sprite = _effect_windblown_particles_leaf_sprite;
		
	param_particle_mass_min = 0.005;
	param_particle_mass_max = 0.01;
	param_particle_start_sprite_scale = 0.25;
	param_particle_end_sprite_scale = 0.25;	
	param_particle_col_1 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_alt_1 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_2 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_alt_2 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_3 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_alt_3 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_4 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_alt_4 = [1.0, 1.0, 1.0, 1.0];	
	param_particle_col_enabled_2 = 0;
	param_particle_col_enabled_3 = 0;
	param_particle_col_2_pos = 0.33;
	param_particle_col_3_pos = 0.66;
	param_particle_initial_velocity_range_x_min = -100;
	param_particle_initial_velocity_range_x_max = 100;
	param_particle_initial_velocity_range_y_min = -100;
	param_particle_initial_velocity_range_y_max = 100;
	param_particle_initial_rotation_min = 0;
	param_particle_initial_rotation_max = 360;
	param_particle_rot_speed_min = -360;
	param_particle_rot_speed_max = 360;
	param_particle_lifetime_min = 100;
	param_particle_lifetime_max = 100;
	param_particle_update_skip = 1;
	param_particle_spawn_border_prop = 0.25;
	param_particle_src_blend = bm_src_alpha;
	param_particle_dest_blend = bm_inv_src_alpha;
	param_particle_align_vel = 1;
	
	param_trails_only = 0;
	param_trail_chance = 20;				// percentage chance a particle will have a trail	
	param_trail_lifetime_min = 0.1;			// trail lifetime in seconds
	param_trail_lifetime_max = 0.5;			// trail lifetime in seconds
	param_trail_thickness_min = 0.25;
	param_trail_thickness_max = 1.0;
	param_trail_col_1 = [1.0, 1.0, 1.0, 0.1];	
	param_trail_col_alt_1 = [1.0, 1.0, 1.0, 0.25];	
	param_trail_col_2 = [1.0, 1.0, 1.0, 0.1];	
	param_trail_col_alt_2 = [1.0, 1.0, 1.0, 0.25];	
	param_trail_col_3 = [1.0, 1.0, 1.0, 0.1];	
	param_trail_col_alt_3 = [1.0, 1.0, 1.0, 0.25];	
	param_trail_col_4 = [1.0, 1.0, 1.0, 0.0];	
	param_trail_col_alt_4 = [1.0, 1.0, 1.0, 0.0];	
	param_trail_col_enabled_2 = 1;
	param_trail_col_enabled_3 = 0;
	param_trail_col_2_pos = 0.5;
	param_trail_col_3_pos = 0.66;
	param_trail_min_segment_length = 20;
	param_trail_src_blend = bm_src_alpha;
	param_trail_dest_blend = bm_inv_src_alpha;
	
	param_force_grid_sizex = 8;		
	param_force_grid_sizey = 8;		
	param_wind_vector_x = -4;
	param_wind_vector_y = -1;
	
	param_num_blowers = 3;
	param_blower_size_min = 0.2;
	param_blower_size_max = 0.6;
	param_blower_speed_min = 0.2;	// proportion of screen crossed in a second
	param_blower_speed_max = 0.5;	// proportion of the screen crossed in a second
	param_blower_rot_speed_min = -180;
	param_blower_rot_speed_max = 180;
	param_blower_force_min = 5;
	param_blower_force_max = 15;
	param_blower_camvec_scale = -1.0;
		
	air_density = 0.01;	
	param_dragcoeff = 1.0;
	
	param_grav_accel = 100.0;
	
	param_debug_grid = 0;
	debug_grid_alpha = 0.25;
	debug_force_scale = 10.0;
	
	particle_scale_compensation = 1.0;
	time_since_last_particle = 0.0;
	
	trails_use_trilists = 0;
	
	particle_col = array_create(4);
	particle_alpha = array_create(4);
	particle_col_alt = array_create(4);
	particle_alpha_alt = array_create(4);
	particle_col_pos = array_create(4);
	particle_col_dist = array_create(3);
	
	trail_col = array_create(4);
	trail_alpha = array_create(4);
	trail_col_alt = array_create(4);
	trail_alpha_alt = array_create(4);
	trail_col_pos = array_create(4);
	trail_col_dist = array_create(3);
	
	update_colours = function()
	{
		// Particle colours
		particle_col[0] = make_colour_rgb(param_particle_col_1[0] * 255, param_particle_col_1[1] * 255, param_particle_col_1[2] * 255);	
		particle_col[1] = make_colour_rgb(param_particle_col_2[0] * 255, param_particle_col_2[1] * 255, param_particle_col_2[2] * 255);	
		particle_col[2] = make_colour_rgb(param_particle_col_3[0] * 255, param_particle_col_3[1] * 255, param_particle_col_3[2] * 255);	
		particle_col[3] = make_colour_rgb(param_particle_col_4[0] * 255, param_particle_col_4[1] * 255, param_particle_col_4[2] * 255);	
		
		particle_col_alt[0] = make_colour_rgb(param_particle_col_alt_1[0] * 255, param_particle_col_alt_1[1] * 255, param_particle_col_alt_1[2] * 255);	
		particle_col_alt[1] = make_colour_rgb(param_particle_col_alt_2[0] * 255, param_particle_col_alt_2[1] * 255, param_particle_col_alt_2[2] * 255);	
		particle_col_alt[2] = make_colour_rgb(param_particle_col_alt_3[0] * 255, param_particle_col_alt_3[1] * 255, param_particle_col_alt_3[2] * 255);	
		particle_col_alt[3] = make_colour_rgb(param_particle_col_alt_4[0] * 255, param_particle_col_alt_4[1] * 255, param_particle_col_alt_4[2] * 255);	
		
		particle_alpha[0] = param_particle_col_1[3];
		particle_alpha[1] = param_particle_col_2[3];
		particle_alpha[2] = param_particle_col_3[3];
		particle_alpha[3] = param_particle_col_4[3];
		
		particle_alpha_alt[0] = param_particle_col_alt_1[3];
		particle_alpha_alt[1] = param_particle_col_alt_2[3];
		particle_alpha_alt[2] = param_particle_col_alt_3[3];
		particle_alpha_alt[3] = param_particle_col_alt_4[3];
		
		particle_col_pos[0] = 0.0;
		particle_col_pos[1] = param_particle_col_2_pos;
		particle_col_pos[2] = param_particle_col_3_pos;
		particle_col_pos[3] = 1.0;
		
		if (param_particle_col_enabled_3 == 0)
		{
			particle_col[2] = particle_col[3];
			particle_col_alt[2] = particle_col_alt[3];
			particle_alpha[2] = particle_alpha[3];
			particle_alpha_alt[2] = particle_alpha_alt[3];
			particle_col_pos[2] = 1.0;
		}
		
		if (param_particle_col_enabled_2 == 0)
		{
			particle_col[1] = particle_col[2];
			particle_col_alt[1] = particle_col_alt[2];
			particle_alpha[1] = particle_alpha[2];
			particle_alpha_alt[1] = particle_alpha_alt[2];
			particle_col_pos[1] = particle_col_pos[2];
		}		
		
		particle_col_dist[0] = particle_col_pos[1] - particle_col_pos[0];
		particle_col_dist[1] = particle_col_pos[2] - particle_col_pos[1];
		particle_col_dist[2] = particle_col_pos[3] - particle_col_pos[2];
		
		
		// Trail colours
		trail_col[0] = make_colour_rgb(param_trail_col_1[0] * 255, param_trail_col_1[1] * 255, param_trail_col_1[2] * 255);	
		trail_col[1] = make_colour_rgb(param_trail_col_2[0] * 255, param_trail_col_2[1] * 255, param_trail_col_2[2] * 255);	
		trail_col[2] = make_colour_rgb(param_trail_col_3[0] * 255, param_trail_col_3[1] * 255, param_trail_col_3[2] * 255);	
		trail_col[3] = make_colour_rgb(param_trail_col_4[0] * 255, param_trail_col_4[1] * 255, param_trail_col_4[2] * 255);	
		
		trail_col_alt[0] = make_colour_rgb(param_trail_col_alt_1[0] * 255, param_trail_col_alt_1[1] * 255, param_trail_col_alt_1[2] * 255);	
		trail_col_alt[1] = make_colour_rgb(param_trail_col_alt_2[0] * 255, param_trail_col_alt_2[1] * 255, param_trail_col_alt_2[2] * 255);	
		trail_col_alt[2] = make_colour_rgb(param_trail_col_alt_3[0] * 255, param_trail_col_alt_3[1] * 255, param_trail_col_alt_3[2] * 255);	
		trail_col_alt[3] = make_colour_rgb(param_trail_col_alt_4[0] * 255, param_trail_col_alt_4[1] * 255, param_trail_col_alt_4[2] * 255);	
		
		trail_alpha[0] = param_trail_col_1[3];
		trail_alpha[1] = param_trail_col_2[3];
		trail_alpha[2] = param_trail_col_3[3];
		trail_alpha[3] = param_trail_col_4[3];
		
		trail_alpha_alt[0] = param_trail_col_alt_1[3];
		trail_alpha_alt[1] = param_trail_col_alt_2[3];
		trail_alpha_alt[2] = param_trail_col_alt_3[3];
		trail_alpha_alt[3] = param_trail_col_alt_4[3];
		
		trail_col_pos[0] = 0.0;
		trail_col_pos[1] = param_trail_col_2_pos;
		trail_col_pos[2] = param_trail_col_3_pos;
		trail_col_pos[3] = 1.0;
		
		if (param_trail_col_enabled_3 == 0)
		{
			trail_col[2] = trail_col[3];
			trail_col_alt[2] = trail_col_alt[3];
			trail_alpha[2] = trail_alpha[3];
			trail_alpha_alt[2] = trail_alpha_alt[3];
			trail_col_pos[2] = 1.0;
		}
		
		if (param_trail_col_enabled_2 == 0)
		{
			trail_col[1] = trail_col[2];
			trail_col_alt[1] = trail_col_alt[2];
			trail_alpha[1] = trail_alpha[2];
			trail_alpha_alt[1] = trail_alpha_alt[2];
			trail_col_pos[1] = trail_col_pos[2];
		}		
		
		trail_col_dist[0] = trail_col_pos[1] - trail_col_pos[0];
		trail_col_dist[1] = trail_col_pos[2] - trail_col_pos[1];
		trail_col_dist[2] = trail_col_pos[3] - trail_col_pos[2];
	}
	
	reset = function()
	{
		frame = 0;	
	
		particles = array_create(0);
		num_particles = 0;	
	
		trail_min_segment_length_sq = param_trail_min_segment_length * param_trail_min_segment_length;
	
		force_grid_sizex = -1;
		force_grid_sizey = -1;	
	
		force_grid = -1;
		force_grid_centrex = 0;		// this is the room position the force grid is based at
		force_grid_centrey = 0;
	
		force_grid_offsetx = 0;		// this is the position in the grid array we start at (circular buffer style)
		force_grid_offsety = 0;
	
		grid_margin = 1;			// this is amount we want the force grid to overhang on each side		
	
		last_view_centrex = 0;
		last_view_centrey = 0;		
	
		blowers = array_create(0);
		num_blowers = 0;	
	
		trails = array_create(0);
		num_trails = 0;
	
		views_minx = 0;
		views_maxx = 0;
		views_miny = 0;
		views_maxx = 0;
		views_centrex = 0;
		views_centrey = 0;
		
		update_colours();
		
		sprwidth = sprite_get_width(param_sprite);
		sprheight = sprite_get_height(param_sprite);
		
		particle_scale_compensation = 1.0;
	}
	
	cleanup = function()
	{
		
	}	
	
	spawn_blower = function(_minx, _maxx, _miny, _maxy)
	{
		var blower = 
		{					
			velx:((_maxx - _minx) * random_range(param_blower_speed_min, param_blower_speed_max)),
			posy:random_range(_miny, _maxy),
			size:(random_range(param_blower_size_min, param_blower_size_max) * (_maxx - _minx)),
			rotspeed:random_range((param_blower_rot_speed_min / 180.0) * pi, (param_blower_rot_speed_max / 180.0) * pi),
			rot:random_range(0, pi * 2.0),
			force:random_range(param_blower_force_min, param_blower_force_max)	
		};		
		
		if (random(100) < 50.0)
			blower.velx = -blower.velx;
					
		if (blower.velx < 0)
			blower.posx = _maxx + blower.size;
		else
			blower.posx = _minx - blower.size;					
			
		return blower;
	}
	
	spawn_trail = function(_lifetime, _spritesize)
	{
		if (array_length(trails) <= num_trails)
		{
			array_resize(trails, num_trails + 1);
		}		
		
		var lifetime_in_frames = _lifetime * game_get_speed(gamespeed_fps);
		var num_segs = ceil(lifetime_in_frames) + 1;	// currently just assume one segment per frame (add on an extra segment so we get a full alpha fade-out of the last segment)
		var trail =
		{
			tail_segment:0,
			head_segment:0,						
			lifetime:lifetime_in_frames,
			total_num_segs:num_segs,
			halfwidth:random_range(param_trail_thickness_min, param_trail_thickness_max) * _spritesize * 0.5,			
			num_segs:0
		};
		
		trail.posx = array_create(num_segs);
		trail.posy = array_create(num_segs);		
		trail.pt1_posx = array_create(num_segs);
		trail.pt1_posy = array_create(num_segs);
		trail.pt2_posx = array_create(num_segs);
		trail.pt2_posy = array_create(num_segs);
		trail.frame = array_create(num_segs);		// only really need this if we're not adding a segment every frame
		
		trail.alphascale = 1.0;			// can be modified by the particle that drives this trail in order to fade it out
		
		var colblend = random_range(0.0, 1.0);					
		trail.cols = array_create(4);
		trail.alphas = array_create(4);
		
		trail.cols[0] = merge_colour(trail_col[0], trail_col_alt[0], colblend);
		trail.cols[1] = merge_colour(trail_col[1], trail_col_alt[1], colblend);
		trail.cols[2] = merge_colour(trail_col[2], trail_col_alt[2], colblend);
		trail.cols[3] = merge_colour(trail_col[3], trail_col_alt[3], colblend);
		
		trail.alphas[0] = lerp(trail_alpha[0], trail_alpha_alt[0], colblend);
		trail.alphas[1] = lerp(trail_alpha[1], trail_alpha_alt[1], colblend);
		trail.alphas[2] = lerp(trail_alpha[2], trail_alpha_alt[2], colblend);
		trail.alphas[3] = lerp(trail_alpha[3], trail_alpha_alt[3], colblend);
		
		trails[num_trails] = trail;
		num_trails++;
		
		return trail;
	}
	
	add_trail_segment = function(_trail, _posx, _posy)
	{
		var totalnumsegs = _trail.total_num_segs;
		if (totalnumsegs < 2)
		{
			show_debug_message("Trail has less than two segments and is unusable.");
			return;
		}		
		
		if (_trail.num_segs == 0)
		{
			var headseg = _trail.head_segment;
			
			// Duplicate first segment
			_trail.posx[headseg] = _posx;
			_trail.posy[headseg] = _posy;
			_trail.frame[headseg] = frame;
			_trail.pt1_posx[headseg] = 0.0;
			_trail.pt1_posy[headseg] = 0.0;
			_trail.pt2_posx[headseg] = 0.0;
			_trail.pt2_posy[headseg] = 0.0;
			
			headseg = (headseg + 1) % totalnumsegs;			
			
			_trail.posx[headseg] = _posx;
			_trail.posy[headseg] = _posy;
			_trail.frame[headseg] = frame;
			_trail.pt1_posx[headseg] = 0.0;
			_trail.pt1_posy[headseg] = 0.0;
			_trail.pt2_posx[headseg] = 0.0;
			_trail.pt2_posy[headseg] = 0.0;
			
			headseg = (headseg + 1) % totalnumsegs;
			
			_trail.head_segment = headseg;
			_trail.num_segs = 2;			
		}
		else
		{			
			var headseg = (_trail.head_segment + (totalnumsegs - 1)) % totalnumsegs;	// update previous segment
			
			_trail.posx[headseg] = _posx;
			_trail.posy[headseg] = _posy;
			_trail.frame[headseg] = frame;
		
			var totalnumsegs = _trail.total_num_segs;
			var sqlength = 0.0;
						
			var prevseg = (headseg + (totalnumsegs - 1)) % totalnumsegs;
			var diffx = _posx - _trail.posx[prevseg];
			var diffy = _posy - _trail.posy[prevseg];
			
			var perpvecx, perpvecy;
			sqlength = (diffx * diffx) + (diffy * diffy);
			if (sqlength > 0.0)
			{
				var length = sqrt(sqlength);
				
				perpvecx = -(diffy / length) * _trail.halfwidth;
				perpvecy = (diffx / length) * _trail.halfwidth;
			}
			else
			{
				perpvecx = _trail.halfwidth;
				perpvecy = 0.0;
			}
			
			var pt1_posx = _posx - perpvecx;
			var pt1_posy = _posy - perpvecy;
			var pt2_posx = _posx + perpvecx;
			var pt2_posy = _posy + perpvecy;
			
			_trail.pt1_posx[headseg] = pt1_posx;
			_trail.pt1_posy[headseg] = pt1_posy;
			_trail.pt2_posx[headseg] = pt2_posx;
			_trail.pt2_posy[headseg] = pt2_posy;
						
			if (_trail.num_segs == 2)
			{
				// If we only have two points in the trail, set the first points perpendicular vectors to the same as the second point
				_trail.pt1_posx[prevseg] = _trail.posx[prevseg] - perpvecx;
				_trail.pt1_posy[prevseg] = _trail.posy[prevseg] - perpvecy;
				_trail.pt2_posx[prevseg] = _trail.posx[prevseg] + perpvecx;
				_trail.pt2_posy[prevseg] = _trail.posy[prevseg] + perpvecy;
			}
			
			// Ideally we would adjust the offset vectors of the previous point to be perpendicular to the average of the segment vectors
			// on either side of it but that's probably not noticeable in most cases			
				
			if (sqlength >= trail_min_segment_length_sq)
			{
				// Only move the head along if the difference between this point and the last is bigger than our threshold
				var currheadseg = _trail.head_segment;
				
				// Copy segment info to current head
				_trail.posx[currheadseg] = _posx;
				_trail.posy[currheadseg] = _posy;
				_trail.frame[currheadseg] = frame;
				_trail.pt1_posx[currheadseg] = pt1_posx;
				_trail.pt1_posy[currheadseg] = pt1_posy;
				_trail.pt2_posx[currheadseg] = pt2_posx;
				_trail.pt2_posy[currheadseg] = pt2_posy;
			
				var nextheadseg = (currheadseg + 1) % totalnumsegs;				
				_trail.head_segment = nextheadseg;
		
				if (nextheadseg == _trail.tail_segment)
				{
					// Could resize here, but for the moment just drop the last segment
					_trail.tail_segment = (_trail.tail_segment + 1) % totalnumsegs;
				}
				else
				{
					_trail.num_segs++;	
				}
			}
		}
	}		
	
	update_trails = function()
	{
		var i;
		for (i = 0; i < num_trails;)
		{
			var trail = trails[i];			
			var oldestvalidframe = frame - trail.lifetime;
						
			var totalnumsegs = trail.total_num_segs;			
			var trailseg = trail.tail_segment;
			
			if (trail.head_segment == trailseg)
			{
				// trail has no segments so bin it
				trails[i] = trails[num_trails - 1];
				num_trails--;
			}
			else
			{
				// We only want to remove a segment if the *next* one is too old
				// This preserves segments that are transition points between being alive and dead
				// so we get a smooth alpha fade-out
				var nexttrailseg = (trailseg + 1) % totalnumsegs;
				while((trail.head_segment != nexttrailseg) && (trail.frame[nexttrailseg] < oldestvalidframe))
				{
					trailseg = nexttrailseg;
					nexttrailseg = (nexttrailseg + 1) % totalnumsegs;
					trail.num_segs--;
				}
			
				var latesttrailseg = (trail.head_segment + (totalnumsegs - 1)) % totalnumsegs;
				if ((trail.frame[latesttrailseg] < oldestvalidframe))		// if the latest segment is older than the threshold, bin the trail
				{
					// trail has run out of segments so bin it
					trails[i] = trails[num_trails - 1];
					num_trails--;
				}
				else
				{
					trail.tail_segment = trailseg;
					i++;	
				}
			}
		}
	}
	
	draw_trails = function()
	{
		var i;
		
		gpu_set_blendmode_ext(param_trail_src_blend, param_trail_dest_blend);
		
		for (i = 0; i < num_trails; i++)
		{
			var trail = trails[i];						
			
			var totalnumsegs = trail.total_num_segs;			
			if (trail.num_segs < 2)
				continue;			// we need at least two active segments
				
			var oldestvalidframe = trail.lifetime + frame;
			
			var cols = trail.cols;
			var alphas = trail.alphas;
			var alphascale = trail.alphascale;
						
			var lifetime = trail.lifetime;
			
			if (trails_use_trilists)
			{			
				// In tests this was considerably slower, despite using less draw calls
				// The GML overhead outways any benefit - still various optimisations possible here though
				draw_primitive_begin(pr_trianglelist);
				var trailseg = trail.tail_segment;		
				var headseg = trail.head_segment;	
				var col = cols[3];
				
				var last_pt1_posx = trail.pt1_posx[trailseg];
				var last_pt1_posy = trail.pt1_posy[trailseg];
				var last_pt2_posx = trail.pt2_posx[trailseg];
				var last_pt2_posy = trail.pt2_posy[trailseg];
				var lastcol = col;
				var lastalpha = alphas[3];
				
				// This could be optimised
				var lifeprop = (frame - trail.frame[trailseg]) / lifetime;
				lifeprop = clamp(lifeprop, 0.0, 1.0);
				var colprop = lifeprop;
				var colzone = 0;
				colprop -= trail_col_dist[0];
				while((colprop > 0.0) && (colzone < 2))
				{
					colzone++
					colprop -= trail_col_dist[colzone];
				}
				var col_dist = trail_col_dist[colzone];
				if (col_dist <= 0.0)
					colprop = 0.0;
				else
					colprop = (lifeprop - trail_col_pos[colzone]) / col_dist;			
				
				lastcol = merge_colour(cols[colzone], cols[colzone+1], colprop);									
				lastalpha = lerp(alphas[colzone], alphas[colzone+1], colprop) * alphascale;				
				
				trailseg = (trailseg + 1) % totalnumsegs;
				
				while(headseg != trailseg)
				{
					// This could be optimised
					lifeprop = (frame - trail.frame[trailseg]) / lifetime;
					lifeprop = clamp(lifeprop, 0.0, 1.0);
					colprop = lifeprop;
					colzone = 0;
					colprop -= trail_col_dist[0];
					while((colprop > 0.0) && (colzone < 2))
					{
						colzone++
						colprop -= trail_col_dist[colzone];
					}
					col_dist = trail_col_dist[colzone];
					if (col_dist <= 0.0)
						colprop = 0.0;
					else
						colprop = (lifeprop - trail_col_pos[colzone]) / col_dist;			
				
					var col = merge_colour(cols[colzone], cols[colzone+1], colprop);									
					var alpha = lerp(alphas[colzone], alphas[colzone+1], colprop) * alphascale;
				
					draw_vertex_colour(last_pt1_posx, last_pt1_posy, lastcol, lastalpha);
					draw_vertex_colour(last_pt2_posx, last_pt2_posy, lastcol, lastalpha);
					draw_vertex_colour(trail.pt1_posx[trailseg], trail.pt1_posy[trailseg], col, alpha);
					draw_vertex_colour(trail.pt1_posx[trailseg], trail.pt1_posy[trailseg], col, alpha);
					draw_vertex_colour(last_pt2_posx, last_pt2_posy, lastcol, lastalpha);
					draw_vertex_colour(trail.pt2_posx[trailseg], trail.pt2_posy[trailseg], col, alpha);
					
					last_pt1_posx = trail.pt1_posx[trailseg];
					last_pt1_posy = trail.pt1_posy[trailseg];
					last_pt2_posx = trail.pt2_posx[trailseg];
					last_pt2_posy = trail.pt2_posy[trailseg];
					lastcol = col;
					lastalpha = alpha;
				
					trailseg = (trailseg + 1) % totalnumsegs;
				}
				draw_primitive_end();	
			}
			else
			{
				// TODO: Look at joining strips with degenerate tris to reduce draw calls
				draw_primitive_begin(pr_trianglestrip);
				var trailseg = trail.tail_segment;		
				var headseg = trail.head_segment;					
				while(headseg != trailseg)
				{					
					var lifeprop = (frame - trail.frame[trailseg]) / lifetime;
					lifeprop = clamp(lifeprop, 0.0, 1.0);
					var colprop = lifeprop;
					var colzone = 0;
					colprop -= trail_col_dist[0];
					while((colprop > 0.0) && (colzone < 2))
					{
						colzone++
						colprop -= trail_col_dist[colzone];
					}
					var col_dist = trail_col_dist[colzone];
					if (col_dist <= 0.0)
						colprop = 0.0;
					else
						colprop = (lifeprop - trail_col_pos[colzone]) / col_dist;			
				
					var col = merge_colour(cols[colzone], cols[colzone+1], colprop);									
					var alpha = lerp(alphas[colzone], alphas[colzone+1], colprop) * alphascale;				
				
					draw_vertex_colour(trail.pt1_posx[trailseg], trail.pt1_posy[trailseg], col, alpha);
					draw_vertex_colour(trail.pt2_posx[trailseg], trail.pt2_posy[trailseg], col, alpha);
				
					trailseg = (trailseg + 1) % totalnumsegs;
				}
				draw_primitive_end();	
			}
		}
	}
	
	setup_particle = function(_spawnxmin, _spawnxmax, _spawnymin, _spawnymax, _spawnweights, _centrex, _centrey, _view_velx, _view_vely, _gamespeed, _spawn_in_one_zone)
	{
		var particle = 
		{					
			velx:random_range(param_particle_initial_velocity_range_x_min, param_particle_initial_velocity_range_x_max),
			vely:random_range(param_particle_initial_velocity_range_y_min, param_particle_initial_velocity_range_y_max),
			rot:random_range(param_particle_initial_rotation_min, param_particle_initial_rotation_max),
			rotspeed:random_range(param_particle_rot_speed_min, param_particle_rot_speed_max),
			subimage:irandom_range(0, sprite_get_number(param_sprite) - 1),
			mass:max(random_range(param_particle_mass_min, param_particle_mass_max), 0.00001),			
			lifetime:(random_range(param_particle_lifetime_min, param_particle_lifetime_max) * _gamespeed),		// lifetime in frames
			spawnframe:frame			
		};		
		
		if (_spawn_in_one_zone)
		{
			// In this mode, _spawnxmin etc are single values rather than an array
			particle.posx = random_range(_spawnxmin, _spawnxmax);
			particle.posy = random_range(_spawnymin, _spawnymax);
			particle.lastposx = particle.posx;
			particle.lastposy = particle.posy;
		}
		else
		{
			// Use weighted zone selection so we don't spawn the same amount of particles in smaller zones as larger ones
			// The order of the zones is:
			// +---+---+---+
			// | 0 | 1 | 2 |
			// +---+---+---+
			// | 3 |   | 4 |
			// +---+---+---+
			// | 5 | 6 | 7 |
			// +---+---+---+
			var zonerand = random_range(0, 0.9999);		
			var zone = 0;
			zonerand -= _spawnweights[zone];
			while((zonerand > 0) && (zone < 7))
			{
				zone++;							
				zonerand -= _spawnweights[zone];
			}
			particle.posx = random_range(_spawnxmin[zone], _spawnxmax[zone]);
			particle.posy = random_range(_spawnymin[zone], _spawnymax[zone]);
			particle.lastposx = particle.posx;
			particle.lastposy = particle.posy;
				
			var view_rel_velx = particle.velx - _view_velx;
			var view_rel_vely = particle.vely - _view_vely;
					
			// Make sure the particles are actually on a trajectory that will move then into view
			// If they are moving in the wrong direction, mirror their position across the centre point
			// We could select the correct zone in the first place but that is probably slower as the zones
			// aren't arranged in a regular order
			// See above for zone indicies
			if ((((particle.posx - _spawnxmax[0]) < 0) && (view_rel_velx < 0)) || (((particle.posx - _spawnxmin[2]) > 0) && (view_rel_velx > 0)))
				particle.posx = _centrex + (_centrex - particle.posx);	// flip particle position around centre
			if ((((particle.posy - _spawnymax[0]) < 0) && (view_rel_vely < 0)) || (((particle.posy - _spawnymin[5]) > 0) && (view_rel_vely > 0)))
				particle.posy = _centrey + (_centrey - particle.posy);	// flip particle position around centre
		}
					
		var colblend = random_range(0.0, 1.0);					
		particle.cols = array_create(4);
		particle.alphas = array_create(4);
		
		particle.cols[0] = merge_colour(particle_col[0], particle_col_alt[0], colblend);
		particle.cols[1] = merge_colour(particle_col[1], particle_col_alt[1], colblend);
		particle.cols[2] = merge_colour(particle_col[2], particle_col_alt[2], colblend);
		particle.cols[3] = merge_colour(particle_col[3], particle_col_alt[3], colblend);
		
		particle.alphas[0] = lerp(particle_alpha[0], particle_alpha_alt[0], colblend);
		particle.alphas[1] = lerp(particle_alpha[1], particle_alpha_alt[1], colblend);
		particle.alphas[2] = lerp(particle_alpha[2], particle_alpha_alt[2], colblend);
		particle.alphas[3] = lerp(particle_alpha[3], particle_alpha_alt[3], colblend);
				
		if (random(100) < param_trail_chance)
		{
			var spritesize = min(sprwidth, sprheight) * particle.mass * param_particle_start_sprite_scale * particle_scale_compensation;
			particle.trail = spawn_trail(random_range(param_trail_lifetime_min, param_trail_lifetime_max), spritesize);
			add_trail_segment(particle.trail, particle.posx, particle.posy);
		}
		else
		{
			particle.trail = undefined;	
		}
		
		return particle;
	}
	
	draw_particles = function()
	{
		gpu_set_blendmode_ext(param_particle_src_blend, param_particle_dest_blend);
		
		var i;
		for(i = 0; i < num_particles; i++)
		{
			var particle = particles[i];			
			
			var lifeprop = (frame - particle.spawnframe) / particle.lifetime;				
			lifeprop = clamp(lifeprop, 0.0, 1.0);											
			
			// Get the interpolated colour and alpha values from our piecewise-linear curve
			// It may be worth converting this to a regularly spaced list of points
			// which would be quicker to evaluate at the cost of some inaccuracy
			var colprop = lifeprop;
			var colzone = 0;
			colprop -= particle_col_dist[0];
			while((colprop > 0.0) && (colzone < 2))
			{
				colzone++
				colprop -= particle_col_dist[colzone];
			}
			var col_dist = particle_col_dist[colzone];
			if (col_dist <= 0.0)
				colprop = 0.0;
			else
				colprop = (lifeprop - particle_col_pos[colzone]) / col_dist;
				
			var cols = particle.cols;
			var alphas = particle.alphas;
				
			var spritecol = merge_colour(cols[colzone], cols[colzone+1], colprop);									
			var spritealpha = lerp(alphas[colzone], alphas[colzone+1], colprop);
			
			if (particle.trail != undefined)
			{
				particle.trail.alphascale = spritealpha;	
			}
			
			if (param_trails_only == 0)
			{
				var rot = 0.0;			
				if ((param_particle_align_vel > 0) && (particle.lastposx != particle.posx) && (particle.lastposy != particle.posy))
				{
					var diffx = particle.posx - particle.lastposx;
					var diffy = particle.posy - particle.lastposy;
					var length = sqrt((diffx * diffx) + (diffy * diffy));
					diffy /= length;
					rot = (arccos(-diffy) / pi) * 180.0;
					if (diffx > 0)
						rot = -rot;
				}		
			
				var spritescale = particle.mass * particle_scale_compensation * lerp(param_particle_start_sprite_scale, param_particle_end_sprite_scale, lifeprop);			
			
				draw_sprite_ext(param_sprite, particle.subimage, particle.posx, particle.posy, spritescale, spritescale, particle.rot + rot, spritecol, spritealpha);
			}
		}
	}
	
	step = function()
	{		
		var i, j, k;	
		var gamespeed = game_get_speed(gamespeed_fps);
		var timedelta = 1.0 / gamespeed;
		
		// update colour values
		update_colours();
		
		var minx = 0, maxx = 0, miny = 0, maxy = 0;				
		if (view_enabled)
		{
			// Get maximal bounding box of current views
			// Ideally we'd do this based on the actual matrices so we'd handle perspective cameras too
			// But that requires that we know what depth we're drawing at, which isn't practical from Step			
			var first = true;
			for(i = 0; i < 8; i++)
			{
				if (view_visible[i])
				{
					var cam = view_camera[i];
					var cam_minx = camera_get_view_x(cam);
					var cam_miny = camera_get_view_y(cam);
					var cam_maxx = cam_minx + camera_get_view_width(cam);
					var cam_maxy = cam_miny + camera_get_view_height(cam);
					
					if (first)
					{
						first = false;	
						minx = cam_minx;
						miny = cam_miny;
						maxx = cam_maxx;
						maxy = cam_maxy;
					}
					else
					{
						minx = min(minx, cam_minx);
						miny = min(miny, cam_miny);
						maxx = max(maxx, cam_maxx);
						maxy = max(maxy, cam_maxy);
					}
				}
			}
			
		}
		else
		{
			minx = 0;
			miny = 0;
			maxx = room_width;
			maxy = room_height;
		}
		
		var centrex = (minx + maxx) / 2.0;
		var centrey = (miny + maxy) / 2.0;
		
		views_minx = minx;
		views_maxx = maxx;
		views_miny = miny;
		views_maxy = maxy;
		views_centrex = centrex;
		views_centrey = centrey;
		
		if (frame == 0)
		{
			last_view_centrex = centrex;
			last_view_centrey = centrey;
		}
		
		// Get view movement speed in pixels-per-second
		var view_velx = centrex - last_view_centrex;
		var view_vely = centrey - last_view_centrey;
		
		if (timedelta != 0)
		{
			view_velx /= timedelta;
			view_vely /= timedelta;
		}
		
		last_view_centrex = centrex;
		last_view_centrey = centrey;
		
		var floored_param_force_grid_size_x = floor(param_force_grid_sizex);
		var floored_param_force_grid_size_y = floor(param_force_grid_sizey);
		
		var cellsizex = (maxx - minx) / (floored_param_force_grid_size_x - (grid_margin * 2));
		var cellsizey = (maxy - miny) / (floored_param_force_grid_size_y - (grid_margin * 2));
		
		if ((force_grid_sizex != floored_param_force_grid_size_x) ||
			(force_grid_sizey != floored_param_force_grid_size_y))
		{
			force_grid_sizex = floored_param_force_grid_size_x;
			force_grid_sizey = floored_param_force_grid_size_y;
			
			force_grid = array_create(force_grid_sizey * force_grid_sizex * 2);
			
			force_grid_centrex = centrex;
			force_grid_centrey = centrey;
		}		
		
		var celldiffx = floor((centrex - force_grid_centrex) / cellsizex);
		var celldiffy = floor((centrey - force_grid_centrey) / cellsizey);
		
		if (celldiffx > 0)
		{		
			force_grid_offsetx += celldiffx;
			force_grid_offsetx = force_grid_offsetx % force_grid_sizex;
			force_grid_centrex += celldiffx * cellsizex;
		}
		else if (celldiffx < 0)
		{
			var celldiff = -celldiffx;	
			celldiff = celldiff % force_grid_sizex;
			
			force_grid_offsetx += (force_grid_sizex - celldiff);
			force_grid_offsetx = force_grid_offsetx % force_grid_sizex;
			force_grid_centrex += celldiffx * cellsizex;
		}
				
		if (celldiffy > 0)
		{		
			force_grid_offsety += celldiffy;
			force_grid_offsety = force_grid_offsety % force_grid_sizey;
			force_grid_centrey += celldiffy * cellsizey;
		}
		else if (celldiffy < 0)
		{
			var celldiff = -celldiffy;	
			celldiff = celldiff % force_grid_sizey;
			
			force_grid_offsety += (force_grid_sizey - celldiff);
			force_grid_offsety = force_grid_offsety % force_grid_sizey;
			force_grid_centrey += celldiffy * cellsizey;
		}	
		
		var grid_basex = force_grid_centrex - ((force_grid_sizex * cellsizex) * 0.5);
		var grid_basey = force_grid_centrey - ((force_grid_sizey * cellsizey) * 0.5);
		
		var floored_param_num_blowers = floor(param_num_blowers);
		if (num_blowers < floored_param_num_blowers)
		{
			if (array_length(blowers) < floored_param_num_blowers)
			{
				array_resize(blowers, floored_param_num_blowers);
			}				
			
			for(i = num_blowers; i < floored_param_num_blowers; i++)
			{
				blowers[i] = spawn_blower(minx, maxx, miny, maxy);
			}
			
			num_blowers = floored_param_num_blowers;
		}
		
		for(i = 0; i < num_blowers;)
		{
			var blower = blowers[i];
			blower.posx += (blower.velx - (view_velx * param_blower_camvec_scale)) * timedelta;
			blower.rot += (blower.rotspeed * timedelta);
			
			var respawn = false;
			if (((blower.velx < 0) && ((blower.posx + blower.size) < minx)) ||
				((blower.velx > 0) && ((blower.posx - blower.size) > maxx)) ||
				((blower.posy + blower.size) < miny) ||
				((blower.posy - blower.size) > maxy))
			{
				respawn = true;
			}
			
			if (respawn && (num_blowers > floored_param_num_blowers))
			{
				// remove blower
				blowers[i] = blowers[num_blowers - 1];
				num_blowers--;
			}
			else if (respawn)
			{
				blowers[i] = spawn_blower(minx, maxx, miny, maxy);
					
				i++;
			}
			else
			{
				i++;
			}
		}
		
		for(i = 0; i < num_blowers; i++)
		{
			var blower = blowers[i];
			blower.vecx = sin(blower.rot) * blower.force;
			blower.vecy = cos(blower.rot) * blower.force;
		}
		
		// Fill force grid				
		for(i = (force_grid_sizey - 1); i >= 0; i--)
		{			
			var gridy = (i + force_grid_offsety) % force_grid_sizey;
			var gridposy = grid_basey + (i * cellsizey);
			
			for(j = 0; j < force_grid_sizex; j++)
			{				
				var gridx = (j + force_grid_offsetx) % force_grid_sizex;
				var gridposx = grid_basex + (j * cellsizex);
				
				var vecx = param_wind_vector_x;
				var vecy = param_wind_vector_y;
				
				for(k = 0; k < num_blowers; k++)
				{
					var blower = blowers[k];
					var diffx = blower.posx - gridposx;
					var diffy = blower.posy - gridposy;
					
					var sqdist = (diffx * diffx) + (diffy * diffy);															
					
					var blowersize = blower.size;
					if (sqdist < (blowersize * blowersize))
					{
						var dist = sqrt(sqdist);
						var weight = 1.0 - (dist / blowersize);						
						
						vecx += blower.vecx * weight;
						vecy += blower.vecy * weight;
					}
					
				}				
				
				var index = ((gridy * force_grid_sizex) + gridx) * 2;
				force_grid[index] = vecx;
				force_grid[index + 1] = vecy;
			}
		}
		
		trail_min_segment_length_sq = param_trail_min_segment_length * param_trail_min_segment_length;
		
		sprwidth = sprite_get_width(param_sprite);
		sprheight = sprite_get_height(param_sprite);	
		
		var max_mass = max(param_particle_mass_min, param_particle_mass_max);
		if (max_mass != 0.0)
		{
			particle_scale_compensation = 1.0 / max_mass;
		}
		else
		{
			particle_scale_compensation = 1.0;
		}
		
		var sprsize = max(sprwidth, sprheight) * max(param_particle_start_sprite_scale, param_particle_end_sprite_scale);
		
		var border_prop = max(0.001, param_particle_spawn_border_prop);
		var spawnxmargin = (maxx - minx) * border_prop;
		var spawnymargin = (maxy - miny) * border_prop;
				
		// Work out off-screen bounds
		var os_spawnboundsx = [ (minx - spawnxmargin) - sprsize, minx - sprsize, maxx + sprsize, maxx + spawnxmargin + sprsize];
		var os_spawnboundsy = [ (miny - spawnymargin) - sprsize, miny - sprsize, maxy + sprsize, maxy + spawnymargin + sprsize];	
		
		var os_spawnxmin = [os_spawnboundsx[0], os_spawnboundsx[1], os_spawnboundsx[2], os_spawnboundsx[0], os_spawnboundsx[2], os_spawnboundsx[0], os_spawnboundsx[1], os_spawnboundsx[2]];
		var os_spawnxmax = [os_spawnboundsx[1], os_spawnboundsx[2], os_spawnboundsx[3], os_spawnboundsx[1], os_spawnboundsx[3], os_spawnboundsx[1], os_spawnboundsx[2], os_spawnboundsx[3]];
		var os_spawnymin = [os_spawnboundsy[0], os_spawnboundsy[0], os_spawnboundsy[0], os_spawnboundsy[1], os_spawnboundsy[1], os_spawnboundsy[2], os_spawnboundsy[2], os_spawnboundsy[2]];
		var os_spawnymax = [os_spawnboundsy[1], os_spawnboundsy[1], os_spawnboundsy[1], os_spawnboundsy[2], os_spawnboundsy[2], os_spawnboundsy[3], os_spawnboundsy[3], os_spawnboundsy[3]];
		
		var os_spawnweights = [];
		var os_weighttotal = 0.0;
		for(i = 0; i < 7; i++)
		{
			os_spawnweights[i] = (os_spawnxmax[i] - os_spawnxmin[i]) * (os_spawnymax[i] - os_spawnymin[i]);
			os_weighttotal += os_spawnweights[i];
		}
		
		for(i = 0; i < 7; i++)
		{
			os_spawnweights[i] /= os_weighttotal;
		}
			
		do
		{
			update_trails();
							
			var spawnxmin;
			var spawnxmax;
			var spawnymin;
			var spawnymax;
			var spawnweights;
			var spawn_all_now;
			var spawn_in_one_zone;
		
			if ((frame == 0) && (param_particle_spawn_all_at_start != 0))
			{
				// Spawn particles on-screen		
				spawnxmin = (minx - spawnxmargin) - sprsize;
				spawnxmax = maxx + spawnxmargin + sprsize;
				spawnymin = (miny - spawnymargin) - sprsize;
				spawnymax = maxy + spawnymargin + sprsize;
				spawnweights = 0;
			
				spawn_all_now = true;
				spawn_in_one_zone = true;
			}
			else
			{
				// Spawn particles off-screen								
				spawnxmin = os_spawnxmin; 
				spawnxmax = os_spawnxmax;
				spawnymin = os_spawnymin;
				spawnymax = os_spawnymax;
		
				spawnweights = os_spawnweights;				
			
				spawn_all_now = false;
				spawn_in_one_zone = false;
			}
			
			var floored_param_num_particles = floor(param_num_particles);
			if (num_particles < floored_param_num_particles)
			{			
				var new_num_particles = floored_param_num_particles;
				if ((param_particle_spawn_time > 0.0) && (spawn_all_now == false))
				{
					time_since_last_particle += timedelta;				
				
					var spawn_time_seconds = param_particle_spawn_time / 1000.0;
				
					new_num_particles = min(new_num_particles, num_particles + floor(time_since_last_particle / spawn_time_seconds));				
					time_since_last_particle = time_since_last_particle % spawn_time_seconds;
				}			
		
				if (array_length(particles) < new_num_particles)
				{
					array_resize(particles, new_num_particles);
				}			
			
				for(i = num_particles; i < new_num_particles; i++)
				{					
					particles[i] = setup_particle(spawnxmin, spawnxmax, spawnymin, spawnymax, spawnweights, centrex, centrey, view_velx, view_vely, gamespeed, spawn_in_one_zone);
				}
			
				num_particles = new_num_particles;
			}						
				
			var dragcoeffs = air_density * param_dragcoeff * 0.5;
						
			var update_skip = floor(param_particle_update_skip + 1);
			for(i = 0; i < num_particles;)
			{
				var respawn = false;
				var particle = particles[i];
			
				if ((particle.spawnframe + particle.lifetime) <= frame)
				{
					respawn = true;
				}
			
				if (!respawn)
				{				
					if (((frame + i) % update_skip) != 0)
					{
						particle.lastposx = particle.posx;
						particle.lastposy = particle.posy;
			
						particle.posx += particle.velx * timedelta;
						particle.posy += particle.vely * timedelta;
				
						if (particle.trail != undefined)
						{
							add_trail_segment(particle.trail, particle.posx, particle.posy);
						}
				
						particle.rot += particle.rotspeed * timedelta;
						i++;
				
						continue;
					}
			
					// look up force grid
					var gridx = (particle.posx - grid_basex) / cellsizex;
					var gridy = (particle.posy - grid_basey) / cellsizey;
					var blendx = frac(gridx);
					var blendy = frac(gridy);
					gridx = floor(gridx);
					gridy = floor(gridy);
					gridx = (gridx + force_grid_offsetx) % force_grid_sizex;
					gridy = (gridy + force_grid_offsety) % force_grid_sizey;
			
					if (gridx < 0)
						gridx = force_grid_sizex + gridx;
					if (gridy < 0)
						gridy = force_grid_sizey + gridy;
			
					var force1x, force1y, force2x, force2y, force3x, force3y, force4x, force4y;
					var gridtempx1 = gridx;			
					var gridtempx2 = ((gridx + 1) % force_grid_sizex);			
					var gridtempy1 = gridy * force_grid_sizex;
					var gridtempy2 = ((gridy + 1) % force_grid_sizey) * force_grid_sizex;
			
					var index1 = (gridtempy1 + gridtempx1) * 2;
					var index2 = (gridtempy1 + gridtempx2) * 2;
					var index3 = (gridtempy2 + gridtempx1) * 2;
					var index4 = (gridtempy2 + gridtempx2) * 2;
			
					var gridforcex;
					var gridforcey;
					
					// Sample grid
					force1x = force_grid[index1];
					force1y = force_grid[index1 + 1];
						
					force2x = force_grid[index2];
					force2y = force_grid[index2 + 1];
						
					force3x = force_grid[index3];
					force3y = force_grid[index3 + 1];
			
					force4x = force_grid[index4];			
					force4y = force_grid[index4 + 1];			
			
					// Bilinear filter
					// (could precalculate force differences between adjacent cells to avoid having to do subtractions here)
					var topval = ((force2x - force1x) * blendx) + force1x;
					var bottomval = ((force4x - force3x) * blendx) + force3x;
					gridforcex = ((bottomval - topval) * blendy) + topval;
			
					topval = ((force2y - force1y) * blendx) + force1y;
					bottomval = ((force4y - force3y) * blendx) + force3y;
					gridforcey = ((bottomval - topval) * blendy) + topval;
			
					var thisparticlemass = particle.mass;
			
					var particle_velx = particle.velx;
					var particle_vely = particle.vely;
			
					particle_velx += (gridforcex / thisparticlemass) * timedelta;
					particle_vely += (gridforcey / thisparticlemass) * timedelta;
			
					// Apply gravity
					particle_vely += param_grav_accel * timedelta;
			
					// Apply drag
					var forcex = dragcoeffs * particle.mass * (particle_velx * particle_velx);
					var forcey = dragcoeffs * particle.mass * (particle_vely * particle_vely);
			
					if (particle_velx > 0)
						forcex = -forcex;
					if (particle_vely > 0)
						forcey = -forcey;
			
					particle_velx += ((forcex / thisparticlemass) * timedelta);
					particle_vely += ((forcey / thisparticlemass) * timedelta);			
			
					particle.velx = particle_velx;
					particle.vely = particle_vely;
			
					particle.lastposx = particle.posx;
					particle.lastposy = particle.posy;
			
					particle.posx += particle_velx * timedelta;
					particle.posy += particle_vely * timedelta;
			
					var view_rel_velx = particle_velx - view_velx;
					var view_rel_vely = particle_vely - view_vely;
									
					if (((view_rel_velx < 0) && ((particle.posx + sprsize) < minx)) ||
						((view_rel_velx > 0) && ((particle.posx - sprsize) > maxx)) ||
						((view_rel_vely < 0) && ((particle.posy + sprsize) < miny)) ||
						((view_rel_vely > 0) && ((particle.posy - sprsize) > maxy)))
					{
						respawn = true;
					}
				}
			
				if (respawn && (num_particles > floored_param_num_particles))
				{
					// remove particle
					particles[i] = particles[num_particles - 1];
					num_particles--;
				}
				else if (respawn)
				{
					particles[i] = setup_particle(spawnxmin, spawnxmax, spawnymin, spawnymax, spawnweights, centrex, centrey, view_velx, view_vely, gamespeed, spawn_in_one_zone);					
				
					i++;
				}
				else
				{			
					if (particle.trail != undefined)
					{
						add_trail_segment(particle.trail, particle.posx, particle.posy);
					}
				
					particle.rot += particle.rotspeed * timedelta;
					i++;	
				}
			}
		
			frame++;
		} until (frame > param_warmup_frames);
	}
	
	room_start = function()
	{
		
	}
	
	room_end = function()
	{
		reset();
	}
	
	layer_begin = function()
	{
		
	}
	
	layer_end = function()
	{
		if ((event_type != ev_draw) || (event_number != 0))
			return;	// wrong event			
		
		gpu_push_state();		
		
		var oldcol = draw_get_colour();
		var oldalpha = draw_get_alpha();
		
		draw_trails();		
		draw_particles();	
		
		if (param_debug_grid > 0)
		{
			draw_set_colour(c_white);
			draw_set_alpha(debug_grid_alpha);
			var cellsizex = (views_maxx - views_minx) / (force_grid_sizex - (grid_margin * 2));
			var cellsizey = (views_maxy - views_miny) / (force_grid_sizey - (grid_margin * 2));
			
			var grid_basex = force_grid_centrex - ((force_grid_sizex * cellsizex) * 0.5);
			var grid_basey = force_grid_centrey - ((force_grid_sizey * cellsizey) * 0.5);
			
			var i, j;
												
			for(i = 0; i < force_grid_sizey; i++)
			{
				for(j = 0; j < force_grid_sizex; j++)
				{														
					var gridx = (j + force_grid_offsetx) % force_grid_sizex;
					var gridy = (i + force_grid_offsety) % force_grid_sizey;
					
					var index = ((gridy * force_grid_sizex) + gridx) * 2;
					var forcevecx = force_grid[index];
					var forcevecy = force_grid[index + 1];
					forcevecx *= debug_force_scale;
					forcevecy *= debug_force_scale;
					
					var startx = (grid_basex + (cellsizex * (j + 0.5))) - (forcevecx * 0.5);
					var starty = (grid_basey + (cellsizey * (i + 0.5))) - (forcevecy * 0.5);
					
					draw_arrow(startx, starty, startx + forcevecx, starty + forcevecy, 10);
					
				}
			}
			
			if (param_debug_grid > 1)
			{
				draw_set_colour(c_yellow);
				for(i = 0; i < num_blowers; i++)
				{
					draw_circle(blowers[i].posx, blowers[i].posy, blowers[i].size, true);
				
					var halfforcevecx = blowers[i].vecx * debug_force_scale * 0.5;
					var halfforcevecy = blowers[i].vecy * debug_force_scale * 0.5;
					draw_arrow(blowers[i].posx - halfforcevecx, blowers[i].posy - halfforcevecy, blowers[i].posx + halfforcevecx, blowers[i].posy + halfforcevecy, 10);
				}
			}
		}
		
		draw_set_colour(oldcol);
		draw_set_alpha(oldalpha);
		
		gpu_pop_state();
	}
	
	reset();
}