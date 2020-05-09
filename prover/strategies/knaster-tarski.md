```k
module STRATEGY-KNASTER-TARSKI
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS
  imports STRATEGY-UNFOLDING
  imports STRATEGY-MATCHING
```

### Knaster Tarski (Least Fixed Point)

this high-level implementation of the knaster tarski rule attempts the applying
the rule to each recursive predicate in turn. it also includes a heuristic
for guessing an instantiation of the inductive hypothesis.

```k
  syntax Patterns ::= getKTUnfoldables(Patterns)   [function]
  rule getKTUnfoldables(.Patterns) => .Patterns
  rule getKTUnfoldables(R(ARGS), REST)
    => R(ARGS), getKTUnfoldables(REST)
    requires isUnfoldable(R)
  rule getKTUnfoldables(S:Symbol, REST)
    => getKTUnfoldables(REST)
    requires notBool isUnfoldable(S)
  rule getKTUnfoldables(S:Symbol(ARGS), REST)
    => getKTUnfoldables(REST)
    requires notBool isUnfoldable(S)
     andBool S =/=K sep
  rule getKTUnfoldables(I:Int, REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(V:Variable, REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(\not(Ps), REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(\and(Ps), REST)
    => getKTUnfoldables(Ps) ++Patterns getKTUnfoldables(REST)
  rule getKTUnfoldables(sep(Ps), REST)
    => getKTUnfoldables(Ps) ++Patterns getKTUnfoldables(REST)
  rule getKTUnfoldables(\implies(LHS, RHS), REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(\equals(LHS, RHS), REST)
    => getKTUnfoldables(LHS) ++Patterns
       getKTUnfoldables(RHS) ++Patterns
       getKTUnfoldables(REST)
  rule getKTUnfoldables(\exists { .Patterns } P, REST)
    => getKTUnfoldables(P, REST)
  rule getKTUnfoldables(\forall { .Patterns } P, REST)
    => getKTUnfoldables(P, REST)
```

```k
  rule <k> kt => kt # .KTFilter ... </k>
  rule <claim> \implies(\and(LHS), RHS) </claim>
       <k> kt # FILTER
               => getKTUnfoldables(LHS) ~> kt # FILTER
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt # head(HEAD)
               => filterByConstructor(LRPs, HEAD) ~> kt # .KTFilter
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt # index(I:Int)
               => getMember(I, LRPs), .Patterns ~> kt # .KTFilter
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt # .KTFilter
               => ktForEachLRP(LRPs)
                  ...
       </k>
```

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:

```k
  syntax Strategy ::= ktForEachLRP(Patterns)
  rule <k> ktForEachLRP(.Patterns) => noop ... </k>
  rule <k> ( ktForEachLRP((LRP, LRPs))
                 => ( remove-lhs-existential . normalize . or-split-rhs . lift-constraints
                    . kt-wrap(LRP) . kt-forall-intro
                    . kt-unfold . lift-or . and-split . remove-lhs-existential
                    . kt-unwrap
                    . simplify . normalize . or-split-rhs. lift-constraints. kt-collapse
                    )
                    | ktForEachLRP(LRPs)
                  )
                 ~> REST
       </k>
```

```k
  rule <k> kt-unf => kt-unf # .KTFilter ... </k>
  rule <claim> \implies(\and(LHS), RHS) </claim>
       <k> kt-unf # FILTER
               => getKTUnfoldables(LHS) ~> kt-unf # FILTER
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt-unf # head(HEAD)
               => filterByConstructor(LRPs, HEAD) ~> kt-unf # .KTFilter
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt-unf # index(I:Int)
               => getMember(I, LRPs), .Patterns ~> kt-unf # .KTFilter
                  ...
       </k>
  rule <k> LRPs:Patterns ~> kt-unf # .KTFilter
               => ktUnfForEachLRP(LRPs)
                  ...
       </k>
```

`ktUnfForEachLRP` iterates over the recursive predicates on the LHS of the goal:

