```k
module STRATEGY-KNASTER-TARSKI
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
  imports PREDICATE-DEFINITIONS
```

### Knaster Tarski (Least Fixed Point)

This high-level implementation of the Knaster Tarski rule attempts the applying
the rule to each recursive predicate in turn. It also includes a heuristic
for guessing an instantiation of the inductive hypothesis.

```k
  rule <strategy> kt => kt # .KTFilter # useAffectedHeuristic ... </strategy>
  rule <k> GOAL </k>
       <strategy> kt # FILTER # INSTANTIATION
               => getLeftRecursivePredicates(GOAL) ~> kt # FILTER # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # head(HEAD) # INSTANTIATION
               => filterByConstructor(LRPs, HEAD) ~> kt # .KTFilter # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # index(I:Int) # INSTANTIATION
               => getMember(I, LRPs), .Patterns ~> kt # .KTFilter # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # .KTFilter # INSTANTIATION
               => ktForEachLRP(LRPs, INSTANTIATION)
                  ...
       </strategy>
```

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:

```k
  syntax Strategy ::= ktForEachLRP(Patterns, KTInstantiate)
  rule <strategy> ktForEachLRP(.Patterns, INSTANTIATION) => fail ... </strategy>
  rule <strategy> ktForEachLRP((LRP, LRPs), INSTANTIATION)
               => ( kt-wrap(LRP) ; kt-forall-intro ; kt-unfold
                  ; lift-or ; and-split ; remove-lhs-existential
                  ; #hole
                  )
                  | ktForEachLRP(LRPs, INSTANTIATION)
                  ...
       </strategy>
```

```k
  syntax Variable ::= "#hole"
  syntax Pattern ::= implicationContext(Pattern, Pattern) [klabel(implicationContext)]
  rule getFreeVariables(#hole, .Patterns) => .Patterns
  rule getFreeVariables(implicationContext(CONTEXT, P), .Patterns)
    => getFreeVariables(CONTEXT, .Patterns) ++Patterns getFreeVariables(P, .Patterns)
```

```k
  syntax Strategy ::= "kt-wrap" "(" Pattern ")"
  rule <k> \implies(LHS:Pattern, RHS)
        => \implies(LRP, implicationContext(LHS[LRP/#hole], RHS))
       </k>
       <strategy> kt-wrap(LRP) => noop ... </strategy>
       <trace> .K => kt-wrap(LRP)  ... </trace>
```

```k
  syntax Strategy ::= "kt-forall-intro"
  rule <k> \implies(LHS, RHS) #as GOAL
        => \implies( LHS
                   , \forall { getUniversalVariables(GOAL) -Patterns getFreeVariables(LHS, .Patterns) }
                             RHS
                   )
       </k>
       <strategy> kt-forall-intro => noop ... </strategy>
```

```k
  syntax Strategy ::= "kt-unfold"
  rule <k> \implies( LRP:RecursivePredicate(ARGS) #as LHS
                =>   substituteBRPs(unfold(LHS), LRP, ARGS, RHS)
                   , RHS
                   )
       </k> 
       <strategy> kt-unfold => noop ... </strategy>

                             // unfolded fixed point, HEAD, LRP variables, Pattern
  syntax Pattern  ::= substituteBRPs  (Pattern,  RecursivePredicate, Patterns, Pattern) [function]

  rule substituteBRPs(P:Int, RP, Vs, RHS) => P 
  rule substituteBRPs(P:Variable, RP, Vs, RHS) => P 
  rule substituteBRPs(P:Symbol, RP, Vs, RHS) => P 
  rule substituteBRPs(S:Symbol(ARGS) #as P, RP, Vs, RHS) => P 
    requires S =/=K RP
  rule substituteBRPs(RP(BODY_ARGS), RP, ARGS, RHS) => RHS[zip(ARGS, BODY_ARGS)]
 
  rule substituteBRPs(\top(), RP, Vs, RHS) => \top()
  rule substituteBRPs(\bottom(), RP, Vs, RHS) => \bottom()
  rule substituteBRPs(\equals(P1, P2), RP, Vs, RHS)
    => \equals( substituteBRPs(P1, RP, Vs, RHS)
              , substituteBRPs(P2, RP, Vs, RHS)
              )

  rule substituteBRPs(\or(Ps), RP, Vs, RHS)  => \or(substituteBRPsPs(Ps, RP, Vs, RHS))
  rule substituteBRPs(\and(Ps), RP, Vs, RHS) => \and(substituteBRPsPs(Ps, RP, Vs, RHS))

  rule substituteBRPs(\exists { E } C, RP, Vs, RHS)
    => \exists { E } substituteBRPs(C, RP, Vs, RHS)
  rule substituteBRPs(\forall { E } C, RP, Vs, RHS)
    => \forall { E } substituteBRPs(C, RP, Vs, RHS)

  syntax Patterns ::= substituteBRPsPs(Patterns, RecursivePredicate, Patterns, Pattern) [function]
  rule substituteBRPsPs(.Patterns, RP, Vs, RHS) => .Patterns
  rule substituteBRPsPs((P, Ps), RP, Vs, RHS) => substituteBRPs(P, RP, Vs, RHS), substituteBRPsPs(Ps, RP, Vs, RHS):Patterns
```

