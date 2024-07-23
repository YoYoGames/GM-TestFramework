// This shader is intended to be used with a 4x2 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_Colour by attempting to set each rectangle to the colour of each light.
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
    gl_FragColor = v_vColour;
}