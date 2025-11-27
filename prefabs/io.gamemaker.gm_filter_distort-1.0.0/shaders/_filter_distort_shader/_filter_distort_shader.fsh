//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 gm_pSurfaceDimensions;

uniform sampler2D g_DistortTexture;
uniform vec2 g_DistortTextureDimensions;

uniform vec2 g_DistortOffset;
uniform float g_DistortScale;
uniform float g_DistortAmount;

void main()
{
	vec2 distortCoords;
	distortCoords = (v_vTexcoord * gm_pSurfaceDimensions) / g_DistortTextureDimensions;	
	distortCoords /= g_DistortScale;
	distortCoords += g_DistortOffset;
	
	vec2 distortVal = texture2D(g_DistortTexture, distortCoords).rg;
	distortVal -= 0.50196;			// this is 128/255 (treating 128 as the centre value)	
	distortVal *=- 2.0;
	distortVal *= g_DistortAmount;
	
	distortVal /= gm_pSurfaceDimensions;
	
	vec4 texcol = texture2D(gm_BaseTexture, v_vTexcoord + distortVal);	
	
	gl_FragColor = texcol;
}