/*
	"3D Blocks BG" by Xor
	
	This is a minimal voxel raytracer for rendering a simple 3D block background.
	If you give this BG a tilesheet sprite, it will randomize the block textures.
	
	You can adjust the camera position, perspective, lighting/shading and texturing.
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

//Camera position (x, y, z/depth in voxel units)
uniform vec3 g_BlocksPosition;
//Perspective ratio (1.0 = 90 degree fov_y, lower = lower FOV)
uniform float g_BlocksPerspective;
//Block shading amount (0.0 = no shading, to 1.0 = full shading)
uniform float g_BlocksShading;
//Lighting per face (0.0 = no-light, to 1.0 = full-light)
uniform vec3 g_BlocksFaceLight;
//Number of columns and rows of tiles on blocks texture
uniform vec2 g_BlocksTiles;
//Texture atlas for block tiles
uniform sampler2D g_BlocksTexture;
//Texel size (unused)
//uniform vec2 g_BlocksTextureTexelSize;

//Map function (approximate SDF scaled by sqrt(3.0))
float map(vec3 p)
{
	return -(p.x+p.y+p.z);
} 
void main()
{
	//Get pixel coordinates from surface resolution
	vec2 res = gm_pSurfaceDimensions;
	vec2 pixel = v_vTexcoord * res;
	//Compute ray direction from pixel coordinates (unnormalized)
	vec3 ray = vec3((pixel*2.0 - res) / res.y * g_BlocksPerspective, 1.0);
	
	//Square root of 1/2, 1/3, 2/3, 1/6 respectively
	#define R1_2 0.707106781187
	#define R1_3 0.577350269189
	#define R2_3 0.816496580927
	#define R1_6 0.408248290463
	//Build diagonal view matrix
	mat3 view = mat3(R1_2,-R1_6,R1_3, 0.0,R2_3,R1_3, -R1_2,-R1_6,R1_3);
	
	//Rotate ray with view matrix
	ray *= view;
	//Convert camera position to view space coordinates
	vec3 pos = -g_BlocksPosition*view;
	
	//Start at block edge for minimal steps
	float start_depth = g_BlocksPosition.z;
	//This will step forward until we hit dist block
	vec3 march = pos + ray * start_depth;
	//Ray sign per axis
	vec3 sgn = sign(ray);
	//Unsigned reciprocal of the ray direction for raytracing
	vec3 recip = sgn / ray;
	//Voxel normal
	vec3 norm = vec3(0.0);
	//Voxel cell index (whole number coordinates)
	highp vec3 vox;
	
	//We only need to step up to 9 times with this map function!
	for(int i = 0; i<9; i++)
	{
		//Offset to nearest voxel cell
		vec3 dist = fract(-march*sgn);
		//Get voxel cell coordinates
		vox = floor(march*sgn+1.0)*sgn;
		//Offset should be one when aligned with any axes
		dist += vec3(equal(dist,-dist));
		//Compute distance from offset
		dist *= recip;
		
		//March to closest axis plane in ray direction
		if (dist.x<dist.y)
		{
			if (dist.x<dist.z)	//X-Axis
			{
				norm = vec3(1,0,0);
				march += dist.x*ray;
				march.x = vox.x;
			}
			else				//Z-Axis
			{
				norm = vec3(0,0,1);
				march += dist.z*ray;
				march.z = vox.z;
			}
		}
		else
		{
			if (dist.y<dist.z)	//Y-Axis
			{
				norm = vec3(0,1,0);
				march += dist.y*ray;
				march.y = vox.y;
			}
			else				//Z-Axis
			{
				norm = vec3(0,0,1);
				march += dist.z*ray;
				march.z = vox.z;
			}	
		}
		vox = floor(march);
		//Stop when you hit a block
		if (map(vox)<0.0) break;
	}
	//Compute a pseudo-random tile index
	highp vec2 tile = floor(sin(vox.x*vec2(72,48) + vox.y*vec2(63,71) + vox.z*vec2(58,78))*1024.0);
	//Compute 2D uv coordinates for each face (based on normal)
	vec2 coord = fract(vec2(-march.z,march.y)*norm.x + vec2(march.x,-march.z)*norm.y + march.xy*norm.z);
	//Convert to tile coordinates
	coord = (coord+tile)/g_BlocksTiles;
	
	//Sample base texture
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);
	
	//Sample block texture
	vec4 tex = texture2D(g_BlocksTexture, coord);
	//Compute shading and lighting
	float shade = smoothstep(-1.0, -3.0, map(march));
	float light = dot(norm, g_BlocksFaceLight);
	//Factor in lighting
	tex.rgb *= (1.0 - shade * g_BlocksShading) * light;

	//Factor in base alpha
	if (gm_pPreMultiplyAlpha > 0.0)
	{			
		tex.rgb *= colour.a;
	}			
	
	//Use texture colour, but don't replace alpha
	colour.rgb = mix(colour.rgb, tex.rgb, tex.a);
	//Output result with vertex colour factored
	gl_FragColor = v_vColour * colour;
}