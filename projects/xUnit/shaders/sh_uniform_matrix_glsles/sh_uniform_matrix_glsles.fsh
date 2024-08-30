// This shader tests shader_set_uniform_matrix()/shader_set_uniform_matrix_array() by applying the matrix passed into the shader as a transformation to the position
// Fragment Shader

// Input values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform sampler2D sample; // Texture sample to use
uniform mat4 u_Matrix; // Matrix passed into the shader


void main()
{
	// Set the fragment colour to the vertex colour multiplied by the texture sample at the current texture coordinate
    gl_FragColor = v_vColour * texture2D(sample, v_vTexcoord);
}