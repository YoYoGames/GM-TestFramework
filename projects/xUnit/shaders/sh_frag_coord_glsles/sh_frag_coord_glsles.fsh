//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_resolution;

void main()
{
	
	gl_FragColor = vec4(gl_FragCoord.x / u_resolution.x, gl_FragCoord.y / u_resolution.y, 1.0, 1.0);
}