```k
  syntax Strategy ::= ktUnfForEachLRP(Patterns)
  rule <k> ktUnfForEachLRP(.Patterns) => noop ... </k>
  rule <k> ( ktUnfForEachLRP((LRP, LRPs))
                 => ( remove-lhs-existential . normalize . or-split-rhs . lift-constraints
                    . kt-wrap(LRP) . kt-forall-intro
                    . kt-unfold . lift-or . and-split . remove-lhs-existential
                    . kt-unwrap
                    . simplify . normalize . or-split-rhs. lift-constraints
                    . ( ( kt-collapse )
                      | ( imp-ctx-unfold . kt-collapse )
                      )
                    )
                    | ktUnfForEachLRP(LRPs)
                  )
                 ~> REST
       </k>
```

>   phi(x) -> C'[psi(x)]
>   --------------------
>   C[phi(x)] -> psi(x)
>
> where `C'[psi(x)] ≡ \exists #hole . #hole /\ ⌊C[#hole] -> psi(x)⌋`

## kt-wrap (FOL)

```k
  syntax Strategy ::= "kt-wrap" "(" Pattern ")"
  rule <claim> \implies(\and(LHS:Patterns), RHS)
        => \implies(LRP, implicationContext(\and(#hole, (LHS -Patterns LRP)), RHS))
       </claim>
       <k> kt-wrap(LRP) => noop ... </k>
       <trace> .K => kt-wrap(LRP)  ... </trace>
    requires LRP in LHS
     andBool isPredicatePattern(\and(LHS))
```

## kt-wrap (SL)

```k
  rule <claim> \implies(\and(sep(LSPATIAL), LCONSTRAINT:Patterns), RHS)
            => \implies(LRP, implicationContext(\and( sep(#hole, (LSPATIAL -Patterns LRP))
                                                    , LCONSTRAINT
                                                    )
                                               , RHS)
                       )
       </claim>
       <k> kt-wrap(LRP) => noop ... </k>
       <trace> .K => kt-wrap(LRP)  ... </trace>
    requires LRP in LSPATIAL
     andBool isSpatialPattern(sep(LSPATIAL))
```

>   phi(x) -> \forall y. psi(x, y)
>   ------------------------------
>         phi(x) -> psi(x, y)

```k
  syntax Strategy ::= "kt-forall-intro"
  rule <claim> \implies(LHS, RHS) #as GOAL
        => \implies( LHS
                   , \forall { getUniversalVariables(GOAL) -Patterns getFreeVariables(LHS, .Patterns) }
                             RHS
                   )
       </claim>
       <k> kt-forall-intro => noop ... </k>
```

>         phi(x) -> psi(x, y)
>   ------------------------------
>   phi(x) -> \forall y. psi(x, y)

```k
  syntax Strategy ::= "kt-forall-elim"
  rule <claim> \implies(LHS, \forall { Vs } RHS) => \implies(LHS, RHS) </claim>
       <k> kt-forall-elim => noop ... </k>
    requires getFreeVariables(LHS) -Patterns Vs ==K getFreeVariables(LHS)
```


// unfold+lfp

