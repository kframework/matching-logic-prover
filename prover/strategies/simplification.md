These strategies encompass a variety of simplification strategies

```k
module STRATEGY-SIMPLIFICATION
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS
  imports SYNTACTIC-MATCH-SYNTAX

```

### remove-lhs-existential

```
         phi -> psi
  -----------------------
  (\exists x. phi) -> psi
```

```k
  rule <claim> \implies(LHS => #lhsRemoveExistentials(LHS), RHS) </claim>
       <k> remove-lhs-existential => noop ... </k>

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
       <k> normalize ... </k>
       requires \and(...) :/=K P andBool \implies(...) :/=K P

  rule <claim> \and(P) => \implies(\and(.Patterns), \and(P)) </claim>
       <k> normalize ... </k>

  rule <claim> \implies(LHS, \and(RHS))
        => \implies(LHS, \exists { .Patterns } \and(RHS))
       </claim>
       <k> normalize ... </k>

  rule <claim> \implies(\and(LHS), \exists { Es } \and(RHS))
        => \implies( \and(#normalizePs(#flattenAnds(#lhsRemoveExistentialsPs(LHS))))
                   , \exists { Es } \and(#normalizePs(#flattenAnds(RHS)))
                   )
       </claim>
       <k> normalize => noop ... </k>

  rule <claim> \not(_) #as P => #normalize(P) </claim>
       <k> normalize => noop ... </k>

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
  rule <claim> \implies(LHS => #purify(LHS), RHS) </claim>
       <k> purify => noop ... </k>

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
  syntax Strategy ::= "abstract-vars" "(" Patterns "," Patterns ")"
  rule <claim> \implies(LHS, \exists{_} RHS) </claim>
       <k> abstract
        => abstract-vars(#getNewVariablesForNil(LHS), #getNewVariablesForNil(RHS))
           ...
       </k>

  rule <claim> \implies(LHS, \exists{_} RHS) </claim>
       <k> abstract-Nth(M)
        => abstract-vars(#makeNils(#getNewVariablesForNil(LHS), M), #getNewVariablesForNil(RHS))
           ...
       </k>

  syntax Patterns ::= #makeNils(Patterns, Int) [function]
  rule #makeNils(.Patterns, _) => .Patterns
  rule #makeNils((V, Vs), 0) => V, #makeNils(Vs, -1)
  rule #makeNils((V, Vs), I) => nil { getReturnSort(V) }(.Patterns), #makeNils(Vs, I -Int 1)
    requires I =/=Int 0

  rule <claim> \implies(LHS, \exists{_} \and(RHS))
            => \implies( \and(#abstract(LHS, VsLHS))
                       , \exists{ VsRHS } \and( #dnf(\or(\and(#createEqualities(VsLHS, VsRHS))))
                                                , #abstract(RHS, VsRHS)
                                                )
                       )
       </claim>
       <k> abstract-vars(VsLHS, VsRHS)
        => normalize . or-split-rhs . lift-constraints
         . instantiate-separation-logic-axioms
         . create-disequalities(VsLHS)
           ...
       </k>

  syntax Strategy ::= "create-disequalities" "(" Patterns ")"
  rule <claim> \implies(\and(LHS), RHS)
            => \implies(\and(LHS ++Patterns #createDisequalities(\and(LHS), VsLHS)), RHS)
       </claim>
       <k> create-disequalities(VsLHS) => noop ... </k>

  syntax Patterns ::= #getNewVariablesForNil(Pattern) [function]
  syntax Patterns ::= #getNewVariablesForNilPs(Patterns) [function]
  rule #getNewVariablesForNil(\and(Ps)) => #getNewVariablesForNilPs(Ps)
  rule #getNewVariablesForNil(\or(Ps)) => #getNewVariablesForNilPs(Ps)
  rule #getNewVariablesForNil(\not(P)) => #getNewVariablesForNil(P)
  rule #getNewVariablesForNil(sep(Ps)) => #getNewVariablesForNilPs(Ps)
  rule #getNewVariablesForNil(S:Symbol(ARGs)) => #getNewVariablesForNilPs(ARGs)
    requires nil { _ } :/=K S
     andBool S =/=K sep
  rule #getNewVariablesForNil(\equals(L, R)) => .Patterns
  rule #getNewVariablesForNil(V:Variable) => .Patterns
  rule #getNewVariablesForNil(nil { LOC }(.Patterns)) => !V:VariableName { LOC }, .Patterns

  rule #getNewVariablesForNilPs(.Patterns) => .Patterns
  rule #getNewVariablesForNilPs(P, Ps) => #getNewVariablesForNil(P) ++Patterns #getNewVariablesForNilPs(Ps)

  syntax Pattern ::= #abstract(Pattern, Patterns) [function]
  syntax Patterns ::= #abstractPs(Patterns, Patterns) [function]
  rule #abstract(\and(Ps), Vs) => \and(#abstractPs(Ps, Vs))
  rule #abstract(\or(Ps), Vs) => \or(#abstractPs(Ps, Vs))
  rule #abstract(\not(P), Vs) => \not(#abstract(P, Vs))
  rule #abstract(sep(Ps), Vs) => sep(#abstractPs(Ps, Vs))
  rule #abstract(S:Symbol(ARGs), Vs) => S(#abstractArgs(ARGs, Vs))
    requires nil { _ } :/=K S
     andBool S =/=K sep
  rule #abstract(V:Variable, Vs) => V
  rule #abstract(nil{_}(.Patterns), (V, Vs)) => V
  rule #abstract(\equals(L, R), Vs)
    => \equals( #abstract(L, Vs)
              , #abstract(R, #chopPs(Vs, #countNils(L)))
              )

  syntax Patterns ::= #abstractArgs(Patterns, Patterns) [function]
  rule #abstractArgs(.Patterns, Vs) => .Patterns
  rule #abstractArgs((V:Variable, Ps), Vs) => V, #abstractArgs(Ps, Vs)
  rule #abstractArgs((nil{_}(.Patterns), Ps), (V, Vs)) => V, #abstractArgs(Ps, Vs)
  rule #abstractArgs((S:Symbol(ARGs), Ps), Vs)
    => (S(#abstractArgs(ARGs, Vs)), .Patterns) ++Patterns #abstractArgs(Ps, #chopPs(Vs, #countNils(ARGs)))
    requires nil { _ } :/=K S

  syntax Int ::= #countNils(Patterns) [function]
  rule #countNils(.Patterns) => 0
  rule #countNils(nil{_}(.Patterns), Ps) => 1 +Int #countNils(Ps)
  rule #countNils(S:Symbol(ARGs), Ps) => #countNils(ARGs)
    requires nil { _ } :/=K S
  rule #countNils(V:Variable, Ps) => #countNils(Ps)
  rule #countNils(\not(P), Ps) => #countNils(P, Ps)
  rule #countNils(\equals(L, R), Ps) => #countNils(L) +Int #countNils(R) +Int #countNils(Ps)

  syntax Patterns ::= #chopPs(Patterns, Int) [function]
  rule #chopPs(Ps, M) => Ps
    requires M <=Int 0
  rule #chopPs(.Patterns, M) => .Patterns
  rule #chopPs((P, Ps), M) => #chopPs(Ps, M -Int 1)
    requires M >Int 0

  rule #abstractPs(.Patterns, _) => .Patterns
  rule #abstractPs((P, Ps), Vs) => #abstract(P, Vs) ++Patterns #abstractPs(Ps, #chopPs(Vs, #countNils(P)))

  // syntax Pattern ::= #abstractNth(Pattern, Patterns, Int) [function]
  // syntax Patterns ::= #abstractNthPs(Patterns, Patterns) [function]
  // rule #abstractNth(\and(Ps), Vs) => \and(#abstractNthPs(Ps, Vs))
  // rule #abstractNth(\or(Ps), Vs) => \or(#abstractNthPs(Ps, Vs))
  // rule #abstractNth(\not(P), Vs) => \not(#abstractNth(P, Vs))
  // rule #abstractNth(sep(Ps), Vs) => sep(#abstractNthPs(Ps, Vs))
  // rule #abstractNth(S(ARGs), Vs) =>
  //   => S(#replaceNewVariables(ARGs, Vs))
  //   requires isUnfoldable(S)
  // rule #abstractNth(pto(ARGs), Vs) => pto(ARGs)
  // rule #abstractNth(\equals(L, R), Vs) => \equals(L, R)

  // rule #abstractNthPs(.Patterns, _) => .Patterns
  // rule #abstractNthPs((P, Ps), Vs) => #abstractNth(P, Vs), #abstractNthPs(Ps, Vs)

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

  syntax Patterns ::= #createDisequalities(Pattern, Patterns) [function]
  syntax Patterns ::= #createDisequalitiesPs(Patterns, Patterns) [function]
  rule #createDisequalities(\and(Ps), Vs) => #createDisequalitiesPs(Ps, Vs)
  rule #createDisequalities(\or(Ps), Vs) => #createDisequalitiesPs(Ps, Vs)
  rule #createDisequalities(sep(Ps), Vs) => #createDisequalitiesPs(Ps, Vs)
  rule #createDisequalities(S:Symbol(ARGs), Vs) => .Patterns
  rule #createDisequalities(\equals(_, _), Vs) => .Patterns
  rule #createDisequalities(\not(\equals(nil{_}(.Patterns), V:Variable)), Vs) => #makeDisequalities(V, Vs)
  rule #createDisequalities(\not(\equals(V:Variable, nil{_}(.Patterns))), Vs) => #makeDisequalities(V, Vs)
  rule #createDisequalities(\not(P), Vs) => .Patterns
    [owise]

  rule #createDisequalitiesPs(.Patterns, _) => .Patterns
  rule #createDisequalitiesPs((P, Ps), Vs) => #createDisequalities(P, Vs) ++Patterns #createDisequalitiesPs(Ps, Vs)

  syntax Patterns ::= #makeDisequalities(Variable, Patterns) [function]
  rule #makeDisequalities(V, .Patterns) => .Patterns
  rule #makeDisequalities(V1, (V2, Vs)) => \not(\equals(V1, V2)), #makeDisequalities(V1, Vs)
```

