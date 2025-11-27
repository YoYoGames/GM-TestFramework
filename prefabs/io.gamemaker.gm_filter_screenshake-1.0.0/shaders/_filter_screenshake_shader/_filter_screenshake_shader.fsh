//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 gm_pSurfaceDimensions;
uniform float gm_pTime;

uniform sampler2D g_NoiseTexture;
uniform vec2 g_NoiseTextureDimensions;
uniform float g_Magnitude;
uniform float g_ShakeSpeed;

vec2 noise2D(vec2 _in)
{
	return texture2D( g_NoiseTexture, _in ).xy;
}

void main()
{
	vec2 noiseCoords;
	noiseCoords.x = fract((g_ShakeSpeed * 60.0) / g_NoiseTextureDimensions.x);	
	noiseCoords.y = 0.5 / g_NoiseTextureDimensions.y;		// stick to top line just now	
	
	vec2 offset = noise2D(noiseCoords);
	offset = ((offset - 0.5) * 2.0 * g_Magnitude) / gm_pSurfaceDimensions;	
	
	gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord + offset);
}