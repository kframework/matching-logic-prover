```
Gamma |- functionalPattern(T)
Gamma |- P(T)
--------------------------------------------------------------------
Gamma |- \exists V. P(V)

```

```k
module STRATEGY-INST-EXISTS
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS

  rule <strategy>
         inst-exists(V, T, Strat)
         => subgoal(\functionalPattern(T), Strat) & noop
       ...</strategy>
       <claim>
         \implies(
           _,
          (\exists {Vs} P) =>
          (\exists {Vs -Patterns V} casubst(P, V, T))
         )
       </claim>
       requires V in Vs

endmodule
```
