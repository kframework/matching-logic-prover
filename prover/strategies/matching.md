```k
module MATCHING-FUNCTIONAL
  imports MAP
  imports KORE-HELPERS

  syntax MatchResult ::= "#matchResult" "(" "subst:" Map "," "rest:" Patterns ")" [format(%1%2%i%n%3%i%n%4%d%n%5%i%6%n%7%d%d%8)]
                       | MatchFailure
                       | "#matchResult" "(" "subst:" Map ")"
  syntax MatchFailure ::= "#matchFailure" "(" String ")"
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

  rule #match( terms: T, pattern: P, variables: Vs )
    => #filterMatchFailures( #matchAssocComm( terms: T
                                            , pattern: P
                                            , variables: Vs
                                            , results: .MatchResults
                                            , subst: .Map
                                            , rest: .Patterns
                                            )
                           )

  syntax MatchResults ::= #filterMatchFailures(MatchResults) [function]
  rule #filterMatchFailures(MF:MatchFailure , MRs) => #filterMatchFailures(MRs)
  rule #filterMatchFailures(MF              , MRs) => MF , #filterMatchFailures(MRs)
    requires notBool isMatchFailure(MF)
  rule #filterMatchFailures(.MatchResults) => .MatchResults
```

Work around OCaml not producing reasonable error messages:

```k
  syntax MatchFailure ::= "#matchStuck" "(" K ")"
  syntax KItem ::= "\\n" [format(%n)]
  rule #matchAssocComm(terms: T
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
    => #matchFailure("Mismatch in length of arguments"), .MatchResults
    requires (Ts ==K .Patterns orBool Ps ==K .Patterns)
     andBool notBool (Ts ==K .Patterns andBool Ps ==K .Patterns)

  // Non-matching constructors
  rule #matchAssoc( terms:     S1:Symbol(_), Ts
                  , pattern:   S2:Symbol(_), Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #matchFailure("Constructors do not match"), .MatchResults
    requires S1 =/=K S2

  // Non-matching constructors
  rule #matchAssoc( terms:     T, Ts
                  , pattern:   S:Symbol(_), Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #matchFailure("Constructors do not match"), .MatchResults
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

  // ground variable: mismatched
  rule #matchAssoc( terms:     T, Ts
                  , pattern:   P:Variable, Ps
                  , variables: Vs
                  , subst:     SUBST
                  , rest:      REST
                  )
    => #matchFailure("Variable does not match"), .MatchResults
    requires T =/=K P
     andBool notBool P in Vs

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
    => #matchFailure( "No valid substitution" ), .MatchResults
    requires T =/=K P
     andBool notBool P in Vs
     
  // free variable: different sorts
  rule #matchAssoc( terms:     T         , Ts
                  , pattern:   P:Variable, Ps
                  , variables: Vs
                  , subst:     _
                  , rest:      REST
                  )
    => #matchFailure("Variable sort does not match term"), .MatchResults
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
    => #matchFailure( "Pattern larger than term" ), .MatchResults

// Base case: emp matches all heaps
  rule #matchAssocComm( terms:     Ts
                      , pattern:   .Patterns
                      , variables: Vs
                      , results:   .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
    => #matchResult(subst: SUBST, rest: REST ++Patterns Ts), .MatchResults

// Base case: If matching a single term, agains an atomic pattern, use Assoc Matching
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
```

With each returned result, we apply the substitution and continue matching over
the unmatched part of the term:

```k
  // TODO: don't want to call substUnsafe directly (obviously)
  rule #matchAssocComm( terms:     Ts => REST
                      , pattern:   P  => substPatternsMap(P, SUBST1)
                      , variables: Vs => Vs -Patterns fst(unzip(SUBST1))
                      , results:   #matchResult(subst: SUBST1, rest: REST), .MatchResults
                                => .MatchResults
                      , subst:     SUBST2
                                => (SUBST1 SUBST2)
                      , rest:      _
                      )
    requires intersectSet(keys(SUBST1), keys(SUBST2)) ==K .Set
```

Failures are propagated:

```k
  rule #matchAssocComm( terms:     Ts
                      , pattern:   P
                      , variables: Vs
                      , results:   MF:MatchFailure, .MatchResults
                      , subst:     SUBST
                      , rest:      REST
                      )
     => MF, .MatchResults
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
  rule <strategy> with-each-match( MRs, S )
               => with-each-match( MRs, S, fail )
                  ...
       </strategy>
  syntax Strategy ::= "with-each-match" "(" MatchResults "," Strategy "," Strategy ")"
  rule <strategy> with-each-match( (MR, MRs), SUCCESS , FAILURE )
               => with-each-match(MR,  SUCCESS, FAILURE)
                | with-each-match(MRs, SUCCESS, FAILURE)
                  ...
       </strategy>
    requires MRs =/=K .MatchResults

  rule <strategy> with-each-match( (MR, .MatchResults), SUCCESS, FAILURE )
               => MR ~> SUCCESS
                  ...
       </strategy>
       
  rule <strategy> with-each-match( .MatchResults, SUCCESS, FAILURE )
               => FAILURE
                  ...
       </strategy>
```

