module flopr #(parameter WIDTH = 8)(
    input  wire                 clk ,
    input  wire                 rst ,
    input  wire [WIDTH - 1:0]   d   ,
    
    output reg  [WIDTH - 1:0]   q   
);

always @(posedge clk or negedge rst) begin
    if (rst == 1'b0)
        q <= 0;
    else 
        q <= d;
end

endmodule