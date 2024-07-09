// This shader tests shader_set_uniform_matrix()/shader_set_uniform_matrix_array() by applying the matrix passed into the shader as a transformation to the position
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
float4x4 u_Matrix; // Matrix passed into the shader


VertexShaderOutput main(VertexShaderInput INPUT) {
    VertexShaderOutput OUTPUT;
	
	// Calculate the vertex's position on screen using the world_view_projection matrix, multiplied by the matrix passed into the shader
    float4 matrixWVP = mul(u_Matrix, mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], INPUT.vPosition));
	
	// Pass the vertex position, colour and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vColor    = INPUT.vColor;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}