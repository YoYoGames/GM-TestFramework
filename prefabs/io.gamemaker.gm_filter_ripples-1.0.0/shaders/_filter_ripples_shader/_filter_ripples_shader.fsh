/*
	"Ripples" by Xor
	
	Generates a simple radial ripple emanating from a variable position.
	
	Added parameters for adjusting speed, width, amplitude and radius (optional).
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for static animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;
//Surface texel size for coordinate calculations
uniform vec2 gm_pSurfaceTexelSize;

//Ripple center position in pixel coordinates
uniform vec2 g_RipplesPosition;
//Ripple animation speed (in seconds)
uniform float g_RipplesSpeed;
//Ripple width (in pixels)
uniform float g_RipplesWidth;
//Ripple amplitude (0.0 = no displacement, to 1.0 = full displacement)
uniform float g_RipplesAmplitude;
//Ripple radius (in pixels, 0.0 = infinite radius)
uniform float g_RipplesRadius;

#define TAU 6.283185307

void main()
{
	//Compute pixel coordinates (plus time offset)
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions;
	//Difference from current pixel to ripple center
	vec2 pixel_diff = pixel - g_RipplesPosition;
	//Distance from current pixel to center (in pixels)
	float len = length(pixel_diff);
	//Compute wave factor from sine wave
	float wave = sin(len / g_RipplesWidth - (g_RipplesSpeed * TAU));
	//Compute pixel amplitude from width and amplitude
	float amp = g_RipplesWidth * g_RipplesAmplitude;
	//Compute falloff value (if radius is > 0.0)
	float falloff = (g_RipplesRadius>0.0) ? max(1.0 - len/g_RipplesRadius, 0.0) : 1.0;
	//Add displacement to pixel coordinates
	pixel += wave * wave * pixel_diff / max(len, g_RipplesWidth) * falloff * amp;
	
	//Convert to texture coordinates
	vec2 coord = pixel * gm_pSurfaceTexelSize;
	
	//Sample base texture
	vec4 colour = texture2D(gm_BaseTexture, coord);
	
	//Output result with v_vColour factor
	gl_FragColor = v_vColour * colour;
}