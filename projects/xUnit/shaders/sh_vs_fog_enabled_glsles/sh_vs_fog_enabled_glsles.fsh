// This shader tests the gm_VS_FogEnabled built-in uniform by outputting white if it's true and black if it's false
// Fragment Shader

// Input values
varying vec4 v_vColour;

void main()
{
	// Set the fragment colour to the vertex colour
	gl_FragColor = v_vColour;
}
