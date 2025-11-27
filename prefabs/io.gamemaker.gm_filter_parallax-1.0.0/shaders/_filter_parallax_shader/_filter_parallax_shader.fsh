/*
	"3D Parallax BG" by Xor

	This is a parallax occlusion shader that renders a heightmap as 3D texture.
	To map a 2D texture to a 3D projection, we raytrace the top and bottom ("start" and "end")
	boundary planes and linearly interpolate between them.
	Rather than stopping at the first intersection, instead we step back step at a higher resolution
	to help fill in any gaps between samples.
	This greatly improves quality without requiring more samples!
*/

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Time in seconds for static animation
uniform float gm_pTime;
//Surface dimensions for pixel coordinates
uniform vec2 gm_pSurfaceDimensions;
//Surface texel size for coordinate calculations
uniform vec2 gm_pSurfaceTexelSize;

// For handling single layer mode
uniform float gm_pPreMultiplyAlpha;

//Parallax view direction (yaw, pitch 0.0 to 1.0)
uniform vec2 g_ParallaxDirection;
//Perspective ratio (1.0 = 90 degree fov_y, lower = lower FOV)
uniform float g_ParallaxPerspective;
//Camera position (x,y/height, z)
uniform vec3 g_ParallaxPosition;
//Texture scale (higher = more often)
uniform float g_ParallaxScale;
//Parallax depth (higher = deeper)
uniform float g_ParallaxDepth;
//Fog colour and alpha
uniform vec4 g_ParallaxFogColour;
//Fog start and end depths respectively
uniform vec2 g_ParallaxFogRange;
//Fog thickness/depth in valley
uniform float g_ParallaxFogDepth;

//Diffuse colour texture (alpha for height)
uniform sampler2D g_ParallaxTexture;
//uniform vec2 g_ParallaxTextureTexelSize;

//Half pi, pi, tau (pi*2) for trig math
#define HPI 1.570796
#define PI  3.141593
#define TAU 6.283185

//Sample step size (reciprocal of the number of samples)
//In this case: 1.0/64.0
#define STEP_SIZE 0.015625

//Classic 2D rotation function
mat2 rotate2D(float a)
{
	vec2 angle = vec2(cos(a),sin(a));
	//Construct rotation matrix
	return mat2(angle.xy,-angle.y,angle.x);
}

void main()
{
	//Shortened resolution name for convenience
	#define res gm_pSurfaceDimensions
	//Compute pixel coordinates
	vec2 pixel = v_vTexcoord * res;
	//Compute ray direction from pixel coordinates (unnormalized)
	vec3 ray = vec3((pixel*2.0 - res) / res.y * g_ParallaxPerspective, 1.0);
	//Normalize for correct rotations
	ray = normalize(ray);

	//Rotate pitch first, then yaw
	ray.yz *= rotate2D(g_ParallaxDirection.y*PI-HPI);
	ray.xz *= rotate2D(g_ParallaxDirection.x*TAU);

	//Get raymarch start height, distance to plane, intersection point and UV coordinates
	float start_height = g_ParallaxPosition.y;
	float start_dist = start_height / ray.y;
	vec3 start_point = ray*start_dist;
	vec2 start_coord = start_point.xz - g_ParallaxPosition.xz;

	//Get raymarch end height, distance to plane, intersection point and UV coordinates
	float end_height = start_height + g_ParallaxDepth;
	float end_dist = end_height / ray.y;
	vec3 end_point = ray*end_dist;
	vec2 end_coord = end_point.xz - g_ParallaxPosition.xz;

	//Sample base texture
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);
	//Blend color (default fog)
	vec4 blend = g_ParallaxFogColour;
	//Parallax texture
	vec4 tex = vec4(0.0, 0.0, 0.0, 0.0);

	//If you intersect with starting plane, raymarch
	if (start_dist>0.0)
	{
		//Bool for intersection test
		bool hit = false;
		//Intersection coordinates
		vec2 coord = start_coord;
		//Dynamic step size (get's smaller)
		float step_size = STEP_SIZE;
		//Position between start and end point
		float pos = 0.0;
		//Iterate through layers
		for(float i = 0.0; i<1.0; i+=STEP_SIZE)
		{
			//Step forward
			pos += step_size;
			//Interpolate between layers
			coord = mix(start_coord, end_coord, pos);
			//Sample heightmap (inverted)
			tex = texture2D(g_ParallaxTexture, coord * g_ParallaxScale);
			//If the sample point is below the heightmap, step back
			if (1.0 - tex.a < pos)
			{
				//Step back
				pos -= step_size;
				//Reduce step size by half
				step_size *= 0.5;
				//Record the intersection
				hit = true;
			}
		}
		//If you don't hit anything, hit the floor
		if (!hit)
		{
			coord = end_coord;
			pos = 1.0;
			tex = texture2D(g_ParallaxTexture, coord * g_ParallaxScale);
		}
		//Reset alpha
		tex.a = 1.0;
		//Compute the difference from the intersection to camera
		vec3 fog_diff = vec3(coord.x, pos*g_ParallaxDepth, coord.y) + g_ParallaxPosition;
		//Scale height by fog depth factor
		fog_diff.y *= g_ParallaxFogDepth;
		//Get the fog distance
		float fog_dist = length(fog_diff);
		//Get the fog amount
		float fog = smoothstep(g_ParallaxFogRange[0], g_ParallaxFogRange[1], fog_dist);
		//Blend texture with fog
		blend = mix(tex, blend, fog);
	}

	//Factor in base alpha
	if (gm_pPreMultiplyAlpha > 0.0)
	{			
		blend.rgb *= colour.a;
	}		

	//Blend with base texture
	colour.rgb = mix(colour.rgb, blend.rgb, blend.a);

	//Output result with vertex colour factored
	gl_FragColor = v_vColour * colour;
}
