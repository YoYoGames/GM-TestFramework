// This shader tests the gm_FogColour built-in uniform by outputting it as the fragment colour
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment colour to gm_FogColour
    return gm_FogColour;
}