This file contains infrastructure for writing tests for K functions.

```k
requires "prover.k"
```

```k
module UNIT-TESTS-SYNTAX
    imports BASIC-K
    imports TOKENS-SYNTAX
    imports UNIT-TESTS
    imports PROVER-SYNTAX

    syntax KItem ::= Pattern // TODO: Explain why we're doing this
    syntax VariableName ::= "W" [token] | "X" [token] | "Y" [token] | "Z" [token]
                          | "W1" [token]
                          | "W2" [token]
                          | "X1" [token]
                          | "X2" [token]
                          | "Y1" [token]
                          | "Y2" [token]
                          | "Z1" [token]
                          | "Z2" [token]
                          | "Vx" [token]
                          | "Vy" [token]
                          | "Vz" [token]
                          | "F8" [token]
    syntax Sort         ::= "Data" [token] | "Loc" [token] | "RefGTyp" [token]
endmodule

module UNIT-TESTS
  imports STRATEGY-MATCHING
  imports PROVER-DRIVER

  syntax Sort         ::= "Data" | "Loc"
  syntax Declaration ::= "assert" "(" MatchResults "==" MatchResults ")" [format(%1%2%i%i%n%3%d%n%4%i%n%5%d%d%6%n)]
  rule assert(EXPECTED == EXPECTED) => .K
endmodule
```
