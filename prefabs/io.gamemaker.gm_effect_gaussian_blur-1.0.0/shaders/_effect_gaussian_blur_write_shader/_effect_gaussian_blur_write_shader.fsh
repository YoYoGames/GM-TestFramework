//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_interpolationValue;
uniform sampler2D g_textureA;

void main()
{
	vec4 colourA = texture2D( g_textureA, v_vTexcoord);
	colourA.a = g_interpolationValue;
    gl_FragColor = colourA;
}
