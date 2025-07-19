`include "riscv_define.v"

module riscv_mem_wb(
    input clk,
    input rst,
    input MemtoReg_in,
    input RegWr_in,
    input [`RegBus] AluP_val_in,
    input [`RegBus] MemRd_val_in,
    input [`RegAddrBus] rd_idx_in,
    input stall,
    input flush,
    output reg MemtoReg_out,
    output reg RegWr_out,
    output reg [`RegBus] AluP_val_out,
    output reg [`RegBus] MemRd_val_out,
    output reg [`RegAddrBus] rd_idx_out
);

always@(posedge clk or posedge rst) begin
    if(rst) begin
        MemtoReg_out <= 1'b0;
        RegWr_out <= 1'b0;
        AluP_val_out <= 32'h0;
        MemRd_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
    end else if(stall) begin
        MemtoReg_out <= MemtoReg_out;
        RegWr_out <= RegWr_out;
        AluP_val_out <= AluP_val_out;
        MemRd_val_out <= MemRd_val_out;
        rd_idx_out <= rd_idx_out;
    end else if(flush) begin
        MemtoReg_out <= 1'b0;
        RegWr_out <= 1'b0;
        AluP_val_out <= 32'h0;
        MemRd_val_out <= 32'h0;
        rd_idx_out <= 5'h0;
    end else begin
        MemtoReg_out <= MemtoReg_in;
        RegWr_out <= RegWr_in;
        AluP_val_out <= AluP_val_in;
        MemRd_val_out <= MemRd_val_in;
        rd_idx_out <= rd_idx_in;
    end    
end

endmodule