// This shader tests the gm_AlphaTestEnabled/gm_AlphaRefValue built-in uniforms by tinting the output green if gm_AlphaTestEnabled is true,
// And making any pixels that have an alpha value under gm_AlphaRefValue completely transparent
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
	
	// Pass the vertex position, colour and texture coordinate to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vColor    = INPUT.vColor;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}