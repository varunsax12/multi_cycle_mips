// read-operation only supported

module imem
    (input logic [5:0] addr,
    output logic [31:0] rd);

    logic [31:0] RAM [0:63];

    initial
        $readmemh("memfile.dat", RAM);

    assign rd = RAM[addr];
endmodule