abstracting nil

on the LHS, replace all occurrences of nil with a fresh variable

```k
  rule <claim> \implies(LHS, RHS) => \implies(#abstractNil(LHS), RHS) </claim>
       <k> abstract-nil => noop
              ...
       </k>

  syntax Pattern ::= #abstractNil(Pattern) [function]
  syntax Patterns ::= #abstractNilPs(Patterns) [function]
  rule #abstractNil(V { SORT }) => V { SORT }
  rule #abstractNil(\and(Ps)) => \and(#abstractNilPs(Ps))
  rule #abstractNil(\or(Ps)) => \or(#abstractNilPs(Ps))
  rule #abstractNil(\not(P)) => \not(#abstractNil(P))
  rule #abstractNil(sep(Ps)) => sep(#abstractNilPs(Ps))
  rule #abstractNil(nil { LOC }(.Patterns)) => !V:VariableName { LOC }
  rule #abstractNil(S:Symbol(ARGs)) => S(#abstractNilPs(ARGs))
    requires nil { _ } :/=K S
  rule #abstractNil(\equals(L, R)) => \equals(#abstractNil(L), #abstractNil(R))
  rule #abstractNilPs(.Patterns) => .Patterns
  rule #abstractNilPs(P, Ps) => #abstractNil(P), #abstractNilPs(Ps)
```

