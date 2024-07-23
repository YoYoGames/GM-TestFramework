// This shader will test the MATRICES_MAX constant by outputting it's value as the RGB components of the vertex colour.
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


VertexShaderOutput main(VertexShaderInput INPUT) {
    VertexShaderOutput OUTPUT;
	
	// Calculate the vertex's position on screen using the world_view_projection matrix
    float4 matrixWVP = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], INPUT.vPosition);
	
	// THIS UNIFORM WILL CURRENTLY CAUSE ERRORS IN HLSL, AND IS TEMPORARILY COMMENTED TO AVOID MESSING UP OTHER TESTS - UNCOMMENT WHEN FIXES ARE IMPLEMENTED
	// Get MATRICES_MAX
	//float matrix_max = float(MATRICES_MAX);
	//// Set the RGB components of the vertex colour to its value (scaled to be between 0 and 1)
    //INPUT.vColour = float4(matrix_max / 255.0, matrix_max / 255.0, matrix_max / 255.0, 1.0);
	
	// Pass the vertex position and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}