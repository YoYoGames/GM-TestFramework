// This shader tests shader_set_uniform_matrix()/shader_set_uniform_matrix_array() by applying the matrix passed into the shader as a transformation to the position
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
Texture2D g_Texture;
SamplerState sample // Texture sample to use
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