//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float gm_pPreMultiplyAlpha;
uniform vec2 gm_pSurfaceDimensions;
uniform float g_DisplacementX;
uniform float g_DisplacementY;
uniform float g_Opacity;
uniform vec4 g_Colour;

void main()
{
	vec4 texcol = texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec2 offset = vec2(-g_DisplacementX / gm_pSurfaceDimensions.x, -g_DisplacementY / gm_pSurfaceDimensions.y);
	vec2 v_vTexcoordShadow = v_vTexcoord + offset;
	
	float shadowalpha = texture2D( gm_BaseTexture, v_vTexcoordShadow ).a;	
	vec4 shadowcol = vec4(g_Colour.r, g_Colour.g, g_Colour.b, shadowalpha * g_Opacity);	

	if (gm_pPreMultiplyAlpha != 0.0)
	{
		texcol.a = clamp(texcol.a, 0.001, 1.0);	// need to do this to prevent NaNs
		texcol.rgb /= texcol.a;				
	}
	
	// Combine texture and shadow	
	vec4 finalcol;	
	finalcol.rgb = ((shadowcol.rgb * shadowcol.a) * (1.0 - texcol.a)) + texcol.rgb;		
	finalcol.a = shadowcol.a + ((1.0 - shadowcol.a) * texcol.a);
	
    gl_FragColor = v_vColour * finalcol;
}
