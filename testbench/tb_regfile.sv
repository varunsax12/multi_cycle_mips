module tb_regfile();
    logic we, clk;
    logic [4:0] a1, a2, a3;
    logic [31:0] rd1, rd2, wd3;

    regfile uut(.clk(clk), .we(we), .a1(a1), .a2(a2), .a3(a3), .rd1(rd1), .rd2(rd2), .wd3(wd3));

    always
        begin
            clk = 0; #10;
            clk = 1; #10;
        end

    initial
        begin
        #5;
        we = 1; a3 = 5'b0001; wd3 = 32'hAAAA_BBBB;
        #20;
        we = 1; a3 = 5'b0010; wd3 = 32'hBBBB_AAAA;
        #10;
        we = 0; a1 = 5'b00001; a2 = 5'b00010;
        // syncronization delays
        #5;
        assert(rd1===32'hAAAA_BBBB) else $error("write 1 failed");
        assert(rd2===32'hBBBB_AAAA) else $error("write 2 failed");
        // attempt to write on reg 0
        #10;
        we = 1; a3 = 0; wd3 = 32'h1111_2222;
        #10;
        we = 0; a1 = 0;
        // syncronization delays
        #5;
        assert(rd1===0) else $error("reg 0 check failed");
        $finish;
        end
endmodule
