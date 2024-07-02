//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	for (int i = 0; i < gl_MaxDrawBuffers; i++)
	{
		gl_FragData[i] = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	}
}
