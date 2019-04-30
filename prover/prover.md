```k
requires "smtlib2.k"
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
  imports SUBSTITUTION
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
  syntax KVar ::= Variable
  
  syntax AtomicPattern ::= Int              // Sugar for \dv{ "number", "Int" }
                         | Variable
                         | "emptyset"       // Sugar for "\emptyset { T } ()"
  syntax RecursivePredicate
  syntax Predicate ::= RecursivePredicate
  syntax PredicatePattern ::= Predicate "(" BasicPatterns ")" [klabel(\apply)]

  syntax BasicPattern ::= AtomicPattern
                        | "\\top"    "(" ")"
                        | "\\bottom" "(" ")"
                        | "\\equals" "(" BasicPattern "," BasicPattern ")"
                        | "\\not"    "(" BasicPattern ")"
                        | PredicatePattern

                        // Int
                        | "plus"   "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "minus"  "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "mult"   "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "div"    "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "gt"     "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "max"    "(" BasicPattern "," BasicPattern ")" // Int Int

                        // Array{Int, Int}
                        | "select" "(" BasicPattern "," BasicPattern ")"                   // ArrayIntInt, Int -> Int
                        | "store"  "(" BasicPattern "," BasicPattern "," BasicPattern ")"  // ArrayIntInt, Int, Int -> ArrayIntInt

                        // Set{Int}
                        | "union"         "(" BasicPattern "," BasicPattern ")" // SetInt, SetInt
                        | "disjoint"      "(" BasicPattern "," BasicPattern ")" // SetInt, SetInt
                        | "disjointUnion" "(" BasicPattern "," BasicPattern ")" // SetInt, SetInt
                        | "singleton"     "(" BasicPattern ")"                  // Int
                        | "isMember"      "(" BasicPattern "," BasicPattern ")" // Int, SetInt
                        | "add"           "(" BasicPattern "," BasicPattern ")" // SetInt, Int
                        | "del"           "(" BasicPattern "," BasicPattern ")" // SetInt, Int

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

  // Defined in `predicate-definitions.md`
  syntax DisjunctiveForm ::= unfold(BasicPattern) [function]
  syntax SymbolDeclaration ::= getSymbolDeclaration(Predicate) [function]
endmodule
```

Kore Helpers
============

Here we define helpers for manipulating Kore formulae.

```k
module KORE-HELPERS
  imports KORE-SUGAR
  imports MAP

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
    => variable(N) { SORT } |-> variable(N, !I) { SORT }
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(variable(N, J) { SORT }, REST)
    => variable(N, J) { SORT } |-> variable(N, !I) { SORT }
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

  configuration
      <prover>
        <goal multiplicity="*" type="Bag">
          <id> 0 </id>
          <active> true:Bool </active>
          <parent> -1 </parent>
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
  imports KORE-HELPERS
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
//  rule <strategy> (T:TerminalStrategy ~> REST) => T </strategy>
//    requires REST =/=K .K
```

The `goalStrat(Int)` strategy is used to establish a reference to the result of
another goal. It's argument holds the id of a subgoal. Once that subgoal has
completed, its result is replaced in the parent goal and the subgoal is removed.

```k
  syntax ResultStrategy ::= goalStrat(Int)
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
  rule replaceStrategyK(K1 ~> K2, F, T) => replaceStrategyK(K1, F, T) ~> replaceStrategyK(K2, F, T)
  rule replaceStrategyK(S:Strategy, F, T) => replaceStrategy(S, F, T)

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
           <strategy> ((S1 & S2) => S2 & goalStrat(!ID)) </strategy>
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
           <strategy> (S1 | S2) => (S2 | goalStrat(!ID)) </strategy>
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
                    | "smt-z3" | "smt-cvc4"
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

```k
module PROVER-HORN-CLAUSE
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports ML-TO-SMTLIB2
  imports DIRECT-PROOF-QUERIES
  imports Z3
  imports CVC4
```

### Search Bound

The `search-bound` strategy peforms a bounded depth-first search for a proof, applying
`direct-proof`, `kt` and `right-unfold` strategies in turn.

```k
  rule <strategy> search-bound(0) => fail </strategy>
  rule <strategy> search-bound(N)
               => simplify ; ( ( instantiate-existentials ; (smt-z3 | smt-cvc4) )
                             | direct-proof
                             | (kt           ; search-bound(N -Int 1))
                             | (right-unfold ; search-bound(N -Int 1))
                             )
                  ...
       </strategy>
    requires N >Int 0
