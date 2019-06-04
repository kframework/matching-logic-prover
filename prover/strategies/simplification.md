These strategies encompass a variety of simplification strategies

```k
module STRATEGY-SIMPLIFICATION
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
```

### remove-lhs-existential

```
         phi -> psi
  ----------------------- 
  (\exists x. phi) -> psi
```

```k
  rule <k> \implies(\exists { _ } \and(LHS) => \and(LHS), RHS) </k>
       <strategy> remove-lhs-existential => noop ... </strategy>
```

### lift-or

Lift `\or`s on the left hand sides of implications

```
  (A -> RHS) /\ (B -> RHS)
  ------------------------
        A \/ B -> RHS
```

```k
  rule <k> \implies(\or(LHSs), RHS) => \and( #liftOr(LHSs, RHS)) </k>
       <strategy> lift-or => noop ... </strategy> 

  syntax Patterns ::= "#liftOr" "(" Patterns "," Pattern ")" [function]
  rule #liftOr(.Patterns, RHS) => .Patterns
  rule #liftOr((LHS, LHSs), RHS) => \implies(LHS, RHS), #liftOr(LHSs, RHS)
```

### Simplify


>       phi(x, y) -> psi(y)
> -------------------------------
> \exists X . phi(x, y) -> psi(y)

```k
  rule <k> \implies(\exists { _ } \and(LHS) => \and(LHS), RHS) </k>
       <strategy> simplify ... </strategy>
```

>    LHS /\ phi -> RHS
> ------------------------
> LHS /\ phi -> RHS /\ phi

```k
  rule <k> \implies(\and(LHS), \exists { _ } \and(RHS => RHS -Patterns LHS)) </k>
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

