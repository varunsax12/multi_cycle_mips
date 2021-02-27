module alu
    (input logic [2:0] control,
    input logic [31:0] srca, srcb,
    output logic zero,
    output logic [31:0] result);

    always_comb
        begin
            case(control)
                3'b000 : result = srca&srcb;
                3'b001 : result = srca|srcb;
                3'b010 : result = srca+srcb;
                3'b110 : result = srca-srcb;
                3'b111 : result = (srca<srcb)?1:0;
            endcase
        end

    assign zero = (result===0)?1:0;
endmodule