```

### Simplify

Remove trivial clauses from the right-hand-side:

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies(\and(LHS), \and(RHS -BasicPatterns LHS)) ...
       </k>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies( \and(LHS ++BasicPatterns ?INSTANTIATION)
                   , \and(RHS -BasicPatterns ?INSTANTIATION)
                   )
       </k>
       <strategy> instantiate-existentials ... </strategy>
    requires ?INSTANTIATION:BasicPatterns
         ==K getAtomForcingInstantiation( RHS
                                        , getFreeVariables(LHS)
                                        , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                        )
     andBool ?INSTANTIATION:BasicPatterns =/=K .Patterns

  rule <k> \implies(\and(LHS), \and(RHS))
       </k>
       <strategy> instantiate-existentials => noop ... </strategy>
    requires .Patterns
         ==K getAtomForcingInstantiation( RHS
                                        , getFreeVariables(LHS)
                                        , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                        )

  syntax BasicPatterns ::= getAtomForcingInstantiation(BasicPatterns, BasicPatterns, BasicPatterns) [function]
  rule getAtomForcingInstantiation((\equals(X:Variable, P), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((\equals(P, X:Variable), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((P, Ps), FREE, EXISTENTIAL)
    => getAtomForcingInstantiation(Ps, FREE, EXISTENTIAL) [owise]
  rule getAtomForcingInstantiation(.Patterns, FREE, EXISTENTIAL)
    => .Patterns
```

### Substitute Equals for equals

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies( \and(removeTrivialEqualities(LHS[?EQUALITY_SUBST]))
                   , \and(removeTrivialEqualities(RHS[?EQUALITY_SUBST]))
                   ) ...
       </k>
       <strategy> substitute-equals-for-equals ... </strategy>
    requires ?EQUALITY_SUBST ==K makeEqualitySubstitution(LHS)
     andBool ?EQUALITY_SUBST =/=K .Map

  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies( \and(removeTrivialEqualities(LHS[?EQUALITY_SUBST]))
                   , \and(removeTrivialEqualities(RHS[?EQUALITY_SUBST]))
                   ) ...
       </k>
       <strategy> substitute-equals-for-equals ... </strategy>
    requires ?EQUALITY_SUBST ==K makeExistentialSubstitution(RHS, getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS))
     andBool ?EQUALITY_SUBST =/=K .Map

  rule <k> \implies(\and(LHS), \and(RHS)) ... </k>
       <strategy> substitute-equals-for-equals => simplify ... </strategy>
    requires .Map ==K makeEqualitySubstitution(LHS)
     andBool .Map ==K makeExistentialSubstitution(RHS, getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS))

  syntax Map ::= makeEqualitySubstitution(BasicPatterns) [function]
  rule makeEqualitySubstitution(.Patterns) => .Map
  rule makeEqualitySubstitution(\equals(X:Variable, T), Ps) => (X |-> T) .Map
  rule makeEqualitySubstitution(\equals(T, X:Variable), Ps) => (X |-> T) .Map
    requires notBool(isVariable(T))
  rule makeEqualitySubstitution((P, Ps:BasicPatterns)) => makeEqualitySubstitution(Ps) [owise]

  syntax Map ::= makeExistentialSubstitution(BasicPatterns, BasicPatterns) [function]
  rule makeExistentialSubstitution(.Patterns, EVs) => .Map
  rule makeExistentialSubstitution((\equals(X:Variable, T), Ps), EVs) => (X |-> T) .Map
    requires X in EVs
  rule makeExistentialSubstitution((\equals(T, X:Variable), Ps), EVs) => (X |-> T) .Map
    requires X in EVs
     andBool notBool(T in EVs)
  rule makeExistentialSubstitution((P, Ps:BasicPatterns), EVs)
    => makeExistentialSubstitution(Ps, EVs) [owise]

  syntax BasicPatterns ::= removeTrivialEqualities(BasicPatterns) [function]
  rule removeTrivialEqualities(.Patterns) => .Patterns
  rule removeTrivialEqualities(\equals(X, X), Ps) => removeTrivialEqualities(Ps)
  rule removeTrivialEqualities(P, Ps) => P, removeTrivialEqualities(Ps) [owise]
