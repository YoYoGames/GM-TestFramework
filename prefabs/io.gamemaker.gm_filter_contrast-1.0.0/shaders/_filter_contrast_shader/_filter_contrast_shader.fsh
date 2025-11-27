/*
	"Contrast & Brightness" by Xor
	
	Adjust contrast and brightness with two simple parameters.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Flag indicating whether we're using premultiplied alpha (single-layer mode)
uniform float gm_pPreMultiplyAlpha;

//Contrast intensity (1.0 = default, higher = more contrast)
uniform float g_ContrastIntensity;
//Brightness amount (1.0 = default, higher = brighter)
uniform float g_ContrastBrightness;

void main()
{
	//Start with base colour
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);

	float colmul = 1.0;
	if (gm_pPreMultiplyAlpha > 0.0)
	{
		colmul = colour.a;
	}

	colour.rgb /= colmul;
	
	//Compute final colour with extrapolation
	colour.rgb = 0.5 + (colour.rgb + g_ContrastBrightness - 1.5) * g_ContrastIntensity;

	colour.rgb *= colmul;

	//Output with vertex colour
	gl_FragColor = v_vColour * colour;
}