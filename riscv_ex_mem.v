`include "riscv_define.v"

module riscv_ex_mem(
    input clk,
    input rst,
    input RegWr_in,
    input [`BranchOpBus] BranchOp_in,
    input MemtoReg_in,
    input MemWr_in,
    input [`MemOpBus] MemOp_in,
    input [`RegBus] rs1_val_in,
    input [`RegBus] rs2_val_in,
    input [`RegBus] pc_in,
    input [`RegBus] AluP_val_in,
    input [`RegAddrBus] rd_idx_in,
    input zero_in,
    input less_in,
    input [`RegBus] imm_in,
    input stall,
    input flush,
    output reg RegWr_out,
    output reg [`BranchOpBus] BranchOp_out,
    output reg MemtoReg_out,
    output reg MemWr_out,
    output reg [`MemOpBus] MemOp_out,
    output reg [`RegBus] rs1_val_out, //
    output reg [`RegBus] rs2_val_out,
    output reg [`RegBus] pc_out, //
    output reg [`RegBus] AluP_val_out,
    output reg [`RegAddrBus] rd_idx_out,
    output reg zero_out,
    output reg less_out,
    output reg [`RegBus] imm_out
);

always@(posedge clk or posedge rst) begin
    if(rst) begin
        RegWr_out <= 1'b0;
        BranchOp_out <= 3'b000;
        MemtoReg_out <= 1'b0;
        MemWr_out <= 1'b0;
        MemOp_out <= 3'b000;
        rs1_val_out <= 32'h0;
        rs2_val_out <= 32'h0;
        pc_out <= 32'h0;
        AluP_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
        zero_out <= 1'b0;
        less_out <= 1'b0;
        imm_out <= 32'h0;
    end else if(stall) begin
        RegWr_out <= RegWr_out;
        BranchOp_out <= BranchOp_out;
        MemtoReg_out <= MemtoReg_out;
        MemWr_out <= MemWr_out;
        MemOp_out <= MemOp_out;
        rs1_val_out <= rs1_val_out;
        rs2_val_out <= rs2_val_out;
        pc_out <= pc_out;
        AluP_val_out <= AluP_val_out;
        rd_idx_out <= rd_idx_out;
        zero_out <= zero_out;
        less_out <= less_out;
        imm_out <= imm_out;
    end else if(flush) begin
        RegWr_out <= 1'b0;
        BranchOp_out <= 3'b000;
        MemtoReg_out <= 1'b0;
        MemWr_out <= 1'b0;
        MemOp_out <= 3'b000;
        rs1_val_out <= 32'h0;
        rs2_val_out <= 32'h0;
        pc_out <= 32'h0;
        AluP_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
        zero_out <= 1'b0;
        less_out <= 1'b0;
        imm_out <= 32'h0;
    end else begin
        RegWr_out <= RegWr_in;
        BranchOp_out <= BranchOp_in;
        MemtoReg_out <= MemtoReg_in;
        MemWr_out <= MemWr_in;
        MemOp_out <= MemOp_in;
        rs1_val_out <= rs1_val_in;
        rs2_val_out <= rs2_val_in;
        pc_out <= pc_in;
        AluP_val_out <= AluP_val_in;
        rd_idx_out <= rd_idx_in;
        zero_out <= zero_in;
        less_out <= less_in;
        imm_out <= imm_in;
    end
end

endmodule