```

### SMT

We can call into both CVC4 and Z3 to solve SMT queries:

```k
  rule <k> GOAL </k>
       <strategy> smt-z3
               => if Z3CheckSAT(Z3Prelude ++SMTLIB2Script ML2SMTLIB(GOAL)) ==K unsat
                  then success
                  else fail
                  fi
                  ...
       </strategy>
       <trace> .K => smt-z3 ... </trace>

  rule <k> GOAL </k>
       <strategy> smt-z3 => fail </strategy>
    requires notBool isImplicativeForm(GOAL) =/=K .Patterns

  rule <k> GOAL </k>
       <strategy> smt-cvc4
               => if CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIB(GOAL)) ==K unsat
                  then success
                  else fail
                  fi
                  ...
       </strategy>
       <trace> .K => smt-cvc4 ... </trace>

  rule <k> GOAL </k>
       <strategy> smt-cvc4 => fail </strategy>
    requires notBool isImplicativeForm(GOAL) =/=K .Patterns
```

### Direct proof

```k
  rule <k> GOAL </k>
       <strategy> direct-proof
               => if checkValid(GOAL)
                  then success
                  else fail
                  fi
                  ...
       </strategy>
       <trace> .K => direct-proof ... </trace>
```

TODO: Stubbed: Should translate to SMTLIB queries.
Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  rule checkValid(\implies(_, \and ( .Patterns ))) => true:Bool
  rule checkValid(\implies(LHS:ConjunctiveForm, _)) => true
    requires triviallyUnsatisfiable(LHS)
  rule checkValid(_) => false:Bool [owise]
```

```k
  syntax Bool ::= triviallyUnsatisfiable(Pattern) [function]
  rule triviallyUnsatisfiable(\equals(X:Int, Y:Int)) => X =/=Int Y
  rule triviallyUnsatisfiable(\equals(0, 12)) => true
  rule triviallyUnsatisfiable(\and(.Patterns)) => false
  rule triviallyUnsatisfiable(\and(BP, BPs:BasicPatterns))
    =>        triviallyUnsatisfiable(BP)
       orBool triviallyUnsatisfiable(\and(BPs))
  rule triviallyUnsatisfiable(_) => false [owise]
```

### Left Unfold (incomplete)

```k
  syntax Strategy ::= "left-unfold-eachBody"  "(" BasicPattern "," DisjunctiveForm ")"
                    | "left-unfold-oneBody"   "(" BasicPattern "," ConjunctiveForm ")"

  rule <strategy> left-unfold-eachBody(LRP, \or(\and(BODY), BODIES:ConjunctiveForms))
               => left-unfold-oneBody(LRP, \and(BODY))
                & left-unfold-eachBody(LRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> left-unfold-eachBody(LRP, \or(.ConjunctiveForms))
               => success
                  ...
       </strategy>

  rule <k> \implies(\and(LHS), RHS)
        => \implies(\and((LHS -BasicPatterns (LRP, .Patterns)) ++BasicPatterns BODY), RHS)
       </k>
       <strategy> left-unfold-oneBody(LRP, \and(BODY)) => noop ... </strategy>
       <trace> .K => left-unfold-oneBody(LRP, \and(BODY)) ... </trace>
```

### Left Unfold Nth

Unfold the Nth predicates on the Left hand side into a conjunction of
implicatations. The resulting goals are equivalent to the initial goal.

```k
  syntax Strategy ::= "left-unfold-Nth-eachLRP"  "(" Int "," BasicPatterns ")"
                    | "left-unfold-Nth-eachBody" "(" Int "," BasicPattern "," DisjunctiveForm ")"
                    | "left-unfold-Nth-oneBody"  "(" Int "," BasicPattern "," ConjunctiveForm ")"

  rule <strategy> left-unfold-Nth(M)
               => left-unfold-Nth-eachLRP(M, getPredicates(LHS))
                  ...
       </strategy>
       <k> \implies(\and(LHS), RHS) </k>

  rule <strategy> left-unfold-Nth-eachLRP(M, PS)
               => fail
                  ...
       </strategy>
  requires M <Int 0 orBool M >=Int getLength(PS)

  rule <strategy> left-unfold-Nth-eachLRP(M, PS)
               => left-unfold-Nth-eachBody(M, getMember(M, PS), unfold(getMember(M, PS)))
                  ...
       </strategy>
  requires 0 <=Int M andBool M <Int getLength(PS)

  rule <strategy> left-unfold-Nth-eachBody(M, LRP, Bodies)
               => left-unfold-eachBody(LRP, Bodies)
                  ...
       </strategy>
```

