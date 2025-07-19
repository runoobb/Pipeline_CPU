`include "riscv_define.v"
module riscv_regfile(
	input				clk,
	input				rst,
	input		[`RegAddrBus]	rs1_idx_i,
	input		[`RegAddrBus]	rs2_idx_i,
	input		[`RegAddrBus]	rd_idx_i,
	input				rd_we_i,
	input		[`RegBus]	rd_val_i,
	output		[`RegBus]	rs1_val_o,
	output		[`RegBus]	rs2_val_o
);
    reg [`RegBus] regfile [31:0]; // Register array

    // write registers
    generate 
        genvar i;
        for(i = 0; i < 32; i = i+1) begin
            if(i == 0) begin
                always@(posedge clk or posedge rst) begin
                    if (rst) begin
                        regfile[i] <= 0; // x0 is always 0
                    end else if (rd_we_i && (rd_idx_i == i)) begin
                        regfile[i] <= 0;
                    end
                end
            end else begin
                always@(posedge clk or posedge rst) begin
                    if (rst) begin
                        regfile[i] <= 0; // Reset all registers to 0
                    end else if (rd_we_i && (rd_idx_i == i)) begin
                        regfile[i] <= rd_val_i; // Write value to register
                    end
                end
            end 
        end
    endgenerate

    // read registers
    assign rs1_val_o = regfile[rs1_idx_i];
    assign rs2_val_o = regfile[rs2_idx_i];
endmodule