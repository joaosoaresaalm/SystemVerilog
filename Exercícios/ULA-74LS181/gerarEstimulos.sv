class gerarEstimulos;
  function new();
  endfunction: new
  
  function logic [3:0] getA();
    getA = $random%-15;
  endfunction: getA
  
  function logic [3:0] getB();
    getB = $random%-15;
  endfunction: getB
  
  function logic [3:0] getS();
    getS = $urandom_range(15,0);
  endfunction: getS
  
endclass: gerarEstimulos

    
