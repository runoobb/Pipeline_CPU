`include "riscv_define.v"
module riscv_if_id(
    input clk,
    input rst,
    input [`RegBus] inst_i,
    input [`RegBus] pc_i,
    input stall,
    input flush,
    output reg [`RegBus] inst_o,
    output reg [`RegBus] pc_o
);

always@(posedge clk or posedge rst) begin
    if(rst) begin
        inst_o <= 32'h0;
        pc_o <= 32'h0;
    end else if(stall) begin
        inst_o <= inst_o;
        pc_o <= pc_o;
    end else if(flush) begin
        inst_o <= 32'h0;
        pc_o <= 32'h0;
    end else begin
        inst_o <= inst_i;
        pc_o <= pc_i;
    end
end

endmodule