```k
module PROVER-HORN-CLAUSE
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
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

  rule <k> \implies(\and(LHS), RHS)
        => \implies(\and((LHS -Patterns (LRP, .Patterns)) ++Patterns BODY), RHS)
       </k>
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
               => left-unfold-Nth-eachLRP(M, getPredicates(LHS))
                  ...
       </strategy>
       <k> \implies(\and(LHS), RHS) </k>

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
               => right-unfold-eachRRP(getPredicates(RHS))
                  ...
       </strategy>
       <k> \implies(LHS, \exists { _ } \and(RHS)) </k>
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
  rule <k> \implies(LHS, \exists { E1 } \and(RHS))
        => \implies(LHS, \exists { E1 ++Patterns E2 }
                         \and((RHS -Patterns (RRP, .Patterns)) ++Patterns BODY))
       </k>
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
               => right-unfold-Nth-eachRRP(M, N, getPredicates(RHS))
                  ...
       </strategy>
       <k> \implies(LHS,\exists {_ } \and(RHS)) </k>

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

