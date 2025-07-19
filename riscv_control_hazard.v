`include "riscv_define.v"
// branch always not taken
// For simplicity, judge branch condition in Mem Stage
module riscv_control_hazard(
    input [`BranchOpBus] BranchOp,
    input zero_i,
    input less_i,
    output reg BranchTaken,
    output flush // if prediction is wrong, flush IF/ID, ID/EX, EX/MEM
);

assign flush = BranchTaken;

// BranchTaken pull up when prediction is wrong
always@(*) begin
    if(BranchOp == 3'b000) begin
        BranchTaken = 1'b0;
    end else if(BranchOp == 3'b001) begin
        BranchTaken = 1'b1;
    end else if(BranchOp == 3'b010) begin
        BranchTaken = 1'b1;
    end else if(BranchOp == 3'b100 & zero_i == 1'b1) begin
        BranchTaken = 1'b1;
    end else if(BranchOp == 3'b101 & zero_i == 1'b0) begin
        BranchTaken = 1'b1;
    end else if(BranchOp == 3'b110 & less_i == 1'b1) begin
        BranchTaken = 1'b1;
    end else if(BranchOp == 3'b111 & less_i == 1'b0) begin
        BranchTaken = 1'b1;
    end else begin
        BranchTaken = 1'b0; // default case, not taken
    end
end

endmodule