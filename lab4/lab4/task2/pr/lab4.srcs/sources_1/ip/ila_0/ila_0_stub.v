// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1756540 Mon Jan 23 19:11:23 MST 2017
// Date        : Mon Nov 05 13:31:16 2018
// Host        : IFI-STAMFORD running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               m:/pc/work/inf4431/lab4/lab4/task2/pr/lab4.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2016.4" *)
module ila_0(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[1:0],probe1[7:0]" */;
  input clk;
  input [1:0]probe0;
  input [7:0]probe1;
endmodule
