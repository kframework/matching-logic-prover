```k
requires "lang/kore-lang.k"
requires "drivers/smt-driver.k"
requires "drivers/kore-driver.k"
requires "drivers/configuration.k"
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
module PROVER-HORN-CLAUSE-SYNTAX
  imports INT-SYNTAX
  imports KORE-SUGAR

  syntax Strategy ::= "search-fol" "(" "bound" ":" Int ")" | "search-sl" "(" "bound" ":" Int ")"
                    | "remove-lhs-existential" | "normalize" | "smtlib-to-implication" | "lift-or"
                    | "simplify" | "instantiate-existentials" | "substitute-equals-for-equals"
                    | "lift-constraints"
                    | "direct-proof"
                    | "smt" | "smt-z3" | "smt-cvc4" | "smt-debug"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")"
                    | "kt"     | "kt"     "#" KTFilter
                    | "kt-gfp" | "kt-gfp" "#" KTFilter
                    | "kt-solve-implications" "(" Strategy ")"
                    | "instantiate-universals-with-ground-terms"
                    | "instantiate-separation-logic-axioms"
                    | "spatial-patterns-equal"
                    | "match" 

  syntax KTFilter ::= head(Symbol)
                    | index(Int)
                    | ".KTFilter"
endmodule
```

Driver & Syntax
===============

The driver is responsible for loading prover files into the configuration.

```k
module PROVER-COMMON
  imports PROVER-CORE-SYNTAX
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports SMTLIB2
  imports KORE-SUGAR

  syntax Pgm ::= SMTLIB2Script
               | Declarations
  syntax Declarations ::= Declaration Declarations
endmodule

module PROVER-COMMON-SYNTAX
  imports KORE-DRIVER
  imports TOKENS-SYNTAX
  syntax Declarations ::= "" [klabel(.Declarations)]
endmodule
```

Main Modules
============

```k
module PROVER
  imports KORE-DRIVER
  imports SMT-DRIVER
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-MATCHING
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI
endmodule
```