### lift-constraints

Bring predicate constraints to the top of a term.

```k
  rule <claim> \implies(\and(Ps) => #flattenAnd(#liftConstraints(#flattenAnd(\and(Ps))))
                       , \exists { _ } (\and(Rs) => #flattenAnd(#liftConstraints(#flattenAnd(\and(Rs)))))
                       )
       </claim>
       <k> lift-constraints => noop ... </k>

  syntax Pattern ::= #liftConstraints(Pattern) [function]
  syntax Patterns ::= #liftConstraintsPs(Patterns) [function]
  rule #liftConstraints(\and(Ps)) => \and(#liftConstraintsPs(Ps))
  rule #liftConstraintsPs(.Patterns) => .Patterns
  rule #liftConstraintsPs(sep(\and(.Patterns), .Patterns), REST) => #liftConstraintsPs(REST)
  rule #liftConstraintsPs(P, REST) => #liftConstraintsPs(REST) ++Patterns P
    requires isPredicatePattern(P)
  rule #liftConstraintsPs(P, REST) => sep(P), #liftConstraintsPs(REST)
    requires isSpatialPattern(P)
  rule #liftConstraintsPs(\and(Ps), REST) => #liftConstraintsPs(Ps ++Patterns REST)
    requires notBool isPredicatePattern(\and(Ps))
  // note the rule below assumes we hever have a pure predicate pattern inside a sep
  rule #liftConstraintsPs(sep((P, Ps) #as SEPs), REST)
    => #liftConstraintsPs( sep(            (SEPs -Patterns #getSpatialPatterns(SEPs))
                                ++Patterns #getSpatialPatterns(SEPs)
                              )
                         , REST
                         )
    requires isSpatialPattern(P) andBool #getSpatialPatterns(SEPs) =/=K SEPs
  rule #liftConstraintsPs(sep(\and(Ps), REST_SEP), REST)
    => #liftConstraintsPs( sep( \and(Ps -Patterns #getPredicatePatterns(Ps))
                              , REST_SEP
                              )
                         , REST
                         )
       ++Patterns #getPredicatePatterns(Ps)
    requires #getPredicatePatterns(Ps) =/=K .Patterns
  rule #liftConstraintsPs(sep(\and(P, .Patterns), REST_SEP), REST)
    => #liftConstraintsPs(sep(P, REST_SEP), REST)
    requires isSpatialPattern(P)
  rule #liftConstraintsPs(sep(\and(P, Ps), REST_SEP), REST)
    => #liftConstraintsPs(sep(P, REST_SEP), sep(\and(Ps), REST_SEP), REST)
    requires #getPredicatePatterns(P, Ps) ==K .Patterns
     andBool isSpatialPattern(P)
     andBool Ps =/=K .Patterns
  rule #liftConstraintsPs(sep(\and(P, Ps), REST_SEP), REST)
    => #liftConstraintsPs(sep(\and(#liftConstraintsPs(P, Ps)), REST_SEP), REST)
    requires #getPredicatePatterns(P, Ps) ==K .Patterns
     andBool notBool isSpatialPattern(P)

  syntax Patterns ::= #getPredicatePatterns(Patterns) [function]
  syntax Patterns ::= #getSpatialPatterns(Patterns) [function]
  rule #getPredicatePatterns(.Patterns) => .Patterns
  rule #getPredicatePatterns(P, Ps) => P, #getPredicatePatterns(Ps)
    requires isPredicatePattern(P)
  rule #getPredicatePatterns(P, Ps) => #getPredicatePatterns(Ps)
    requires notBool isPredicatePattern(P)
  rule #getSpatialPatterns(.Patterns) => .Patterns
  rule #getSpatialPatterns(P, Ps) => P, #getSpatialPatterns(Ps)
    requires isSpatialPattern(P)
  rule #getSpatialPatterns(P, Ps) => #getSpatialPatterns(Ps)
    requires notBool isSpatialPattern(P)

  // test cases:
  // \and(.Patterns) => \and(.Patterns)
  // \and(sep(\and(.Patterns))) => \and(.Patterns)
  // \and( dll(..), pto(..) ) => \and( sep( dll ), sep( pto ) )
  // \and(sep(\and(H1, P1, H2, P2)))
  // => \and(sep(H1), sep(H2), P1, P2)
  // \and(sep(\and(H1, H2, x=y), H3), H4, w=z)
  // => \and(sep(H1, H3), sep(H2, H3), sep(H4), x=y, w=z)
```

