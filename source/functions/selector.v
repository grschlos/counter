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

module selector(
 input [7:0]addr,
 input [7:0]counter,
 input [7:0]version,
 //input [7:0]switch,
 input [7:0]dac,
 output reg [7:0]data
);

always @*
begin
   case(addr)
      8'h00:  data = version;
	   //8'h01:  data = switch;
   
      8'h02:  data = dac;
      8'h03:  data = dac;
      8'h04:  data = dac;
      8'h05:  data = dac;
      8'h06:  data = dac;
      8'h07:  data = dac;
      8'h08:  data = dac;
      8'h09:  data = dac;
      8'h23:  data = dac;
      8'h24:  data = dac;
      8'h25:  data = dac;
      8'h47:  data = dac;
      8'h48:  data = dac;

      8'h26:  data = counter;
      8'h27:  data = counter;
      8'h28:  data = counter;
      8'h29:  data = counter;
      8'h2a:  data = counter;
      8'h2b:  data = counter;
      8'h2c:  data = counter;
      8'h2d:  data = counter;
      8'h2e:  data = counter;
      8'h2f:  data = counter;
      8'h30:  data = counter;
      8'h31:  data = counter;
      8'h32:  data = counter;
      8'h33:  data = counter;
      8'h34:  data = counter;
      8'h35:  data = counter;
      8'h36:  data = counter;
      8'h37:  data = counter;
      8'h38:  data = counter;
      8'h39:  data = counter;
      8'h3a:  data = counter;
      8'h3b:  data = counter;
      default:
  	     data = 0;
   endcase
end

endmodule
