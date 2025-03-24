`timescale 1ns/1ns
module tb_top ();

reg clk, rst;    
wire[31:0] writedata, dataaddr;
wire memwrite;

top top_inst(
   .clk         (clk),
   .rst         (rst),
   .writedata   (writedata),
   .dataaddr    (dataaddr),
   .memwrite    (memwrite)
);

initial begin
    clk = 1'b1;
    rst <= 1'b0;
    # 10
    rst <= 1'b1;
end

always #10 clk = ~clk;
	
always @(negedge clk) begin
	if(memwrite) begin
		/* code */
		if(dataaddr === 84 & writedata === 7) begin
			/* code */
			$display("Simulation succeeded");
			$stop;
		end else if(dataaddr !== 80) begin
			/* code */
			$display("Simulation Failed");
			$stop;
		end
	end
end
endmodule