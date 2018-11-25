#! /bin/bash

vcom -work work -2008 -explicit -vopt subprog_pck.vhd
vcom -work work -2008 -explicit -vopt subprog_bdy.vhd
vcom -work work -2008 -explicit -vopt pos_meas_ent.vhd
vcom -work work -2008 -explicit -vopt pos_meas_rtl.vhd
vcom -work work -2008 -explicit -vopt seg7ctrl_ent.vhd
vcom -work work -2008 -explicit -vopt seg7ctrl_rtl.vhd
vcom -work work -2008 -explicit -vopt test_pos_meas.vhd



