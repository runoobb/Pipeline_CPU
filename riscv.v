`include "riscv_define.v"
module riscv(

	input wire				 clk,
	input wire				 rst,         // high is reset
	
    // inst_mem
	input wire[31:0]         inst_i,      // instruction from inst_mem
	output wire[31:0]        inst_addr_o, // pc
	output wire              inst_ce_o,  // enable to inst_mem

    // data_mem
	input wire[31:0]         data_i,      // load data from data_mem
	output wire              data_we_o,	 // write enable to data_mem
    output wire              data_ce_o,  // enable to data_mem
	output wire[31:0]        data_addr_o,  // address to data_mem
	output wire[31:0]        data_o       // store data to  data_mem

);

//  instance your module  below


assign inst_ce_o = 1'b1; // always enable instruction memory
assign data_ce_o = 1'b1; // always enable data memory



wire [`RegBus] npc;
wire [`RegBus] pc;
wire zero;
wire less;
wire [`RegBus] imm; // imm input to id_ex reg, or forward to npc at ID stage

wire [`RegBus] rs1_val;
wire [`RegBus] rs2_val;
assign inst_addr_o = pc;

wire data_hazard_stall;
wire data_hazard_flush;
assign data_hazard_flush = data_hazard_stall;
wire control_hazard_flush;


// IF stage

wire [`RegBus] inst_if_id_o;
wire [`RegBus] pc_if_id_o;

riscv_if_id u0_riscv_if_id(
	.clk(clk),
	.rst(rst),
	.inst_i(inst_i),
	.pc_i(pc),
	.stall(data_hazard_stall),
	.flush(control_hazard_flush),
	.inst_o(inst_if_id_o),
	.pc_o(pc_if_id_o)
);


// ID stage
wire [4:0] inst_rs1_idx_field = inst_if_id_o[19:15];
wire [4:0] inst_rs2_idx_field = inst_if_id_o[24:20];
wire [4:0] inst_rd_idx_field = inst_if_id_o[11:7];
wire [`ExtOpBus] ext_op;
wire reg_wr_id_ex_i;
wire [`BranchOpBus] branch_op_id_ex_i;
wire mem_to_reg_id_ex_i;
wire mem_wr_id_ex_i;
wire [`MemOpBus] mem_op_id_ex_i;
wire [`AluctrBus] alu_ctr_id_ex_i;

wire reg_wr_id_ex_o;
wire [`BranchOpBus] branch_op_id_ex_o;
wire mem_to_reg_id_ex_o;
wire mem_wr_id_ex_o;
wire [`MemOpBus] mem_op_id_ex_o;
wire [`AluctrBus] alu_ctr_id_ex_o;


wire alu_asrc;
wire [`AluBsrcBus] alu_bsrc;

riscv_control u0_riscv_control (
	.inst_i(inst_if_id_o),
	.ExtOp(ext_op),
	.RegWr(reg_wr_id_ex_i),
	.BranchOp(branch_op_id_ex_i),
	.MemtoReg(mem_to_reg_id_ex_i),
	.MemWr(mem_wr_id_ex_i),
	.MemOp(mem_op_id_ex_i),
	.ALUAsrc(alu_asrc),
	.ALUBsrc(alu_bsrc),
	.ALUctr(alu_ctr_id_ex_i)
);

riscv_immgen u0_riscv_immgen(
	.inst_i(inst_if_id_o),
	.ExtOp(ext_op),
	.imm_o(imm)
);


wire [`RegBus] rs1_val_id_ex_o;
wire [`RegBus] rs2_val_id_ex_o;

wire [`RegAddrBus] rs1_idx_id_ex_o;
wire [`RegAddrBus] rs2_idx_id_ex_o;
wire [`RegAddrBus] rd_idx_id_ex_o;
wire [`RegBus] pc_id_ex_o;
wire [`RegBus] imm_id_ex_o;
wire [4:0] opcode_id_ex_o;

wire alu_asrc_id_ex_o;
wire [`AluBsrcBus] alu_bsrc_id_ex_o;

wire [`RegBus] rs1_val_id_ex_i;
wire [`RegBus] rs2_val_id_ex_i;

wire [2:0] forwardA;
wire [2:0] forwardB;
wire [`RegBus] forward_EX_MEM_o;
wire [`RegBus] forward_MEM_WB_o;

assign rs1_val_id_ex_i = forwardA[2] == 1'b1 ? forward_MEM_WB_o : rs1_val;
assign rs2_val_id_ex_i = forwardB[2] == 1'b1 ? forward_MEM_WB_o : rs2_val;


