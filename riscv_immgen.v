`include "riscv_define.v"
module riscv_immgen(
    input [`InstBus] inst_i,
    input [`ExtOpBus] ExtOp,
    output [`RegBus] imm_o
);

wire	[`RegBus]	I_imm;
wire	[`RegBus]	S_imm;
wire	[`RegBus]	B_imm;
wire	[`RegBus]	J_imm;
wire	[`RegBus]	U_imm;

assign	I_imm	= {{20{inst_i[31]}}, inst_i[31:20]};
assign	S_imm	= {{20{inst_i[31]}}, inst_i[31:25], inst_i[11:7]};
assign	B_imm	= {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
assign	J_imm	= {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
assign	U_imm	= {inst_i[31:12], 12'b0};

assign imm_o = 
    (ExtOp == 3'b000) ? I_imm :
    (ExtOp == 3'b010) ? S_imm :
    (ExtOp == 3'b011) ? B_imm :
    (ExtOp == 3'b100) ? J_imm :
    (ExtOp == 3'b001) ? U_imm : 32'b0;

endmodule