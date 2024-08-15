// This shader tests the enable_corner_id() function by attempting to get each corner ID and colour them differently
// Vertex Shader

// Input values
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

// Output values
varying vec4 v_vColour;


void main()
{
	// Calculate the vertex's position on screen using the world_view_projection matrix
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	// When enable_corner_id() is enabled, the corner ID is stored in the lowest bit of the red and blue component of the vertex's colour
	// Get the lowest bit of the vertex's red and blue values by getting their remainder when divided by 2
	vec2 rem = mod(in_Colour.rb * 255., 2.);
	// Then get the corner ID by multiplying the lowest bit of red by 1, the lowest bit of blue by 2, then adding them together to get their decimal value
	// (a dot product is used here to do this effeciently)
	int corner_id = int(dot(vec2(1., 2.), rem));
	
	// Set corner 0 (top-left) to be red
	if (corner_id == 0) {
		v_vColour = vec4(1,0,0,1);
	} 
	// Set corner 1 (top-right) to be blue
	else if (corner_id == 1) {
		v_vColour = vec4(0,0,1,1);
	} 
	// Set corner 2 (bottom-right) to be green
	else if (corner_id == 2) {
		v_vColour = vec4(0,1,0,1);
	} 
	// Set corner 2 (bottom-left) to be yellow
	else if (corner_id == 3){
		v_vColour = vec4(1,1,0,1);
	}
}