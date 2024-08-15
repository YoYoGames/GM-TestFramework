// This shader tests the enable_corner_id() function by attempting to get each corner ID and colour them differently
// Vertex Shader

// Input values
struct VertexShaderInput {
    float4 vPosition : POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

// Output values
struct VertexShaderOutput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


VertexShaderOutput main(VertexShaderInput INPUT) {
    VertexShaderOutput OUTPUT;
	
	// Calculate the vertex's position on screen using the world_view_projection matrix
    float4 matrixWVP = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], INPUT.vPosition);
	
	// When enable_corner_id() is enabled, the corner ID is stored in the lowest bit of the red and blue component of the vertex's colour
	// Get the lowest bit of the vertex's red and blue values by getting their remainder when divided by 2
	float2 rem = (float2(INPUT.vColor.x, INPUT.vColor.z) * 255.0) % 2.0;
	// Then get the corner ID by multiplying the lowest bit of red by 1, the lowest bit of blue by 2, then adding them together to get their decimal value
	// (a dot product is used here to do this effeciently)
	int corner_id = int(dot(float2(1.0, 2.0), rem));
	
	// Set corner 0 (top-left) to be red
	if (corner_id == 0) {
		OUTPUT.vColor = float4(1,0,0,1);
	} 
	// Set corner 1 (top-right) to be blue
	else if (corner_id == 1) {
		OUTPUT.vColor = float4(0,0,1,1);
	} 
	// Set corner 2 (bottom-right) to be green
	else if (corner_id == 2) {
		OUTPUT.vColor = float4(0,1,0,1);
	} 
	// Set corner 2 (bottom-left) to be yellow
	else if (corner_id == 3){
		OUTPUT.vColor = float4(1,1,0,1);
	}
	
	// Pass the vertex position and texture coordinates to the fragment shader
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 
	
    return OUTPUT;
}