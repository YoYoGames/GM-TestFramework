// This shader tests the gm_AmbientColour built-in uniform by setting it as the vertex colour
// Vertex Shader

// Input values
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

// Output values
varying vec4 v_vColour;


void main()
{
	// Calculate the vertex's position on screen using the world_view_projection matrix
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	// Set the vertex colour to the value from gm_AmbientColour 
	vec4 value = gm_AmbientColour;
	v_vColour = vec4(value.x, value.y, value.z, value.w);
}