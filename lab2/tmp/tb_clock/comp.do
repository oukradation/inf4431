#! /bin/bash

#vcom -work work -2008 -explicit -vopt timer.vhd
#vcom -work work -2008 -explicit -vopt decoder.vhd
#vcom -work work -2008 -explicit -vopt subprog_pck.vhd
#vcom -work work -2008 -explicit -vopt subprog_bdy.vhd
#vcom -work work -2008 -explicit -vopt seg7ctrl_ent.vhd
#vcom -work work -2008 -explicit -vopt seg7ctrl_rtl.vhd
#vcom -work work -2008 -explicit -vopt regctrl_ent.vhd
#vcom -work work -2008 -explicit -vopt regctrl_rtl.vhd
#vcom -work work -2008 -explicit -vopt reg_ent.vhd
#vcom -work work -2008 -explicit -vopt reg_str.vhd
#vcom -work work -2008 -explicit -vopt tb_reg.vhd
vcom -work work1 -2008 -explicit -vopt clock_ent.vhd
vcom -work work1 -2008 -explicit -vopt clock_rtl.vhd
vcom -work work1 -2008 -explicit -vopt tb_clock.vhd

