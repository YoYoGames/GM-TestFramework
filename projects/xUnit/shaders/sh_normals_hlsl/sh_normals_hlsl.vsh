//
// Simple passthrough vertex shader (HLSL 11)
//

struct VertexShaderInput {
    float4 vPosition : POSITION;
	float3 vNormal	 : NORMAL;
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
	
	float3 scaled_normal = (INPUT.vNormal / 2.0) + 0.5;
	
    OUTPUT.vPosition = matrixWVP;
    OUTPUT.vColor    = float4(scaled_normal.x, scaled_normal.y, scaled_normal.z, 1.0);
    OUTPUT.vTexcoord = INPUT.vTexcoord; 

    return OUTPUT;
}