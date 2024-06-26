//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D sample;

void main()
{
    gl_FragColor = v_vColour * texture2D( sample, v_vTexcoord );
}
