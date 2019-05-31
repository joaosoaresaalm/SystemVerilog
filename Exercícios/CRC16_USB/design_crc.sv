module crc16(crc16_di, crc16_en, crc16_o, reset_l, clk);
  
//  I/O definition
input crc16_di; //CRC16 data (H)
input crc16_en; //CRC16 enable (H)
input reset_l; // Reset (L)
input clk;     //Clock (X)
output[15:0] crc16_o; //CRC16 out (H)

// Regs para logic random
reg crc16_0_in, crc16_2_in, crc16_15_in;
  
// Regs para DFFs
reg [15:0] crc16_o;
  
always @(crc16_di or crc16_o or crc16_0_in)
  begin
    crc16_0_in <= (crc16_di ^ crc16_o[15]);
    crc16_2_in <= ~(crc16_0_in ^crc16_o[1]);
    crc16_15_in <= ~(crc16_0_in ^crc16_o[14]);
  end

  always @(posedge(clk) or negedge(reset_l))
  begin
    if(~reset_l) crc16_o[15:0] <= 1'b0;
    else
    begin
      if(~crc16_en) crc16_o[15:0] <= crc16_o[15:0];
      else
      begin
        crc16_o[15] <= crc16_15_in;
        crc16_o[14:3] <= crc16_o[13:2];
        crc16_o[2] <= crc16_2_in;
        crc16_o[1] <= crc16_o[0];
        crc16_o[0] <= crc16_0_in;
      end
	end
  end
endmodule