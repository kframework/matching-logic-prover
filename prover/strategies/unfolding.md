```k
module STRATEGY-UNFOLDING
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS

  syntax Bool ::= isUnfoldable(Symbol) [function]
  rule [[ isUnfoldable(S:Symbol) => true ]]
       <declaration> axiom \forall {_} \iff-lfp(S(_), _) </declaration>
  rule isUnfoldable(S:Symbol) => false [owise]

  syntax Pattern ::= unfold(Pattern) [function]
  rule [[ unfold(S:Symbol(ARGs)) => alphaRename(substMap(DEF, zip(Vs, ARGs))) ]]
       <declaration> axiom \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs ==K .Patterns
  rule [[ unfold(S:Symbol(ARGs)) => {("ifflfp axiom has free variables!" ~> S ~> (getFreeVariables(DEF) -Patterns Vs))}:>Pattern ]]
       <declaration> axiom \forall { Vs } \iff-lfp(S(Vs), DEF) </declaration>
    requires getFreeVariables(DEF) -Patterns Vs =/=K .Patterns

  syntax SymbolDeclaration ::= getSymbolDeclaration(Symbol) [function]
  rule [[ getSymbolDeclaration(S) => DECL ]]
       <declaration> symbol S (_) : _ #as DECL </declaration>

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
  rule getUnfoldables(I:Int, REST)
    => getUnfoldables(REST)
  rule getUnfoldables(V:Variable, REST)
    => getUnfoldables(REST)
  rule getUnfoldables(\not(Ps), REST)
    => getUnfoldables(Ps) ++Patterns getUnfoldables(REST)
  rule getUnfoldables(\and(Ps), REST)
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
  rule <strategy> right-unfold
               => right-unfold-eachRRP(getUnfoldables(RHS))
                  ...
       </strategy>
       <claim> \implies(LHS, \exists { _ } \and(RHS)) </claim>
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

```k
  rule <claim> \implies(LHS, \exists { E1 } \and(RHS))
        => \implies(LHS, \exists { E1 ++Patterns E2 }
                         \and((RHS -Patterns (RRP, .Patterns)) ++Patterns BODY))
       </claim>
       <strategy> right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) => noop ... </strategy>
       <trace> .K => right-unfold-oneBody(RRP, \exists { E2 } \and(BODY)) ... </trace>
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

