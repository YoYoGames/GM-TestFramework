//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;		// (x,y,z)
attribute vec3 in_Normal;		// (x,y,z)
attribute vec4 in_Colour;		// (r,g,b,a)
attribute vec2 in_TextureCoord;	// (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	vec3 scaled_normal = (in_Normal / 2.0) + 0.5;
    v_vColour = vec4(scaled_normal.x, scaled_normal.y, scaled_normal.z, 1.0);
    v_vTexcoord = in_TextureCoord;
}
