// This shader will test the MAX_VS_LIGHTS constant by outputting it's value as the RGB components of the vertex colour.
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
    
	// Get MAX_VS_LIGHTS
	float max_lights = float(MAX_VS_LIGHTS);
	
	// Set the RGB components of the vertex colour to its value (scaled to be between 0 and 1)
    v_vColour = vec4(max_lights / 255.0, max_lights / 255.0, max_lights / 255.0, 1.0);
}