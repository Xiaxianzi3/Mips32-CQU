module controller (
    input  wire [5:0]   op          ,
    input  wire [5:0]   funct       ,
    input  wire         zero        ,

    output wire         memtoreg    ,
    output wire         memwrite    ,
	output wire         pcsrc       ,
    output wire         alusrc      ,
	output wire         regdst      ,
    output wire         regwrite    ,
	output wire         jump        ,
	output wire [2:0]   alucontrol
);

wire[1:0] aluop;
wire branch;

maindec maindec_inst(
    .op          (op      ),

    .memtoreg    (memtoreg),
    .memwrite    (memwrite),
    .branch      (branch  ),
    .alusrc      (alusrc  ),
    .regdst      (regdst  ),
    .regwrite    (regwrite),
    .jump        (jump    ),
    .aluop       (aluop   )
);


aludec aludec_inst(
    .funct      (funct),
    .aluop      (aluop),

    .alucontrol (alucontrol)
    );

assign pcsrc = branch & zero;
endmodule