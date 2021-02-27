module mips
    (input logic clk, reset,
    input logic [31:0] readdata,
    output logic [31:0] writedata, pc, addr,
    output logic memwrite);

    logic [31:0] aluout, Instr;
    logic [2:0] alucontrol;
    logic IorD, IRWrite, RegDst, MemtoReg, RegWrite, ALUSrcA, Branch, PCWrite;
    logic [1:0] ALUSrcB, PCSrc;

    datapath    dp (.clk(clk), .reset(reset), .IorD(IorD), .MemWrite(memwrite), .IRWrite(IRWrite), .RegDst(RegDst), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .Branch(Branch), .PCWrite(PCWrite), .ALUSrcB(ALUSrcB), .PCSrc(PCSrc), .alucontrol(alucontrol), .readdata(readdata), .addr(addr), .pc(pc), .aluout(aluout), .writedata(writedata), .Instr(Instr));

    controlunit    cu (.clk(clk), .reset(reset), .opcode(Instr[31:26]), .funct(Instr[5:0]), .IorD(IorD), .MemWrite(memwrite), .IRWrite(IRWrite), .RegDst(RegDst), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .Branch(Branch), .PCWrite(PCWrite), .ALUSrcB(ALUSrcB), .PCSrc(PCSrc), .ALUControl(alucontrol), .Instr(Instr));

endmodule
