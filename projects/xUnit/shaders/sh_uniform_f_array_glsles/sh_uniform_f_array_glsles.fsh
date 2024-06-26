//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float color[4];

void main()
{
	vec4 v_modColour = vec4(color[0], color[1], color[2], color[3]);
    gl_FragColor = v_modColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
