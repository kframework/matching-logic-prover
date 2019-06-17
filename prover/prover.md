```k
requires "predicate-definitions.k"
requires "strategies/core.k"
requires "strategies/knaster-tarski.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/unfolding.k"
```

Kore Sugar
==========

```k
module KORE-SUGAR
  imports INT-SYNTAX
  imports STRING-SYNTAX
  syntax Ints ::= List{Int, ","}

  syntax Sort ::= "Bool"        [token]
                | "Int"         [token]
                | "ArrayIntInt" [token]
                | "SetInt"         [token]
```

We allow two "variaties" of variables: the first, identified by a String, is for
use in defining claims; the second, identified by a String and an Int subscript
is to be used for generating fresh variables. *The second variety must be used
only in this scenario*.

```k
  syntax Variable ::= "variable" "(" String ")"         "{" Sort "}"
                    | "variable" "(" String "," Int ")" "{" Sort "}"
  syntax Pattern ::= Int
                   | Variable
                   | Symbol
                   | Symbol "(" Patterns ")"                    [klabel(\apply)]

                   | "\\top"    "(" ")"                         [klabel(\top)]
                   | "\\bottom" "(" ")"                         [klabel(\bottom)]
                   | "\\equals" "(" Pattern "," Pattern ")"     [klabel(\equals)]
                   | "\\not"    "(" Pattern ")"                 [klabel(\not)]

                   | "\\and"    "(" Patterns ")"                [klabel(\and)]
                   | "\\or"     "(" Patterns ")"                [klabel(\or)]
                   | "\\implies" "(" Pattern "," Pattern ")"    [klabel(\implies)]

                   | "\\exists" "{" Patterns "}" Pattern        [klabel(\exists)]
                   | "\\forall" "{" Patterns "}" Pattern        [klabel(\forall)]
                   

  syntax Symbol ::= "emptyset"
  syntax Symbol ::= "singleton"
  syntax Symbol ::= "plus"| "minus"| "mult"| "div"| "gt"| "max" // Arith
                  | "union" | "disjoint" | "disjointUnion" | "isMember" | "add" | "del" // Sets
                  | "select" // Arrays
  syntax Symbol ::= "store"
  syntax Symbol ::= Predicate
  syntax RecursivePredicate
  syntax Predicate ::= RecursivePredicate

  syntax Patterns ::= List{Pattern, ","}                        [klabel(Patterns)]
  syntax Sorts ::= List{Sort, ","}                              [klabel(Sorts)]

  syntax SymbolDeclaration ::= "symbol" Symbol "{" "}" "(" Sorts ")" ":" Sort
endmodule
```

Kore Helpers
============

Here we define helpers for manipulating Kore formulae.

```k
module KORE-HELPERS
  imports KORE-SUGAR
  imports MAP
  imports INT

  syntax String ::= SortToString(Sort) [function, functional, hook(STRING.token2string)]

  syntax Bool ::= Pattern "in" Patterns [function]
  rule P in (P,  P1s) => true
  rule P in (P1, P1s) => P in P1s requires P =/=K P1
  rule P in .Patterns => false

  syntax Patterns ::= Patterns "++Patterns" Patterns [function, right]
  rule (P1, P1s) ++Patterns P2s => P1, (P1s ++Patterns P2s)
  rule .Patterns ++Patterns P2s => P2s

  syntax Patterns ::= removeDuplicates(Patterns) [function]
  rule removeDuplicates(.Patterns) => .Patterns
  rule removeDuplicates(P, Ps) => P, removeDuplicates(Ps)
  requires notBool(P in Ps)
  rule removeDuplicates(P, Ps) => removeDuplicates(Ps)
    requires P in Ps

  syntax Patterns ::= Patterns "-Patterns" Patterns [function]
  rule (P1, P1s) -Patterns P2s => P1, (P1s -Patterns P2s)
    requires notBool(P1 in P2s)
  rule (P1, P1s) -Patterns P2s =>      (P1s -Patterns P2s)
    requires P1 in P2s
  rule .Patterns -Patterns P2s => .Patterns
  rule P1s -Patterns .Patterns => P1s
```

