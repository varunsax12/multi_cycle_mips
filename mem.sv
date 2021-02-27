// same memory for data and intruction
// it will still read the  instruction using readmem
// POSSIBLE ENHANCEMENT:
//    1. Add the data displacement logic to ensure that the write operation does not overwrite instructions
//    2. Add support for byte addressable

module mem
    (input logic clk, we,
    input logic [31:0] addr, wd,
    output logic [31:0] rd);
    
    logic [31:0] RAM [0:4*1023];

    initial
        $readmemh("/user/a0230100/verilog_training/multi_cycle_mips/memfile.dat", RAM);

    // NOTE: input address ignores the last 2 bits to ignore the byte addressing part
    // It also syncs up with the PC with increments by 4 to keep the design simple
    always_ff @(posedge clk)
        begin
            if(we) RAM[addr[31:2]] <= wd;
        end

    assign rd = RAM[addr[31:2]];
endmodule
