module shiftleft
    #(parameter SHIFT=2)
    (input logic [31:0] indata,
    output logic [31:0] outdata);

    //can also be used as multiple by 2^SHIFT

    assign outdata = indata<<SHIFT;
endmodule
