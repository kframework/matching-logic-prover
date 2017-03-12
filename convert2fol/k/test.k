// Copyright (c) 2012-2016 K Team. All Rights Reserved.

module TEST-SYNTAX
  syntax Sort  ::= Id 
  syntax Sorts ::= ".Sorts"    [function]
                 | Sort
				 | Sorts Sorts [right, function, assoc, unit(.Sorts), element(Sort)]
  syntax Sorts ::= rev(Sorts)

endmodule

module TEST
  import TEST-SYNTAX
  
  configuration <T> <k> $PGM:Sorts </k> </T>
  
  rule rev(S:Sort Ss:Sorts) => Ss S
endmodule