# typecheck - for Coq terms

```k
module STRATEGY-TYPECHECK
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule
    <claim> \type(ID:Symbol, TYPE) => \type(TERM, TYPE) </claim>
    <strategy> typecheck ... </strategy>
    <declaration> axiom AXID : \equals(ID, TERM) </declaration>

  rule
    <claim> \type(TYPE, TYPE) </claim>
    <strategy> typecheck => success ... </strategy>

  // lambda
  rule
    <claim> \type(\lambda { VARs } TERM, \pi { VARs } TYPE) => \type(TERM, TYPE) </claim>
    <strategy> typecheck ... </strategy>

  // application
  rule
    <claim> \type(TERM1 ( TERM2 ), TYPE) => \type(TERM1, \pi { !X:VariableName { StringToSort("Term") } } TYPE) </claim>
    <strategy> typecheck ... </strategy>

endmodule
```
