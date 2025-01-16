// This shader tests SV_POSITION by setting each fragment's red and green values to SV_POSITION's x and y values
// Fragment Shader

// Input values
struct PixelShaderInput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Uniforms
float2 u_resolutionPS; // The resolution of the window


float4 main(PixelShaderInput INPUT) : SV_TARGET {
	// Set the fragment's red and green values to gl_FragCoord's x and y values, divided by the window resolution, to get them between 0 and 1
	float4 modColor = float4(INPUT.vPosition.x / u_resolutionPS.x, INPUT.vPosition.y / u_resolutionPS.y, 1.0, 1.0);
    return modColor;
}