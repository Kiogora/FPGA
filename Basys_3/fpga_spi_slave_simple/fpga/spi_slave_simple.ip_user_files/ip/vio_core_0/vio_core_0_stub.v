// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Oct 16 12:43:39 2018
// Host        : badass running 64-bit Ubuntu 18.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/alois/Documents/projects/FPGA/Basys_3/fpga_spi_slave_simple/fpga/spi_slave_simple.srcs/sources_1/ip/vio_core_0/vio_core_0_stub.v
// Design      : vio_core_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2018.2" *)
module vio_core_0(clk, probe_in0, probe_in1, probe_in2, probe_in3, 
  probe_in4, probe_in5, probe_in6, probe_in7, probe_in8)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[0:0],probe_in1[0:0],probe_in2[0:0],probe_in3[2:0],probe_in4[0:0],probe_in5[15:0],probe_in6[15:0],probe_in7[0:0],probe_in8[15:0]" */;
  input clk;
  input [0:0]probe_in0;
  input [0:0]probe_in1;
  input [0:0]probe_in2;
  input [2:0]probe_in3;
  input [0:0]probe_in4;
  input [15:0]probe_in5;
  input [15:0]probe_in6;
  input [0:0]probe_in7;
  input [15:0]probe_in8;
endmodule
