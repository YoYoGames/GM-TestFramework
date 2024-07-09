// This shader tests gl_FragData by attempting to use it to render to all possible draw targets at once
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment data for all possible draw targets to the vertex colour
	for (int i = 0; i < gl_MaxDrawBuffers; i++)
	{
		gl_FragData[i] = v_vColour;
	}
}
