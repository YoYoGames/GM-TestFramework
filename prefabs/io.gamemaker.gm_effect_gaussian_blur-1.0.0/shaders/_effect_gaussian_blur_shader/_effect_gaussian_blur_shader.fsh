
uniform vec2 g_sampledTexelSize;
uniform vec2 g_blurDirection;

varying vec2 v_vTexcoord;

void main()
{
	float weights[3];
	weights[0] = 0.2270270270;
	weights[1] = 0.3162162162;
	weights[2] = 0.0702702703;
	
	float offsets[3];
	offsets[0] = 0.0;
	offsets[1] = 1.3846153846;
	offsets[2] = 3.2307692308;
	
	
	vec4 accumcol = texture2D(gm_BaseTexture, v_vTexcoord) * weights[0];
	for(int i = 1; i < 3; i++)
	{
		vec2 offset = (g_blurDirection * offsets[i]) * g_sampledTexelSize;
		accumcol += texture2D(gm_BaseTexture, v_vTexcoord + offset) * weights[i];
		accumcol += texture2D(gm_BaseTexture, v_vTexcoord - offset) * weights[i];
	}
	
	gl_FragColor = accumcol;
}
