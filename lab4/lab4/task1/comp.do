#! /bin/bash

vcom -work work -2008 -explicit -vopt compute_pipelined_ent.vhd
vcom -work work -2008 -explicit -vopt compute_pipelined_rtl.vhd
vcom -work work -2008 -explicit -vopt tb_compute_pipelined.vhd
