```k
module MATCHING-COMMON
  imports MAP
  imports KORE-HELPERS
  imports ERROR

  syntax MatchResult ::= "#matchResult" "(" "subst:" Map "," "rest:" Patterns ")" [format(%1%2%i%n%3%i%n%4%d%n%5%i%6%n%7%d%d%8)]
                       | Error
                       | "#matchResult" "(" "subst:" Map ")"
endmodule

module MATCHING-FUNCTIONAL
  imports MATCHING-COMMON

  syntax MatchResults ::= List{MatchResult, ","} [klabel(MatchResults), format(%1%n%2 %3)]

  syntax MatchResults ::= "#match" "(" "terms:"     Patterns
                                   "," "pattern:"   Patterns
                                   "," "variables:" Patterns
                                   ")" [function]
  syntax MatchResults ::= "#matchAssoc" "(" "terms:"     Patterns
                                        "," "pattern:"   Patterns
                                        "," "variables:" Patterns
                                        "," "subst:"     Map
                                        "," "rest:"      Patterns
                                        ")" [function]
  syntax MatchResults ::= "#matchAssocComm" "(" "terms:"     Patterns
                                            "," "pattern:"   Patterns
                                            "," "variables:" Patterns
                                            "," "results:"   MatchResults
                                            "," "subst:"     Map
                                            "," "rest:"      Patterns
                                            ")" [function]

  syntax MatchResults ::= MatchResults "++MatchResults" MatchResults [function, right]
  rule (MR1, MR1s) ++MatchResults MR2s => MR1, (MR1s ++MatchResults MR2s)
  rule .MatchResults ++MatchResults MR2s => MR2s

  rule #match( terms: \and(sep(H), Hs), pattern: P, variables: Vs )
    =>                #match( terms: H,        pattern: P, variables: Vs )
       ++MatchResults #match( terms: \and(Hs), pattern: P, variables: Vs )
    requires Hs =/=K .Patterns

  rule #match( terms: \and(sep(H), .Patterns), pattern: P, variables: Vs )
    => #match( terms: H,                       pattern: P, variables: Vs )

  rule #match( terms: \and(.Patterns),         pattern: P, variables: Vs )
    => .MatchResults

  rule #match( terms: T, pattern: P, variables: Vs )
    => #filterErrors( #matchAssocComm( terms: T
                                     , pattern: P
                                     , variables: Vs
                                     , results: .MatchResults
                                     , subst: .Map
                                     , rest: .Patterns
                                     )
                    )
    requires isSpatialPattern(sep(T))

  syntax MatchResults ::= #filterErrors(MatchResults) [function]
  rule #filterErrors(MR:Error , MRs) => #filterErrors(MRs)
  rule #filterErrors(MR       , MRs) => MR , #filterErrors(MRs)
    requires notBool isError(MR)
  rule #filterErrors(.MatchResults) => .MatchResults
```

Work around OCaml not producing reasonable error messages:

```k
  syntax MatchResult ::= MatchStuck
  syntax MatchStuck ::= "#matchStuck" "(" K ")"
  syntax KItem ::= "\\n" [format(%n)]
  rule #matchAssocComm( terms: T
                      , pattern: P
                      , variables: Vs
                      , results: MRs 
                      , subst: SUBST
                      , rest: REST
                      )
    => #matchStuck( "AC" 
                 ~> "terms:" ~> T
                 ~> "pattern:" ~> P
                 ~> "variables:" ~> Vs
                 ~> "subst:" ~> SUBST
                 ~> "rest:" ~> REST
                 ~> "MRs:" ~> MRs )
     , .MatchResults
    [owise]
```

Recurse over assoc-only constructors (including `pto`):

