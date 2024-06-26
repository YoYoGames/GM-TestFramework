//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	vec2 rem = mod(in_Colour.rb * 255., 2.);
	int corner_id = int(dot(vec2(1., 2.), rem));
	
	if (corner_id == 0) {
		v_vColour = vec4(1,0,0,1);
	} 
	else if (corner_id == 1) {
		v_vColour = vec4(0,0,1,1);
	} 
	else if (corner_id == 2) {
		v_vColour = vec4(0,1,0,1);
	} 
	else if (corner_id == 3){
		v_vColour = vec4(1,1,0,1);
	}
	
    v_vTexcoord = in_TextureCoord;
}