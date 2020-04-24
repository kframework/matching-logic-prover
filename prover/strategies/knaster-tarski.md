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
  rule getKTUnfoldables(\or(Ps), REST)
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
  rule <k> ktForEachLRP(.Patterns) => fail ... </k>
  rule <k> ( ktForEachLRP((LRP, LRPs))
                 => ( remove-lhs-existential . normalize . or-split-rhs . lift-constraints
                    . kt-wrap(LRP) . kt-forall-intro
                    . kt-unfold . remove-lhs-existential
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

## kt-wrap

```k
  syntax Strategy ::= "kt-wrap" "(" Pattern ")"
  rule <claim> \implies(LHS, RHS)
            => \implies(LRP, implicationContext(subst(LHS, LRP, #hole { getReturnSort(LRP) } ), RHS))
       </claim>
       <k> kt-wrap(LRP) => noop ... </k>
    requires #hole { getReturnSort(LRP) } in getFreeVariables(subst(LHS, LRP, #hole { getReturnSort(LRP) }))
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
  syntax Strategy ::= "kt-unfold" | "kt-unfold" "(" Pattern ")"
  rule <claim> \implies(LHS, RHS) </claim>
       <k> kt-unfold => kt-unfold(unfold(LHS)) ... </k>
  rule <claim> \implies(LRP(ARGS) #as LHS, RHS)
            => \implies(UNFOLDED_LHS, RHS)
       </claim>
       <k> kt-unfold(UNFOLDED_LHS)
               => lift-or . and-split
                . kt-subst(filterByConstructor(getUnfoldables(UNFOLDED_LHS), LRP), ARGS)
                  ...
       </k>
    requires removeDuplicates(ARGS) ==K ARGS
     andBool isUnfoldable(LRP)
  rule <claim> \implies(LRP(ARGS), RHS) </claim>
       <k> kt-unfold => fail ... </k>
    requires removeDuplicates(ARGS) =/=K ARGS
     andBool isUnfoldable(LRP)

  // in LHS, substitute LRP(x') with \and(LRP(x'), RHS[x |-> x'])
  syntax Strategy ::= "kt-subst" "(" Patterns "," Patterns ")"
  rule <claim> \implies(LHS, RHS)
            => \implies( subst( LHS
                              , LRP(UNFOLDED_ARGs)
                              , \and( LRP(UNFOLDED_ARGs)
                                    , substMap(alphaRename(RHS), zip(ARGs, UNFOLDED_ARGs))
                                    )
                              )
                       , RHS
                       )
       </claim>
       <k> kt-subst((LRP:Symbol(UNFOLDED_ARGs), RECs), ARGs)
               => kt-subst(RECs, ARGs)
                  ...
       </k>
  rule <k> kt-subst(.Patterns, ARGs) => noop ... </k>

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
    requires P =/=K #hole { Bool }
     andBool #hole { Bool } in Ps

  rule <claim> \implies(\and(sep(\forall { _ }
                         implicationContext( \and(P, Ps)
                                          => \and(Ps ++Patterns P)
                                           , _)
                        ,_ ), _), _)
       </claim>
       <k> kt-collapse ... </k>
    requires P =/=K #hole { Heap }
     andBool #hole { Heap } in getFreeVariables(Ps)

  rule <claim> \implies(\and(sep(\forall { _ }
                         implicationContext( \and( (sep(P, Ps) => sep(Ps ++Patterns P))
                                                 , _)
                                           , _)
                        ,_ ), _), _)
       </claim>
       <k> kt-collapse ... </k>
    requires P =/=K #hole { Heap }
     andBool #hole { Heap } in getFreeVariables(Ps)
```

#### Collapsing contexts (FOL)

In the FOL case, we create an implication, and dispatch that to the smt
solver using `kt-solve-implications`

```k
  rule <claim> \implies(\and( \forall { UNIVs }
                              ( implicationContext( \and(#hole { Bool }, CTXLHS:Patterns)
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
                                    implicationContext( \and(sep(#hole { Heap }, CTXLHS:Patterns), CTXLCONSTRAINTS) , _)
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
  rule <claim> \implies(\and( ( sep ( \forall { UNIVs => UNIVs -Patterns fst(unzip(SUBST)) }
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
               => kt-collapse-resolve
                  ...
       </k>
     requires UNIVs =/=K .Patterns
```

       1.  LHS * ?H   /\ not(LCTXCONSTR)   -> RHS
       2a. LHS * ?H   /\ LCTXCONSTR        -> \exists X . LCTX
       2b. LHS * RCTX /\ LCTXCONSTR        -> RHS
------------------------------------------------------------------------------ Where X does not occur in RCTX or LCTXCONSTR
     LHS * \forall X. \ic(LCTX /\ LCTXCONSTR, RCTX) /\ LCONSTRAINTS -> RHS

```k
  syntax Strategy ::= "kt-collapse-resolve"
  rule <claim> \implies( \and( sep ( \forall { UNIVs }
                                     implicationContext( \and( sep(CTXLSPATIAL)
                                                             , CTXLCONSTRAINTs
                                                             )
                                                       , CTXRHS
                                                       )
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <k> kt-collapse-resolve
        => resolve(\and(getPredicatePatterns(CTXLCONSTRAINTs)))
           ...
       </k>
    requires CTXLCONSTRAINTs =/=K .Patterns
     andBool getFreeVariables(getPredicatePatterns(CTXLCONSTRAINTs)) intersect UNIVs ==K .Patterns
```

```k
    // 1 in rule above
    syntax Strategy ::= "kt-collapse-unsat"
    rule <claim> \implies( \and( sep ( \forall { UNIVs } implicationContext(_, _)
                                     , LSPATIAL
                                     )
                               , LHS:Patterns
                               )
                       , RHS:Pattern
                       )
             => \implies( \or(#dnfPs( \and( sep(LSPATIAL ++Patterns !H:VariableName { Heap })
                                          , LHS:Patterns
                                          )
                                    )
                             )
                        , RHS:Pattern
                        )
       </claim>
       <k> kt-collapse-unsat => noop ... </k>

    // 2a and 2b in rule above
    syntax Strategy ::= "kt-collapse-valid"
    rule <claim> \implies(\and( sep ( \forall { UNIVs }
                                      implicationContext( LCTX
                                                        , RCTX
                                                        )
                                    , LSPATIAL
                                    )
                              , LHS:Patterns
                              )
                         , RHS:Pattern
                         )
         </claim>
         <k> ( kt-collapse-valid ~> #hole . REST )
                 => subgoal( \implies( \and(sep(LSPATIAL ++Patterns !H:VariableName { Heap }), LHS)
                                     , \exists { UNIVs ++Patterns #hole { Heap } } LCTX
                                     )
                           , REST
                           )
                  & subgoal( \implies( \and(sep(RCTX, LSPATIAL), LHS)
                                     , RHS
                                     )
                           , REST
                           )
         </k>
      requires getFreeVariables(RCTX) intersect UNIVs ==K .Patterns
```

### Resolve

```
    PHI /\ P -> PSI        PHI /\ not(P) -> PSI
    -------------------------------------------    resolve(P)
                      PHI -> PSI
```

```k
    syntax Strategy ::= "resolve" "(" Pattern ")"
    rule <claim> \implies(\and(LHS), RHS) </claim>
         <k> ( resolve(P) ~> #hole . REST )
          => subgoal( \implies(\and(LHS ++Patterns \not(P)), RHS)
                    , kt-collapse-unsat . lift-or . and-split . REST
                    )
           & subgoal( \implies(\and(#flattenAnds(LHS ++Patterns P)), RHS)
                    , kt-collapse-valid . REST
                    )
         </k>
```


### Unfolding within the implication context

```k
  syntax Strategy ::= "imp-ctx-unfold"
```

```k
  rule <claim> \implies(\and( sep ( \forall { UNIVs }
                                    implicationContext( \and( sep( #hole { Heap }
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
                                    implicationContext( \and(sep(#hole { Heap }, CTXLHS:Patterns)) , _)
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
  rule <claim> \implies( \and(\forall { Us } \implies(LIMPLIES, RIMPLIES), LHS), RHS )
            => \implies( \and(LHS), RHS )
       </claim>
       <k> kt-solve-implications( STRAT )
        => ( kt-solve-implication( subgoal(\implies(\and(removeImplications(LHS)), \exists { Us } LIMPLIES), STRAT)
                                 , RIMPLIES
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
       <k> \implies(\and(LHS), RHS)
            => \implies(\and(CONC, LHS), RHS)
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
