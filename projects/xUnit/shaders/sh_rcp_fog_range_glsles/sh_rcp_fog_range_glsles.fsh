// This shader tests the gm_RcpFogRange built-in uniform by outputting white if it's over 99 (should be 100 when set), and black if not
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
	gl_FragColor = v_vColour;
}