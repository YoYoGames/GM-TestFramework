//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	float colour = (float(gl_MaxDrawBuffers) / 255.0);
	
    gl_FragColor = vec4(colour, colour, colour, 1.0);
}
