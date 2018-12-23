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
                    | Strategy Strategy
                    | clpr(Int)
                    | "direct-proof"
                    | "kt"
                    | "right-unfold"
                    |  "left-unfold"
  rule ( (S T) U ):Strategy => S (T U)
       [macro]

  rule clpr(0) => fail
  rule clpr(N)
    =>   direct-proof
      ~> kt clpr(N -Int 1)
      ~> right-unfold clpr(N -Int 1)
endmodule
```
