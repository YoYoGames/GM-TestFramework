//
// Simple passthrough pixel shader (HLSL 11)
//

struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

uniform float color[4];

float4 main(PixelShaderInput INPUT) : SV_TARGET {
    float4 diffuseTexture = gm_BaseTextureObject.Sample(gm_BaseTexture, INPUT.vTexcoord);
	
	float4 vModColor = float4(color[0], color[1], color[2], color[3]);
	
    return vModColor;
}