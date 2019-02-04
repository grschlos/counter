module eth_top (
		input  wire  reset_n,                   //             clk_clk_in_reset.reset_n
		output wire  out_port_from_the_LAN_RST, //  LAN_RST_external_connection.export
		output wire  out_port_from_the_LAN_CS,  //   LAN_CS_external_connection.export
		input  wire  MISO_to_the_LAN,           //                 LAN_external.MISO
		output wire  MOSI_from_the_LAN,         //                             .MOSI
		output wire  SCLK_from_the_LAN,         //                             .SCLK
		output wire  SS_n_from_the_LAN,         //                             .SS_n
		input  wire  clk,                       //                   clk_clk_in.clk
		input  wire  in_port_to_the_LAN_NINT,   // LAN_NINT_external_connection.export
		output wire  dclk_from_the_epcs,        //                epcs_external.dclk
		output wire  sce_from_the_epcs,         //                             .sce
		output wire  sdo_from_the_epcs,         //                             .sdo
		input  wire  data0_to_the_epcs          //                             .data0
	);
sopc sopc_inst (
		
		reset_n,                   //             clk_clk_in_reset.reset_n
		
		out_port_from_the_LAN_RST, //  LAN_RST_external_connection.export
		out_port_from_the_LAN_CS,  //   LAN_CS_external_connection.export
		MISO_to_the_LAN,           //                 LAN_external.MISO
		MOSI_from_the_LAN,         //                             .MOSI
		SCLK_from_the_LAN,         //                             .SCLK
		SS_n_from_the_LAN,         //                             .SS_n
		
		clk,                       //                   clk_clk_in.clk
		in_port_to_the_LAN_NINT,   // LAN_NINT_external_connection.export
		
		dclk_from_the_epcs,        //                epcs_external.dclk
		sce_from_the_epcs,         //                             .sce
		sdo_from_the_epcs,         //                             .sdo
		data0_to_the_epcs
);
endmodule