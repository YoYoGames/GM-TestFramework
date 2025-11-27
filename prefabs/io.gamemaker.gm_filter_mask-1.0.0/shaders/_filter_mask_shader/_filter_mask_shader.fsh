/*
	"Alpha Mask" by Xor

	This is a simple alpha mask shader, that takes the RGB color from the base texture
	and the alpha channel from a separate alpha mask texture.

	This can be used to clip a surface into a specific shape.
	That mask starting value and ending value can be changed as needed (a bit like fog).
*/
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

//Mask alpha starting value
uniform float g_MaskStart;
//Mask alpha ending value
uniform float g_MaskEnd;
//Mask texture to extra alpha from (only alpha used)
uniform sampler2D g_MaskTexture;
//uniform vec2 g_MaskTextureTexelSize;

void main()
{
	//Sample base colour
	vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord);
	//Sample mask for alpha component
	float alpha = texture2D(g_MaskTexture, v_vTexcoord).r;

	//Multiply by new alpha range
	colour *= smoothstep(g_MaskStart, g_MaskEnd, alpha);

	//Output the result with v_vColour
    gl_FragColor = v_vColour * colour;
}
