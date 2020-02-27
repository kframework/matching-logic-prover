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

  // axiom: (Term, Term, Term)
  rule
    <claim> \type(\pi { VARs } TYPE, #token("Term", "UpperName")) </claim>
    <strategy> typecheck => success ... </strategy>

  // lambda
  rule
    <claim> \type(\lambda { VARs1 } TERM, \pi { VARs2 } TYPE) => \type(TERM, TYPE) </claim>
    <strategy> typecheck ... </strategy>

  // application
  rule
    <claim> \type(TERM1 ( TERM2 ), TYPE) => \type(TERM1, \pi { !X:VariableName { #token("Term", "UpperName") } } TYPE) </claim>
    <strategy> typecheck ... </strategy>

endmodule
```
