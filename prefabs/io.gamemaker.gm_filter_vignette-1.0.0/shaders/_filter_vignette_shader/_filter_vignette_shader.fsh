/*
	"Vignette" by Xor
	
	Adds a smooth vignette border to the screen.
	There are parameters to adjust the fade and shape.
	The texture determines the color and alpha!
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Surface resolution for pixel calculations
uniform vec2 gm_pSurfaceDimensions;

//Vignette start and end points (0.0 = screen center, 1.0 = screen side)
uniform vec2 g_VignetteEdges;
//Vignette corner sharpness (1.0 = circular, higher = more square)
uniform float g_VignetteSharpness;

//Vignette texture for color or texturing
uniform sampler2D g_VignetteTexture;
//Vignette texture texel size for 1 to 1 scaling
uniform vec2 g_VignetteTextureTexelSize;

void main()
{
	//Sample base texture for blending with
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	
	//Distance to screen center (from 0.0 to 1.0)
	vec2 center = abs(v_vTexcoord - 0.5) * 2.0;
	//Compute exponential coordinates
	vec2 coord = pow(center, vec2(g_VignetteSharpness));
	//Get linear distance to edge
	float vignette = pow(length(coord), 1.0 / g_VignetteSharpness);
	//Normalize to vignette edges (positive uncapped)
	vignette = max((vignette-g_VignetteEdges.x) / (g_VignetteEdges.y-g_VignetteEdges.x), 0.0);
	
	//Compute pixel coordinates (screen-space)
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions;
	//Convert to vignette texture coordinates
	vec2 vignette_coord = pixel * g_VignetteTextureTexelSize;
	//Sample vignette texture
	vec4 vignette_sample = texture2D(g_VignetteTexture, vignette_coord);
	
	//Blend with base color	
	colour.rgb = mix(colour.rgb, vignette_sample.rgb, min(vignette * vignette_sample.a, 1.0));
	gl_FragColor = v_vColour * colour;
}