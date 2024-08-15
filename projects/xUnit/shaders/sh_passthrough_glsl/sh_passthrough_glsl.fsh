// This shader tests general shader usage by outputting all input values unchanged
// Fragment Shader

// Input values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;


void main()
{
	// Set the fragment colour to the vertex colour multiplied by its texture at the current texture coordinate
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
