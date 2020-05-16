### Search Bound

The `search-bound` strategy peforms a bounded depth-first search for a proof, applying
`direct-proof`, `kt` and `right-unfold` strategies in turn.

```k
module STRATEGY-SEARCH-BOUND
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <k> search-fol(bound: 0) => fail </k>
  rule <k> search-fol(bound: N)
               => normalize . simplify
                . ( ( instantiate-existentials . smt-cvc4 )
                  | (kt           . search-fol(bound: N -Int 1))
                  | (right-unfold . search-fol(bound: N -Int 1))
                  )
                  ...
       </k>
    requires N >Int 0

  rule <k> search-sl(kt-bound: 0, unfold-bound: UNFOLDBOUND) => fail ... </k>
  rule <k> search-sl(kt-bound: KTBOUND, unfold-bound: UNFOLDBOUND)
        => remove-lhs-existential . normalize . or-split-rhs
         . lift-constraints . instantiate-existentials . substitute-equals-for-equals
         . check-lhs-constraint-unsat
         . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
             . ( right-unfold-all(bound: UNFOLDBOUND) )
             . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
             )
           | ( kt . search-sl(kt-bound: KTBOUND -Int 1, unfold-bound: UNFOLDBOUND) )
           )
           ...
       </k>
    requires KTBOUND >Int 0

  rule <k> alternate-search-sl(kt-bound: 0, unfold-bound: UNFOLDBOUND) => fail ... </k>
  rule <k> alternate-search-sl(kt-bound: KTBOUND, unfold-bound: UNFOLDBOUND)
        => remove-lhs-existential . normalize . or-split-rhs
         . lift-constraints . instantiate-existentials . substitute-equals-for-equals
         . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
             . ( right-unfold { UNFOLDBOUND } )
             . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
             )
           | ( kt . alternate-search-sl(kt-bound: KTBOUND -Int 1, unfold-bound: UNFOLDBOUND) )
           )
           ...
       </k>
    requires KTBOUND >Int 0

  rule <k> kt-unfold-search-sl(kt-bound: 0, unfold-bound: UNFOLDBOUND) => fail ... </k>
  rule <k> kt-unfold-search-sl(kt-bound: KTBOUND, unfold-bound: UNFOLDBOUND)
        => remove-lhs-existential . normalize . or-split-rhs
         . lift-constraints . instantiate-existentials . substitute-equals-for-equals
         . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
             . ( right-unfold-all(bound: UNFOLDBOUND) )
             . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
             )
           | ( kt-unf . kt-unfold-search-sl(kt-bound: KTBOUND -Int 1, unfold-bound: UNFOLDBOUND) )
           )
           ...
       </k>
    requires KTBOUND >Int 0

endmodule
```

