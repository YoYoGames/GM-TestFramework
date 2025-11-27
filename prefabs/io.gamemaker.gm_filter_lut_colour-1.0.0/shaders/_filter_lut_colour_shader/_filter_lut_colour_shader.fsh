/*
	"LUT Colour Grading" by Xor

	Use a typical 512x512 LUT texture to colour grade anything.
	LUTs can be used applying any number of colors all at once, including:
	Saturation, contrast, color balance, color curves, inversion, palette swaps and more!

	Plus there's an intensity parameter so you can control exactly how much of an effect it has.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Flag indicating whether we're using premultiplied alpha (single-layer mode)
uniform float gm_pPreMultiplyAlpha;

//Lut colour grading intensity (0.0 = no effect up to 1.0 = full effect)
uniform float g_LUTColourIntensity;

//LUT texture for colour grading
uniform sampler2D g_LUTColourTexture;
//Unneeded texel size
//uniform vec2 g_LUTColourTextureTexelSize;

//Number of colours per channel (64 is standard)
#define COL_N 64.0
//Square root of COL_N
#define COL_S 8.0
//Reciprocal of COL_S
#define COL_R 0.125

#define INTERPOLATE

//LUT look-up (with optional channel cell offset)
vec3 look_up(vec3 col, vec3 off)
{
	vec3 index = clamp(floor(col.rgb * COL_N - 0.5) + off, 0.0, COL_N-1.0);
	vec2 coord = (index.rg / COL_N + mod(floor(index.b * vec2(1, COL_R)), COL_S)) * COL_R;

	return texture2D(g_LUTColourTexture, coord).rgb;
}
//LUT look-up with per-channel interpolation
vec3 look_up_interpolated(vec3 col)
{
	vec3 col000 = look_up(col, vec3(0,0,0));
	vec3 col100 = look_up(col, vec3(1,0,0));
	vec3 col010 = look_up(col, vec3(0,1,0));
	vec3 col110 = look_up(col, vec3(1,1,0));
	vec3 col001 = look_up(col, vec3(0,0,1));
	vec3 col101 = look_up(col, vec3(1,0,1));
	vec3 col011 = look_up(col, vec3(0,1,1));
	vec3 col111 = look_up(col, vec3(1,1,1));

	vec3 m = fract(col * COL_N + 0.5);
	return mix(mix(mix(col000, col100, m.r), mix(col010, col110, m.r), m.g),
				mix(mix(col001, col101, m.r), mix(col011, col111, m.r), m.g), m.b);
}

void main()
{
	//Sample base texture for LUT mapping
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Get LUT colour with or without interpolation
	#ifdef INTERPOLATE
		vec3 lut_colour = look_up_interpolated(colour.rgb);
	#else
		vec3 lut_colour = look_up(colour.rgb, vec3(0,0,0));
	#endif

	float colmul = 1.0;
	if (gm_pPreMultiplyAlpha > 0.0)
	{
		colmul = colour.a;
	}

	lut_colour *= colmul;

	colour.rgb = mix(colour.rgb, lut_colour, g_LUTColourIntensity);

	//Output with vertex colour
	gl_FragColor = v_vColour * colour;
}
