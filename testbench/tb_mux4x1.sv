module tb_mux4x1();
    logic [31:0] in1, in2, in3, in4, outdata;
    logic [1:0] control;

    mux4x1    uut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .control(control), .outdata(outdata));

    initial
        begin
        $monitor("in1 = %b, in2 = %b, in3 = %b, in4 = %b, control = %b, outdata = %b", in1, in2, in3, in4, control, outdata);
        #1;
        in1 = 1; in2 = 2; in3 = 3; in4 = 4;
        control = 0;
        #5;
        assert(outdata===1) else $error("case 1 failed");
        control = 1;
        #5;
        assert(outdata===2) else $error("case 2 failed");
        control = 2;
        #5;
        assert(outdata===3) else $error("case 3 failed");
        control = 3;
        #5;
        assert(outdata===4) else $error("case 4 failed");
        $finish;
        end
endmodule
