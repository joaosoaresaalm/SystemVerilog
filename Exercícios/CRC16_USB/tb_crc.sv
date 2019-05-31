module crc16_sys;
  reg clk,reset_l, crc16_di, crc16_en;
  wire [15:0] crc16_o;
  integer i, mask;
  reg [7:0] crc16_di_8[15:0];
  
  crc16 crc16(.crc16_di(crc16_di), .crc16_en(crc16_en), .crc16_o(crc16_o), .reset_l(reset_l), .clk(clk));
  
  
  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars(1,clk,reset_l,crc16_di, crc16_en, crc16_o, reset_l, clk);
  
      $readmemh("crc16_di.dat", crc16_di_8);
      
      clk <= 1'b1;
      reset_l  <= 1'b0;
      crc16_en <= 1'b0;
      crc16_di <= 1'b0;
#110  reset_l <= 1'b1;
#10   crc16_di <= 1'b0;
      
      for(i = 0; i < 16; i = i + 1)
      begin
        for(mask = 8'h80; mask > 0; mask = (mask >> 1))
        begin
          crc16_di_gen;
        end
      end
      #100 $finish;
    
    end
  
  always #25 clk <= ~clk;
   
  task crc16_di_gen;
  begin
    if(((i % 8) == 1) && (mask == 8)) reset_l <= 1'b0;
    else reset_l <= 1'b1;
    if((crc16_di_8[i] & mask) == 0) #50 crc16_di <= 1'b0;
    else #50 crc16_di <= 1'b1;
    if(((i % 8) > 1) && ((i % 8) < 6)) crc16_en <= 1'b1;
    else crc16_en <= 1'b0;
  end

endtask
endmodule
    