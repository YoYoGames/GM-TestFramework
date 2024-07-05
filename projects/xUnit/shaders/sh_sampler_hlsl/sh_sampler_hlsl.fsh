
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

Texture2D g_Texture;

SamplerState sample
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};

float4 main(PixelShaderInput INPUT) : SV_TARGET {
    float4 diffuseTexture = g_Texture.Sample(sample, INPUT.vTexcoord);
  
    return INPUT.vColor * diffuseTexture;
}