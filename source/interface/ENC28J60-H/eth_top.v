//------------------------------------------------------------------------------
//  Copyright 2016 Konstantin Shchablo
//  Copyright 2018 Ilya Butorov
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//      Information
// Company: JINR PMTLab
// Author: Ilya Butorov
// Email: butorov.ilya@gmail.com
//------------------------------------------------------------------------------

module eth_top(

	input  wire  reset_n,        
	output wire  out_port_from_the_LAN_RST,
	output wire  out_port_from_the_LAN_CS,  
	input  wire  MISO_to_the_LAN,           
	output wire  MOSI_from_the_LAN,        
	output wire  SCLK_from_the_LAN,        

	input  wire  clk,                       

	input  wire  in_port_to_the_LAN_NINT,   

	input  wire [31:0]time_export,
	input  wire [31:0]ch1_count_export,
	input  wire [31:0]ch2_count_export,
	input  wire [31:0]ch3_count_export,
	input  wire [31:0]ch4_count_export,

	output wire [7:0]addr_export,
	input  wire [7:0]rdata_export,
	output wire [7:0]wdata_export,

	output wire		 swrite_export,
	output wire      sread_export,
	output wire		 cread_export,  		// counter read signal
	output wire		 addr_write_export,     // addr write signal

	/* signals for start and stop run */
	output wire	startStep_export,			// start signal to DAC
	input wire	stopStep_export,			// stop signal from counter

	output wire  		swrite32_export,
	output wire [31:0]  wdata32_export,
	input  wire [31:0]  rdata32_export
	);

wire  SS_n_from_the_LAN;
wire  dclk_from_the_epcs; 
wire  sce_from_the_epcs;
wire  sdo_from_the_epcs;
wire  data0_to_the_epcs; 

wire	[7:0]signals_export_array;
wire	[7:0]status_export_array;
wire 		  rwrite32_export;

assign status_export_array[4] = stopStep_export;

assign rwrite32_export = signals_export_array[6];
assign swrite32_export = signals_export_array[5];
assign startStep_export = signals_export_array[4];
assign swrite_export = signals_export_array[3];
assign sread_export = signals_export_array[2];
assign cread_export = signals_export_array[1];
assign addr_write_export = signals_export_array[0];

sopc sopc_inst (

	reset_n,           

	out_port_from_the_LAN_RST,
	out_port_from_the_LAN_CS,
	MISO_to_the_LAN,      
	MOSI_from_the_LAN,       
	SCLK_from_the_LAN,         
	SS_n_from_the_LAN,      

	clk,                      
	in_port_to_the_LAN_NINT,   

	dclk_from_the_epcs,      
	sce_from_the_epcs,       
	sdo_from_the_epcs,    
	data0_to_the_epcs,

	time_export,        
	ch1_count_export,


	addr_export,         
	rdata_export,            

	wdata_export,      

	signals_export_array,
	status_export_array,

	wdata32_export,
	rdata32_export,
	ch2_count_export,
	ch3_count_export,
	ch4_count_export
);

endmodule
