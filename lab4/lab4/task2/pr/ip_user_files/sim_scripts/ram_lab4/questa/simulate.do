onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_lab4_opt

do {wave.do}

view wave
view structure
view signals

do {ram_lab4.udo}

run -all

quit -force
