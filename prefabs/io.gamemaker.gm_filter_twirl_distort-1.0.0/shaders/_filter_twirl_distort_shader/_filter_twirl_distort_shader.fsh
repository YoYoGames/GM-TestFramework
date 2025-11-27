//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 gm_pSurfaceDimensions;

uniform float g_DistortAngle;
uniform float g_DistortRadius;
uniform vec2 g_DistortOffset;

void main()
{
	vec2 distortCentre = vec2(0.5, 0.5) + g_DistortOffset;
	vec2 vectocentre = distortCentre - v_vTexcoord;
	
	float disttocentre = length(vectocentre);
	disttocentre /= g_DistortRadius;
	
	float blendratio = 1.0 - (disttocentre * 2.0);
	blendratio = clamp(blendratio, 0.0, 1.0);	
	blendratio = smoothstep(0.0, 1.0, blendratio);
	float powscale = clamp(g_DistortRadius, 1.0, 16.0);	
	blendratio = pow(blendratio, powscale);
		
	float rotangle = g_DistortAngle * blendratio;
	rotangle = (rotangle / 180.0) * 3.14159;
	float sinrot = sin(rotangle);
	float cosrot = cos(rotangle);
	
	vec2 transCoord = v_vTexcoord - distortCentre;
	transCoord = vec2((transCoord.x * cosrot) + (transCoord.y * sinrot),
					 (transCoord.x * -sinrot) + (transCoord.y * cosrot));
	transCoord = transCoord + distortCentre;	
	
	vec4 texcol = texture2D(gm_BaseTexture, transCoord);	
	
	gl_FragColor = texcol;
}