riscv_id_ex u0_riscv_id_ex(
	.clk(clk),
	.rst(rst),
	.RegWr_in(reg_wr_id_ex_i),
	.BranchOp_in(branch_op_id_ex_i),
	.MemtoReg_in(mem_to_reg_id_ex_i),
	.MemWr_in(mem_wr_id_ex_i),
	.MemOp_in(mem_op_id_ex_i),
	.AluCtr_in(alu_ctr_id_ex_i),
	.ALUAsrc_in(alu_asrc),
	.ALUBsrc_in(alu_bsrc),
	.rs1_idx_in(inst_rs1_idx_field),
	.rs2_idx_in(inst_rs2_idx_field),
	.rs1_val_in(rs1_val_id_ex_i), //
	.rs2_val_in(rs2_val_id_ex_i),
	.rd_idx_in(inst_rd_idx_field),
	.pc_in(pc_if_id_o), //
	.imm_in(imm), //
	.opcode_in(inst_if_id_o[6:2]), //
	.stall(),
	.flush(data_hazard_flush | control_hazard_flush),
	.RegWr_out(reg_wr_id_ex_o),
	.BranchOp_out(branch_op_id_ex_o),
	.MemtoReg_out(mem_to_reg_id_ex_o),
	.MemWr_out(mem_wr_id_ex_o),
	.MemOp_out(mem_op_id_ex_o),
	.AluCtr_out(alu_ctr_id_ex_o),
	.ALUAsrc_out(alu_asrc_id_ex_o),
	.ALUBsrc_out(alu_bsrc_id_ex_o),
	.rs1_idx_out(rs1_idx_id_ex_o),
	.rs2_idx_out(rs2_idx_id_ex_o),
	.rs1_val_out(rs1_val_id_ex_o), //
	.rs2_val_out(rs2_val_id_ex_o),
	.rd_idx_out(rd_idx_id_ex_o),
	.pc_out(pc_id_ex_o), //
	.imm_out(imm_id_ex_o), //
	.opcode_out(opcode_id_ex_o)
);

// EX stage
wire [`RegBus] alu_p_val_ex_mem_i;


wire [`RegBus] rs1_val_alu_i;
wire [`RegBus] rs2_val_alu_i;

assign rs1_val_alu_i = forwardA[1:0] == 2'b00 ? rs1_val_id_ex_o :
	(forwardA[1:0] == 2'b01 ? forward_MEM_WB_o : 
	(forwardA[1:0] == 2'b10 ? forward_EX_MEM_o : rs1_val_id_ex_o));

assign rs2_val_alu_i = forwardB[1:0] == 2'b00 ? rs2_val_id_ex_o :
	(forwardB == 2'b01 ? forward_MEM_WB_o : 
	(forwardB == 2'b10 ? forward_EX_MEM_o : rs2_val_id_ex_o));

wire [`RegBus] alu_a_val_ex_mem_i;
wire [`RegBus] alu_b_val_ex_mem_i;
assign alu_a_val_ex_mem_i = alu_asrc_id_ex_o ? pc_id_ex_o : rs1_val_alu_i;
assign alu_b_val_ex_mem_i = alu_bsrc_id_ex_o == 2'b00 ? rs2_val_alu_i : 
	(alu_bsrc_id_ex_o == 2'b01 ? imm_id_ex_o : 
	(alu_bsrc_id_ex_o == 2'b10 ? 32'h4 : 32'h0));

riscv_alu u0_riscv_alu(
	.alu_ctr_i(alu_ctr_id_ex_o),
	.alu_a_i(alu_a_val_ex_mem_i),
	.alu_b_i(alu_b_val_ex_mem_i),
	.zero_o(zero), // used to judge branch at npc
	.less_o(less),
	.alu_p_o(alu_p_val_ex_mem_i)
);


wire reg_wr_ex_mem_o;
wire [`BranchOpBus] branch_op_ex_mem_o;
wire mem_to_reg_ex_mem_o;
wire mem_wr_ex_mem_o;
wire [`RegAddrBus] rd_idx_ex_mem_o;
wire [`MemOpBus] mem_op_ex_mem_o;
wire [`RegBus] rs1_val_ex_mem_o;
wire [`RegBus] rs2_val_ex_mem_o;
wire [`RegBus] pc_ex_mem_o;
wire [`RegBus] alu_p_val_ex_mem_o;

wire zero_ex_mem_o;
wire less_ex_mem_o;
wire [`RegBus] imm_ex_mem_o;




riscv_ex_mem u0_riscv_ex_mem(
	.clk(clk),
	.rst(rst),
	.RegWr_in(reg_wr_id_ex_o),
	.BranchOp_in(branch_op_id_ex_o),
	.MemtoReg_in(mem_to_reg_id_ex_o),
	.MemWr_in(mem_wr_id_ex_o),
	.MemOp_in(mem_op_id_ex_o),
	.rs1_val_in(rs1_val_alu_i), // need to pass in following pipeline | e.g. B Type inst
	.rs2_val_in(rs2_val_alu_i), // need to pass in following pipeline | e.g. S Type inst
	.pc_in(pc_id_ex_o), //
	.AluP_val_in(alu_p_val_ex_mem_i),
	.rd_idx_in(rd_idx_id_ex_o),
	.zero_in(zero),
	.less_in(less),
	.imm_in(imm_id_ex_o), //
	.stall(),
	.flush(control_hazard_flush),
	.RegWr_out(reg_wr_ex_mem_o),
	.BranchOp_out(branch_op_ex_mem_o),
	.MemtoReg_out(mem_to_reg_ex_mem_o),
	.MemWr_out(mem_wr_ex_mem_o),
	.MemOp_out(mem_op_ex_mem_o),
	.rs1_val_out(rs1_val_ex_mem_o), //
	.rs2_val_out(rs2_val_ex_mem_o),
	.pc_out(pc_ex_mem_o), //
	.AluP_val_out(alu_p_val_ex_mem_o),
	.rd_idx_out(rd_idx_ex_mem_o),
	.zero_out(zero_ex_mem_o),
	.less_out(less_ex_mem_o),
	.imm_out(imm_ex_mem_o)
);

// MEM stage
wire mem_to_reg_mem_wb_o;
wire reg_wr_mem_wb_o;
wire [`RegBus] alu_p_val_mem_wb_o;
wire [`RegBus] mem_rd_val_mem_wb_o;
wire [`RegAddrBus] rd_idx_mem_wb_o;

