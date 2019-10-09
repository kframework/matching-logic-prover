```k
module STRATEGY-MATCHING
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports PROVER-CONFIGURATION
  imports KORE-HELPERS
  imports MAP
```

Instantiate existentials using matching on the spatial part of goals:

```k
  rule <claim> \implies(\and(LSPATIAL, LHS) , \exists { Vs } \and(RSPATIAL, RHS)) </claim>
       <strategy> match => #match( term: LSPATIAL
                                 , pattern: RSPATIAL
                                 , variables: Vs
                                 )
                        ~> match
                  ...
       </strategy>
    requires isSpatialPattern(LSPATIAL)
     andBool isSpatialPattern(RSPATIAL)
  rule <claim> \implies( \and( LSPATIAL, LHS)
                       ,  \exists { Vs } \and( RHS )
                       => \exists { Vs -Patterns fst(unzip(SUBST)) } substMap(\and(RHS), SUBST)
                       )
       </claim>
       <strategy> ( #matchResult( subst: SUBST
                                , rest:  .Patterns
                                )
                  ; .MatchResults
                 ~> match
                  )
               => noop
                  ...
       </strategy>
```

Instantiate heap axioms:

```k
    syntax Strategy ::= "instantiate-axiom" "(" Pattern ")"
    rule <strategy> instantiate-separation-logic-axioms
                 => instantiate-axiom( \forall { !L { LOC }, !D {DATA} }
                                       \implies( \and(sep(pto(!L { LOC }, !D { DATA })))
                                               , \not(\equals( nil(.Patterns), !L { LOC }))
                                               )
                                     )
                    ...
         </strategy>
         <declaration> axiom heap(LOC, DATA) </declaration>
```

