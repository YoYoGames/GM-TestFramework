//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 gm_pSurfaceDimensions;

uniform sampler2D g_NoiseTexture;
uniform vec2 g_NoiseTextureDimensions;
uniform float g_Radius;

// Annoyingly the number of samples has to be fixed to be compatible across platforms
// NUM_SAMPLES was originally a float however this can break loop unrolling on certain platforms so keep as an int
#define NUM_SAMPLES	32

vec2 noise2D(vec2 _in)
{
	//vec2 newNoise = fract(_in + texture2D( g_NoiseTexture, _in ).xy);
	//return newNoise;
	return texture2D( g_NoiseTexture, _in ).xy;
}

void main()
{
	vec2 noiseCoords;
	noiseCoords = fract((v_vTexcoord * gm_pSurfaceDimensions) / g_NoiseTextureDimensions);
		
	vec4 accumcol = vec4(0.0,0.0,0.0,0.0);
	
	for(int s = 0; s < NUM_SAMPLES; s++)
	{
		noiseCoords = noise2D(noiseCoords);		
		vec2 sampleCoords = v_vTexcoord + (((noiseCoords - 0.5) * 4.0 * g_Radius) / gm_pSurfaceDimensions);		
		accumcol += texture2D( gm_BaseTexture, sampleCoords );
	}
	
	gl_FragColor = accumcol / float(NUM_SAMPLES);
}