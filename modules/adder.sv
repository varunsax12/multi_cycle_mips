module adder
    (input logic[31:0] ina, inb,
    output logic[31:0] outdata);

    assign outdata = ina+inb;
endmodule
