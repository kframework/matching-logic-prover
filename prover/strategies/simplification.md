These strategies encompass a variety of simplification strategies

```k
module STRATEGY-SIMPLIFICATION
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
```

### Simplify

Remove trivial clauses from the right-hand-side:

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies(\and(LHS), \and(RHS -BasicPatterns LHS)) ...
       </k>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => #fun( INSTANTIATION =>
                   \implies( \and(LHS ++BasicPatterns INSTANTIATION)
                           , \and(RHS -BasicPatterns INSTANTIATION)
                           )
               )
               ( getAtomForcingInstantiation( RHS
                                            , getFreeVariables(LHS)
                                            , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                            )
               )
       </k>
       <strategy> instantiate-existentials ... </strategy>
       [owise]

  rule <k> \implies(\and(LHS), \and(RHS))
       </k>
       <strategy> instantiate-existentials => noop ... </strategy>
    requires .Patterns
         ==K getAtomForcingInstantiation( RHS
                                        , getFreeVariables(LHS)
                                        , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                        )

  syntax BasicPatterns ::= getAtomForcingInstantiation(BasicPatterns, BasicPatterns, BasicPatterns) [function]
  rule getAtomForcingInstantiation((\equals(X:Variable, P), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((\equals(P, X:Variable), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((P, Ps), FREE, EXISTENTIAL)
    => getAtomForcingInstantiation(Ps, FREE, EXISTENTIAL) [owise]
  rule getAtomForcingInstantiation(.Patterns, FREE, EXISTENTIAL)
    => .Patterns
```

```k
endmodule
```
