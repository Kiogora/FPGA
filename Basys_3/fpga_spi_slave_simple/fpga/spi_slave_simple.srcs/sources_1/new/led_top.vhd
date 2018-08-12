----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/29/2018 09:03:41 PM
-- Design Name: 
-- Module Name: led_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_top is
  Port (JA : in std_logic_vector(2 downto 0); -- SPI lines ss, sck, mosi connected to Pmod connectors
        JB : out std_logic_vector(0 downto 0); --miso output
        LED : out std_logic_vector(15 downto 0); --All 16 LEDs on the Basys 3 board. Initialise output as low.
        CLK100MHZ : in std_logic);
end led_top;

architecture Behavioral of led_top is

--Declarative architecture section, declare used entities in structural way
component spi_slave_simple is
generic(datawidth: integer:= 16);
port (  
rst_i: in std_logic; --Async reset
clk_i: in std_logic;
sck_i: in std_logic;
ss_i: in std_logic;
miso_o: out std_logic;
mosi_i: in std_logic;
data_i: in std_logic_vector(datawidth-1 downto 0);
data_o: out std_logic_vector(datawidth-1 downto 0);
dbg_input_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
dbg_output_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
ready_o: out std_logic;
dbg_state_o: out std_logic_vector(2 downto 0); --Debug port for checking the internal states
dbg_sck_o: out std_logic; --Debug port for checking synchronised sck output
dbg_ss_o: out std_logic; --Debug port for checking synchronised ss output
dbg_mosi_o: out std_logic;
dbg_miso_o: out std_logic);
end component;

component ila_0 
port ( 
clk : in std_logic;
probe0 : in std_logic; 
probe1 : in std_logic; 
probe2 : in std_logic; 
probe3 : in std_logic_vector(2 downto 0);
probe4 : in std_logic; 
probe5 : in std_logic_vector(15 downto 0);
probe6 : in std_logic_vector(15 downto 0);
probe7 : in std_logic;
probe8 : in std_logic_vector(15 downto 0));
end component;

--Cut from vio ip core instantiation file
component vio_core_0
port (
clk : in std_logic;
probe_in0 : in std_logic;
probe_in1 : in std_logic;
probe_in2 : in std_logic;
probe_in3 : in std_logic_vector(2 downto 0);
probe_in4 : in std_logic;
probe_in5 : in std_logic_vector(15 downto 0);
probe_in6 : in std_logic_vector(15 downto 0);
probe_in7 : in std_logic;
probe_in8 : in std_logic_vector(15 downto 0));
end component;


signal ready : std_logic;

signal debug_mosi, debug_miso, debug_ss, debug_sck, debug_ready, clk_buffer : std_logic;
signal debug_state : std_logic_vector(2 downto 0);
signal debug_input_shift_reg, debug_output_shift_reg, output_buffer, input_buffer, aux_led : std_logic_vector(15 downto 0);

begin

vio_core : vio_core_0 
port map (
clk => CLK100MHZ,
probe_in0 => debug_ss,
probe_in1 => debug_sck,
probe_in2 => debug_mosi,
probe_in3 => debug_state,
probe_in4 => debug_ready,
probe_in5 => debug_input_shift_reg,
probe_in6 => input_buffer,
probe_in7 => debug_miso,
probe_in8 => debug_output_shift_reg);
                                
ila_core : ila_0
port map (
clk => CLK100MHZ,
probe0 => debug_ss,
probe1 => debug_sck,
probe2 => debug_mosi,
probe3 => debug_state,
probe4 => debug_ready,
probe5 => debug_input_shift_reg,
probe6 => input_buffer,
probe7 => debug_miso,
probe8 => debug_output_shift_reg);
  
spi_slave_input: spi_slave_simple 
port map(
rst_i => '1', 
clk_i => CLK100MHZ, 
ss_i => JA(0),
sck_i => JA(1), 
mosi_i => JA(2),
miso_o=> JB(0),
data_i => output_buffer,
data_o => input_buffer,
ready_o => debug_ready,
dbg_input_shift_register_state_o => debug_input_shift_reg, 
dbg_output_shift_register_state_o => debug_output_shift_reg, 
dbg_state_o => debug_state,
dbg_sck_o => debug_sck,
dbg_ss_o => debug_ss,
dbg_mosi_o => debug_mosi,
dbg_miso_o => debug_miso);

--Input buffer is used as an auxiliary signal before writing to the LED and output buffer, leading to state synchronisation
LED <= input_buffer;

output_buffer <= input_buffer;

--Debug signals sent via IO for external debug probing here

end behavioral;
