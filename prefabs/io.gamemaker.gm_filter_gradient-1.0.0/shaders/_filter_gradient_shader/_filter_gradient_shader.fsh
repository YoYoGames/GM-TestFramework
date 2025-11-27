/*
	"Gradients BG" by Xor

	A basic colour gradient background with many 6 modes to try:
		0 = Linear gradient
		1 = Circle/radial
		2 = Rectangle
		3 = Rotated square
		4 = Symmetrical  conic
		5 = Asymmetrical conic

	There are parameters for two colours and two endpoints.
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 gm_pSurfaceDimensions;

// Flag indicating whether we're using premultiplied alpha (single-layer mode)
uniform float gm_pPreMultiplyAlpha;

//Start and end colour (angle alpha)
uniform vec4 g_GradientColour1;
uniform vec4 g_GradientColour2;
//Start and end position (ranging from 0.0 to 1.0)
uniform vec2 g_GradientPosition1;
uniform vec2 g_GradientPosition2;
//Gradient mode (see list above)
uniform float g_GradientMode;

//Tau (pi*2) and pi for trig math
#define TAU 6.283185
#define PI  3.141593

void main()
{
	//Start with base texture
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Compute pixel coordinates (screen-space)
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions;
	//End points in pixel coordinates
	vec2 pixel_pos1 = g_GradientPosition1 * gm_pSurfaceDimensions;
	vec2 pixel_pos2 = g_GradientPosition2 * gm_pSurfaceDimensions;

	//Get the current point, relative to the starting point
	vec2 pnt = pixel - pixel_pos1;
	//Get the difference between the end points
	vec2 dif = pixel_pos2 - pixel_pos1;
	//Compute the reciprocal of the square of the distance for formulas
	float rcp =  1.0 / dot(dif, dif);
	//Compute the rotated coordinates
	//vec2 rot =  pnt * mat2(dif,-dif.y,dif.x) * rcp;
	vec2 rot = vec2(dot(pnt, vec2(dif.x, -dif.y)), dot(pnt, vec2(dif.y, dif.x))) * rcp;
	//Rectangle coordinates
	vec2 rec = abs(pnt / dif);

	//Compute gradients
	float position = dot(pnt, dif) * rcp;									//0 = Linear gradient
	if (g_GradientMode>0.5) position = length(pnt) / length(dif);	//1 = Circle/radial
	if (g_GradientMode>1.5) position = max(rec.x,rec.y);			//2 = Rectangle
	if (g_GradientMode>2.5) position = abs(rot.x)+abs(rot.y);		//3 = Rotated square
	if (g_GradientMode>3.5) position = abs(atan(rot.y,rot.x))/PI;	//4 = Symmetrical  conic
	if (g_GradientMode>4.5) position = (atan(rot.y,-rot.x))/TAU+.5;	//5 = Asymmetrical conic

	//Clamp to 0.0 to 1.0 range.
	position = clamp(position, 0.0, 1.0);

	float colmul = 1.0;
	if (gm_pPreMultiplyAlpha > 0.0)
	{
		colmul = colour.a;
	}

	//Get the gradient colour
	vec4 gradient_colour = mix(g_GradientColour1, g_GradientColour2, position) * colmul;
	//Blend with base_colour;
	colour.rgb = mix(colour.rgb, gradient_colour.rgb, gradient_colour.a);
	//Output with vertex colour
	gl_FragColor = v_vColour * colour;
}
