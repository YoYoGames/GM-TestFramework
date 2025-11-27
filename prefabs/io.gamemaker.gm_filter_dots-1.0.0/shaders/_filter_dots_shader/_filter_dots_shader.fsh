/*
	"Dots Background" by Xor

	Renders randomized circles over top of the base texture.
	There are plenty of parameters for customizing and animating as needed.
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time for movement animation
uniform float gm_pTime;
//Surface resolution for pixel calculations
uniform vec2 gm_pSurfaceDimensions;
//Surface texel size for coordinate calculations
uniform vec2 gm_pSurfaceTexelSize;
//Camera offset for matching view
uniform vec2 gm_pCamOffset;


//Dot spacing in pixels
uniform float g_DotsScale;
//min,max dot size (ranging from 0 to 1)
uniform vec2 g_DotsSize;
//x,y offset (pixels) for manual adjustment
uniform vec2 g_DotsOffset;
//Displacement amount (0.0 = no displacement to 1.0 = full displacement)
uniform float g_DotsDisplacement;
//Animation speed
uniform float g_DotsSpeed;
uniform float g_DotsColourSpeed;
//Number of colours to use from the palette
uniform float g_DotsColours;
//Edge sharpness (1.0 = one-pixel edge, 0.5 = two-pixels, etc)
uniform float g_DotsSharpness;


//Palette texture (columns for colours, rows for optional animation)
uniform sampler2D g_DotsPalette;

#define TAU 6.283185307

//Sample palette texture
vec4 palette(float p, float r)
{
	//Precompute reciprocal of the colour count
	float rcp = 1.0 / g_DotsColours;
	//Compute colour and animate with y-axis
	vec2 coord = vec2((floor(p * g_DotsColours) + 0.5) * rcp, 0.2 * g_DotsColourSpeed);
	//Sample palette
 	return texture2D(g_DotsPalette, coord);
}
//Compute a complex sinusoidal wave for motion
vec2 wave(vec2 p)
{
 	return sin((g_DotsSpeed * TAU) + p.yx + cos(p * mat2(.78,-.11,.07,.89))) * g_DotsDisplacement * 0.5;
}
//Compute 2D pseudo-random hash
vec2 hash(vec2 p)
{
 	return fract(sin(p * mat2(78,-11,07,89))*394.);
}

void main()
{
	//Start with base texture
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

	//Compute pixel coordinates
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions;
	//Add offsets
	pixel += gm_pCamOffset - g_DotsOffset;
	//Compute scaled coordinates
	vec2 coord = pixel / g_DotsScale;
	//Compute sub-cell coordinates (0.0 to 1.0)
	vec2 sub = fract(coord);
	//Compute whole number cell coordinates
	vec2 cell = coord - sub;

	//Iterate through neighbor cells
	for(int x = 0; x<=1; x++)
	for(int y = 0; y<=1; y++)
	{
		//Current cell position
		vec2 current_cell = cell + vec2(x,y);
		//Random cell values for colour and radius
		vec2 rand = hash(current_cell + 1.0);
		//Cell with wave offset
		vec2 offset = current_cell + wave(current_cell);

		//Distance to dot edge
		float dist = mix(g_DotsSize[0], g_DotsSize[1], rand.y) * 0.5 - length(coord - offset);
		//Sample dot colour and alpha
		vec4 dot_colour = palette(rand.x, rand.y);
		//Compute alpha from distance
		float alpha = clamp(dist * g_DotsScale * g_DotsSharpness, 0.0, 1.0) * dot_colour.a;

		//Factor in base alpha
		alpha *= colour.a;
		colour.rgb = mix(colour.rgb, dot_colour.rgb, alpha);
	}

	//Output results
    gl_FragColor = colour;
}
