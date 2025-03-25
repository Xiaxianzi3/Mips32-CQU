`timescale 1ns/1ns
module tb_result ();

reg clk, rst;
wire stcp, shcp, ds, oe;

initial begin
    clk = 1'b1;
    rst <= 1'b0;

    # 10
    rst <= 1'b1;
end

always #10 clk <= ~clk;

pass_or_fail pass_or_fail(
    .clk    (clk),
    .rst    (rst),
    .stcp   (stcp),
    .shcp   (shcp),
    .ds     (ds),
    .oe     (oe)
);



endmodule