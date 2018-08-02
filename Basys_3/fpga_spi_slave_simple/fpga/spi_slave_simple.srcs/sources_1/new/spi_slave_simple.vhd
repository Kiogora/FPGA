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
    port ( rst_i: in std_logic; --Async reset
           clk_i: in std_logic;
           sck_i: in std_logic;
           ss_i: in std_logic;
           mosi_i: in std_logic;
           data_o: out std_logic_vector(datawidth-1 downto 0);
           ready_o: out std_logic);
end spi_slave_simple;

architecture behavioral of spi_slave_simple is

type state_type is (idle, shift);
signal present_state, next_state : state_type ;

signal input_shift_register : std_logic_vector(datawidth-1 downto 0);

signal synced_mosi, synced_sck, synced_ss, sck_rise, sck_fall : std_logic;

component synchronizer is
    generic ( stages : natural := 3 );
    Port ( clk_i : in std_logic;
             i : in std_logic;
             o : out std_logic;
             rise_o: out std_logic;
             fall_o: out std_logic);
end component;

    
begin

ss_sync: synchronizer port map(clk_i => clk_i, i => ss_i, o => synced_ss, rise_o => open, fall_o => open);
sck_sync: synchronizer port map(clk_i => clk_i, i => sck_i, o => open, rise_o => sck_rise, fall_o => sck_fall);
mosi_sync: synchronizer port map(clk_i => clk_i, i => mosi_i, o => synced_mosi, rise_o => open, fall_o => open);

--Realises FFs with asynchronous reset
--Has factors affecting state transition in sensitivity list.
state_sync: process(rst_i, clk_i, next_state, synced_ss, sck_rise)
begin
    if(rst_i = '0') then
        present_state <= idle;
        data_o<=(others => '0');
        ready_o <= '0';
    elsif(rising_edge(clk_i)) then
            if(synced_ss = '0') then
                if(sck_rise = '1') then
                    present_state <= next_state;
                    ready_o<='0';
                end if;
            else
                present_state <= idle;
                data_o<=input_shift_register;
                ready_o <= '1';
            end if;
    end if;
end process state_sync;

--Outputs are function of past inputs and outputs, no present input on any data lines
combinatorial : process(present_state, synced_mosi, input_shift_register)
begin
case present_state is
when idle =>
    input_shift_register <= (others=>'0');
    next_state <= shift;
when shift =>
    input_shift_register<=input_shift_register(datawidth-2 downto 0) & synced_mosi;
    next_state <= shift;
--Catch all to avoid latch inferencing by synthesis tools
when others =>
input_shift_register <= (others=>'0');
next_state <= idle;
end case;
end process combinatorial;

end behavioral;