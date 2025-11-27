/*
	"Colour Balance" by Xor
	
	Applies a colour balance filter using RGB/CMY tones.
	The tones range from +1 to -1 (RGB to CMY respectively).
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Shadow tones apply to luminosity values less than 0.4
uniform vec3 g_ColourBalanceShadows;
//Midtones apply to luminosity values between 0.3 and 0.7
uniform vec3 g_ColourBalanceMidtones;
//Highlight tones apply to luminosity values greater than 0.6
uniform vec3 g_ColourBalanceHighlights;

void main()
{
	//Get the base texture colour
	vec4 base_colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	//Luma values from:  https://GMshaders.com/tutorials/tipsandtricks/#useful
	const vec3 luma = vec3(0.299, 0.587, 0.114);
	//Compute luminosity.
	float luminosity = dot(base_colour.rgb, luma);
		
	//Blend between shadows and midtones
	float blend1 = smoothstep(0.3, 0.4, luminosity);
	vec3 tones = mix(g_ColourBalanceShadows, g_ColourBalanceMidtones, blend1);
	
	//Blend between midtones and highlights
	float blend2 = smoothstep(0.6, 0.7, luminosity);
	tones = mix(tones, g_ColourBalanceHighlights, blend2);
	
	//Apply colour balancing
	vec3 colour = base_colour.rgb + base_colour.rgb * tones + max(tones, 0.0)/1.5;
	//Make sure it stays in the 0 to 1 range
	colour = clamp(colour, 0.0, 1.0);
	
	//Preserve luminosity
	colour *= luminosity / dot(colour, luma);
	
	//Output final result
    gl_FragColor = vec4(colour, base_colour.a);
}