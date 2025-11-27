/*
	"Twist Blur" by Xor
	
	Samples in a arc around a center point
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Get surface texel size for sample direction
uniform vec2 gm_pSurfaceTexelSize;
//Get surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;

//Twist blur center point (between 0.0 and 1.0)
uniform vec2  g_TwistBlurCenter;
//Blur intensity (0.0 = no blur, 1.0 = max blur)
uniform float g_TwistBlurIntensity;

//Blur noise texture for randomized sample offsets
uniform sampler2D g_TwistBlurTexture;
//Blur noise texel size
uniform vec2 g_TwistBlurTextureTexelSize;

//Amount of falloff at the edge samples
#define FALLOFF 0.8
//Number of texture samples
#define SAMPLES 64
//Step size (the reciprocal of SAMPLES).
//Example: 1 / 64 = 0.015625
#define STEP_SIZE 0.015625

//Tau (pi*2) and pi for trig math
#define TAU 6.283185
#define PI  3.141593

void main()
{
	//Samples total for averaging
	vec4 samples_total = vec4(0.0, 0.0, 0.0, 0.0);
	//Total weight for divisor
	float weights_total = 0.0;
	
	//Compute pixel coordinates from texture coordinates
	vec2 pixel_coord = v_vTexcoord * gm_pSurfaceDimensions;
	//Convert the center position to pixel units
	vec2 pixel_center = g_TwistBlurCenter * gm_pSurfaceDimensions;
	
	//Compute noise texture coordinates from view-space pixels
	vec2 noise_texcoord = pixel_coord * g_TwistBlurTextureTexelSize;
	//Sample noise for offsets
	float noise_sample = texture2D(g_TwistBlurTexture, noise_texcoord).r;
	
	//Fade position (starts at -1.0 and ends at +1.0)
	float fade = noise_sample * STEP_SIZE - 1.0;
	
	//Compute the rotation angle for each iteration ("step").
	float rotate_step_size = g_TwistBlurIntensity * TAU * STEP_SIZE;
	
	//Starting position (with noise factored)
	float start_angle = noise_sample * rotate_step_size - g_TwistBlurIntensity * PI;
	
	//Find the difference between the current pixel and twist blur center
	vec2 dif = pixel_coord - pixel_center;
	//Rotation direction for starting angle
	vec2 dir = vec2(cos(start_angle),sin(start_angle));
	//Rotate to match the starting angle
	dif *= mat2(dir.xy, -dir.y, dir.x);
	//Compute rotation step direction
	dir = vec2(cos(rotate_step_size), sin(rotate_step_size));
	//Pre-compute rotation
	mat2 rotate = mat2(dir,-dir.y,dir.x);
	
	//Sample in arc
	for(int i = 0; i < SAMPLES; i++)
	{
		//Rotate difference vector
		dif *= rotate;
		//Compute sample texture coordinates
		vec2 sample_texcoord = (dif + pixel_center) * gm_pSurfaceTexelSize;
		//Get texture sample
		vec4 sample = texture2D(gm_BaseTexture, sample_texcoord);
		//Square for cheap gamma correction
		sample *= sample;
		//Compute weight with parabola falloff
		float weight = 1.0 - fade * fade * FALLOFF;
		
		//Add to totals
		samples_total += sample * weight;
		weights_total += weight;

		//Add to fade position
		fade += 2.0*STEP_SIZE;
	}
	//Compute weighted average (with gamma correction)
	vec4 blur_colour = sqrt(samples_total / weights_total);
	//Output with vertex colour
	gl_FragColor = v_vColour * blur_colour;
}