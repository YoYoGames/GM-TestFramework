//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform int u_expected_alpha_test_enabled;
uniform int u_expected_alpha_ref_value;

void main()
{
	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	if (gm_AlphaTestEnabled == true)
	{
		if (gl_FragColor.a < 0.95)
		{
			gl_FragColor.a = 0.0;
		}
	}
	
	
	if (gm_AlphaTestEnabled == bool(u_expected_alpha_test_enabled))
	{
		gl_FragColor.b = 0.5;
	}
	
	if (gm_AlphaRefValue == float(u_expected_alpha_ref_value))
	{
		gl_FragColor.r = 0.5;
	}
	


	//// Used to create expected image/buffer with alpha testing enabled
	//if (gl_FragColor.a < 0.95)
	//{
	//	gl_FragColor.a = 0.0;
	//}
	//gl_FragColor.b = 0.5;
	//gl_FragColor.r = 0.5;
}
