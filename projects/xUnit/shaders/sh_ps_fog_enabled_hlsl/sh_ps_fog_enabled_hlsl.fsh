// This shader tests the gm_PS_FogEnabled built-in uniform by outputting white if it's true and black if it's false
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	
	// Set fragment colour to black
	float4 colour = float4(0.0, 0.0, 0.0, 1.0);
	
	// If gm_PS_FogEnabled is true then set the vertex colour to white
	if (gm_PS_FogEnabled == true)
	{
		colour = float4(1.0, 1.0, 1.0, 1.0);
	}
	
    return colour;
}