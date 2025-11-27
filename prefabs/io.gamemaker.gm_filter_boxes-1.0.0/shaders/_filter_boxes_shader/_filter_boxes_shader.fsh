/*
	"Boxes Background" by Xor

	Renders randomized boxes over top of the base texture.
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

// For handling single layer mode
uniform float gm_pPreMultiplyAlpha;

//Box spacing in pixels
uniform float g_BoxesScale;
//min,max box size (ranging from 0 to 1)
uniform vec2 g_BoxesSize;
//x,y offset (pixels) for manual adjustment
uniform vec2 g_BoxesOffset;
//Displacement amount (0.0 = no displacement to 1.0 = full displacement)
uniform float g_BoxesDisplacement;
//Animation speed
uniform float g_BoxesSpeed;
//Starting angle (useful for non-rotating boxes)
uniform float g_BoxesAngle;
//min,max Rotation speed
uniform vec2 g_BoxesRotation;

//Roundness amount (0.0 = sharp corners to 1.0 = circular corners)
uniform float g_BoxesRoundness;
//Color animation speed
uniform float g_BoxesColourSpeed;
//Number of colours to use from the palette
uniform float g_BoxesColours;
//Edge sharpness (1.0 = one-pixel edge, 0.5 = two-pixels, etc)
uniform float g_BoxesSharpness;

//Palette texture (columns for colours, rows for optional animation)
uniform sampler2D g_BoxesPalette;

//Approximation of pi/2 (for rotation)
#define HALF_PI 1.570796
#define DOUBLE_PI 6.283185307

//Sample palette texture
vec4 palette(float p, float r)
{
	//Precompute reciprocal of the colour count
	float rcp = 1.0 / g_BoxesColours;
	//Compute colour and animate with y-axis
	vec2 coord = vec2((floor(p * g_BoxesColours) + 0.5) * rcp, g_BoxesColourSpeed);
	//Sample palette
 	return texture2D(g_BoxesPalette, coord);
}
//Compute a complex sinusoidal wave for motion
vec2 wave(vec2 p)
{
 	return sin((g_BoxesSpeed * DOUBLE_PI) + p.yx + cos(p * mat2(.78,-.11,.07,.89))) * g_BoxesDisplacement * 0.7+0.5;
}
//Compute 2D pseudo-random hash
vec4 hash(vec2 p)
{
 	return fract(sin(p.x * vec4(45,61,53,50) - p.y * vec4(52,63,42,59))*394.);
}

void main()
{
	//Start with base texture
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

	//Compute pixel coordinates (world-space)
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions - gm_pCamOffset;
	//Compute scaled coordinates
	vec2 coord = pixel / g_BoxesScale;
	//Compute sub-cell coordinates (0.0 to 1.0)
	vec2 sub = fract(coord);
	//Compute whole number cell coordinates
	vec2 cell = coord - sub;
	//Edge thickness before scaling
	float edge = 1.0 / g_BoxesSharpness / g_BoxesScale;

	//Iterate through neighbor cells
	for(int x = -1; x<=1; x++)
	for(int y = -1; y<=1; y++)
	{
		//Current cell position
		vec2 current_cell = cell + vec2(x,y);
		//Get random values for rotation, size, colour and animation
		vec4 rand = hash(current_cell + 1.0);
		//Get rotation angle
		float angle =  mix(g_BoxesRotation.x, g_BoxesRotation.y, rand.x) * gm_pTime;
		//Compute direction vector for rotation
		vec2 vect = cos( -(g_BoxesAngle * (HALF_PI / 90.0) + angle) + vec2(0, HALF_PI));
		//Assemble rotation matrix
		mat2 rotate = mat2(vect, -vect.y, vect.x);
		//Cell with wave offset
		vec2 offset = current_cell + wave(current_cell);

		//Distance to box edge
		float size = mix(g_BoxesSize[0], g_BoxesSize[1], rand.y) * 0.5;
		//Rotate and compute axial distance to edges
		vec2 square = max(abs((coord - offset) * rotate) + size * (g_BoxesRoundness - 1.0) - edge, 0.0);
		//Compute distance to round square edge
		float dist =  size * g_BoxesRoundness - length(square);
		//Sample box colour and alpha
		vec4 box_colour = palette(rand.z, rand.w);
		//Compute alpha from distance
		float alpha = clamp(dist * g_BoxesScale * g_BoxesSharpness + 1.0, 0.0, 1.0) * box_colour.a;		

		//Factor in base alpha
		if (gm_pPreMultiplyAlpha > 0.0)
		{			
			box_colour *= colour.a;
		}				
		colour.rgb = mix(colour.rgb, box_colour.rgb, alpha);
	}

	//Output results
    gl_FragColor = colour;
}
