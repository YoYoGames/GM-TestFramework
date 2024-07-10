// This shader tests the gm_AlphaTestEnabled/gm_AlphaRefValue built-in uniforms by tinting the output green if gm_AlphaTestEnabled is true,
// And making any pixels that have an alpha value under gm_AlphaRefValue completely transparent
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	
	// Set the fragment colour to the vertex colour multiplied by its texture at the current texture coordinate
    float4 diffuseTexture = gm_BaseTextureObject.Sample(gm_BaseTexture, INPUT.vTexcoord);
	float4 outputColour = INPUT.vColor * diffuseTexture;
	
	// If gm_AlphaTestEnabled is true, set the fragment's blue and red components to 0.5, tinting it green
	if (gm_AlphaTestEnabled == true)
	{
		outputColour.b = 0.5;
		outputColour.r = 0.5;
	}
	
	// If the fragment's alpha is under gm_AlphaRefValue (divided by 255 to scale it to between 1 and 0), set its alpha to 0
	if (outputColour.a < gm_AlphaRefValue / 255.0)
	{
		outputColour.a = 0.0;
	}
	
    return outputColour;
}