```k
  // Base case
  rule #matchAssoc( terms:     .Patterns
                  , pattern:   .Patterns
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #matchResult(subst: SUBST, rest: REST), .MatchResults

  rule #matchAssoc( terms:     Ts
                  , pattern:   Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #error("Mismatch in length of arguments"), .MatchResults
    requires (Ts ==K .Patterns orBool Ps ==K .Patterns)
     andBool notBool (Ts ==K .Patterns andBool Ps ==K .Patterns)

  // Non-matching constructors
  rule #matchAssoc( terms:     S1:Symbol(_), Ts
                  , pattern:   S2:Symbol(_), Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #error("Constructors do not match"), .MatchResults
    requires S1 =/=K S2

  // Non-matching constructors
  rule #matchAssoc( terms:     T, Ts
                  , pattern:   S:Symbol(_), Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #error("Constructors do not match"), .MatchResults
    requires notBool isApplication(T)

  // Constructors match: Recurse over arguments
  rule #matchAssoc( terms:     S:Symbol(T_ARGs), Ts
                            => T_ARGs ++Patterns Ts
                  , pattern:   S:Symbol(P_ARGs), Ps
                            => P_ARGs ++Patterns Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    requires S =/=K sep

  // ground variable: identical
  rule #matchAssoc( terms:     P:Variable, Ts => Ts
                  , pattern:   P:Variable, Ps => Ps
                  , variables: Vs
                  , subst:     _
                  , rest:      REST
                  )
    requires notBool P in Vs

  // ground variable: non-identical
  rule #matchAssoc( terms:     T, Ts
                  , pattern:   P:Variable, Ps
                  , variables: Vs
                  , subst:     _
                  , rest:      REST
                  )
    => #error( "No valid substitution" ), .MatchResults
    requires T =/=K P
     andBool notBool P in Vs
     
  // free variable: different sorts
  rule #matchAssoc( terms:     T         , Ts
                  , pattern:   P:Variable, Ps
                  , variables: Vs
                  , subst:     _
                  , rest:      REST
                  )
    => #error("Variable sort does not match term"), .MatchResults
    requires T =/=K P
     andBool P in Vs
     andBool getReturnSort(T) =/=K getReturnSort(P)

  // free variable: extend substitution
  rule #matchAssoc( terms:     T         , Ts => Ts
                  , pattern:   P:Variable, Ps => substPatternsMap(Ps, P |-> T)
                  , variables: Vs
                  , subst:     SUBST => ((P |-> T) SUBST)
                  , rest:      REST
                  )
    requires T =/=K P
     andBool P in Vs
     andBool getReturnSort(T) ==K getReturnSort(P)
```

Recurse over assoc-comm `sep`:

```k
// Base case: If pattern is larger than term, there can be no match
  rule #matchAssocComm( terms:     .Patterns
                      , pattern:   P, Ps
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #error( "Pattern larger than term" ), .MatchResults
    requires notBool P in Vs

// Base case: emp matches all heaps
  rule #matchAssocComm( terms:     Ts
                      , pattern:   .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchResult(subst: SUBST, rest: REST ++Patterns Ts), .MatchResults

// Base case: If matching a single term against an atomic pattern, use Assoc Matching
  rule #matchAssocComm( terms:     T, .Patterns
                      , pattern:   P, .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchAssoc( terms: T
                  , pattern: P
                  , variables: Vs
                  , subst: SUBST
                  , rest:      REST
                  )
    requires notBool P in Vs
```

Matching an atomic pattern against multiple terms: return a disjunction of the solutions

```k
  rule #matchAssocComm( terms:     T, Ts
                      , pattern:   P, .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchAssocComm( terms:     T
                      , pattern:   P, .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      Ts ++Patterns REST
                      ) ++MatchResults
       #matchAssocComm( terms:     Ts
                      , pattern:   P, .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      T, REST
                      )
    requires Ts =/=K .Patterns
     andBool notBool P in Vs
```

Matching a non-atomic pattern against multiple terms: Match the first
atom in the pattern against any of the terms, and then extend those solutions.

```k
  rule #matchAssocComm( terms:     ARGs
                      , pattern:   P_ARG, P_ARGs
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchAssocComm( terms:     ARGs
                      , pattern:   P_ARGs
                      , variables: Vs
                      , results: #matchAssocComm( terms:     ARGs
                                                , pattern:   P_ARG
                                                , variables: Vs
                                                , results:  .MatchResults
                                                , subst:    .Map
                                                , rest:     .Patterns
                                                )
                      , subst:     SUBST
                      , rest:      REST
                      )
    requires ARGs =/=K .Patterns
     andBool P_ARGs =/=K .Patterns
     andBool notBool P_ARG in Vs
```

Base case: If matching a single term against a heap variable, return REST
TODO: if there are multiple heap variables, we need to return all possible partitions.
Currently, the entire REST is constrained to a single heap variable
TODO: other corner cases probably

