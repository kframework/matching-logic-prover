```k
module STRATEGY-KNASTER-TARSKI
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
  imports STRATEGY-UNFOLDING
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
  rule getKTUnfoldables(I:Int, REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(V:Variable, REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(\not(Ps), REST)
    => getKTUnfoldables(REST)
  rule getKTUnfoldables(\and(Ps), REST)
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
  rule <strategy> kt => kt # .KTFilter ... </strategy>
  rule <claim> \implies(\and(LHS), RHS) </claim>
       <strategy> kt # FILTER
               => getKTUnfoldables(LHS) ~> kt # FILTER
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # head(HEAD)
               => filterByConstructor(LRPs, HEAD) ~> kt # .KTFilter
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # index(I:Int)
               => getMember(I, LRPs), .Patterns ~> kt # .KTFilter
                  ...
       </strategy>
  rule <strategy> LRPs:Patterns ~> kt # .KTFilter
               => ktForEachLRP(LRPs)
                  ...
       </strategy>
```

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:

```k
  syntax Strategy ::= ktForEachLRP(Patterns)
  rule <strategy> ktForEachLRP(.Patterns) => noop ... </strategy>
  rule <strategy> ( ktForEachLRP((LRP, LRPs))
                 => ( remove-lhs-existential ; normalize
                    ; kt-wrap(LRP) ; kt-forall-intro
                    ; kt-unfold ; lift-or ; and-split ; remove-lhs-existential
                    ; kt-unwrap
                    ; simplify ; normalize ; kt-collapse
                    )
                    | ktForEachLRP(LRPs)
                  )
                 ~> REST
       </strategy>
```

```k
  syntax Variable ::= "#hole"

  // Sugar for `\exists #hole . #hole /\ floor(Arg1 -> Arg2)
  syntax Pattern ::= implicationContext(Pattern, Pattern) [klabel(implicationContext)]

  rule getFreeVariables(implicationContext(CONTEXT, P), .Patterns)
    => (getFreeVariables(CONTEXT, .Patterns) ++Patterns getFreeVariables(P, .Patterns))
       -Patterns #hole, .Patterns
  rule subst(implicationContext(CTX, RHS), X, V)
    => implicationContext(subst(CTX,X,V), subst(RHS,X,V)):Pattern
  rule alphaRename(implicationContext(P, Qs))
    => implicationContext(alphaRename(P), alphaRename(Qs))
```

>   phi(x) -> C'[psi(x)]
>   --------------------
>   C[phi(x)] -> psi(x)
>
> where `C'[psi(x)] ≡ \exists #hole . #hole /\ ⌊C[#hole] -> psi(x)⌋`

```k
  syntax Strategy ::= "kt-wrap" "(" Pattern ")"
  rule <claim> \implies(\and(LHS:Patterns), RHS)
        => \implies(LRP, implicationContext(\and(#hole, (LHS -Patterns LRP)), RHS))
       </claim>
       <strategy> kt-wrap(LRP) => noop ... </strategy>
       <trace> .K => kt-wrap(LRP)  ... </trace>
    requires LRP in LHS
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
       <strategy> kt-forall-intro => noop ... </strategy>
```

>         phi(x) -> psi(x, y)
>   ------------------------------
>   phi(x) -> \forall y. psi(x, y)

