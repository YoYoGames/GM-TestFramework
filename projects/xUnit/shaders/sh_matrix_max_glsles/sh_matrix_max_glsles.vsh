
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
    
	//float matrix_max = float(MATRIX_MAX);
	float matrix_max = float(MATRICES_MAX);
    v_vColour = vec4(matrix_max / 255.0, matrix_max / 255.0, matrix_max / 255.0, 1.0);
    v_vTexcoord = in_TextureCoord;
}