```k
  syntax Strategy ::= ktForEachBody(Pattern, Pattern, KTInstantiate)
  rule <strategy> ktForEachBody(LRP, \or(.Patterns), _) => success ... </strategy>
  rule <strategy> ktForEachBody(LRP, \or(BODY, BODIES), INSTANTIATION)
               => ktOneBody(LRP, BODY, INSTANTIATION)
                & ktForEachBody(LRP, \or(BODIES), INSTANTIATION)
                  ...
       </strategy>
```

```k
  syntax Strategy ::= ktOneBody(Pattern, Pattern, KTInstantiate)
```

```k
  syntax KItem ::= ktEachBRP(Pattern, Pattern, Patterns, KTInstantiate) // LRP, Body, BRPs
                 | ktOneBRP(Pattern, Pattern, Pattern, Map)   // LRP, Body, BRP, Instantiation substitution
                 | ktBRPResult(Patterns, Pattern)
                 | ktBRPCollectResults(Pattern, Pattern) // Body, LRP
  rule <strategy> ktOneBody(LRP:RecursivePredicate(ARGS), BODY, INSTANTIATION)
               => ktEachBRP(LRP(ARGS), BODY, filterByConstructor(getRecursivePredicates(BODY, .Patterns), LRP), INSTANTIATION)
               ~> ktBRPCollectResults(BODY, LRP(ARGS))
                  ...
       </strategy>
```

