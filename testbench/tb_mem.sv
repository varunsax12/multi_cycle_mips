module tb_mem();
    logic clk, we;
    logic [31:0] addr, wd, rd;

    mem    uut (.clk(clk), .we(we), .addr(addr), .wd(wd), .rd(rd));

    always
        begin
            clk = 0; #10;
            clk = 1; #10;
        end

    initial
        begin    
            $monitor("addr = %h, mem data = %h", addr,     rd);
            addr = 32'b0;
            #15;
            for(int i=0; i<=20; i++)
                begin
                    #10;
                    addr = addr+4;    
                end
            $finish;
        end
endmodule