```k
  rule #matchAssocComm( terms:     Ts
                      , pattern:   (H:Variable, P, Ps)
                                => ((P, Ps) ++Patterns H)
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      .Patterns
                      )
    requires notBool isVariable(P)

  rule #matchAssocComm( terms:     Ts
                      , pattern:   H:Variable, .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      .Patterns
                      )
    => #matchResult( subst: SUBST H |-> sep(Ts)
                   , rest: .Patterns
                   )
     , .MatchResults
    requires H in Vs
```

With each returned result, we apply the substitution and continue matching over
the unmatched part of the term:

```k
  // TODO: don't want to call substUnsafe directly (obviously)
  rule #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   #matchResult(subst: SUBST_INNER, rest: REST_INNER), .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchAssocComm( terms:     REST_INNER
                      , pattern:   substPatternsMap(P, SUBST_INNER)
                      , variables: Vs -Patterns fst(unzip(SUBST_INNER))
                      , results:   .MatchResults
                      , subst:     SUBST_INNER SUBST
                      , rest:      REST
                      )
    requires intersectSet(keys(SUBST_INNER), keys(SUBST)) ==K .Set
```

Failures are propagated:

```k
  rule #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   E:Error, .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
     => E, .MatchResults
```

If the nested call returns a disjunction of solutions, we distribute the disjunction:

```k
  rule #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   MR, MRs
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   MR
                      , subst:     SUBST
                      , rest:      REST
                      ) ++MatchResults
       #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   MRs
                      , subst:     SUBST
                      , rest:      REST
                      )
    requires MRs =/=K .MatchResults
```

```k
endmodule
```


```k
module STRATEGY-MATCHING
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports PROVER-CONFIGURATION
  imports KORE-HELPERS
  imports MATCHING-FUNCTIONAL
```

The `with-each-match` strategy 

```k
  syntax Strategy ::= "with-each-match" "(" MatchResults "," Strategy ")"
  rule <k> with-each-match( MRs, S )
               => with-each-match( MRs, S, fail )
                  ...
       </k>
  syntax Strategy ::= "with-each-match" "(" MatchResults "," Strategy "," Strategy ")"
  rule <k> with-each-match( (MR, MRs), SUCCESS , FAILURE )
               => with-each-match(MR,  SUCCESS, FAILURE)
                | with-each-match(MRs, SUCCESS, FAILURE)
                  ...
       </k>
    requires MRs =/=K .MatchResults

  rule <k> with-each-match( (MR, .MatchResults), SUCCESS, FAILURE )
               => MR ~> SUCCESS
                  ...
       </k>
       
  rule <k> with-each-match( .MatchResults, SUCCESS, FAILURE )
               => FAILURE
                  ...
       </k>
```

Instantiate existentials using matching on the spatial part of goals:

```k
  rule <claim> \implies(\and(LHS) , \exists { Vs } \and(sep(RSPATIAL), RHS)) </claim>
       <k> match
        => with-each-match(#match( terms: \and(getSpatialPatterns(LHS))
                                        , pattern: RSPATIAL
                                        , variables: Vs
                                 )
                          , match
                          )
           ...
       </k>
    requires isSpatialPattern(sep(RSPATIAL))
     andBool getFreeVariables(getSpatialPatterns(sep(RSPATIAL), RHS)) intersect Vs =/=K .Patterns
  rule <claim> \implies(\and(LHS) , \exists { Vs } \and(RHS)) </claim>
       <k> match => noop ... </k>
     requires getFreeVariables(getSpatialPatterns(RHS)) intersect Vs ==K .Patterns
  rule <claim> \implies( \and( LSPATIAL, LHS)
                       ,  \exists { Vs } \and(sep(RSPATIAL), RHS)
                       => \exists { Vs -Patterns fst(unzip(SUBST)) }
                          #flattenAnd(substMap( \and(getSpatialPatterns(RHS) ++Patterns (sep(RSPATIAL), (RHS -Patterns getSpatialPatterns(RHS))))
                                              , SUBST
                                              )
                                     )
                       )
       </claim>
       <k> ( #matchResult(subst: SUBST, rest: .Patterns) ~> match )
        => match
          ...
       </k>

  rule <claim> \implies(LHS, \exists { Vs } \and(RSPATIAL, RHS)) </claim>
       <k> match => fail ... </k>
    requires isPredicatePattern(LHS)
     andBool isSpatialPattern(RSPATIAL)
  rule <claim> \implies(\and(LSPATIAL, LHS), \exists { Vs } RHS) </claim>
       <k> match => fail ... </k>
    requires isPredicatePattern(RHS)
     andBool isSpatialPattern(LSPATIAL)

  rule <k> ( #matchResult(subst: _, rest: REST) ~> match )
               => fail
                  ...
       </k>
     requires REST =/=K .Patterns
```

