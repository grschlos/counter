/*******************************************************************************
*   Copyright 2016 Guido Socher, Konstantin Shchablo
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
* Information.
* Company: JINR PMTLab
* Author: Shchablo Konstantin
* Email: ShchabloKV@gmail.com
* Tel: 8-906-796-76-53 (russia)
*******************************************************************************/

/*******************************************************************************
 * IP/ARP/UDP/TCP functions
 *
 * Chip type           : NIOSII with ENC28J60
*******************************************************************************/

#ifndef IP_ARP_UDP_TCP_H
#define IP_ARP_UDP_TCP_H

#include <io.h>
#include "../eth_bsp/system.h"
#include <unistd.h>
#include "../eth_bsp/HAL/inc/alt_types.h"
#include "../eth_bsp/drivers/inc/altera_avalon_pio_regs.h"
#include "../eth_bsp/drivers/inc/altera_avalon_spi_regs.h"
#include "../eth_bsp/drivers/inc/altera_avalon_spi.h"

extern void init_ip_arp_udp_tcp(unsigned char* mymac, unsigned char* myip, unsigned char wwwp);
extern unsigned char eth_type_is_arp_and_my_ip(unsigned char* buf, unsigned int len);
extern unsigned char eth_type_is_ip_and_my_ip(unsigned char* buf, unsigned int len);
extern void make_arp_answer_from_request(unsigned char* buf);
extern void make_echo_reply_from_request(unsigned char* buf, unsigned int len);
extern void make_udp_reply_from_request(unsigned char* buf, char* data,
unsigned char datalen, unsigned int port);

extern void make_tcp_synack_from_syn(unsigned char* buf);
extern void init_len_info(unsigned char* buf);
extern unsigned int get_tcp_data_pointer(void);
extern unsigned int fill_tcp_data_p(unsigned char* buf, unsigned int pos, const unsigned char* progmem_s);
extern unsigned int fill_tcp_data(unsigned char* buf, unsigned int pos, const char* s);
extern void make_tcp_ack_from_any(unsigned char* buf);
extern void make_tcp_ack_with_data(unsigned char* buf, unsigned int dlen);

#endif