### lift-or

Lift `\or`s on the left hand sides of implications

```
  (A -> RHS) /\ (B -> RHS)
  ------------------------
        A \/ B -> RHS
```

```k
  rule <claim> \implies(\and(\not(\and(Ps)), LHS), RHS)
            => \implies(\and(\or(#not(Ps)), LHS), RHS) 
       </claim>
       <k> lift-or ... </k>
  rule <claim> \implies(\and(\or(Ps), LHS), RHS)
            => \implies(\or(#liftOr-in-And(Ps, LHS)), RHS)
       </claim>
       <k> lift-or ... </k>
  syntax Patterns ::= "#liftOr-in-And" "(" Patterns "," Patterns ")" [function]
  rule #liftOr-in-And(.Patterns, LHS) => .Patterns
  rule #liftOr-in-And((P, Ps), LHS) => \and(P, LHS), #liftOr-in-And(Ps, LHS)

  rule <claim> \implies(\or(LHSs), RHS) => \and( #liftOr(LHSs, RHS)) </claim>
       <k> lift-or => noop ... </k>

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
       <k> simplify ... </k>
```

>       phi(x, y) -> psi(y)
> -------------------------------
> \exists X . phi(x, y) -> psi(y)

```k
  rule <claim> \implies(\exists { _ } \and(LHS) => \and(LHS), RHS) </claim>
       <k> simplify ... </k>
```

