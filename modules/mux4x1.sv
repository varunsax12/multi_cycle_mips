module mux4x1
    (input logic [31:0] in1, in2, in3, in4,
    input logic [1:0] control,
    output logic [31:0] outdata);

    always_comb
        begin
            case(control)
                0 : outdata = in1;
                1 : outdata = in2;
                2 : outdata = in3;
                3 : outdata = in4;
            endcase    
        end
endmodule
