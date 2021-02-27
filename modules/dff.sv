module dff
    #(parameter WIDTH=32)
    (input logic clk, reset,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q);

    // parameter WIDTH_1 = WIDTH-1;
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset) q <= 32'h0000_0000;
            else q <= d;
        end
endmodule
