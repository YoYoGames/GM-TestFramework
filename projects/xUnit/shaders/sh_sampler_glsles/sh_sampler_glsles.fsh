// This shader tests shader_get_sampler_index() by outputting the texture passed into the shader through the sampler uniform
// Fragment Shader

// Input values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform sampler2D sample; // Texture sample passed into the shader


void main()
{
	// Set the fragment colour to the vertex colour multiplied by the texture sample at the current texture coordinate
    gl_FragColor = v_vColour * texture2D( sample, v_vTexcoord );
}
