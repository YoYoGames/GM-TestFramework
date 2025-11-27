/*
	"Clouds BG" by Xor

	Renders smooth cartoony clouds
	This uses a specialized noise texture that makes use of all 4-channels for more efficient sampling
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;
//Camera offset for matching view
uniform vec2 gm_pCamOffset;

//Cloud circle scale (in pixels)
uniform float g_CloudScale;
//Shape of whole clouds (horizontal and vertical)
uniform vec2  g_CloudShape;
//Level/amount of clouds (0.0 = no clouds, to 1.0 = full clouds)
uniform float g_CloudLevel;
//Density along cloud edges (1.0 = hard transition, lower = smoother transition)
uniform float g_CloudDensity;
//Velocity (in pixels per second)
uniform vec2  g_CloudVelocity;
//Amount of waves (0.0 = no waves, higher = more waves)
uniform float g_CloudWaves;
//Speed of turbulence
uniform float g_CloudTurbulence;
//Alpha fade at cloud edge (in pixels)
uniform float g_CloudFade;
//Light side colour
uniform vec4  g_CloudColour1;
//Shade side colour
uniform vec4  g_CloudColour2;
//Shade offset (-1.0 to +1.0)
uniform vec2  g_CloudShadeOffset;
//Shade fade at shadow edge (in pixels)
uniform float g_CloudShadeFade;

//Cloud texture for Worley function
uniform sampler2D g_CloudTexture;
//Cloud texel size
uniform vec2 g_CloudTextureTexelSize;

//Half pi and tau (pi*2)
#define PIH 1.5707963
#define TAU 6.2831853

//Cloud shape function (signed bi-cubic texture sample)
float shape(vec2 p)
{
	//Scale/stretch
    p *= g_CloudShape;
	//Add velocity movement
	p -= g_CloudVelocity / g_CloudScale * gm_pTime;

	//Bi-cubic interpolation
    vec2 f = floor(p);
    vec2 s = p-f;
    s *= s*(3.0-s*2.0);
    vec4 samp = texture2D(g_CloudTexture, (f + 0.5) * g_CloudTextureTexelSize);

	//Add wave, interpolated sample and cloud level
    return g_CloudWaves*sin(p.y*5.0 + sin(p.x*9.0)) +
	mix(mix(samp.r, samp.g, s.x), mix(samp.b, samp.a, s.x), s.y) - g_CloudLevel;
}
//Smooth maximum (inspired by IQ's smin: https://iquilezles.org/articles/smin/)
vec2 smax(vec2 a, vec2 b, vec2 k)
{
    vec2 h = clamp(0.5+0.5 * (a-b)/k, 0.0, 1.0 );
    return mix( b, a, h ) + k*h * (1.0-h);
}
//Sample worley circle with size from the shape function
vec2 circle(vec2 d,float s,vec2 t,vec2 p)
{
	//Add turbulence
	t += sin(s + vec2(0,PIH) + (g_CloudTurbulence * TAU)) * 0.25 - 1.0;
	//Compute radius from cloud shape function
	float D = shape(t) / length(g_CloudShape)*g_CloudDensity;
	float r = clamp(min(D,D*2.0-0.5), -2.0, 2.0);
	//Compute smoothness factor
	vec2 k = min(vec2(g_CloudFade, g_CloudShadeFade) / g_CloudScale, 0.25);
	//Find smooth maximum (circle and shadow respectively)
	return smax(d, r - vec2(length(t-p), length(t-p+g_CloudShadeOffset)),k);
}
//Sample clouds (a highly modified Worley function)
vec4 clouds(vec2 p)
{
	//Correct for cloud scale
	p /= g_CloudScale;
	//Cell floor
    vec2 f = floor(p);
	//Worley distance for circle and shadow
    vec2 dist = vec2(-9,-9);

	//Cell offset
	const vec2 O = vec2(0,2);
	//Sample a 4x4 cell region (using 4-channel neighbor packing)
	vec4 samp00 = texture2D(g_CloudTexture, (f+O.xx + 0.5) * g_CloudTextureTexelSize) * TAU;
	vec4 samp10 = texture2D(g_CloudTexture, (f+O.yx + 0.5) * g_CloudTextureTexelSize) * TAU;
	vec4 samp01 = texture2D(g_CloudTexture, (f+O.xy + 0.5) * g_CloudTextureTexelSize) * TAU;
	vec4 samp11 = texture2D(g_CloudTexture, (f+O.yy + 0.5) * g_CloudTextureTexelSize) * TAU;

	//Loop through samples
	for(int x = 0; x<=1; x++)
	for(int y = 0; y<=1; y++)
	{
		vec2 v = f + vec2(x,y);
		dist = circle(dist, samp00[x+y*2], v+O.xx, p);
	    dist = circle(dist, samp10[x+y*2], v+O.yx, p);
		dist = circle(dist, samp01[x+y*2], v+O.xy, p);
		dist = circle(dist, samp11[x+y*2], v+O.yy, p);
	}
	//Convert distances to the correct range
	dist = clamp(dist*g_CloudScale*0.5/vec2(g_CloudFade, g_CloudShadeFade), 0.0, 1.0);
	//Blend between colours
	vec4 col = vec4(mix(sqrt(g_CloudColour1.rgb), sqrt(g_CloudColour2.rgb), dist.y), dist.x);
	//Square colours for better transitions
	col.rgb *= col.rgb;
    return col;
}

void main()
{
	//Sample base texture
	vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Compute pixel coordinates
	vec2 pixel = v_vTexcoord * gm_pSurfaceDimensions;

	//Add offsets
	pixel += gm_pCamOffset;

	//Sample cloud colour and alpha
	vec4 cloud = clouds(pixel);

	//Initialize output colour
	vec4 colour = base_colour;
	//Blend colours with base texture
	cloud.a *= colour.a;		// factor in base alpha
	colour.rgb = colour.rgb + (cloud - colour).rgb * cloud.a;

	//Output result with vertex colour
	gl_FragColor = v_vColour * colour;
}