Instantiate existentials using matching on the spatial part of goals:

```k
  rule <claim> \implies(\and(sep(LSPATIAL), LHS) , \exists { Vs } \and(sep(RSPATIAL), RHS)) </claim>
       <strategy> match
               => with-each-match(#match( terms: LSPATIAL
                                        , pattern: RSPATIAL
                                        , variables: Vs
                                        )
                                 , match
                                 )
                  ...
       </strategy>
    requires isSpatialPattern(sep(LSPATIAL))
     andBool isSpatialPattern(sep(RSPATIAL))
  rule <claim> \implies( \and( LSPATIAL, LHS)
                       ,  \exists { Vs } \and( RHS )
                       => \exists { Vs -Patterns fst(unzip(SUBST)) } substMap(\and(RHS), SUBST)
                       )
       </claim>
       <strategy> ( #matchResult(subst: SUBST, rest: .Patterns) ~> match )
               => noop
                  ...
       </strategy>

  rule <claim> \implies(LHS, \exists { Vs } \and(RSPATIAL, RHS)) </claim>
       <strategy> match => fail ... </strategy>
    requires isPredicatePattern(LHS)
     andBool isSpatialPattern(RSPATIAL)
  rule <claim> \implies(\and(LSPATIAL, LHS), \exists { Vs } RHS) </claim>
       <strategy> match => fail ... </strategy>
    requires isPredicatePattern(RHS)
     andBool isSpatialPattern(LSPATIAL)

  rule <strategy> ( #matchResult(subst: _, rest: REST) ~> match )
               => fail
                  ...
       </strategy>
     requires REST =/=K .Patterns
```

```k
  syntax Strategy ::= "match-pto" "(" Patterns ")"
  rule <claim> \implies( \and(sep(LSPATIAL), LHS)
                       , \exists { Vs } \and(sep(RSPATIAL), RHS)
                       )
       </claim>
       <strategy> match-pto => match-pto(getPartiallyInstantiatedPtos(RSPATIAL, Vs)) ... </strategy>
  rule <strategy> match-pto(.Patterns)
               => noop
                  ...
       </strategy>

  rule <claim> \implies( \and(sep(LSPATIAL), LHS:Patterns)
                       , \exists { Vs } \and(sep(RSPATIAL), RHS:Patterns))
       </claim>
       <strategy> match-pto(P, Ps:Patterns)
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
       </strategy>
  rule <claim> \implies( _
                       ,  (\exists { Vs } \and( RHS ))
                       => ( \exists { Vs -Patterns fst(unzip(SUBST)) }
                            substMap(\and(RHS), SUBST)
                          )
                       )
       </claim>
       <strategy> ( #matchResult(subst: SUBST, rest: _) ~> match-pto )
               => noop
                  ...
       </strategy>

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
    syntax Strategy ::= "instantiate-axiom" "(" Pattern ")"
                      | "instantiate-separation-logic-axioms" "(" Patterns ")"
    rule <strategy> instantiate-separation-logic-axioms
                 => instantiate-separation-logic-axioms(gatherHeapAxioms(.Patterns))
                    ...
         </strategy>
         <declaration> axiom _: heap(LOC, DATA) </declaration>

    syntax Patterns ::= gatherHeapAxioms(Patterns) [function]
    rule [[ gatherHeapAxioms(AXs) => gatherHeapAxioms(heap(LOC, DATA), AXs) ]]
         <declaration> axiom _: heap(LOC, DATA) </declaration>
      requires notBool(heap(LOC, DATA) in AXs)
    rule gatherHeapAxioms(AXs) => AXs [owise]

    rule <strategy> instantiate-separation-logic-axioms(heap(LOC, DATA), AXs)
                 => instantiate-separation-logic-axioms(AXs)
                  . instantiate-axiom( \forall { !L { LOC }, !D {DATA} }
                                       \implies( \and(sep(pto(!L { LOC }, !D { DATA })))
                                               , \not(\equals( parameterizedSymbol(nil, LOC)(.Patterns), !L { LOC }))
                                               )
                                     )
                  . instantiate-axiom( \forall { !L1 { LOC }, !D1 {DATA}, !L2 { LOC }, !D2 { DATA } }
                                       \implies( \and(sep(pto(!L1 { LOC }, !D1 { DATA }), pto(!L2 { LOC }, !D2 { DATA })) )
                                               , \not(\equals( !L1 { LOC }, !L2 { LOC }) )
                                               )
                                     )
                    ...
         </strategy>
    rule <strategy> instantiate-separation-logic-axioms(.Patterns) => noop ... </strategy>
```

