// This shader tests gl_MaxDrawBuffers by outputting its value in the red, green and blue components of the fragment colour
// Fragment Shader


void main()
{
	// Get the value of gl_MaxDrawBuffers as a value between 0 and 1
	float colour = (float(gl_MaxDrawBuffers) / 255.0);
	
	// Set that value as the red, green and blue components of the fragment colour
    gl_FragColor = vec4(colour, colour, colour, 1.0);
}
