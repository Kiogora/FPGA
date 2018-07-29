----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alois Mbutura
-- 
-- Create Date: 07/28/2018 04:53:40 PM
-- Design Name: 
-- Module Name: spi_slave_simple - Behavioral
-- Project Name: spi_slave_simple
-- Target Devices: Basys3
-- Tool Versions: Vivado design suite 17,4
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

--Default working of this SPI slave is in SPI mode 0(CPOL_CPHA='00')
--May not work reliably for other SPI modes
entity spi_slave_simple is
    generic(datawidth: integer:= 16);
    port ( sck: in std_logic;
           ss: in std_logic;
           miso: out std_logic;
           data: in std_logic_vector(datawidth-1 downto 0));
end spi_slave_simple;

architecture behavioral of spi_slave_simple is
    -- Internal entity signals
    type state_type is (idle, load, shift);
    signal present_state, next_state : state_type;
    
    signal output_shift_register : std_logic_vector(datawidth-1 downto 0);

    
begin

--Realises to a FF(s)
--Has factors affecting state transition in sensitivity list. Usually asynchronous.
state_sync: process(sck, ss)
begin
    --Force next state as idle state when ss is high, regardless of sck
    if(ss = '1') then 
        present_state <= idle;
    elsif(rising_edge(sck)) then 
        present_state <= next_state;
    end if;
end process state_sync;

--Outputs are function of past inputs and outputs, no present input on any data lines
combinatorial : process(present_state)
begin
case present_state is
when idle =>
    output_shift_register<=(others=>'0');
    next_state <= load;
when load =>
    output_shift_register<=data;
    next_state <= shift;
when shift =>
    miso<=output_shift_register(datawidth-1);
    output_shift_register(datawidth-1 downto 0)<=output_shift_register(datawidth-2 downto 0) & '0';
    next_state <= shift;
--Catch all to avoid latch inferencing by synthesis tools
when others =>
next_state <= idle;

end case;
end process combinatorial;

end behavioral;