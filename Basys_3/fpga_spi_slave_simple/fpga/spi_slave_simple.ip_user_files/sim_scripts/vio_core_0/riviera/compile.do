vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../spi_slave_simple.srcs/sources_1/ip/vio_core_0/hdl/verilog" "+incdir+../../../../spi_slave_simple.srcs/sources_1/ip/vio_core_0/hdl" "+incdir+../../../../spi_slave_simple.srcs/sources_1/ip/vio_core_0/hdl/verilog" "+incdir+../../../../spi_slave_simple.srcs/sources_1/ip/vio_core_0/hdl" \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../spi_slave_simple.srcs/sources_1/ip/vio_core_0/sim/vio_core_0.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