```k
  syntax Patterns ::= getFreeVariables(Patterns) [function]
  rule getFreeVariables(.Patterns) => .Patterns
  rule getFreeVariables(P, Ps)
    => removeDuplicates(getFreeVariables(P, .Patterns) ++Patterns getFreeVariables(Ps))
    requires Ps =/=K .Patterns

  rule getFreeVariables(N:Int, .Patterns) => .Patterns
  rule getFreeVariables(X:Variable, .Patterns) => X, .Patterns
  rule getFreeVariables(S:Symbol, .Patterns) => .Patterns
  rule getFreeVariables(S:Symbol(ARGS) , .Patterns) => getFreeVariables(ARGS)

  rule getFreeVariables(\top(), .Patterns) => .Patterns
  rule getFreeVariables(\bottom(), .Patterns) => .Patterns
  rule getFreeVariables(\equals(P1, P2), .Patterns) => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(\not(P), .Patterns) => getFreeVariables(P, .Patterns)

  rule getFreeVariables(\implies(LHS, RHS), .Patterns) => getFreeVariables(LHS, RHS, .Patterns)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\or(Ps),  .Patterns) => getFreeVariables(Ps)

  rule getFreeVariables(\exists { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs
  rule getFreeVariables(\forall { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs

// TODO: These seem specific to implication. Perhaps they need better names?
  syntax Patterns ::= getUniversalVariables(Pattern) [function]
  rule getUniversalVariables(GOAL) => getFreeVariables(GOAL, .Patterns)
  syntax Patterns ::= getExistentialVariables(Pattern) [function]
  rule getExistentialVariables(\implies(\and(LHS), \exists { EXISTENTIALS } \and(RHS)) #as GOAL)
    => EXISTENTIALS
```

Filters a list of patterns, returning the ones that are applications of the symbol:

```k
  syntax Patterns ::= filterByConstructor(Patterns, Symbol) [function]
  rule filterByConstructor(.Patterns, S) => .Patterns
  rule filterByConstructor((P:Symbol (Ps) , Rest), P)
    => (P:Symbol (Ps)), filterByConstructor(Rest, P)
  rule filterByConstructor((Q:Symbol (Qs) , Rest), P)
    => filterByConstructor(Rest, P)
    requires P =/=K Q
  rule filterByConstructor((Q, Rest), P) => filterByConstructor(Rest, P) [owise]
```

zip: Take two lists and return a map. This can be used to take a list of variables
and values, passed to K's substitute.

```k
  syntax Map ::= zip(Patterns, Patterns) [function]
  rule zip((L, Ls), (R, Rs)) => (L |-> R) zip(Ls, Rs)
  rule zip(.Patterns, .Patterns) => .Map

  syntax Map ::= removeIdentityMappings(Map) [function]
  rule removeIdentityMappings((L |-> R) REST) =>           removeIdentityMappings(REST)
    requires L ==K R
  rule removeIdentityMappings((L |-> R) REST) => (L |-> R) removeIdentityMappings(REST)
    requires L =/=K R
  rule removeIdentityMappings(.Map) => .Map
```

```k
  syntax Map ::= makeFreshSubstitution(Patterns) [function] // Variables
  rule makeFreshSubstitution(variable(N) { SORT }, REST)
    => variable(N) { SORT } |-> variable(N, !I:Int) { SORT }
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(variable(N, J) { SORT }, REST)
    => variable(N, J) { SORT } |-> variable(N, !I:Int) { SORT }
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(.Patterns)
    => .Map
```

```k
  syntax Patterns ::= getLeftRecursivePredicates(Pattern) [function]
  rule getLeftRecursivePredicates(\implies(\and(LHS), RHS)) => getRecursivePredicates(LHS)
```

```k
  syntax Patterns ::= getRecursivePredicates(Patterns)   [function]
  rule getRecursivePredicates(.Patterns) => .Patterns
  rule getRecursivePredicates(R:RecursivePredicate(ARGS), REST)
    => R(ARGS), getRecursivePredicates(REST)
  rule getRecursivePredicates(S:Symbol, REST)
    => getRecursivePredicates(REST)
    requires notBool isRecursivePredicate(S)
  rule getRecursivePredicates(S:Symbol(ARGS), REST)
    => getRecursivePredicates(REST)
    requires notBool isRecursivePredicate(S)
  rule getRecursivePredicates(I:Int, REST)
    => getRecursivePredicates(REST)
  rule getRecursivePredicates(V:Variable, REST)
    => getRecursivePredicates(REST)
  rule getRecursivePredicates(\not(Ps), REST)
    => getRecursivePredicates(Ps)
  rule getRecursivePredicates(\and(Ps), REST)
    => getRecursivePredicates(Ps) ++Patterns getRecursivePredicates(REST)
  rule getRecursivePredicates(\implies(LHS, RHS), REST)
    => getRecursivePredicates(LHS) ++Patterns
       getRecursivePredicates(RHS) ++Patterns
       getRecursivePredicates(REST)
  rule getRecursivePredicates(\equals(LHS, RHS), REST)
    => getRecursivePredicates(LHS) ++Patterns
       getRecursivePredicates(RHS) ++Patterns
       getRecursivePredicates(REST)
  rule getRecursivePredicates(\exists { _ } \and(Ps), REST)
    => getRecursivePredicates(Ps) ++Patterns getRecursivePredicates(REST)
```

