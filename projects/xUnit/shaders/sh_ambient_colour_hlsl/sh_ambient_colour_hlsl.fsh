// This shader tests the gm_AmbientColour built-in uniform by setting it as the vertex colour
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment colour to the colour outputted by the vertex shader
    return INPUT.vColor;
}