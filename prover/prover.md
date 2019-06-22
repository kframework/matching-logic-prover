```k
requires "predicate-definitions.k"
requires "strategies/knaster-tarski.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/smt.k"
requires "strategies/unfolding.k"
requires "substitution.k"
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

  rule getFreeVariables(\exists { EXISTENTIALS } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns EXISTENTIALS

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

Substitution:

```k
  syntax Pattern ::= Pattern "[" Variable "/" Pattern "]" [function, klabel(subst)]
  syntax Pattern ::= subst(Pattern, Variable, Pattern)    [function, klabel(subst)]
  rule subst(X,X,V) => V
  rule subst(X:Variable,Y,V) => X requires X =/=K Y
  rule subst(\top(),_,_) => \top()
  rule subst(\bottom(),_,_) => \bottom()
  rule subst(I:Int, X, V) => I
  rule subst(emptyset, X, V) => emptyset
  rule subst(\equals(ARG1, ARG2):Pattern, X, V) => \equals(ARG1[X/V], ARG2[X/V]):Pattern
  rule subst(\not(ARG):Pattern, X:Variable, V:Pattern) => \not(subst(ARG, X, V)):Pattern
  rule subst(\and(ARG):Pattern, X:Variable, V:Pattern) => \and(ARG[X/V]):Pattern

  rule subst(S:Symbol(ARGS:Patterns) #as T:Pattern, X, V) => S(ARGS[X/V])
    requires T =/=K X

  syntax Pattern ::= Pattern "[" Map "]"     [function, klabel(substMap)]
  syntax Pattern ::= substMap(Pattern,  Map) [function, klabel(substMap)]
  rule substMap(BP, ((X |-> V):Map REST))
    => substMap(subst(BP,X,V), REST:Map)
  rule substMap(BP, .Map) => BP

  syntax Patterns ::= Patterns "[" Map "]"         [function, klabel(substPatternsMap)]
  syntax Patterns ::= substPatternsMap(Patterns, Map) [function, klabel(substPatternsMap)]
  rule substPatternsMap((BP, BPs), SUBST) => substMap(BP, SUBST)
                                        , substPatternsMap(BPs, SUBST)
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

Core Strategy Language
======================

The "strategy" language is an imperative language for describing which
high-level proof rules to try, in an attempt to find a proof.
Strategies can be composed: by sequencing via the `;` strategy;
as alternatives picking the first one that succeeds via the `|` strategy;
or, by requiring several strategies succeed.

```k
module PROVER-CORE-SYNTAX
```

```k
  syntax Strategy ::= Strategy ";" Strategy [right]
                    | "(" Strategy ")"      [bracket]
                    | TerminalStrategy
                    | ResultStrategy
  syntax ResultStrategy ::= "noop"
                          | Strategy "&" Strategy [right, format(%1%n%2  %3)]
                          | Strategy "|" Strategy [right, format(%1%n%2  %3)]
```

TODO: Should we allow `success` and `fail` in the program syntax? All other
strategies (assuming correct implementation) only allow for constructing a sound
proof.

```k
  syntax TerminalStrategy ::= "success" | "fail"
```

```k
endmodule
```

```k
module PROVER-CORE
  imports PROVER-CONFIGURATION
```

```k
  imports PROVER-CORE-SYNTAX
```

`Strategy`s can be sequentially composed via the `;` operator.

```k
  rule <strategy> (S ; T) ; U => S ; (T ; U) ... </strategy>
```

Since strategies do not live in the K cell, we must manually heat and cool.
`ResultStrategy`s are strategies that can only be simplified when they are
cooled back into the sequence strategy.

```k
  syntax ResultStrategy ::= "#hole"
  rule <strategy> S1 ; S2 => S1 ~> #hole ; S2 ... </strategy>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole ; S2 => S1 ; S2 ... </strategy>
```

The `noop` (no operation) strategy is the unit for sequential composition:

```k
  rule <strategy> noop ; T => T ... </strategy>
```

The `success` and `fail` strategy indicate that a goal has been successfully
proved, or that constructing a proof has failed.

```k
  rule <strategy> T:TerminalStrategy ; S => T ... </strategy>
```

TODO: Why does this not terminate? `success` followed by any strategies clears
up the `<stratergy>` cell.

```
  rule <strategy> (T:TerminalStrategy ~> REST:K) => T </strategy>
       <k> GOAL => .K </k>
       <id> 0 </id>
    requires REST =/=K .K
     andBool GOAL =/=K .K
```

The `goalStrat(GoalId)` strategy is used to establish a reference to the result of
another goal. It's argument holds the id of a subgoal. Once that subgoal has
completed, its result is replaced in the parent goal and the subgoal is removed.

```k
  syntax ResultStrategy ::= goalStrat(GoalId)
  rule <prover>
         <goal> <id> PID </id>
                <active> _ => true </active>
                <strategy> PStrat => replaceStrategyK(PStrat, goalStrat(ID), RStrat) </strategy>
                ...
         </goal>
         ( <goal> <id> ID </id>
                  <active> true:Bool </active>
                  <parent> PID </parent>
                  <strategy> RStrat:TerminalStrategy ... </strategy>
                  ...
           </goal> => .Bag
         )
         ...
       </prover>
```

```k
  syntax K ::= replaceStrategyK(K, Strategy, Strategy) [function]
  rule replaceStrategyK(K1:Strategy ~> K2, F, T)
    => replaceStrategy(K1, F, T) ~> replaceStrategyK(K2, F, T)
  rule replaceStrategyK(.K, F, T) => .K
```

```k
  syntax Strategy ::= replaceStrategy(Strategy, Strategy, Strategy) [function]
  rule replaceStrategy(S1 ; S2, F, T) => replaceStrategy(S1, F, T) ; replaceStrategy(S2, F, T)
  rule replaceStrategy(S1 & S2, F, T) => replaceStrategy(S1, F, T) & replaceStrategy(S2, F, T)
  rule replaceStrategy(S1 | S2, F, T) => replaceStrategy(S1, F, T) | replaceStrategy(S2, F, T)
  rule replaceStrategy(F,       F, T) => T
  rule replaceStrategy(S,       F, T) => S [owise]
```

Sometimes, we may need to combine the proofs of two subgoals to construct a proof
of the main goal. The `&` strategy generates subgoals for each child strategy, and if
all succeed, it succeeds:

```k
  rule <strategy> S & fail => fail ... </strategy>
  rule <strategy> fail & S => fail ... </strategy>
  rule <strategy> S & success => S ... </strategy>
  rule <strategy> success & S => S ... </strategy>
  rule <strategy> (S1 & S2) ; S3 => (S1 ; S3) & (S2 ; S3) ... </strategy>
  rule <prover>
         ( .Bag =>
             <goal>
               <id> !ID:Int </id>
               <active> true:Bool </active>
               <parent> PARENT </parent>
               <strategy> S1 </strategy>
               <k> GOAL:Pattern </k>
               <trace> TRACE </trace>
               ...
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <active> true => false </active>
           <strategy> ((S1 & S2) => S2 & goalStrat(!ID:Int)) </strategy>
           <k> GOAL:Pattern </k>
           <trace> TRACE </trace>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isTerminalStrategy(S1))
     andBool notBool(isTerminalStrategy(S2))
```

Similarly, there may be a different approaches to finding a proof for a goal.
The `|` strategy lets us try these different approaches, and succeeds if any one
approach succeeds:

```k
  rule <strategy> S | fail => S ... </strategy>
  rule <strategy> fail | S => S ... </strategy>
  rule <strategy> S | success => success ... </strategy>
  rule <strategy> success | S => success ... </strategy>
  rule <strategy> (S1 | S2) ; S3 => (S1 ; S3) | (S2 ; S3) ... </strategy>

  rule <prover>
         ( .Bag =>
             <goal>
               <id> !ID:Int </id>
               <active> true:Bool </active>
               <parent> PARENT </parent>
               <strategy> S1 </strategy>
               <k> GOAL:Pattern </k>
               <trace> TRACE </trace>
               ...
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <active> true => false </active>
           <strategy> (S1 | S2) => (S2 | goalStrat(!ID:Int)) </strategy>
           <k> GOAL:Pattern </k>
           <trace> TRACE </trace>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isTerminalStrategy(S1))
     andBool notBool(isTerminalStrategy(S2))
```

If-then-else-fi strategy is useful for implementing other strategies:

```k
  syntax Strategy ::= "if" Bool "then" Strategy "else" Strategy "fi" [function]
  rule if true  then S1 else _  fi => S1
  rule if false then _  else S2 fi => S2
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

