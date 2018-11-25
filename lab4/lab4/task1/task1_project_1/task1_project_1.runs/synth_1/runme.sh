#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/uio/kant/ifi-project06/robin/programs/SDK/2016.4/bin:/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/ids_lite/ISE/bin/lin64:/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/bin
else
  PATH=/uio/kant/ifi-project06/robin/programs/SDK/2016.4/bin:/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/ids_lite/ISE/bin/lin64:/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/uio/kant/ifi-project06/robin/programs/Vivado/2016.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/uio/hume/student-u41/wonhol/pc/work/inf4431/lab4/lab4/task1/task1_project_1/task1_project_1.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log compute.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source compute.tcl
