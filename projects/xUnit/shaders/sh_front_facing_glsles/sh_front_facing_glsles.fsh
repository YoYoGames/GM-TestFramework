//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	if (!gl_FrontFacing)
	{
		gl_FragColor = vec4(1.0, 0.0, 0.0, 1);
	}
	else
	{
		gl_FragColor = vec4(0.0, 1.0, 0.0, 1);
	}
}
