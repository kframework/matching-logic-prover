```k
module STRATEGY-REFLEXIVITY

  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <k> reflexivity => success ...</k>
       <claim> \equals(P, P) </claim>

  rule <k> reflexivity => fail ...</k>
       <claim> \equals(P, Q) </claim>
       requires P =/=K Q


endmodule // STRATEGY-REFLEXIVITY
```
