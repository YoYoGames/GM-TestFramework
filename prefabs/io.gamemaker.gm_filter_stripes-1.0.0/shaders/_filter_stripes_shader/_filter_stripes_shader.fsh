/*
	"Stripes Background" by Xor

	A generic vertex passthrough shader.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

//Time for movement animation
uniform float gm_pTime;
//Surface resolution for pixel calculations
uniform vec2 gm_pSurfaceDimensions;
//Surface texel size for coordinate calculations
uniform vec2 gm_pSurfaceTexelSize;
//Camera offset for matching view
uniform vec2 gm_pCamOffset;

//Stripe width in pixels
uniform float g_StripesWidth;
//Direction angle in degrees
uniform float g_StripesDirection;
//x,y offset in pixels
uniform vec2  g_StripesOffset;
//Width displacement (0.0 = no displacement to 1.0 = full displacement)
uniform float g_StripesDisplacement;
//Animation speed (0.0 = no animation)
uniform float g_StripesSpeed;
//Wave frequency in pixels
uniform float g_StripesFrequency;
//Wave amplitude/depth in pixels
uniform float g_StripesAmplitude;
//Number of stripe colours
uniform float g_StripesColours;
//Edge sharpness (1.0 = one-pixel edge, 0.5 = two-pixels, etc)
uniform float g_StripesSharpness;

//Palette texture (columns for colours, rows for optional animation)
uniform sampler2D g_StripesPalette;

#define TAU 6.283185307

//Sample palette texture
vec4 palette(float p)
{
	//Precompute reciprocal of the colour count
	float rcp = 1.0 / g_StripesColours;
	//Sample with colour "p" and animate the y-axis
 	return texture2D(g_StripesPalette, vec2(p, g_StripesSpeed) * rcp);
}
//Compute a sinusoidal wave for motion
float wave(float p)
{
	float t = g_StripesSpeed * TAU;
 	return sin(p + t + 0.6 * cos(p * 0.91 - t)) * 0.5 * g_StripesDisplacement;
}

void main()
{
	//Start with base texture
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

	//Compute the stripe width reciprocal
	float rcp  = 1.0 / g_StripesWidth;
	//Convert degrees to radians
	float angle = radians(g_StripesDirection);
	//Compute unit vector
	vec2 dir = vec2(cos(angle), -sin(angle));

	//Compute pixel coordinates
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions - gm_pCamOffset;
	//Add offset
	pixel -= g_StripesOffset;
	//Compute position along the dir vector
	float pos = dot(pixel, dir * rcp);
	//Compute the sideway position
	float side = dot(pixel, vec2(dir.y,-dir.x));

	//Scale to frequency
	float scale = 3.1415 / g_StripesFrequency;
	//Add position offset for sine waves
	pos += cos(side * scale) * rcp * g_StripesAmplitude;

	//Sample wave at current pixel and one-pixel away
	float w0 = wave(pos);
	float w1 = wave(pos + rcp);
	//Approximate derivative
    float d = g_StripesSharpness / abs(w0 - w1 - rcp);
	//Smoothly blend between colours at defined pixel scale
	float p = floor(pos + w0) + clamp((fract(pos + w0)-0.5) * d + 0.5, 0.0, 1.0) + 0.5;
	//Sample palette texture for stripe colour
    vec4 stripe_colour = palette(p);

	//Factor in base alpha
	stripe_colour.a *= colour.a;

	//Blend with base colour
	colour.rgb = mix(colour.rgb, stripe_colour.rgb, stripe_colour.a);
    gl_FragColor = colour;
}
