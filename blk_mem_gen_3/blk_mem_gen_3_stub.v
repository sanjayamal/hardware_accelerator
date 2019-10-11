// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Sun Sep  8 16:22:54 2019
// Host        : DESKTOP-5G8NHJI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub c:/ip_repo/blk_mem_gen_3/blk_mem_gen_3_stub.v
// Design      : blk_mem_gen_3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *)
module blk_mem_gen_3(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[5:0],douta[31:0]" */;
  input clka;
  input ena;
  input [5:0]addra;
  output [31:0]douta;
endmodule
