
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

uniform float2 u_resolution;

float4 main(PixelShaderInput INPUT) : SV_TARGET {
	
	float4 vModColor = float4(INPUT.vPosition.x / u_resolution.x, INPUT.vPosition.y / u_resolution.y, 1.0, 1.0);
	
    return vModColor;
}