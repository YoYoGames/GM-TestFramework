// This shader is intended to be used with a 4x2 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_Direction by attempting to set each rectangle's RGBA colour values to each light direction's xyzw value.
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
	
	// Get the index of the current rectangle via it's red value
	int rect_index = int(in_Colour.r * 255.0);
	
	// Get the light direction for the light corresponding to that index
	vec4 value = gm_Lights_Direction[rect_index];
	
	//// This code is used to create expected image/buffer for comparison, with all lights set
	//if (rect_index == 3)
	//{
	//	value.w = 0.0;
	//}
	
	// Set vertex colour to value from light direction (scaled to be between 0 and 1)
	v_vColour = vec4((value.x * 2.0) + 0.5, (value.y * 2.0) + 0.5, (value.z * 2.0) + 0.5, value.w);
}
