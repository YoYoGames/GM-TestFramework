// This shader tests the gm_AlphaTestEnabled/gm_AlphaRefValue built-in uniforms by tinting the output green if gm_AlphaTestEnabled is true,
// And making any pixels that have an alpha value under gm_AlphaRefValue completely transparent
// Fragment Shader

// Input values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	// Set the fragment colour to the vertex colour multiplied by its texture at the current texture coordinate
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	// If gm_AlphaTestEnabled is true, set the fragment's blue and red components to 0.5, tinting it green
	if (gm_AlphaTestEnabled == true)
	{
		gl_FragColor.b = 0.5;
		gl_FragColor.r = 0.5;
	}
	
	// If the fragment's alpha is under gm_AlphaRefValue (divided by 255 to scale it to between 1 and 0), set its alpha to 0
	if (gl_FragColor.a < gm_AlphaRefValue / 255.0)
	{
		gl_FragColor.a = 0.0;
	}
	
	//// This code was used to create expected image/buffer for comparison, when alpha testing is enabled
	//gl_FragColor.b = 0.5;
	//gl_FragColor.r = 0.5;
	//if (gl_FragColor.a < 254.0 / 255.0)
	//{
	//	gl_FragColor.a = 0.0;
	//}
}