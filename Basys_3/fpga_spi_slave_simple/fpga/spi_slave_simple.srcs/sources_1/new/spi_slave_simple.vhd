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
           shift_register_state_o: out std_logic_vector(datawidth-1 downto 0);
           ready_o: out std_logic;
           state_o: out std_logic_vector(1 downto 0)); --For checking the two internal states
end spi_slave_simple;

architecture behavioral of spi_slave_simple is

type state_type is (reset, shift, store);
signal present_state, next_state : state_type ;

type reg_state is (shifted, unshifted);
signal register_state : reg_state :=unshifted ;

type init_state is (yes, no);
signal core_init_flag: init_state := no ;

signal input_shift_register : std_logic_vector(datawidth-1 downto 0);

signal synced_mosi, synced_sck, synced_ss, sck_rise, sck_fall, ss_rise, ss_fall, init_done, store_done: std_logic;


component synchronizer is
    generic ( stages : natural := 3 );
    Port ( clk_i : in std_logic;
             i : in std_logic;
             o : out std_logic;
             rise_o: out std_logic;
             fall_o: out std_logic);
end component;

    
begin

ss_sync: synchronizer port map(clk_i => clk_i, i => ss_i, o => synced_ss, rise_o => ss_rise, fall_o => ss_fall);
sck_sync: synchronizer port map(clk_i => clk_i, i => sck_i, o => open, rise_o => sck_rise, fall_o => sck_fall);
mosi_sync: synchronizer port map(clk_i => clk_i, i => mosi_i, o => synced_mosi, rise_o => open, fall_o => open);

--Realises FFs with asynchronous reset
--Has factors affecting state transition in sensitivity list.
state_sync: process(rst_i, clk_i, next_state, core_init_flag, register_state) --ss, mosi, sck are synchronous to the system clock. No need to include in sensitivity list
begin
    if(rst_i = '0') then
        --Toggle current init flag state to trigger initialisation
        present_state <= reset;
    elsif(rising_edge(clk_i)) then
        if(core_init_flag = no) then
            present_state <= reset;
        elsif(synced_ss = '0') then
            if(sck_fall = '1') then
                present_state <= next_state;
            elsif(ss_rise = '1') then
                present_state <= store;
            end if;
        end if;  
    end if;
end process state_sync;

combinatorial: process(present_state, synced_mosi)
begin
case present_state is
when reset =>
    --Initialise all storage and outputs
    data_o<=(others => '0');
    input_shift_register<=(others => '0');
    ready_o <= '0';
    next_state<= shift;
    --Signal the sync process to change state
    core_init_flag <= yes;
when shift =>
    ready_o <= '0';
    input_shift_register<=input_shift_register(datawidth-2 downto 0) & synced_mosi;
    shift_register_state_o <= input_shift_register;
    next_state <= shift;
    register_state <= shifted;
when store =>
    data_o <= input_shift_register;
    ready_o<='1'; --Pulse this pin for one system clock cycle
    next_state <= shift;
    register_state <= unshifted;
when others =>
    next_state <= reset;
    register_state <= unshifted;

end case;
end process combinatorial;

with present_state select
state_o <= "00" when reset,
           "01" when shift,
           "10" when store,
          "00" when others;

end behavioral;