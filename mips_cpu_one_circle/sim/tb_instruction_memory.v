`timescale 1ns/1ns
module tb_instruction_memory();

reg clk, rst;
reg [7:0] addr;
wire [31:0] instruction;

initial begin
    clk = 1'b1;
    rst <= 1'b0;
    # 10
    rst <= 1'b1;
end

always @(posedge clk or negedge rst) begin
    if (rst == 1'b0)
        addr <= 8'd0;
    else if (addr == 8'd255)
        addr <= 8'd0;
    else 
        addr <= addr + 1'b1;
end

always #10 clk = ~clk;

instruction_memory	instruction_memory_inst (
	.aclr ( ~rst ),
	.address ( addr ),
	.clock ( clk ),
	.data (  ),
	.wren ( 1'b0 ),
	.q ( instruction )
	);

endmodule