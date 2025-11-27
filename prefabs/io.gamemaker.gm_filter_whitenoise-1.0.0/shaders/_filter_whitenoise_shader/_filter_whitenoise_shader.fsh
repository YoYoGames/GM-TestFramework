/*
	"White Noise" by Xor

	Samples the texture evenly in a straight line.
	The noise texture is used to offset the samples.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for static animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;

//Noise intensity (0 = no noise, 1 = full noise)
uniform float g_WhiteNoiseIntensity;
//Animation toggle (0 = no animation, 1 = animation)
uniform float g_WhiteNoiseAnimation;

//White noise texture
uniform sampler2D g_WhiteNoiseTexture;
//White noise texel size
uniform vec2 g_WhiteNoiseTextureTexelSize;

#define TAU 6.283185307

void main()
{
	//Sample base texture
	vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Animation time (0 if disabled)
	float time = g_WhiteNoiseAnimation;

	//Compute pixel coordinates (plus time offset)
	vec2 pixel = floor(v_vTexcoord * gm_pSurfaceDimensions + time) + 0.5;
	//Compute noise texture coordinates
	vec2 noise_coord = pixel * g_WhiteNoiseTextureTexelSize;
	//Sample noise texture
	float noise = texture2D(g_WhiteNoiseTexture, noise_coord).r;
	//Compute pseudo-random value with noise texture, pixel coordinates and time.
	noise = fract(sin(noise*94.3 + dot(pixel,vec2(0.063,0.127)) + (time * TAU))*5945.);

	//Initialize output colour
	vec4 colour = base_colour;
	//Linearly mix with noise using intensity
	colour.rgb = colour.rgb + (noise - colour.rgb) * colour.a * g_WhiteNoiseIntensity;

	gl_FragColor = v_vColour * colour;
}
