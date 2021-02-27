module signext
    (input logic [15:0] data,
    output logic [31:0] outdata);

    assign outdata = {{16{data[15]}}, data};
endmodule
