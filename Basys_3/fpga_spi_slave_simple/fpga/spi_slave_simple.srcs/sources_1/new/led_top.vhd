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
  Port (JA : in std_logic_vector(7 downto 0); -- SPI lines ss, sck, mosi connected to Pmod connectors
        JB : out std_logic_vector(7 downto 0);
        LED : out std_logic_vector(15 downto 0) := (others => '0'); --All 16 LEDs on the Basys 3 board. Initialise output as low.
        CLK100MHZ : in std_logic);
end led_top;

architecture Behavioral of led_top is

signal pipo_buffer : std_logic_vector(15 downto 0);
signal ready : std_logic;

--Declarative architecture section, declare used entities in structural way
component spi_slave_simple is
    generic(datawidth: integer:= 16);
    port ( rst_i: in std_logic; --Async reset
           clk_i: in std_logic;
           sck_i: in std_logic;
           ss_i: in std_logic;
           mosi_i: in std_logic;
           shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
           data_o: out std_logic_vector(datawidth-1 downto 0);
           ready_o: out std_logic;
           state_o: out std_logic);
end component;

begin

--data_ready: process(ready)
--begin
--if(rising_edge(ready)) then

--end if;
--end process data_ready;
LED <= pipo_buffer;
spi_slave_input: spi_slave_simple port map(rst_i => '1', clk_i => CLK100MHZ, ss_i => JA(0),sck_i => JA(1), 
                                           mosi_i => JA(2),data_o => pipo_buffer,ready_o => JB(1), shift_register_state_o => open, state_o => JB(0));



end behavioral;
