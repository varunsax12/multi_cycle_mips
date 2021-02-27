module tb_signext();
    logic [15:0] indata;
    logic [31:0] outdata;

    signext uut(.data(indata), .outdata(outdata));

    initial
        begin
            $monitor("indata = %b, outdata = %b", indata, outdata);
            indata = 16'hFFFF;
            #5;
            assert(outdata===32'hFFFF_FFFF) else $error("case 1 failed");
            #5;
            indata = 16'h8880;
            #5;
            assert(outdata===32'hFFFF_8880) else $error("case 2 failed");
            #5;
            indata = 16'h777F;
            #5;
            assert(outdata===32'h0000_777F) else $error("case 3 failed");
            $finish;
        end
endmodule
