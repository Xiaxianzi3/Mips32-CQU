module mips (
    input wire          clk,
    input wire          rst,
    input wire  [31:0]  instruction,
    input wire  [31:0]  readdata,

    output wire [31:0]  pc,
    output wire         memwrite,
    output wire [31:0]  aluout,
    output wire [31:0]  writedata
);

wire memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero, overflow;
wire[2:0] alucontrol;

controller controller_inst(
    .op          (instruction[31:26]),
    .funct       (instruction[ 5: 0]),
    .zero        (zero),

    .memtoreg    (memtoreg),
    .memwrite    (memwrite),
    .pcsrc       (pcsrc),
    .alusrc      (alusrc),
    .regdst      (regdst),
    .regwrite    (regwrite),
    .jump        (jump),
    .alucontrol  (alucontrol)
);

datapath datapath_inst(
    .clk             (clk),
    .rst             (rst),   
    .memtoreg        (memtoreg),
    .pcsrc           (pcsrc),
    .alusrc          (alusrc),
    .regdst          (regdst),
    .regwrite        (regwrite),
    .jump            (jump),
    .alucontrol      (alucontrol),
    .instruction     (instruction),
    .readdata        (readdata),

    .overflow        (overflow),
    .zero            (zero),
    .pc              (pc),
    .aluout          (aluout),
    .writedata       (writedata)
);

endmodule