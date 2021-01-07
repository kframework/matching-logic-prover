```k
requires "lang/kore-lang.k"
requires "drivers/smt-driver.k"
requires "drivers/kore-driver.k"
requires "drivers/base.k"
requires "strategies/apply.k"
requires "strategies/apply-equation.k"
requires "strategies/core.k"
requires "strategies/duplicate.k"
requires "strategies/instantiate-universals.k"
requires "strategies/inst-exists.k"
requires "strategies/intros.k"
requires "strategies/knaster-tarski.k"
requires "strategies/matching.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/reflexivity.k"
requires "strategies/replace-evar-with-func-constant.k"
requires "strategies/unfolding.k"
requires "utils/error.k"
requires "utils/instantiate-assumptions.k"
requires "utils/heatcool.k"
requires "utils/load-named.k"
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
                    | "canonicalize" | "remove-lhs-existential" | "normalize" | "lift-or"
                    | "simplify" | "substitute-equals-for-equals"
                    | "instantiate-existentials"
                    | "lift-constraints"
                    | "direct-proof"
                    | "check-lhs-constraint-unsat" | "check-lhs-constraint-unsat-debug"
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
                    | "instantiate-separation-logic-axioms" | "pto-is-injective"
                    | "spatial-patterns-equal"
                    | "spatial-patterns-match"
                    | "match" | "match-debug" | "match-pto"
                    | "frame"
                    | "footprint-analysis" | "nullity-analysis" "(" Strategy ")"
                    | "remove-constraints"
                    | "unfold-mut-recs"
                    | "apply-equation"
                        RewriteDirection AxiomOrClaimName
                        "at" Int "by" "[" Strategies "]"
                    | "apply-equation"
                      "(" "eq:" Pattern
                      "," "idx:" Int
                      "," "direction:" RewriteDirection
                      "," "at:" Int
                      ")"
                    | "intros" AxiomName
                    | "replace-evar-with-func-constant" Variables
                    | "duplicate" AxiomOrClaimName "as" AxiomName
                    | "instantiate-universals" "("
                        "in:" AxiomName ","
                        "vars:" VariableNames ","
                        "with:" Patterns ")"
                    // Proves the current goal using the conclusion
                    // of the axiom or claim given as the first arg.
                    // Uses the strategy given in second argument
                    // to discharge the axiom's premises.
                    | "apply" "(" AxiomOrClaimName
                              "," Strategy ")"
                    | "inst-exists" "(" Variable "," Pattern
                                    "," Strategy ")"
                    | "universal-generalization"
                    | "propagate-exists-through-application" Int
                    | "propagate-predicate-through-application" "(" Pattern "," Int ")"
                    | "propagate-conjunct-through-exists" "(" Int "," Int ")"

  syntax Strategy ::= "kt-wrap" "(" "head:" Symbol ")"
                    | "kt-wrap" "(" Pattern ")" | "kt-unwrap"
                    | "kt-forall-intro" | "kt-forall-elim"
                    | "kt-unfold"
                    | "with-each-implication-context" "(" Strategy ")" | "normalize-implication-context" | "kt-collapse"

                    | "instantiate-rhs" "(" Variable "," Pattern ")"
                    | "instantiate-context" "(" Variable "," Pattern ")"
                    
                    | "context-destructure" "(" "head:" Symbol ")"
                    | "context-case-analysis"

                    | "instantiate-existentials-implication-context"  | "imp-ctx-unfold" // TODO: These strategies should be in terms of `instantiate-existentials` and `right-unfold`

                    | "kt-abstract" "(" Symbol ")" | "kt-abstract-full" "(" Symbol ")"
                    | "kt-abstract-refine" | "kt-abstract-finalize" "(" Symbol ")"


  syntax RewriteDirection ::= "->" | "<-"

  syntax Strategies ::= List{Strategy, ","}                        [klabel(Strategies)]
  syntax Variables ::= List{Variable, ","}                 [klabel(Variables)]
  syntax VariableNames ::= List{VariableName, ","}                 [klabel(VariableNames)]


  syntax KTFilter ::= head(Symbol)
                    | index(Int)
                    | ".KTFilter"
endmodule
```
