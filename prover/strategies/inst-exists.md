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
         P => instExists(P, V, T)
       </claim>

  syntax Pattern ::= instExists(Pattern, Variable, Pattern) [function]

  rule instExists(\implies(L, R), V, T)
    => \implies(L, instExists(R, V, T))

  rule instExists(\exists {Vs} P, V, T)
    => #if (Vs -Patterns V) ==K .Patterns #then
         subst(P, V, T)
       #else
          \exists {Vs -Patterns V} subst(P, V, T)
       #fi
       requires V in Vs

endmodule
```
