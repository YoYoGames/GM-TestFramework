// This shader is intended to be used with 4x2 a grid of rectangles, each with a unique red colour value to be used as an index.
// It will test gm_Lights_Colour by attempting to set each rectangle to the colour of each light.
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
	
	// Get the index of the current rectangle via it's red value
	int rect_index = int(in_Colour.r * 255.0);
	
	// Get the light colour for the light corresponding to that index
	vec4 value = gm_Lights_Colour[rect_index];
	
	//// This code is used to create expected image/buffer for comparison, with all lights set
	//if (rect_index == 0) {
	//	value = vec4(1.0,0.0,0.0,1.0);
	//} else if (rect_index == 1) {
	//	value = vec4(0.0,1.0,0.0,1.0);
	//} else if (rect_index == 2) {
	//	value = vec4(0.0,0.0,1.0,1.0);
	//} else if (rect_index == 3) {
	//	value = vec4(1.0,1.0,1.0,1.0);
	//} else if (rect_index == 4) {
	//	value = vec4(0.0,1.0,1.0,1.0);	
	//} else if (rect_index == 5) {
	//	value = vec4(1.0,0.0,1.0,1.0);		
	//} else if (rect_index == 6) {
	//	value = vec4(1.0,1.0,0.0,1.0);
	//} else if (rect_index == 7) {
	//	value = vec4(0.0,0.0,0.0,1.0);
	//}
	
	// Set vertex colour to value from light colour
	v_vColour = vec4(value.r, value.g, value.b, value.a);
}