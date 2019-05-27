### Search Bound

The `search-bound` strategy peforms a bounded depth-first search for a proof, applying
`direct-proof`, `kt` and `right-unfold` strategies in turn.

```k
module STRATEGY-SEARCH-BOUND
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX

  rule <strategy> search-bound(0) => fail </strategy>
  rule <strategy> search-bound(N)
               => simplify ; ( ( instantiate-existentials ; smt )
                             | (kt           ; search-bound(N -Int 1))
                             | (right-unfold ; search-bound(N -Int 1))
                             )
                  ...
       </strategy>
    requires N >Int 0
endmodule
```

