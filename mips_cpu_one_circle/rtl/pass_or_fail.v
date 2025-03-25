
module pass_or_fail (
    input wire  clk ,
    input wire  rst ,

    output wire stcp,
    output wire shcp,
    output wire ds  ,
    output wire oe 
);

wire [31:0]  writedata;
wire [31:0]  dataaddr;
wire         memwrite;
reg  [19:0]  data;
reg  [5:0]   sign;

top top_inst(
   .clk         (clk),
   .rst         (rst),
   .writedata   (writedata),
   .dataaddr    (dataaddr),
   .memwrite    (memwrite)
);

seg_595_dynamic seg_595_dynamic_inst(
    .sys_clk     (clk),
    .sys_rst_n   (rst),
    .data        (data),
    .point       (6'b000_000),
    .seg_en      (1'b1),
    .sign        (1'b0),
    .stcp        (stcp),
    .shcp        (shcp),
    .ds          (ds),
    .oe          (oe) 
);

always @(posedge clk) begin
	if(memwrite) begin
		if(dataaddr == 84 & writedata == 7) begin
			data <= 20'd7;
            sign <= 6'b000_000;
        end
		else if(dataaddr !== 80) begin 
            data <= 20'd0;
            sign <= 6'b111_111;
        end
	end
end
endmodule