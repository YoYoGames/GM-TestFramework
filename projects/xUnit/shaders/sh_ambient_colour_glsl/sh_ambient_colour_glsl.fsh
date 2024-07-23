// This shader tests the gm_AmbientColour built-in uniform by setting it as the vertex colour
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
    gl_FragColor = v_vColour;
}