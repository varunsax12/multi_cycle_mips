module mux2x1
    #(parameter WIDTH=32)
    (input logic [WIDTH-1:0] ina, inb,
    input logic control,
    output logic [WIDTH-1:0] outdata);

    assign outdata = (control)?inb:ina;
endmodule
