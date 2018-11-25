vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/pos_ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/p_ctrl_ent2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/motor_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/pos_meas_ent2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/pos_seg7_ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/motor_beh.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/p_ctrl2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/pos_meas_arch2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/pos_ctrl_arch.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg4/tb_pos_ctrl.vhd

vsim work.tb_pos_ctrl


add wave -position insertpoint sim:/tb_pos_ctrl/*


run 10 us