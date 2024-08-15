// This shader is intended to be used with a 4x4 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] by setting the red component of each rectangle in the grid to each expected value in the matrix,
// and the green and blue components to each actual value, making the image grayscale when the values match, and any differences are shown in red/cyan.
// Fragment Shader

// Input values
varying vec4 v_vColour;

// Uniforms
uniform mat4 u_expected_matrix_view; // The expected value of the matrix


void main()
{
	// Set the fragment colour to the vertex colour
    gl_FragColor = v_vColour;
}