module tb_dff();
    logic [31:0] d, q;
    logic clk, reset;
    dff uut(.d(d), .q(q), .clk(clk), .reset(reset));

    initial
        begin
            reset = 1;
            #5;
            reset = 0;
            d = 32'h1111_1111;
            #10;
            assert (q===d) else $error("case 1 failed");
            #10;
            d = 32'hAAAA_BBBB;
            #10;
            assert (q===d) else $error("case 2 failed");
            #10;
            reset = 1;
            #10;
            assert (q===32'h0000_0000) else $error("case reset failed");
            // end sims using finish
            $finish;
        end

    always
        begin
            clk = 0; #10;
            clk = 1; #10;
        end
endmodule