```k
  syntax Strategy ::= "match-pto" "(" Patterns ")"
  rule <claim> \implies( \and(sep(LSPATIAL), LHS)
                       , \exists { Vs } \and(sep(RSPATIAL), RHS)
                       )
       </claim>
       <k> match-pto => match-pto(getPartiallyInstantiatedPtos(RSPATIAL, Vs)) ... </k>
  rule <k> match-pto(.Patterns)
               => noop
                  ...
       </k>

  rule <claim> \implies( \and(sep(LSPATIAL), LHS:Patterns)
                       , \exists { Vs } \and(sep(RSPATIAL), RHS:Patterns))
       </claim>
       <k> match-pto(P, Ps:Patterns)
               => with-each-match(
                    #match( terms: LSPATIAL:Patterns
                                         , pattern: P
                                         , variables: Vs:Patterns
                                         )
                                 , match-pto
                                 , noop
                                 )
                . match-pto(Ps:Patterns)
                  ...
       </k>
  rule <claim> \implies( _
                       ,  (\exists { Vs } \and( RHS ))
                       => ( \exists { Vs -Patterns fst(unzip(SUBST)) }
                            substMap(\and(RHS), SUBST)
                          )
                       )
       </claim>
       <k> ( #matchResult(subst: SUBST, rest: _) ~> match-pto )
               => noop
                  ...
       </k>

  syntax Patterns ::= getPartiallyInstantiatedPtos(Patterns, Patterns) [function]
  rule getPartiallyInstantiatedPtos((pto(L, R), Ps), Vs)
    => pto(L, R), getPartiallyInstantiatedPtos(Ps, Vs)
    requires notBool L in Vs
     andBool getFreeVariables(R) intersect Vs =/=K .Patterns
  rule getPartiallyInstantiatedPtos((P, Ps), Vs) => getPartiallyInstantiatedPtos(Ps, Vs)
    [owise]
  rule getPartiallyInstantiatedPtos(.Patterns, Vs) => .Patterns
```

Instantiate heap axioms:

```k
    syntax Strategy ::= "instantiate-heap-axiom" "(" Pattern ")"
                      | "instantiate-separation-logic-axioms" "(" Patterns ")"
                      | "pto-is-injective" "(" Patterns ")"
    rule <k> instantiate-separation-logic-axioms
          => instantiate-separation-logic-axioms(gatherHeapAxioms(.Patterns))
             ...
         </k>
         <declaration> axiom _: heap(LOC, DATA) </declaration>

    syntax Patterns ::= gatherHeapAxioms(Patterns) [function]
    rule [[ gatherHeapAxioms(AXs) => gatherHeapAxioms(heap(LOC, DATA), AXs) ]]
         <declaration> axiom _: heap(LOC, DATA) </declaration>
      requires notBool(heap(LOC, DATA) in AXs)
    rule gatherHeapAxioms(AXs) => AXs [owise]

    rule <k> instantiate-separation-logic-axioms(heap(LOC, DATA), AXs)
          => instantiate-separation-logic-axioms(AXs)
           . instantiate-heap-axiom( \forall { !L { LOC }, !D {DATA} }
                                     \implies( \and(sep(pto(!L { LOC }, !D { DATA })))
                                             , \not(\equals(nil(.Patterns), !L { LOC }))
                                             )
                                   )
           . instantiate-heap-axiom( \forall { !L1 { LOC }, !D1 { DATA }, !L2 { LOC }, !D2 { DATA } }
                                     \implies( \and(sep(pto(!L1 { LOC }, !D1 { DATA }), pto(!L2 { LOC }, !D2 { DATA })) )
                                             , \not(\equals( !L1 { LOC }, !L2 { LOC }) )
                                             )
                                   )
             ...
         </k>
    rule <k> instantiate-separation-logic-axioms(.Patterns) => noop ... </k>
```

