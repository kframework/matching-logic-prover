```k
module STRATEGY-UNFOLDING
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS
  imports STRATEGY-SIMPLIFICATION

  syntax Pattern ::= unfold(Pattern) [function]
  rule [[ unfold(S:Symbol(ARGs)) => alphaRename(substMap(alphaRename(DEF), zip(Vs, ARGs))) ]]
       <declaration> axiom _: \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs ==K .Patterns
  rule [[ unfold(S:Symbol(ARGs)) => {("ifflfp axiom has free variables!" ~> S ~> (getFreeVariables(DEF) -Patterns Vs))}:>Pattern ]]
       <declaration> axiom _: \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs =/=K .Patterns
  rule unfold(\mu X . P) => subst(P, X, alphaRename(\mu X . P))

  syntax SymbolDeclaration ::= getSymbolDeclaration(Symbol) [function]
  rule [[ getSymbolDeclaration(S) => DECL ]]
       <declaration> symbol S (_) : _ #as DECL </declaration>

  syntax Patterns ::= getRecursiveSymbols(Patterns) [function]
  rule [[ getRecursiveSymbols(SYMs) => getRecursiveSymbols(SYM, SYMs) ]]
       <declaration> axiom _: \forall { Vs } \iff-lfp(SYM(Vs), DEF) </declaration>
     requires notBool SYM in SYMs
  rule getRecursiveSymbols(SYMs) => SYMs
    [owise]

  syntax Patterns ::= getUnfoldables(Patterns)   [function]
  rule getUnfoldables(.Patterns) => .Patterns
  rule getUnfoldables(R(ARGS), REST)
    => R(ARGS), (getUnfoldables(ARGS)
       ++Patterns getUnfoldables(REST))
    requires isUnfoldable(R)
  rule getUnfoldables(\mu X . P, REST)
    => \mu X . P, getUnfoldables(REST)
  rule getUnfoldables(S:Symbol, REST)
    => getUnfoldables(REST)
    requires notBool isUnfoldable(S)
  rule getUnfoldables(S:Symbol(ARGS), REST)
    => getUnfoldables(ARGS) ++Patterns getUnfoldables(REST)
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

### Left Unfold (incomplete)

```k
  syntax Strategy ::= "left-unfold-eachBody"  "(" Pattern "," Pattern ")"
                    | "left-unfold-oneBody"   "(" Pattern "," Pattern ")"

  rule <k> left-unfold-eachBody(LRP, \or(BODY, BODIES))
               => left-unfold-oneBody(LRP, BODY)
                & left-unfold-eachBody(LRP, \or(BODIES))
                  ...
       </k>
  rule <k> left-unfold-eachBody(LRP, \or(.Patterns))
               => success
                  ...
       </k>

// TODO: left-unfold should take a context as a parameter as well in the future
  rule <claim> \implies(LHS, RHS)
            => \implies(subst(LHS, LRP, \and(BODY)), RHS)
       </claim>
       <k> left-unfold-oneBody(LRP, \exists { _ } \and(BODY)) => noop ... </k>
       <trace> .K => left-unfold-oneBody(LRP, \and(BODY)) ... </trace>
    requires #hole { getReturnSort(LRP) } in getFreeVariables(subst(LHS, LRP, #hole { getReturnSort(LRP) }))
```

### Left Unfold Nth

Unfold the Nth predicates on the Left hand side into a conjunction of
implicatations. The resulting goals are equivalent to the initial goal.

```k
  syntax Strategy ::= "left-unfold-Nth-eachLRP"  "(" Int "," Patterns ")"
                    | "left-unfold-Nth-eachBody" "(" Int "," Pattern "," Pattern ")"
                    | "left-unfold-Nth-oneBody"  "(" Int "," Pattern "," Pattern ")"

  rule <k> left-unfold-Nth(M)
               => left-unfold-Nth-eachLRP(M, getUnfoldables(LHS))
                  ...
       </k>
       <claim> \implies(\and(LHS), RHS) </claim>

  rule <k> left-unfold-Nth-eachLRP(M, PS)
               => fail
                  ...
       </k>
  requires M <Int 0 orBool M >=Int getLength(PS)

  rule <k> left-unfold-Nth-eachLRP(M, PS)
               => left-unfold-Nth-eachBody(M, getMember(M, PS), unfold(getMember(M, PS)))
                  ...
       </k>
  requires 0 <=Int M andBool M <Int getLength(PS)

  rule <k> left-unfold-Nth-eachBody(M, LRP, Bodies)
               => left-unfold-eachBody(LRP, Bodies)
                  ...
       </k>
