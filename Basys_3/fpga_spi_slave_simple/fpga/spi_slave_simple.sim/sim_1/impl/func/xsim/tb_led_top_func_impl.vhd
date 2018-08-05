-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
-- Date        : Sat Aug  4 00:15:22 2018
-- Host        : bae running 64-bit Ubuntu 16.04.4 LTS
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               /home/alois/Music/esp32_spi_trials/Basys_3/fpga_spi_slave_simple/fpga/spi_slave_simple.sim/sim_1/impl/func/xsim/tb_led_top_func_impl.vhd
-- Design      : led_top
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity synchronizer is
  port (
    o : out STD_LOGIC;
    CLK100MHZ : in STD_LOGIC;
    JA_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
end synchronizer;

architecture STRUCTURE of synchronizer is
  signal flipflops : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute async_reg : string;
  attribute async_reg of flipflops : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \flipflops_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \flipflops_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[0]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[1]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[1]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[1]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[2]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[2]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[2]\ : label is "FD_1";
begin
  o <= flipflops(2);
\flipflops_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => JA_IBUF(0),
      Q => flipflops(0),
      R => '0'
    );
\flipflops_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(0),
      Q => flipflops(1),
      R => '0'
    );
\flipflops_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(1),
      Q => flipflops(2),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity synchronizer_0 is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \present_state_reg[0]\ : out STD_LOGIC;
    CLK100MHZ : in STD_LOGIC;
    JA_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of synchronizer_0 : entity is "synchronizer";
end synchronizer_0;

architecture STRUCTURE of synchronizer_0 is
  signal flipflops : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute async_reg : string;
  attribute async_reg of flipflops : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \flipflops_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \flipflops_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[0]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[1]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[1]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[1]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[2]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[2]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[2]\ : label is "FD_1";
begin
  \out\(1 downto 0) <= flipflops(2 downto 1);
\flipflops_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => JA_IBUF(0),
      Q => flipflops(0),
      R => '0'
    );
\flipflops_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(0),
      Q => flipflops(1),
      R => '0'
    );
\flipflops_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(1),
      Q => flipflops(2),
      R => '0'
    );
\present_state[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => flipflops(2),
      I1 => flipflops(1),
      O => \present_state_reg[0]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity synchronizer_1 is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    CLK100MHZ : in STD_LOGIC;
    JA_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of synchronizer_1 : entity is "synchronizer";
end synchronizer_1;

architecture STRUCTURE of synchronizer_1 is
  signal flipflops : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute async_reg : string;
  attribute async_reg of flipflops : signal is "true";
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \flipflops_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \flipflops_reg[0]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[0]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[1]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[1]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[1]\ : label is "FD_1";
  attribute ASYNC_REG_boolean of \flipflops_reg[2]\ : label is std.standard.true;
  attribute KEEP of \flipflops_reg[2]\ : label is "yes";
  attribute XILINX_LEGACY_PRIM of \flipflops_reg[2]\ : label is "FD_1";
begin
  \out\(1 downto 0) <= flipflops(2 downto 1);
\flipflops_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => JA_IBUF(0),
      Q => flipflops(0),
      R => '0'
    );
\flipflops_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(0),
      Q => flipflops(1),
      R => '0'
    );
