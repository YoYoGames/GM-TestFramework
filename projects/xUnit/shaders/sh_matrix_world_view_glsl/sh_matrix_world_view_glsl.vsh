// This shader is intended to be used with a 4x4 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Matrices[MATRIX_WORLD_VIEW] by setting the red component of each rectangle in the grid to each expected value in the matrix,
// and the green and blue components to each actual value, making the image grayscale when the values match, and any differences are shown in red/cyan.
// Vertex Shader

// Input values
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

// Output values
varying vec4 v_vColour;

// Uniforms
uniform mat4 u_expected_matrix; // The expected value of the matrix
uniform mat4 u_initial_matrix_world_view_projection; // The world_view_projection matrix before it was modified for the test


void main()
{
	// Calculate the vertex's position on screen using u_initial_matrix_world_view_projection, since the world_view_projection matrix has been modified
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = u_initial_matrix_world_view_projection * object_space_pos;
	
	// Get the index of the current rectangle via it's red value
	int rect_index = int(in_Colour.r * 255.0);
	// Get the rectangle's row and column in the grid by finding the remainder (mod) and integer quotient (div) when dividing by the grid width
	int row = int(mod(float(rect_index), 4.0));
	int column = rect_index / 4;
	
	// Get the expected value at the current row and column
	float expected_value = u_expected_matrix[row][column];
	// Get the actual value at the current row and column
	float actual_value = gm_Matrices[MATRIX_WORLD_VIEW][row][column];
	
	// Set the vertex's red value to the expected value, and the green and blue values to the actual value
	// (both scaled to show values of 0-1 as 0.25-0.75, to make values over 1 or under 0 identifyable)
	v_vColour = vec4((expected_value/2.0) + 0.25, (actual_value/2.0) + 0.25, (actual_value/2.0) + 0.25, 1.0);
}