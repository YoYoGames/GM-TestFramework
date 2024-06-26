
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Expected test values from gpu_get_fog()
uniform float u_expected_fog_start;
uniform float u_expected_rcp_fog_range;
uniform int u_expected_fog_enabled;
uniform vec3 u_expected_fog_colour;

// To be used with a test mesh that gives every vertex a different red value, to act as a vertex index, allowing tests to be run per vertex.
bool vertex_test(int test_number, bool test_condition)
{
	// Check that the current vertex has a red value equal to the test_number
	if (int(in_Colour.r * 255.0) == test_number) {
		// Run the test
		if (test_condition == true)
		{
			// colour the vertex white if it is a success
			v_vColour = vec4(1.0);
		}
		// Return true if the test has been run
		return true;
	}
	// Return false if not
	return false;
}

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	v_vColour = vec4(0.0, 0.0, 0.0, 1.0);
	
	if (vertex_test(0, gm_FogStart == u_expected_fog_start)) 
	{
	}
	else if (vertex_test(1, gm_RcpFogRange == u_expected_rcp_fog_range))
	{
	}
	else if (vertex_test(2, gm_VS_FogEnabled == bool(u_expected_fog_enabled)))
	{
	}
}