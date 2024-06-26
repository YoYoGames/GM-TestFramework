//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
//attribute vec2 in_TextureCoord;              // (u,v)

//varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//varying mat4 v_mat_view;
//varying mat4 v_mat_projection;
//varying mat4 v_mat_world;
//varying mat4 v_mat_world_view;
//varying mat4 v_mat_world_view_projection;
//varying float v_mat_max;
//varying float v_max_vs_lights;

//varying bool v_gm_lighting_enabled;
//varying vec4 v_gm_lights_direction[8];
//varying vec4 v_gm_lights_posrange[8];
//varying vec4 v_gm_lights_colour[9];
//varying vec4 v_gm_ambient_colour;
//varying float v_gm_fog_start;
//varying float v_gm_rcp_fog_range;
//varying vec4 v_gm_fog_colour;
//varying bool v_gm_vs_fog_enabled;

uniform int u_expected_lighting_enabled;
uniform vec4 u_expected_lights_direction[8];
//uniform int u_expected_lights_pos_range
//uniform int u_expected_lights_colour
//uniform int u_expected_ambient_colour
//uniform int u_expected_fog_start
//uniform int u_expected_rcp_fog_range
uniform int u_expected_fog_enabled;


void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	v_vColour = vec4(0.0, 0.0, 0.0, 1.0);
	if (int(in_Colour.r * 255.0) == 0) {
		// Test gm_VS_FogEnabled
		if (gm_LightingEnabled == bool(u_expected_lighting_enabled))
		{
			v_vColour = vec4(1.0);
		}
	} 
	else if (int(in_Colour.r * 255.0) == 1) {
		// Test gm_Lights_Direction[0]
		if (gm_Lights_Direction[0] == u_expected_lights_direction[0])
		{
			v_vColour = vec4(1.0);
		}
	}
	else if (int(in_Colour.r * 255.0) == 2) {
		// Test gm_Lights_Direction[0]
		if (gm_Lights_Direction[0] == u_expected_lights_direction[0])
		{
			v_vColour = vec4(1.0);
		}
	}
	else if (int(in_Colour.r * 255.0) == 3) {
		// Test gm_Lights_Direction[0]
		if (gm_Lights_Direction[0] == u_expected_lights_direction[0])
		{
			v_vColour = vec4(1.0);
		}
	}
	else if (int(in_Colour.r * 255.0) == 4) {
		// Test gm_Lights_Direction[0]
		if (gm_Lights_Direction[0] == u_expected_lights_direction[0])
		{
			v_vColour = vec4(1.0);
		}
	}
	else if (int(in_Colour.r * 255.0) == 5) {
		// Test gm_VS_FogEnabled
		if (gm_VS_FogEnabled == bool(u_expected_fog_enabled))
		{
			v_vColour = vec4(1.0);
		}
	}
    //v_vTexcoord = in_TextureCoord;
}
