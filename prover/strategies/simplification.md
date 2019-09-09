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
  rule <claim> \implies(LHS => #lhsRemoveExistentials(LHS), RHS) </claim>
       <strategy> remove-lhs-existential => noop ... </strategy>

  syntax Pattern  ::= #lhsRemoveExistentials(Pattern)    [function]
  syntax Patterns ::= #lhsRemoveExistentialsPs(Patterns) [function]

  rule #lhsRemoveExistentialsPs(.Patterns) => .Patterns
  rule #lhsRemoveExistentialsPs(P, Ps)
    => #lhsRemoveExistentials(P), #lhsRemoveExistentialsPs(Ps)

  rule #lhsRemoveExistentials(N:Int) => N
  rule #lhsRemoveExistentials(X:Variable) => X
  rule #lhsRemoveExistentials(S:Symbol) => S
  rule #lhsRemoveExistentials(S:Symbol(ARGS) ) => S(#lhsRemoveExistentialsPs(ARGS))

  rule #lhsRemoveExistentials(\top()) => \top()
  rule #lhsRemoveExistentials(\bottom()) => \bottom()
  rule #lhsRemoveExistentials(\equals(P1, P2))
    => \equals(#lhsRemoveExistentials(P1), #lhsRemoveExistentials(P2))
  rule #lhsRemoveExistentials(\not(P)) => \not(P)

  rule #lhsRemoveExistentials(\implies(LHS, RHS))
    => \implies(#lhsRemoveExistentials(LHS), #lhsRemoveExistentials(RHS))
  rule #lhsRemoveExistentials(\and(Ps)) => \and(#lhsRemoveExistentialsPs(Ps))
  rule #lhsRemoveExistentials(\or(Ps)) => \or(#lhsRemoveExistentialsPs(Ps))
  rule #lhsRemoveExistentials(\forall { U } P) => \forall { U } #lhsRemoveExistentials(P)
  rule #lhsRemoveExistentials(\exists { E } P) => #lhsRemoveExistentials(P)

// It is sound to be conservative. This is needed for implicationContext
  rule #lhsRemoveExistentials(P) => P [owise]
```

Normalize:

 - RHS has existential qunatifier
 - Implications on the LHS of the goal are always universally quantified.
 - All \ands are flattened

```k
  rule <claim> \implies(LHS, \and(RHS))
        => \implies(LHS, \exists { .Patterns } \and(RHS))
       </claim>
       <strategy> normalize ... </strategy>

  rule <claim> \implies(\and(LHS), \exists { Es } \and(RHS))
        => \implies( \and(#normalizePs(#flattenAnds(#lhsRemoveExistentialsPs(LHS))))
                   , \exists { Es } \and(#normalizePs(#flattenAnds(RHS)))
                   )
       </claim>
       <strategy> normalize => noop ... </strategy>

  rule <claim> \not(_) #as P => #normalize(P) </claim>
       <strategy> normalize => noop ... </strategy>

  rule <claim> \forall{Vs} P => P </claim>
       <strategy> smtlib-to-implication ... </strategy>

  rule <claim> \or(Ps) => \implies(\and(#filterNegative(Ps)), \and(#filterPositive(Ps))) </claim>
       <strategy> smtlib-to-implication => noop ... </strategy>

  syntax Patterns ::= "#filterNegative" "(" Patterns ")" [function]
  rule #filterNegative(\not(P), Ps) => P, #filterNegative(Ps)
  rule #filterNegative(P, Ps)       => #filterNegative(Ps) [owise]
  rule #filterNegative(.Patterns)   => .Patterns

  syntax Patterns ::= "#filterPositive" "(" Patterns ")" [function]
  rule #filterPositive(\not(P), Ps) => #filterPositive(Ps)
  rule #filterPositive(P, Ps)       => P, #filterPositive(Ps) [owise]
  rule #filterPositive(.Patterns)   => .Patterns

  syntax Pattern ::= #normalize(Pattern) [function]
  syntax Patterns ::= #normalizePs(Patterns) [function]

  rule #normalizePs(.Patterns) => .Patterns
  rule #normalizePs(P, Ps) => #normalize(P), #normalizePs(Ps)

  // TODO: normalize on LHS and RHS?
  rule #normalize(\implies(LHS, RHS))
    => \forall { .Patterns } \implies(LHS, RHS)
  rule #normalize(\exists{.Patterns} P)
    => #normalize(P)

  rule #normalize(\not(\exists{Vs} P)) => \forall{Vs} #normalize(\not(P))
  rule #normalize(\not(\and(Ps))) => #normalize(\or(#pushNots(Ps)))
  rule #normalize(\not(\not(P))) => #normalize(P)
  rule #normalize(\or(Ps)) => \or(#normalizePs(Ps))
  rule #normalize(P) => P
    [owise]

  syntax Patterns ::= #pushNots(Patterns) [function]
  rule #pushNots(.Patterns) => .Patterns
  rule #pushNots(P, Ps) => \not(P), #pushNots(Ps)

  syntax Patterns ::= #flattenAnds(Patterns) [function]
  rule #flattenAnds(\and(Ps1), Ps2) => #flattenAnds(Ps1) ++Patterns #flattenAnds(Ps2)
  rule #flattenAnds(P, Ps) => P ++Patterns #flattenAnds(Ps) [owise]
  rule #flattenAnds(.Patterns) => .Patterns
```

### lift-or

Lift `\or`s on the left hand sides of implications

```
  (A -> RHS) /\ (B -> RHS)
  ------------------------
        A \/ B -> RHS
```

```k
  rule <claim> \implies(\or(LHSs), RHS) => \and( #liftOr(LHSs, RHS)) </claim>
       <strategy> lift-or => noop ... </strategy> 

  syntax Patterns ::= "#liftOr" "(" Patterns "," Pattern ")" [function]
  rule #liftOr(.Patterns, RHS) => .Patterns
  rule #liftOr((LHS, LHSs), RHS) => \implies(LHS, RHS), #liftOr(LHSs, RHS)
```

### Simplify

>              phi(x, y) -> psi(y)
> -----------------------------------------
> (\forall .Patterns . phi(x, y)) -> psi(y)

```k
  rule <claim> \implies(\forall { .Patterns } \and(LHS) => \and(LHS), RHS) </claim>
       <strategy> simplify ... </strategy>
```

>       phi(x, y) -> psi(y)
> -------------------------------
> \exists X . phi(x, y) -> psi(y)

```k
  rule <claim> \implies(\exists { _ } \and(LHS) => \and(LHS), RHS) </claim>
       <strategy> simplify ... </strategy>
```

>    LHS /\ phi -> RHS
> ------------------------
> LHS /\ phi -> RHS /\ phi

```k
  rule <claim> \implies(\and(LHS), \exists { _ } \and(RHS => RHS -Patterns LHS)) </claim>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <claim> \implies( \and(LHS) , \exists { EXIST } \and(RHS) ) #as GOAL
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
       </claim>
       <strategy> instantiate-existentials ... </strategy>
       [owise]

  rule <claim> \implies(\and(LHS), \exists { _ } \and(RHS)) #as GOAL </claim>
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