### Right Unfold

Unfold the predicates on the Right hand side into a disjunction of implications.
Note that the resulting goals is stonger than the initial goal (i.e.
`A -> B \/ C` vs `(A -> B) \/ (A -> C)`).

```k
  syntax Strategy ::= "right-unfold-eachRRP" "(" BasicPatterns")"
                    | "right-unfold-eachBody" "(" BasicPattern "," DisjunctiveForm ")"
                    | "right-unfold-oneBody"  "(" BasicPattern "," ConjunctiveForm ")"
  rule <strategy> right-unfold
               => right-unfold-eachRRP(getPredicates(RHS))
                  ...
       </strategy>
       <k> \implies(LHS, \and(RHS)) </k>
  rule <strategy> right-unfold-eachRRP(P, PS)
               => right-unfold-eachBody(P, unfold(P))
                | right-unfold-eachRRP(PS)
                  ...
       </strategy>
  rule <strategy> right-unfold-eachRRP(.Patterns)
               => fail
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(\and(BODY), BODIES:ConjunctiveForms))
               => right-unfold-oneBody(RRP, \and(BODY))
                | right-unfold-eachBody(RRP, \or(BODIES))
                  ...
       </strategy>
  rule <strategy> right-unfold-eachBody(RRP, \or(.ConjunctiveForms))
               => fail
                  ...
       </strategy>
```

```k
  rule <k> \implies(LHS, \and(RHS))
        => \implies(LHS, \and((RHS -BasicPatterns (RRP, .Patterns)) ++BasicPatterns BODY))
       </k>
       <strategy> right-unfold-oneBody(RRP, \and(BODY)) => noop ... </strategy>
       <trace> .K => right-unfold-oneBody(RRP, \and(BODY)) ... </trace>
```

### Right-Unfold-Nth

Often, when debugging a proof, the user knows which predicate needs to be
unfolded. Here we define a strategy `right-unfold-Nth(M, N)`, which unfolds the
`M`th recursive predicate (on the right-hand side) to its `N`th body. When `M`
or `N` is out of range, `right-unfold(M,N) => fail`.

```k
  syntax Strategy ::= "right-unfold-Nth-eachRRP"  "(" Int "," Int "," BasicPatterns")"
                    | "right-unfold-Nth-eachBody" "(" Int "," Int "," BasicPattern "," DisjunctiveForm ")"
                    | "right-unfold-Nth-oneBody"  "(" Int "," Int "," BasicPattern "," ConjunctiveForm ")"

  rule <strategy> right-unfold-Nth (M,N) => fail ... </strategy>
  requires (M <Int 0) orBool (N <Int 0)

  rule <strategy> right-unfold-Nth (M,N)
               => right-unfold-Nth-eachRRP(M, N, getPredicates(RHS))
       ...</strategy>
       <k> \implies(LHS,\and(RHS)) </k>

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs) => fail ... </strategy>
    requires getLength(RRPs) <=Int M

  rule <strategy> right-unfold-Nth-eachRRP(M, N, RRPs:BasicPatterns)
               => right-unfold-Nth-eachBody(M, N, getMember(M, RRPs), unfold(getMember(M, RRPs)))
       ...</strategy>
    requires getLength(RRPs) >Int M

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies))
               => fail
       ...</strategy>
    requires getLength(Bodies) <=Int N

  rule <strategy> right-unfold-Nth-eachBody(M, N, RRP, \or(Bodies:ConjunctiveForms))
               => right-unfold-Nth-oneBody(M, N, RRP, getMember(N, Bodies))
       ...</strategy>
    requires getLength(Bodies) >Int N

  rule <strategy> right-unfold-Nth-oneBody(M, N, RRP, Body)
               => right-unfold-oneBody(RRP, Body) ...
       </strategy>
```

### Knaster Tarski (Least Fixed Point)

This high-level implementation of the Knaster Tarski rule attempts the applying
the rule to each recursive predicate in turn. It also includes a heuristic
for guessing an instantiation of the inductive hypothesis.

