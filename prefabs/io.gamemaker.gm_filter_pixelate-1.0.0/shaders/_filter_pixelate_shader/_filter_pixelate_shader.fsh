//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec2 gm_pSurfaceDimensions;
uniform float g_CellSize;

// It'd be nice to make this tweakable but some of the shader versions don't support loops with
// variable iterations
#define SUBSAMPLES_DIM 2.0

void main()
{
	vec2 pixelCoords = v_vTexcoord * gm_pSurfaceDimensions;
	vec2 snappedCoords = floor(pixelCoords / g_CellSize) * g_CellSize;	
	vec2 scaledCoords = snappedCoords / gm_pSurfaceDimensions;
	
	vec4 outcolour;
	
	if (SUBSAMPLES_DIM > 1.0)
	{
		vec2 coordinc;
		coordinc.x = g_CellSize / SUBSAMPLES_DIM;
		coordinc.y = coordinc.x;		
		coordinc /= gm_pSurfaceDimensions;		
		vec2 offset;
		offset.x = coordinc.x / 2.0;	
		offset.y = coordinc.y / 2.0;
		offset += scaledCoords;	
	
		float offsetbasex = offset.x;
	
		vec4 accumcol = vec4(0.0, 0.0, 0.0, 0.0);
		for(float y = 0.0; y < SUBSAMPLES_DIM; y++)
		{
			for(float x = 0.0; x < SUBSAMPLES_DIM; x++)
			{
				accumcol += texture2D( gm_BaseTexture, offset);
		
				offset.x += coordinc.x;
			}
		
			offset.x = offsetbasex;
			offset.y += coordinc.y;
		}
	
		outcolour = accumcol / (SUBSAMPLES_DIM * SUBSAMPLES_DIM);
	}
	else
	{
		outcolour = texture2D( gm_BaseTexture, scaledCoords);
	}
	
	gl_FragColor = outcolour;
}