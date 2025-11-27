/*
	"Disk Blur" by Xor

	Performs a weighted blur in a disk radius.
	This uses a fibonacci disk to space out samples, decreasing sample weight with sample radius.
	It also uses an exponential falloff function for weighting brighter samples over darker samples.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Get surface texel size for sample scale
uniform vec2 gm_pSurfaceTexelSize;

//Radius for blur disk
uniform float g_RecursiveBlurRadius;
//Gamma exponent for boosting brightness
uniform float g_RecursiveBlurGamma;

//Number of samples for blur
//36 seems adequate for balance between quality and performance
#define SAMPLES 36
//Radius multiplier based off of samples.
//Should follow this forumla: 1.0 / sqrt(SAMPLES)
//In this case: 1.0 / 6.0 or 1.66...
#define RADIUS 0.1666667

void main()
{
	//Sample total for averaging (numerator)
	vec4 sample_total = vec4(0.0, 0.0, 0.0, 0.0);
	//Weight total for averaging (denominator)
	float weight_total = (0.0);
	//Golden angle rotation matrix (for well distributed samples)
	mat2 golden_angle = mat2(-0.7373688, -0.6754904, 0.6754904,  -0.7373688);

	//Used for iterated radius
	float radius = 1.0;
	//Starting sample point (scaled to match radius)
	vec2 pnt = vec2(RADIUS,0) * g_RecursiveBlurRadius;
	//Iterate through samples
	for(int i = 0; i<SAMPLES; i++)
	{
		//Increase radius (approximation for sqrt(i+2))
		radius += 1.0 / radius;
		//Rotate sample pnt
		pnt *= golden_angle;

		//Compute new sample coordinates
		vec2 coord = v_vTexcoord + pnt * (radius-1.0) * gm_pSurfaceTexelSize;
		//Sample texture
		vec4 samp = texture2D(gm_BaseTexture, coord);
		//Compute weight from brightness falloff and radius falloff
		float gray = dot(samp, vec4(0.299, 0.587, 0.114, 0.0));
		float weight = exp(gray * g_RecursiveBlurGamma) / radius;
		//Add sample and weight totals
		sample_total += samp * weight;
		weight_total += weight;
	}

	//Compute color from weighted average
	vec4 colour = sample_total / weight_total;
	//Factor in "v_vColour"
    gl_FragColor = v_vColour * colour;
}