```k
  rule <k> GOAL </k>
       <strategy> ktEachBRP(LRP, BODY, (BRP_samehead, BRPs_samehead), INSTANTIATION)
               => ktOneBRP(LRP, BODY, BRP_samehead, ktMakeInstantiationSubst(LRP, BRP_samehead, GOAL, INSTANTIATION))
               ~> ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION)
                  ...
       </strategy>
  rule <strategy> ktEachBRP(LRP, BODY, .Patterns, INSTANTIATION)
               => ktBRPResult(.Patterns, \exists { .Patterns } \and(.Patterns)) ...
       </strategy>

  rule <k> \implies(\and(LHS), \exists { E1 } \and(RHS)) #as GOAL </k>
       <strategy> ktOneBRP(HEAD:RecursivePredicate(LRP_ARGS), \exists { E2 } \and(BODY), HEAD(BRP_ARGS), INST_SUBST)
               => ktBRPResult( (\implies( \and( (LHS -Patterns (HEAD(LRP_ARGS), .Patterns)) ++Patterns
                                                (BODY -Patterns filterByConstructor(getRecursivePredicates(BODY), HEAD)) // BRPs_diffhead + BCPs
                                              )
                                        , \exists {(listToPatterns(values(INST_SUBST)) -Patterns getUniversalVariables(GOAL))}
                                          \and((LHS -Patterns (HEAD(LRP_ARGS), .Patterns))[ zip(LRP_ARGS, BRP_ARGS) ][ INST_SUBST ])
                                        ), .Patterns)
                             , \exists { E1 ++Patterns (listToPatterns(values(INST_SUBST)) -Patterns getUniversalVariables(GOAL))}
                               \and( {(LHS -Patterns (HEAD(LRP_ARGS), .Patterns))[ zip(LRP_ARGS, BRP_ARGS) ][ INST_SUBST ]}:>Patterns
                     ++Patterns {RHS[zip(LRP_ARGS, BRP_ARGS)][INST_SUBST]}:>Patterns)
                             )
                  ...
       </strategy>

  syntax Patterns ::= listToPatterns(List) [function]
  rule listToPatterns(.List) => .Patterns
  rule listToPatterns(ListItem(L) Ls) => L, listToPatterns(Ls)

  syntax Map ::= ktMakeInstantiationSubst(Pattern, Pattern, Pattern, KTInstantiate) [function]
  rule ktMakeInstantiationSubst(HEAD:Predicate(LRP_ARGS), HEAD(BRP_ARGS), \implies(\and(LHS), RHS), useAffectedHeuristic)
    => makeFreshSubstitution(removeDuplicates(findAffectedVariablesAux(LRP_ARGS -Patterns BRP_ARGS, LHS))
                             -Patterns (LRP_ARGS -Patterns (LRP_ARGS -Patterns BRP_ARGS)) // Non-critical
                            // TODO: !!!! This should use findAffectedVariables and not the Aux version
                            )
  rule ktMakeInstantiationSubst(HEAD:Predicate(LRP_ARGs), _, \implies(\and(LHS), RHS), freshPositions(POSITIONS))
    => makeFreshSubstitution(removeDuplicates(getMembers(POSITIONS, getFreeVariables(LHS) -Patterns LRP_ARGs))) // PassiveVars
```

Two consecutive ktBRPResults are consolidated into a single one.

```k
  rule <strategy>    ktBRPResult(PREMISES1, \exists {E1} \and(CONCL_FRAGS1))
                  ~> ktBRPResult(PREMISES2, \exists {E2} \and(CONCL_FRAGS2))
               => ktBRPResult( PREMISES1 ++Patterns PREMISES2
                             , \exists { removeDuplicates( E1 ++Patterns E2 ) }
                               \and(CONCL_FRAGS1 ++Patterns CONCL_FRAGS2)
                             )
                  ...
       </strategy>
```

`ktEachBRP`s are brought to the top of the cell:

```k
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION)
               => ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION) ~> ktBRPResult(PREMISES, CONCL_FRAG)
                  ...
       </strategy>
```

Finally, once we encounter `ktBRPCollectResults`, we build a strategy for KT
goals, including both the premises and the conclusion:

```k
                           // Body           , LRP         , Premises        , Conclusion frags
  syntax Strategy ::= ktGoals(Pattern, Pattern, Patterns        , Pattern)
                    | ktPremise(Pattern)
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktBRPCollectResults(BODY, LRP)
               => ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
  rule <strategy> ktGoals(BODY, LRP, (PREMISE, PREMISES), CONCL_FRAG)
               => ktPremise(PREMISE) & ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
  rule <k> _ => PREMISE </k>
       <strategy> ktPremise(PREMISE) => noop ... </strategy>
       <trace> .K => ktPremise(PREMISE) ... </trace>
```

```k
  rule <k> \implies(\and(LHS), RHS)
        => \implies( \and( (LHS -Patterns (HEAD(LRP_ARGS), .Patterns))
                           ++Patterns (BODY -Patterns filterByConstructor(getRecursivePredicates(BODY), HEAD))
                           ++Patterns CONCL_FRAGS
                         )
                   , RHS
                   )
           ...
       </k>
       <strategy> ktGoals(\exists { _ } \and(BODY), HEAD:RecursivePredicate(LRP_ARGS), .Patterns, \exists { _ } \and(CONCL_FRAGS))
               => noop
                  ...
       </strategy>
       <trace> .K => "Conclusion" ... </trace>
```

