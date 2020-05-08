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
       <k>
         P => instExists(P, V, T)
       </k>

  syntax Pattern ::= instExists(Pattern, Variable, Pattern) [function]

  rule instExists(\implies(L, R), V, T)
    => \implies(L, instExists(R, V, T))

  rule instExists(\exists {Vs} P, V, T)
    => subst(P, V, T)
       requires V in Vs andBool ((Vs -Patterns V) ==K .Patterns)

  rule instExists(\exists {Vs} P, V, T)
    => \exists {Vs -Patterns V} subst(P, V, T)
       requires V in Vs andBool notBool ((Vs -Patterns V) ==K .Patterns)

endmodule
```
