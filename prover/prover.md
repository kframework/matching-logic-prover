```k
requires "strategies/smt.k"
requires "strategies/search-bound.k"
requires "strategies/simplification.k"
requires "strategies/knaster-tarski.k"
requires "strategies/unfolding.k"
requires "strategies/ltl.k"
requires "substitution.k"
requires "direct-proof.k"
requires "predicate-definitions.k"
```

Kore Sugar
==========

The Matching Logic Prover operates at the meta level, over a version of Kore
that has sorts elided for convenience. There are also additional syntactical
categories for formulae in particular standard forms (`ImplicativeForm`,
`ConjunctiveForm`, ...), and `\and` and `\or` are represented as an associative
list of subpatterns.

TODO: We assume that all free variables in an ImplicativeForm that are in the RHS
but not in the LHS are existential. This should be explicit.

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

We allow two "varieties" of variables: the first, identified by a String, is for
use in defining claims; the second, identified by a String and an Int subscript
is to be used for generating fresh variables. *The second variety must be used
only in this scenario*.

```k
  syntax KItem ::= Variable
  syntax Variable ::= "variable" "(" String ")"         "{" Sort "}"
                    | "variable" "(" String "," Int ")" "{" Sort "}"
  
  syntax AtomicPattern ::= Int              // Sugar for \dv{ "number", "Int" }
                         | Variable
                         | "emptyset"       // Sugar for "\emptyset { T } ()"

  // TODO: We need a uniform interface for these:
  syntax RecursivePredicate
  syntax Predicate ::= RecursivePredicate
  syntax FunctionSymbol ::= Predicate
                          | UnaryFunctionSymbol
                          | BinaryFunctionSymbol
                          | TrinaryFunctionSymbol
  syntax PredicatePattern ::= Predicate "(" BasicPatterns ")" [klabel(\apply)]
  syntax FunctionPattern ::= PredicatePattern
                           | UnaryFunctionSymbol "(" BasicPattern ")" [klabel(\apply)]
                           | BinaryFunctionSymbol "(" BasicPattern "," BasicPattern ")" [klabel(\apply)]
                           | TrinaryFunctionSymbol "(" BasicPattern "," BasicPattern "," BasicPattern ")" [klabel(\apply)]
  syntax UnaryFunctionSymbol ::= "singleton"
  syntax BinaryFunctionSymbol ::= "plus"| "minus"| "mult"| "div"| "gt"| "max" // Arith
                                | "union" | "disjoint" | "disjointUnion" | "isMember" | "add" | "del" // Sets
                                | "select" // Arrays
  syntax TrinaryFunctionSymbol ::= "store"

  syntax BasicPattern ::= AtomicPattern
                        | FunctionPattern
                        | "\\top"    "(" ")"
                        | "\\bottom" "(" ")"
                        | "\\equals" "(" BasicPattern "," BasicPattern ")"
                        | "\\not"    "(" BasicPattern ")"

  syntax ConjunctiveForm ::= "\\and"     "(" BasicPatterns ")" [klabel(\and)]
  syntax ConjunctiveForms ::= List{ConjunctiveForm, ","}
  syntax DisjunctiveForm ::= "\\or"      "(" ConjunctiveForms ")"
  syntax ImplicativeForm ::= "\\implies" "(" ConjunctiveForm "," ConjunctiveForm ")" [prefer, klabel(\implies)]

  syntax Pattern ::= BasicPattern
                   | ConjunctiveForm
                   | DisjunctiveForm
                   | ImplicativeForm

                   // General syntax
                   | "phi"
                   | "\\implies" "(" Pattern "," Pattern ")" [klabel(\implies)]
                   | "\\and"     "(" Patterns ")"            [klabel(\and)]
                   | "\\not"     "(" Pattern ")"

                   // LTL&CTL concrete syntax
                   | "wnext" "(" Pattern ")"
                   | "snext" "(" Pattern ")"
                   | "always" "(" Pattern ")"

  syntax BasicPatterns ::= ".Patterns"
                         | BasicPattern "," BasicPatterns [klabel(PatternCons), right]
  syntax Patterns      ::= BasicPatterns
                         | Pattern "," Patterns           [klabel(PatternCons), right]

  syntax Sorts ::= List{Sort, ","} [klabel(Sorts)]
  syntax SymbolDeclaration ::= "symbol" Predicate "{" "}" "(" Sorts ")" ":" Sort
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

  syntax Bool ::= BasicPattern "in" BasicPatterns [function]
  rule BP in (BP,  BP1s) => true
  rule BP in (BP1, BP1s) => BP in BP1s requires BP =/=K BP1
  rule BP in .Patterns   => false

  syntax Bool ::= Pattern "inPatterns" Patterns [function]
  rule P inPatterns (P,  P1s) => true
  rule P inPatterns (P1, P1s) => P inPatterns P1s requires P =/=K P1
  rule P inPatterns .Patterns => false

  syntax BasicPatterns ::= BasicPatterns "++BasicPatterns" BasicPatterns [function, right]
  rule (BP1, BP1s) ++BasicPatterns BP2s => BP1, (BP1s ++BasicPatterns BP2s)
  rule .Patterns ++BasicPatterns BP2s => BP2s

  syntax Patterns ::= Patterns "++Patterns" Patterns [function, right]
  rule (BP1, BP1s) ++Patterns BP2s => BP1, (BP1s ++Patterns BP2s)
  rule .Patterns ++Patterns BP2s => BP2s

  syntax BasicPatterns ::= removeDuplicates(BasicPatterns) [function]
  rule removeDuplicates(.Patterns) => .Patterns
  rule removeDuplicates(BP, BPs) => BP, removeDuplicates(BPs)
  requires notBool(BP in BPs)
  rule removeDuplicates(BP, BPs) => removeDuplicates(BPs)
    requires BP in BPs

  syntax BasicPatterns ::= BasicPatterns "-BasicPatterns" BasicPatterns [function]
  rule (BP1, BP1s) -BasicPatterns BP2s => BP1, (BP1s -BasicPatterns BP2s)
    requires notBool(BP1 in BP2s)
  rule (BP1, BP1s) -BasicPatterns BP2s =>      (BP1s -BasicPatterns BP2s)
    requires BP1 in BP2s
  rule .Patterns -BasicPatterns BP2s => .Patterns
  rule BP1s -BasicPatterns .Patterns => BP1s

  syntax Patterns ::= Patterns "-Patterns" Patterns [function]
  rule (P1, P1s) -Patterns P2s => P1, (P1s -Patterns P2s)
    requires notBool(P1 in P2s)
  rule (P1, P1s) -Patterns P2s =>      (P1s -Patterns P2s)
    requires P1 in P2s
  rule .Patterns -Patterns P2s => .Patterns
  rule P1s -Patterns .Patterns => P1s
```

