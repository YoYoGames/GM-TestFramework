varying vec2 v_vTexcoord;

#define u_surface1 gm_BaseTexture
uniform sampler2D u_surface2;

void main() {
	gl_FragColor = abs(texture2D(u_surface1, v_vTexcoord) - texture2D(u_surface2, v_vTexcoord));
}
