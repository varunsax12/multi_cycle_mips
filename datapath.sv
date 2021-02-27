module datapath
    (input logic clk, reset, IorD, MemWrite, IRWrite, RegDst, MemtoReg, RegWrite, ALUSrcA, Branch, PCWrite,
    input logic [1:0] ALUSrcB, PCSrc,
    input logic [2:0] alucontrol,
    input logic [31:0] readdata,
    output logic [31:0] addr, pc, aluout, writedata, Instr);

    logic [31:0] pcnext, Adr, srca, srcb, memrd, MemData, rfwd3in, SignImm, rfrd1out, rfrd2out, ALUSrcaIn, ALUSrcbIn, SignImmShift, ALUResult, jumpshift, PCJump;
    logic PCEn, Zero;
    logic [4:0] rfa3in;

    // program counter logic
    dff_en     #(32)    pcff    (.clk(clk), .enable(PCEn), .reset(reset), .d(pcnext), .q(pc));
    mux2x1              memin   (.ina(pc), .inb(aluout), .control(IorD), .outdata(Adr));

    // memory segment
    // replace the mem block
    assign writedata = srcb;
    assign memrd     = readdata;
    assign addr      = Adr;

    //mem            mem1    (.clk(clk), .we(MemWrite), .addr(addr), .wd(writedata), .rd(readdata));
    dff_en     #(32)   memrdff  (.clk(clk), .enable(IRWrite), .reset(reset), .d(memrd), .q(Instr));
    dff        #(32)   memdatff (.clk(clk), .reset(reset), .d(memrd), .q(MemData));

    // register file segment
    mux2x1     #(5)    a3mux    (.ina(Instr[20:16]), .inb(Instr[15:11]), .control(RegDst), .outdata(rfa3in));
    mux2x1     #(32)   wd3mux   (.ina(aluout), .inb(MemData), .control(MemtoReg), .outdata(rfwd3in));
    regfile            rf       (.clk(clk), .we(RegWrite), .a1(Instr[25:21]), .a2(Instr[20:16]), .a3(rfa3in), .wd3(rfwd3in), .rd1(rfrd1out), .rd2(rfrd2out));
    signext            signext1 (.data(Instr[15:0]), .outdata(SignImm));
    dff        #(32)   srcadff  (.clk(clk), .reset(reset), .d(rfrd1out), .q(srca));
    dff        #(32)   srcbdff  (.clk(clk), .reset(reset), .d(rfrd2out), .q(srcb));

    // alu segment
    mux2x1     #(32)   srcamux  (.ina(pc), .inb(srca), .control(ALUSrcA), .outdata(ALUSrcaIn));
    shiftleft          sl       (.indata(SignImm), .outdata(SignImmShift));
    mux4x1             srcbmux  (.in1(srcb), .in2(32'b100), .in3(SignImm), .in4(SignImmShift), .control(ALUSrcB), .outdata(ALUSrcbIn));
    alu                mipsalu  (.control(alucontrol), .srca(ALUSrcaIn), .srcb(ALUSrcbIn), .zero(Zero), .result(ALUResult));

    assign PCEn = (Zero&Branch)|PCWrite;

    // memwriteback region
    dff        #(32)  wbdff     (.clk(clk), .reset(reset), .d(ALUResult), .q(aluout));
    shiftleft         sljump    (.indata({6'b000000, Instr[25:0]}), .outdata(jumpshift));
    assign PCJump = {Instr[31:28], jumpshift[27:0]};
    mux4x1            wbmux     (.in1(ALUResult), .in2(aluout), .in3(PCJump), .in4(32'bz), .control(PCSrc), .outdata(pcnext));

endmodule
