// It will test the MATRICES_MAX constant by outputting it's value as the RGB components of the vertex colour.
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