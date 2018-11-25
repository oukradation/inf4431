vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/p_ctrl_ent2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/motor_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_meas_ent2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_seg7_ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/rstsynch_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/seg7ctrl_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/clkdiv_ent.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/seg7model_ent.vhd



vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/motor_beh.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/p_ctrl2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_meas_arch2.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_ctrl_arch.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/cru.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/pos_seg7_ctrl.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/subprog_pck.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/subprog_pck_arch.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/seg7model_beh.vhd
vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/seg7ctrl_arch.vhd

vcom -work work -93 -explicit -vopt M:/lab3/lab3-src/src/oppg5/tb_pos7segctrl.vhd


vsim work.tb_pos7segctrl


add wave -position insertpoint sim:/tb_pos7segctrl/*

run 1 ms