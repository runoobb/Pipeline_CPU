`include "riscv_define.v"

module riscv_id_ex (
    input clk,
    input rst,
    // some of control signal do not need to pass to next stage
    input RegWr_in,
    input [`BranchOpBus] BranchOp_in,
    input MemtoReg_in,
    input MemWr_in,
    input [`MemOpBus] MemOp_in,
    input [`AluctrBus] AluCtr_in,

    input ALUAsrc_in, // pass to next stage(EX), where forward value are mux
    input [`AluBsrcBus] ALUBsrc_in,
    input [`RegAddrBus] rs1_idx_in, // need to store, used by forward unit
    input [`RegAddrBus] rs2_idx_in,
    input [`RegBus] rs1_val_in,
    input [`RegBus] rs2_val_in, // rs2_val is used by load/store instruction, need to pass to next stage
    input [`RegAddrBus] rd_idx_in,
    input [`RegBus] pc_in,

    input [`RegBus] imm_in,
    input [4:0] opcode_in,

    input stall,
    input flush,
    
    output reg RegWr_out,
    output reg [`BranchOpBus] BranchOp_out,
    output reg MemtoReg_out,
    output reg MemWr_out,
    output reg [`MemOpBus] MemOp_out,
    output reg [`AluctrBus] AluCtr_out,
    output reg  ALUAsrc_out,
    output reg [`AluBsrcBus] ALUBsrc_out,
    output reg [`RegAddrBus] rs1_idx_out,
    output reg [`RegAddrBus] rs2_idx_out,
    output reg [`RegBus] rs1_val_out,
    output reg [`RegBus] rs2_val_out,
    output reg [`RegAddrBus] rd_idx_out,
    output reg [`InstAddrBus] pc_out,
    output reg [`RegBus] imm_out,
    output reg [4:0] opcode_out
);

always@(posedge clk or posedge rst) begin
    if(rst) begin
        RegWr_out <= 1'b0;
        BranchOp_out <= 3'h0;
        MemtoReg_out <= 1'b0;
        MemWr_out <= 1'b0;
        MemOp_out <= 3'b000;
        AluCtr_out <= 4'b0000;
        ALUAsrc_out <= 1'b0;
        ALUBsrc_out <= 2'b00;
        rs1_idx_out <= 5'h0;
        rs2_idx_out <= 5'h0;
        rs1_val_out <= 32'h0;
        rs2_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
        pc_out <= 32'h0;
        imm_out <= 32'h0;
        opcode_out <= 5'h0;
    end else if(stall) begin
        RegWr_out <= RegWr_out;
        BranchOp_out <= BranchOp_out;
        MemtoReg_out <= MemtoReg_out;
        MemWr_out <= MemWr_out;
        MemOp_out <= MemOp_out;
        AluCtr_out <= AluCtr_out;
        ALUAsrc_out <= ALUAsrc_out;
        ALUBsrc_out <= ALUBsrc_out;
        rs1_idx_out <= rs1_idx_out;
        rs2_idx_out <= rs2_idx_out;
        rs1_val_out <= rs1_val_out;
        rs2_val_out <= rs2_val_out;
        rd_idx_out <= rd_idx_out;
        pc_out <= pc_out;
        imm_out <= imm_out;
        opcode_out <= opcode_out;
    end else if(flush) begin
        RegWr_out <= 1'b0;
        BranchOp_out <= 3'h0;
        MemtoReg_out <= 1'b0;
        MemWr_out <= 1'b0;
        MemOp_out <= 3'b000;
        AluCtr_out <= 4'b0000;
        ALUAsrc_out <= 1'b0;
        ALUBsrc_out <= 2'b00;
        rs1_idx_out <= 5'h0;
        rs2_idx_out <= 5'h0;
        rs1_val_out <= 32'h0;
        rs2_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
        pc_out <= 32'h0;
        imm_out <= 32'h0;
        opcode_out <= 5'h0;
    end else begin
        // Normal operation, pass values to next stage
        RegWr_out <= RegWr_in;
        BranchOp_out <= BranchOp_in;
        MemtoReg_out <= MemtoReg_in;
        MemWr_out <= MemWr_in;
        MemOp_out <= MemOp_in;
        AluCtr_out <= AluCtr_in;
        ALUAsrc_out <= ALUAsrc_in;
        ALUBsrc_out <= ALUBsrc_in;
        rs1_idx_out <= rs1_idx_in;
        rs2_idx_out <= rs2_idx_in;
        rs1_val_out <= rs1_val_in;
        rs2_val_out <= rs2_val_in;
        rd_idx_out <= rd_idx_in;
        pc_out <= pc_in;
        imm_out <= imm_in;
        opcode_out <= opcode_in;
    end
end

endmodule