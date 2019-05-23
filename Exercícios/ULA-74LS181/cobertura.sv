class cobertura;
  protected logic [3:0] a;
  protected logic [3:0] b;
  protected logic [3:0] s;
  protected logic clock = 0;
  
  function new();
    cobert = new();
  endfunction: new
  
  covergroup cobert @(posedge clock);
    cobA: coverpoint this.a;
    cobB: coverpoint this.b;
    cobS: coverpoint this.s {
      bins sels = {[0:15]};
    }
    selAB: cross cobA, cobB, cobS;
    
  endgroup: cobert
  
  function void valor(logic [3:0] a, logic [3:0] b, logic [3:0] s);
    this.a = a;
    this.b = b;
    this.s = s;
    this.clock = ~clock;
  endfunction: valor
  
  function void mostrarCobertura();
    $display("Cobertura = %.2f%%",cobert.get_coverage());
  endfunction:mostrarCobertura
  
  function int get_coverage();
    get_coverage = cobert.get_coverage();
  endfunction:get_coverage
  
endclass: cobertura
