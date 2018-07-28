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

#define SCLK_SPEED 10000000UL

static const char* TAG = "[FPGA_SPI_SLAVE]";

void set_read_basys3_leds(spi_transaction_t* transaction, spi_device_handle_t* handler)
{
    //Generate pseudorandom 16 bit value with initial default seed = 1 for traceability during reruns.
    //The rand() functions keeps current state between calls
    uint16_t ledstate=rand()%65536;

    //Default initial state is one in order to differentiate it from actual value 0 read if ok during testing
    uint32_t readstate=1;

    //Stuff 16 bit data to transmit into tx_data array member in transaction struct.
    transaction->tx_data[0]=(uint8_t)(ledstate & 0x00ff);
    transaction->tx_data[1]=(uint8_t)(ledstate & 0xff00);

    esp_err_t ret=spi_device_transmit(*(handler), transaction);

    if(ret == ESP_OK)
    {
	//Convert from four element byte array to 32 bit integer variable with endianness preserved
	for(int i=0; i<=3; i++)
	{
            readstate += (transaction->rx_data[i] << (i*8)); //Pointer points to transaction rx array
	}
        ESP_LOGI(TAG, "Note: SPI read success");
	ESP_LOGI(TAG, "Value read is %d", readstate);
    }
    else
    {
        ESP_LOGE(TAG, "ERROR: SPI read failure");
    }
    
}

void app_main()
{
    esp_err_t ret;
    spi_device_handle_t spi;
    //Configure the spi bus
    spi_bus_config_t buscfg={
        .miso_io_num=PIN_NUM_MISO,
        .mosi_io_num=PIN_NUM_MOSI,
        .sclk_io_num=PIN_NUM_CLK,
        .quadwp_io_num=-1,
        .quadhd_io_num=-1
    };

    spi_device_interface_config_t devcfg={
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
    //Attach the LCD to the SPI bus
    ret=spi_bus_add_device(HSPI_HOST, &devcfg, &spi);
    assert(ret==ESP_OK);

    spi_transaction_t tx;
    memset(&tx, 0, sizeof(tx));
    //Store transmit and receive data in the transaction struct itself as both are 4 bytes and less.
    tx.flags=SPI_TRANS_USE_TXDATA|SPI_TRANS_USE_RXDATA;
    tx.length=16;

    while(1)
    {
        set_read_basys3_leds(&tx, &spi);
	vTaskDelay(1000 / portTICK_PERIOD_MS);
    }

}
