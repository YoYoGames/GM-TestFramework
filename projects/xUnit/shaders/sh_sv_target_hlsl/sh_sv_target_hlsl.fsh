//
// Simple passthrough pixel shader (HLSL 11)
//

struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

struct PixelShaderOutput{
	float4 color0 : SV_Target0;
	float4 color1 : SV_Target1;
	float4 color2 : SV_Target2;
	float4 color3 : SV_Target3;
};


PixelShaderOutput main(PixelShaderInput INPUT) : SV_TARGET {
	
	PixelShaderOutput output;
	
	output.color0 = INPUT.vColor;
	output.color1 = INPUT.vColor;
	output.color2 = INPUT.vColor;
	output.color3 = INPUT.vColor;
	
    return output;
}