Instantiate the axiom: `\forall { L, D } (pto L D) -> L != nil 

```k
    rule <claim> \implies(\and((sep(_) #as LSPATIAL), LCONSTRAINT), RHS) </claim>
         <strategy> instantiate-axiom(\forall { Vs }
                                      \implies( \and((sep(_) #as AXIOM_LHS))
                                              , AXIOM_RHS
                                              )
                                     ) #as STRAT
                 => ( #match( term: LSPATIAL
                            , pattern:  sep(.Patterns) // AXIOM_LHS
                            , variables: Vs
                            )
                   ~> STRAT:Strategy
                    )
                    ...
         </strategy>
//       requires isSpatialPattern(AXIOM_LHS)

//    rule <claim> \implies(\and((sep(_) #as LSPATIAL), LCONSTRAINT)
//                         , RHS
//                         )
//         </claim>
//         <strategy> ( #matchResult( subst: SUBST, rest: _ ) ; MRs
//                   ~> instantiate-pto-not-nil
//                    )
//                 => ( MRs
//                   ~> instantiate-pto-not-nil
//                    )
//                    ...
//         </strategy>
```

```k
                                         /* Subst, Rest */
  syntax MatchResult ::= "#matchResult" "(" "subst:" Map "," "rest:" Patterns ")" [format(%1%2%i%n%3%i%n%4%d%n%5%i%6%n%7%d%d%8)]
                       | MatchFailure
                       | "#matchResult" "(" "subst:" Map ")"
  syntax MatchFailure ::= "#matchFailure" "(" String ")"
  syntax MatchResults ::= List{MatchResult, ";"} [klabel(MatchResults), format(%1%n%2 %3)]

  syntax MatchResults ::= "#match" "(" "term:"      Pattern
                                   "," "pattern:"   Pattern
                                   "," "variables:" Patterns
                                   ")" [function]
  syntax MatchResults ::= "#matchShowFailures" "(" "term:"      Pattern
                                               "," "pattern:"   Pattern
                                               "," "variables:" Patterns
                                               ")" [function]
  syntax MatchResults ::= "#matchAux" "(" "terms:"     Patterns
                                      "," "pattern:"   Pattern
                                      "," "variables:" Patterns
                                      "," "results:"   MatchResults
                                      "," "subst:"     Map
                                      ")" [function]

  syntax MatchResults ::= MatchResults "++MatchResults" MatchResults [function, right]
  rule (MR1; MR1s) ++MatchResults MR2s => MR1; (MR1s ++MatchResults MR2s)
  rule .MatchResults ++MatchResults MR2s => MR2s

  syntax MatchResults ::= #getMatchResults(Pattern, Pattern, MatchResults) [function]
  rule #getMatchResults(T, P, MF:MatchFailure; MRs)
    => MF
     ; #getMatchResults(T, P, MRs)
  rule #getMatchResults(T, P, (#matchResult(subst: _, rest: _) #as MR); MRs)
    => MR
     ; #getMatchResults(T, P, MRs)
  rule #getMatchResults(T, P, .MatchResults) => .MatchResults
  rule #getMatchResults(S(ARGs), S(P_ARGs), #matchResult(subst: SUBST); MRs)
    => #matchResult(subst: SUBST, rest: .Patterns)
     ; #getMatchResults(S(ARGs), S(P_ARGs), MRs)
    requires S =/=K sep
  rule #getMatchResults(sep(ARGs), sep(P_ARGs), #matchResult(subst: SUBST); MRs)
    => #matchResult(subst: SUBST, rest: ARGs -Patterns substPatternsMap(P_ARGs, SUBST))
     ; #getMatchResults(sep(ARGs), sep(P_ARGs), MRs)

  rule #matchShowFailures( term: T , pattern: P, variables: Vs )
    => #getMatchResults( T, P, #matchAux( terms: T , pattern: P, variables: Vs, results: .MatchResults, subst: .Map ) )
    requires getFreeVariables(T) intersect Vs ==K .Patterns
  rule #matchShowFailures( term: T, pattern: _, variables: Vs )
    => #matchFailure( "AlphaRenaming not done" ); .MatchResults
    requires getFreeVariables(T) intersect Vs =/=K .Patterns
    
    
  rule #match( term: T, pattern: P, variables: Vs )
    => #filterMatchFailures(#matchShowFailures( term: T, pattern: P, variables: Vs ))
    
  syntax MatchResults ::= #filterMatchFailures(MatchResults) [function]
  rule #filterMatchFailures(MF:MatchFailure ; MRs) => #filterMatchFailures(MRs)
  rule #filterMatchFailures(MF              ; MRs) => MF ; #filterMatchFailures(MRs)
    requires notBool isMatchFailure(MF)
  rule #filterMatchFailures(.MatchResults) => .MatchResults
```

Work around OCaml not producing reasonable error messages:

```k
  syntax MatchFailure ::= "#matchStuck" "(" K ")"
  syntax KItem ::= "\\n" [format(%n)] 
  rule #matchAux( terms: Ts , pattern: P, variables: Vs, results: MRs, subst: SUBST )
    => #matchStuck( "AUX" ~> \n ~> "terms:" ~> Ts
                          ~> \n ~> "pattern:" ~> P
                          ~> \n ~> "vars:" ~> Vs
                          ~> \n ~> "results:" ~> MRs
                          ~> \n ~> "subst:" ~> SUBST
                  )
     ; .MatchResults
    [owise]
  rule #getMatchResults(T, P, MRs)
    => #matchStuck( "GET RESULTS" ~> "term:" ~> T ~> "pattern:" ~> P ~> "MRs:" ~> MRs )
     ; .MatchResults
    [owise]
```

Recurse over assoc-only constructors (including `pto`):

```k
  // Non-matching constructors
  rule #matchAux( terms:     S1:Symbol(_) , .Patterns
                , pattern:   S2:Symbol(_)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST
                )
    => #matchFailure("Constructors do not match"); .MatchResults     
    requires S1 =/=K S2
     andBool S1 =/=K sep

  // Empty application
  rule #matchAux( terms:     S:Symbol(.Patterns) , .Patterns
                , pattern:   S:Symbol(.Patterns)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST
                )
    => #matchResult(subst: SUBST); .MatchResults
    requires S =/=K sep
    
  // Application, can susbstitute
  rule #matchAux( terms:     S:Symbol(ARG, ARGs), .Patterns
                          => S(ARGs), .Patterns
                , pattern:   S:Symbol(P_ARG:Variable, P_ARGs)
                          => S(P_ARGs)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST => (P_ARG |-> ARG) SUBST
                )
    requires S =/=K sep
     andBool P_ARG in Vs
     
  // Application, ground: don't need substitution
  rule #matchAux( terms:     S:Symbol(ARG, ARGs) , .Patterns
                          => S:Symbol(ARGs:Patterns) , .Patterns
                , pattern:   S:Symbol(ARG:Variable, P_ARGs:Patterns)
                          => S:Symbol(P_ARGs)
                , variables: Vs
                , results:   .MatchResults
                , subst:     _
                )
    requires S =/=K sep
     andBool notBool ARG in Vs

  // Application, ground: cannot substitute variable
  rule #matchAux( terms:     S:Symbol(ARG, _:Patterns) , .Patterns
                , pattern:   S:Symbol(P_ARG:Variable, _:Patterns)
                , variables: Vs
                , results:   .MatchResults
                , subst:     _
                )
    => #matchFailure( "No valid substitution" ); .MatchResults
    requires S =/=K sep
     andBool ARG =/=K P_ARG
     andBool notBool P_ARG in Vs

  // Application, nested: recurse
  rule #matchAux( terms:   ( S:Symbol((S1:Symbol(_) #as ARG), ARGs) , .Patterns
                          => S:Symbol(ARGs) , .Patterns
                           )
                , pattern: ( S:Symbol((S1:Symbol(_) #as P_ARG), P_ARGs)
                          => S:Symbol(P_ARGs)
                           )
                , variables: Vs
                , results:   .MatchResults 
                          => #matchAux( terms:   ARG, .Patterns
                                      , pattern: P_ARG
                                      , variables: Vs
                                      , results: .MatchResults
                                      , subst: SUBST
                                      )
                , subst:     SUBST
                )
    requires S =/=K sep