```k
  rule <strategy> kt => kt # .KTFilter # useAffectedHeuristic ... </strategy>
  rule <k> GOAL </k>
       <strategy> kt # FILTER # INSTANTIATION
               => getLeftRecursivePredicates(GOAL) ~> kt # FILTER # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs ~> kt # head(HEAD) # INSTANTIATION
               => filterByConstructor(LRPs, HEAD) ~> kt # .KTFilter # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs:BasicPatterns ~> kt # index(I:Int) # INSTANTIATION
               => getMember(I, LRPs), .Patterns ~> kt # .KTFilter # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> LRPs ~> kt # .KTFilter # INSTANTIATION
               => ktForEachLRP(LRPs, INSTANTIATION)
                  ...
       </strategy>
```

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:

```k
  syntax Strategy ::= ktForEachLRP(BasicPatterns, KTInstantiate)
  rule <strategy> ktForEachLRP(.Patterns, INSTANTIATION) => fail ... </strategy>
  rule <strategy> ktForEachLRP((LRP, LRPs), INSTANTIATION)
               => ktLRP(LRP, INSTANTIATION) | ktForEachLRP(LRPs, INSTANTIATION)
                  ...
       </strategy>
```

(`ktLRP` corresponds to `lprove_kt/6`)

```k
  syntax Strategy ::= ktLRP(BasicPattern, KTInstantiate)
  rule <strategy> ktLRP(LRP, INSTANTIATION)
               => ktForEachBody(LRP, unfold(LRP), INSTANTIATION) ...
       </strategy>
       <trace> .K => ktLRP(LRP, INSTANTIATION) ... </trace>
```

(`ktForEachBody` corresponds to `lprove_kt_all_bodies`)

```k
  syntax Strategy ::= ktForEachBody(BasicPattern, DisjunctiveForm, KTInstantiate) [function]
  rule ktForEachBody(LRP, \or(.ConjunctiveForms), _) => success
  rule ktForEachBody(LRP, \or(BODY, BODIES), INSTANTIATION)
    => ktOneBody(LRP, BODY, INSTANTIATION)
     & ktForEachBody(LRP, \or(BODIES), INSTANTIATION)
```

```k
  syntax Strategy ::= ktOneBody(BasicPattern, ConjunctiveForm, KTInstantiate)
```

```k
  syntax KItem ::= ktEachBRP(BasicPattern, ConjunctiveForm, BasicPatterns, KTInstantiate) // LRP, Body, BRPs
                 | ktOneBRP(BasicPattern, ConjunctiveForm, BasicPattern, KTInstantiate)   // LRP, Body, BRP
                 | ktBRPResult(Patterns, ConjunctiveForm)
                 | ktBRPCollectResults(ConjunctiveForm, BasicPattern) // Body, LRP
  rule <strategy> ktOneBody(LRP:RecursivePredicate(ARGS), BODY, INSTANTIATION)
               => ktEachBRP(LRP(ARGS), BODY, filterByConstructor(getRecursivePredicates(BODY, .Patterns), LRP), INSTANTIATION)
               ~> ktBRPCollectResults(BODY, LRP(ARGS))
                  ...
       </strategy>
```