```k
  syntax BasicPatterns ::= getFreeVariables(Patterns) [function]
  rule getFreeVariables(.Patterns) => .Patterns
  rule getFreeVariables(P, Ps)
    => removeDuplicates(
         getFreeVariables(P, .Patterns) ++BasicPatterns getFreeVariables(Ps))
    requires Ps =/=K .Patterns
  rule getFreeVariables(X:Variable, .Patterns) => X, .Patterns
  rule getFreeVariables(P:Predicate(ARGS) , .Patterns)   => getFreeVariables(ARGS)
  rule getFreeVariables(\implies(LHS, RHS), .Patterns)
    => removeDuplicates(
         getFreeVariables(LHS, .Patterns) ++BasicPatterns getFreeVariables(RHS, .Patterns))
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\or(CF, CFs),  .Patterns)
    => removeDuplicates(
         getFreeVariables(CF, .Patterns) ++BasicPatterns getFreeVariables(\or(CFs), .Patterns))
  rule getFreeVariables(\or(.ConjunctiveForms), .Patterns)
    => .Patterns

  rule getFreeVariables(N:Int, .Patterns) => .Patterns
  rule getFreeVariables(emptyset, .Patterns) => .Patterns
  rule getFreeVariables(\top(), .Patterns) => .Patterns
  rule getFreeVariables(\bottom(), .Patterns) => .Patterns
  rule getFreeVariables(\not(P), .Patterns) => getFreeVariables(P, .Patterns)
  rule getFreeVariables(\equals(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)

  // TODO: Defining these for each symbol is tiring. If `select` etc were defined
  // as the application of a symbol to arguments (similar to how Predicate and RecursivePredicate
  // are), this would be easier. We would lose our compile time check on the arity though.
  rule getFreeVariables(plus(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(mult(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(div(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(gt(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(minus(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(max(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(select(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(store(P1, P2, P3), .Patterns)
    => getFreeVariables(P1, P2, P3, .Patterns)
  rule getFreeVariables(union(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(disjoint(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(disjointUnion(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(singleton(P1), .Patterns)
    => getFreeVariables(P1, .Patterns)
  rule getFreeVariables(isMember(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(add(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(del(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
```

```k
  syntax Bool ::= BasicPatterns "notOccurFree" Patterns [function]
  rule .Patterns notOccurFree Qs => true
  rule (X:Variable, .Patterns) notOccurFree Qs
    => notBool(X in getFreeVariables(Qs))
  rule (P:BasicPattern, Ps:BasicPatterns) notOccurFree Qs
    => ((P, .Patterns) notOccurFree Qs) andBool (Ps notOccurFree Qs)
    requires Ps =/=K .Patterns
```

Returns a list of terms that are the application of the `Predicate`.

```k
  syntax BasicPatterns ::= filterByConstructor(BasicPatterns, Predicate) [function]
  rule filterByConstructor(.Patterns, CTOR) => .Patterns
  rule filterByConstructor((P:Predicate (Ps) , Rest), P)
    => (P:Predicate (Ps)), filterByConstructor(Rest, P)
  rule filterByConstructor((Q:Predicate (Qs) , Rest), P)
    => filterByConstructor(Rest, P)
  requires P =/=K Q
  rule filterByConstructor((Q, Rest), P)
    => filterByConstructor(Rest, P)
       [owise]
```

