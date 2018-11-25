#! /bin/bash

vcom -work work -2008 -explicit -vopt subprog_pck.vhd
vcom -work work -2008 -explicit -vopt subprog_bdy.vhd
vcom -work work -2008 -explicit -vopt decoder.vhd
vcom -work work -2008 -explicit -vopt timer.vhd
vcom -work work -2008 -explicit -vopt seg7ctrl_ent.vhd
vcom -work work -2008 -explicit -vopt seg7ctrl_rtl.vhd
vcom -work work -2008 -explicit -vopt pos_meas_ent.vhd
vcom -work work -2008 -explicit -vopt pos_meas_rtl.vhd
vcom -work work -2008 -explicit -vopt p_ctrl_ent.vhd
vcom -work work -2008 -explicit -vopt p_ctrl_rtl.vhd
vcom -work work -2008 -explicit -vopt pos_ctrl_ent.vhd
vcom -work work -2008 -explicit -vopt pos_ctrl_rtl.vhd
vcom -work work -2008 -explicit -vopt clkdiv_ent.vhd
vcom -work work -2008 -explicit -vopt clkdiv_rtl.vhd
vcom -work work -2008 -explicit -vopt rstsynch_ent.vhd
vcom -work work -2008 -explicit -vopt rstsynch_rtl.vhd
vcom -work work -2008 -explicit -vopt cru_ent.vhd
vcom -work work -2008 -explicit -vopt cru_str.vhd
vcom -work work -2008 -explicit -vopt pos_seg7_ctrl_ent.vhd
vcom -work work -2008 -explicit -vopt pos_seg7_ctrl_str.vhd
vcom -work work -2008 -explicit -vopt tb_pos_seg7_ctrl.vhd



