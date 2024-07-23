// This shader tests the gm_PS_FogEnabled built-in uniform by outputting white if it's true and black if it's false
// Fragment Shader


void main()
{
	// Set fragment colour to black
	gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	
	// If gm_PS_FogEnabled is true then set the vertex colour to white
	if (gm_PS_FogEnabled == true)
	{
		gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	}
	
	//// This code is used to create expected image/buffer for comparison, with fog enabled
	//fragColour = vec4(1.0, 1.0, 1.0, 1.0); // Used to create expected image/buffer with fog enabled
}