```k
  syntax Strategy ::= "kt-unfold"
  rule <claim> \implies( LRP(ARGS) #as LHS
                  => substituteBRPs(unfold(LHS), LRP, ARGS, RHS)
                   , RHS
                   )
       </claim>
       <k> kt-unfold => noop ... </k>
    requires removeDuplicates(ARGS) ==K ARGS
     andBool isUnfoldable(LRP)
  rule <claim> \implies(LRP(ARGS), RHS)
       </claim>
       <k> kt-unfold => fail ... </k>
    requires removeDuplicates(ARGS) =/=K ARGS
     andBool isUnfoldable(LRP)

                             // unfolded fixed point, HEAD, LRP variables, RHS
  syntax Pattern ::= substituteBRPs(Pattern,  Symbol, Patterns, Pattern) [function]
  rule substituteBRPs(P:Int, RP, Vs, RHS) => P
  rule substituteBRPs(P:Variable, RP, Vs, RHS) => P
  rule substituteBRPs(P:Symbol, RP, Vs, RHS) => P
  rule substituteBRPs(S:Symbol(ARGS) #as P, RP, Vs, RHS) => P
    requires S =/=K RP
     andBool S =/=K sep
 rule substituteBRPs(RP(BODY_ARGS), RP, ARGS, RHS)
   => alphaRename(substMap(alphaRename(RHS), zip(ARGS, BODY_ARGS)))

  rule substituteBRPs(\top(), RP, Vs, RHS) => \top()
  rule substituteBRPs(\bottom(), RP, Vs, RHS) => \bottom()
  rule substituteBRPs(\equals(P1, P2), RP, Vs, RHS)
    => \equals( substituteBRPs(P1, RP, Vs, RHS)
              , substituteBRPs(P2, RP, Vs, RHS)
              )
  rule substituteBRPs(\not(P), RP, Vs, RHS)
    => \not(substituteBRPs(P, RP, Vs, RHS))

  rule substituteBRPs(\or(Ps), RP, Vs, RHS)  => \or(substituteBRPsPs(Ps, RP, Vs, RHS))
  rule substituteBRPs(\and(Ps), RP, Vs, RHS) => \and(substituteBRPsPs(Ps, RP, Vs, RHS))
  rule substituteBRPs(sep(Ps), RP, Vs, RHS) => sep(substituteBRPsPs(Ps, RP, Vs, RHS))

  rule substituteBRPs(\exists { E } C, RP, Vs, RHS)
    => \exists { E } substituteBRPs(C, RP, Vs, RHS)
//  rule substituteBRPs(\forall { E } C, RP, Vs, RHS)
//    => \forall { E } substituteBRPs(C, RP, Vs, RHS) [owise]

  syntax Patterns ::= substituteBRPsPs(Patterns, Symbol, Patterns, Pattern) [function]
  rule substituteBRPsPs(.Patterns, RP, Vs, RHS) => .Patterns
  rule substituteBRPsPs((P, Ps), RP, Vs, RHS) => substituteBRPs(P, RP, Vs, RHS), substituteBRPsPs(Ps, RP, Vs, RHS):Patterns
```

```k
  syntax Strategy ::= "kt-unwrap"
  rule <claim> \implies(LHS, \forall { UNIV } implicationContext(CTX, RHS))
        => \implies(subst(CTX, #hole, LHS), RHS)
       </claim>
       <k> kt-unwrap => noop ... </k>
```


### `kt-collapse`

```k
  syntax Strategy ::= "kt-collapse"
```

If there are no implication contexts to collapse, we are done:

```k
  rule <claim> GOAL </claim>
       <k> kt-collapse => noop ... </k>
    requires notBool(hasImplicationContext(GOAL))

  rule <claim> GOAL </claim>
       <k> imp-ctx-unfold => noop ... </k>
    requires notBool(hasImplicationContext(GOAL))
```

#### Normalizing terms

Bring terms containing the implication context to the front:

```k
  // FOL case
  rule <claim> \implies(\and(P, Ps) #as LHS, RHS)
            => \implies(\and(Ps ++Patterns P), RHS)
       </claim>
       <k> kt-collapse ... </k>
    requires notBool hasImplicationContext(P)
     andBool hasImplicationContext(LHS)
```

```k
  // SL case
  rule <claim> \implies(\and((sep(S, Ss) #as LSPATIAL), Ps), RHS)
            => \implies(\and(sep(Ss ++Patterns S), Ps), RHS)
       </claim>
       <k> kt-collapse ... </k>
    requires notBool hasImplicationContext(S)
     andBool hasImplicationContext(LSPATIAL)

  rule <claim> \implies(\and((sep(S, Ss) #as LSPATIAL), Ps), RHS)
            => \implies(\and(sep(Ss ++Patterns S), Ps), RHS)
       </claim>
       <k> imp-ctx-unfold ... </k>
    requires notBool hasImplicationContext(S)
     andBool hasImplicationContext(LSPATIAL)
```

Move #holes to the front

// TODO: would:
// rule P, #hole, REST => #hole, P, REST [anywhere]
// be better?