```k
  rule <strategy> ktEachBRP(LRP, BODY, (BRP_samehead, BRPs_samehead), INSTANTIATION)
               => ktOneBRP(LRP, BODY, BRP_samehead, INSTANTIATION)
               ~> ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION)
                  ...
       </strategy>
  rule <strategy> ktEachBRP(LRP, BODY, .Patterns, INSTANTIATION)
               => ktBRPResult(.Patterns, \and(.Patterns)) ...
       </strategy>

  rule <k> \implies(\and(LHS), \and(RHS)) </k>
       <strategy> ktOneBRP(HEAD:RecursivePredicate(LRP_ARGS), \and(BODY), HEAD(BRP_ARGS), INSTANTIATION)
               => ktBRPResult( (?Premise, .Patterns)
                             , \and(?LHS_UA ++BasicPatterns ?RHS_UAF)
                             )
                  ...
       </strategy>
       <trace> .K
            => ( "InstSubst" ~> ?InstSubst
              ~> "PassiveVars" ~> ?PassiveVars
               )
               ...
       </trace>
    requires ?USubst ==K zip(LRP_ARGS, BRP_ARGS)
     andBool ?InstSubst ==K ktMakeInstantiationSubst(HEAD(LRP_ARGS), HEAD(BRP_ARGS), \implies(\and(LHS), \and(RHS)), INSTANTIATION)
     andBool ?LHS_UA  ==K {(LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns))[ ?USubst ][ ?InstSubst ]}:>BasicPatterns
     andBool ?Premise ==K \implies( \and( (LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns)) ++BasicPatterns
                                          (BODY -BasicPatterns filterByConstructor(getRecursivePredicates(BODY), HEAD)) // BRPs_diffhead + BCPs
                                        )
                                  , \and(?LHS_UA)
                                  )
     andBool ?UnivVars ==K getFreeVariables(LHS)
     andBool ?ExVARS   ==K getFreeVariables(\and(RHS), .Patterns) -BasicPatterns ?UnivVars
     andBool ?FSubst   ==K makeFreshSubstitution(?ExVARS)
     andBool ?RHS_UAF  ==K {RHS[?USubst][?InstSubst][?FSubst]}:>BasicPatterns
     andBool ?PassiveVars ==K getFreeVariables(LHS) -BasicPatterns LRP_ARGS

  syntax Map ::= ktMakeInstantiationSubst(PredicatePattern, PredicatePattern, ImplicativeForm, KTInstantiate) [function]
  rule ktMakeInstantiationSubst(HEAD:Predicate(LRP_ARGS), HEAD(BRP_ARGS), \implies(\and(LHS), RHS), useAffectedHeuristic)
    => makeFreshSubstitution(findAffectedVariablesAux(LRP_ARGS -BasicPatterns BRP_ARGS, LHS)
                             -BasicPatterns (LRP_ARGS -BasicPatterns (LRP_ARGS -BasicPatterns BRP_ARGS)) // Non-critical
                            // TODO: !!!! This should use findAffectedVariables and not the Aux version
                            )
  rule ktMakeInstantiationSubst(HEAD:Predicate(LRP_ARGs), _, \implies(\and(LHS), RHS), freshPositions(POSITIONS))
    => makeFreshSubstitution(getMembers(POSITIONS, getFreeVariables(LHS) -BasicPatterns LRP_ARGs)) // PassiveVars
```

Two consecutive ktBRPResults are consolidated into a single one.

```k
  rule <strategy>    ktBRPResult(PREMISES1, \and(CONCL_FRAGS1))
                  ~> ktBRPResult(PREMISES2, \and(CONCL_FRAGS2))
               => ktBRPResult( PREMISES1 ++Patterns PREMISES2
                             , \and(CONCL_FRAGS1 ++BasicPatterns CONCL_FRAGS2)
                             )
                  ...
       </strategy>
```

`ktEachBRP`s are brought to the top of the cell:

```k
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION)
               => ktEachBRP(LRP, BODY, BRPs_samehead, INSTANTIATION) ~> ktBRPResult(PREMISES, CONCL_FRAG)
                  ...
       </strategy>
```

Finally, once we encounter `ktBRPCollectResults`, we build a strategy for KT
goals, including both the premises and the conclusion:

```k
                           // Body           , LRP         , Premises        , Conclusion frags
  syntax Strategy ::= ktGoals(ConjunctiveForm, BasicPattern, Patterns        , ConjunctiveForm)
                    | ktPremise(ImplicativeForm)
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktBRPCollectResults(BODY, LRP)
               => ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
  rule <strategy> ktGoals(BODY, LRP, (PREMISE, PREMISES), CONCL_FRAG)
               => ktPremise(PREMISE) & ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
  rule <k> _ => PREMISE </k>
       <strategy> ktPremise(PREMISE) => noop ... </strategy>
       <trace> .K => ktPremise(PREMISE) ... </trace>
```

```k
  rule <k> \implies(\and(LHS), RHS)
        => \implies( \and( (LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns))
                           ++BasicPatterns (BODY -BasicPatterns ?BRP_samehead)
                           ++BasicPatterns CONCL_FRAGS
                         )
                   , RHS
                   )
           ...
       </k>
       <strategy> ktGoals(\and(BODY), HEAD:RecursivePredicate(LRP_ARGS), .Patterns, \and(CONCL_FRAGS))
               => noop
                  ...
       </strategy>
       <trace> .K => "Conclusion" ... </trace>
     requires ?BRP_samehead ==K filterByConstructor(getRecursivePredicates(BODY), HEAD)
```

