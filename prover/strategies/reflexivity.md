```k
module STRATEGY-REFLEXIVITY

  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy> reflexivity => success ...</strategy>
       <k> \equals(P, P) </k>

  rule <strategy> reflexivity => fail ...</strategy>
       <k> \equals(P, Q) </k>
       requires P =/=K Q


endmodule // STRATEGY-REFLEXIVITY
```