\flipflops_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '1'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => flipflops(1),
      Q => flipflops(2),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity spi_slave_simple is
  port (
    CLK : out STD_LOGIC;
    Q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK100MHZ : in STD_LOGIC;
    JA_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
end spi_slave_simple;

architecture STRUCTURE of spi_slave_simple is
  signal core_init_flag : STD_LOGIC;
  signal core_init_flag_reg_i_1_n_0 : STD_LOGIC;
  signal \data_o_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[10]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[13]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[14]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \data_o_reg[9]_i_1_n_0\ : STD_LOGIC;
  signal input_shift_register : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \input_shift_register_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[10]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[11]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[13]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[14]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[15]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[5]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[6]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \input_shift_register_reg[9]_i_1_n_0\ : STD_LOGIC;
  signal o : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_0_in_0 : STD_LOGIC;
  signal \present_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \present_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \present_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \present_state_reg_n_0_[1]\ : STD_LOGIC;
  signal ready_o_reg_i_1_n_0 : STD_LOGIC;
  signal sck_sync_n_0 : STD_LOGIC;
  signal sck_sync_n_2 : STD_LOGIC;
  signal synced_mosi : STD_LOGIC;
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of core_init_flag_reg : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[10]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[11]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[12]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[13]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[14]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[15]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[3]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[4]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[5]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[6]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[7]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[8]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \data_o_reg[9]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[0]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[10]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[11]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[12]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[13]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[14]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[15]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[1]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[2]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[3]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[4]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[5]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[6]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[7]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[8]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of \input_shift_register_reg[9]\ : label is "LD";
  attribute XILINX_LEGACY_PRIM of ready_o_reg : label is "LD";
begin
core_init_flag_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '1'
    )
        port map (
      CLR => '0',
      D => '0',
      G => core_init_flag_reg_i_1_n_0,
      GE => '1',
      Q => core_init_flag
    );
core_init_flag_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => \present_state_reg_n_0_[1]\,
      O => core_init_flag_reg_i_1_n_0
    );
\data_o_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[0]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(0)
    );
\data_o_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(0),
      O => \data_o_reg[0]_i_1_n_0\
    );
\data_o_reg[10]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[10]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(10)
    );
\data_o_reg[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(10),
      O => \data_o_reg[10]_i_1_n_0\
    );
\data_o_reg[11]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[11]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(11)
    );
\data_o_reg[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(11),
      O => \data_o_reg[11]_i_1_n_0\
    );
\data_o_reg[12]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[12]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(12)
    );
\data_o_reg[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(12),
      O => \data_o_reg[12]_i_1_n_0\
    );
\data_o_reg[13]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[13]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(13)
    );
\data_o_reg[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(13),
      O => \data_o_reg[13]_i_1_n_0\
    );
\data_o_reg[14]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[14]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(14)
    );
\data_o_reg[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(14),
      O => \data_o_reg[14]_i_1_n_0\
    );
\data_o_reg[15]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[15]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(15)
    );
\data_o_reg[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(15),
      O => \data_o_reg[15]_i_1_n_0\
    );
\data_o_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[1]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(1)
    );
\data_o_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(1),
      O => \data_o_reg[1]_i_1_n_0\
    );
\data_o_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[2]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(2)
    );
\data_o_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(2),
      O => \data_o_reg[2]_i_1_n_0\
    );
\data_o_reg[3]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[3]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(3)
    );
\data_o_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(3),
      O => \data_o_reg[3]_i_1_n_0\
    );
\data_o_reg[4]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[4]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(4)
    );
\data_o_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(4),
      O => \data_o_reg[4]_i_1_n_0\
    );
\data_o_reg[5]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[5]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(5)
    );
\data_o_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(5),
      O => \data_o_reg[5]_i_1_n_0\
    );
\data_o_reg[6]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[6]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(6)
    );
\data_o_reg[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(6),
      O => \data_o_reg[6]_i_1_n_0\
    );
\data_o_reg[7]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[7]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(7)
    );
\data_o_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(7),
      O => \data_o_reg[7]_i_1_n_0\
    );
\data_o_reg[8]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[8]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(8)
    );
\data_o_reg[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(8),
      O => \data_o_reg[8]_i_1_n_0\
    );
\data_o_reg[9]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \data_o_reg[9]_i_1_n_0\,
      G => \present_state_reg_n_0_[0]\,
      GE => '1',
      Q => Q(9)
    );
\data_o_reg[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => input_shift_register(9),
      O => \data_o_reg[9]_i_1_n_0\
    );
\input_shift_register_reg[0]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[0]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(0)
    );
\input_shift_register_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => synced_mosi,
      O => \input_shift_register_reg[0]_i_1_n_0\
    );
\input_shift_register_reg[10]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[10]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(10)
    );
\input_shift_register_reg[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(9),
      O => \input_shift_register_reg[10]_i_1_n_0\
    );
\input_shift_register_reg[11]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[11]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(11)
    );
\input_shift_register_reg[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(10),
      O => \input_shift_register_reg[11]_i_1_n_0\
    );
