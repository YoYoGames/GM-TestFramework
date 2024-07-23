// This shader tests the gm_VS_FogEnabled built-in uniform by outputting white if it's true and black if it's false
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
	
	// Set vertex colour to black
	v_vColour = vec4(0.0, 0.0, 0.0, 1.0);
	
	// If gm_VS_FogEnabled is true, then set the vertex colour to white
	if (gm_VS_FogEnabled == true)
	{
		v_vColour = vec4(1.0, 1.0, 1.0, 1.0);
	}
	
	//// This code is used to create expected image/buffer for comparison, with fog enabled
	//v_vColour = vec4(1.0, 1.0, 1.0, 1.0);
}
