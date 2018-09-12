#! /bin/bash

vsim work.tb_hex2seg7
add wave sim:/tb_first/a_n          
add wave sim:/tb_first/abcdefgdec_n 
add wave sim:/tb_first/disp3        
add wave sim:/tb_first/disp2        
add wave sim:/tb_first/disp1        
add wave sim:/tb_first/disp0        
add wave sim:/tb_first/indata       
add wave sim:/tb_first/dec          
run 1 us