\input_shift_register_reg[12]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[12]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(12)
    );
\input_shift_register_reg[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(11),
      O => \input_shift_register_reg[12]_i_1_n_0\
    );
\input_shift_register_reg[13]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[13]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(13)
    );
\input_shift_register_reg[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(12),
      O => \input_shift_register_reg[13]_i_1_n_0\
    );
\input_shift_register_reg[14]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[14]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(14)
    );
\input_shift_register_reg[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(13),
      O => \input_shift_register_reg[14]_i_1_n_0\
    );
\input_shift_register_reg[15]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[15]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(15)
    );
\input_shift_register_reg[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(14),
      O => \input_shift_register_reg[15]_i_1_n_0\
    );
\input_shift_register_reg[1]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[1]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(1)
    );
\input_shift_register_reg[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(0),
      O => \input_shift_register_reg[1]_i_1_n_0\
    );
\input_shift_register_reg[2]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[2]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(2)
    );
\input_shift_register_reg[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(1),
      O => \input_shift_register_reg[2]_i_1_n_0\
    );
\input_shift_register_reg[3]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[3]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(3)
    );
\input_shift_register_reg[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(2),
      O => \input_shift_register_reg[3]_i_1_n_0\
    );
\input_shift_register_reg[4]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[4]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(4)
    );
\input_shift_register_reg[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(3),
      O => \input_shift_register_reg[4]_i_1_n_0\
    );
\input_shift_register_reg[5]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[5]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(5)
    );
\input_shift_register_reg[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(4),
      O => \input_shift_register_reg[5]_i_1_n_0\
    );
\input_shift_register_reg[6]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[6]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(6)
    );
\input_shift_register_reg[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(5),
      O => \input_shift_register_reg[6]_i_1_n_0\
    );
\input_shift_register_reg[7]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[7]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(7)
    );
\input_shift_register_reg[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(6),
      O => \input_shift_register_reg[7]_i_1_n_0\
    );
\input_shift_register_reg[8]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[8]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(8)
    );
\input_shift_register_reg[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(7),
      O => \input_shift_register_reg[8]_i_1_n_0\
    );
\input_shift_register_reg[9]\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0',
      IS_G_INVERTED => '1'
    )
        port map (
      CLR => '0',
      D => \input_shift_register_reg[9]_i_1_n_0\,
      G => \present_state_reg_n_0_[1]\,
      GE => '1',
      Q => input_shift_register(9)
    );
\input_shift_register_reg[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => input_shift_register(8),
      O => \input_shift_register_reg[9]_i_1_n_0\
    );
mosi_sync: entity work.synchronizer
     port map (
      CLK100MHZ => CLK100MHZ,
      JA_IBUF(0) => JA_IBUF(2),
      o => synced_mosi
    );
\present_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3130313303000300"
    )
        port map (
      I0 => \present_state_reg_n_0_[1]\,
      I1 => core_init_flag,
      I2 => o,
      I3 => sck_sync_n_2,
      I4 => p_0_in_0,
      I5 => \present_state_reg_n_0_[0]\,
      O => \present_state[0]_i_1_n_0\
    );
\present_state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5455545510110000"
    )
        port map (
      I0 => core_init_flag,
      I1 => o,
      I2 => p_0_in,
      I3 => sck_sync_n_0,
      I4 => p_0_in_0,
      I5 => \present_state_reg_n_0_[1]\,
      O => \present_state[1]_i_1_n_0\
    );
\present_state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => \present_state[0]_i_1_n_0\,
      Q => \present_state_reg_n_0_[0]\,
      R => '0'
    );
\present_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK100MHZ,
      CE => '1',
      D => \present_state[1]_i_1_n_0\,
      Q => \present_state_reg_n_0_[1]\,
      R => '0'
    );
ready_o_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => \present_state_reg_n_0_[1]\,
      G => ready_o_reg_i_1_n_0,
      GE => '1',
      Q => CLK
    );
ready_o_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \present_state_reg_n_0_[0]\,
      I1 => \present_state_reg_n_0_[1]\,
      O => ready_o_reg_i_1_n_0
    );
