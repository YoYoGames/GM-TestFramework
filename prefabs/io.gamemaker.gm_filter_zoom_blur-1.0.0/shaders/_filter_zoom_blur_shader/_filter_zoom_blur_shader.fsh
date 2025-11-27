/*
	"Zoom Blur" by Xor
	
	Samples starting towards the zoom center point.
	The blur intensity and focus radius are adjustable
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Get surface texel size for sample direction
uniform vec2 gm_pSurfaceTexelSize;
//Get surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;

//Zoom blur center point (between 0.0 and 1.0)
uniform vec2  g_ZoomBlurCenter;
//Blur intensity (0.0 = no blur, 1.0 = max blur)
uniform float g_ZoomBlurIntensity;
//Radius of the focus area (0.0 = no focus)
uniform float g_ZoomBlurFocusRadius;

//Blur noise texture for randomized sample offsets
uniform sampler2D g_ZoomBlurTexture;
//Blur noise texel size
uniform vec2 g_ZoomBlurTextureTexelSize;

//Amount of fading at the edges
#define FADE 0.5
//Number of texture samples
#define SAMPLES 64
//Step size (the reciprocal of SAMPLES).
//Example: 1 / 64 = 0.015625
#define STEP_SIZE 0.015625

void main()
{
	//Samples total for averaging
	vec4 samples_total = vec4(0.0, 0.0, 0.0, 0.0);
	//Total weight for divisor
	float weights_total = 0.0;
	
	//Compute pixel coordinates from texture coordinates
	vec2 pixel_coord = v_vTexcoord * gm_pSurfaceDimensions;
	//Zoom center in pixels
	vec2 pixel_center = g_ZoomBlurCenter * gm_pSurfaceDimensions;
	
	//Compute noise texture coordinates from view-space pixels
	vec2 noise_texcoord = pixel_coord * g_ZoomBlurTextureTexelSize;
	//Sample noise for offsets
	float noise = texture2D(g_ZoomBlurTexture, noise_texcoord).r;
	
	//Step size with blur intensity factor
	float step_size = g_ZoomBlurIntensity * STEP_SIZE;
	//Distance to focus point (in pixels)
	float focus_dist = length(pixel_coord - pixel_center);
	//Step size with focus gradient
	step_size *= smoothstep(0.0, g_ZoomBlurFocusRadius, focus_dist);
	
	//Starting position (with noise)
	float pos = noise * step_size;
	//Fade position (starts at 0.0 and ends at 1.0)
	float fade = noise * STEP_SIZE;
	
	//Sample in line
	for(int i = 0; i < SAMPLES; i++)
	{
		//Compute sampple texture coordinates
		vec2 sample_texcoord = mix(v_vTexcoord, g_ZoomBlurCenter, pos);
		//Get texture sample
		vec4 sample = texture2D(gm_BaseTexture, sample_texcoord);
		sample *= sample;
		//Compute weight with parabola falloff
		float weight = 1.0 - fade * fade * FADE;
		
		//Add to totals
		samples_total += sample * weight;
		weights_total += weight;
		
		//Step forward
		pos += step_size;
		//Add to fade position
		fade += STEP_SIZE;
	}
	//Compute weighted average
	vec4 blur_colour = sqrt(samples_total / weights_total);
	//Output with vertex colour
	gl_FragColor = v_vColour * blur_colour;
}