Instantiate the axiom: `\forall { L, D } (pto L D) -> L != nil

```k
    rule <claim> \implies(\and(LHS), RHS) </claim>
         <k> instantiate-heap-axiom(\forall { Vs }
                                           \implies( \and(sep(AXIOM_LSPATIAL))
                                                   , AXIOM_RHS
                                                   )
                                          ) #as STRAT
                 => ( #match( terms: \and(getSpatialPatterns(LHS))
                            , pattern:  AXIOM_LSPATIAL
                            , variables: Vs
                            )
                   ~> STRAT:Strategy
                    )
                    ...
         </k>
       requires isSpatialPattern(sep(AXIOM_LSPATIAL))

    rule <claim> \implies(\and(LHS), RHS)
              => \implies(\and(substMap(AXIOM_RHS, SUBST), LHS), RHS)
         </claim>
         <k> ( #matchResult( subst: SUBST, rest: _ ) , MRs
                   ~> instantiate-heap-axiom(\forall { Vs }
                                             \implies( _
                                                     , AXIOM_RHS
                                                     )
                                            ) #as STRAT
                    )
                 => ( MRs ~> STRAT:Strategy )
                    ...
         </k>
      requires isPredicatePattern(AXIOM_RHS)

    rule <k> (.MatchResults ~> instantiate-heap-axiom(_)) => noop ... </k>

    syntax Patterns ::= getLocations(Pattern)    [function]
    syntax Patterns ::= getLocationsPs(Patterns) [function]
    rule getLocationsPs(.Patterns) => .Patterns
    rule getLocationsPs(P, Ps) => getLocations(P) ++Patterns getLocationsPs(Ps)
    rule getLocations(V:Variable) => .Patterns
    rule getLocations(pto(X, Y)) => X, .Patterns
    rule getLocations(S:Symbol(_)) => .Patterns
      requires S =/=K pto andBool S =/=K sep
    rule getLocations(\and(Ps)) => getLocationsPs(Ps)
    rule getLocations(sep(Ps)) => getLocationsPs(Ps)
    rule getLocations(\or(Ps)) => getLocationsPs(Ps)
    rule getLocations(P) => .Patterns
      requires isPredicatePattern(P)

    rule <claim> \implies(LHS, RHS) </claim>
         <k> pto-is-injective => pto-is-injective(getLocations(LHS)) ... </k>

    rule <k> pto-is-injective(.Patterns) => noop ... </k>

    // TODO: this should become unification
    rule <claim> \implies(\and(sep(SPATIAL1), sep(SPATIAL2), LHS), RHS) </claim>
         <k> pto-is-injective(L { LOC }, LOCs)
                 => #match( terms:     SPATIAL1
                          , pattern:   pto(L { LOC }, !D1 { DATA })
                          , variables: !D1 { DATA }
                          )
                 ~> #match( terms:     SPATIAL2
                          , pattern:   pto(L { LOC }, !D2 { DATA })
                          , variables: !D2 { DATA }
                          )
                 ~> pto-is-injective(L { LOC }, LOCs)
                    ...
         </k>
         <declaration> axiom _: heap(LOC, DATA) </declaration>

    rule <claim> \implies(\and(LHS)                                                               , RHS)
              => \implies(\and(LHS ++Patterns #destructEquality((D1, .Patterns), (D2, .Patterns))), RHS)
         </claim>
         <k> #matchResult( subst: V1 |-> D1, rest: _ ), .MatchResults
                 ~> #matchResult( subst: V2 |-> D2, rest: _ ), .MatchResults
                 ~> pto-is-injective(L { LOC }, LOCs)
                 => pto-is-injective(LOCs)
                    ...
         </k>

    syntax Patterns ::= #destructEquality(Patterns, Patterns) [function]
    rule #destructEquality(.Patterns, .Patterns) => .Patterns
    rule #destructEquality((P1, Ps1), (P2, Ps2))
      => \equals(P1, P2), #destructEquality(Ps1, Ps2)
      requires S:Symbol(_) :/=K P1
    rule #destructEquality((P1, Ps1), (P2, Ps2))
      => \equals(P1, P2), #destructEquality(Ps1, Ps2)
      requires S:Symbol(_) :/=K P2
    rule #destructEquality((S:Symbol(ARGs1), Ps1), (S:Symbol(ARGs2), Ps2))
      => #destructEquality(ARGs1, ARGs2) ++Patterns #destructEquality(Ps1, Ps2)
      requires isConstructor(S)
    rule #destructEquality((S1:Symbol(ARGs1), Ps1), (S2:Symbol(ARGs2), Ps2))
      => \equals(S1(ARGs1), S2(ARGs2)), #destructEquality(Ps1, Ps2)
      requires S1 =/=K S2 orBool notBool isConstructor(S1)

    rule <claim> \implies(LHS, \exists { Vs } RHS)
         </claim>
         <k> spatial-patterns-equal => noop ... </k>
      requires isPredicatePattern(RHS)

    rule <claim> \implies(               \and(sep(LSPATIAL), LHS)
                         , \exists{ Vs } \and(sep(RSPATIAL), RHS)
                         )
              => \implies(\and(LHS), \exists { Vs } \and(RHS))
         </claim>
         <k>                    spatial-patterns-equal
          => lift-constraints . spatial-patterns-equal
             ...
         </k>
      requires LSPATIAL -Patterns RSPATIAL ==K .Patterns
       andBool RSPATIAL -Patterns LSPATIAL ==K .Patterns

    rule <claim> \implies(               \and(sep(LSPATIAL), LHS)
                         , \exists{ Vs } \and(sep(RSPATIAL), RHS)
                         )
              => \implies(               \and(LHS ++Patterns sep(LSPATIAL))
                         , \exists{ Vs } \and(sep(RSPATIAL), RHS)
                         )
         </claim>
         <k> spatial-patterns-equal ... </k>
      requires LSPATIAL -Patterns RSPATIAL =/=K .Patterns
        orBool RSPATIAL -Patterns LSPATIAL =/=K .Patterns

    rule <claim> \implies(               \and(L, LHS)
                         , \exists{ Vs } \and(sep(RSPATIAL), RHS)
                         )
         </claim>
         <k> spatial-patterns-equal => fail ... </k>
      requires getSpatialPatterns(L) ==K .Patterns

    rule <claim> \implies(\and(LHS), RHS)
              => \implies(\and(LHS -Patterns getSpatialPatterns(LHS)), RHS)
         </claim>
         <k> spatial-patterns-match => noop ... </k>
       requires isPredicatePattern(RHS)
```

### Footprint Analysis

```
    REST -> \exists d, H. H * xi |-> d
    -----------------------------------
         xi |-> _ * REST -> RHS
```

If the left hand side contains a pointer xi |-> _ and a recursive definition, it
is sufficient to prove that the left hand side *without* xi |-> _ implies that
there is a d such that that xi |-> d. If this proof succeeds, then with
instantiate-separation-logic-axioms, we have xi pointing to two different
things, so the LHS becomes unsat.

```k
  syntax Strategy ::= "footprint-analysis" "(" Pattern ")"

  rule <claim> \implies(\and(sep(LSPATIAL), LCONSTRAINT), RHS) </claim>
       <k> footprint-analysis
               => with-each-match( #match( terms:     LSPATIAL
                                         , pattern:   pto(!X:VariableName { LOC }, !Y:VariableName { DATA })
                                         , variables: !X { LOC }, !Y { DATA }
                                         )
                                 , footprint-analysis( pto(!X { LOC }, !Y { DATA }) )
                                 )
                  ...
       </k>
       <declaration> axiom _: heap(LOC, DATA) </declaration>

// TODO: figure out why rule gets stuck when requires clause is uncommented
  rule <claim> \implies(\and(sep(LSPATIAL), LCONSTRAINT), RHS)
            => \implies( \and(sep(REST), LCONSTRAINT),
                         \exists { !D:VariableName { DATA }, !H:VariableName { Heap } }
                           \and(sep(pto(XMATCH, !D:VariableName { DATA }), !H { Heap }))
                       )
       </claim>
       <k> #matchResult( subst: X { LOC }  |-> XMATCH
                                       Y { DATA } |-> YMATCH
                              , rest: REST
                              )
               ~> footprint-analysis( pto(X { LOC }, Y { DATA }) )
               => noop
                  ...
       </k>
