//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_Intensity;

float YUVval(vec4 _rgb)
{
	return dot(vec3(0.299, 0.587, 0.114), _rgb.rgb);
}

void main()
{
	vec4 texcol = texture2D( gm_BaseTexture, v_vTexcoord );
	float greyval = YUVval(texcol);	
	vec3 greyCol = vec3(greyval,greyval,greyval);
	vec3 finalCol = mix(texcol.rgb,greyCol, g_Intensity);
    gl_FragColor = vec4(finalCol, texcol.a);
}