```

### Right Unfold

Unfold the predicates on the Right hand side into a disjunction of implications.
Note that the resulting goals is stonger than the initial goal (i.e.
`A -> B \/ C` vs `(A -> B) \/ (A -> C)`).

```k
  syntax Strategy ::= "right-unfold-eachRRP" "(" Patterns")"
                    | "right-unfold-eachBody" "(" Pattern "," Pattern ")"
                    | "right-unfold-oneBody"  "(" Pattern "," Pattern ")"

  rule <k> right-unfold ( SYMBOL )
               => right-unfold-eachRRP( filterByConstructor(getUnfoldables(RHS), SYMBOL) )
                  ...
       </k>
       <claim> \implies(LHS, \exists { _ } \and(RHS)) </claim>
  rule <k> right-unfold
               => right-unfold-eachRRP(getUnfoldables(RHS))
                  ...
       </k>
       <claim> \implies(LHS, \exists { _ } \and(RHS)) </claim>
  rule <k> right-unfold-all(bound: N)
               => right-unfold-all(symbols: getRecursiveSymbols(.Patterns), bound: N)
                  ...
       </k>
  rule <k> right-unfold-all(symbols: SYMs, bound: N)
               => right-unfold-perm(permutations: perm(SYMs), bound: N)
                  ...
       </k>
  rule <k> right-unfold-perm(permutations: .List, bound: _)
               => noop
                  ...
       </k>
  rule <k> right-unfold-perm(permutations: ListItem(Ps) L, bound: N)
               => right-unfold(symbols: Ps, bound: N)
                | right-unfold-perm(permutations: L, bound: N)
                  ...
       </k>
  rule <k> right-unfold(symbols: Ps, bound: N)
               => fail
                  ...
       </k>
    requires Ps ==K .Patterns orBool N <=Int 0
  rule <k> right-unfold(symbols: P, Ps, bound: N)
               => normalize . or-split-rhs . lift-constraints
                . instantiate-existentials . substitute-equals-for-equals
                . ( ( noop )
                  | ( right-unfold(P) . right-unfold(symbols: P, Ps, bound: N -Int 1) )
                  | ( right-unfold(symbols: Ps, bound: N) )
                  )
                  ...
       </k>
    requires N =/=Int 0
  rule <k> right-unfold-eachRRP(P, PS)
               => right-unfold-eachBody(P, unfold(P))
                | right-unfold-eachRRP(PS)
                  ...
       </k>
  rule <k> right-unfold-eachRRP(.Patterns)
               => fail
                  ...
       </k>
  rule <k> right-unfold-eachBody(RRP, \or(BODY, BODIES))
               => right-unfold-oneBody(RRP, BODY)
                | right-unfold-eachBody(RRP, \or(BODIES))
                  ...
       </k>
  rule <k> right-unfold-eachBody(RRP, \or(.Patterns))
               => fail
                  ...
       </k>
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
                             \and(substPatternsMap(RHS, zip((RRP, .Patterns), (\and(BODY), .Patterns)))))
       </claim>
       <k> right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) => noop ... </k>
       <trace> .K
            => right-unfold-oneBody(RRP, \exists { E2 } \and(BODY))
               ~> RHS ~> substPatternsMap(RHS, zip((RRP, .Patterns), (\and(BODY), .Patterns)))
               ...
       </trace>
    requires notBool hasImplicationContext(LHS)

  syntax Pattern ::= #moveHoleToFront(Pattern) [function]
  rule #moveHoleToFront(\and(sep(#hole { Heap }, REST_SEP), REST_AND)) => \and(sep(#hole { Heap }, REST_SEP), REST_AND)
  rule #moveHoleToFront(\and(sep(P, REST_SEP), REST_AND)) => #moveHoleToFront(\and(sep(REST_SEP ++Patterns P), REST_AND))
    requires P =/=K #hole { Heap }

  // right unfolding within an implication context
  rule <claim> \implies(\and( sep ( \forall { UNIVs => UNIVs ++Patterns E2 }
                                    implicationContext( ( \and( sep( #hole { Heap }
                                                                   , CTXLHS
                                                                   )
                                                              , CTXLCONSTRAINTS
                                                              )
                                                        )
                                                       => #moveHoleToFront(#flattenAssoc(
                                                            #liftConstraints( \and( sep( #hole { Heap }
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
       <k> right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) => noop ... </k>
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

  rule <k> right-unfold-Nth (M,N) => fail ... </k>
    requires (M <Int 0) orBool (N <Int 0)

  rule <k> right-unfold-Nth (M,N)
               => right-unfold-Nth-eachRRP(M, N, getUnfoldables(RHS))
                  ...
       </k>
       <claim> \implies(LHS,\exists {_ } \and(RHS)) </claim>

  rule <k> right-unfold-Nth-eachRRP(M, N, RRPs) => fail ... </k>
    requires getLength(RRPs) <=Int M

  rule <k> right-unfold-Nth-eachRRP(M, N, RRPs:Patterns)
               => right-unfold-Nth-eachBody(M, N, getMember(M, RRPs), unfold(getMember(M, RRPs)))
                  ...
       </k>
    requires getLength(RRPs) >Int M

  rule <k> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => fail
                  ...
       </k>
    requires getLength(Bodies) <=Int N

  rule <k> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => right-unfold-Nth-oneBody(M, N, RRP, getMember(N, Bodies))
                  ...
       </k>
    requires getLength(Bodies) >Int N

  rule <k> right-unfold-Nth-oneBody(M, N, RRP, Body)
               => right-unfold-oneBody(RRP, Body)
                  ...
       </k>
```

```k
endmodule
```

