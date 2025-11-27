//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_interpolationValue;
uniform sampler2D g_textureA;
uniform sampler2D g_textureB;

void main()
{
	vec4 colourA = texture2D( g_textureA, v_vTexcoord);
	vec4 colourB = texture2D( g_textureB, v_vTexcoord);
	vec4 colour = mix(colourA, colourB, g_interpolationValue);
    gl_FragColor = colour;
}