>    LHS /\ phi -> RHS
> ------------------------
> LHS /\ phi -> RHS /\ phi

```k
  rule <claim> \implies(\and(LHS), \exists { _ } \and(RHS => RHS -Patterns LHS)) </claim>
       <k> simplify => noop ... </k>
```

### Instantiate Existials

```
           phi /\ x = t -> psi
     -------------------------------
     phi -> \exists x . x = t /\ psi
```

```k
  rule <claim> \implies( \and(LHS) , \exists { EXIST } \and(RHS) ) #as GOAL </claim>
       <k> (. => getAtomForcingInstantiation(RHS, getExistentialVariables(GOAL)))
               ~> instantiate-existentials
                  ...
       </k>

  rule <claim> \implies( \and(LHS) , \exists { EXIST } \and(RHS) )
            => \implies( \and(LHS ++Patterns INSTANTIATION)
                       , \exists { EXIST -Patterns getFreeVariables(INSTANTIATION) }
                         \and(RHS -Patterns INSTANTIATION)
                       )
       </claim>
       <k> (INSTANTIATION => .) ~> instantiate-existentials ... </k>
     requires INSTANTIATION =/=K .Patterns
  rule <k> (.Patterns ~> instantiate-existentials) => noop ... </k>
```

We define a similar strategy for quantified implication contexts:

```k
  rule <claim> \implies( \and(sep(\forall { Vs } implicationContext(\and(LCTX), RCTX), _),  LHS) , _ ) </claim>
       <k> (. => getAtomForcingInstantiation(LCTX, Vs))
        ~> instantiate-existentials-implication-context
           ...
       </k>
  rule <claim> \implies( \and( sep( \forall { Vs } implicationContext(\and(LCTX), RCTX), LSPATIAL), LHS) , RHS )
            => \implies( \and( sep( \forall { Vs -Patterns getFreeVariables(INSTANTIATION) }
                                    implicationContext(\and(LCTX -Patterns INSTANTIATION), RCTX)
                                  , LSPATIAL
                                  )
                             , (LHS ++Patterns INSTANTIATION)
                             )
                       , RHS
                       )
       </claim>
       <k> (INSTANTIATION => .) ~> instantiate-existentials-implication-context ... </k>
     requires INSTANTIATION =/=K .Patterns
  rule <k> (.Patterns ~> instantiate-existentials-implication-context) => noop ... </k>
```

