// This shader is intended to be used with a 4x2 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_Direction by attempting to set each rectangle's RGBA colour values to each light direction's xyzw value.
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