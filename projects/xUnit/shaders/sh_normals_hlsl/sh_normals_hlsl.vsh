// This shader tests NORMAL by colouring each vertex based on its normal value
// Vertex Shader

// Input values
struct VertexShaderInput {
    float4 vPosition : POSITION;
	float3 vNormal	 : NORMAL;
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
	
	// Scale the normal's values to be between 0 and 1
	float3 scaled_normal = (INPUT.vNormal / 2.0) + 0.5;
	
	// Set the red, green and blue values of each vertex to the scaled x, y and z values of the normal
	OUTPUT.vColor    = float4(scaled_normal.x, scaled_normal.y, scaled_normal.z, 1.0);
	
	// Pass the vertex position and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}