```k
  syntax Patterns ::= getPredicates(Patterns)   [function]
  rule getPredicates(.Patterns) => .Patterns
  rule getPredicates(R:Predicate(ARGS), REST)
    => R(ARGS), getPredicates(REST)
  rule getPredicates(S:Symbol, REST)
    => getPredicates(REST)
    requires notBool isPredicate(S)
  rule getPredicates(S:Symbol(ARGS), REST)
    => getPredicates(REST)
    requires notBool isPredicate(S)
  rule getPredicates(I:Int, REST)
    => getPredicates(REST)
  rule getPredicates(V:Variable, REST)
    => getPredicates(REST)
  rule getPredicates(\not(Ps), REST)
    => getPredicates(Ps)
  rule getPredicates(\and(Ps), REST)
    => getPredicates(Ps) ++Patterns getPredicates(REST)
  rule getPredicates(\implies(LHS, RHS), REST)
    => getPredicates(LHS) ++Patterns
       getPredicates(RHS) ++Patterns
       getPredicates(REST)
  rule getPredicates(\equals(LHS, RHS), REST)
    => getPredicates(LHS) ++Patterns
       getPredicates(RHS) ++Patterns
       getPredicates(REST)
  rule getPredicates(\exists { _ } \and(Ps), REST)
    => getPredicates(Ps) ++Patterns getPredicates(REST)
```

```k
  syntax Pattern ::= getMember(Int, Patterns) [function]
  rule getMember(0, (P:Pattern, Ps)) => P
  rule getMember(N, (P:Pattern, Ps)) => getMember(N -Int 1, Ps)
    requires N >Int 0

  syntax Patterns ::= getMembers(Ints, Patterns) [function]
  rule getMembers((I, Is), Ps) => getMember(I, Ps), getMembers(Is, Ps)
  rule getMembers(.Ints, Ps) => .Patterns

  syntax Int ::= getLength(Patterns) [function]
  rule getLength(.Patterns) => 0
  rule getLength(P, Ps) => 1 +Int getLength(Ps)
```

Substitution: Substitute term or variable

```k
  syntax Pattern ::= Pattern "[" Pattern "/" Pattern "]" [function, klabel(subst)]
  syntax Pattern ::= subst(Pattern, Pattern, Pattern)    [function, klabel(subst)]
  rule subst(X,X,V) => V
  rule subst(X:Variable,Y,V) => X requires X =/=K Y
  rule subst(I:Int, X, V) => I
  rule subst(\top(),_,_) => \top()
  rule subst(\bottom(),_,_) => \bottom()
  rule subst(\equals(ARG1, ARG2):Pattern, X, V) => \equals(ARG1[X/V], ARG2[X/V]):Pattern
  rule subst(\not(ARG):Pattern, X, V) => \not(subst(ARG, X, V)):Pattern
  rule subst(\and(ARG):Pattern, X, V) => \and(ARG[X/V]):Pattern
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V)
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V)

  rule subst(S:Symbol, X, V) => S
    requires S =/=K X
  rule subst(S:Symbol(ARGS:Patterns) #as T:Pattern, X, V) => S(ARGS[X/V])
    requires T =/=K X

  syntax Pattern ::= Pattern "[" Map "]"     [function, klabel(substMap)]
  syntax Pattern ::= substMap(Pattern,  Map) [function, klabel(substMap)]
  rule substMap(BP, ((X |-> V):Map REST))
    => substMap(subst(BP,X,V), REST:Map)
  rule substMap(BP, .Map) => BP

  syntax Patterns ::= Patterns "[" Map "]"         [function, klabel(substPatternsMap)]
  syntax Patterns ::= substPatternsMap(Patterns, Map) [function, klabel(substPatternsMap)]
  rule substPatternsMap((BP, BPs), SUBST)
    => substMap(BP, SUBST), substPatternsMap(BPs, SUBST)

  rule .Patterns[SUBST] => .Patterns

  syntax Patterns ::= Patterns "[" Pattern "/" Pattern "]" [function]
  rule (BP, BPs)[X/V] => BP[X/V], (BPs[X/V])
  rule .Patterns[X/V] => .Patterns
```

```k
endmodule
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
                    | "remove-lhs-existential" | "lift-or"
                    | "simplify" | "instantiate-existentials" | "substitute-equals-for-equals"
                    | "direct-proof" // rules that the SMT-PROVER can't handle
                    | "smt" | "smt-z3" | "smt-cvc4"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")"
                    | "kt"     | "kt"     "#" KTFilter "#" KTInstantiate
                    | "kt-gfp" | "kt-gfp" "#" KTFilter "#" KTInstantiate

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

