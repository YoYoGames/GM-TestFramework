
struct VertexShaderInput {
    float4 vPosition : POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};


struct VertexShaderOutput {
    float4 vPosition : SV_POSITION;
    float4 vColor    : COLOR0;
    float2 vTexcoord : TEXCOORD0;
};

VertexShaderOutput main(VertexShaderInput INPUT) {
    VertexShaderOutput OUTPUT;

    float4 matrixWVP = mul(gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION], INPUT.vPosition);

	float2 rem = (float2(INPUT.vColor.x, INPUT.vColor.z) * 255.0) % 2.0;
	int corner_id = int(dot(float2(1.0, 2.0), rem));
	
	if (corner_id == 0) {
		OUTPUT.vColor = float4(1,0,0,1);
	} 
	else if (corner_id == 1) {
		OUTPUT.vColor = float4(0,0,1,1);
	} 
	else if (corner_id == 2) {
		OUTPUT.vColor = float4(0,1,0,1);
	} 
	else if (corner_id == 3){
		OUTPUT.vColor = float4(1,1,0,1);
	}
	
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}