Instantiate the axiom: `\forall { L, D } (pto L D) -> L != nil

```k
    rule <claim> \implies(\and((sep(LSPATIAL)), LCONSTRAINT), RHS) </claim>
         <strategy> instantiate-axiom(\forall { Vs }
                                      \implies( \and(sep(AXIOM_LSPATIAL))
                                              , AXIOM_RHS
                                              )
                                     ) #as STRAT
                 => ( #match( terms: LSPATIAL
                            , pattern:  AXIOM_LSPATIAL
                            , variables: Vs
                            )
                   ~> STRAT:Strategy
                    )
                    ...
         </strategy>
       requires isSpatialPattern(sep(AXIOM_LSPATIAL))

    rule <claim> \implies(\and((sep(_) #as LSPATIAL), (LCONSTRAINT => substMap(AXIOM_RHS, SUBST), LCONSTRAINT))
                         , RHS
                         )
         </claim>
         <strategy> ( #matchResult( subst: SUBST, rest: _ ) , MRs
                   ~> instantiate-axiom(\forall { Vs }
                                        \implies( _
                                                , AXIOM_RHS
                                                )
                                       ) #as STRAT
                    )
                 => ( MRs ~> STRAT:Strategy )
                    ...
         </strategy>
      requires isPredicatePattern(AXIOM_RHS)

    rule <strategy> (.MatchResults ~> instantiate-axiom(_)) => noop ... </strategy>

    rule <claim> \implies(               \and(sep(LSPATIAL), LCONSTRAINT)
                         , \exists{ Vs } \and(sep(RSPATIAL), RCONSTRAINT)
                         )
              => \implies(\and(LCONSTRAINT), \exists { Vs } \and(RCONSTRAINT))
         </claim>
         <strategy> spatial-patterns-equal => noop ... </strategy>
      requires LSPATIAL -Patterns RSPATIAL ==K .Patterns
       andBool RSPATIAL -Patterns LSPATIAL ==K .Patterns

    rule <claim> \implies(               \and(sep(LSPATIAL), _)
                         , \exists{ Vs } \and(sep(RSPATIAL), _)
                         )
         </claim>
         <strategy> spatial-patterns-equal => fail ... </strategy>
      requires LSPATIAL -Patterns RSPATIAL =/=K .Patterns
        orBool RSPATIAL -Patterns LSPATIAL =/=K .Patterns
```

```k
    rule <claim> \implies( \and(sep( LSPATIAL ) , _ )
                         , \exists {_}
                           \and(sep( RSPATIAL ) , _ )
                         )
         </claim>
         <strategy> frame => frame(LSPATIAL intersect RSPATIAL) ... </strategy>
```

```k
    syntax Strategy ::= "frame" "(" Patterns ")"
    rule <claim> \implies( LHS
                         , \exists { .Patterns }
                           \and( sep(_),  RCONSTRAINTs )
                         )
         </claim>
         <strategy> frame(pto(LOC, VAL), Ps)
                 => subgoal( \implies( LHS
                                     , \and(filterClausesInvolvingVariable(LOC, RCONSTRAINTs))
                                     )
                           , normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                           . ( noop | left-unfold-Nth(0) | left-unfold-Nth(1) | left-unfold-Nth(2) )
                           . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                           . instantiate-separation-logic-axioms . subsume-spatial . (smt-cvc4)
                           )
                 ~> frame(pto(LOC, VAL))
                 ~> frame(Ps)
                    ...
         </strategy>

    rule <claim> \implies( \and( sep(LSPATIAL => (LSPATIAL -Patterns P)) , LCONSTRAINTs )
                         , \exists { .Patterns }
                           \and( (sep(RSPATIAL => RSPATIAL -Patterns P)) , (RCONSTRAINTs => RCONSTRAINTs -Patterns filterClausesInvolvingVariable(LOC, RCONSTRAINTs)) )
                         )
         </claim>
         <strategy> success
                 ~> frame((pto(LOC, VAL) #as P), .Patterns)
                 => .K
                    ...
         </strategy>
      requires P in LSPATIAL
       andBool P in RSPATIAL

    rule <claim> \implies( \and( sep(LSPATIAL => (LSPATIAL -Patterns P)) , LCONSTRAINTs )
                         , \exists { .Patterns }
                           \and( (sep(RSPATIAL => RSPATIAL -Patterns P)) , RCONSTRAINTs )
                         )
         </claim>
         <strategy> frame((S:Symbol(_) #as P), Ps)  => frame(Ps)
                    ...
         </strategy>
      requires notBool S ==K pto

    rule <strategy> frame(.Patterns) => noop ... </strategy>

    syntax Patterns ::= filterPredicates(Patterns) [function]
    rule filterPredicates(P, Ps) => P, filterPredicates(Ps)
      requires isPredicatePattern(P)
    rule filterPredicates(P, Ps) => filterPredicates(Ps)
      requires notBool isPredicatePattern(P)
    rule filterPredicates(.Patterns) => .Patterns

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
         <strategy> subsume-spatial => noop
                    ...
         </strategy>
      requires isPredicatePattern(\and(RHS))
```

```k
endmodule
```

