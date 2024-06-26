//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_expected_alpha_ref_value;
uniform int u_expected_alpha_test_enabled;
uniform vec4 u_expected_fog_colour;
uniform int u_expected_fog_enabled;


void main()
{
    vec4 frag_color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	gl_FragColor = vec4(0.,0.,0.,1.);
	// Red values of the pixels are used as a test index
	if (int(frag_color.r*255.0) == 0)
	{
		// Test gm_AlphaRefValue
		if (gm_AlphaRefValue == u_expected_alpha_ref_value)
		{
			gl_FragColor = vec4(1.0);
		}
	}
	else if (int(frag_color.r*255.0) == 1)
	{
		// Test gm_AlphaTestEnabled
		if (gm_AlphaTestEnabled == bool(u_expected_alpha_test_enabled))
		{
			gl_FragColor = vec4(1.0);
		}
	}
	else if (int(frag_color.r*255.0) == 2)
	{
		// Test gm_FogColour
		if (gm_FogColour == u_expected_fog_colour)
		{
			gl_FragColor = vec4(1.0);
		}
	}
	else if (int(frag_color.r*255.0) == 3)
	{
		// Test gm_PS_FogEnabled
		if (gm_PS_FogEnabled == bool(u_expected_fog_enabled))
		{
			gl_FragColor = vec4(1.0);
		}
	}
}
