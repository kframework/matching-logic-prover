### Search Bound

The `search-bound` strategy peforms a bounded depth-first search for a proof, applying
`direct-proof`, `kt` and `right-unfold` strategies in turn.

```k
module STRATEGY-SEARCH-BOUND
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX

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

  rule <strategy> search-sl(bound: 0) => fail </strategy>
  rule <strategy> search-sl(bound: N)
               => normalize . or-split-rhs
                . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
                    . ( right-unfold-or-match { N } )
                    . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
                    . match . spatial-patterns-equal . smt-cvc4
                    )
                  | ( kt . search-sl(bound: N -Int 1) )
                  )
                  ...
       </strategy>
    requires N >Int 0

  syntax Strategy ::= "right-unfold-or-match" [function]
  rule right-unfold-or-match
    => normalize . or-split-rhs
     . lift-constraints . instantiate-existentials . substitute-equals-for-equals
     . ( ( match . spatial-patterns-equal . smt-cvc4 )
       | ( right-unfold )
       )
endmodule
```

