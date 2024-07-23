// This shader is intended to be used with a 4x4 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] by setting the red component of each rectangle in the grid to each expected value in the matrix,
// and the green and blue components to each actual value, making the image grayscale when the values match, and any differences are shown in red/cyan.
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment colour to the vertex colour
    return INPUT.vColor;
}