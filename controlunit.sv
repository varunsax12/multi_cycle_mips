module controlunit
    (input logic clk, reset,
    input logic [5:0] opcode, funct,
	input logic [31:0] Instr,
    output logic IorD, MemWrite, IRWrite, RegDst, MemtoReg, RegWrite, ALUSrcA, Branch, PCWrite,
    output logic [1:0] ALUSrcB, PCSrc,
    output logic [2:0] ALUControl);

    typedef enum logic [3:0] {FETCH, DECODE, MEMADR, MEMREAD, MEMWRITEBACK, MEMWRITE, EXECUTE, ALUWRITEBACK, BRANCH, ADDIEXECUTE, ADDIWRITEBACK, JUMP} statetype;
    statetype [3:0] state, nextstate;

    // parameters for op code decode
    parameter RTPYE = 6'b000000;
    parameter LW    = 6'b100011;
    parameter SW    = 6'b101011;
    parameter BEQ   = 6'b000100;
    parameter ADDI  = 6'b001000;
    parameter J     = 6'b000010;

    // parameters for funct decode
    parameter ADD   = 6'b100000;
    parameter SUB   = 6'b100010;
    parameter AND   = 6'b100100;
    parameter OR    = 6'b100101;
    parameter SLT   = 6'b101010;

    logic [15:0] controls;
    logic [1:0] ALUOp;

    // asyc reset
    always_ff @(posedge clk or posedge reset)
        begin
            if(reset) state <= FETCH;
            else state <= nextstate;
        end

    // default cases set to fetch to ensure the FSM does not get stuck
    always_comb
        begin
            case(state)
                FETCH         :   nextstate <= DECODE;
                DECODE        :   case (opcode)
                                      LW       :    nextstate <= MEMADR;
                                      SW       :    nextstate <= MEMADR;
                                      RTPYE    :    nextstate <= EXECUTE;
                                      BEQ      :    nextstate <= BRANCH;
                                      ADDI     :    nextstate <= ADDIEXECUTE;
                                      J        :    nextstate <= JUMP;
                                      default  :    nextstate <= FETCH;
                                  endcase
                MEMADR        :   case (opcode)
                                      LW       :    nextstate <= MEMREAD;
                                      SW       :    nextstate <= MEMWRITE;
                                      default  :    nextstate <= FETCH;
                                  endcase
                MEMREAD       :   nextstate <= MEMWRITEBACK;
                MEMWRITEBACK  :   nextstate <= FETCH;
                MEMWRITE      :   nextstate <= FETCH;
                EXECUTE       :   nextstate <= ALUWRITEBACK;
                ALUWRITEBACK  :   nextstate <= FETCH;
                BRANCH        :   nextstate <= FETCH;
                ADDIEXECUTE   :   nextstate <= ADDIWRITEBACK;
                ADDIWRITEBACK :   nextstate <= FETCH;
                JUMP          :   nextstate <= FETCH;
                default       :   nextstate <= FETCH;
            endcase
        end

    // decode logic for control signals

    assign {PCWrite,MemWrite,IRWrite,RegWrite,ALUSrcA,Branch,IorD,MemtoReg,RegDst,ALUSrcB,PCSrc,ALUOp} = controls;

    always_comb
        begin
            case(state)
                FETCH          :    controls <= 15'b1010_00000_0100_00;
                DECODE         :    controls <= 15'b0000_00000_1100_00;
                MEMADR         :    controls <= 15'b0000_10000_1000_00;
                MEMREAD        :    controls <= 15'b0000_00100_0000_00;
                MEMWRITEBACK   :    controls <= 15'b0001_00010_0000_00;
                MEMWRITE       :    controls <= 15'b0100_00100_0000_00;
                EXECUTE        :    controls <= 15'b0000_10000_0000_10;
                ALUWRITEBACK   :    controls <= 15'b0001_00001_0000_00;
                BRANCH         :    controls <= 15'b0000_11000_0001_01;
                ADDIEXECUTE    :    controls <= 15'b0000_10000_1000_00;
                ADDIWRITEBACK  :    controls <= 15'b0001_00000_0000_00;
                JUMP           :    controls <= 15'b1000_00000_0010_00;
                default        :    controls <= 15'b0000_xxxxx_xxxx_xx;
            endcase
        end

    // decode logic for the ALU => ALUControl

    always_comb
        begin
            case(ALUOp)
                2'b00    :    ALUControl <= 3'b010; //add
                2'b01    :    ALUControl <= 3'b110; //sub
                2'b10    :    case(funct)
                                  ADD    :    ALUControl <= 3'b010;
                                  SUB    :    ALUControl <= 3'b110;
                                  AND    :    ALUControl <= 3'b000;
                                  OR     :    ALUControl <= 3'b001;
                                  SLT    :    ALUControl <= 3'b111;
                                  default    :    ALUControl <= 3'bxxx;
                              endcase
                default  :    ALUControl <= 3'bxxx;
            endcase
        end

endmodule
