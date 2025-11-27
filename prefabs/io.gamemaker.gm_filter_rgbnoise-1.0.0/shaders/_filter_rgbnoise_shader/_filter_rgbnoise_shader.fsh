/*
	"RGB Noise" by Xor

	Generates RGB random noise (which can be animated).
	Added parameters for colour and intensity.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for static animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;

//Noise intensity (0 = no noise, 1 = full noise)
uniform float g_RGBNoiseIntensity;
//Animation toggle (0 = no animation, 1 = animation)
uniform float g_RGBNoiseAnimation;
//Noise colour multiplier (alpha is unused)
uniform vec4 g_RGBNoiseColour;

//RGB noise texture used as a seed
uniform sampler2D g_RGBNoiseTexture;
//Noise texel size
uniform vec2 g_RGBNoiseTextureTexelSize;

#define TAU 6.283185307

void main()
{
	//Sample base texture
	vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Animation time (0 if disabled)
	float time = g_RGBNoiseAnimation;

	//Compute pixel coordinates (plus time offset)
	highp vec2 pixel = floor(v_vTexcoord * gm_pSurfaceDimensions + time) + 0.5;
	//Compute noise texture coordinates
	vec2 noise_coord = pixel * g_RGBNoiseTextureTexelSize;
	//Sample noise texture
	highp vec3 noise = texture2D(g_RGBNoiseTexture, noise_coord).rgb;
	//Compute pseudo-random value with noise texture, pixel coordinates and time
	noise = fract(sin(noise*94.3 + pixel.x*vec3(0.063, 0.071, 0.67)	+ pixel.y*vec3(0.127, 0.117, 0.109) + (time * TAU))*5945.);
	//Multiply by noise colour
	noise.rgb *= g_RGBNoiseColour.rgb;

	//Initialize output colour
	vec4 colour = base_colour;
	//Linearly mix with noise using intensity
	colour.rgb = colour.rgb + (noise - colour.rgb) * colour.a * g_RGBNoiseIntensity;

	gl_FragColor = v_vColour * colour;
}
