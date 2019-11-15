```k
requires "lang/kore-lang.k"
requires "drivers/smt-driver.k"
requires "drivers/kore-driver.k"
requires "drivers/base.k"
requires "strategies/core.k"
requires "strategies/knaster-tarski.k"
requires "strategies/matching.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/unfolding.k"
```

Strategies for the Horn Clause fragment
=======================================

```k
module STRATEGIES-EXPORTED-SYNTAX
  imports INT-SYNTAX
  imports KORE

  syntax Strategy ::= "search-fol" "(" "bound" ":" Int ")" | "search-sl" "(" "bound" ":" Int ")"
                    | "remove-lhs-existential" | "normalize" | "lift-or"
                    | "simplify" | "instantiate-existentials" | "substitute-equals-for-equals"
                    | "lift-constraints"
                    | "direct-proof"
                    | "check-lhs-constraint-unsat"
                    | "smt" | "smt-z3" | "smt-cvc4" | "smt-debug"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")" | "right-unfold" "(" Symbol ")"
                    | "kt"     | "kt"     "#" KTFilter
                    | "kt-gfp" | "kt-gfp" "#" KTFilter
                    | "kt-solve-implications" "(" Strategy ")"
                    | "instantiate-universals-with-ground-terms"
                    | "instantiate-separation-logic-axioms"
                    | "spatial-patterns-equal"
                    | "match"
                    | "unfold-mut-recs"

  syntax KTFilter ::= head(Symbol)
                    | index(Int)
                    | ".KTFilter"
endmodule
```
