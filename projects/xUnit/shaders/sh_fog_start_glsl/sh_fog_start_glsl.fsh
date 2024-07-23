// This shader tests the gm_FogStart built-in uniform by outputting white if it's value is over 9.0 (should be 10 when set) and black otherwise
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
	gl_FragColor = v_vColour;
}