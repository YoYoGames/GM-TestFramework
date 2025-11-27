/*
	"Outline" by Xor

	Sample the alpha channel 3 units in all directions.
	If the largest alpha within the radius is above a threshold,
	use the "g_OutlineColour".

	The pixel scale can be adjusted with "g_OutlinePixelScale".
*/


//Texel size for offset calculations
uniform vec2 gm_pSurfaceTexelSize;

//Outline colour (and alpha)
uniform vec4 g_OutlineColour;
//Outline radius in pixels
uniform float g_OutlineRadius;
//Pixel scale (useful for pixel art)
uniform float g_OutlinePixelScale;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Max number of samples in each direction
#define MAX_RADIUS 3.0
//Total samples = sqr(RADIUS*2+1)
//In this case, 49 samples (+1 base sample) which seems acceptable

//Alpha threshold for outline
#define THRESHOLD 0.0

void main()
{
	//Base colour for overlaying
	vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Outline total alpha
	float outline = 0.0;

	//Compute the radius squared
	float radius_sqr = g_OutlineRadius * g_OutlineRadius;

	//Look through all the samples
	for(float x = -MAX_RADIUS; x <= MAX_RADIUS; x++)
	for(float y = -MAX_RADIUS; y <= MAX_RADIUS; y++)
	{
		//Skip samples outside radius
		if (x*x + y*y > radius_sqr) continue;

		//Compute sample offset in pixels
		vec2 offset = vec2(x,y) * g_OutlinePixelScale;
		//Compute sample coordinates
		vec2 coord = v_vTexcoord + offset * gm_pSurfaceTexelSize;
		//Sample texture
		vec4 samp = texture2D(gm_BaseTexture, coord);

		//Store the largest alpha sample
		outline = max(outline, samp.a);
	}
	//Set outline colour and alpha
	vec4 colour = g_OutlineColour * float(outline > THRESHOLD);
	//Blend with base colour
	colour = mix(colour, base_colour, base_colour.a>THRESHOLD ? outline: 0.0);

	//Output result
	gl_FragColor = v_vColour * colour;
}
