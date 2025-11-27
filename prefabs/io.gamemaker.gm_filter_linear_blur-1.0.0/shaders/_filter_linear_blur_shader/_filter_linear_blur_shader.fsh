/*
	"Linear Blur" by Xor

	Samples the texture evenly in a straight line.
	The noise texture is used to offset the samples.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Get surface texel size for sample direction
uniform vec2 gm_pSurfaceTexelSize;
//Get surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;

//Blur vector in pixels
uniform vec2 g_LinearBlurVector;

//Blur noise texture for sample offsets
uniform sampler2D g_NoiseTexture;
//Blur noise texel size
uniform vec2 g_NoiseTextureTexelSize;

//Amount of fading at the edges
#define FADE 0.5
//Number of texture samples
#define SAMPLES 64
//Step size (half the reciprocal of SAMPLES).
//Example: 0.5 / 64 = 0.03125
#define STEP_SIZE 0.03125

void main()
{
	//Samples total for averaging
	vec4 samples_total = vec4(0.0, 0.0, 0.0, 0.0);
	//Total weight for divisor
	float weights_total = 0.0;


	//Compute pixel coordinates from texture coordinates
	vec2 pixel_coord = v_vTexcoord * gm_pSurfaceDimensions;
	//Compute noise texture coordinates from view-space pixels
	vec2 noise_texcoord = pixel_coord * g_NoiseTextureTexelSize;
	//Sample noise for offsets
	float noise = texture2D(g_NoiseTexture, noise_texcoord).r;
	//Sample position starting at -1.0 plus random offset
	float pos = -1.0 + STEP_SIZE * noise;
	//Compute texture-space vector
	vec2 vect = g_LinearBlurVector * gm_pSurfaceTexelSize;

	//Sample in line
	for(int i = 0; i < SAMPLES; i++)
	{
		//Compute sampple texture coordinates
		vec2 sample_texcoord = v_vTexcoord + vect * pos;
		//Get texture sample
		vec4 sample = texture2D(gm_BaseTexture, sample_texcoord);
		//Compute weight with parabola falloff
		float weight = 1.0 - pos * pos * FADE;

		//Add to totals
		samples_total += sample * weight;
		weights_total += weight;
		//Step along the line
		pos += STEP_SIZE;
	}
	//Compute weighted average
	vec4 blur_colour = samples_total / weights_total;
	//Output with vertex colour
	gl_FragColor = v_vColour * blur_colour;
}
