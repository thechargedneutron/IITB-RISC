transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/resetState.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/memoryWrite.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/MemoryAddressInput.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/instructionEnable.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/memory.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/ALULogic.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/fiveBitRegister.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/TempRegisterInputB.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/TempRegisterInputA.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/sixteenBitRegister.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/SignExtended9spl.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/signExtended9.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/signExtended6.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/registerFileWrite.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/RegisterFileInputD3.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/RegisterFileInputC.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/RegisterFileInputA.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/registerFileAccess.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/Register7Input.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/PriorityEncoder.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/PEModifyEnable.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/PEEnable.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/PCinput.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/main.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/eightBitRegister.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/oneBitRegister.vhd}
vcom -93 -work work {/home/geek-at-work/Desktop/EE-309-Project-1/nextState.vhd}

