module TWOCOUNTERS

  imports INT

  syntax State ::= state(Int,Int)

  rule state(M, N) => state((M -Int 1), (N +Int M))
  requires M >=Int 1

endmodule
