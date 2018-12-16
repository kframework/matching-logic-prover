```k
requires "kore.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  syntax Foo ::= "foo"
               | "bar"
endmodule

module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports KORE-HELPERS
  imports STRING

  rule foo => bar

  syntax String ::= unparse(String, Pattern) [function, hook(UNPARSE.unparse)]
  syntax String ::= Z3CheckSAT(String) [function, hook(Z3.checkSAT)]
endmodule
```