```k
  syntax Strategy ::= "kt-forall-elim"
  rule <claim> \implies(LHS, \forall { Vs } RHS) => \implies(LHS, RHS) </claim>
       <strategy> kt-forall-elim => noop ... </strategy>
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
       <strategy> kt-unfold => noop ... </strategy>
    requires removeDuplicates(ARGS) ==K ARGS
     andBool isUnfoldable(LRP)
  rule <claim> \implies(LRP(ARGS), RHS)
       </claim>
       <strategy> kt-unfold => fail ... </strategy>
    requires removeDuplicates(ARGS) =/=K ARGS
     andBool isUnfoldable(LRP)

                             // unfolded fixed point, HEAD, LRP variables, Pattern
  syntax Pattern ::= substituteBRPs(Pattern,  Symbol, Patterns, Pattern) [function]
  rule substituteBRPs(P:Int, RP, Vs, RHS) => P
  rule substituteBRPs(P:Variable, RP, Vs, RHS) => P
  rule substituteBRPs(P:Symbol, RP, Vs, RHS) => P
  rule substituteBRPs(S:Symbol(ARGS) #as P, RP, Vs, RHS) => P
    requires S =/=K RP
  rule substituteBRPs(RP(BODY_ARGS), RP, ARGS, (\forall { Qs } implicationContext(CTX, P)) #as RHS)
    => alphaRename(substMap(RHS, zip(ARGS, BODY_ARGS)))

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
        => \implies(CTX[#hole/LHS], RHS)
       </claim>
       <strategy> kt-unwrap => noop ... </strategy>
```

```k
  syntax Strategy ::= "kt-collapse"

// Move Implication contexts to the front
  rule <claim> \implies(\and(P, Ps) #as LHS, RHS)
        => \implies(\and(Ps ++Patterns P), RHS)
       </claim>
       <strategy> kt-collapse ... </strategy>
    requires notBool hasImplicationContext(P)
     andBool hasImplicationContext(LHS)

// Move #holes to the front
  rule <claim> \implies(\and(\forall { _ }
                         implicationContext( \and(P, Ps)
                                          => \and(Ps ++Patterns P)
                                           , _)
                        , _), _)
       </claim>
       <strategy> kt-collapse ... </strategy>
    requires P =/=K #hole:Pattern
     andBool #hole in Ps

// remove implication context
  rule <claim> \implies(\and( \forall { UNIVs } ( implicationContext( \and(#hole, CTXLHS:Patterns)
                                                                , CTXRHS:Pattern)
                                           => \implies(\and(CTXLHS), CTXRHS)
                                            )
                        , LHS:Patterns
                        )
                   , RHS:Pattern
                   )
       </claim>
       <strategy> kt-collapse ... </strategy>
```

```k
  syntax Patterns ::= substituteWithEach(Pattern, Variable, Patterns) [function]
  rule substituteWithEach(_, _, .Patterns) => .Patterns
  rule substituteWithEach(P, V, (I, Is))
    => P[V/I], substituteWithEach(P, V, Is)

  syntax Patterns ::= filterVariablesBySort(Patterns, Sort) [function]
  rule filterVariablesBySort(.Patterns, _) => .Patterns
  rule filterVariablesBySort(((_ { S } #as V), Vs), S)
    => V, filterVariablesBySort(Vs, S)
  rule filterVariablesBySort((V, Vs), S)
    => filterVariablesBySort(Vs, S) [owise]

  rule <claim> GOAL </claim>
       <strategy> kt-collapse => noop ... </strategy>
    requires notBool(hasImplicationContext(GOAL))

  // TODO: Move to "normalize" strategy
  rule <claim> \implies(\and(\and(Ps1), Ps2), RHS)
        => \implies(\and(Ps1 ++Patterns Ps2), RHS)
       </claim>
       <strategy> kt-collapse ... </strategy>
  rule <claim> \implies(\and(_, ( \and(Ps1), Ps2
                           => Ps1 ++Patterns Ps2))
                   , RHS)
       </claim>
       <strategy> kt-collapse ... </strategy>

  rule <claim> \implies(\and( _
                        , (\exists { _ } P => P)
                        , Ps)
                   , _
                   )
       </claim>
       <strategy> kt-collapse ... </strategy>

  syntax Bool ::= hasImplicationContext(Pattern)  [function]
  syntax Bool ::= hasImplicationContextPs(Patterns)  [function]
  rule hasImplicationContext(X:Variable) => false
  rule hasImplicationContext(X:Int) => false
  rule hasImplicationContext(S:Symbol) => false
  rule hasImplicationContext(\implies(LHS, RHS))
    => hasImplicationContext(LHS) orBool hasImplicationContext(RHS)
  rule hasImplicationContext(\equals(LHS, RHS))
    => hasImplicationContext(LHS) orBool hasImplicationContext(RHS)
  rule hasImplicationContext(S:Symbol (ARGS)) => hasImplicationContextPs(ARGS)
  rule hasImplicationContext(\and(Ps)) => hasImplicationContextPs(Ps)
  rule hasImplicationContext(\or(Ps)) => hasImplicationContextPs(Ps)
  rule hasImplicationContext(\not(P)) => hasImplicationContext(P)
  rule hasImplicationContext(\exists{ _ } P ) => hasImplicationContext(P)
  rule hasImplicationContext(\forall{ _ } P ) => hasImplicationContext(P)
  rule hasImplicationContext(implicationContext(_, _)) => true
  rule hasImplicationContextPs(.Patterns) => false
  rule hasImplicationContextPs(P, Ps)
    => hasImplicationContext(P) orBool hasImplicationContextPs(Ps)
```

