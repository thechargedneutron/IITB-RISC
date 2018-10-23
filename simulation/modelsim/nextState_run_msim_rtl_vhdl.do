transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/nextState.vhd}

