#! /bin/bash
vsim work.tb_pos_seg7_ctrl
add wave *
add wave sim:/tb_pos_seg7_ctrl/UUT/pos_d0
add wave sim:/tb_pos_seg7_ctrl/UUT/pos_d1
add wave sim:/tb_pos_seg7_ctrl/UUT/sp_d0
add wave sim:/tb_pos_seg7_ctrl/UUT/sp_d1
run 30 ms