//     requires LSPATIAL -Patterns REST ==K pto(XMATCH, YMATCH)
```

### Nullity Analysis

```
    LHS -> \exists d, H. xi |-> d * H      LHS /\ xi =/= nil -> RHS
    ---------------------------------------------------------------
                               LHS -> RHS
```

```k

  syntax Strategy ::= "nullity-analysis" "(" Patterns "," Strategy ")"

  rule <claim> \implies(LHS, RHS) </claim>
       <k> nullity-analysis(S)
        => nullity-analysis(filterVariablesBySort(getFreeVariables(LHS), LOC), S)
           ...
       </k>
       <declaration> axiom _: heap(LOC, DATA) </declaration>

  rule <claim> \implies(LHS, RHS) </claim>
       <k> nullity-analysis(.Patterns, S) => fail ... </k>

  rule <claim> \implies( \and( sep(LSPATIAL), LCONSTRAINT), RHS)
            => \implies( \and( \forall { !D:VariableName { DATA }, !H:VariableName { Heap } }
                               \implies( \and(sep(pto(V, !D:VariableName { DATA }), !H { Heap }))
                                       , \not(\equals( V
                                                     , nil(.Patterns)
                                                     )
                                             )
                                       )
                             , sep(LSPATIAL)
                             , LCONSTRAINT
                             )
                       , RHS
                       )
       </claim>
       <k> nullity-analysis((V, Vs), S)
        => kt-solve-implications(S)
         | nullity-analysis(Vs, S)
           ...
       </k>
       <declaration> axiom _: heap(LOC, DATA) </declaration>
