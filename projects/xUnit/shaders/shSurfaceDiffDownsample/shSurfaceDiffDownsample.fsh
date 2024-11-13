varying vec2 v_vTexcoord;

uniform vec2 u_texture_size;

vec4 fetchPixel(sampler2D texture, vec2 coord, vec2 textureSize) {
	vec2 uv = coord / textureSize;
	if (uv.x < 1.0 && uv.y < 1.0) {
		return texture2D(texture, uv);
	}
	return vec4(0.0);
}

void main() {
	vec2 texCoord = floor(gl_FragCoord.xy) * 2.0;
	gl_FragColor = fetchPixel(gm_BaseTexture, texCoord, u_texture_size)
		+ fetchPixel(gm_BaseTexture, texCoord + vec2(1.0, 0.0), u_texture_size)
		+ fetchPixel(gm_BaseTexture, texCoord + vec2(1.0, 1.0), u_texture_size)
		+ fetchPixel(gm_BaseTexture, texCoord + vec2(0.0, 1.0), u_texture_size);
}
