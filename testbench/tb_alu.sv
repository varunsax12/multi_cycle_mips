module tb_alu();
    logic [31:0] srca, srcb, result;
    logic [2:0] control;
    logic zero;

    alu uut(.srca(srca), .srcb(srcb), .result(result), .control(control), .zero(zero));

    initial
        begin
            $monitor("srca = %b, srcb = %b, result = %b, control = %b, zero = %b", srca, srcb, result, control, zero);
            #5;
            srca = 32'h1111_1111; srcb = 32'h0000_000F;
            control = 3'b000;
            #5;
            assert(result===32'h0000_0001) else $error("case and failed");
            control = 3'b001;
            #5;
            assert(result===32'h1111_111F) else $error("case or failed");
            control = 3'b010;
            #5;
            assert(result===32'h1111_1120) else $error("case add failed");
            control = 3'b110;
            #5;
            assert(result===32'h1111_1102) else $error("case sub failed");
            control = 3'b111;
            srca = 1; srcb = 2;
            #5;
            assert(result===1) else $error("case slt failed");
            srca = 1; srcb = 1; control = 3'b110;
            #5;
            assert(result===0) else $error("case sub 0 failed");
            assert(zero===1) else $error("case sub 0 flag failed");
            $finish;
        end
endmodule
