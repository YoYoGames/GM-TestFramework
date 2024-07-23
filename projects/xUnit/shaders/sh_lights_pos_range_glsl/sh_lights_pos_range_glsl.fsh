// This shader is intended to be used with a 4x2 grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_PosRange by attempting to set each rectangle's RGBA colour values to each light's xyz position and w range value.
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour
    gl_FragColor = v_vColour;
}