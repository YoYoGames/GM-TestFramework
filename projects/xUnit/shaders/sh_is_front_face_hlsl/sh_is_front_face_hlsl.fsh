//
// Simple passthrough pixel shader (HLSL 11)
//

struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
	float4 vNormal	 : NORMAL;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT, bool vFrontFace : SV_IsFrontFace) : SV_TARGET {
	float4 outputColour;
	
	if (vFrontFace <= 0.0)
	{
		outputColour = float4(1.0, 0.0, 0.0, 1);
	}
	else
	{
		outputColour = float4(0.0, 1.0, 0.0, 1);
	}
	
	return outputColour;
}