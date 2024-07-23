// This shader tests the gm_FogColour built-in uniform by outputting it as the fragment colour
// Fragment Shader


void main()
{	
	// Set the fragment colour to gm_FogColour
	gl_FragColor = gm_FogColour;
}