zip: Take two lists and return a map. This can be used to take a list of variables
and values, passed to K's substitute.

```k
  syntax Map ::= zip(BasicPatterns, BasicPatterns) [function]
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
  syntax Map ::= makeFreshSubstitution(BasicPatterns) [function] // Variables
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
  syntax BasicPatterns ::= getLeftRecursivePredicates(ImplicativeForm) [function]
  rule getLeftRecursivePredicates(\implies(\and(LHS), RHS))
    => getRecursivePredicates(LHS)
```

```k
  syntax BasicPatterns ::= getRecursivePredicates(Patterns)   [function]
  rule getRecursivePredicates(.Patterns) => .Patterns
  rule getRecursivePredicates(R:RecursivePredicate(ARGS), REST)
    => R(ARGS), getRecursivePredicates(REST)
  rule getRecursivePredicates(\and(Ps), REST)
    =>                 getRecursivePredicates(Ps)
       ++BasicPatterns getRecursivePredicates(REST)
  rule getRecursivePredicates(PATTERN:BasicPattern, REST)
    => getRecursivePredicates(REST)
       [owise]
```

```k
  syntax BasicPatterns ::= getPredicates(Patterns)   [function]
  rule getPredicates(.Patterns) => .Patterns
  rule getPredicates(R:Predicate(ARGS), REST)
    => R(ARGS), getPredicates(REST)
  rule getPredicates(\and(Ps), REST)
    =>                 getPredicates(Ps)
       ++BasicPatterns getPredicates(REST)
  rule getPredicates(PATTERN:BasicPattern, REST)
    => getPredicates(REST)
       [owise]
```

```k
  syntax Int ::= getLength(BasicPatterns) [function]
  rule getLength(.Patterns) => 0
  rule getLength(P:BasicPattern, Ps) => 1 +Int getLength(Ps)

  syntax BasicPattern ::= getMember(Int, BasicPatterns) [function]
  rule getMember(0, (P:BasicPattern, Ps)) => P
  rule getMember(N, (P:BasicPattern, Ps)) => getMember(N -Int 1, Ps)
    requires N >Int 0

  syntax BasicPatterns ::= getMembers(Ints, BasicPatterns) [function]
  rule getMembers((I, Is), Ps) => getMember(I, Ps), getMembers(Is, Ps)
  rule getMembers(.Ints, Ps) => .Patterns

  syntax Int ::= getLength(ConjunctiveForms) [function]
  rule getLength(.ConjunctiveForms) => 0
  rule getLength(CF:ConjunctiveForm, CFs) => 1 +Int getLength(CFs)

  syntax ConjunctiveForm ::= getMember(Int, ConjunctiveForms) [function]
  rule getMember(0, (CF:ConjunctiveForm, CFs:ConjunctiveForms)) => CF
  rule getMember(N, (CF:ConjunctiveForm, CFs:ConjunctiveForms)) => getMember(N -Int 1, CFs)
    requires N >Int 0
```

Substitution:

```k
  syntax BasicPattern ::= BasicPattern "[" Variable "/" BasicPattern "]" [function]
  rule X:Variable[X/V] => V
  rule X:Variable[Y/V] => X requires X =/=K Y
  rule \top()[_/_] => \top()
  rule \bottom()[_/_] => \bottom()
  rule \equals(ARG1, ARG2) [X/V] => \equals(ARG1[X/V], ARG2[X/V])
  rule \not(ARG) [X/V] => \not(ARG[X/V])
  rule I:Int [X/V] => I
  rule emptyset [X/V] => emptyset
  rule (P:Predicate(ARGS)) [X/V] => P(ARGS[X/V])
  rule (F:UnaryFunctionSymbol(ARG)) [X/V] => F(ARG[X/V])
  rule (F:BinaryFunctionSymbol(ARG1, ARG2)) [X/V] => F(ARG1[X/V], ARG2[X/V])
  rule (F:TrinaryFunctionSymbol(ARG1, ARG2, ARG3)) [X/V] => F(ARG1[X/V], (ARG2[X/V]), (ARG3[X/V]))
  
  syntax BasicPattern ::= BasicPattern "[" Map "]" [function]
  rule BP:BasicPattern[ (X |-> V):Map REST:Map ] => BP[X/V][REST:Map]
  rule BP:BasicPattern[ .Map ] => BP

  syntax BasicPatterns ::= BasicPatterns "[" Map "]" [function]
  rule (BP, BPs)[SUBST] => BP[SUBST], (BPs[SUBST])
  rule .Patterns[SUBST] => .Patterns

  syntax BasicPatterns ::= BasicPatterns "[" Variable "/" BasicPattern "]" [function]
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
  imports PROVER-LTL-SYNTAX
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
endmodule
```

Main Modules
============

```k
module PROVER
  imports PROVER-DRIVER
//  imports PROVER-HORN-CLAUSE
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-DIRECT-PROOF
  imports STRATEGY-KNASTER-TARSKI

  imports PROVER-LTL
endmodule
```