>   gamma -> alpha     beta /\ gamma -> psi
>   ---------------------------------------
>      (alpha -> beta) /\ gamma -> psi

```k
  rule <claim> \implies( \and(\forall { .Patterns } \implies(LHS, RHS), REST:Patterns)
                  => \and(REST)
                   , _
                   )
       </claim>
       <strategy> kt-solve-implications( STRAT)
               => ( kt-solve-implication( subgoal(\implies(\and(removeImplications(REST)), LHS), STRAT)
                                        , \and(LHS, RHS)
                                        )
                  ; kt-solve-implications(STRAT)
                  )
                  ...
       </strategy>

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
       <strategy> kt-solve-implications(_)
                  ...
       </strategy>
    requires hasImplication(REST)
     andBool notBool matchesImplication(P)

  rule <claim> \implies(\and(LHS), _) </claim>
       <strategy> kt-solve-implications(STRAT) => noop ... </strategy>
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
  rule <strategy> kt-solve-implication(S, RHS)
               => S ~> kt-solve-implication(#hole, RHS)
                  ...
       </strategy>
    requires notBool isTerminalStrategy(S)
    
  rule <strategy> T:TerminalStrategy ~> kt-solve-implication(#hole, RHS)
               => kt-solve-implication(T, RHS)
                  ...
       </strategy>
  rule <strategy> kt-solve-implication(fail, RHS) => noop ... </strategy>
  rule <strategy> kt-solve-implication(success, CONC) => noop ... </strategy>
       <claim> \implies(\and(LHS), RHS)
        => \implies(\and(CONC, LHS), RHS)
       </claim>
```

