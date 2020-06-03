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
    syntax Strategy ::= "instantiate-axiom" "(" Pattern ")"
                      | "instantiate-separation-logic-axioms" "(" Patterns ")"
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
         </k>
    rule <k> instantiate-separation-logic-axioms(.Patterns) => noop ... </k>
```

Instantiate the axiom: `\forall { L, D } (pto L D) -> L != nil

```k
    rule <claim> \implies(\and((sep(LSPATIAL)), LCONSTRAINT), RHS) </claim>
         <k> instantiate-axiom(\forall { Vs }
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
         </k>
       requires isSpatialPattern(sep(AXIOM_LSPATIAL))

    rule <claim> \implies(\and((sep(_) #as LSPATIAL), (LCONSTRAINT => substMap(AXIOM_RHS, SUBST), LCONSTRAINT))
                         , RHS
                         )
         </claim>
         <k> ( #matchResult( subst: SUBST, rest: _ ) , MRs
                   ~> instantiate-axiom(\forall { Vs }
                                        \implies( _
                                                , AXIOM_RHS
                                                )
                                       ) #as STRAT
                    )
                 => ( MRs ~> STRAT:Strategy )
                    ...
         </k>
      requires isPredicatePattern(AXIOM_RHS)

    rule <k> (.MatchResults ~> instantiate-axiom(_)) => noop ... </k>

    rule <claim> \implies(               \and(sep(LSPATIAL), LCONSTRAINT)
                         , \exists{ Vs } \and(sep(RSPATIAL), RCONSTRAINT)
                         )
              => \implies(\and(LCONSTRAINT), \exists { Vs } \and(RCONSTRAINT))
         </claim>
         <k> spatial-patterns-equal => noop ... </k>
      requires LSPATIAL -Patterns RSPATIAL ==K .Patterns
       andBool RSPATIAL -Patterns LSPATIAL ==K .Patterns

    rule <claim> \implies(               \and(sep(LSPATIAL), _)
                         , \exists{ Vs } \and(sep(RSPATIAL), _)
                         )
         </claim>
         <k> spatial-patterns-equal => fail ... </k>
      requires LSPATIAL -Patterns RSPATIAL =/=K .Patterns
        orBool RSPATIAL -Patterns LSPATIAL =/=K .Patterns
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
                           . instantiate-separation-logic-axioms . subsume-spatial . (smt-cvc4)
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

