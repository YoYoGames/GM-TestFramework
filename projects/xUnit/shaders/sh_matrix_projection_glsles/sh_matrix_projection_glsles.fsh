//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform mat4 u_expected_matrix_view;

void main()
{
    gl_FragColor = v_vColour;
}