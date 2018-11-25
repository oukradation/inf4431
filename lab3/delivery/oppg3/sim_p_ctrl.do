vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/p_ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/motor_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/pos_meas_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/motor_beh.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/p_ctrl.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/pos_meas_arch.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg3/tb_p_ctrl.vhd

vsim work.tb_p_ctrl


add wave -position insertpoint sim:/tb_p_ctrl/*

run 10 us