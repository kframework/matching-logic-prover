```k
requires "kore.k"
requires "smtlib2.k"

module MATCHING-LOGIC-PROVER-SYNTAX
endmodule

module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports KORE-HELPERS
  imports SMTLIB2
  
  configuration <goal>
                  <lhs> .K </lhs>
                  <rhs> .K </rhs>
                </goal>
                <strategy> .K </strategy>
                <k> $PGM </k>

  syntax Strategy ::= "success"
                    | "fail"
                    | "direct-proof"

endmodule
```
