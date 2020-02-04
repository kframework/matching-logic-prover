```k
module STRATEGY-REFLEXIVITY

  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy> reflexivity => success ...</strategy>
       <claim> \equals(P, P) </claim>

  rule <strategy> reflexivity => fail ...</strategy>
       <claim> \equals(P, Q) </claim>
       requires P =/=K Q


endmodule // STRATEGY-REFLEXIVITY
```
