These strategies encompass a variety of simplification strategies

```k
module STRATEGY-SIMPLIFICATION
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
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

 - convert claim to implication
 - RHS has existential qunatifier
 - Implications on the LHS of the goal are always universally quantified.
 - All \ands are flattened

```k

  rule <claim> P::Pattern => \and(P) </claim>
       <strategy> normalize ... </strategy>
       requires \and(...) :/=K P andBool \implies(...) :/=K P

  rule <claim> \and(P) => \implies(\and(.Patterns), \and(P)) </claim>
       <strategy> normalize ... </strategy>

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
  rule #normalize(\not(\and(Ps))) => #normalize(\or(#not(Ps)))
  rule #normalize(\not(\not(P))) => #normalize(P)
  rule #normalize(\or(Ps)) => \or(#normalizePs(Ps))
  rule #normalize(P) => P
    [owise]
```

### purify

LHS terms of the form S(T, Vs) become S(V, Vs) /\ V = T

```k
  rule <claim> \implies(LHS => #purify(LHS), RHS) ... </claim>
       <strategy> purify => noop ... </strategy>

  syntax Pattern ::= #purify(Pattern) [function]
  syntax Patterns ::= #purifyPs(Patterns) [function]
  rule #purify(S(ARGs))
    => #fun( VARs
          => \and( S(VARs), #makeEqualities(VARs, ARGs) )
           )( makePureVariables(ARGs) )
    requires isUnfoldable(S)
  rule #purify(\and(Ps)) => \and(#purifyPs(Ps))
  rule #purify(sep(Ps)) => sep(#purifyPs(Ps))
  rule #purify(\not(P)) => \not(#purify(P))
  rule #purify(\equals(P1, P2)) => \equals(P1, P2)
  rule #purify(S:Symbol(Ps)) => S(Ps)
    [owise]
  rule #purifyPs(.Patterns) => .Patterns
  rule #purifyPs(P, Ps) => #purify(P), #purifyPs(Ps)

  syntax Patterns ::= makePureVariables(Patterns) [function]
  rule makePureVariables(V:Variable, REST) => V, makePureVariables(REST)
  rule makePureVariables(P, REST) => !V1:VariableName { getReturnSort(P) }, makePureVariables(REST)
    requires notBool isVariable(P)
  rule makePureVariables(.Patterns) => .Patterns

  syntax Patterns ::= #getNonVariables(Patterns) [function]
  rule #getNonVariables(.Patterns) => .Patterns
  rule #getNonVariables(V:Variable, Ps) => #getNonVariables(Ps)
  rule #getNonVariables(P, Ps) => P, #getNonVariables(Ps)
    requires notBool isVariable(P)

  syntax Patterns ::= #makeEqualities(Patterns, Patterns) [function]
  rule #makeEqualities(.Patterns, .Patterns) => .Patterns
  rule #makeEqualities((V, Vs), (V, Ps)) => #makeEqualities(Vs, Ps)
  rule #makeEqualities((V, Vs), (P, Ps)) => \equals(V, P), #makeEqualities(Vs, Ps)
    requires V =/=K P
```

### abstraction

obligation of the form R(T, Vs) => R(T', Vs') becomes
R(V, Vs) => exists V', R(V', Vs') and V = V'

```k
  rule <claim> \implies(LHS, RHS) </claim>
       <strategy> abstract
               => #getNewVariables(LHS, .Patterns)
               ~> #getNewVariables(RHS, .Patterns)
               ~> abstract
              ...
       </strategy>

  rule <claim> \implies(LHS, \and(\or(RHS)))
            => \implies( #abstract(LHS, VsLHS)
                       , \exists{ VsRHS } \and( #dnf(\or(\and(#createEqualities(VsLHS, VsRHS))))
                                                , #abstract(RHS, VsRHS)
                                                )
                       )
       </claim>
       <strategy> (VsLHS:Patterns ~> VsRHS:Patterns ~> abstract) => noop ... </strategy>

  syntax Patterns ::= #getNewVariables(Pattern, Patterns) [function]
  syntax Patterns ::= #getNewVariablesPs(Patterns, Patterns) [function]
  rule #getNewVariables(\and(Ps), Vs) => #getNewVariablesPs(Ps, Vs)
  rule #getNewVariables(\or(Ps), Vs) => #getNewVariablesPs(Ps, Vs)
  rule #getNewVariables(\not(P), Vs) => #getNewVariablesPs(P, Vs)
  rule #getNewVariables(sep(Ps), Vs) => #getNewVariablesPs(Ps, Vs)
  rule #getNewVariables(S(ARGs), Ps)
    => (makePureVariables(ARGs) -Patterns ARGs) ++Patterns Ps
    requires isUnfoldable(S)
  rule #getNewVariables(pto(_), Ps) => Ps
  rule #getNewVariables(\equals(_, _), Ps) => Ps

  rule #getNewVariablesPs(.Patterns, _) => .Patterns
  rule #getNewVariablesPs((P, Ps), Vs) => #getNewVariables(P, Vs) ++Patterns #getNewVariablesPs(Ps, Vs)

  syntax Pattern ::= #abstract(Pattern, Patterns) [function]
  syntax Patterns ::= #abstractPs(Patterns, Patterns) [function]
  rule #abstract(\and(Ps), Vs) => \and(#abstractPs(Ps, Vs))
  rule #abstract(\or(Ps), Vs) => \or(#abstractPs(Ps, Vs))
  rule #abstract(\not(P), Vs) => \not(#abstract(P, Vs))
  rule #abstract(sep(Ps), Vs) => sep(#abstractPs(Ps, Vs))
  rule #abstract(S(ARGs), Vs)
    => S(#replaceNewVariables(ARGs, Vs))
    requires isUnfoldable(S)
  rule #abstract(pto(ARGs), Vs) => pto(ARGs)
  rule #abstract(\equals(L, R), Vs) => \equals(L, R)

  rule #abstractPs(.Patterns, _) => .Patterns
  rule #abstractPs((P, Ps), Vs) => #abstract(P, Vs), #abstractPs(Ps, Vs)

  syntax Patterns ::= #replaceNewVariables(Patterns, Patterns) [function]
  rule #replaceNewVariables((V1:Variable, Ps), Vs) => V1, #replaceNewVariables(Ps, Vs)
  rule #replaceNewVariables((P, Ps), (V, Vs)) => V, #replaceNewVariables(Ps, Vs)
    requires notBool isVariable(P)
  rule #replaceNewVariables(.Patterns, _) => .Patterns

  syntax Patterns ::= #createEqualities(Patterns, Patterns) [function]
  syntax Patterns ::= #createEqualitiesVar(Patterns, Pattern) [function]
  rule #createEqualities(VsLHS, .Patterns) => .Patterns
  rule #createEqualities(VsLHS, (VRHS, VsRHS)) => \or(#createEqualitiesVar(VsLHS, VRHS)), #createEqualities(VsLHS, VsRHS)
  rule #createEqualitiesVar(.Patterns, VRHS) => .Patterns
  rule #createEqualitiesVar((VLHS, VsLHS), VRHS) => \equals(VRHS, VLHS), #createEqualitiesVar(VsLHS, VRHS)
```

### lift-constraints

Bring predicate constraints to the top of a term.

```k
  rule <claim> \implies(\and(Ps) => #flattenAnd(#liftConstraints(\and(Ps)))
                       , \exists { _ } (\and(Rs) => #flattenAnd(#liftConstraints(\and(Rs))))
                       )
       </claim>
       <strategy> lift-constraints => noop ... </strategy>

  syntax Pattern ::= #liftConstraints(Pattern) [function]
  rule #liftConstraints(P) =>     P  requires isPredicatePattern(P)
  rule #liftConstraints(S) => sep(S) requires isSpatialPattern(S)

  rule #liftConstraints(sep(\and(.Patterns), REST)) => #liftConstraints(sep(REST))

  rule #liftConstraints(sep(\and(P, Ps:Patterns), REST:Patterns))
    => #liftConstraints(\and(sep(\and(Ps), REST), P, .Patterns))
    requires isPredicatePattern(P)
  rule #liftConstraints(sep(\and(P, Ps), REST))
    => #liftConstraints(sep(\and(Ps), P, REST))
    requires isSpatialPattern(P)
  rule #liftConstraints(sep(\and(P, Ps), REST))
    => #liftConstraints(sep(\and(#flattenAnds(#liftConstraints(P), Ps)), REST))
    requires notBool isPredicatePattern(P) andBool notBool isSpatialPattern(P)

  // Rotate
  rule #liftConstraints(sep(S, Ps))
    => #liftConstraints(sep(Ps ++Patterns S))
    requires isSpatialPattern(S) andBool notBool isSpatialPattern(sep(S, Ps))

  rule #liftConstraints(\and(sep(Ss), Ps))
    => #liftConstraints(\and(#flattenAnds(#liftConstraints(sep(Ss)), .Patterns) ++Patterns Ps))
    requires notBool isSpatialPattern(sep(Ss))

  rule #liftConstraints(\and(S, Ps))
    => \and(sep(S), #flattenAnds(#liftConstraints(\and(Ps)), .Patterns))
    requires isSpatialPattern(S)

  rule #liftConstraints(\and(\and(Ps), REST))
    => #liftConstraints(\and(Ps ++Patterns REST))

  rule #liftConstraints(\and(P, Ps))
    => #liftConstraints(\and(Ps ++Patterns P))
  requires isPredicatePattern(P) andBool notBool isPredicatePattern(\and(P, Ps))
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

```
           phi /\ x = t -> psi
     -------------------------------
     phi -> \exists x . x = t /\ psi
```

```k
  rule <claim> \implies( \and(LHS) , \exists { EXIST } \and(RHS) ) #as GOAL </claim>
       <strategy> (. => getAtomForcingInstantiation(RHS, getExistentialVariables(GOAL)))
               ~> instantiate-existentials
                  ...
       </strategy>

  rule <claim> \implies( \and(LHS) , \exists { EXIST } \and(RHS) )
            => \implies( \and(LHS ++Patterns INSTANTIATION)
                       , \exists { EXIST -Patterns getFreeVariables(INSTANTIATION) }
                         \and(RHS -Patterns INSTANTIATION)
                       )
       </claim>
       <strategy> (INSTANTIATION => .) ~> instantiate-existentials ... </strategy>
     requires INSTANTIATION =/=K .Patterns

  rule <strategy> (.Patterns ~> instantiate-existentials) => noop ... </strategy>

  syntax Patterns ::= getAtomForcingInstantiation(Patterns, Patterns) [function]
  rule getAtomForcingInstantiation((\equals(X:Variable, P), Ps), EXISTENTIALS)
    => \equals(X:Variable, P), .Patterns
    requires X in EXISTENTIALS
     andBool getFreeVariables(P, .Patterns) intersect EXISTENTIALS ==K .Patterns
  rule getAtomForcingInstantiation((\equals(P, X:Variable), Ps), EXISTENTIALS)
    => \equals(X:Variable, P), .Patterns
    requires X in EXISTENTIALS
     andBool getFreeVariables(P, .Patterns) intersect EXISTENTIALS ==K .Patterns
  rule getAtomForcingInstantiation((P, Ps), EXISTENTIALS)
    => getAtomForcingInstantiation(Ps, EXISTENTIALS) [owise]
  rule getAtomForcingInstantiation(.Patterns, EXISTENTIALS)
    => .Patterns
```

### Substitute Equals for equals

```
     PHI[x/y] -> PSI[x/y]
    ----------------------  where y is a variable
     x = y /\ PHI -> PSI
```

```k
  rule <claim> \implies(\and(LHS), _) </claim>
       <strategy> substitute-equals-for-equals
               => (makeEqualitySubstitution(LHS) ~> substitute-equals-for-equals)
                  ...
       </strategy>

  rule <strategy> (SUBST:Map ~> substitute-equals-for-equals)
               => noop
                  ...
       </strategy>
    requires SUBST ==K .Map

  rule <claim> \implies( \and(LHS => removeTrivialEqualities(substPatternsMap(LHS, SUBST)))
                       , \exists { _ }
                         ( \and(RHS => removeTrivialEqualities(substPatternsMap(RHS, SUBST))) )
                       )
       </claim>
       <strategy> (SUBST:Map ~> substitute-equals-for-equals)
               => substitute-equals-for-equals
                  ...
       </strategy>
    requires SUBST =/=K .Map

  syntax Map ::= makeEqualitySubstitution(Patterns) [function]
  rule makeEqualitySubstitution(.Patterns) => .Map
  rule makeEqualitySubstitution(\equals(X:Variable, T), Ps) => (X |-> T) .Map
  rule makeEqualitySubstitution(\equals(T, X:Variable), Ps) => (X |-> T) .Map
    requires notBool(isVariable(T))
  rule makeEqualitySubstitution((P, Ps:Patterns)) => makeEqualitySubstitution(Ps) [owise]

  syntax Patterns ::= removeTrivialEqualities(Patterns) [function]
  rule removeTrivialEqualities(.Patterns) => .Patterns
  rule removeTrivialEqualities(\equals(X, X), Ps) => removeTrivialEqualities(Ps)
  rule removeTrivialEqualities(P, Ps) => P, removeTrivialEqualities(Ps) [owise]
```

```k
endmodule
```

