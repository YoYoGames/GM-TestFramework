// This shader is intended to be used with 4x2 a grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_Colour by attempting to set each rectangle to the colour of each light.
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
	
	// Get the index of the current rectangle via it's red value
	int rect_index = int(INPUT.vColor.r * 255.0);
	
	// Set vertex colour to the colour of the light corresponding to the rectangle index
	OUTPUT.vColor = gm_Lights_Colour[rect_index];
	
	// Pass the vertex position, colour and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}