    
module alu(
  
    input logic signed [3:0] a,
    input logic signed [3:0] b,
  	input logic [3:0] s,
  	output logic signed [4:0] f,
    input logic m,
  	output logic[3:0] function_output,
  output bit comparator_output,	// entender o que cada var significa		
  	output bit carry_generate,			
  	output bit carry_propagate,			
  	output bit carry_out	
);

always_comb begin
    if (m) begin
        case (s)
            4'b0000 : f = ~a;
          	4'b0001 : f = ~(a & b);
          	4'b0010 : f = ~a + ~b;
            4'b0011 : f = '1;
            4'b0100 : f = ~a + ~b;
            4'b0101 : f = ~b;
            4'b0110 : f = ~a ^ ~b;
            4'b0111 : f = a + ~b;
            4'b1000 : f = ~a & b;
            4'b1001 : f = a ^ b;
            4'b1010 : f = b;
            4'b1011 : f = a + b;
            4'b1100 : f = '0;
            4'b1101 : f = a & ~b;
            4'b1110 : f = a & b;
            4'b1111 : f = a;
            default : f = '0;
        endcase
    end else begin
        case (s)
            4'b0000 : f = a - 1;
          	4'b0001 : f = (a & b) - 1;
          	4'b0010 : f = (a & ~b) - 1;
            4'b0011 : f = -1;
            4'b0100 : f = a + (a | ~b);
          	4'b0101 : f = (a & b) + (a | ~b);
            4'b0110 : f = a - b - 1;
          	4'b0111 : f = (a | ~b);
          	4'b1000 : f = a + (a | b);
            4'b1001 : f = a + b;
            4'b1010 : f = (a & ~b) + (a | b);
            4'b1011 : f = a + b;
            4'b1100 : f = a + ( a << 1); 
            4'b1101 : f = (a & b) + a;
            4'b1110 : f = (a & ~b) - a; 
            4'b1111 : f = a; 
            default : f = '0;
        endcase
    end
end
  
  assign function_output = f[3:0]; // ver o que isso significa
  
  assign carry_out = ~(f[4] & ~m);
  assign carry_propagate = (~carry_out | (&function_output | ~|function_output)) & ~m; 
  assign carry_generate = ~carry_out;
  assign comparator_output = &(~function_output);
endmodule: alu