assign data_we_o = mem_wr_ex_mem_o; // write enable to data memory
assign data_addr_o = alu_p_val_ex_mem_o;
assign data_o = rs2_val_ex_mem_o; // store data to data_mem

riscv_mem_wb u0_riscv_mem_wb(
	.clk(clk),
	.rst(rst),
	.MemtoReg_in(mem_to_reg_ex_mem_o),
	.RegWr_in(reg_wr_ex_mem_o),
	.AluP_val_in(alu_p_val_ex_mem_o),
	.MemRd_val_in(data_i),
	.rd_idx_in(rd_idx_ex_mem_o),
	.stall(),
	.flush(),
	.MemtoReg_out(mem_to_reg_mem_wb_o),
	.RegWr_out(reg_wr_mem_wb_o),
	.AluP_val_out(alu_p_val_mem_wb_o),
	.MemRd_val_out(mem_rd_val_mem_wb_o),
	.rd_idx_out(rd_idx_mem_wb_o)
);

// WB stage
wire [`RegBus] rd_val;
assign rd_val = mem_to_reg_mem_wb_o ? mem_rd_val_mem_wb_o : alu_p_val_mem_wb_o;
riscv_regfile u0_riscv_regfile(
	.clk(clk),
	.rst(rst),
	.rs1_idx_i(inst_rs1_idx_field),
	.rs2_idx_i(inst_rs2_idx_field),
	.rd_idx_i(rd_idx_mem_wb_o),
	.rd_val_i(rd_val),
	.rd_we_i(reg_wr_mem_wb_o),
	.rs1_val_o(rs1_val),
	.rs2_val_o(rs2_val)
);


// when RAW(ALU) dependent instructions detected at IF-ID / MEM-WB stage(2 insts in between), but need to rule out other two cases(they are detected at later pipeline stage), so we need to detect other 2 RAW dependency in advance


riscv_forward u0_riscv_forward(
	.EX_MEM_RegWr(reg_wr_ex_mem_o),
	.MEM_WB_RegWr(reg_wr_mem_wb_o),
	.MEM_WB_MemtoReg(mem_to_reg_mem_wb_o),
	.EX_MEM_rd_idx(rd_idx_ex_mem_o),
	.MEM_WB_rd_idx(rd_idx_mem_wb_o),
	.IF_ID_opcode(inst_if_id_o[6:2]),
	// update at July 19th, 2025
	.IF_ID_rs1_idx(inst_rs1_idx_field),
	.IF_ID_rs2_idx(inst_rs2_idx_field),
	//
	.ID_EX_opcode(opcode_id_ex_o),
	.ID_EX_rs1_idx(rs1_idx_id_ex_o),
	.ID_EX_rs2_idx(rs2_idx_id_ex_o),
	.forward_EX_MEM_ALU(alu_p_val_ex_mem_o),
	.forward_MEM_WB_ALU(alu_p_val_mem_wb_o),
	.forward_MEM_WB_MEM(mem_rd_val_mem_wb_o),
	.forward_EX_MEM(forward_EX_MEM_o),
	.forward_MEM_WB(forward_MEM_WB_o),
	.forwardA(forwardA),
	.forwardB(forwardB)
);

riscv_data_hazard u0_riscv_data_hazard(
	.ID_EX_MemtoReg(mem_to_reg_id_ex_o),
	.ID_EX_rd_idx(rd_idx_id_ex_o),
	.IF_ID_rs1_idx(inst_rs1_idx_field),
	.IF_ID_rs2_idx(inst_rs2_idx_field),
	.stall(data_hazard_stall)
);

wire branch_taken;

riscv_control_hazard u0_riscv_control_hazard(
	.BranchOp(branch_op_ex_mem_o),
	.zero_i(zero_ex_mem_o),
	.less_i(less_ex_mem_o),
	.BranchTaken(branch_taken),
	.flush(control_hazard_flush)
);

// IF stage
riscv_npc u0_riscv_npc(
	.clk(clk),
	.rst(rst),
	.branch_taken(branch_taken),
	.branch_op_ex_mem_i(branch_op_ex_mem_o),
	.imm_ex_mem_i(imm_ex_mem_o),
	.rs1_val_ex_mem_i(rs1_val_ex_mem_o),
	.pc_ex_mem_i(pc_ex_mem_o),
	.pc_i(pc),
	.stall(data_hazard_stall)
);

endmodule