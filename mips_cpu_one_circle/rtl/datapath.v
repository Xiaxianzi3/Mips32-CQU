// 数据通路
module datapath (
    input  wire         clk         ,
    input  wire         rst,
    input  wire         memtoreg    ,   // 0:aluresult              1:memdata
    input  wire         pcsrc       ,   // 0:pc+4                   1:branch_addr = (pc+4) + (SignImm << 2)
    input  wire         alusrc      ,   // 0:RD2                    1:SignImm
    input  wire         regdst      ,   // 0:WriteBackToRt[20:16]   1:WriteBackToRd[15:11]
    input  wire         regwrite    ,   // 0:                       1:regfile write en
    input  wire         jump        ,   // 0:                       1:jump
    input  wire [ 2:0]  alucontrol  ,
    input  wire [31:0]  instruction ,
    input  wire [31:0]  readdata    ,   

    output wire         overflow    ,
    output wire         zero        ,
    output wire [31:0]  pc          ,
    output wire [31:0]  aluout      ,
    output wire [31:0]  writedata
);
    
wire [ 4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;


flopr #(32) flopr_inst(
    .clk (clk   ),
    .rst (rst   ),
    .d   (pcnext),
    
    .q   (pc     )
);

adder pc_plus_4_adder_inst(
    .a  (pc),
    .b  (32'd4),
    
    .y  (pcplus4)
);

shift_left_2 shift_left_2_inst(
    .a  (signimm),
    
    .y  (signimmsh)
);

adder pc_branch_adder_inst(
    .a  (pcplus4),
    .b  (signimmsh),
    
    .y  (pcbranch)
);

// beq
mux2 #(32) pcbrmux_inst(      
    .d0 (pcplus4),
    .d1 (pcbranch),
    .s  (pcsrc),
    
    .y  (pcnextbr)
);

// jump  pc+4高四位 拼接26位字地址
mux2 #(32) pcmux_inst(
    .d0 (pcnextbr),
    .d1 ({pcplus4[31:28], instruction[25:0], 2'b00}),
    .s  (jump),
    
    .y  (pcnext)    
);

regfile rf(
    .clk (clk                ),
    .we3 (regwrite           ),
    .ra1 (instruction[25:21] ),
    .ra2 (instruction[20:16] ),
    .wa3 (writereg),
    .wd3 (result),
    .rd1 (srca),
    .rd2 (writedata)
);

mux2 #(5) wr_mux_inst(
    .d0 (instruction[20:16]),
    .d1 (instruction[15:11]),
    .s  (regdst),
    
    .y  (writereg)
);

// mem or aluout
mux2 #(32) resmux_inst(
    .d0 (aluout),
    .d1 (readdata),
    .s  (memtoreg),
    
    .y  (result)
);

sign_extend sign_extend_inst(
    .a  (instruction[15:0]),
    .y  (signimm)
);

mux2 #(32) srcbmux_inst(
    .d0 (writedata),
    .d1 (signimm),
    .s  (alusrc),
    
    .y  (srcb)
);

alu alu_inst(
    .a       (srca),
    .b       (srcb),
    .op      (alucontrol),

    .y       (aluout),
    .overflow(overflow),
    .zero    (zero)
);
endmodule