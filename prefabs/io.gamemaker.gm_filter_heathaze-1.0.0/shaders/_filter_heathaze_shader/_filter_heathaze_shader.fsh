//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 gm_pSurfaceDimensions;
uniform vec2 gm_pSurfaceTexelSize;
uniform vec2 gm_pCamOffset;
uniform float gm_pTime;

uniform sampler2D g_DistortTexture;
//uniform vec2 g_DistortTextureDimensions;
uniform vec2 g_DistortTextureTexelSize;
uniform float g_Distort1Speed;
uniform float g_Distort2Speed;
uniform vec2 g_Distort1Scale;
uniform vec2 g_Distort2Scale;
uniform float g_Distort1Amount;
uniform float g_Distort2Amount;
uniform float g_ChromaSpreadAmount;
uniform float g_CamOffsetScale;

void main()
{
	// Using the reciprocal of the scale values is more intuitive for the user
	vec2 rcpDistort1Scale = vec2(1.0 / g_Distort1Scale.x, 1.0 / g_Distort1Scale.y);
	vec2 rcpDistort2Scale = vec2(1.0 / g_Distort2Scale.x, 1.0 / g_Distort2Scale.y);
	
	vec2 noise1coord = ((v_vTexcoord * gm_pSurfaceDimensions) * g_DistortTextureTexelSize) * rcpDistort1Scale;
	vec2 noise2coord = ((v_vTexcoord * gm_pSurfaceDimensions) * g_DistortTextureTexelSize) * rcpDistort2Scale;	
	noise1coord.y += g_Distort1Speed;
	noise2coord.y += g_Distort2Speed;	
	
	noise1coord += (gm_pCamOffset * g_DistortTextureTexelSize) * rcpDistort1Scale * g_CamOffsetScale;	
	noise2coord += (gm_pCamOffset * g_DistortTextureTexelSize) * rcpDistort2Scale * g_CamOffsetScale;
	
	vec4 noise1col = texture2D( g_DistortTexture, noise1coord );
	vec4 noise2col = texture2D( g_DistortTexture, noise2coord );	
	noise1col -= 0.5;
	noise2col -= 0.5;	
	
	vec4 blendednoisecol = (noise1col * g_Distort1Amount) + (noise2col * g_Distort2Amount);	
	
	vec2 sampleoffset = blendednoisecol.xy * gm_pSurfaceTexelSize;
	vec2 sampleoffset_r = sampleoffset * (1.0 + g_ChromaSpreadAmount);
	vec2 sampleoffset_g = sampleoffset * (1.0 + (g_ChromaSpreadAmount * 0.5));
	vec2 sampleoffset_b = sampleoffset * 1.0;
	
	vec4 wobbledcol;
	wobbledcol.r = texture2D( gm_BaseTexture, v_vTexcoord + sampleoffset_r ).r;
	wobbledcol.g = texture2D( gm_BaseTexture, v_vTexcoord + sampleoffset_g ).g;
	wobbledcol.b = texture2D( gm_BaseTexture, v_vTexcoord + sampleoffset_b ).b;	
	wobbledcol.a = texture2D( gm_BaseTexture, v_vTexcoord + sampleoffset_r ).a;	
	    
	gl_FragColor = v_vColour * wobbledcol;
}
