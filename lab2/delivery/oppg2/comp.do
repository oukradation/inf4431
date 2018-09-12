#! /bin/bash

vcom -work work -2008 -explicit -vopt seg7model_ent.vhd
vcom -work work -2008 -explicit -vopt seg7model_beh.vhd
vcom -work work -2008 -explicit -vopt subprog_pck.vhd
vcom -work work -2008 -explicit -vopt subprog_bdy.vhd
vcom -work work -2008 -explicit -vopt tb_hex2seg7.vhd

