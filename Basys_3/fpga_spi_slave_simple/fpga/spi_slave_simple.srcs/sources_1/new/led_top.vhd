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
        LED: out std_logic_vector(15 downto 0)); --All 16 LEDs on the Basys 3 board
end led_top;

architecture Behavioral of led_top is

signal pipo_buffer : std_logic_vector(15 downto 0);
signal ready : std_logic;

--Declarative architecture section, declare used entities in structural way
component spi_slave_simple is
    generic(datawidth: integer:= 16);
    port ( sck: in std_logic;
           ss: in std_logic;
           mosi: in std_logic;
           data: out std_logic_vector(datawidth-1 downto 0);
           ready: out std_logic);
end component;

begin

--data_ready: process(ready)
--begin
--if(rising_edge(ready)) then
--pipo_buffer <= ;
--end if;
--end process data_ready;

spi_slave_input: spi_slave_simple port map(ss => JA(0),sck => JA(1),mosi => JA(2),data => pipo_buffer,ready => ready);

LED <= pipo_buffer;

end behavioral;
