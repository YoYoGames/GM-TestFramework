// This shader tests shader_set_uniform_f() by outputting the floats passed into the shader as the RGBA values of the fragment colour
// Fragment Shader

// Input values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform vec4 color; // Floats passed into the shader


void main()
{
	// Set the fragment colour to the uniform floats passed into the shader
    gl_FragColor = color;
}
