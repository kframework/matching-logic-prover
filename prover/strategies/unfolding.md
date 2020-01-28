```k
module STRATEGY-UNFOLDING
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS
  imports STRATEGY-SIMPLIFICATION

  syntax Pattern ::= unfold(Pattern) [function]
  rule [[ unfold(S:Symbol(ARGs)) => alphaRename(substMap(alphaRename(DEF), zip(Vs, ARGs))) ]]
       <declaration> axiom \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs ==K .Patterns
  rule [[ unfold(S:Symbol(ARGs)) => {("ifflfp axiom has free variables!" ~> S ~> (getFreeVariables(DEF) -Patterns Vs))}:>Pattern ]]
       <declaration> axiom \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs =/=K .Patterns

  syntax SymbolDeclaration ::= getSymbolDeclaration(Symbol) [function]
  rule [[ getSymbolDeclaration(S) => DECL ]]
       <declaration> symbol S (_) : _ #as DECL </declaration>

  syntax Patterns ::= getRecursiveSymbols(Patterns) [function]
  rule [[ getRecursiveSymbols(SYMs) => getRecursiveSymbols(SYM, SYMs) ]]
       <declaration> axiom \forall { Vs } \iff-lfp(SYM(Vs), DEF) </declaration>
     requires notBool SYM in SYMs
  rule getRecursiveSymbols(SYMs) => SYMs
    [owise]

  syntax Patterns ::= getUnfoldables(Patterns)   [function]
  rule getUnfoldables(.Patterns) => .Patterns
  rule getUnfoldables(R(ARGS), REST)
    => R(ARGS), getUnfoldables(REST)
    requires isUnfoldable(R)
  rule getUnfoldables(S:Symbol, REST)
    => getUnfoldables(REST)
    requires notBool isUnfoldable(S)
  rule getUnfoldables(S:Symbol(ARGS), REST)
    => getUnfoldables(REST)
    requires notBool isUnfoldable(S)
    andBool S =/=K sep
  rule getUnfoldables(I:Int, REST)
    => getUnfoldables(REST)
  rule getUnfoldables(V:Variable, REST)
    => getUnfoldables(REST)
  rule getUnfoldables(\not(Ps), REST)
    => getUnfoldables(Ps) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(\and(Ps), REST)
    => getUnfoldables(Ps) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(sep(Ps), REST)
    => getUnfoldables(Ps) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(\or(Ps), REST)
    => getUnfoldables(Ps) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(\implies(LHS, RHS), REST)
    => getUnfoldables(LHS) ++Patterns
       getUnfoldables(RHS) ++Patterns
       getUnfoldables(REST)
  rule getUnfoldables(\equals(LHS, RHS), REST)
    => getUnfoldables(LHS) ++Patterns
       getUnfoldables(RHS) ++Patterns
       getUnfoldables(REST)
  rule getUnfoldables(\exists { _ } P, REST)
    => getUnfoldables(P) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(\forall { _ } P, REST)
    => getUnfoldables(P) ++Patterns getUnfoldables(REST)
```

### Just Left Unfold Nth

Just unfolds the Nth predicate on the LHS.

```k
  rule <strategy> just-left-unfold-Nth(M)
               => just-left-unfold-Nth-#1(M, getUnfoldables(LHS))
                  ...
       </strategy>
       <claim> \implies(\and(LHS), RHS) </claim>

  syntax Strategy ::= "just-left-unfold-Nth-#1"  "(" Int "," Patterns ")"
                    | "just-left-unfold-Nth-#2"  "(" Pattern "," Pattern ")"


  rule <strategy> just-left-unfold-Nth-#1(M, PS)
               => just-left-unfold-Nth-#2(getMember(M, PS), unfold(getMember(M, PS)))
                  ...
       </strategy>
  requires 0 <=Int M andBool M <Int getLength(PS)

  rule <claim> \implies(LHS => subst(LHS, PATTERN, BODY), RHS) </claim>
       <strategy> just-left-unfold-Nth-#2(PATTERN, BODY)
               => noop
                  ...
       </strategy>

```

### Left Unfold (incomplete)

```k
  syntax Strategy ::= "left-unfold-eachBody"  "(" Pattern "," Pattern ")"
                    | "left-unfold-oneBody"   "(" Pattern "," Pattern ")"

  rule <strategy> left-unfold-eachBody(LRP, \or(BODY, BODIES))
               => left-unfold-oneBody(LRP, BODY)
                & left-unfold-eachBody(LRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> left-unfold-eachBody(LRP, \or(.Patterns))
               => success
                  ...
       </strategy>

  rule <claim> \implies(\and(LHS), RHS)
        => \implies(\and((LHS -Patterns (LRP, .Patterns)) ++Patterns BODY), RHS)
       </claim>
       <strategy> left-unfold-oneBody(LRP, \exists { _ } \and(BODY)) => noop ... </strategy>
       <trace> .K => left-unfold-oneBody(LRP, \and(BODY)) ... </trace>
       requires LRP in LHS

  rule <claim> \implies( \and( sep( (LHS => ((LHS -Patterns (LRP, .Patterns)) ++Patterns \and(BODY))) )
                             , _
                             )
                       , RHS
                       )
       </claim>
       <strategy> left-unfold-oneBody(LRP, \exists { _ } \and(BODY)) => noop ... </strategy>
       <trace> .K => left-unfold-oneBody(LRP, \and(BODY)) ... </trace>
       requires LRP in LHS
```

