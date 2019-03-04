```k
module DIRECT-PROOF-QUERIES
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports PROVER-CONFIGURATION
  imports PROVER-CORE-SYNTAX
  imports KORE-HELPERS

  syntax Bool ::= checkValid(ImplicativeForm) [function]

  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
```

```k
endmodule
```

