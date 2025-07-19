`include "riscv_define.v"

module riscv_control(
    input [`InstBus] inst_i,
    output reg [`ExtOpBus] ExtOp,
    output reg RegWr,
    output reg [`BranchOpBus] BranchOp,
    output reg MemtoReg,
    output reg MemWr,
    output reg [`MemOpBus] MemOp,
    output reg ALUAsrc,
    output reg [`AluBsrcBus] ALUBsrc,
    output reg [`AluctrBus] ALUctr
);

always @(*) begin
	if ((inst_i & `INST_ADD_MASK) == `INST_ADD) begin // add
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_SUB_MASK) == `INST_SUB) begin // sub
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b1000;

	end else if ((inst_i & `INST_XOR_MASK) == `INST_XOR) begin // xor
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0100;

	end else if ((inst_i & `INST_OR_MASK) == `INST_OR) begin // or
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0110;

	end else if ((inst_i & `INST_AND_MASK) == `INST_AND) begin // and
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0111;

	end else if ((inst_i & `INST_SLL_MASK) == `INST_SLL) begin // sll
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0001;

	end else if ((inst_i & `INST_SRL_MASK) == `INST_SRL) begin // srl
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0101;

	end else if ((inst_i & `INST_SRA_MASK) == `INST_SRA) begin // sra
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b1101;

	end else if ((inst_i & `INST_SLT_MASK) == `INST_SLT) begin // slt
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_SLTU_MASK) == `INST_SLTU) begin // sltu
        ExtOp = `ExtOpNone;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b1010;

	end else if ((inst_i & `INST_ADDI_MASK) == `INST_ADDI) begin // addi
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_XORI_MASK) == `INST_XORI) begin // xori
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0100;

	end else if ((inst_i & `INST_ORI_MASK) == `INST_ORI) begin // ori
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0110;

	end else if ((inst_i & `INST_ANDI_MASK) == `INST_ANDI) begin // andi
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0111;

	end else if ((inst_i & `INST_SLLI_MASK) == `INST_SLLI) begin // slli
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0001;

	end else if ((inst_i & `INST_SRLI_MASK) == `INST_SRLI) begin // srli
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0101;

	end else if ((inst_i & `INST_SRAI_MASK) == `INST_SRAI) begin // srai
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b1101;

	end else if ((inst_i & `INST_SLTI_MASK) == `INST_SLTI) begin // slti
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_SLTIU_MASK) == `INST_SLTIU) begin // sltiu
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b1010;

    end else if ((inst_i & `INST_LB_MASK) == `INST_LB) begin // lb
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b1;
        MemWr = 1'b0;
        MemOp = 3'b000;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_LH_MASK) == `INST_LH) begin // lh
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b1;
        MemWr = 1'b0;
        MemOp = 3'b001;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_LW_MASK) == `INST_LW) begin // lw
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b1;
        MemWr = 1'b0;
        MemOp = 3'b010;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_LBU_MASK) == `INST_LBU) begin // lbu
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b1;
        MemWr = 1'b0;
        MemOp = 3'b100;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_LHU_MASK) == `INST_LHU) begin // lhu
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b1;
        MemWr = 1'b0;
        MemOp = 3'b101;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_SB_MASK) == `INST_SB) begin // sb
        ExtOp = 3'b010;
        RegWr = 1'b0;
        BranchOp = 3'b000;
        MemtoReg = 1'b0; //'x
        MemWr = 1'b1;
        MemOp = 3'b000;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_SH_MASK) == `INST_SH) begin // sh
        ExtOp = 3'b010;
        RegWr = 1'b0;
        BranchOp = 3'b000;
        MemtoReg = 1'b0; //'x
        MemWr = 1'b1;
        MemOp = 3'b001;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_SW_MASK) == `INST_SW) begin // sw
        ExtOp = 3'b010;
        RegWr = 1'b0;
        BranchOp = 3'b000;
        MemtoReg = 1'b0; //'x
        MemWr = 1'b1;
        MemOp = 3'b010;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_BEQ_MASK) == `INST_BEQ) begin // beq
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b100;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_BNE_MASK) == `INST_BNE) begin // bne
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b101;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_BLT_MASK) == `INST_BLT) begin // blt
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b110;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_BGE_MASK) == `INST_BGE) begin // bge
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b111;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0010;

	end else if ((inst_i & `INST_BLTU_MASK) == `INST_BLTU) begin // bltu
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b110;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b1010;

	end else if ((inst_i & `INST_BGEU_MASK) == `INST_BGEU) begin // bgeu
        ExtOp = 3'b011;
        RegWr = 1'b0;
        BranchOp = 3'b111;
        MemtoReg = 1'b0; // 'x
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b1010;

	end else if ((inst_i & `INST_JAL_MASK) == `INST_JAL) begin // jal
        ExtOp = 3'b100;
        RegWr = 1'b1;
        BranchOp = 3'b001;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b1;
        ALUBsrc = 2'b10;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_JALR_MASK) == `INST_JALR) begin // jalr
        ExtOp = 3'b000;
        RegWr = 1'b1;
        BranchOp = 3'b010;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b1;
        ALUBsrc = 2'b10;
        ALUctr = 4'b0000;

	end else if ((inst_i & `INST_LUI_MASK) == `INST_LUI) begin // lui
        ExtOp = 3'b001;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0; //'x
        ALUBsrc = 2'b01;
        ALUctr = 4'b0011;

	end else if ((inst_i & `INST_AUIPC_MASK) == `INST_AUIPC) begin // auipc
        ExtOp = 3'b001;
        RegWr = 1'b1;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b1;
        ALUBsrc = 2'b01;
        ALUctr = 4'b0000;

        end else begin
        ExtOp = 3'b000;
        RegWr = 1'b0;
        BranchOp = 3'b000;
        MemtoReg = 1'b0;
        MemWr = 1'b0;
        MemOp = `MemOpNone;

        ALUAsrc = 1'b0;
        ALUBsrc = 2'b00;
        ALUctr = 4'b0000;              
        end
end

endmodule