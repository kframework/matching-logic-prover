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
  rule <k> \implies(\and(LHS), \exists { _ } \and(RHS => RHS -Patterns LHS))
       </k>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <k> \implies( \and(LHS) , \exists { EXIST } \and(RHS) ) #as GOAL
        => #fun( INSTANTIATION =>
                   \implies( \and(LHS ++Patterns INSTANTIATION)
                           , \exists { EXIST -Patterns getFreeVariables(INSTANTIATION) }
                             \and(RHS -Patterns INSTANTIATION)
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

  syntax Patterns ::= getAtomForcingInstantiation(Patterns, Patterns, Patterns) [function]
  rule getAtomForcingInstantiation((\equals(X:Variable, P), Ps), FREE, EXISTENTIALS)
    => \equals(X:Variable, P), .Patterns
    requires X in EXISTENTIALS
     andBool getFreeVariables(P, .Patterns) -Patterns EXISTENTIALS ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((\equals(P, X:Variable), Ps), FREE, EXISTENTIALS)
    => \equals(X:Variable, P), .Patterns
    requires X in EXISTENTIALS
     andBool getFreeVariables(P, .Patterns) -Patterns EXISTENTIALS ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((P, Ps), FREE, EXISTENTIALS)
    => getAtomForcingInstantiation(Ps, FREE, EXISTENTIALS) [owise]
  rule getAtomForcingInstantiation(.Patterns, FREE, EXISTENTIALS)
    => .Patterns
```

```k
endmodule
```
