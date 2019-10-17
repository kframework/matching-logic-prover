```k
requires "kore.k"
requires "smtlib-to-kore.k"
requires "strategies/core.k"
requires "strategies/knaster-tarski.k"
requires "strategies/matching.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/unfolding.k"
```

Configuration
=============

The configuration consists of a assoc-commutative bag of goals. Only goals
marked `<active>` are executed to control the non-determinism in the system. The
`<claim>` cell contains the Matching Logic Pattern for which we are searching for a
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
        <k> $PGM:Pgm </k>
        <goals>
          <goal multiplicity="*" type="Set" format="%1%i%n%2, %3, %4%n%5%n%6%n%7%n%d%8">
            <active format="active: %2"> true:Bool </active>
            <id format="id: %2"> root </id>
            <parent format="parent: %2"> .K </parent>
            <claim> .K </claim>
            <strategy> .K </strategy>
            <trace> .K </trace>
          </goal>
        </goals>
        <declarations>
          <declaration multiplicity="*" type="Set">  .K </declaration>
        </declarations>
      </prover>
endmodule
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

module PROVER-SYNTAX
  imports PROVER-COMMON
  imports TOKENS-SYNTAX
  imports SMTLIB2-SYNTAX
  imports SMTLIB-SL
  syntax Declarations ::= "" [klabel(.Declarations)]
endmodule
```

```k
module PROVER-DRIVER
  imports PROVER-COMMON
  imports PROVER-CORE
  imports K-IO

  syntax Declarations ::= ".Declarations" [klabel(.Declarations)]

  // K changes directory to "REPODIR/.krun-TIMESTAMP"
  rule <k> imports FILE:String
        => #system("kast --directory ../.build/defn/prover '../" +String FILE +String "'")
           ...
       </k>
  rule <k> #systemResult(0, KAST_STRING, STDERR) => #parseKAST(KAST_STRING) ... </k>

  rule <k> (D:Declaration Ds:Declarations)
        => (D ~> Ds)
           ...
       </k>
  rule <k> .Declarations => .K ... </k>

  rule <k> (symbol _ ( _ ) : _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>

  rule <k> (sort _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>

  rule <k> (axiom _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>
  rule <k> claim PATTERN
           strategy STRAT
        => .K
           ...
       </k>
       <goals>
         ( .Bag =>
           <goal>
             <id> root </id>
             <active> true:Bool </active>
             <parent> .K </parent>
             <claim> PATTERN </claim>
             <strategy> STRAT </strategy>
             <trace> .K </trace>
           </goal>
         )
         ...
       </goals>
```

Normalize ImplicativeForms:

```k
  rule <claim> \implies(LHS, \and(RHS) => \exists { .Patterns } \and(RHS)) </claim>
```

```k
endmodule
```

Main Modules
============

```k
module PROVER
  imports PROVER-DRIVER
  imports SMTLIB-TO-KORE
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-MATCHING
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI
endmodule
```

