module ULA;

  logic[3:0] a;
  logic[3:0] b;
  logic[3:0] s;
  logic m;

  wire[4:0] f;
  integer i;

  ula74181 duv(.a(a), .b(b), .s(s), .f(f), .m(m));

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $monitor("A = %b, B = %b, M = %d, S = %b, F = %b", a, b, m, s, f);

   end

  initial begin
    a = 3;
    b = 6;
    m = 1'b0;
    s = 4'b0000;

    for (i=0;i<=14;i=i+1)
      begin
        #5 s = s + 4'b0001;
      end;
  end

endmodule

