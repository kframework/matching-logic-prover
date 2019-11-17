### Search Bound

The `search-bound` strategy peforms a bounded depth-first search for a proof, applying
`direct-proof`, `kt` and `right-unfold` strategies in turn.

```k
module STRATEGY-SEARCH-BOUND
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy> search-fol(bound: 0) => fail </strategy>
  rule <strategy> search-fol(bound: N)
               => normalize . simplify
                . ( ( instantiate-existentials . smt-cvc4 )
                  | (kt           . search-fol(bound: N -Int 1))
                  | (right-unfold . search-fol(bound: N -Int 1))
                  )
                  ...
       </strategy>
    requires N >Int 0

  rule <strategy> search-sl(kt-bound: 0, unfold-bound: UNFOLDBOUND) => fail ... </strategy>
  rule <strategy> search-sl(kt-bound: KTBOUND, unfold-bound: UNFOLDBOUND)
               => normalize . or-split-rhs
                . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
                    . ( right-unfold-all(bound: UNFOLDBOUND) )
                    . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                    . match . spatial-patterns-equal . smt-cvc4
                    )
                  | ( kt . search-sl(kt-bound: KTBOUND -Int 1, unfold-bound: UNFOLDBOUND) )
                  )
                  ...
       </strategy>
    requires KTBOUND >Int 0

endmodule
```

