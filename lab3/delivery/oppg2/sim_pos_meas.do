vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg2/pos_meas_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg2/motor_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg2/motor_beh.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg2/pos_meas_arch.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg2/tb_pos_meas.vhd

vsim work.tb_pos_meas



add wave -position insertpoint sim:/tb_pos_meas/*
add wave -position insertpoint sim:/tb_pos_meas/motor_tb/*


run 10 us