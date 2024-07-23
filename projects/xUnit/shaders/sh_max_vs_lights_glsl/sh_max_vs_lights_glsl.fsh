// This shader will test the MAX_VS_LIGHTS constant by outputting it's value as the RGB components of the vertex colour.
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
    gl_FragColor = v_vColour;
}
