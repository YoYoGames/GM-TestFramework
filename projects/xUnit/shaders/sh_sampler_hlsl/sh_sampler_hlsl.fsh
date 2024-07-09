// This shader tests shader_get_sampler_index() by outputting the texture passed into the shader through the sampler uniform
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
Texture2D g_Texture;
SamplerState sample  // Texture sample passed into the shader
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment colour to the vertex colour multiplied by the texture sample at the current texture coordinate
    float4 diffuseTexture = g_Texture.Sample(sample, INPUT.vTexcoord);
    return INPUT.vColor * diffuseTexture;
}