// This shader tests shader_set_uniform_f() by outputting the floats passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
uniform float4 color; // Floats passed into the shader


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment colour to the uniform floats passed into the shader
	float4 modColor = color;
    return modColor;
}