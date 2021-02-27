module regfile
    (input logic clk, we,
    input logic [31:0] wd3,
    input logic [4:0] a1, a2, a3,
    output logic [31:0] rd1, rd2);

    logic [31:0] rf [0:31];


    // async read and write on neg edge
    // register 0 reserved for value 0

    assign rd1 = (a1 != 0)?rf[a1]:0;
    assign rd2 = (a2 != 0)?rf[a2]:0;

    always_ff @(posedge clk)
        if (we) rf[a3] <= wd3;

endmodule
