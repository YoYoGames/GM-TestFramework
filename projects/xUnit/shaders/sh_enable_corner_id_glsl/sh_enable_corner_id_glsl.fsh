// This shader tests the enable_corner_id() function by attempting to get each corner ID and colour them differently
// Fragment Shader

// Input values
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the colour outputted by the vertex shader
    gl_FragColor = v_vColour;
}