```

```k
    rule <claim> \implies( \and(sep( LSPATIAL ) , _ )
                         , \exists {_}
                           \and(sep( RSPATIAL ) , _ )
                         )
         </claim>
         <k> frame => frame(LSPATIAL intersect RSPATIAL) ... </k>
```

```k
    syntax Strategy ::= "frame" "(" Patterns ")"
    rule <claim> \implies( LHS
                         , \exists { .Patterns }
                           \and( sep(_),  RCONSTRAINTs )
                         )
         </claim>
         <k> frame(pto(LOC, VAL), Ps)
                 => subgoal( \implies( LHS
                                     , \and(filterClausesInvolvingVariable(LOC, RCONSTRAINTs))
                                     )
                           , normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                           . ( noop | left-unfold-Nth(0) | left-unfold-Nth(1) | left-unfold-Nth(2) )
                           . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                           . instantiate-separation-logic-axioms . spatial-patterns-match . (smt-cvc4)
                           )
                 ~> frame(pto(LOC, VAL))
                 ~> frame(Ps)
                    ...
         </k>

    rule <claim> \implies( \and( sep(LSPATIAL => (LSPATIAL -Patterns P)) , LCONSTRAINTs )
                         , \exists { .Patterns }
                           \and( (sep(RSPATIAL => RSPATIAL -Patterns P)) , (RCONSTRAINTs => RCONSTRAINTs -Patterns filterClausesInvolvingVariable(LOC, RCONSTRAINTs)) )
                         )
         </claim>
         <k> success
                 ~> frame((pto(LOC, VAL) #as P), .Patterns)
                 => .K
                    ...
         </k>
      requires P in LSPATIAL
       andBool P in RSPATIAL

    rule <claim> \implies( \and( sep(LSPATIAL => (LSPATIAL -Patterns P)) , LCONSTRAINTs )
                         , \exists { .Patterns }
                           \and( (sep(RSPATIAL => RSPATIAL -Patterns P)) , RCONSTRAINTs )
                         )
         </claim>
         <k> frame((S:Symbol(_) #as P), Ps)  => frame(Ps)
                    ...
         </k>
      requires notBool S ==K pto

    rule <k> frame(.Patterns) => noop ... </k>

    syntax Patterns ::= filterClausesInvolvingVariable(Variable, Patterns) [function]
    rule filterClausesInvolvingVariable(V, (P, Ps))
      => P, filterClausesInvolvingVariable(V, Ps)
      requires V in getFreeVariables(P)
    rule filterClausesInvolvingVariable(V, (P, Ps))
      => filterClausesInvolvingVariable(V, Ps)
      requires notBool V in getFreeVariables(P)
    rule filterClausesInvolvingVariable(_, .Patterns)
      => .Patterns

    syntax Strategy ::= "subsume-spatial"
    rule <claim> \implies( \and( sep(LSPATIAL:Patterns) , LCONSTRAINTs:Patterns)
                        => \and(                 LCONSTRAINTs:Patterns)
                         , \exists { Vs:Patterns }
                           \and( RHS:Patterns )
                         )
         </claim>
         <k> subsume-spatial => noop
                    ...
         </k>
      requires isPredicatePattern(\and(RHS))
```

```k
endmodule
```

