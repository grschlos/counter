//------------------------------------------------------------------------------
//  Copyright 2016 Shchablo Konstantin
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
// Information.
// Company: JINR PMTLab
// Author: Shchablo Konstantin
// Email: ShchabloKV@gmail.com
// Tel: 8-906-796-76-53 (russia)
//------------------------------------------------------------------------------

module command #(parameter CLK_FREQ=200000000)
(
	input	clk, input reset, input init,
	output reg reset_out,

	input we_addr_vjtag,
	input [7:0]addr_vjtag,

	input we_addr_export,
	input [7:0]addr_export,

	output reg [7:0]addr,

	input write_vjtag,
	input write_export,
	input write32_export,

	output reg sw_out,
	output reg sw_out32,	

	input [7:0]data_in_export,
	input [7:0]data_in_vjtag,

	input [31:0]data_in32_export,

	output reg [7:0]data_out,
	output reg [31:0]data_out32
); 

	(* syn_encoding = "safe" *) reg [5:0] state;

	parameter D0 = 0, R0 = 1, R1 = 2, SW0 = 3, SW1 = 4, vjtag_AD0 = 5, vjtag_AD1 = 6, export_AD0 = 7, export_AD1 = 8, INIT0 = 9, SW0_export = 10, SW1_export = 11, SW0_export32 = 12, SW1_export32 = 13;
	integer delay = CLK_FREQ/2500000;

	// Determine the next state
	integer res_count;
	integer sw_count;
	integer AD_count;
	always @ (posedge clk) begin
			case (state)
				D0: begin

					reset_out = 1'b0;
					sw_out  = 1'b0;
					sw_out32  = 1'b0;

					 if(!reset || (addr == 8'h01 && data_out == 8'h02))
							state <= R0;
					 if(write_vjtag)
							state <= SW0;
					if(write_export)
							state <= SW0_export;
					if(write32_export)
							state <= SW0_export32;
					 if(we_addr_vjtag)
							state <= vjtag_AD0;
					 if(we_addr_export)
							state <= export_AD0;
					 if(init)
							state <= INIT0;
				end

			 // reset
				R0: begin
					res_count <= CLK_FREQ/1000;
					state <= R1;
					end
				R1:
					if (res_count > 0) begin
						state <= R1;
						res_count <= res_count - 1;
						
						addr <= 8'h00;
						reset_out = 1'b1;
					end
					else begin
						state <= D0;
					end

				// signal write vjtag
				SW0: begin
					sw_count <= delay;
					state <= SW1;
					end
				SW1:
					if (sw_count > 0) begin
						state <= SW1;
						sw_count <= sw_count - 1;
						
						sw_out  = 1'b1;
						data_out <= data_in_vjtag;
					end
					else begin
						state <= D0;
					end

				// signal write export
				SW0_export: begin
					sw_count <= delay;
					state <= SW1_export;
					end
				SW1_export:
					if (sw_count > 0) begin
						state <= SW1_export;
						sw_count <= sw_count - 1;
						
						sw_out  = 1'b1;
						data_out <= data_in_export;
					end
					else begin
						state <= D0;
					end

				// signal write32 export
				SW0_export32: begin
					sw_count <= delay;
					state <= SW1_export32;
					end
				SW1_export32:
					if (sw_count > 0) begin
						state <= SW1_export32;
						sw_count <= sw_count - 1;
						
						sw_out32  = 1'b1;
						data_out32 <= data_in32_export;
					end
					else begin
						state <= D0;
					end

				// addr vjtag
				vjtag_AD0: begin
					AD_count <= delay;
					state <= vjtag_AD1;
					end
				vjtag_AD1:
					if (AD_count > 0) begin
						state <= vjtag_AD1;
						AD_count <= AD_count - 1;
						
						addr <= addr_vjtag;
					end
					else begin
						state <= D0;
					end

				// addr eth	
				export_AD0: begin
					AD_count <= delay;
					state <= export_AD1;
					end
				export_AD1:
					if (AD_count > 0) begin
						state <= export_AD1;
						AD_count <= AD_count - 1;

						addr <= addr_export;	
					end
					else begin
						state <= D0;
					end

				INIT0: begin
					addr <= 0;
					state <= D0;
				end

				default:
						state <= D0;
			endcase
	end

endmodule