```k
  rule <claim> \implies(\and(\forall { _ }
                         implicationContext( \and(P, Ps)
                                          => \and(Ps ++Patterns P)
                                           , _)
                        , _), _)
       </claim>
       <k> kt-collapse ... </k>
    requires P =/=K #hole:Pattern
     andBool #hole in Ps

  rule <claim> \implies(\and(sep(\forall { _ }
                         implicationContext( \and(P, Ps)
                                          => \and(Ps ++Patterns P)
                                           , _)
                        ,_ ), _), _)
       </claim>
       <k> kt-collapse ... </k>
    requires P =/=K #hole:Pattern
     andBool #hole in Ps
```

#### Collapsing contexts (FOL)

In the FOL case, we create an implication, and dispatch that to the smt
solver using `kt-solve-implications`

```k
  rule <claim> \implies(\and( \forall { UNIVs }
                              ( implicationContext( \and(#hole, CTXLHS:Patterns)
                                                  , CTXRHS:Pattern
                                                  )
                             => \implies(\and(CTXLHS), CTXRHS)
                              )
                        , LHS:Patterns
                        )
                   , RHS:Pattern
                   )
       </claim>
       <k> kt-collapse ... </k>
```

#### Collapsing contexts (SL)

In the separation logic case, we must use matching.

First, we use matching to instantiate the quantifiers of the implication context.
Then we apply the substitution to the context, including the constraints.
Next, duplicate constraints are removed using the ad-hoc rule below until the implication
context has no constraints.

```k
  rule <claim> \implies(\and( sep ( \forall { UNIVs }
                                    implicationContext( \and(sep(#hole, CTXLHS:Patterns), CTXLCONSTRAINTS) , _)
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> kt-collapse
               => with-each-match( #match(terms: LSPATIAL, pattern: CTXLHS, variables: UNIVs)
                                 , kt-collapse
                                 )
                  ...
       </k>
     requires UNIVs =/=K .Patterns
```

```k
  rule <claim> \implies(\and( ( sep ( \forall { UNIVs => .Patterns }
                                      ( implicationContext( \and(sep(_), CTXLCONSTRAINTS), CTXRHS ) #as CTX
                                     => substMap(CTX, SUBST)
                                      )
                                    , LSPATIAL
                                    )
                              )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> ( #matchResult(subst: SUBST, rest: REST) ~> kt-collapse )
               => kt-collapse
                  ...
       </k>
     requires UNIVs =/=K .Patterns
      andBool UNIVs -Patterns fst(unzip(SUBST)) ==K .Patterns

  rule <claim> \implies(\and( ( sep ( \forall { UNIVs => .Patterns }
                                      ( implicationContext( \and(sep(_), CTXLCONSTRAINTS), CTXRHS ) #as CTX
                                      )
                                    , LSPATIAL
                                    )
                              )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> ( #matchResult(subst: SUBST, rest: REST) ~> kt-collapse )
               => fail
                  ...
       </k>
     requires UNIVs =/=K .Patterns
      andBool UNIVs -Patterns fst(unzip(SUBST)) =/=K .Patterns
```

Finally, we use matching on the no universal quantifiers case to collapse the context.

```k
  rule <claim> \implies(\and( sep ( \forall { .Patterns }
                                    implicationContext( \and(sep(#hole, CTXLHS:Patterns)) , _)
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> kt-collapse
               => with-each-match( #match(terms: LSPATIAL, pattern: CTXLHS, variables: .Patterns)
                                 , kt-collapse
                                 )
                  ...
       </k>

  rule <claim> \implies( \and( ( sep ( \forall { .Patterns }
                                       implicationContext( \and(sep(_)) , CTXRHS)
                                     , LSPATIAL
                                     )
                              => sep(substMap(CTXRHS, SUBST) ++Patterns REST)
                               )
                               , LHS:Patterns
                             )
                       , RHS:Pattern
                       )
       </claim>
       <k> ( #matchResult(subst: SUBST, rest: REST) ~> kt-collapse )
               => kt-collapse
                  ...
       </k>
```

TODO: This is pretty adhoc: Remove constraints in the context that are already in the LHS

