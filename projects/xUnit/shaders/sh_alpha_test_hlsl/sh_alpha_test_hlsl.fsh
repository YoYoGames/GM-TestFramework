//
// Simple passthrough pixel shader (HLSL 11)
//

struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

int u_expected_alpha_test_enabled;
int u_expected_alpha_ref_value;


float4 main(PixelShaderInput INPUT) : SV_TARGET {
    float4 diffuseTexture = gm_BaseTextureObject.Sample(gm_BaseTexture, INPUT.vTexcoord);
	
	float4 outputColour = INPUT.vColor * diffuseTexture;
	
	if (gm_AlphaTestEnabled == true)
	{
		if (outputColour.a < 0.95)
		{
			outputColour.a = 0.0;
		}
	}
	
	bool alphaTestEnabled = gm_AlphaTestEnabled;
	if (alphaTestEnabled == u_expected_alpha_test_enabled)
	{
		outputColour.b = 0.5;
	}
	
	int alphaRefValue = gm_AlphaRefValue;
	if (alphaRefValue == u_expected_alpha_ref_value)
	{
		outputColour.r = 0.5;
	}
	
    return outputColour;
}