sck_sync: entity work.synchronizer_0
     port map (
      CLK100MHZ => CLK100MHZ,
      JA_IBUF(0) => JA_IBUF(1),
      \out\(1) => sck_sync_n_0,
      \out\(0) => p_0_in,
      \present_state_reg[0]\ => sck_sync_n_2
    );
ss_sync: entity work.synchronizer_1
     port map (
      CLK100MHZ => CLK100MHZ,
      JA_IBUF(0) => JA_IBUF(0),
      \out\(1) => o,
      \out\(0) => p_0_in_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity led_top is
  port (
    JA : in STD_LOGIC_VECTOR ( 2 downto 0 );
    LED : out STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK100MHZ : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of led_top : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of led_top : entity is "112151a0";
end led_top;

architecture STRUCTURE of led_top is
  signal CLK100MHZ_IBUF : STD_LOGIC;
  signal CLK100MHZ_IBUF_BUFG : STD_LOGIC;
  signal JA_IBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal LED_OBUF : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal pipo_buffer : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal ready : STD_LOGIC;
begin
CLK100MHZ_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => CLK100MHZ_IBUF,
      O => CLK100MHZ_IBUF_BUFG
    );
CLK100MHZ_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => CLK100MHZ,
      O => CLK100MHZ_IBUF
    );
\JA_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => JA(0),
      O => JA_IBUF(0)
    );
\JA_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => JA(1),
      O => JA_IBUF(1)
    );
\JA_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => JA(2),
      O => JA_IBUF(2)
    );
\LED_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(0),
      O => LED(0)
    );
\LED_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(10),
      O => LED(10)
    );
\LED_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(11),
      O => LED(11)
    );
\LED_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(12),
      O => LED(12)
    );
\LED_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(13),
      O => LED(13)
    );
\LED_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(14),
      O => LED(14)
    );
\LED_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(15),
      O => LED(15)
    );
\LED_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(1),
      O => LED(1)
    );
\LED_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(2),
      O => LED(2)
    );
\LED_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(3),
      O => LED(3)
    );
\LED_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(4),
      O => LED(4)
    );
\LED_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(5),
      O => LED(5)
    );
\LED_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(6),
      O => LED(6)
    );
\LED_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(7),
      O => LED(7)
    );
\LED_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(8),
      O => LED(8)
    );
\LED_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => LED_OBUF(9),
      O => LED(9)
    );
\LED_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(0),
      Q => LED_OBUF(0),
      R => '0'
    );
\LED_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(10),
      Q => LED_OBUF(10),
      R => '0'
    );
\LED_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(11),
      Q => LED_OBUF(11),
      R => '0'
    );
\LED_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(12),
      Q => LED_OBUF(12),
      R => '0'
    );
\LED_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(13),
      Q => LED_OBUF(13),
      R => '0'
    );
\LED_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(14),
      Q => LED_OBUF(14),
      R => '0'
    );
\LED_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(15),
      Q => LED_OBUF(15),
      R => '0'
    );
\LED_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(1),
      Q => LED_OBUF(1),
      R => '0'
    );
\LED_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(2),
      Q => LED_OBUF(2),
      R => '0'
    );
\LED_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(3),
      Q => LED_OBUF(3),
      R => '0'
    );
\LED_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(4),
      Q => LED_OBUF(4),
      R => '0'
    );
\LED_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(5),
      Q => LED_OBUF(5),
      R => '0'
    );
\LED_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(6),
      Q => LED_OBUF(6),
      R => '0'
    );
\LED_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(7),
      Q => LED_OBUF(7),
      R => '0'
    );
\LED_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(8),
      Q => LED_OBUF(8),
      R => '0'
    );
\LED_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => ready,
      CE => '1',
      D => pipo_buffer(9),
      Q => LED_OBUF(9),
      R => '0'
    );
spi_slave_input: entity work.spi_slave_simple
     port map (
      CLK => ready,
      CLK100MHZ => CLK100MHZ_IBUF_BUFG,
      JA_IBUF(2 downto 0) => JA_IBUF(2 downto 0),
      Q(15 downto 0) => pipo_buffer(15 downto 0)
    );
end STRUCTURE;
