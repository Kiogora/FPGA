#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2017.4 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sat Aug 04 00:15:26 EAT 2018
# SW Build 2086221 on Fri Dec 15 20:54:30 MST 2017
#
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xelab -wto cb0707bd15e44a8cbf8fd26ab6ad4f08 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_led_top_func_impl xil_defaultlib.tb_led_top -log elaborate.log
