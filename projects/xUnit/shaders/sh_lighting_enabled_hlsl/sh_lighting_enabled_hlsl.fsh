// This shader tests the gm_LightingEnabled built-in uniform by outputting white if it's true and black if it's false
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