`include "riscv_define.v"
module riscv_forward(
    input EX_MEM_RegWr,
    input MEM_WB_RegWr, //
    input MEM_WB_MemtoReg, // marks load instructions
    input [`RegAddrBus] EX_MEM_rd_idx,
    input [`RegAddrBus] MEM_WB_rd_idx,
    input [4:0] IF_ID_opcode,
    input [`RegAddrBus] IF_ID_rs1_idx,
    input [`RegAddrBus] IF_ID_rs2_idx,
    input [4:0] ID_EX_opcode,
    input [`RegAddrBus] ID_EX_rs1_idx,
    input [`RegAddrBus] ID_EX_rs2_idx,
    input [`RegBus] forward_EX_MEM_ALU,
    input [`RegBus] forward_MEM_WB_ALU,
    input [`RegBus] forward_MEM_WB_MEM,
    output [`RegBus] forward_EX_MEM,
    output [`RegBus] forward_MEM_WB,
    output [2:0] forwardA,
    output [2:0] forwardB
);

    assign forward_EX_MEM = forward_EX_MEM_ALU;
    assign forward_MEM_WB = MEM_WB_MemtoReg ? forward_MEM_WB_MEM : forward_MEM_WB_ALU;

    // ForwardA_C1 and ForwardA_C2, under these two conditions, val is forwarded to EX stage
    // ForwardA_C3 is high when val is forwarded to ID stage
    wire forwardA_C1;
    wire forwardA_C2;
    wire forwardA_C3;
    assign forwardA_C1 = EX_MEM_RegWr & (EX_MEM_rd_idx != 5'b00000) & (EX_MEM_rd_idx == ID_EX_rs1_idx);
    assign forwardA_C2 = MEM_WB_RegWr & (MEM_WB_rd_idx != 5'b00000) & ~forwardA_C1 & (MEM_WB_rd_idx == ID_EX_rs1_idx);
    assign forwardA_C3 = MEM_WB_RegWr & (MEM_WB_rd_idx != 5'b00000) & (MEM_WB_rd_idx == IF_ID_rs1_idx);
    assign forwardA[1:0] = forwardA_C1 ? 2'b10 : 
                      forwardA_C2 ? 2'b01 : 2'b00;
    assign forwardA[2] = forwardA_C3 ? 1'b1 : 1'b0;

    // when I type instruction, do not forward B
    wire forwardB_C1; 
    wire forwardB_C2; 
    wire forwardB_C3;
    assign forwardB_C1 = EX_MEM_RegWr & (EX_MEM_rd_idx != 5'b00000) & (EX_MEM_rd_idx == ID_EX_rs2_idx) & (ID_EX_opcode != 5'b00100); // I-Type instruction do not forward(addi, sw, lw), controller signal pipelined to alu will block(mux not choose)
    assign forwardB_C2 = MEM_WB_RegWr & (MEM_WB_rd_idx != 5'b00000) & ~forwardB_C1 & (MEM_WB_rd_idx == ID_EX_rs2_idx) & (ID_EX_opcode != 5'b00100);
    assign forwardB_C3 = MEM_WB_RegWr & (MEM_WB_rd_idx != 5'b00000) & (MEM_WB_rd_idx == IF_ID_rs2_idx) & (IF_ID_opcode != 5'b00100); 
    assign forwardB[1:0] = forwardB_C1 ? 2'b10 : 
                      forwardB_C2 ? 2'b01 : 2'b00;
    assign forwardB[2] = forwardB_C3 ? 1'b1 : 1'b0;

endmodule