```k
  rule <claim> \implies(\and( sep ( \forall { .Patterns }
                                    implicationContext( \and( sep(_)
                                                            , ( CTXCONSTRAINT, CTXCONSTRAINTs
                                                             => CTXCONSTRAINTs
                                                              )
                                                            ) , _)
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> kt-collapse ... </k>
    requires isPredicatePattern(CTXCONSTRAINT)
     andBool CTXCONSTRAINT in LHS

  rule <claim> \implies(\and( sep ( \forall { .Patterns }
                                    implicationContext( \and( sep(_)
                                                            , ( CTXCONSTRAINT, CTXCONSTRAINTs )
                                                            ) , _)
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> kt-collapse => fail ... </k>
    requires isPredicatePattern(CTXCONSTRAINT)
     andBool notBool (CTXCONSTRAINT in LHS)
```

### Unfolding within the implication context

```k
  syntax Strategy ::= "imp-ctx-unfold"
```

```k
  rule <claim> \implies(\and( sep ( \forall { UNIVs }
                                    implicationContext( \and( sep( #hole
                                                                 , CTXLHS:Patterns
                                                                 )
                                                            , CTXLCONSTRAINTS
                                                            )
                                                      , _
                                                      )
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> imp-ctx-unfold => right-unfold-eachRRP(getUnfoldables(CTXLHS)) ... </k>
     requires UNIVs =/=K .Patterns

  rule <claim> \implies(\and( sep ( \forall { .Patterns }
                                    implicationContext( \and(sep(#hole, CTXLHS:Patterns)) , _)
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> imp-ctx-unfold => right-unfold-eachRRP(getUnfoldables(CTXLHS)) ... </k>
```

#### Infrastructure


```k
  syntax Patterns ::= substituteWithEach(Pattern, Variable, Patterns) [function]
  rule substituteWithEach(_, _, .Patterns) => .Patterns
  rule substituteWithEach(P, V, (I, Is))
    => subst(P, V, I), substituteWithEach(P, V, Is)

  syntax Patterns ::= filterVariablesBySort(Patterns, Sort) [function]
  rule filterVariablesBySort(.Patterns, _) => .Patterns
  rule filterVariablesBySort(((_ { S } #as V), Vs), S)
    => V, filterVariablesBySort(Vs, S)
  rule filterVariablesBySort((V, Vs), S)
    => filterVariablesBySort(Vs, S) [owise]

  // TODO: Move to "normalize" strategy
  rule <claim> \implies(\and(\and(Ps1), Ps2), RHS)
        => \implies(\and(Ps1 ++Patterns Ps2), RHS)
       </claim>
       <k> kt-collapse ... </k>
  rule <claim> \implies(\and(_, ( \and(Ps1), Ps2
                           => Ps1 ++Patterns Ps2))
                   , RHS)
       </claim>
       <k> kt-collapse ... </k>

  rule <claim> \implies(\and( _
                        , (\exists { _ } P => P)
                        , Ps)
                   , _
                   )
       </claim>
       <k> kt-collapse ... </k>
```

>   gamma -> alpha     beta /\ gamma -> psi
>   ---------------------------------------
>      (alpha -> beta) /\ gamma -> psi

```k
  rule <claim> \implies( \and(\forall { Us } \implies(LHS, RHS), REST:Patterns), RHS2 )
            => \implies( \and(REST), RHS2 )
       </claim>
       <k> kt-solve-implications( STRAT)
        => ( kt-solve-implication( subgoal(\implies(\and(removeImplications(REST)), \exists { Us } LHS), STRAT)
                                 , \and(LHS, RHS)
                                 )
           . kt-solve-implications(STRAT)
           )
           ...
       </k>

  syntax Patterns ::= removeImplications(Patterns) [function]
  rule removeImplications(P, Ps) => P, removeImplications(Ps)
    requires notBool matchesImplication(P)
  rule removeImplications(P, Ps) => removeImplications(Ps)
    requires matchesImplication(P)
  rule removeImplications(.Patterns) => .Patterns

  rule <claim> \implies( \and(P:Pattern, REST:Patterns)
                  => \and(REST ++Patterns P)
                   , _
                   )
       </claim>
       <k> kt-solve-implications(_)
                  ...
       </k>
    requires hasImplication(REST)
     andBool notBool matchesImplication(P)

  rule <claim> \implies(\and(LHS), _) </claim>
       <k> kt-solve-implications(STRAT) => noop ... </k>
     requires notBool hasImplication(LHS)

  syntax Bool ::= matchesImplication(Pattern)    [function]
  rule matchesImplication(\forall { _ } \implies(LHS, RHS)) => true
  rule matchesImplication(P)                  => false [owise]

  syntax Bool ::= hasImplication(Patterns) [function]
  rule hasImplication(.Patterns) => false
  rule hasImplication(P, Ps)
    => matchesImplication(P) orBool hasImplication(Ps)
```

