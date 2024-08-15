// This shader tests shader_set_uniform_i_array() by outputting the int array passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
uniform int color[4]; // Array of ints passed into the shader


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Put the values from the uniform array into a float4
	float4 vModColor = float4(color[0], color[1], color[2], color[3]);
	// Set the fragment colour to that float4
    return vModColor;
}