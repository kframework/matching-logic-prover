```k
module MATCHING-LOGIC-PROVER-SYNTAX
  syntax K ::= "foo"
             | "bar"
endmodule

module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  rule foo => bar
endmodule
```
