#! /bin/bash

vsim work.tb_seg7ctrl
add wave sim:/tb_reg/a_n          
add wave sim:/tb_reg/abcdefgdec_n 
add wave sim:/tb_reg/d0
add wave sim:/tb_reg/d1
add wave sim:/tb_reg/d2        
add wave sim:/tb_reg/d3        
add wave sim:/tb_reg/mclk        
add wave sim:/tb_reg/reset        
add wave sim:/tb_reg/load
run 1 us
