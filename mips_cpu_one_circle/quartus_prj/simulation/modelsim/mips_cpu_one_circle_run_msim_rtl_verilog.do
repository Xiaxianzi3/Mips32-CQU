transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {e:/program files/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {e:/program files/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {e:/program files/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {e:/program files/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {e:/program files/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {e:/program files/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/seg_dynamic.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/seg_595_dynamic.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/pass_or_fail.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/hc595_ctrl.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/bcd_8421.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/top.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/sign_extend.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/shift_left_2.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/regfile.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/mux2.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/mips.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/maindec.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/flopr.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/datapath.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/controller.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/aludec.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/alu.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/rtl {E:/MyCPU/git/mips_cpu_one_circle/rtl/adder.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/ip_core/data_memory {E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/ip_core/data_memory/data_memory.v}
vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/ip_core/instruction_memory {E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/ip_core/instruction_memory/instruction_memory.v}

vlog -vlog01compat -work work +incdir+E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/../sim {E:/MyCPU/git/mips_cpu_one_circle/quartus_prj/../sim/tb_top.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_top

add wave *
view structure
view signals
run 1 ms
