module top (
    input  wire         clk,
    input  wire         rst,

    output wire [31:0]  writedata,
    output wire [31:0]  dataaddr,
    output wire         memwrite
);
    
wire [31:0] pc, instruction, readdata;

mips mips_inst(
    .clk            (clk),
    .rst            (rst),
    .instruction    (instruction),
    .readdata       (readdata),

    .pc             (pc),
    .memwrite       (memwrite),
    .aluout         (dataaddr),
    .writedata      (writedata)
    );

instruction_memory	instruction_memory_inst (
	.aclr       ( ~rst ),
	.address    ( pc[7:0] ),
	.clock      ( ~clk ),
	.data       (  ),
	.wren       ( 1'b0 ),
	.q          ( instruction )
	);

data_memory	data_memory_inst (
	.aclr ( ~rst ),
	.address ( dataaddr ),
	.clock ( clk ),
	.data ( writedata ),
	.wren ( memwrite ),
	.q ( readdata )
	);

// ----

endmodule