//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float gm_pPreMultiplyAlpha;
uniform float g_Threshold;

void main()
{
	highp vec2 fragcoord = v_vTexcoord;
	fragcoord.x = floor(fragcoord.x) + 0.5;
	fragcoord.y = floor(fragcoord.y) + 0.5;
	
	vec4 texcol = texture2D( gm_BaseTexture, fragcoord / v_vColour.xy);
	vec4 texcol_right = texture2D( gm_BaseTexture, vec2(fragcoord.x + 1.0, fragcoord.y) / v_vColour.xy );
	vec4 texcol_down = texture2D( gm_BaseTexture, vec2(fragcoord.x, fragcoord.y + 1.0) / v_vColour.xy );

	vec4 diffx = abs(texcol_right - texcol);
	vec4 diffy = abs(texcol_down - texcol);	
	diffx -= g_Threshold;
	diffy -= g_Threshold;
	diffx *= 1.0 / (1.0 - g_Threshold);
	diffy *= 1.0 / (1.0 - g_Threshold);
	
	vec4 outcol = max(diffx, diffy);

	if (gm_pPreMultiplyAlpha > 0.0)
	{
		outcol.a = max(outcol.a, max(outcol.r, max(outcol.g, outcol.b)));
	}
	else
	{
		outcol.a = 1.0;
	}
	
	gl_FragColor = outcol;
}
