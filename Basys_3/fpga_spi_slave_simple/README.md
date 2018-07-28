ESP32-master FPGA-slave SPI communication
=========================================

Purpose of this project is to test spi communication between an ESP32 and Basys3 FPGA board with the Artix-7 35T FPGA.

## Purpose 

Test the spi communication between ESP32 master and FPGA slave.

## Operation

Read current state of LEDs on the Basys3 board and set the state of the LEDs. The FPGA initially sets all LEDs to the off state.

The spi transactions shall be full duplex with a transaction size of 2 bytes to set the state of all 16 LEDs. The ESP32 shall check the read current LEDs state and send the next state randomly by a PRNG with a fixed seed after a periodic interval.

If the read state matches the state written previously, it reports back an okay status to the user via UART to the computer. If not, it reports a failure status.

The status of the communication is inspected via a logic analyzer for the first few transactions and images stored in the logic_analyzer_cap folder.


