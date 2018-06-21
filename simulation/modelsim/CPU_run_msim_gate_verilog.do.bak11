transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {CPU.vo}

vlog -vlog01compat -work work +incdir+/home/pedro/odilon/mips/32bitsRegister {/home/pedro/odilon/mips/32bitsRegister/reg32bits_TB.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  reg32bits_TB

add wave *
view structure
view signals
run -all
