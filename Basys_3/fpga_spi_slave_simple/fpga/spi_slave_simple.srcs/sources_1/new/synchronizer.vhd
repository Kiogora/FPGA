----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/01/2018 03:12:31 PM
-- Design Name: 
-- Module Name: synchronizer - Behavioral
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

entity synchronizer is
    generic ( stages : natural := 3 );
    Port ( clk_i : in std_logic;
             i : in std_logic;
             o : out std_logic;
             rise_o: out std_logic;
             fall_o: out std_logic);
end synchronizer;

architecture Behavioral of synchronizer is
signal flipflops : std_logic_vector(stages-1 downto 0):= (others => '0');
--https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_3/ug901-vivado-synthesis.pdf page 40
attribute ASYNC_REG : string;
attribute ASYNC_REG of flipflops: signal is "true";
begin

--Continuous assignment of MSB to output
o <= flipflops(flipflops'high);

--Rising/falling output is delayed by stages-1 system clock cycles. System clock should be much faster than the communication clock.
fall_o <= flipflops(flipflops'high) and not flipflops(flipflops'high-1);
rise_o <= not flipflops(flipflops'high) and flipflops(flipflops'high-1);

clk_proc: process(clk_i)
begin
    --Use falling edge in order to change the outpu
    if falling_edge(clk_i) then
        flipflops <= flipflops(flipflops'high-1 downto 0) & i;
    end if;
end process;

end Behavioral;
