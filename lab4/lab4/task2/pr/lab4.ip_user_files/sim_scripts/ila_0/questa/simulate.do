onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "C:/Xilinx/Vivado/2016.4/lib/win64.o/libxil_vsim.dll" -lib xil_defaultlib ila_0_opt

do {wave.do}

view wave
view structure
view signals

do {ila_0.udo}

run -all

quit -force
