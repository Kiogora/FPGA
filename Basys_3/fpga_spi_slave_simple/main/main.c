/*
The spi transaction is as follows => command | address | data
For our purposes, we always do a full duplex Write and read. We write the next LED state and read the current LED state.
There is no command or address bits in the transaction, which contains data only.
*/ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "esp_system.h"
#include "driver/spi_master.h"
#include "esp_err.h"
#include "esp_log.h"

#define PIN_NUM_MISO 25
#define PIN_NUM_MOSI 23
#define PIN_NUM_CLK  19
#define PIN_NUM_CS   22

#define SCLK_SPEED 1000000UL

static const char* TAG = "[FPGA_SPI_SLAVE]";

uint16_t prev_state=0;

void set_read_basys3_leds(spi_transaction_t* transaction, spi_device_handle_t* handler)
{
    //Generate pseudorandom 16 bit value with initial default seed = 1 for traceability during reruns.
    //The rand() functions keeps current state between calls
    uint16_t ledstate=rand()%65536;
    ESP_LOGI(TAG, "Ledstate value is 0x%04x", ledstate);

    //Default initial state is one in order to differentiate it from actual value 0 read if ok during testing
    uint16_t readstate=0;

    //Stuff 16 bit data to transmit into tx_data array member in transaction struct.
    //Byte 0 is sent out first which should be the MSByte, sent as msb first.
    transaction->tx_data[0]=(uint8_t)((ledstate>>8) & 0xff);
    transaction->tx_data[1]=(uint8_t)(ledstate & 0xff);
    ESP_LOGI(TAG, "Upper byte of asembled state value sent firstly is 0x%02x", transaction->tx_data[0]);
    ESP_LOGI(TAG, "Lower byte of asembled state value sent lastly is 0x%02x", transaction->tx_data[1]);

    esp_err_t ret=spi_device_transmit(*(handler), transaction);

    if(ret == ESP_OK)
    {
	//Convert from four element byte array to 32 bit integer variable with endianness preserved
	readstate =  (((uint16_t)(transaction->rx_data[0]<<8))|transaction->rx_data[1]);
        ESP_LOGI(TAG, "Note: SPI read success");
	ESP_LOGI(TAG, "Value read is 0x%04x", readstate);
	if(readstate == prev_state)
	{
	    ESP_LOGI(TAG, "Value match :)\n");
        }
	else
	{
	    ESP_LOGE(TAG, "Value mismatch :(\n");
	}
    }
    else
    {
        ESP_LOGE(TAG, "ERROR: SPI read failure\n");
    }
    //Inittial may have a mismatch based on LED initialisation
    prev_state=ledstate;
    
}

void app_main()
{
    esp_err_t ret;
    spi_device_handle_t spi;
    //Configure the spi bus
    spi_bus_config_t buscfg=
    {
        .miso_io_num=PIN_NUM_MISO,
        .mosi_io_num=PIN_NUM_MOSI,
        .sclk_io_num=PIN_NUM_CLK,
        .quadwp_io_num=-1,
        .quadhd_io_num=-1
    };

    spi_device_interface_config_t devcfg=
    {
        .clock_speed_hz=SCLK_SPEED,             //Clock out at SCLK_SPEED Hz
        .address_bits=0,			//No address bits in transaction
	.command_bits=0,			//No command bits in transaction
        .mode=0,                                //SPI mode 0(CPOL=0,CPHA=0)
        .spics_io_num=PIN_NUM_CS,               //CS pin
        .queue_size=7,                          //We want to be able to queue 7 transactions at a time
    };
    //Initialize the SPI bus
    ret=spi_bus_initialize(HSPI_HOST, &buscfg, 1);
    assert(ret==ESP_OK);
    //Attach the FPGA to the SPI bus
    ret=spi_bus_add_device(HSPI_HOST, &devcfg, &spi);
    assert(ret==ESP_OK);

    spi_transaction_t tx;
    //Zero out the memory statically allocated for the transaction struct on the stack.
    memset(&tx, 0, sizeof(tx));
    //Store transmit and receive data in the transaction struct itself as both are 4 bytes and less.
    tx.flags=SPI_TRANS_USE_TXDATA|SPI_TRANS_USE_RXDATA;
    //Total number of LEDs to write/read on the basys3 board is 16
    tx.length=16;

    while(1)
    {
        set_read_basys3_leds(&tx, &spi);
	vTaskDelay(10 / portTICK_PERIOD_MS);
    }

}
