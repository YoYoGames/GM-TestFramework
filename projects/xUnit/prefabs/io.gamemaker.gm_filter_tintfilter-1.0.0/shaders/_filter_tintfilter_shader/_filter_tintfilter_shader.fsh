//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 g_TintCol;

void main()
{
	vec4 basecol = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) * g_TintCol;
    gl_FragColor = basecol;	
}
