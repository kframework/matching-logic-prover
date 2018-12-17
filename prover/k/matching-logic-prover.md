```k
requires "kore.k"
requires "smtlib2.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  syntax Foo ::= "foo"
               | "bar"
endmodule

module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports KORE-HELPERS
  imports SMTLIB2
endmodule
```
