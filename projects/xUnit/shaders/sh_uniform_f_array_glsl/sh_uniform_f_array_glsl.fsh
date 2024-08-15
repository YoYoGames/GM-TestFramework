// This shader tests shader_set_uniform_f_array() by outputting the float array passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Uniforms
uniform float color[4]; // Array of floats passed into the shader


void main()
{
	// Put the values from the uniform array into a vec4
	vec4 modColour = vec4(color[0], color[1], color[2], color[3]);
	// Set the fragment colour to that vec4
    gl_FragColor = modColour;
}
