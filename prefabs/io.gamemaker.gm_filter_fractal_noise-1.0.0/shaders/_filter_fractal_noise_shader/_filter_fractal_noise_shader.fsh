/*
	"Fractal Noise" by Xor
	
	Blends fractal noise with the base texture.
	Any texture can be used for the noise, but the alpha channel is used for blending.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;
// Flag indicating whether we're using premultiplied alpha (single-layer mode)
uniform float gm_pPreMultiplyAlpha;

//Fractal scale in pixels
uniform float g_FractalNoiseScale;
//Octave persistence (0.0 = smooth, up to 1.0 = rough detail)
uniform float g_FractalNoisePersistence;
//Noise offset in pixels
uniform vec2 g_FractalNoiseOffset;
//Movement speed for animation
uniform float g_FractalNoiseSpeed;
//Optional tint colour (and alpha)
uniform vec4 g_FractalNoiseTintColour;

//Noise texture for fractal
uniform sampler2D g_FractalNoiseTexture;
//Noise texel size
uniform vec2 g_FractalNoiseTextureTexelSize;

//Number of octave passes
#define STEPS 8
//Speed scaler for each octave
#define SPEED_SCALE 0.7

//Sample noise texture with bi-cubic interpolation
vec4 noise_sample(vec2 p)
{
	vec2 f = floor(p);
	vec2 s = p-f;
	s *= s*(3.0-s*2.0);
	
	return texture2D(g_FractalNoiseTexture, (f+s+0.5) * g_FractalNoiseTextureTexelSize);
}
//Add up noise octaves
vec4 noise_fractal(vec2 p)
{
	//Totals for averaging
	vec4  sample_total = vec4(0.0, 0.0, 0.0, 0.0); 
	float weight_total = 0.0;
	
	//Starting octave weight
	float weight = 1.0;
	//Starting speed
	float speed = g_FractalNoiseSpeed;
	//Transformation (golden angle rotation + 2x scaling)
	//mat2 trans = mat2(-0.7373688, -0.6754904, 0.6754904,  -0.7373688) * 2.0;
	vec2 trans0 = vec2(-0.7373688, 0.6754904) * 2.0;
	vec2 trans1 = vec2(-0.6754904, -0.7373688) * 2.0;
	
	//Iterate through octaves
	for(int i = 0; i<STEPS; i++)
	{
		//Sample noise and add to totals
		vec4 sample = noise_sample(p+speed*gm_pTime);
		sample_total += sample * weight;
		weight_total += weight;
		
		//Transform position
		//p *= trans;
		p = vec2(dot(p, trans0), dot(p, trans1));
		//Update weight and speed
		weight *= g_FractalNoisePersistence;
		speed *= SPEED_SCALE;
	}
	//Compute weighted average
	return sample_total / weight_total;
}

void main()
{
	//Sample base texture
	vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	
	//Compute pixel coordinates
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions - g_FractalNoiseOffset;
	
	//Generate fractal noise
	vec4 noise = noise_fractal(pixel / g_FractalNoiseScale);
	//Factor noise colour and alpha
	noise *= g_FractalNoiseTintColour;
	
	//Initialize output colour
	vec4 colour = base_colour;

	float colmul = 1.0;
	if (gm_pPreMultiplyAlpha > 0.0)
	{
		colmul = colour.a;
	}
	
	//Linearly mix with noise using intensity
	colour.rgb = colour.rgb + ((noise - colour).rgb * noise.a * colmul);
	
	//Output result with vertex colour
	gl_FragColor = v_vColour * colour;
}