```

Recurse over assoc-comm `sep`:

```k
  // Base case: emp matches all heaps
  rule #matchAux( terms:     sep(ARGs), .Patterns
                , pattern:   sep(.Patterns)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST
                )
    => #matchResult(subst: SUBST); .MatchResults

  // Base case: If pattern is larger than term, there can be no match 
  rule #matchAux( terms:     sep(.Patterns), .Patterns
                , pattern:   sep(P, Ps)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST
                )
    => #matchFailure( "Pattern larger than term" ); .MatchResults

  // Recursive case: AC match on arguments
  rule #matchAux( terms:     sep(ARGs), .Patterns
                , pattern:   sep(P_ARG, P_ARGs)
                , variables: Vs
                , results:   .MatchResults
                , subst:     SUBST
                )
    => #matchAux( terms:     sep(ARGs)
                , pattern:   sep(P_ARGs)
                , variables: Vs
                , results:   #matchAux( terms:     ARGs
                                      , pattern:   P_ARG
                                      , variables: Vs
                                      , results:  .MatchResults
                                      , subst:    SUBST
                                      )
                , subst:     SUBST
                )
    requires ARGs =/=K .Patterns
```

Distribute results for nested matching over current call:

```k
  // Base case: Apply substitution from nested term
  // TODO: don't want to call substUnsafe directly (obviously)
  rule #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   #matchResult(subst: SUBST1); .MatchResults
                , subst:     SUBST2
                )
    => #matchAux( terms:     Ts
                , pattern:   substUnsafe(P, SUBST1)
                , variables: Vs -Patterns fst(unzip(SUBST1))
                , results:   .MatchResults
                , subst:     SUBST1 SUBST2
                )

  rule #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   (#matchFailure(_) #as MF); .MatchResults
                , subst:     SUBST2
                )
    => MF; .MatchResults

  // Recursive case
  rule #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   MR; MRs
                , subst:     SUBST
                )
    => #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   MR
                , subst:     SUBST
                ) ++MatchResults
       #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   MRs
                , subst:     SUBST
                )
    requires MRs =/=K .MatchResults
```

Recurse over terms. This implements commutative matching:

```k
  rule #matchAux( terms:     T, Ts
                , pattern:   P
                , variables: Vs
                , results:   RESULTS
                , subst:     SUBST
                )
    => #matchAux( terms:     T
                , pattern:   P
                , variables: Vs
                , results:   RESULTS
                , subst:     SUBST
                ) ++MatchResults
       #matchAux( terms:     Ts
                , pattern:   P
                , variables: Vs
                , results:   RESULTS
                , subst:     SUBST
                )
    requires Ts =/=K .Patterns
endmodule

module TEST-MATCHING-SYNTAX
    imports BASIC-K
    imports TOKENS-SYNTAX
    imports TEST-MATCHING
    imports PROVER-SYNTAX

    syntax KItem ::= Pattern // TODO: Explain why we're doing this
    syntax VariableName ::= "W" [token] | "X" [token] | "Y" [token] | "Z" [token]
                          | "W1" [token]
                          | "W2" [token]
                          | "X1" [token]
                          | "X2" [token]
                          | "Y1" [token]
                          | "Y2" [token]
                          | "Z1" [token]
                          | "Z2" [token]
                          | "Vx" [token]
                          | "Vy" [token]
                          | "Vz" [token]
                          | "F8" [token]
    syntax Sort         ::= "Data" [token] | "Loc" [token] | "RefGTyp" [token]
endmodule

module TEST-MATCHING
  imports STRATEGY-MATCHING
  imports PROVER-DRIVER

  syntax Sort         ::= "Data" | "Loc"
  syntax Declaration ::= "assert" "(" MatchResults "==" MatchResults ")" [format(%1%2%i%i%n%3%d%n%4%i%n%5%d%d%6%n)]
  rule assert(EXPECTED == EXPECTED) => .K
endmodule
```