```k
  syntax Patterns        // Critical       Conds
    ::= findAffectedVariablesAux(Patterns, Patterns)             [function]
      | findAffectedVariables(Patterns, Patterns, Patterns) [function]
  rule findAffectedVariables(AFF, NONCRIT, CONDS)
    => AFF -Patterns NONCRIT
    requires findAffectedVariablesAux(AFF -Patterns NONCRIT, CONDS) -Patterns NONCRIT
         ==K AFF -Patterns NONCRIT
  // TODO: Why doesn't `owise` work here?
  rule findAffectedVariables(AFF, NONCRIT, CONDS)
    => findAffectedVariables( findAffectedVariablesAux(AFF -Patterns NONCRIT, CONDS)
                            , NONCRIT
                            , CONDS
                            )
    requires findAffectedVariablesAux(AFF -Patterns NONCRIT, CONDS) -Patterns NONCRIT
         =/=K AFF -Patterns NONCRIT
  rule findAffectedVariablesAux(    AFF , (\equals(X, Y), REST))
    => findAffectedVariablesAux((X, AFF),                 REST )
    requires isVariable(X)
     andBool AFF =/=K (AFF -Patterns getFreeVariables(Y, .Patterns))
  rule findAffectedVariablesAux(    AFF , (\equals(Y, X), REST))
    => findAffectedVariablesAux((X, AFF),                 REST )
    requires isVariable(X)
     andBool (AFF -Patterns getFreeVariables(Y, .Patterns)) =/=K AFF
     andBool notBool X in AFF
  rule findAffectedVariablesAux(    AFF , (COND,          REST))
    => findAffectedVariablesAux(    AFF ,                 REST )
       [owise]
  rule findAffectedVariablesAux(    AFF , .Patterns)
    => AFF
```

### Knaster Tarski (Greatest Fixed Points)

TODO: Need `CorecursivePredicate` sort

```k
  rule <strategy> kt-gfp => kt-gfp # .KTFilter # useAffectedHeuristic ... </strategy>
  rule <k> \implies(_, RHS:Pattern) </k>
       <strategy> kt-gfp # FILTER # INSTANTIATION
               => getRecursivePredicates(RHS, .Patterns) ~> kt-gfp # FILTER # INSTANTIATION
                  ...
       </strategy>
//  rule <strategy> RRPs ~> kt-gfp # head(HEAD) # INSTANTIATION
//               => filterByConstructor(RRPs, HEAD) ~> kt-gfp # .KTFilter # INSTANTIATION
//                  ...
//       </strategy>
  rule <strategy> RRPs:Patterns ~> kt-gfp # index(I:Int) # INSTANTIATION
               => getMember(I, RRPs), .Patterns ~> kt-gfp # .KTFilter # INSTANTIATION
                  ...
       </strategy>
```

```k
//  rule <k>    \implies(\and(LHS), \and(RHS))
//           => \implies(\and(LHS), \and({LHS[?USubst][?InstSubst]}:>Patterns
//                                      ++Patterns ?BODY_REST
//                                      ++Patterns (RHS -Patterns (HEAD:Predicate(RRP_ARGS), .Patterns))
//                      )               )
//       </k>
//       <strategy> HEAD(RRP_ARGS), .Patterns
//               ~> kt-gfp # .KTFilter # INSTANTIATION
//               => noop
//                  ...
//       </strategy>
//       <trace>
//         .K => "USubst"    ~> ?USubst
//            ~> "InstSubst" ~> ?InstSubst
//            ~> "BRP: " ~> HEAD(?BRP_ARGS)
//         ...
//       </trace>
//    requires \or(\and(?UNFOLD)) ==K unfold(HEAD(RRP_ARGS))
//     andBool HEAD(?BRP_ARGS), .Patterns ==K filterByConstructor(getRecursivePredicates(?UNFOLD), HEAD)
//     andBool ?BODY_REST ==K (?UNFOLD -Patterns (HEAD(?BRP_ARGS), .Patterns))
//     andBool ?USubst ==K zip(RRP_ARGS, ?BRP_ARGS)
//     andBool ?InstSubst ==K makeFreshSubstitution(getFreeVariables(LHS) -Patterns getFreeVariables(RHS))
```

```k
endmodule
```
