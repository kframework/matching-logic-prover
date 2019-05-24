```k
module PROVER-HORN-CLAUSE
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
```

### Left Unfold (incomplete)

```k
  syntax Strategy ::= "left-unfold-eachBody"  "(" BasicPattern "," DisjunctiveForm ")"
                    | "left-unfold-oneBody"   "(" BasicPattern "," ConjunctiveForm ")"

  rule <strategy> left-unfold-eachBody(LRP, \or(\and(BODY), BODIES:ConjunctiveForms))
               => left-unfold-oneBody(LRP, \and(BODY))
                & left-unfold-eachBody(LRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> left-unfold-eachBody(LRP, \or(.ConjunctiveForms))
               => success
                  ...
       </strategy>

  rule <k> \implies(\and(LHS), RHS)
        => \implies(\and((LHS -BasicPatterns (LRP, .Patterns)) ++BasicPatterns BODY), RHS)
       </k>
       <strategy> left-unfold-oneBody(LRP, \and(BODY)) => noop ... </strategy>
       <trace> .K => left-unfold-oneBody(LRP, \and(BODY)) ... </trace>
```

### Left Unfold Nth

Unfold the Nth predicates on the Left hand side into a conjunction of
implicatations. The resulting goals are equivalent to the initial goal.

```k
  syntax Strategy ::= "left-unfold-Nth-eachLRP"  "(" Int "," BasicPatterns ")"
                    | "left-unfold-Nth-eachBody" "(" Int "," BasicPattern "," DisjunctiveForm ")"
                    | "left-unfold-Nth-oneBody"  "(" Int "," BasicPattern "," ConjunctiveForm ")"

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
  syntax Strategy ::= "right-unfold-eachRRP" "(" BasicPatterns")"
                    | "right-unfold-eachBody" "(" BasicPattern "," DisjunctiveForm ")"
                    | "right-unfold-oneBody"  "(" BasicPattern "," ConjunctiveForm ")"
  rule <strategy> right-unfold
               => right-unfold-eachRRP(getPredicates(RHS))
                  ...
       </strategy>
       <k> \implies(LHS, \and(RHS)) </k>
  rule <strategy> right-unfold-eachRRP(P, PS)
               => right-unfold-eachBody(P, unfold(P))
                | right-unfold-eachRRP(PS)
                  ...
       </strategy>
  rule <strategy> right-unfold-eachRRP(.Patterns)
               => fail
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(\and(BODY), BODIES:ConjunctiveForms))
               => right-unfold-oneBody(RRP, \and(BODY))
                | right-unfold-eachBody(RRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(.ConjunctiveForms))
               => fail
                  ...
       </strategy>
```

```k
  rule <k> \implies(LHS, \and(RHS))
        => \implies(LHS, \and((RHS -BasicPatterns (RRP, .Patterns)) ++BasicPatterns BODY))
       </k>
       <strategy> right-unfold-oneBody(RRP, \and(BODY)) => noop ... </strategy>
       <trace> .K => right-unfold-oneBody(RRP, \and(BODY)) ... </trace>
```

### Right-Unfold-Nth

Often, when debugging a proof, the user knows which predicate needs to be
unfolded. Here we define a strategy `right-unfold-Nth(M, N)`, which unfolds the
`M`th recursive predicate (on the right-hand side) to its `N`th body. When `M`
or `N` is out of range, `right-unfold(M,N) => fail`.

```k
  syntax Strategy ::= "right-unfold-Nth-eachRRP"  "(" Int "," Int "," BasicPatterns")"
                    | "right-unfold-Nth-eachBody" "(" Int "," Int "," BasicPattern "," DisjunctiveForm ")"
                    | "right-unfold-Nth-oneBody"  "(" Int "," Int "," BasicPattern "," ConjunctiveForm ")"

  rule <strategy> right-unfold-Nth (M,N) => fail ... </strategy>
  requires (M <Int 0) orBool (N <Int 0)

  rule <strategy> right-unfold-Nth (M,N)
               => right-unfold-Nth-eachRRP(M, N, getPredicates(RHS))
       ...</strategy>
       <k> \implies(LHS,\and(RHS)) </k>

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs) => fail ... </strategy>
    requires getLength(RRPs) <=Int M

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs:BasicPatterns)
               => right-unfold-Nth-eachBody(M, N, getMember(M, RRPs), unfold(getMember(M, RRPs)))
       ...</strategy>
    requires getLength(RRPs) >Int M

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => fail
       ...</strategy>
    requires getLength(Bodies) <=Int N

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies:ConjunctiveForms))
               => right-unfold-Nth-oneBody(M, N, RRP, getMember(N, Bodies))
       ...</strategy>
    requires getLength(Bodies) >Int N

  rule <strategy> right-unfold-Nth-oneBody(M, N, RRP, Body)
               => right-unfold-oneBody(RRP, Body) ...
       </strategy>
```

```k
endmodule
```

