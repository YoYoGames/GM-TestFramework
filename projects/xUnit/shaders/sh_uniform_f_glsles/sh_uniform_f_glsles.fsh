//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 color;

void main()
{
	vec4 v_modColour = color;
    gl_FragColor = v_modColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
