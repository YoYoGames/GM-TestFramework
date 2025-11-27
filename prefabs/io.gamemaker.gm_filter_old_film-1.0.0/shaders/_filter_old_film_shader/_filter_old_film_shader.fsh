/*
	"Old Film" by Xor

	This filter desaturates, adds jittering, flickering, random specks, bars and rings for
	a classic old film effect.

	Plenty of parameters for adjusting each component individually.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for static animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;
//Surface texel size for coordinate calculations
uniform vec2 gm_pSurfaceTexelSize;

//Flicker intensity (0.0 = no flicker, to 1.0 = 100% variation)
uniform float g_OldFilmFlickerIntensity;
//Flicker animation speed (default = 5.0)
uniform float g_OldFilmFlickerSpeed;
//Frame jittering offset in pixels (moves at flicker rate)
uniform float g_OldFilmJitterIntensity;
//Colour Saturation (0.0 = no saturation, to 1.0 = full saturation)
uniform float g_OldFilmSaturation;
//Speck intensity (0.0 = no specks, to 1.0 = max specks)
uniform float g_OldFilmSpeckIntensity;
//Bar width scale (1.0 = default)
uniform float g_OldFilmBarScale;
//Bar animation speed
uniform float g_OldFilmBarSpeed;
//Bar frequency (40.0 = default, higher = more often)
uniform float g_OldFilmBarFrequency;
//Scale of rings
uniform float g_OldFilmRingScale;
//Ring edge sharpness (60.0 = default, higher = sharper)
uniform float g_OldFilmRingSharpness;
//Ring intensity (0.0 = no rings, to 1.0 = full rings)
uniform float g_OldFilmRingIntensity;

//White noise texture
uniform sampler2D g_OldFilmTexture;
//White noise texel size
uniform vec2 g_OldFilmTextureTexelSize;

//Sample noise texture with bicubic interpolation
vec4 noise_sample(vec2 p)
{
	vec2 f = floor(p);
	vec2 s = p-f;
	//Bicubic interpolant
	s *= s*(3.0-s*2.0);

	return texture2D(g_OldFilmTexture, (f+s+0.5) * g_OldFilmTextureTexelSize);
}
//Iterate through 3 samples (using each RGB channel)
float noise_fractal(in vec2 p)
{
	//Golden angle rotation with 2.5x scaling
	mat2 trans = mat2(-0.7373688, -0.6754904, 0.6754904, -0.7373688) * 2.5;

	//Sample total
	float total = 0.0;
	//Iterate 3 times
	for(int i = 0; i<3; i++)
	{
		p *= trans;
		total += noise_sample(p+gm_pTime*9.)[i];
	}
	//Return total
	return total;
}
void main()
{
	//Compute offset for flicker and jitter
	vec2 offset_coord = v_vTexcoord * 0.1 + g_OldFilmFlickerSpeed;
	//Signed offset value (-0.5 to +0.5)
	vec3 offset = noise_sample(offset_coord).rgb - 0.5;
	//Flicker brightness
	float flicker = offset.b * g_OldFilmFlickerIntensity;

	//Compute texture coordinates with jitter offset
	vec2 coord = v_vTexcoord + offset.xy * g_OldFilmJitterIntensity * gm_pSurfaceTexelSize;
	//Sample base texture
	vec4 base_colour = texture2D(gm_BaseTexture, coord);

	//Compute pixel coordinates (plus time offset)
	vec2 pixel = coord * gm_pSurfaceDimensions;

	//Compute noise texture coordinates
	vec2 noise_coord = pixel * g_OldFilmTextureTexelSize;

	//Start with 0.7 scaling (hand picked scale)
	vec2 speck_coord = noise_coord*0.7;

	//Sample noise fractal
	float noise = noise_fractal(speck_coord);
	//Compute speck brightness (0.0 to 1.0)
	float speck = clamp((noise - g_OldFilmSpeckIntensity) * 4.0, 0.0, 1.0);

	//Bar sample coordinates (stretched vertically)
	vec2 bar_coord = noise_coord.x*vec2(5,2)/g_OldFilmBarScale + noise_coord.y*vec2(0,6e-3);
	//Animate (perpendicular to scaling)
	bar_coord += vec2(-2e2,5e2)*g_OldFilmBarSpeed;
	//Compute bar brightness (0.0 to 1.0)
	float bar = max(1.0 - exp(0.5 - noise - noise_sample(bar_coord).b*g_OldFilmBarFrequency),0.0);

	//Compute ring noise coordinates (scaled up and stretched)
	vec2 ring_coord = noise_coord / g_OldFilmRingScale * vec2(0.1, 0.06);
	//Sample noise for rings
	float ring = noise_fractal(ring_coord) + noise*0.03;
	//Get noise bias for valleys
	float bias = noise_sample(ring_coord + offset.xy*9.0).r * 20.0 - 2.0;
	//Compute ring brightness (0.0 to 1.0)
	ring = clamp(abs(ring-2.0) * g_OldFilmRingSharpness + bias, 1.0-g_OldFilmRingIntensity, 1.0);

	//Compute total brightness with specks, rings, bars and flicker
	float light = speck * ring * bar + flicker;

	//Gray scale brightness for desaturating
	float gray = dot(base_colour.rgb, vec3(0.299, 0.587, 0.114));

	//Initialize output colour
	vec4 colour = base_colour;
	//Bararly mix with gray colour for desaturation
	colour.rgb = (gray + (colour.rgb - gray) * g_OldFilmSaturation) * light;
	//Output result with v_vColour factor
	gl_FragColor = v_vColour * colour;
}
