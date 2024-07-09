// This shader tests shader_set_uniform_i() by outputting the ints passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
uniform int4 color; // Ints passed into the shader


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Put the ints from the uniform into a floatc4
	float4 vModColor = float4(color.x, color.y, color.z, color.w);
	// Set the fragment colour to that float4
    return vModColor;
}