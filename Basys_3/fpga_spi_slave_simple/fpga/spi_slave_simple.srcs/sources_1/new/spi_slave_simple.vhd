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
           mosi: in std_logic;
           data: out std_logic_vector(datawidth-1 downto 0);
           ready: out std_logic);
end spi_slave_simple;

architecture behavioral of spi_slave_simple is
    -- Internal entity signals
    type state_type is (idle, load, shift);
    signal present_state, next_state : state_type;
    
    signal input_shift_register : std_logic_vector(datawidth-1 downto 0);
    signal index : integer;

    
begin

--Realises to a FF(s)
--Has factors affecting state transition in sensitivity list. Usually asynchronous.
state_sync: process(sck)
begin
    --Force next state as idle state when ss is high, regardless of sck
    if(rising_edge(sck)) then
        if(ss = '0') then
            present_state <= next_state;
            ready<='0';
        else
            present_state <= idle;
            data<=input_shift_register;
            ready <= '1';
        end if;
    end if;
end process state_sync;

--Outputs are function of past inputs and outputs, no present input on any data lines
combinatorial : process(present_state)
begin
case present_state is
when idle =>
    input_shift_register<=(others=>'0');
    index<=datawidth-1;
    next_state <= shift;
when shift =>
    if (index /= 0) then
        input_shift_register(index) <= mosi;
        index <= index-1;
    else
        --Left shift and append to the right
        input_shift_register(datawidth-1 downto 0)<=input_shift_register(datawidth-2 downto 0) & mosi;
    end if;
    next_state <= shift;
--Catch all to avoid latch inferencing by synthesis tools
when others =>
next_state <= idle;

end case;
end process combinatorial;

end behavioral;