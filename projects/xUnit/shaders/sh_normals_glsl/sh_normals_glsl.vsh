// This shader tests in_Normal by colouring each vertex based on its normal value
// Vertex Shader

// Input values
attribute vec3 in_Position;		// (x,y,z)
attribute vec3 in_Normal;		// (x,y,z)
attribute vec4 in_Colour;		// (r,g,b,a)
attribute vec2 in_TextureCoord;	// (u,v)

// Output values
varying vec4 v_vColour;


void main()
{
	// Calculate the vertex's position on screen using the world_view_projection matrix
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	// Scale the normal's values to be between 0 and 1
	vec3 scaled_normal = (in_Normal / 2.0) + 0.5;
	
	// Set the red, green and blue values of each vertex to the scaled x, y and z values of the normal
    v_vColour = vec4(scaled_normal.x, scaled_normal.y, scaled_normal.z, 1.0);
}
