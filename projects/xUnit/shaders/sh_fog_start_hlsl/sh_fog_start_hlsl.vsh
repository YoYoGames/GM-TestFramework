// This shader tests the gm_FogStart built-in uniform by outputting white if it's value is over 9.0 (should be 10 when set) and black otherwise
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
	
	// Set the vertex colour to black
	OUTPUT.vColor    = float4(0.0, 0.0, 0.0, 1.0);
	// If gm_FogStart is over 9.0 (it should be 10 when set), then set the vertex colour to white
	if (gm_FogStart > 9.0)
	{
		OUTPUT.vColor    = float4(1.0, 1.0, 1.0, 1.0);
	}
	
	// Pass the vertex position, colour and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 
	
    return OUTPUT;
}