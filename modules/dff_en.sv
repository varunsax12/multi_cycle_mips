// dff with enable logic

module dff_en
    #(parameter WIDTH=32)
    (input logic clk, enable, reset,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q);

    // parameter WIDTH_1 = WIDTH-1;
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset) q <= 32'h0000_0000;
            else if(enable) q <= d;
        end
endmodule
