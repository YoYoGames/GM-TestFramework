//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
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

uniform float u_expected_alpha_ref_value;
uniform int u_expected_alpha_test_enabled;
uniform vec4 u_expected_fog_colour;
uniform int u_expected_fog_enabled;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	
	//v_mat_view = gm_Matrices[MATRIX_VIEW];
	//v_mat_projection = gm_Matrices[MATRIX_PROJECTION];
	//v_mat_world = gm_Matrices[MATRIX_WORLD];
	//v_mat_world_view = gm_Matrices[MATRIX_WORLD_VIEW];
	//v_mat_world_view_projection = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION];
	//v_mat_max = MATRIX_MAX;
	//v_max_vs_lights = MAX_VS_LIGHTS;
	//v_gm_lighting_enabled = gm_LightingEnabled;
	//v_gm_lights_direction = gm_Lights_Direction;
	//v_gm_lights_posrange = gm_Lights_PosRange;
	//v_gm_lights_colour = gm_Lights_Colour;
	//v_gm_ambient_colour = gm_AmbientColour;
	//v_gm_fog_start = gm_FogStart;
	//v_gm_rcp_fog_range = gm_RcpFogRange;
	//v_gm_fog_colour = gm_FogColour;
	//v_gm_vs_fog_enabled = gm_VS_FogEnabled;
}
