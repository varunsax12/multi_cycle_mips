module dmem
    (input logic clk, we,
    input logic [31:0] addr, writedata,
    output logic [31:0] readdata);

    logic [31:0] RAM [0:64];

    // we are using word aligned so the LS hex of the address will be
    // such that the 2 LSB digits give the byte to fetch
    // can be ignored in byte aligned 
    assign readdata = RAM[addr[31:2]];

    always_ff @(posedge clk)
        if (we) RAM[addr[31:2]] <= writedata;
endmodule
