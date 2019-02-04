/**
 * System signals and addresses.
 */

#ifndef CONSTANTS_H
#define CONSTANTS_H 1

//________System signals____________
#define SIGNAL_WRADDR 			0x01
#define SIGNAL_RDCNT			0x02
#define SIGNAL_WRDATA			0x08
#define SIGNAL_CNT				0x10
#define SIGNAL_WRDATA32			0x20
//______System addresses____________
/*    		  DAC			     */
#define DAC1_CALIBDATA1_ADDR	0x02
#define DAC1_CALIBDATA2_ADDR	0x03
#define DAC2_CALIBDATA1_ADDR	0x04
#define DAC2_CALIBDATA2_ADDR	0x05
#define DAC3_CALIBDATA1_ADDR	0x06
#define DAC3_CALIBDATA2_ADDR	0x07
#define DAC4_CALIBDATA1_ADDR	0x08
#define DAC4_CALIBDATA2_ADDR	0x09
#define DAC_CMD_ADDR			0x23
#define DAC_DATA1_ADDR			0x24
#define DAC_DATA2_ADDR			0x25
#define DAC_DATA32_ADDR			0x47
//__________________________________
/*   		  GATE	 			  */
#define GATE_CMD_ADDR			0x20
#define GATE_STATUS_ADDR		0x21
#define GATE_DATA_ADDR			0x22
//__________________________________
/* 			GENERATOR	 		  */
#define GEN_DATA32_ADDR			0x53
//__________________________________
/*  		COUNTER 			  */
#define CNT_CMD_ADDR			0x26
#define CNT_STATUS_ADDR			0x27
#define CNT_CH1_DATA_ADDR		0x28
#define CNT_CH2_DATA_ADDR		0x30
#define CNT_CH3_DATA_ADDR		0x34
#define CNT_CH4_DATA_ADDR		0x38

//__________________________________
/*         COMMANDS               */
#define CMD_INIT				0x10			/**< INIT command code. 		*/
#define CMD_HELP				0x20			/**< HELP command code. 		*/
#define CMD_INTR				0x30			/**< INTERRUPT command code. 	*/
#define CMD_ADDR				0x40			/**< ADDR command code. 		*/
#define CMD_RADDR				0x50			/**< RADDR command code. 		*/
#define CMD_DATA				0x60			/**< DATA command code. 		*/
#define CMD_RDATA				0x70			/**< RDATA command code.		*/
#define CMD_FRQ					0x80			/**< FREQ command code.			*/
#define CMD_RFRQ				0x90			/**< RFREQ command code.		*/
#define CMD_GATE				0xA0			/**< GATE command code.			*/
#define CMD_RGATE				0xB0			/**< RGATE command code.		*/
#define CMD_RST					0xC0			/**< RESET command code.		*/
#define CMD_DAC					0xD0			/**< DAC command code.			*/

//__________________________________
/*         CONSTANTS			  */
#define MARK_INP			  0xDEAF			/**< Input bits sequence mark	*/
#define MARK_OUT			  0xDEAD			/**< Output bits sequence mark	*/
#define MARK_OK				  	0x08			/**< OK response mark			*/
#define MARK_ERR				0x01			/**< Error response mark		*/
#define MARK_BUSY				0x02			/**< Counter busy mark			*/
#endif
