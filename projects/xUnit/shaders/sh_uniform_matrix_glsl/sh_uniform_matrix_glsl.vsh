// This shader tests shader_set_uniform_matrix()/shader_set_uniform_matrix_array() by applying the matrix passed into the shader as a transformation to the position
// Vertex Shader

// Input values
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

// Output values
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms
uniform sampler2D sample; // Texture to use
uniform mat4 u_Matrix; // Matrix passed into the shader


void main()
{
	// Calculate the vertex's position on screen using the world_view_projection matrix, multiplied by the matrix passed into the shader
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = u_Matrix * gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	// Pass the vertex colour and texture coordinates to the fragment shader
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}