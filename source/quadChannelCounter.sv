//------------------------------------------------------------------------------
// Copyright [2016] [Shchablo Konstantin]
//
// Licensed under the Apache License, Version 2.0 (the "License"); 
// you may not use this file except in compliance with the License. 
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, 
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. 
// See the License for the specific language governing permissions and
// limitations under the License.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Information.
// Company: JINR PMTLab
// Author: Shchablo Konstantin
// Email: ShchabloKV@gmail.com
// Tel: 8-906-796-76-53 (russia)
//-------------------------------------------------------------------------------

module quadChannelCounter(

	input clock50Mhz,

	input key_restart,

	output READ,
	output nCS,
	output nRESET,
	output nLDAC,
	output [1:0]dac_chn_out,
	output [11:0]dac_data_out,

	output wire  out_port_from_the_LAN_RST,
	output wire  out_port_from_the_LAN_CS, 
	input  wire  MISO_to_the_LAN,          
	output wire  MOSI_from_the_LAN,
	output wire  SCLK_from_the_LAN,        
	input  wire  in_port_to_the_LAN_NINT,  

	input [3:0]count,
	output t_clk
  );

localparam FRQ=50000000;
wire clk;

// Instantiation initializer. Signals and registers are declared.
wire init;
wire reset;
assign clk=clock50Mhz;
initializer#(.clk_freq(FRQ)) initializer_inst
(
	clk,
	init
);

wire [7:0]data_in;

// Instantiation vjtag. Signals and registers are declared.
wire [7:0]data_vjtag_out;
wire [7:0]address_vjtag;
wire addr_write_vjtag;
wire write_vjtag;
wire addr_read_vjtag;
vjtag vjtag_inst_interface
(
	init,
	data_in, 
	data_vjtag_out, 
	address_vjtag,
	write_vjtag,
	addr_write_vjtag
);

// Instantiation eth. Signals and registers are declared.
wire [31:0]time_export;
wire [31:0]signals_export[3:0];

wire [7:0]addr_export;

wire [7:0]wdata_export;
wire swrite_export;
wire sread_export; 

wire cread_export;          
wire addr_write_export;

wire startStep_export;
wire stopStep_export;

wire swrite32_export;
wire [31:0]wdata32_export;
wire [31:0]rdata32_export;

eth_top eth_inst
(
	key_restart,
	out_port_from_the_LAN_RST,
	out_port_from_the_LAN_CS,
	MISO_to_the_LAN,
	MOSI_from_the_LAN,
	SCLK_from_the_LAN,
	clk,		// clock50Mhz
	in_port_to_the_LAN_NINT,

	time_export,
	signals_export[0],
	signals_export[1],
	signals_export[2],
	signals_export[3],

	addr_export,
	data_in, 		// output data (from FOGA)
	wdata_export, 	// input data (from NIOS II)

	swrite_export,
	sread_export,
	cread_export,
	addr_write_export,

	startStep_export,
	stopStep_export,

	swrite32_export,
	wdata32_export,
	rdata32_export
);

// Instantiation command. Signals and registers are declared.
wire write;
wire write32;
wire [7:0]data;
wire [31:0]data32;
wire [7:0]addr;
command#(.CLK_FREQ(FRQ)) command_inst
(
	clk, key_restart, //clock200Mhz
	init, reset,

	addr_write_vjtag,
	address_vjtag,

	addr_write_export,
	addr_export,

	addr,

	write_vjtag,
	swrite_export,
	swrite32_export,

	write,
	write32,

	wdata_export,
	data_vjtag_out,
	wdata32_export,

	data,
	data32
);	

// Instantiation counter. Signals and registers declared.
wire [7:0]data_counter;
wire start_counter;
//reg [3:0]in_cnt;
//reg [7:0]cnt_switch;
assign t_clk = clk;

/*always @(posedge clk) begin
	if (init) begin
		cnt_switch <= 1;
	end
	if (write) begin
		if (addr==1'b1) begin
			cnt_switch <= data;
		end
	end
end

always @(cnt_switch[0]) begin
	if(cnt_switch) begin
		in_cnt[0] <= count[0];
		in_cnt[1] <= count[1];
		in_cnt[2] <= count[2];
		in_cnt[3] <= count[3];
	end
	else begin
		in_cnt[0] <= clk;
		in_cnt[1] <= clk;
		in_cnt[2] <= clk;
		in_cnt[3] <= clk;
	end
end */

counter#(.CLK_FREQ(FRQ)) counter_inst
(
	clk,
	addr,
	data, data_counter,
	write, init, reset,

	time_export,
	signals_export,

	start_counter,
	stopStep_export,

	count 
);
  
// Instantiation DAC. Signals and registers declared.
wire [7:0]data_DAC;
wire [3:0]channels_DAC;
 dac dac_inst
(
 clk,
 init, reset,
 write, addr,
 data,
 data_DAC,
 
 write32,
 data32,
 
 READ,
 nCS,
 nRESET,
 nLDAC,
 dac_chn_out,
 dac_data_out,
 
 startStep_export,
 start_counter
);


reg [7:0]version;
//reg [7:0]switch;
assign version[7:0] = 8'b00010000;
//assign switch[7:0] = cnt_switch;

// Instantiation selector. Signals and registers declared.
selector selector_data_vjtag_in(
 addr,
 data_counter,
 version,
 //switch,
 data_DAC,
 
 data_in
);

endmodule
