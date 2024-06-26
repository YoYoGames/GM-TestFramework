
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Expected test values from gpu_get_fog()
uniform float u_expected_fog_start;
uniform float u_expected_rcp_fog_range;
uniform int u_expected_fog_enabled;
uniform vec3 u_expected_fog_colour;

// To be used with a test sprite that gives every vertex a different red value, to act as a vertex index, allowing tests to be run per vertex.
bool vertex_test(vec4 frag_colour, int test_number, bool test_condition)
{
	// Check that the current vertex has a red value equal to the test_number
	if (int(frag_colour.r*255.0) == test_number) {
		// Run the test
		if (test_condition == true)
		{
			// colour the vertex white if it is a success
			gl_FragColor = vec4(1.0);
		}
		// Return true if the test has been run
		return true;
	}
	// Return false if not
	return false;
}

void main()
{
    vec4 frag_colour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	gl_FragColor = vec4(0.0,0.0,0.0,1.0);
	
	if (vertex_test(frag_colour, 0, gm_PS_FogEnabled == bool(u_expected_fog_enabled))) 
	{
	}
}
