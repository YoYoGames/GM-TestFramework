// This shader tests in_Normal by colouring each vertex based on its normal value
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the colour outputted by the vertex shader
    gl_FragColor = v_vColour;
}