If the subgoal in the first argument succeeds add the second argument to the LHS, otherwise do nothing:

```k
  syntax Strategy ::= "kt-solve-implication" "(" Strategy "," Pattern ")"
  rule <k> kt-solve-implication(S, RHS)
               => S ~> kt-solve-implication(#hole, RHS)
                  ...
       </k>
    requires notBool isTerminalStrategy(S)
    
  rule <k> T:TerminalStrategy ~> kt-solve-implication(#hole, RHS)
               => kt-solve-implication(T, RHS)
                  ...
       </k>
  rule <k> kt-solve-implication(fail, RHS) => noop ... </k>
  rule <k> kt-solve-implication(success, CONC) => noop ... </k>
       <claim> \implies(\and(LHS), RHS)
        => \implies(\and(CONC, LHS), RHS)
       </claim>
```

```k
  syntax Strategy ::= "instantiate-universals-with-ground-terms" "(" Patterns /* universals */ "," Patterns /* ground terms */ ")"
  rule <claim> \implies(\and(LHS), RHS) #as GOAL </claim>
       <k> instantiate-universals-with-ground-terms
               => instantiate-universals-with-ground-terms(getForalls(LHS), removeDuplicates(getGroundTerms(GOAL)))
                  ...
       </k>

  rule <k> instantiate-universals-with-ground-terms( (\forall { (_ { S } #as V:Variable), UNIVs:Patterns } P:Pattern , REST_FORALLs)
                                => (substituteWithEach(\forall { UNIVs } P, V, filterBySort(GROUND_TERMS, S)) ++Patterns REST_FORALLs)
                                 , GROUND_TERMS
                                 )
                  ...
       </k>

  rule <claim> \implies(\and(LHS => P, LHS), RHS) </claim> 
       <k> instantiate-universals-with-ground-terms( (\forall { .Patterns } P:Pattern , REST_FORALLs) => REST_FORALLs 
                                 , _
                                 )
                  ...
       </k>
    requires notBool P in LHS
  rule <claim> \implies(\and(LHS), RHS) </claim> 
       <k> instantiate-universals-with-ground-terms( (\forall { .Patterns } P:Pattern , REST_FORALLs) => REST_FORALLs 
                                 , _
                                 )
                  ...
       </k>
    requires P in LHS

  rule <k> instantiate-universals-with-ground-terms( .Patterns
                                 , _
                                 )
               => noop
                  ...
       </k>

  syntax Patterns ::= getForalls(Patterns) [function]
  rule getForalls(((\forall { _ } _) #as P), Ps) => P, getForalls(Ps)
  rule getForalls(                       P , Ps) =>    getForalls(Ps) [owise]
  rule getForalls(.Patterns) => .Patterns 
  
  syntax Patterns ::= filterBySort(Patterns, Sort) [function]
  rule filterBySort((P, Ps), S) => P, filterBySort(Ps, S) requires getReturnSort(P) ==K S
  rule filterBySort((P, Ps), S) =>    filterBySort(Ps, S) requires getReturnSort(P) =/=K S
  rule filterBySort(.Patterns, S) => .Patterns

  syntax Bool ::= hasForall(Patterns)    [function]
  rule hasForall(P, Ps) => matchesForall(P) orBool hasForall(Ps)
  rule hasForall(.Patterns) => false
  syntax Bool ::= matchesForall(Pattern) [function]
  rule matchesForall(\forall{ _ } _) => true
  rule matchesForall(_) => false [owise]
```

```k
endmodule
```
