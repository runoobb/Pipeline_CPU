`include "riscv_define.v"
module riscv_npc (
    input clk,
    input rst,
    input branch_taken,
    input [`BranchOpBus] branch_op_ex_mem_i,
    input [`RegBus] imm_ex_mem_i,
    input [`RegBus] rs1_val_ex_mem_i,
    input [`InstAddrBus] pc_ex_mem_i, 
    output reg [`InstAddrBus] pc_i,
    input stall
);

reg PCAsrc_o;
reg PCBsrc_o;
reg [`InstAddrBus] npc;

always@(posedge clk or posedge rst) begin
    if(rst) begin
        pc_i <= 32'h0; // Reset PC to 0
    end else if(stall) begin
        pc_i <= pc_i;
    end else if(branch_taken) begin
        pc_i <= npc;
    end else
        pc_i <= pc_i + 32'h4;
end

// handle branch taken case: pc_i <= npc
always@(*) begin
    if(branch_op_ex_mem_i == 3'b001) begin
        npc = pc_ex_mem_i + imm_ex_mem_i;
    end else if(branch_op_ex_mem_i == 3'b010) begin
        npc = rs1_val_ex_mem_i + imm_ex_mem_i; 
    end else if(branch_op_ex_mem_i == 3'b100) begin
        npc = pc_ex_mem_i + imm_ex_mem_i;
    end else if(branch_op_ex_mem_i == 3'b101) begin
        npc = pc_ex_mem_i + imm_ex_mem_i;
    end else if(branch_op_ex_mem_i == 3'b110) begin
        npc = pc_ex_mem_i + imm_ex_mem_i;
    end else if(branch_op_ex_mem_i == 3'b111) begin
        npc = pc_ex_mem_i + imm_ex_mem_i;
    end
end


endmodule