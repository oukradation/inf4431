onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ram_lab4 -pli "C:/Xilinx/Vivado/2016.4/lib/win64.o/libxil_vsim.dll" -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_5 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ram_lab4 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ram_lab4.udo}

run -all

endsim

quit -force