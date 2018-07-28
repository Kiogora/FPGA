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
           miso: out std_logic;
           LED: inout std_logic_vector(datawidth-1 downto 0) := (others => '0'));
           --ready: out std_logic);
end spi_slave_simple;

architecture behavioral of spi_slave_simple is
    -- Internal entity signals
    signal data_temp_in : std_logic_vector(datawidth-1 downto 0) := (others => '0');
    signal data_temp_out : std_logic_vector(datawidth-1 downto 0):= (others => '0');
    
begin

--Operations at start and end of transaction.
    process (ss)
    begin
        if rising_edge(ss) then
            --Write data received from mosi in buffer of transaction width to the LEDs
            --The data should be read out dependent on the ready port by external entity
            LED <= data_temp_in;
            --Signal that data in buffer is ok to  read out.
            --ready <= '1';
        end if;
    end process;
    
    process (ss)
    begin
        --Start of spi transaction
        if falling_edge(ss) then
            --Signal that data in buffer is in flux. Should not be trusted
            --ready <= '0';
            --Read data from LEDs into buffer of the transaction width to be written to mosi at each sck rising edge
            data_temp_out <= LED;
        end if;
    end process;
    
--Operations within the transaction itself.
    process (sck)
        begin
        if rising_edge(sck) then
            if ss = '0' then
                --As long as there is a rising edge on sck when ss is active low, always left shift the data in buffer. Even when in error
                --Write to miso and read from mosi concurrently
                --A transaction on the spi bus occurs by default as msb first thus we unpack msb to lsb on mosi and miso.
                --Left shift [length-1:1]<-[length-2:0] then write to index 0 with value from mosi
                --This means that we do nothave to keep track of an index variable, just the buffer length
                data_temp_in(datawidth-1 downto 0) <= data_temp_in(datawidth-2 downto 0) & mosi;           
                --Write msb to the spi bus and left shift the buffer data while adding zeros to the buffer lsb at each sck rising edge 
                miso <= data_temp_out(datawidth-1);
                data_temp_out(datawidth-1 downto 0) <= data_temp_out(datawidth-2 downto 0) & '0';
--            else
--                --Set the mosi into Hi-Z if this slave is not selected. Overkill for this example as there is only one slave on SPI bus.
--                mosi<=(others => 'z');
            end if;
        end if;
    end process;
    

end behavioral;