```k
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
  syntax Strategy ::= "substitute-equals-for-equals" "(" Map ")"
  rule <claim> \implies(\and(LHS), _) </claim>
       <k> substitute-equals-for-equals
        => substitute-equals-for-equals(makeEqualitySubstitution(LHS))
           ...
       </k>

  rule <k> substitute-equals-for-equals(.Map)
        => noop
           ...
       </k>

  rule <claim> \implies( LHS, \exists{Vs} RHS )
            => \implies( subst(LHS, X, T), \exists{Vs} subst(RHS, X, T) )
       </claim>
       <k> substitute-equals-for-equals((X |-> T):Map)
        => substitute-equals-for-equals
           ...
       </k>

  syntax Map ::= makeEqualitySubstitution(Patterns) [function]
  rule makeEqualitySubstitution(.Patterns) => .Map
  rule makeEqualitySubstitution(\equals(X:Variable, T), Ps) => (X |-> T) .Map
    requires X =/=K T
  rule makeEqualitySubstitution(\equals(T, X:Variable), Ps) => (X |-> T) .Map
    requires notBool(isVariable(T)) andBool X =/=K T
  rule makeEqualitySubstitution((P, Ps:Patterns)) => makeEqualitySubstitution(Ps) [owise]

  syntax Patterns ::= removeTrivialEqualities(Patterns) [function]
  rule removeTrivialEqualities(.Patterns) => .Patterns
  rule removeTrivialEqualities(\equals(X, X), Ps) => removeTrivialEqualities(Ps)
  rule removeTrivialEqualities(P, Ps) => P, removeTrivialEqualities(Ps) [owise]
```

### Universal generalization

```
     P(x)
    ----------------------
    \forall x. P(x)
```

```k

  rule <claim> \forall{_} P => P </claim>
       <k> universal-generalization => noop ...</k>

```

### Propagate exists

The strategy `propagate-exists-through-application N` finds the Nth existential
quantifier that is used as an argument of an application, and propagates it outside
the application. For example, the formula `f(\exists X. Phi)` gets rewritten
to `\exists X. f(Phi)`.

```
Gamma |- C[\exists X. C_\sigma[Phi]]
------------------------------------
Gamma |- C[C_\sigma[\exists X. Phi]]
```

```k
  rule <claim> P
            => propagateExistsThroughApplicationVisitorResult(
                 visitTopDown(
                   propagateExistsThroughApplicationVisitor(N),
                   P
                 )
               )
      </claim>
       <k> propagate-exists-through-application N
               => noop
       ...</k>

  syntax Visitor ::= propagateExistsThroughApplicationVisitor(Int)

  syntax Pattern ::= propagateExistsThroughApplicationVisitorResult(VisitorResult) [function]

  rule propagateExistsThroughApplicationVisitorResult(visitorResult(_, P)) => P

  rule visit(propagateExistsThroughApplicationVisitor(N) #as V, P)
       => #if isApplication(P) andBool N >=Int 0
          #then propagateExistsThroughApplication(N, P)
          #else visitorResult(V, P) #fi

  syntax VisitorResult ::= propagateExistsThroughApplication(Int, Pattern) [function]
                         | #propagateExistsThroughApplication(Patterns, Int, Symbol, Patterns) [function]

  rule propagateExistsThroughApplication(N, S::Symbol(Ps::Patterns))
    => #propagateExistsThroughApplication(.Patterns, N, S, Ps)

  rule #propagateExistsThroughApplication(Ps1, N, S, (P, Ps2))
    => #propagateExistsThroughApplication((Ps1 ++Patterns P, .Patterns), N, S, Ps2)
    requires ((\exists{_} _) :/=K P) orBool ((\exists{.Patterns} _) :=K P)

  rule #propagateExistsThroughApplication(Ps1, N, S, (\exists{V, Vs} P, Ps2))
    => #propagateExistsThroughApplication(Ps1 ++Patterns (\exists{V, Vs} P, .Patterns), N -Int 1, S, Ps2)
    requires N >=Int 1

  rule #propagateExistsThroughApplication(Ps1, 0, S, (\exists{V, Vs} P, Ps2))
    => visitorResult(
         propagateExistsThroughApplicationVisitor(-1),
         \exists{V} S(Ps1 ++Patterns (maybeExists{Vs} P, .Patterns) ++Patterns Ps2)
       )

  rule #propagateExistsThroughApplication(Ps, N, S, .Patterns)
    => visitorResult(
         propagateExistsThroughApplicationVisitor(N),
         S(Ps)
       )

```

