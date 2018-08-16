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

--Default working of this SPI slave is in SPI mode 0(CPOL_CPHA='00')
--Untested for other SPI modes.
entity spi_slave_simple is
generic(datawidth: integer:= 16);
port ( 
rst_i: in std_logic; --Async reset
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
dbg_miso_o: out std_logic);                    --Debug port for checking synchronised miso output
end spi_slave_simple;

architecture behavioral of spi_slave_simple is

type state_type is (load, idle, shift, store);
signal next_state : state_type ;

type bus_state is (active, hi_z);
signal miso_state: bus_state;

signal input_shift_register, output_shift_register : std_logic_vector(datawidth-1 downto 0);

signal synced_mosi, synced_sck, synced_ss, sck_rise, sck_fall, ss_rise, ss_fall, init_done, store_done: std_logic;


component synchronizer is
generic ( stages : natural := 3 );
Port ( 
clk_i : in std_logic;
i : in std_logic;
o : out std_logic;
rise_o: out std_logic;
fall_o: out std_logic);
end component;

    
begin

ss_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => ss_i, o => synced_ss, rise_o => open, fall_o => open);
sck_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => sck_i, o => synced_sck, rise_o => sck_rise, fall_o => sck_fall);
mosi_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => mosi_i, o => synced_mosi, rise_o => open, fall_o => open);

process(rst_i, clk_i)
begin

if(rst_i = '0')then
--Initialise all storage and outputs
data_o<=(others => '0');
output_shift_register<=(others => '0');
input_shift_register<=(others => '0');
miso_state <= hi_z;
ready_o <= '0';
next_state<= idle;
elsif(rising_edge(clk_i)) then
    case next_state is
    when load =>
        output_shift_register<=data_i;
        next_state<=shift;
    when store =>
        data_o <= input_shift_register;
        next_state<=idle;     
    when idle => 
        if(synced_ss = '0') then
            --input_shift_register<=(others => '0');
            miso_state <= active;
            ready_o <= '0';
            next_state<=load;
        else
            miso_state <= hi_z;
            ready_o <= '1';
            next_state<=idle;
        end if;
    when shift => 
        if(synced_ss = '0') then
            if(sck_rise = '1') then
                input_shift_register<=input_shift_register(datawidth-2 downto 0) & synced_mosi;
            elsif(sck_fall = '1') then
                output_shift_register<=output_shift_register(datawidth-2 downto 0) & '0';
            end if;
            next_state <= shift;
        else
            next_state<=store;
        end if;
    when others =>
        next_state<= idle;
end case;
end  if;

if(miso_state = active) then
    miso_o <= output_shift_register(datawidth-1);
else 
    miso_o <= 'Z';
end if;

end process;

--Debugging signals
dbg_sck_o <= synced_sck;
dbg_ss_o <= synced_ss;
dbg_miso_o <= output_shift_register(datawidth-1);
dbg_mosi_o <= mosi_i;
dbg_input_shift_register_state_o <= input_shift_register;
dbg_output_shift_register_state_o <= output_shift_register;
   
with next_state select
   dbg_state_o <= "000" when idle,
                  "001" when shift,
                  "010" when load,
                  "011" when store,
                  "100" when others;               
end behavioral;