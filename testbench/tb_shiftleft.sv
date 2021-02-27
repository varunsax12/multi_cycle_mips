module tb_shiftleft();
    logic [31:0] indata, outdata;

    shiftleft uut(.indata(indata), .outdata(outdata));

    initial
        begin
            $monitor("indata = %b, outdata = %b", indata, outdata);
            indata = 32'hFFFF_FFFF;
            #5;    
            assert(outdata===32'hFFFF_FFFC) else $error("case 1 failed");
            $finish;
        end
endmodule
