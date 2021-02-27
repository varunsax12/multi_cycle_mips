module multi_cycle_mips
    (input logic clk, reset,
    output logic memwrite,
    output logic [31:0] writedata, addr);

    logic [31:0] readdata;
    // NOTE: pc is not required in this block, it is only connected for debugging
    logic [31:0] pc;

    // mips controller
    mips    mp    (.clk(clk), .reset(reset), .readdata(readdata), .writedata(writedata), .addr(addr), .memwrite(memwrite), .pc(pc));
    // mem block
    mem    mem1    (.clk(clk), .we(memwrite), .addr(addr), .wd(writedata), .rd(readdata));

endmodule
