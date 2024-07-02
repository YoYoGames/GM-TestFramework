//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform mat4 u_expected_matrix;
uniform mat4 u_initial_matrix_world_view_projection;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = u_initial_matrix_world_view_projection * object_space_pos;
	
	// This shader should be used with an array of rectangles, each representing one value in the array
	// Each rect's red colour value is used as an index to test each value of the array. they must be a multiple of 16 (just to make the index colours more distinct when debugging)
	int rect_index = int(in_Colour.r * 255.0) / 16;
	int row = int(mod(float(rect_index), 4.0));
	int column = rect_index / 4;
	
	float expected_value = u_expected_matrix[row][column];
	float actual_value = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION][row][column];
	
	v_vColour = vec4((expected_value/2.0) + 0.25, (actual_value/2.0) + 0.25, (actual_value/2.0) + 0.25, 1.0);
	
    v_vTexcoord = in_TextureCoord;
}