// This shader tests the gm_AmbientColour built-in uniform by setting it as the vertex colour
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
	// Set the vertex colour to the value from gm_AmbientColour 
	//OUTPUT.vColor = gm_AmbientColour;
	
	// Pass the vertex position and texture coordinate to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}