// This shader tests gl_FragCoord by setting each fragment's red and green values to gl_FragCoord's x and y values
// Fragment Shader

// Uniforms
uniform vec2 u_resolution; // The resolution of the window


void main()
{
	// Set the fragment's red and green values to gl_FragCoord's x and y values, divided by the window resolution, to get them between 0 and 1
	gl_FragColor = vec4(gl_FragCoord.x / u_resolution.x, gl_FragCoord.y / u_resolution.y, 1.0, 1.0);
}
