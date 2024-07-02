
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 fragColour = vec4(0.0, 0.0, 0.0, 1.0);
	
	if (gm_PS_FogEnabled == true)
	{
		fragColour = vec4(1.0, 1.0, 1.0, 1.0);
	}
	
	gl_FragColor = fragColour;
}
