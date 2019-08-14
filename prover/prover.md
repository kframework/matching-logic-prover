```k
requires "kore.k"
requires "predicate-definitions.k"
requires "strategies/core.k"
requires "strategies/knaster-tarski.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/unfolding.k"
```

Configuration
=============

The configuration consists of a assoc-commutative bag of goals. Only goals
marked `<active>` are executed to control the non-determinism in the system. The
`<k>` cell contains the Matching Logic Pattern for which we are searching for a
proof. The `<strategy>` cell contains an imperative language that controls which
(high-level) proof rules are used to complete the goal. The `<trace>` cell
stores a log of the strategies used in the search of a proof and other debug
information. Eventually, this could be used for constructing a proof object.

```k
module PROVER-CONFIGURATION
  imports KORE-SUGAR
  imports DOMAINS-SYNTAX

  syntax Pgm
  syntax Strategy

  syntax GoalId ::= "root" | Int

  configuration
      <prover>
        <goal multiplicity="*" type="Set">
          <id> root </id>
          <active> true:Bool </active>
          <parent> .K </parent>
          <k> $PGM </k>
          <strategy> .K </strategy>
          <trace> .K </trace>
        </goal>
      </prover>
endmodule
```

Strategies for the Horn Clause fragment
=======================================

```k
module PROVER-HORN-CLAUSE-SYNTAX
  imports INT-SYNTAX
  imports KORE-SUGAR
  imports PREDICATE-DEFINITIONS

  syntax Strategy ::= "search-bound" "(" Int ")"
                    | "remove-lhs-existential" | "normalize" | "lift-or"
                    | "simplify" | "instantiate-existentials" | "substitute-equals-for-equals"
                    | "direct-proof"
                    | "smt" | "smt-z3" | "smt-cvc4" | "smt-debug"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")"
                    | "kt"     | "kt"     "#" KTFilter "#" KTInstantiate
                    | "kt-gfp" | "kt-gfp" "#" KTFilter "#" KTInstantiate
  syntax Strategy ::= "kt-solve-implications" "(" Strategy ")"
                    | "instantiate-aux"

  syntax KTFilter ::= head(RecursivePredicate)
                    | index(Int)
                    | ".KTFilter"
  syntax KTInstantiate ::= "useAffectedHeuristic"
                         | freshPositions(Ints)
endmodule
```

Driver & Syntax
===============

The driver is responsible for loading prover files into the configuration.

```k
module PROVER-SYNTAX
  imports PROVER-CORE-SYNTAX
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-SUGAR
  syntax Pgm ::= "claim" Pattern
                 "strategy" Strategy
endmodule
```

```k
module PROVER-DRIVER
  imports PROVER-SYNTAX
  imports PROVER-CORE

  rule <k> claim PATTERN
           strategy STRAT
        => PATTERN
       </k>
       <strategy> _ => STRAT </strategy>
```

Normalize ImplicativeForms:

```k
  rule <k> \implies(LHS, \and(RHS) => \exists { .Patterns } \and(RHS)) </k>
```

```k
endmodule
```

Main Modules
============

```k
module PROVER
  imports PROVER-DRIVER
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI
endmodule
```