```k
  syntax BasicPatterns        // Critical       Conds
    ::= findAffectedVariablesAux(BasicPatterns, BasicPatterns)             [function]
      | findAffectedVariables(BasicPatterns, BasicPatterns, BasicPatterns) [function]
  rule findAffectedVariables(AFF, NONCRIT, CONDS)
    => AFF -BasicPatterns NONCRIT
    requires findAffectedVariablesAux(AFF -BasicPatterns NONCRIT, CONDS) -BasicPatterns NONCRIT
         ==K AFF -BasicPatterns NONCRIT
  // TODO: Why doesn't `owise` work here?
  rule findAffectedVariables(AFF, NONCRIT, CONDS)
    => findAffectedVariables( findAffectedVariablesAux(AFF -BasicPatterns NONCRIT, CONDS)
                            , NONCRIT
                            , CONDS
                            )
    requires findAffectedVariablesAux(AFF -BasicPatterns NONCRIT, CONDS) -BasicPatterns NONCRIT
         =/=K AFF -BasicPatterns NONCRIT
  rule findAffectedVariablesAux(    AFF , (\equals(X, Y), REST))
    => findAffectedVariablesAux((X, AFF),                 REST )
    requires isVariable(X)
     andBool AFF =/=K (AFF -BasicPatterns getFreeVariables(Y, .Patterns))
  rule findAffectedVariablesAux(    AFF , (\equals(Y, X), REST))
    => findAffectedVariablesAux((X, AFF),                 REST )
    requires isVariable(X)
     andBool (AFF -BasicPatterns getFreeVariables(Y, .Patterns)) =/=K AFF
     andBool notBool X in AFF
  rule findAffectedVariablesAux(    AFF , (COND,          REST))
    => findAffectedVariablesAux(    AFF ,                 REST )
       [owise]
  rule findAffectedVariablesAux(    AFF , .Patterns)
    => AFF
```

### Knaster Tarski (Greatest Fixed Points)

TODO: Need `CorecursivePredicate` sort

```k
  rule <strategy> kt-gfp => kt-gfp # .KTFilter # useAffectedHeuristic ... </strategy>
  rule <k> \implies(_, RHS:ConjunctiveForm) </k>
       <strategy> kt-gfp # FILTER # INSTANTIATION
               => getRecursivePredicates(RHS, .Patterns) ~> kt-gfp # FILTER # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> RRPs ~> kt-gfp # head(HEAD) # INSTANTIATION
               => filterByConstructor(RRPs, HEAD) ~> kt-gfp # .KTFilter # INSTANTIATION
                  ...
       </strategy>
  rule <strategy> RRPs:BasicPatterns ~> kt-gfp # index(I:Int) # INSTANTIATION
               => getMember(I, RRPs), .Patterns ~> kt-gfp # .KTFilter # INSTANTIATION
                  ...
       </strategy>
```

```k
  rule <k>    \implies(\and(LHS), \and(RHS))
           => \implies(\and(LHS), \and({LHS[?USubst][?InstSubst]}:>BasicPatterns
                                      ++BasicPatterns ?BODY_REST
                                      ++BasicPatterns (RHS -BasicPatterns (HEAD:Predicate(RRP_ARGS), .Patterns))
                      )               )
       </k>
       <strategy> HEAD(RRP_ARGS), .Patterns
               ~> kt-gfp # .KTFilter # INSTANTIATION
               => noop
                  ...
       </strategy>
       <trace>
         .K => "USubst"    ~> ?USubst
            ~> "InstSubst" ~> ?InstSubst
            ~> "BRP: " ~> HEAD(?BRP_ARGS)
         ...
       </trace>
    requires \or(\and(?UNFOLD)) ==K unfold(HEAD(RRP_ARGS))
     andBool HEAD(?BRP_ARGS), .Patterns ==K filterByConstructor(getRecursivePredicates(?UNFOLD), HEAD)
     andBool ?BODY_REST ==K (?UNFOLD -Patterns (HEAD(?BRP_ARGS), .Patterns))
     andBool ?USubst ==K zip(RRP_ARGS, ?BRP_ARGS)
     andBool ?InstSubst ==K makeFreshSubstitution(getFreeVariables(LHS) -BasicPatterns getFreeVariables(RHS))
```

```k
endmodule
```

LTL Fragment
============

### and-intro

```k
module PROVER-LTL-SYNTAX
  syntax Strategy ::= "and-intro"
  syntax Strategy ::= "unfold"
  syntax Strategy ::= "kt-always"
endmodule
```