### Propagate predicate

`propagate-predicate-through-application(P, N)` rewrites a subpattern of the form
`f(Pred /\ Phi)` to `Pred /\ f(Phi)`, given that `Pred` is a predicate.
The subpattern is chosen such that `Pred` is the `N`th (counting from 0) instance of the pattern `P`
that is immediately surrounded by `\and(...)` and symbol application.
For instance, if N=3 and P=\equals(#A, #B), then the formula
`f(A=B /\ Phi1, C=D) \/ f(Phi2 /\ E=F, G=H)` gets rewritten to
`f(A=B /\ Phi1, C=D) \/ (E=F /\ f(Phi2, G=H))` (assuming that Phi1 and Phi2 are not equalities).

```

Gamma |- C[P /\ C_\sigma[Phi]]
------------------------------ where P is a predicate pattern
Gamma |- C[C_\sigma[P /\ Phi]]
```

```k
  rule <claim> T
            => pptaVisitorResult(
                 visitTopDown(
                   pptaVisitor(P, N),
                   T
                 )
               )
      </claim>
       <k> propagate-predicate-through-application(P, N)
               => noop
       ...</k>


  syntax Visitor ::= pptaVisitor(Pattern, Int)

  syntax Pattern ::= pptaVisitorResult(VisitorResult) [function]

  rule pptaVisitorResult(visitorResult(_, P)) => P

  rule visit(pptaVisitor(P, N) #as V, T)
       => #if isApplication(T) andBool N >=Int 0
          #then ppta(P, N, T)
          #else visitorResult(V, T) #fi

  syntax VisitorResult ::= ppta(Pattern, Int, Pattern) [function]
                         | "#ppta1" "(" "processedArgs:" Patterns
                                    "," "pattern:" Pattern
                                    "," "index:" Int
                                    "," "symbol:" Symbol
                                    "," "remainingArgs:" Patterns
                                    ")" [function]
                         | "#ppta2" "(" "processedArgs:" Patterns
                                    "," "result:" KItem
                                    "," "currArg:" Pattern
                                    "," "pattern:" Pattern
                                    "," "symbol:" Symbol
                                    "," "remainingArgs:" Patterns
                                    ")" [function]


  rule ppta(P, N, S::Symbol(As::Patterns))
    => #ppta1( processedArgs: .Patterns
             , pattern: P
             , index: N
             , symbol: S
             , remainingArgs: As
             )

  rule #ppta1( processedArgs: As1
             , pattern: P
             , index: N
             , symbol: S
             , remainingArgs: .Patterns
             )
       => visitorResult(pptaVisitor(P, N), S(As1))

  rule #ppta1( processedArgs: As1
             , pattern: P
             , index: N
             , symbol: S
             , remainingArgs: (A, As2)
             )
    => #ppta2( processedArgs: As1
             , result: pptaProcessArg(N, P, A)
             , currArg: A
             , pattern: P
             , symbol: S
             , remainingArgs: As2
             )

  rule #ppta2( processedArgs: As1
             , result: pptaNoMatch(N)
             , currArg: A
             , pattern: P
             , symbol: S
             , remainingArgs: As2
             )
    => #ppta1( processedArgs: As1 ++Patterns (A, .Patterns)
             , pattern: P
             , index: N
             , symbol: S
             , remainingArgs: As2
             )

  rule #ppta2( processedArgs: As1
             , result: pptaMatch(pred: P', newArg: A')
             , currArg: _
             , pattern: P
             , symbol: S
             , remainingArgs: As2
             )
    => visitorResult(
         pptaVisitor(P, -1),
         \and(P', S(As1 ++Patterns (A', .Patterns) ++Patterns As2))
       )

  syntax KItem ::= pptaNoMatch(Int)
                 | "pptaMatch" "(" "pred:" Pattern "," "newArg:" Pattern ")"
                 | pptaProcessArg(Int, Pattern, Pattern) [function]
                 | #pptaProcessArg(Int, Pattern, Patterns, Patterns) [function]

  rule pptaProcessArg(N, P, T)
    => pptaNoMatch(N)
       requires \and(_) :/=K T

  rule pptaProcessArg(N, P, \and(Ps))
    => #pptaProcessArg(N, P, .Patterns, Ps)

  rule #pptaProcessArg(N, P, Ps1, .Patterns)
    => pptaNoMatch(N)

  rule #pptaProcessArg(N, P, Ps1, (P', Ps2))
    => #if #matchResult(subst: _) :=K syntacticMatch(
                           terms: (P', .Patterns)
                         , patterns: (P, .Patterns)
                         , variables: getUniversallyQuantifiedVariables(P)
                                      ++Patterns getSetVariables(P)
                         )
          andBool isPredicatePattern(P')
       #then
         #if N ==Int 0 #then
           pptaMatch(pred: P', newArg: maybeAnd(Ps1 ++Patterns Ps2))
         #else
           #pptaProcessArg(N -Int 1, P, Ps1 ++Patterns (P', .Patterns), Ps2)
         #fi
       #else
         #pptaProcessArg(N, P, Ps1 ++Patterns (P', .Patterns), Ps2)
       #fi

```
### Propagate conjunct through exists

In its simplest form, `propagate-conjunct-through-exists(0,0)`
rewrites the pattern `\exists X. (Pi /\ Psi)` to `Pi /\ exists X. Psi`,
assuming that `Pi` does not contain free `X`. In the general form,
`propagate-conjunct-through-exists(N, M)` will operate on the M-th conjunct
of the N-th instance of the pattern `\exists {_} \and(...)`.

```
Gamma |- C[Pi /\ \exists X. Psi]
-------------------------------- where X not free in Pi
Gamma |- C[\exists X. Pi /\ Psi]
```

```k

  rule <claim> T
            => visitorResult.getPattern(
                 visitTopDown(
                   pcteVisitor(N, M),
                   T
                 )
               )
       </claim>
       <k>
         propagate-conjunct-through-exists(N, M) => noop
       ...</k>

  syntax Visitor ::= pcteVisitor(Int, Int)

  rule visit(pcteVisitor(_,_) #as V, P)
    => visitorResult(V, P)
    requires \exists{_} _ :/=K P

  rule visit(pcteVisitor(_,_) #as V, (\exists{_} P') #as P)
    => visitorResult(V, P)
    requires \and(_) :/=K P'

  rule visit(pcteVisitor(N, M) #as V, (\exists{Vs} \and(Ps)) #as P)
    => #if N <Int 0 #then
         visitorResult(V, P)
       #else #if N >Int 0 #then
         visitorResult(pcteVisitor(N -Int 1, M), P)
       #else // N ==Int 0
         pcte1(M, Vs, Ps)
       #fi #fi

  syntax VisitorResult ::= pcte1(Int, Patterns, Patterns) [function]

  rule pcte1(M, Vs, Ps)
    => pcte2(idx: M,
             vars: Vs,
             ps1: takeFirst(M, Ps),
             pattern: getMember(M, Ps),
             ps2: skipFirst(M +Int 1, Ps) )
    requires getLength(Ps) >Int M

  syntax VisitorResult ::= "pcte2" "(" "idx:" Int
                                   "," "vars:" Patterns
                                   "," "ps1:" Patterns
                                   "," "pattern:" Pattern
                                   "," "ps2:" Patterns
                                   ")" [function]

  rule pcte2(idx: M, vars: Vs, ps1: Ps1, pattern: P, ps2: Ps2)
    => visitorResult(
         pcteVisitor(-1, M),
         maybeExists{takeFirst(getLength(Vs) -Int 1, Vs)}
         \and(P, \exists{getLast(Vs), .Patterns} maybeAnd(Ps1 ++Patterns Ps2), .Patterns)
       )
    requires notBool (getLast(Vs) in getFreeVariables(P))

```

```k
endmodule
```

