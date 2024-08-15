// This shader tests gl_FrontFacing by colouring anything that it considers front-facing green, and everything else red
// Fragment Shader


void main()
{
	// If the fragment is considered front-facing, make it green
	if (!gl_FrontFacing)
	{
		gl_FragColor = vec4(1.0, 0.0, 0.0, 1);
	}
	// If not, make it red
	else
	{
		gl_FragColor = vec4(0.0, 1.0, 0.0, 1);
	}
}
