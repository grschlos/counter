/*******************************************************************************
*   Copyright 2016 Guido Socher, Konstantin Shchablo
*   Copyright 2018 Ilya Butorov
*
*   This program is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with this program.  If not, see <https://www.gnu.org/licenses/>.
*******************************************************************************/

/*******************************************************************************
*       Information
*  Company: JINR PMTLab
*  Author: 	Ilya Butorov
*  Email: 	butorov.ilya@gmail.com
*******************************************************************************/

#include <string.h>
#include <stdio.h>
#include "simple_server.h"
#include <io.h>
#include "../eth_bsp/system.h"
#include <unistd.h>
#include "../eth_bsp/HAL/inc/alt_types.h"
#include "../eth_bsp/drivers/inc/altera_avalon_pio_regs.h"
#include "../eth_bsp/drivers/inc/altera_avalon_spi_regs.h"
#include "../eth_bsp/drivers/inc/altera_avalon_spi.h"

#define  SPInet_Init   SPI2_Init

// HARDWARE DEFINE
#define LED             ( 1 << 5 )              // PB5: LED D2

#define BP2             0x2000                     // PC13: BP2
#define BP3             0x0001                     // PA0 : BP3

#define UP              0x0800                     // PB11: UP
#define RIGHT           0x1000                     // PB12: RIGHT
#define LEFT            0x2000                     // PB13: LEFT
#define DOWN            0x4000                     // PB14: DOWN
#define OK              0x8000                     // PB15: OK

#define JOYSTICK        0xF800                     // JOYSTICK ALL KEYS

void SPI2_Init(void);

void SPI2_Init(void)
{
	IOWR_ALTERA_AVALON_SPI_CONTROL(LAN_BASE,0x00);
}


void Delay(unsigned long int nCount)
{
   for (; nCount != 0; nCount--);
}
int main(void)
{
	 SPInet_Init();

	 simple_server();
	 return 0;
}