### Left Unfold Nth

Unfold the Nth predicates on the Left hand side into a conjunction of
implicatations. The resulting goals are equivalent to the initial goal.

```k
  syntax Strategy ::= "left-unfold-Nth-eachLRP"  "(" Int "," Patterns ")"
                    | "left-unfold-Nth-eachBody" "(" Int "," Pattern "," Pattern ")"
                    | "left-unfold-Nth-oneBody"  "(" Int "," Pattern "," Pattern ")"

  rule <strategy> left-unfold-Nth(M)
               => left-unfold-Nth-eachLRP(M, getUnfoldables(LHS))
                  ...
       </strategy>
       <claim> \implies(\and(LHS), RHS) </claim>

  rule <strategy> left-unfold-Nth-eachLRP(M, PS)
               => fail
                  ...
       </strategy>
  requires M <Int 0 orBool M >=Int getLength(PS)

  rule <strategy> left-unfold-Nth-eachLRP(M, PS)
               => left-unfold-Nth-eachBody(M, getMember(M, PS), unfold(getMember(M, PS)))
                  ...
       </strategy>
  requires 0 <=Int M andBool M <Int getLength(PS)

  rule <strategy> left-unfold-Nth-eachBody(M, LRP, Bodies)
               => left-unfold-eachBody(LRP, Bodies)
                  ...
       </strategy>
```

### Right Unfold

Unfold the predicates on the Right hand side into a disjunction of implications.
Note that the resulting goals is stonger than the initial goal (i.e.
`A -> B \/ C` vs `(A -> B) \/ (A -> C)`).

```k
  syntax Strategy ::= "right-unfold-eachRRP" "(" Patterns")"
                    | "right-unfold-eachBody" "(" Pattern "," Pattern ")"
                    | "right-unfold-oneBody"  "(" Pattern "," Pattern ")"

  rule <strategy> right-unfold ( SYMBOL )
               => right-unfold-eachRRP( filterByConstructor(getUnfoldables(RHS), SYMBOL) )
                  ...
       </strategy>
       <claim> \implies(LHS, \exists { _ } \and(RHS)) </claim>
  rule <strategy> right-unfold
               => right-unfold-eachRRP(getUnfoldables(RHS))
                  ...
       </strategy>
       <claim> \implies(LHS, \exists { _ } \and(RHS)) </claim>
  rule <strategy> right-unfold-all(bound: N)
               => right-unfold-all(symbols: getRecursiveSymbols(.Patterns), bound: N)
                  ...
       </strategy>
  rule <strategy> right-unfold-all(symbols: SYMs, bound: N)
               => right-unfold-perm(permutations: perm(SYMs), bound: N)
                  ...
       </strategy>
  rule <strategy> right-unfold-perm(permutations: .List, bound: _)
               => noop
                  ...
       </strategy>
  rule <strategy> right-unfold-perm(permutations: ListItem(Ps) L, bound: N)
               => right-unfold(symbols: Ps, bound: N)
                | right-unfold-perm(permutations: L, bound: N)
                  ...
       </strategy>
  rule <strategy> right-unfold(symbols: Ps, bound: N)
               => fail
                  ...
       </strategy>
    requires Ps ==K .Patterns orBool N <=Int 0
  rule <strategy> right-unfold(symbols: P, Ps, bound: N)
               => normalize . or-split-rhs . lift-constraints
                . instantiate-existentials . substitute-equals-for-equals
                . ( ( match . spatial-patterns-equal . smt-cvc4 )
                  | ( right-unfold(P) . right-unfold(symbols: P, Ps, bound: N -Int 1) )
                  | ( right-unfold(symbols: Ps, bound: N) )
                  )
                  ...
       </strategy>
    requires N =/=Int 0
  rule <strategy> right-unfold-eachRRP(P, PS)
               => right-unfold-eachBody(P, unfold(P))
                | right-unfold-eachRRP(PS)
                  ...
       </strategy>
  rule <strategy> right-unfold-eachRRP(.Patterns)
               => fail
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(BODY, BODIES))
               => right-unfold-oneBody(RRP, BODY)
                | right-unfold-eachBody(RRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(.Patterns))
               => fail
                  ...
       </strategy>
```

### Permuting list of recursive symbols for use in right-unfold-all

