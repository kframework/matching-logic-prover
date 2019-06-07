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
  rule <k> \implies(\and(LHS), \exists { _ } \and(RHS => RHS -BasicPatterns LHS))
       </k>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <k> \implies( \and(LHS) , \exists { EXIST } \and(RHS) ) #as GOAL
        => #fun( INSTANTIATION =>
                   \implies( \and(LHS ++BasicPatterns INSTANTIATION)
                           , \exists { EXIST -BasicPatterns getFreeVariables(INSTANTIATION) }
                             \and(RHS -BasicPatterns INSTANTIATION)
                           )
               )
               ( getAtomForcingInstantiation( RHS
                                            , getUniversalVariables(GOAL)
                                            , getExistentialVariables(GOAL)
                                            )
               )
       </k>
       <strategy> instantiate-existentials ... </strategy>
       <trace> .K => ( getAtomForcingInstantiation( RHS
                                            , getUniversalVariables(GOAL)
                                            , getExistentialVariables(GOAL)
                                            )
               )
               ...
       </trace>
       [owise]

  rule <k> \implies(\and(LHS), \exists { _ } \and(RHS)) #as GOAL </k>
       <strategy> instantiate-existentials => noop ... </strategy>
    requires .Patterns
         ==K getAtomForcingInstantiation( RHS
                                        , getUniversalVariables(GOAL)
                                        , getExistentialVariables(GOAL)
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
