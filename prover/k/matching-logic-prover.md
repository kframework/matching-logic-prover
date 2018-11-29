```k
requires "kore.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  syntax Foo ::= "foo"
               | "bar"
endmodule

module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports KORE-HELPERS
  rule foo => bar
endmodule
```
