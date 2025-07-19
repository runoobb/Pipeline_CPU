`include "riscv_define.v"

// load-on-use hazard(RAW)
module riscv_data_hazard(
    input ID_EX_MemtoReg,
    input [`RegAddrBus] ID_EX_rd_idx,
    input [`RegAddrBus] IF_ID_rs1_idx,
    input [`RegAddrBus] IF_ID_rs2_idx,
    output stall       // output stall to IF, IF/ID, ID/EX
);
    
    assign stall = ID_EX_MemtoReg & (ID_EX_rd_idx == IF_ID_rs1_idx || ID_EX_rd_idx == IF_ID_rs2_idx) & ID_EX_rd_idx != 5'b00000;  // write x0 do not forward

endmodule