```k
  syntax Strategy ::= "instantiate-universals-with-ground-terms" "(" Patterns /* universals */ "," Patterns /* ground terms */ ")"
  rule <claim> \implies(\and(LHS), RHS) #as GOAL </claim>
       <strategy> instantiate-universals-with-ground-terms
               => instantiate-universals-with-ground-terms(getForalls(LHS), removeDuplicates(getGroundTerms(GOAL)))
                  ...
       </strategy>

  rule <strategy> instantiate-universals-with-ground-terms( (\forall { (_ { S } #as V:Variable), UNIVs:Patterns } P:Pattern , REST_FORALLs)
                                => (substituteWithEach(\forall { UNIVs } P, V, filterBySort(GROUND_TERMS, S)) ++Patterns REST_FORALLs)
                                 , GROUND_TERMS
                                 )
                  ...
       </strategy>

  rule <claim> \implies(\and(LHS => P, LHS), RHS) </claim> 
       <strategy> instantiate-universals-with-ground-terms( (\forall { .Patterns } P:Pattern , REST_FORALLs) => REST_FORALLs 
                                 , _
                                 )
                  ...
       </strategy>
    requires notBool P in LHS
  rule <claim> \implies(\and(LHS), RHS) </claim> 
       <strategy> instantiate-universals-with-ground-terms( (\forall { .Patterns } P:Pattern , REST_FORALLs) => REST_FORALLs 
                                 , _
                                 )
                  ...
       </strategy>
    requires P in LHS

  rule <strategy> instantiate-universals-with-ground-terms( .Patterns
                                 , _
                                 )
               => noop
                  ...
       </strategy>

  syntax Patterns ::= getForalls(Patterns) [function]
  rule getForalls(((\forall { _ } _) #as P), Ps) => P, getForalls(Ps)
  rule getForalls(                       P , Ps) =>    getForalls(Ps) [owise]
  rule getForalls(.Patterns) => .Patterns 
  
  syntax Patterns ::= filterBySort(Patterns, Sort) [function]
  rule filterBySort((P, Ps), S) => P, filterBySort(Ps, S) requires getReturnSort(P) ==K S
  rule filterBySort((P, Ps), S) =>    filterBySort(Ps, S) requires getReturnSort(P) =/=K S
  rule filterBySort(.Patterns, S) => .Patterns

  syntax Sort ::= getReturnSort(Pattern) [function]
  rule getReturnSort( I:Int ) => Int
  rule getReturnSort( _ { S } ) => S
  rule getReturnSort( select ( ARGS ) ) => Int
  rule getReturnSort( union ( ARGS ) ) => SetInt
  rule getReturnSort( singleton ( ARGS ) ) => SetInt
  rule getReturnSort( emptyset ) => SetInt
  rule getReturnSort( disjoint ( ARGS ) ) => Bool
  rule getReturnSort( gt ( ARGS ) ) => Bool
  rule [[ getReturnSort( R ( ARGS ) )  => S ]]
       <declaration> symbol R ( _ ) : S </declaration>

  syntax Patterns ::= getGroundTerms(Pattern) [function]
  rule getGroundTerms(P) => getGroundTerms(P, .Patterns)
  syntax Patterns ::= getGroundTerms(Pattern, Patterns) [function, klabel(getGroundTermsAux)]
  rule getGroundTerms(S:Symbol, VARs) => S, .Patterns
  rule getGroundTerms(I:Int, VARs) => I, .Patterns
  rule getGroundTerms(X:Variable, VARs) => X, .Patterns requires notBool X in VARs
  rule getGroundTerms(X:Variable, VARs) =>    .Patterns requires         X in VARs

  rule getGroundTerms(\implies(LHS, RHS), VARs)
    => getGroundTerms(LHS, VARs) ++Patterns getGroundTerms(RHS, VARs) 
  rule getGroundTerms(\equals(LHS, RHS), VARs)
    => getGroundTerms(LHS, VARs) ++Patterns getGroundTerms(RHS, VARs) 
  rule getGroundTerms(\forall { UNIVs } P, VARs)
    => getGroundTerms(P, VARs ++Patterns UNIVs) 
  rule getGroundTerms(\exists { UNIVs } P, VARs)
    => getGroundTerms(P, VARs ++Patterns UNIVs) 
  rule getGroundTerms(\and(.Patterns), VARs)
    => .Patterns
  rule getGroundTerms(\and(P, Ps), VARs)
    => getGroundTerms(P, VARs) ++Patterns getGroundTerms(\and(Ps), VARs) 
  rule getGroundTerms(\not(P), VARs)
    => getGroundTerms(P, VARs)
  rule getGroundTerms(S:Symbol(ARGS:Patterns) #as APPLY, VARs)
    => APPLY , getGroundTerms(\and(ARGS))
    requires VARs -Patterns getFreeVariables(ARGS) ==K VARs
  rule getGroundTerms(S:Symbol(ARGS:Patterns) #as APPLY, VARs)
    => getGroundTerms(\and(ARGS))
    requires VARs -Patterns getFreeVariables(ARGS) =/=K VARs

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
