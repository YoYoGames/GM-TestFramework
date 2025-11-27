/*
	"Hue & Saturation" by Xor
	
	Hue shift and saturation control
	
	This filter converts the colour to YIQ colour space, rotates the hue and scales saturation,
	then converts the colour back to RGB colour space.
	
	You can even increase the saturation level above 1.0 to boost saturation!
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Hue shift amount (0.0 = no shift, to 1.0 = full shift)
uniform float g_HueShift;
//Saturation level (0.0 = no saturation, to 1.0 = full colour, higher = more saturation)
uniform float g_HueSaturation;

//Tau (pi*2) for trig math
#define TAU 6.283185

//Hue shift by transforming YIQ colour space: en.wikipedia.org/wiki/YIQ
//Inputs are colour, hue shift angle (radians) and saturation multiplier
vec3 hue(vec3 col, float ang, float sat)
{
	//Colour conversion matrices
	const mat3 RGBtoYIQ = mat3(0.299,  0.587,  0.114,
							   0.596, -0.275, -0.321,
							   0.212, -0.523,  0.311);
	
	const mat3 YIQtoRGB = mat3(1.0,  0.956,  0.621,
							   1.0, -0.272, -0.647,
							   1.0, -1.107,  1.704);
	//Compute YIQ colour
	vec3 YIQ = col * RGBtoYIQ;
	//Rotate I and Q chrominance values and scale for saturation
	YIQ.yz *= mat2(cos(ang), -sin(ang), sin(ang), cos(ang)) * sat;
	
	//Convert back to RGB colour space
    return YIQ * YIQtoRGB;
}

void main()
{
	//Sample base texture
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);
	
	//Hue shift and saturation
	colour.rgb = hue(colour.rgb, g_HueShift * TAU, g_HueSaturation);
	
	//Output result with vertex colour factored
	gl_FragColor = v_vColour * colour;
}