```k
module PROVER-LTL
  imports PROVER-CORE
  imports PROVER-LTL-SYNTAX
  imports PROVER-HORN-CLAUSE

  /* |- A -> B /\ C
   * =>
   * |- A -> B
   * |- A -> C
   */
  syntax Strategy ::= "and-intro" "(" Patterns ")"
  rule <k> \implies(LHS:Pattern, \and(Ps:Patterns)) </k>
       <strategy> and-intro => and-intro(Ps) ... </strategy>

  rule <strategy> and-intro(.Patterns) => success </strategy>
  rule <strategy> and-intro(P:Pattern, Ps:Patterns)
               => and-intro(P, .Patterns) & and-intro(Ps) ... </strategy>
  requires Ps =/=K .Patterns
  rule <k> \implies(LHS:Pattern, RHS:Pattern) => \implies(LHS, P) ... </k>
       <strategy> and-intro(P, .Patterns) => noop ... </strategy>
```

### wnext-and

```k
  /* wnext(P /\ Q) => wnext(P) /\ wnext(Q) */
  rule wnext(\and(.Patterns)) => \top() [anywhere]
  rule wnext(\and(P:Pattern, Ps:Patterns))
    => \and(wnext(P), wnext(\and(Ps)), .Patterns) [anywhere]
```

### kt-always

```k
  /* |- P -> always(Q)
   * =>
   * |- P -> Q /\ wnext(P)
   */

  rule <k> \implies(P:Pattern, always(Q:Pattern))
        => \implies(P, \and(Q, wnext(P), .Patterns)) </k>
        <strategy> kt-always => noop ... </strategy>
```

### unfold

```k
  // <k> ... always(P) => P /\ wnext(always(P)) ... </k>
  // This rule will pick one recursive/fixpoint and unfold it.
  // One has to traverse the whole pattern.
  // Here, I only did a simple special case that works for LTL-Ind.
  rule <k> \implies( \and(always(P), Ps:Patterns) , Q )
        => \implies( \and(P, wnext(always(P)), Ps) , Q)
       </k>
       <active> true </active>
       <strategy> left-unfold => noop ... </strategy>

```

### Simplification rules


TODO: These should be part of simplify

```k
  rule \and(P, \and(Ps1:Patterns), Ps2)
    => \and(P, (Ps1 ++Patterns Ps2)) [anywhere]

  rule <k> \implies( \and(Ps1:Patterns)
                   , P:Pattern
                   )
       </k>
       <strategy> direct-proof => success ... </strategy>
     requires P inPatterns Ps1

  rule <k> \implies( _
                   , \top()
                   )
       </k>
       <strategy> direct-proof => success ... </strategy>

  rule <k> \implies ( \and ( \implies ( phi , wnext ( phi ) )
                           , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) )
                           , phi , .Patterns )
                    , wnext ( phi )
                    )
       </k>
       <strategy>
         direct-proof => success ...
       </strategy>
  rule <k> \implies( \and ( \implies ( phi , wnext ( phi ) )
                          , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) )
                          , phi , .Patterns )
                   , wnext ( \implies ( phi , wnext ( phi ) ) )
                   )
       </k>
       <strategy>
         direct-proof => fail ...
       </strategy>

  rule <k> \implies ( \and ( always ( \implies ( phi , wnext ( phi ) ) ) , phi , .Patterns )
                    , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) )
                    )
       </k>
       <strategy>
         direct-proof => fail ...
       </strategy>

  rule <k> \implies ( \and ( always ( \implies ( phi , wnext ( phi ) ) ) , phi , .Patterns )
                    , wnext ( phi )
                    )
       </k>
       <strategy>
         direct-proof => fail ...
       </strategy>
```

### Ad-hoc rules

```k
  rule <k> \implies(_ , wnext ( \implies ( phi , wnext ( phi ) ) )) </k>
       <active> true </active>
       <strategy> and-intro => fail ... </strategy>

  rule <k> \implies ( \and ( \implies ( phi , wnext ( phi ) )
                           , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) )
                           , phi
                           , .Patterns
                           )
                    , phi
                    )
       </k>
       <active> true </active>
       <strategy> and-intro => fail ... </strategy>
```

```k
endmodule
````

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
  imports PROVER-HORN-CLAUSE
  imports PROVER-LTL
endmodule
```

