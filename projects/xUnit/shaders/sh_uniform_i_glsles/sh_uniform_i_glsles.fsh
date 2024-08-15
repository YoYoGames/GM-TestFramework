// This shader tests shader_set_uniform_i() by outputting the ints passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Uniforms
uniform ivec4 color; // Ints passed into the shader


void main()
{
	// Put the ints from the uniform into a vec4
	vec4 modColour = vec4(color.x, color.y, color.z, color.w);
	// Set the fragment colour to that vec4
    gl_FragColor = modColour;
}
