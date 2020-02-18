```k
requires "lang/kore-lang.k"
requires "drivers/smt-driver.k"
requires "drivers/kore-driver.k"
requires "drivers/base.k"
requires "strategies/apply-equation.k"
requires "strategies/core.k"
requires "strategies/duplicate.k"
requires "strategies/instantiate-universals.k"
requires "strategies/intros.k"
requires "strategies/knaster-tarski.k"
requires "strategies/matching.k"
requires "strategies/search-bound.k"
requires "strategies/simple-sort-check.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/reflexivity.k"
requires "strategies/replace-evar-with-func-constant.k"
requires "strategies/unfolding.k"
requires "utils/instantiate-assumptions.k"
requires "utils/heatcool.k"
requires "utils/load-named.k"
requires "utils/sort-checking.k"
requires "utils/syntactic-match.k"
requires "utils/visitor.k"
```

Strategies for the Horn Clause fragment
=======================================

```k
module STRATEGIES-EXPORTED-SYNTAX
  imports INT-SYNTAX
  imports KORE
  imports LIST

  syntax Strategy ::= "search-fol" "(" "bound" ":" Int ")"
                    | "search-sl" "(" "kt-bound" ":" Int "," "unfold-bound" ":" Int ")"
                    | "reflexivity"
                    | "alternate-search-sl" "(" "kt-bound" ":" Int "," "unfold-bound" ":" Int ")"
                    | "kt-unfold-search-sl" "(" "kt-bound" ":" Int "," "unfold-bound" ":" Int ")"
                    | "remove-lhs-existential" | "normalize" | "lift-or" | "purify" | "abstract"
                    | "simplify" | "instantiate-existentials" | "substitute-equals-for-equals"
                    | "lift-constraints"
                    | "direct-proof"
                    | "check-lhs-constraint-unsat"
                    | "smt" | "smt-z3" | "smt-cvc4" | "smt-debug"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")" | "right-unfold" "(" Symbol ")"
                    | "right-unfold-all"  "(" "bound" ":" Int ")"
                    | "right-unfold-all"  "(" "symbols" ":" Patterns "," "bound" ":" Int ")"
                    | "right-unfold-perm" "(" "permutations" ":" List "," "bound" ":" Int ")"
                    | "right-unfold"      "(" "symbols" ":" Patterns "," "bound" ":" Int ")"
                    | "kt"     | "kt"     "#" KTFilter
                    | "kt-unf" | "kt-unf" "#" KTFilter
                    | "kt-gfp" | "kt-gfp" "#" KTFilter
                    | "kt-solve-implications" "(" Strategy ")"
                    | "instantiate-universals-with-ground-terms"
                    | "instantiate-separation-logic-axioms"
                    | "spatial-patterns-equal"
                    | "match" | "match-pto"
                    | "frame"
                    | "unfold-mut-recs"
                    | "apply-equation"
                        RewriteDirection AxiomOrClaimName
                        "at" Int "by" "[" Strategies "]"
                    | "intros" AxiomName
                    | "replace-evar-with-func-constant" Variables
                    | "duplicate" AxiomOrClaimName "as" AxiomName
                    | "instantiate-universals" "("
                        "in:" AxiomName ","
                        "vars:" VariableNames ","
                        "with:" Patterns ")"
                    | "simple-sort-check"

  syntax RewriteDirection ::= "->" | "<-"

  syntax Strategies ::= List{Strategy, ","}                        [klabel(Strategies)]
  syntax Variables ::= List{Variable, ","}                 [klabel(Variables)]
  syntax VariableNames ::= List{VariableName, ","}                 [klabel(VariableNames)]


  syntax KTFilter ::= head(Symbol)
                    | index(Int)
                    | ".KTFilter"
endmodule
```
