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
	
	// This shader should be used with an array of rectangles, each representing one value in the array
	// Each rect's red colour value is used as an index to test each value of the array. they must be a multiple of 16 (just to make the index colours more distinct when debugging)
	int rect_index = int(in_Colour.r * 255.0) / 16;
	int row = int(mod(float(rect_index), 4.0));
	int column = rect_index / 4;
	
	vec4 value = gm_Lights_Direction[rect_index];
	
	v_vColour = vec4((value.x * 2.0) + 0.5, (value.y * 2.0) + 0.5, (value.z * 2.0) + 0.5, value.w);
		
    v_vTexcoord = in_TextureCoord;
}