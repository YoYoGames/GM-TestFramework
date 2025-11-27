/*
	"3D Panorama BG" by Xor
	
	This projects any HDRI or cylindrical texture as 3D panorama.
	You can rotate the panorama or change the perspective as needed.
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

//Panorama view direction (yaw, pitch 0.0 to 1.0)
uniform vec2 g_PanoramaDirection;
//Perspective ratio (1.0 = 90 degree fov_y, lower = lower FOV)
uniform float g_PanoramaPerspective;
//Toggle for cylinder texturing (0.0 = HDRI, 1.0 = cylinder)
uniform float g_PanoramaCylinder;
//Texture for mapping
uniform sampler2D g_PanoramaTexture;
//Texel size (unused)
//uniform vec2 g_PanoramaTextureTexelSize;


//Half pi, pi, tau (pi*2) for trig math
#define HPI 1.570796
#define PI  3.141593
#define TAU 6.283185

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
	vec3 ray = vec3((pixel*2.0 - res) / res.y * g_PanoramaPerspective, 1.0);
	//Normalize for correct rotations
	ray = normalize(ray);
	
	//Rotate pitch first, then yaw
	ray.yz *= rotate2D(g_PanoramaDirection.y*PI-HPI);
	ray.xz *= rotate2D(g_PanoramaDirection.x*TAU);
	
	//Convert float to bool
	bool cylinder = g_PanoramaCylinder > 0.5;
	//Correct for cylinder projection
	if (cylinder) ray /= sqrt(1.0-ray*ray).y;
	
	//Compute 2D coordinates from polar coordinates
	vec2 coord = vec2(atan(ray.z,ray.x)/TAU, cylinder? ray.y/PI : asin(ray.y)/PI) + 0.5;
	//Sample panorama texture
	vec4 tex = texture2D(g_PanoramaTexture, coord);
	//Sample base texture
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);

	//Factor in base alpha
	if (gm_pPreMultiplyAlpha > 0.0)
	{			
		tex.rgb *= colour.a;
	}	
	
	//Blend with base texture
	colour.rgb = mix(colour.rgb, tex.rgb, tex.a);
	
	//Output result with vertex colour factored
	gl_FragColor = v_vColour * colour;
}