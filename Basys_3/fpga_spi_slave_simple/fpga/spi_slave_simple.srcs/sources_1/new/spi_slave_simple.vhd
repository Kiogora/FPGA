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
--May not work reliably for other SPI modes.
entity spi_slave_simple is
generic(datawidth: integer:= 16);
port ( 
rst_i: in std_logic; --Async reset
clk_i: in std_logic;
sck_i: in std_logic;
ss_i: in std_logic;
mosi_i: in std_logic;
miso_o: buffer std_logic;
data_i: in std_logic_vector(datawidth-1 downto 0);
data_o: out std_logic_vector(datawidth-1 downto 0);
dbg_input_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
dbg_output_shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
ready_o: out std_logic;
dbg_state_o: out std_logic_vector(2 downto 0); --Debug port for checking the internal state
dbg_sck_o: out std_logic; --Debug port for checking synchronised sck output
dbg_ss_o: out std_logic; --Debug port for checking synchronised ss output
dbg_mosi_o: out std_logic; --Debug port for checking synchronised mosi input
dbg_miso_o: out std_logic); --Debug port for checking synchronised mosi input
end spi_slave_simple;

architecture behavioral of spi_slave_simple is

type state_type is (load, idle, shift, store);
signal next_state : state_type ;

signal input_shift_register, output_shift_register : std_logic_vector(datawidth-1 downto 0);

signal synced_mosi, synced_sck, synced_ss, sck_rise, sck_fall, ss_rise, ss_fall, init_done, store_done, miso_buffer: std_logic;


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

ss_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => ss_i, o => synced_ss, rise_o => ss_rise, fall_o => ss_fall);
sck_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => sck_i, o => synced_sck, rise_o => sck_rise, fall_o => sck_fall);
mosi_sync: synchronizer generic map(stages => 3) port map(clk_i => clk_i, i => mosi_i, o => synced_mosi, rise_o => open, fall_o => open);

process(rst_i, clk_i)
begin

if(rst_i = '0')then
--Initialise all storage and outputs
data_o<=(others => '0');
output_shift_register<=(others => '0');
input_shift_register<=(others => '0');
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
            ready_o <= '0';
            next_state<=load;
        else
            ready_o <= '1';
            next_state<=idle;
        end if;
    when shift => 
        if(synced_ss = '0') then
            if(sck_rise = '1') then
                input_shift_register<=input_shift_register(datawidth-2 downto 0) & synced_mosi;
            elsif(sck_fall = '1') then
                miso_o <= output_shift_register(datawidth-1);
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
end process;


--Debug output section
dbg_sck_o <= synced_sck;
dbg_ss_o <= synced_ss;
miso_buffer <= synced_mosi;

dbg_miso_o <= miso_o;
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