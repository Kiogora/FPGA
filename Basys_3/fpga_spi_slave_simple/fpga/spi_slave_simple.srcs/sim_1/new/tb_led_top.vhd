----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2018 11:26:09 AM
-- Design Name: 
-- Module Name: tb_led_top - Behavioral
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
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_led_top is
end tb_led_top;

architecture Behavioral of tb_led_top is

signal rst: std_logic ;
signal clk: std_logic ;
signal sck: std_logic ;
signal ss: std_logic ;
signal mosi: std_logic;
signal data: std_logic_vector(15 downto 0);
signal ready: std_logic := '0';
signal state: std_logic;
signal shift_register_state: std_logic_vector(15 downto 0);

component spi_slave_simple is
    generic(datawidth: integer:= 16);
    port ( rst_i: in std_logic; --Async reset
    clk_i: in std_logic;
    sck_i: in std_logic;
    ss_i: in std_logic;
    mosi_i: in std_logic;
    miso_o: inout std_logic; --Tristate buffer to disconnect the miso line when ss is high
    data_i: in std_logic_vector(datawidth-1 downto 0);
    data_o: out std_logic_vector(datawidth-1 downto 0);
    dbg_input_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);  --Debug port for checking the input shift register
    dbg_output_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0); --Debug port for checking the output shift register
    ready_o: out std_logic;
    dbg_state_o: out std_logic_vector(2 downto 0); --Debug port for checking the internal state
    dbg_sck_o: out std_logic;                      --Debug port for checking synchronised sck input
    dbg_ss_o: out std_logic;                       --Debug port for checking synchronised ss input
    dbg_mosi_o: out std_logic;                     --Debug port for checking synchronised mosi input
    dbg_miso_o: out std_logic);                    --Debug port for checking synchronised miso output);
end component;


begin

uut : spi_slave_simple generic map(datawidth => 16) port map (rst_i => rst, shift_register_state_o => shift_register_state, clk_i => clk, sck_i => sck, ss_i => ss, mosi_i => mosi, data_o => data, ready_o => ready, state_o => state
rst_i => rst, 
clk_i => clk, 
ss_i => ss,
sck_i => sck, 
mosi_i => mosi,
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

rst <= '1';

file_read : process
variable rdline: line;
variable ss_sck_mosi: std_logic_vector(2 downto 0);
file file_input: text open read_mode is "/home/alois/Music/esp32_spi_trials/Basys_3/fpga_spi_slave_simple/fpga/spi_slave_simple.srcs/sim_1/new/ss_sck_mosi_normal.txt";
begin

while not endfile(file_input) loop
readline(file_input, rdline);
read(rdline, ss_sck_mosi);
ss <= ss_sck_mosi(2);
sck <= ss_sck_mosi(1);
mosi <= ss_sck_mosi(0);
--Change edges as per a 10MHz async clock to the system clock
wait for 50 ns;
end loop;
wait;
end process;

--100 MHz system clock
system_clock: process
begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
end process;

--100 MHz system clock
--async_reset: process
--begin
--    rst <= '0';
--    wait for 800 ns;
--    rst <= '1';
--    wait for 800 ns;
--end process;

end Behavioral;
