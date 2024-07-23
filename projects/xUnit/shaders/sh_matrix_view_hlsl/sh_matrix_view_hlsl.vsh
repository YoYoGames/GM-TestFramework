// This shader is intended to be used with a 4x4 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Matrices[MATRIX_VIEW] by setting the red component of each rectangle in the grid to each expected value in the matrix,
// and the green and blue components to each actual value, making the image grayscale when the values match, and any differences are shown in red/cyan.
// Vertex Shader

// Input values
struct VertexShaderInput {
    float4 vPosition : POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Output values
struct VertexShaderOutput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
uniform float4x4 u_expected_matrix; // The expected value of the matrix
uniform float4x4 u_initial_matrix_world_view_projection; // The world_view_projection matrix before it was modified for the test


VertexShaderOutput main(VertexShaderInput INPUT) {
    VertexShaderOutput OUTPUT;
	
	// Calculate the vertex's position on screen using u_initial_matrix_world_view_projection, since the world_view_projection matrix has been modified
    float4 matrixWVP = mul(u_initial_matrix_world_view_projection, INPUT.vPosition);
	
	// Get the index of the current rectangle via it's red value
	int rect_index = INPUT.vColor.r * 255.0;
	// Get the rectangle's row and column in the grid by finding the remainder (mod) and integer quotient (div) when dividing by the grid width
	int row = rect_index % 4.0;
	int column = rect_index / 4;
	
	// Get the expected value at the current row and column
	float expected_value = u_expected_matrix[column][row];
	// Get the actual value at the current row and column
	float actual_value = gm_Matrices[MATRIX_VIEW][column][row];
	
	// Set the vertex's red value to the expected value, and the green and blue values to the actual value
	// (both scaled to show values of 0-1 as 0.25-0.75, to make values over 1 or under 0 identifyable)
	OUTPUT.vColor = float4((expected_value/2.0) + 0.25, (actual_value/2.0) + 0.25, (actual_value/2.0) + 0.25, 1.0);
	
	// Pass the vertex position and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}