```k
syntax List ::= perm(Patterns) [function]
              | permHelp(Patterns, Patterns) [function]
              | addPattern(Pattern, List) [function]
rule perm(.Patterns) => ListItem(.Patterns)
rule perm(Ps) => permHelp(Ps, Ps)
  requires Ps =/=K .Patterns
rule permHelp(.Patterns, _) => .List
rule permHelp((P, Ps1), Ps2) => addPattern(P, perm(Ps2 -Patterns P)) permHelp(Ps1, Ps2)

rule addPattern(P, .List) => .List
rule addPattern(P, ListItem(Ps:Patterns) L) => ListItem(P, Ps) addPattern(P, L)
```

```k
  // TODO: -Patterns does not work here. We need to substitute RRP with BODY
  rule <claim> \implies(LHS, \exists { E1 } \and(RHS))
        => \implies(LHS, \exists { E1 ++Patterns E2 }
                         \and(substPatternsMap(RHS, zip((RRP, .Patterns), (\and(BODY), .Patterns))))) ...
       </claim>
       <strategy> right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) => noop ... </strategy>
       <trace> .K
            => right-unfold-oneBody(RRP, \exists { E2 } \and(BODY))
               ~> RHS ~> substPatternsMap(RHS, zip((RRP, .Patterns), (\and(BODY), .Patterns)))
               ...
       </trace>
    requires notBool hasImplicationContext(LHS)

  syntax Pattern ::= #moveHoleToFront(Pattern) [function]
  rule #moveHoleToFront(\and(sep(#hole, REST_SEP), REST_AND)) => \and(sep(#hole, REST_SEP), REST_AND)
  rule #moveHoleToFront(\and(sep(P, REST_SEP), REST_AND)) => #moveHoleToFront(\and(sep(REST_SEP ++Patterns P), REST_AND))
    requires P =/=K #hole:Variable

  // right unfolding within an implication context
  rule <claim> \implies(\and( sep ( \forall { UNIVs => UNIVs ++Patterns E2 }
                                    implicationContext( ( \and( sep( #hole
                                                                   , CTXLHS
                                                                   )
                                                              , CTXLCONSTRAINTS
                                                              )
                                                        )
                                                       => #moveHoleToFront(#flattenAnd(
                                                            #liftConstraints( \and( sep( #hole
                                                                                       , substPatternsMap(CTXLHS, zip((RRP, .Patterns), (\and(BODY), .Patterns)))
                                                                                       )
                                                                                  , CTXLCONSTRAINTS
                                                                                  )
                                                                            )
                                                          ))
                                                      , _
                                                      )
                                  , LSPATIAL
                                  )
                            , LHS:Patterns
                            )
                       , RHS:Pattern
                       )
       </claim>
       <strategy> right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) => noop ... </strategy>
       <trace> .K
            => right-unfold-oneBody(RRP, \exists { E2 } \and(BODY))
               ~> RHS ~> substPatternsMap(RHS, zip((RRP, .Patterns), (\and(BODY), .Patterns)))
               ...
       </trace>
```

### Right-Unfold-Nth

Often, when debugging a proof, the user knows which predicate needs to be
unfolded. Here we define a strategy `right-unfold-Nth(M, N)`, which unfolds the
`M`th recursive predicate (on the right-hand side) to its `N`th body. When `M`
or `N` is out of range, `right-unfold(M,N) => fail`.

```k
  syntax Strategy ::= "right-unfold-Nth-eachRRP"  "(" Int "," Int "," Patterns")"
                    | "right-unfold-Nth-eachBody" "(" Int "," Int "," Pattern "," Pattern ")"
                    | "right-unfold-Nth-oneBody"  "(" Int "," Int "," Pattern "," Pattern ")"

  rule <strategy> right-unfold-Nth (M,N) => fail ... </strategy>
  requires (M <Int 0) orBool (N <Int 0)

  rule <strategy> right-unfold-Nth (M,N)
               => right-unfold-Nth-eachRRP(M, N, getUnfoldables(RHS))
                  ...
       </strategy>
       <claim> \implies(LHS,\exists {_ } \and(RHS)) </claim>

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs) => fail ... </strategy>
    requires getLength(RRPs) <=Int M

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs:Patterns)
               => right-unfold-Nth-eachBody(M, N, getMember(M, RRPs), unfold(getMember(M, RRPs)))
                  ...
       </strategy>
    requires getLength(RRPs) >Int M

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => fail
                  ...
       </strategy>
    requires getLength(Bodies) <=Int N

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => right-unfold-Nth-oneBody(M, N, RRP, getMember(N, Bodies))
                  ...
       </strategy>
    requires getLength(Bodies) >Int N

  rule <strategy> right-unfold-Nth-oneBody(M, N, RRP, Body)
               => right-unfold-oneBody(RRP, Body)
                  ...
       </strategy>
```

```k
endmodule
```

