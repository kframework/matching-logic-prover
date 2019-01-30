```k
requires "smtlib2.k"
requires "substitution.k"
```

Kore Sugar
==========

TODO: We assume that all free variables in an ImplicativeForm that are in the RHS
but not in the LHS are existential. This should be explicit.

The following is sugar for a post-sort-erasure first-order horn clause fragment
of kore:

```k
module KORE-SUGAR
  imports DOMAINS-SYNTAX
  syntax Ints ::= List{Int, ","}

  syntax Sort ::= "Bool" | "Int" | "ArrayIntInt" | "Set"
```

We allow two "varieties" of variables: the first, identified by a String, is for use in defining claims;
the second, identified by a String and an Int subscript is to be used for generating fresh variables.
*The second variety must be used only in this scenario*.

```k
  syntax Variable ::= "variable" "(" String ")"         "{" Sort "}"
                    | "variable" "(" String "," Int ")" "{" Sort "}"
  syntax KVariable ::= Variable

  syntax AtomicPattern ::= Int              // Sugar for \dv{ "number", "Int" }
                         | Variable
                         | "emptyset"       // Sugar for "\emptyset { T } ()"
  syntax RecursivePredicate
  syntax Predicate ::= RecursivePredicate
  syntax PredicatePattern ::= Predicate "(" BasicPatterns ")"

  syntax BasicPattern ::= AtomicPattern
                        | "\\top"    "(" ")"
                        | "\\bottom" "(" ")"
                        | "\\equals" "(" BasicPattern "," BasicPattern ")"
                        | "\\not"    "(" BasicPattern ")"
                        | PredicatePattern

                        // Int
                        | "plus"   "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "minus"  "(" BasicPattern "," BasicPattern ")" // Int Int
                        | "gt"     "(" BasicPattern "," BasicPattern ")" // Int Int

                        // Array{Int, Int}
                        | "select" "(" BasicPattern "," BasicPattern ")"        // ArrayIntInt, Int

                        // Set{Int}
                        | "union"         "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "disjoint"      "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "disjointUnion" "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "singleton"     "(" BasicPattern ")"                  // Int
                        | "isMember"      "(" BasicPattern "," BasicPattern ")" // Int, Set
                        | "add"           "(" BasicPattern "," BasicPattern ")" // Set, Int
                        | "del"           "(" BasicPattern "," BasicPattern ")" // Set, Int

  syntax ConjunctiveForm ::= "\\and"     "(" BasicPatterns ")"
  syntax ConjunctiveForms ::= List{ConjunctiveForm, ","}
  syntax DisjunctiveForm ::= "\\or"      "(" ConjunctiveForms ")"
  syntax ImplicativeForm ::= "\\implies" "(" ConjunctiveForm "," ConjunctiveForm ")"

  syntax Pattern ::= BasicPattern
                   | ConjunctiveForm
                   | DisjunctiveForm
                   | ImplicativeForm

                   // General syntax
                   | "phi"
                   | "\\implies" "(" Pattern "," Pattern ")"
                   | "\\and"     "(" Patterns ")"
                   | "\\not"     "(" Pattern ")"

                   // LTL&CTL concrete syntax
                   | "wnext" "(" Pattern ")"
                   | "snext" "(" Pattern ")"
                   | "always" "(" Pattern ")"

  syntax BasicPatterns ::= ".Patterns"
                         | BasicPattern "," BasicPatterns [klabel(PatternCons), right]
  syntax Patterns      ::= BasicPatterns
                         | Pattern "," Patterns           [klabel(PatternCons), right]

  /* examples */
  syntax RecursivePredicate ::= "listSegmentLeft"
                              | "listSegmentLeftSorted"
                              | "listSegmentRight"
                              | "listSegmentRightLength"
                              | "listSorted"
                              | "listSortedLength"
                              | "listLength"
                              | "list"
                              | "bt"
                              | "bst"
                              | "dll"
                              | "dllLength"
                              | "dllSegmentLeft"
                              | "dllSegmentLeftLength"
                              | "dllSegmentRight"
                              | "dllSegmentRightLength"
                              /* find */
                              | "find-list-seg"
                              | "find-list"
                              | "find-find"

                              // Weakened versions for `lr -> ll`
                              | "listSegmentLeftWeak"
                              | "listSegmentRightWeak"
  syntax Predicate ::= "isEmpty"
endmodule
```

Kore Helpers
============

```k
module KORE-HELPERS
  imports KORE-SUGAR
  imports MAP

  syntax Bool ::= BasicPattern "in" BasicPatterns [function]
  rule BP in (BP,  BP1s) => true
  rule BP in (BP1, BP1s) => BP in BP1s requires BP =/=K BP1
  rule BP in .Patterns   => false

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
    => getFreeVariables(LHS, .Patterns) ++BasicPatterns getFreeVariables(RHS, .Patterns)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\or(CF, CFs),  .Patterns)
    =>                 getFreeVariables(CF, .Patterns)
       ++BasicPatterns getFreeVariables(\or(CFs), .Patterns)
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
  rule getFreeVariables(gt(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(select(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(union(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(disjoint(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(disjointUnion(P1, P2), .Patterns)
    => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(singleton(P1), .Patterns) => getFreeVariables(P1, .Patterns)
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

The configuration consists of a Assoc-Commutative bag of goals. Only goals
marked `<active>` are executed to control the non-determinism in the system. The
`<k>` cell contains the Matching Logic Pattern that is being proved. The
`<strategy>` cell contains an imperative language that controls which proof
rules are used to complete the goal. The trace cell stores a log of
the strategies used in the search of a proof. Information here could be used
for constructing a proof object.

```k
module MATCHING-LOGIC-PROVER-CONFIGURATION
  imports KORE-SUGAR
  imports DOMAINS-SYNTAX

  syntax Pgm
  syntax Strategy
```

```k
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

The "strategy" language is an imperative language for describing which proof rules
to apply to complete the proof.

```k
module MATCHING-LOGIC-PROVER-CORE-SYNTAX
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
module MATCHING-LOGIC-PROVER-CORE
  imports MATCHING-LOGIC-PROVER-CONFIGURATION
```

```k
  imports MATCHING-LOGIC-PROVER-CORE-SYNTAX
  imports KORE-HELPERS
  imports SUBSTITUTION
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

The `goalStrat(Int)` strategy is used to establish a refernce to the result of another
goal. It's argument holds the id of a subgoal. Once that subgoal has completed,
its result is replaced in the parent goal and the subgoal is removed.

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
module MATCHING-LOGIC-PROVER-HORN-CLAUSE-SYNTAX
  imports INT-SYNTAX
  imports KORE-SUGAR

  syntax Strategy ::= "search-bound" "(" Int ")"
                    | "simplify" | "substitute-equals-for-equals" | "direct-proof"
                    | "left-unfold" | "left-unfold-Nth" "(" Int ")"
                    | "right-unfold" | "right-unfold-Nth" "(" Int "," Int ")"
                    | "kt" | "kt" "#" KTFilter "#" KTInstantiate

  syntax KTFilter ::= head(RecursivePredicate)
                    | index(Int)
                    | ".KTFilter"
  syntax KTInstantiate ::= "useAffectedHeuristic"
                         | freshPositions(Ints)
endmodule
```

```k
module MATCHING-LOGIC-PROVER-HORN-CLAUSE
  imports MATCHING-LOGIC-PROVER-CORE
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE-SYNTAX
```

### Search Bound

```k
  rule <strategy> search-bound(0) => fail </strategy>
  rule <strategy> search-bound(N)
               => simplify ; ( direct-proof
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
  rule <k> \implies(\and(LHS), \and(RHS)) => \implies(\and(LHS), \and(RHS -BasicPatterns LHS)) ... </k>
       <strategy> simplify => noop ... </strategy>
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

  rule <k> \implies(\and(LHS), \and(RHS)) ... </k>
       <strategy> substitute-equals-for-equals => simplify ... </strategy>
    requires ?EQUALITY_SUBST ==K makeEqualitySubstitution(LHS)
     andBool ?EQUALITY_SUBST ==K .Map

  syntax Map ::= makeEqualitySubstitution(BasicPatterns) [function]
  rule makeEqualitySubstitution(.Patterns) => .Map
  rule makeEqualitySubstitution(\equals(X:Variable, T), Ps) => (X |-> T) .Map
  rule makeEqualitySubstitution(\equals(T, X:Variable), Ps) => (X |-> T) .Map
    requires notBool(isVariable(T))
  rule makeEqualitySubstitution((P, Ps:BasicPatterns)) => makeEqualitySubstitution(Ps) [owise]

  syntax BasicPatterns ::= removeTrivialEqualities(BasicPatterns) [function]
  rule removeTrivialEqualities(.Patterns) => .Patterns
  rule removeTrivialEqualities(\equals(X, X), Ps) => removeTrivialEqualities(Ps)
  rule removeTrivialEqualities(P, Ps) => P, removeTrivialEqualities(Ps) [owise]
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
  syntax Bool ::= checkValid(ImplicativeForm) [function]
  rule checkValid(\implies(_, \and ( .Patterns ))) => true:Bool
  rule checkValid(_) => false:Bool [owise]
```

Some "hard-wire" direct-proof rules.

```k
  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
```

Temp: needed by `listSegmentLeft -> listSegmentRight`

```k
  rule checkValid(
      \implies ( \and ( \not ( \equals ( Y_3 , select ( H , Y_3 ) ) )
                      , gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( X_32 , select ( H , Y_3 ) )
                      , \equals ( F_31 , emptyset )
                      , .Patterns )
               )
               ) => true
  requires removeDuplicates(H, Y_3, F_31, X_32, .Patterns)
      ==K (H, Y_3, F_31, X_32, .Patterns)

  rule checkValid(
      \implies ( \and ( \not ( \equals ( X , Y ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( Y , select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , \not ( \equals ( X , Y_3 ) )
                      , gt ( X , 0 )
                      , .Patterns )
               , \and ( \not ( \equals ( X_28 , Y ) )
                      , \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                      , disjoint ( F_27 , singleton ( Y_3 ) )
                      , .Patterns )
               )
               ) => true
  requires removeDuplicates(  F, F_2, F_27, F_38, H, X, X_28, Y, Y_3, .Patterns)
       ==K (  F, F_2, F_27, F_38, H, X, X_28, Y, Y_3, .Patterns)

  rule checkValid(
        \implies ( \and ( \not ( \equals ( X , Y ) )
                        , gt ( X , 0 )
                        , \equals ( select ( H , X ) , T )
                        , \equals ( F , union ( F2 , singleton ( X ) ) )
                        , disjoint ( F2 , singleton ( X ) )
                        , \equals ( T , Y )
                        , \equals ( F2 , emptyset )
                        , .Patterns )
                 , \and ( \not ( \equals ( X , Y ) )
                        , \equals ( Y , select ( H , Y2 ) )
                        , \equals ( F , union ( F1 , singleton ( Y2 ) ) )
                        , disjoint ( F1 , singleton ( Y2 ) )
                        , \equals ( X , Y2 )
                        , \equals ( F1 , emptyset )
                        , .Patterns ) )
                 ) => true:Bool
    requires removeDuplicates(X, Y, H, T, F, F2, Y2, F1, .Patterns)
         ==K                 (X, Y, H, T, F, F2, Y2, F1, .Patterns)

  rule checkValid(
            \implies ( \and ( \not ( \equals ( Y_3 , select ( H , Y_3 ) ) )
                                  , gt ( Y_3 , 0 )
                                  , disjoint ( emptyset , singleton ( Y_3 ) )
                                  , .Patterns )
                     , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 31 ) { Int } )
                            , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 30 ) { Set } , singleton ( Y_3 ) ) )
                            , disjoint ( variable ( "F" , 30 ) { Set } , singleton ( Y_3 ) )
                            , \equals ( variable ( "X" , 31 ) { Int } , select ( H , Y_3 ) )
                            , \equals ( variable ( "F" , 30 ) { Set } , emptyset )
                            , .Patterns )
                     )
                  ) => true

  rule checkValid(
      \implies ( \and ( \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , T )
                      , \equals ( F , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
                      , \equals ( T , Y )
                      , \equals ( F1 , emptyset )
                      , .Patterns )
               , \and ( gt ( Y7 , 0 )
                      , \equals ( Y , select ( H , Y7 ) )
                      , \equals ( F , union ( F6 , singleton ( Y7 ) ) )
                      , disjoint ( F6 , singleton ( Y7 ) )
                      , \equals ( X , Y7 )
                      , \equals ( F6 , emptyset )
                      , .Patterns ) )
                 ) => true:Bool
    requires removeDuplicates(X, Y, H, T, F, F1, Y7, F6, .Patterns)
         ==K                 (X, Y, H, T, F, F1, Y7, F6, .Patterns)

  rule checkValid(
      \implies ( \and ( \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , T )
                      , \equals ( F , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
                      , \not ( \equals ( T , Y ) )
                      , gt ( Y3 , 0 )
                      , \equals ( Y , select ( H , Y3 ) )
                      , \equals ( F1 , union ( F1 , singleton ( Y3 ) ) )
                      , disjoint ( F1 , singleton ( Y3 ) )
                      , .Patterns
                      )
               , \and ( \equals ( F23 , union ( F1 , singleton ( X ) ) )
                      , .Patterns
                      )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F1, F23, F1, H, T, X, Y, Y3, .Patterns)
         ==K                 (F, F1, F23, F1, H, T, X, Y, Y3, .Patterns)

  rule checkValid(
         \implies ( \and ( \not ( \equals ( X , Y ) )
                         , gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F , union ( F1 , singleton ( X ) ) )
                         , disjoint ( F1 , singleton ( X ) )
                         , \not ( \equals ( T , Y ) )
                         , gt ( Y3 , 0 )
                         , \equals ( Y , select ( H , Y3 ) )
                         , \equals ( F1 , union ( F2 , singleton ( Y3 ) ) )
                         , disjoint ( F2 , singleton ( Y3 ) )
                         , .Patterns
                         )
                  , \and ( \not ( \equals ( X , Y3 ) )
                         , \equals ( F23 , union ( F2 , singleton ( X ) ) )
                         , disjoint ( F2 , singleton ( X ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)
        ==K                  (F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)

  rule checkValid(
      \implies ( \and ( listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( F , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , .Patterns )
               , \and ( \equals ( K_10 , union ( F_2 , G ) )
                      , disjoint ( F_2 , G )
                      , .Patterns ) )
               ) => true:Bool
    requires removeDuplicates(F, F_2,  G,  H,  K,  K_10,  MAX,  MIN,  MIN2,  VAL_4,  X,  X_3,  Y, .Patterns)
         ==K                 (F, F_2,  G,  H,  K,  K_10,  MAX,  MIN,  MIN2,  VAL_4,  X,  X_3,  Y, .Patterns)

  rule checkValid(
      \implies ( \and ( \not ( \equals ( Y_3 , select ( H , Y_3 ) ) ) , gt ( Y_3 , 0 ) , disjoint ( emptyset , singleton ( Y_3 ) ) , .Patterns ) , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 32 ) { Int } ) , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) ) ) , disjoint ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) ) , \equals ( variable ( "X" , 32 ) { Int } , select ( H , Y_3 ) ) , \equals ( variable ( "F" , 31 ) { Set } , emptyset ) , .Patterns ) )
       ) => true


  rule checkValid(
\implies ( \and ( \not ( \equals ( Y_3 , select ( H , Y_3 ) ) )
                      , gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 27 ) { Int } )
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 26 ) { Set } , singleton ( Y_3 ) ) )
                      , disjoint ( variable ( "F" , 26 ) { Set } , singleton ( Y_3 ) )
                      , \equals ( variable ( "X" , 27 ) { Int } , select ( H , Y_3 ) )
                      , \equals ( variable ( "F" , 26 ) { Set } , emptyset )
                      , .Patterns )
               )
                ) => true

  rule checkValid(
      \implies ( \and ( \not ( \equals ( X , Y ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( K, select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , \equals ( X , Y_3 )
                      , \equals ( F_2 , emptyset )
                      , .Patterns )
               , \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_35 )
                      , \equals ( F , union ( F_34 , singleton ( X ) ) )
                      , disjoint ( F_34 , singleton ( X ) )
                      , \equals ( X_35 , Y )
                      , \equals ( F_34 , emptyset )
                      , .Patterns )
             )) => true
 requires removeDuplicates(F, F_2, F_34, H, X, X_35, Y, Y_3, .Patterns)
      ==K                 (F, F_2, F_34, H, X, X_35, Y, Y_3, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( K , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , gt ( Length , 0 )
                      , \equals ( LENGTH_4 , minus ( Length , 1 ) )
                      , listLength ( H , X_3 , F_2 , LENGTH_4 , .Patterns )
                      , .Patterns )
               , \and ( listLength ( H , X_31 , F_30 , LENGTH_32 , .Patterns )
                      , \equals ( select ( H , X ) , X_31 )
                      , \equals ( K , union ( F_30 , singleton ( X ) ) )
                      , disjoint ( F_30 , singleton ( X ) )
                      , \equals ( LENGTH_32 , minus ( Length , 1 ) )
                      , .Patterns )
               )
       ) => true
  requires removeDuplicates(F_2, F_30, H, K, LENGTH_32, LENGTH_4, Length, MIN, VAL_4, X, X_3, X_31, .Patterns)
       ==K                 (F_2, F_30, H, K, LENGTH_32, LENGTH_4, Length, MIN, VAL_4, X, X_3, X_31, .Patterns)

  rule checkValid(
      \implies ( \and ( listSorted ( H , Y  , G , MIN2 , .Patterns )
                      , \equals ( K  , union ( F  , G  ) )
                      , disjoint ( F  , G  )
                      , \not ( gt ( MAX , MIN2 ) )
                      , \equals ( X  , Y  )
                      , \equals ( F  , emptyset )
                      , .Patterns )
               , \and ( listSorted ( H  , X  , K  , MIN  , .Patterns )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F, G, H, K, MAX, MIN, MIN2, X, Y, .Patterns)
         ==K                 (F, G, H, K, MAX, MIN, MIN2, X, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , Y , Z , F2 , LENGTH2 , .Patterns ) 
                      , \equals ( F , union ( F1 , F2 ) ) 
                      , disjoint ( F1 , F2 ) 
                      , \equals ( LENGTH , plus ( LENGTH1 , LENGTH2 ) ) 
                      , \equals ( X , Y ) 
                      , \equals ( F1 , emptyset ) 
                      , \equals ( LENGTH1 , 0 ) 
                      , .Patterns ) 
               , \and ( listSegmentRightLength ( H , X , Z , F , LENGTH , .Patterns ) 
                      , .Patterns ) 
               ) )
        => true
    requires removeDuplicates(F, F1, F2, H, LENGTH, LENGTH1, LENGTH2, X, Y, Z, .Patterns)
         ==K                 (F, F1, F2, H, LENGTH, LENGTH1, LENGTH2, X, Y, Z, .Patterns)
    
rule checkValid(
      \implies ( \and ( listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( F , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K_12 , union ( F_2 , G ) )
                      , disjoint ( F_2 , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , listSorted ( H , X_3 , K_12 , VAL_4 , .Patterns )
                      , .Patterns )
               , \and ( listSorted ( H , X_27 , F_26 , VAL_28 , .Patterns )
                      , \equals ( select ( H , X ) , X_27 )
                      , \equals ( K , union ( F_26 , singleton ( X ) ) )
                      , disjoint ( F_26 , singleton ( X ) )
                      , \equals ( VAL_28 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_28 , MIN )
                      , .Patterns ) )
                ) => true:Bool
  requires removeDuplicates(F, F_2, F_26, G, H, K, K_12, MAX, MIN, MIN2, VAL_28, VAL_4, X, X_27, X_3, Y, .Patterns)
       ==K                 (F, F_2, F_26, G, H, K, K_12, MAX, MIN, MIN2, VAL_28, VAL_4, X, X_27, X_3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns ) 
                      , \equals ( F , union ( FA , FB ) ) 
                      , disjoint ( FA , FB ) 
                      , \equals ( LENGTH , plus ( LA , LB ) ) 
                      , \not ( \equals ( Y , Z ) ) 
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) ) 
                      , gt ( Y_3 , 0 ) 
                      , \equals ( Z , select ( H , Y_3 ) ) 
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) ) 
                      , disjoint ( F_2 , singleton ( Y_3 ) ) 
                      , listSegmentRightLength ( H , X , Y , FA , LA , .Patterns ) 
                      , \equals ( F_10 , union ( FA , F_2 ) ) 
                      , disjoint ( FA , F_2 ) 
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) ) 
                      , listSegmentRightLength ( H , X , Y_3 , F_10 , LENGTH_9 , .Patterns ) 
                      , .Patterns ) 
               , \and ( listSegmentRightLength ( H , X , Y_25 , F_24 , LENGTH_24 , .Patterns ) 
                      , \not ( \equals ( X , Z ) ) 
                      , \equals ( LENGTH_24 , minus ( LENGTH , 1 ) ) 
                      , gt ( Y_25 , 0 ) 
                      , \equals ( Z , select ( H , Y_25 ) ) 
                      , \equals ( F , union ( F_24 , singleton ( Y_25 ) ) ) 
                      , disjoint ( F_24 , singleton ( Y_25 ) ) 
                      , .Patterns ) 
               )) => true
    requires removeDuplicates( F , F_10 , F_2 , F_24 , FA , FB , H , LA , LB , LENGTH , LENGTH_2 , LENGTH_24 , LENGTH_9 , X , Y , Y_25 , Y_3 , Z , .Patterns)
         ==K ( F , F_10 , F_2 , F_24 , FA , FB , H , LA , LB , LENGTH , LENGTH_2 , LENGTH_24 , LENGTH_9 , X , Y , Y_25 , Y_3 , Z , .Patterns)

  rule checkValid(
         \implies ( \and ( \not ( \equals ( X , Y ) )
                         , gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F , union ( F1 , singleton ( X ) ) )
                         , disjoint ( F1 , singleton ( X ) )
                         , \not ( \equals ( T , Y ) )
                         , gt ( Y3 , 0 )
                         , \equals ( Y , select ( H , Y3 ) )
                         , \equals ( F1 , union ( F2 , singleton ( Y3 ) ) )
                         , disjoint ( F2 , singleton ( Y3 ) )
                         , \not ( \equals ( X , Y3 ) )
                         , gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F23 , union ( F2 , singleton ( X ) ) )
                         , disjoint ( F2 , singleton ( X ) )
                         , listSegmentRight ( H , X , Y3 , F23 , .Patterns )
                         , .Patterns )
                  , \and ( listSegmentRight ( H , X , Y53 , F52 , .Patterns )
                         , gt ( Y53 , 0 )
                         , \equals ( Y , select ( H , Y53 ) )
                         , \equals ( F , union ( F52 , singleton ( Y53 ) ) )
                         , disjoint ( F52 , singleton ( Y53 ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)
         ==K                 (F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)

  rule checkValid(
         \implies ( \and ( list ( H , Y , G , .Patterns )
                         , \equals ( K , union ( F , G ) )
                         , disjoint ( F , G )
                         , \equals ( X , Y )
                         , \equals ( F , emptyset )
                         , .Patterns
                         )
                  , \and ( list ( H , X , K , .Patterns )
                         , .Patterns
                         )
                  )
                ) => true:Bool
      requires removeDuplicates(F, G, H, K, X, Y, .Patterns)
           ==K                 (F, G, H, K, X, Y, .Patterns)

  rule checkValid(
          \implies ( \and ( list ( H , Y , G , .Patterns )
                          , \equals ( K , union ( F , G ) )
                          , disjoint ( F , G )
                          , \not ( \equals ( X , Y ) )
                          , gt ( X , 0 )
                          , \equals ( select ( H , X ) , X3 )
                          , \equals ( F , union ( F2 , singleton ( X ) ) )
                          , disjoint ( F2 , singleton ( X ) )
                          , .Patterns )
                   , \and ( \equals ( K9 , union ( F2 , G ) )
                          , disjoint ( F2 , G )
                          , .Patterns )
                   )
                 ) => true:Bool
    requires removeDuplicates(F, F2, G, H, K, K9, X, X3, Y, .Patterns)
        ==K                  (F, F2, G, H, K, K9, X, X3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( list ( H , Y , G , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X3 )
                      , \equals ( F , union ( F2 , singleton ( X ) ) )
                      , disjoint ( F2 , singleton ( X ) )
                      , list ( H , Y , G , .Patterns )
                      , \equals ( K9 , union ( F2 , G ) )
                      , disjoint ( F2 , G )
                      , list ( H , X3 , K9 , .Patterns )
                      , .Patterns
                      )
               , \and ( list ( H , X19 , F18 , .Patterns )
                      , \equals ( select ( H , X ) , X19 )
                      , \equals ( K , union ( F18 , singleton ( X ) ) )
                      , disjoint ( F18 , singleton ( X ) )
                      , .Patterns
                      )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F18, F2, G, H, K, K9, X, X19, X3, Y, .Patterns)
         ==K                 (F, F18, F2, G, H, K, K9, X, X19, X3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , plus ( X , 1 ) ) , 0 )
                      , \equals ( select ( H , plus ( X , 2 ) ) , 0 )
                      , \equals ( MIN , X )
                      , \equals ( MAX , X )
                      , \equals ( F , singleton ( X ) )
                      , .Patterns )
               , \and ( \equals ( X26 , select ( H , plus ( X , 1 ) ) )
                      , \equals ( X29 , select ( H , plus ( X , 2 ) ) )
                      , \not ( isMember ( X , F28 ) )
                      , \not ( isMember ( X , F27 ) )
                      , \equals ( F , union ( singleton ( X ) , union ( F28 , F27 ) ) )
                      , disjoint ( F28 , F27 )
                      , \equals ( X26 , 0 )
                      , \equals ( F28 , emptyset )
                      , \equals ( X29 , 0 )
                      , \equals ( F27 , emptyset )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F27, F28, H, MAX, MIN, X, X26, X29, .Patterns)
         ==K                 (F, F27, F28, H, MAX, MIN, X, X26, X29, .Patterns)

  rule checkValid(
        \implies ( \and ( gt ( X , 0 )
                             , \equals ( select ( H , plus ( X , 1 ) ) , X2 )
                             , \equals ( select ( H , plus ( X , 2 ) ) , X9 )
                             , gt ( X , MAX6 )
                             , gt ( MIN7 , X )
                             , \equals ( MIN8 , MIN )
                             , \equals ( MAX5 , MAX )
                             , \not ( isMember ( X , F4 ) )
                             , \not ( isMember ( X , F3 ) )
                             , \equals ( F , union ( singleton ( X ) , union ( F4 , F3 ) ) )
                             , disjoint ( F4 , F3 )
                             , bt ( H , X9 , F3 , .Patterns )
                             , bt ( H , X2 , F4 , .Patterns )
                             , .Patterns )
                 , \and ( bt ( H , X87 , F89 , .Patterns )
                        , bt ( H , X90 , F88 , .Patterns )
                        , \equals ( X87 , select ( H , plus ( X , 1 ) ) )
                        , \equals ( X90 , select ( H , plus ( X , 2 ) ) )
                        , \not ( isMember ( X , F89 ) )
                        , \not ( isMember ( X , F88 ) )
                        , \equals ( F , union ( singleton ( X ) , union ( F89 , F88 ) ) )
                        , disjoint ( F89 , F88 )
                        , .Patterns )
                 )
                 ) => true:Bool
    requires removeDuplicates(F, F3, F4, F88, F89, H, MAX, MAX5, MAX6, MIN, MIN7, MIN8, X, X2, X87, X9, X90, .Patterns)
         ==K                 (F, F3, F4, F88, F89, H, MAX, MAX5, MAX6, MIN, MIN7, MIN8, X, X2, X87, X9, X90, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X3 )
                      , \equals ( K , union ( F2 , singleton ( X ) ) )
                      , disjoint ( F2 , singleton ( X ) )
                      , \equals ( VAL4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL4 , MAX )
                      , list ( H , X3 , F2 , .Patterns )
                      , .Patterns )
               , \and ( list ( H , X27 , F26 , .Patterns )
                      , \equals ( select ( H , X ) , X27 )
                      , \equals ( K , union ( F26 , singleton ( X ) ) )
                      , disjoint ( F26 , singleton ( X ) )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F2, F26, H, K, MAX, VAL4, X, X27, X3, .Patterns)
         ==K                 (F2, F26, H, K, MAX, VAL4, X, X27, X3, .Patterns)

/* find */

  rule checkValid(
         \implies ( \and ( find-list ( H0 ,  X ,  F0 , .Patterns )
                         , \equals (  X ,  OLDX )
                         , \equals (  TMP , 0 )
                         , .Patterns )
                  , \and ( disjoint (  F1 ,  F2 )
                         , \not ( isMember (  DATA ,  F1 ) )
                         , \equals (  OLDX ,  X )
                         , \equals (  F1 , emptyset )
                         , .Patterns )
                  )) => true:Bool
  requires (F1, F2, DATA, .Patterns) notOccurFree (H0, X, F0, X, OLDX, TMP, .Patterns)

  /* needed in find-in-loop */

  rule checkValid(
            \implies ( \and ( find-list-seg ( H0 , OLDX , X , F1 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \not ( isMember ( DATA , F1 ) )
                            , gt ( X , 0 )
                            , gt ( X , DATA )
                            , \equals ( X2 , select ( H0 , plus ( X , 1 ) ) )
                            , \equals ( F3 , add ( F1 , X ) )
                            , \equals ( F4 , del ( F2 , X ) )
                            , \equals ( X , 0 )
                            , \equals ( F2 , emptyset )
                            , .Patterns )
                     , \and ( find-list ( H0 , X2 , F4 , .Patterns )
                            , disjoint ( F3 , F4 )
                            , \not ( isMember ( DATA , F3 ) )
                            , find-list-seg ( H0 , OLDX , Y_2 , F_1 , .Patterns )
                            , gt ( Y_2 , 0 )
                            , \equals ( X2 , select ( H0 , plus ( Y_2 , 1 ) ) )
                            , \equals ( F3 , add ( F_1 , Y_2 ) )
                            , \not ( isMember ( Y_2 , F_1 ) )
                            , .Patterns )
                     )
            )
        => true:Bool
    requires removeDuplicates(DATA, F_1, F1, F2, F3, F4, H0, OLDX, X, X2, Y_2, .Patterns)
         ==K                 (DATA, F_1, F1, F2, F3, F4, H0, OLDX, X, X2, Y_2, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 32 ) { Int } )
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) ) )
                      , disjoint ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) )
                      , \equals ( variable ( "X" , 32 ) { Int } , select ( H , Y_3 ) )
                      , \equals ( variable ( "F" , 31 ) { Set } , emptyset )
                      , .Patterns )
               )
       ) => true

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                       , \equals ( F , union ( FA , FB ) )  
                       , disjoint ( FA , FB )  
                       , \equals ( LENGTH , plus ( LA , LB ) )  
                       , \equals ( Y , Z )  
                       , \equals ( FB , emptyset )  
                       , \equals ( LB , 0 )  
                       , .Patterns ) 
               , \and ( listSegmentRightLength ( H , X , Z , F , LENGTH , .Patterns ) 
                      , .Patterns ) 
               )
       ) => true
    requires removeDuplicates(F, FA, FB, H, LA, LB, LENGTH, X, Y, Z, .Patterns)
         ==K                 (F, FA, FB, H, LA, LB, LENGTH, X, Y, Z, .Patterns)
         
  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns ) 
                      , \equals ( F , union ( FA , FB ) ) 
                      , disjoint ( FA , FB ) 
                      , \equals ( LENGTH , plus ( LA , LB ) ) 
                      , \not ( \equals ( Y , Z ) ) 
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) ) 
                      , gt ( Y_3 , 0 ) 
                      , \equals ( Z , select ( H , Y_3 ) ) 
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) ) 
                      , disjoint ( F_2 , singleton ( Y_3 ) ) 
                      , .Patterns ) 
               , \and ( \equals ( F_10 , union ( FA , F_2 ) ) 
                      , disjoint ( FA , F_2 ) 
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) ) 
                      , .Patterns ) 
               )) => true
    requires removeDuplicates(F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)
         ==K                 (F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)

  rule checkValid(
            \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns ) 
                      , \equals ( F , union ( FA , FB ) ) 
                      , disjoint ( FA , FB ) 
                      , \equals ( LENGTH , plus ( LA , LB ) ) 
                      , \not ( \equals ( Y , Z ) ) 
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) ) 
                      , gt ( Y_3 , 0 ) 
                      , \equals ( Z , select ( H , Y_3 ) ) 
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) ) 
                      , disjoint ( F_2 , singleton ( Y_3 ) ) 
                      , .Patterns ) 
               , \and ( \equals ( F_10 , union ( FA , F_2 ) ) 
                      , disjoint ( FA , F_2 ) 
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) ) 
                      , .Patterns ) 
               )) => true
     requires removeDuplicates(F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)
          ==K                 (F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)

  rule checkValid(
            \implies ( \and ( gt ( Y_3 , 0 )
                                  , \equals ( Y , select ( H , Y_3 ) )
                                  , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                                  , disjoint ( F_2 , singleton ( Y_3 ) )
                                  , gt ( X , 0 )
                                  , \equals ( select ( H , X ) , X_28 )
                                  , \equals ( F_2 , union ( F_27 , singleton ( X ) ) )
                                  , disjoint ( F_27 , singleton ( X ) )
                                  , gt ( Y_3 , 0 )
                                  , \equals ( Y , select ( H , Y_3 ) )
                                  , \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                                  , disjoint ( F_27 , singleton ( Y_3 ) )
                                  , listSegmentLeftWeak ( H , X_28 , Y , F_38 , .Patterns )
                                  , .Patterns )
                           , \and ( listSegmentLeftWeak ( H , X_56 , Y , F_55 , .Patterns )
                                  , \equals ( select ( H , X ) , X_56  )
                                  , \equals ( F , union ( F_55 , singleton ( X ) ) )
                                  , disjoint ( F_55 , singleton ( X ) )
                                  , .Patterns )
                           )
                ) => true
            requires removeDuplicates(F, F_2, F_27, F_38, F_55, H, X, X_28, Y, Y_3, .Patterns)
                 ==K                 (F, F_2, F_27, F_38, F_55, H, X, X_28, Y, Y_3, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , \equals ( Y , select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_28 )
                      , \equals ( F_2 , union ( F_27 , singleton ( X ) ) )
                      , disjoint ( F_27 , singleton ( X ) )
                      , .Patterns )
               , \and ( \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                      , disjoint ( F_27 , singleton ( Y_3 ) )
                      , .Patterns )
               )
        ) => true

  rule checkValid(
      \implies ( \and ( list ( H , Y , F2 , .Patterns )
                      , disjoint ( F1 , F2 )
                      , \equals ( F , union ( F1 , F2 ) )
                      , \equals ( X , Y )
                      , \equals ( F1 , emptyset )
                      , .Patterns )
               , \and ( list ( H , X , F , .Patterns ) , .Patterns ) ) ) => true
    requires removeDuplicates(F, F1, F2, H, X, Y, .Patterns)
         ==K                 (F, F1, F2, H, X, Y, .Patterns)

  rule checkValid(
        \implies ( \and ( list ( H , Y , G2 , .Patterns )
                              , disjoint ( G1 , G2 )
                              , \equals ( F , union ( G1 , G2 ) )
                              , \not ( \equals ( X , Y ) )
                              , gt ( Y_3 , 0 )
                              , \equals ( Y , select ( H , Y_3 ) )
                              , \equals ( G1 , union ( F_2 , singleton ( Y_3 ) ) )
                              , disjoint ( F_2 , singleton ( Y_3 ) )
                              , .Patterns )
                        , \and ( disjoint ( F_2 , G2_10 )
                               , \equals ( F , union ( F_2 , G2_10 ) )
                               , list ( H , X_15 , F_14 , .Patterns )
                               , \equals ( select ( H , Y_3 ) , X_15 )
                               , \equals ( G2_10 , union ( F_14 , singleton ( Y_3 ) ) )
                               , disjoint ( F_14 , singleton ( Y_3 ) )
                               , .Patterns )
                        )
                 ) => true
      requires removeDuplicates(F, F_14, F_2, G1, G2, G2_10, H, X, X_15, Y, Y_3, .Patterns)
           ==K                 (F, F_14, F_2, G1, G2, G2_10, H, X, X_15, Y, Y_3, .Patterns)

rule checkValid(
            \implies ( \and ( find-list-seg ( H0 , OLDX , X , F1 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \not ( isMember ( DATA , F1 ) )
                            , gt ( X , 0 )
                            , gt ( X , DATA )
                            , \equals ( X2 , select ( H0 , plus ( X , 1 ) ) )
                            , \equals ( F3 , add ( F1 , X ) )
                            , \equals ( F4 , del ( F2 , X ) )
                            , find-list ( H0 , X_4 , F_3 , .Patterns )
                            , gt ( X , 0 )
                            , \equals ( select ( H0 , plus ( X , 1 ) ) , X_4 )
                            , \equals ( F2 , add ( F_3 , X ) )
                            , \not ( isMember ( X , F_3 ) )
                            , .Patterns )
                     , \and ( find-list ( H0 , X2 , F4 , .Patterns )
                            , disjoint ( F3 , F4 )
                            , \not ( isMember ( DATA , F3 ) )
                            , find-list-seg ( H0 , OLDX , Y_2 , F_1 , .Patterns )
                            , gt ( Y_2 , 0 )
                            , \equals ( X2 , select ( H0 , plus ( Y_2 , 1 ) ) )
                            , \equals ( F3 , add ( F_1 , Y_2 ) )
                            , \not ( isMember ( Y_2 , F_1 ) )
                            , .Patterns )
                     )
              ) => true:Bool
    requires removeDuplicates(DATA, F_1, F_3, F1, F2, F3, F4, H0, OLDX, X, X_4, X2, Y_2, .Patterns)
         ==K                 (DATA, F_1, F_3, F1, F2, F3, F4, H0, OLDX, X, X_4, X2, Y_2, .Patterns)

  /* used in find-after-loop1 */
  rule checkValid(
            \implies ( \and ( find-list ( H0 , X , F2 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \equals ( F3 , union ( F1 , F2 ) )
                            , \equals ( OLDX , X )
                            , \equals ( F1 , emptyset )
                            , .Patterns )
                     , \and ( find-list ( H0 , OLDX , F3 , .Patterns )
                            , .Patterns ) )
            ) => true:Bool
    requires removeDuplicates(F1, F2, F3, H0, OLDX, X, .Patterns)
         ==K                 (F1, F2, F3, H0, OLDX, X, .Patterns)

  /* used in dll */
  rule checkValid(
            \implies ( \and ( dll ( variable ( "H" ) { ArrayIntInt } 
                                  , variable ( "Y" ) { Int } 
                                  , variable ( "G" ) { Set } 
                                  , .Patterns ) 
                            , \equals ( variable ( "K" ) { Set } 
                            , union ( variable ( "F" ) { Set } 
                                    , variable ( "G" ) { Set } ) ) 
                            , disjoint ( variable ( "F" ) { Set } 
                            , variable ( "G" ) { Set } ) 
                            , \equals ( variable ( "X" ) { Int } 
                                      , variable ( "Y" ) { Int } ) 
                            , \equals ( variable ( "F" ) { Set } , emptyset ) 
                            , .Patterns ) 
                     , \and ( dll ( variable ( "H" ) { ArrayIntInt } 
                                  , variable ( "X" ) { Int } 
                                  , variable ( "K" ) { Set } 
                                  , .Patterns ) 
                            , .Patterns ) )
              ) => true:Bool

  rule checkValid(
            \implies ( \and ( dll ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , .Patterns ) 
                            , \equals ( variable ( "K" ) { Set } 
                            , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) 
                            , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) 
                            , \not ( \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) ) 
                            , gt ( variable ( "X" ) { Int } , 0 ) 
                            , gt ( variable ( "X" , 3 ) { Int } , 0 ) 
                            , \equals ( variable ( "X" , 3 ) { Int } 
                                      , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) 
                            , \equals ( variable ( "X" ) { Int } 
                                      , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) 
                            , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) 
                            , \equals ( variable ( "F" ) { Set } 
                                      , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) 
                            , .Patterns ) 
                     , \and ( \equals ( variable ( "K" , 9 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) 
                            , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , .Patterns ) )
) => true:Bool   

  rule checkValid(
\implies ( \and ( dll ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \not ( \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) ) , gt ( variable ( "X" ) { Int } , 0 ) , gt ( variable ( "X" , 3 ) { Int } , 0 ) , \equals ( variable ( "X" , 3 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , dll ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , .Patterns ) , \equals ( variable ( "K" , 9 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , dll ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "K" , 9 ) { Set } , .Patterns ) , .Patterns ) , \and ( dll ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 19 ) { Int } , variable ( "F" , 18 ) { Set } , .Patterns ) , gt ( variable ( "X" , 19 ) { Int } , 0 ) , \equals ( variable ( "X" , 19 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 19 ) { Int } , 2 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 18 ) { Set } ) ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" , 18 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , .Patterns ) )
) => true:Bool            


  rule checkValid(
\implies ( \and ( dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) , \equals ( variable ( "L" ) { Int } , 0 ) , \equals ( variable ( "F" ) { Set } , emptyset ) , .Patterns ) , \and ( dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } , variable ( "K" ) { Set } , variable ( "N" ) { Int } , .Patterns ) , .Patterns ) )
) => true:Bool

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

Unfold the Nth predicates on the Left hand side into a conjunction of implicatations.
The resulting goals are equivalent to the initial goal.

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

The strategy `right-unfold` can be highly nondeterministic, which makes debugging
and keeping track of the proofs difficult. Here we define a deterministic
strategy `right-unfold-Nth(M, N)`, which unfolds the `M`th recursive predicate
(on the right-hand side) to its `N`th body. When `M` or `N` is out of range,
`right-unfold(M,N) => fail`.

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

### Knaster Tarski

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
  rule findAffectedVariablesAux(    AFF , (COND,          REST))
    => findAffectedVariablesAux(    AFF ,                 REST )
       [owise]
  rule findAffectedVariablesAux(    AFF , .Patterns)
    => AFF
```

Definition of Recursive Predicates
==================================

TODO: Ideally, this would live as part of the test files, perhaps as `axioms`.
However, we currently use this in two differnt directions, one for
left-unfolding and the other for right unfolding. Each unfold rule would thus be
equivalent to a set of axioms for each body: `BODY_i -> Predicate(ARGS)` and
another axiom `Predicate(ARGS) -> or(BODIES)`.

```k
  syntax DisjunctiveForm ::= "unfold" "(" BasicPattern ")" [function]

  /* listSegmentLeft */
  rule unfold(listSegmentLeft(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentLeft( H
                                    , variable("X", !I) { Int }
                                    , Y
                                    , variable("F", !J) { Set }
                                    , .Patterns
                                    )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , \equals( select(H, X)
                            , variable("X", !I) { Int }
                            )
                   , \equals( F
                            , union(variable("F", !J) { Set } , singleton(X))
                            )
                   , disjoint(variable("F", !J) { Set } , singleton(X))
                   , .Patterns
                   )
             )

  rule unfold(listSegmentLeftSorted(H, X, Y, F, PREV_VAL, MAX, .Patterns))
    => \or( \and( \equals(X, Y)
                , \equals(F, emptyset)
                , .Patterns
                )
          , \and( listSegmentLeftSorted( H
                                       , variable("X", !I) { Int }
                                       , Y
                                       , variable("F", !J) { Set }
                                       , variable("VAL", !K) { Int }
                                       , MAX
                                       , .Patterns
                                       )
                , \not(\equals(X, Y))
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))

                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                // Strictly decreasing
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , \not(gt(variable("VAL", !K) { Int }, MAX))
                , .Patterns
                )
          )

  /* listSegmentRight */
  rule unfold(listSegmentRight(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentRight( H
                              , X
                              , variable("Y", !I) { Int }
                              , variable("F", !J) { Set }
                              , .Patterns
                              )
                   , \not(\equals(X, Y))
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, variable("Y", !I) { Int }))
                   , \equals( F
                            , union( variable("F", !J) { Set }
                                   , singleton(variable("Y", !I) { Int })
                                   )
                            )
                   , disjoint( variable("F", !J) { Set }
                             , singleton(variable("Y", !I) { Int })
                             )
                   , .Patterns
                   )
             )

 rule unfold(listSegmentRightLength(H,X,Y,F,LENGTH,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , \equals(LENGTH, 0)
                   , .Patterns
                   )
             , \and( listSegmentRightLength( H
                                           , X
                                           , variable("Y", !I) { Int }
                                           , variable("F", !J) { Set }
                                           , variable("LENGTH", !J) { Int }
                                           , .Patterns
                                           )
                   , \not(\equals(X, Y))
                   , \equals(variable("LENGTH", !J) { Int }, minus(LENGTH, 1))
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, variable("Y", !I) { Int }))
                   , \equals( F
                            , union( variable("F", !J) { Set }
                                   , singleton(variable("Y", !I) { Int })
                                   )
                            )
                   , disjoint( variable("F", !J) { Set }
                             , singleton(variable("Y", !I) { Int })
                             )
                   , .Patterns
                   )
             )

  rule unfold(isEmpty(S, .Patterns)) => \or ( \and ( \equals(S, emptyset), .Patterns ) )

  /* list */
  rule unfold(list(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( list(H,variable("X", !I) { Int },variable("F", !J) { Set },.Patterns)
                   , gt(X,0)
                   , \equals(select(H, X) , variable("X", !I) { Int })
                   , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                   , disjoint(variable("F", !J) { Set }, singleton(X))
                   , .Patterns
                   )
             )

  rule unfold(listLength(H,X,F, LENGTH,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , \equals(LENGTH, 0)
                   , .Patterns
                   )
             , \and( listLength(H,variable("X", !I) { Int },variable("F", !J) { Set }, variable("LENGTH", !K) { Int }, .Patterns)
                   , gt(X,0)
                   , \equals(select(H, X) , variable("X", !I) { Int })
                   , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                   , disjoint(variable("F", !J) { Set }, singleton(X))
                   , gt(LENGTH, 0)
                   , \equals(variable("LENGTH", !K) { Int }, minus(LENGTH, 1))
                   , .Patterns
                   )
             )

  rule unfold(listSorted(H, X, F, PREV_VAL:BasicPattern, .Patterns))
    => \or( \and( \equals(X, 0)
                , \equals(F, emptyset)
                , .Patterns
                )
          , \and( listSorted(H, variable("X", !I) { Int }, variable("F", !J) { Set }, variable("VAL", !K) { Int }, .Patterns)
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))
                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , .Patterns
                )
          )

  rule unfold(listSortedLength(H, X, F, PREV_VAL, LENGTH, .Patterns))
    => \or( \and( \equals(X, 0)
                , \equals(F, emptyset)
                , \equals(LENGTH, 0)
                , .Patterns
                )
          , \and( listSortedLength(H
                                  , variable("X", !I) { Int }
                                  , variable("F", !J) { Set }
                                  , variable("VAL", !K) { Int }
                                  , variable("LENGTH", !K) { Int }
                                  , .Patterns
                                  )
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))
                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , gt(LENGTH, 0)
                , \equals(variable("LENGTH", !K) { Int }, minus(LENGTH, 1))
                , .Patterns
                )
          )

  /* bt */
  rule unfold(bt(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( bt(H, variable("X", !I1) { Int }, variable("F", !J1) { Set }, .Patterns)
                   , bt(H, variable("X", !I2) { Int }, variable("F", !J2) { Set }, .Patterns)
                   , gt(X,0)
                   , \equals( variable("X", !I1) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( variable("X", !I2) { Int }
                            , select(H, plus(X, 2)))
                   , \not(isMember(X, variable("F", !J1) { Set }))
                   , \not(isMember(X, variable("F", !J2) { Set }))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1) { Set }
                                            , variable("F", !J2) { Set })))
                   , disjoint(variable("F", !J1) { Set }, variable("F", !J2) { Set })
                   , .Patterns
                   )
              )

  /* bst */
  rule unfold(bst(H,X,F,MIN,MAX,.Patterns))
       => \or( \and( \equals(X,0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( gt(X,0)
                   , \equals(select(H, plus(X, 1)), 0)
                   , \equals(select(H, plus(X, 2)), 0)
                   , \equals(MIN, X)
                   , \equals(MAX, X)
                   , \equals(F, singleton(X))
                   , .Patterns
                   )
             , \and( bst( H
                        , variable("X",   !I1) { Int }
                        , variable("F",   !J1) { Set }
                        , variable("MIN", !K1) { Int }
                        , variable("MAX", !L1) { Int }
                        , .Patterns
                        )
                   , bst( H
                        , variable("X",   !I2) { Int }
                        , variable("F",   !J2) { Set }
                        , variable("MIN", !K2) { Int }
                        , variable("MAX", !L2) { Int }
                        , .Patterns
                        )
                   , gt(X,0)
                   , \equals(select(H, plus(X, 1)), variable("X", !I1) { Int })
                   , \equals(select(H, plus(X, 2)), variable("X", !I2) { Int })
                   , gt(X, variable("MAX", !K1) { Int })
                   , gt(variable("MIN", !L2) { Int }, X)
                   , \equals(variable("MIN", !L1) { Int }, MIN)
                   , \equals(variable("MAX", !K2) { Int }, MAX)
                   , \not(isMember(X, variable("F", !J1) { Set }))
                   , \not(isMember(X, variable("F", !J2) { Set }))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1) { Set }
                                            , variable("F", !J2) { Set })))
                   , disjoint(variable("F", !J1) { Set }, variable("F", !J2) { Set })
                   , .Patterns
                   )
              )

/* dll */

  rule unfold(dll(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dll( H
                        , variable("X", !I) { Int }
                        , variable("F", !J) { Set }
                        , .Patterns
                        )
                   , gt(X, 0)
                   , gt(variable("X", !I) { Int } , 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllLength(H,X,F,L,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(L, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllLength( H
                        , variable("X", !I) { Int }
                        , variable("F", !J) { Set }
                        , variable("L", !K) { Int }
                        , .Patterns
                        )
                   , gt(X, 0)
                   , \equals(variable("L", !K) { Int }, minus(L, 1))
                   , gt(variable("X", !I) { Int } , 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentLeft(H,X,Y,F,L,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllSegmentLeft( H
                                   , variable("X", !I) { Int }
                                   , Y
                                   , variable("F", !J) { Set }
                                   , variable("L", !K) { Int }
                                   , .Patterns
                                   )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , \equals(variable("L", !K) { Int }, minus(L, 1))
                   , gt(variable("X", !I) { Int }, 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentLeftLength(H,X,Y,F,L,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(L, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllSegmentLeftLength( H
                                   , variable("X", !I) { Int }
                                   , Y
                                   , variable("F", !J) { Set }
                                   , .Patterns
                                   )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , gt(variable("X", !I) { Int }, 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentRight(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllSegmentRight( H
                                    , X
                                    , variable("Y", !I) { Int }
                                    , variable("F", !J) { Set }
                                    , .Patterns
                                    )
                   , gt(variable("Y", !I) { Int }, 0)
                   , gt(Y, 0)
                   , \equals( variable("Y", !I) { Int }
                            , select(H, plus(Y, 2)))
                   , \equals( Y
                            , select(H, plus(variable("Y", !I) { Int }, 1)))
                   , \not(isMember(variable("Y", !I) { Int }, variable("F", !J) { Set }))
                   , \equals(F, union( variable("F", !J) { Set }
                                     , singleton(variable("Y", !I) { Set })))
                   , .Patterns
                   )
             )

/* find */

  /* find-list-seg */
  rule unfold(find-list-seg(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( find-list-seg( H
                                  , X
                                  , variable("Y", !I) { Int }
                                  , variable("F", !J) { Set }
                                  , .Patterns
                                  )
                // , \not(\equals(X, Y))
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, plus(variable("Y", !I) { Int }, 1)))
                   , \equals( F
                            , add ( variable("F", !J) { Set }
                                  , variable("Y", !I) { Int }
                                  )
                            )
                   , \not(isMember(variable("Y", !I) { Int }, variable("F", !J) { Set }))
                   , .Patterns
                   )
             )

  /* find-list */
  rule unfold(find-list(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( find-list(H, variable("X", !I) { Int }, variable("F", !J) { Set },.Patterns)
                   , gt(X,0)
                   , \equals(select(H, plus(X, 1)), variable("X", !I) { Int })
                   , \equals(F, add( variable("F", !J) { Set }, X))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , .Patterns
                   )
             )

  /* find-find */
  rule unfold(find-find(DATA, RET, F, .Patterns))
    => \or( \and( gt(RET, 0)
                , \equals(RET, DATA)
                , isMember(DATA, F)
                , .Patterns
                )
          , \and( \equals(RET, 0)
                , \not(isMember(DATA, F))
                , .Patterns
                )
          )
```

Weakened left unfold / right unfold `\not(\equals(X, Y))` removed from recursive case,
needed for `lr -> ll`.

```k
  rule unfold(listSegmentLeftWeak(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentLeftWeak( H
                                        , variable("X", !I) { Int }
                                        , Y
                                        , variable("F", !J) { Set }
                                        , .Patterns
                                        )
                   , gt(X, 0)
                   , \equals( select(H, X)
                            , variable("X", !I) { Int }
                            )
                   , \equals( F
                            , union(variable("F", !J) { Set } , singleton(X))
                            )
                   , disjoint(variable("F", !J) { Set } , singleton(X))
                   , .Patterns
                   )
             )
  rule unfold(listSegmentRightWeak(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentRightWeak( H
                                         , X
                                         , variable("Y", !I) { Int }
                                         , variable("F", !J) { Set }
                                         , .Patterns
                                         )
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, variable("Y", !I) { Int }))
                   , \equals( F
                            , union( variable("F", !J) { Set }
                                   , singleton(variable("Y", !I) { Int })
                                   )
                            )
                   , disjoint( variable("F", !J) { Set }
                             , singleton(variable("Y", !I) { Int })
                             )
                   , .Patterns
                   )
             )
endmodule
```

LTL Fragment
============

### and-intro

```k
module MATCHING-LOGIC-PROVER-LTL-SYNTAX
  syntax Strategy ::= "and-intro"
  syntax Strategy ::= "unfold"
  syntax Strategy ::= "kt-always"
endmodule
```

```k
module MATCHING-LOGIC-PROVER-LTL
  imports MATCHING-LOGIC-PROVER-CORE
  imports MATCHING-LOGIC-PROVER-LTL-SYNTAX
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE

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
        => \implies( \and(P, wnext(always(P)), Ps) , Q) </k>
```

General rules
=============

### Simplification rules

TODO:: Generalize these rules properly.

```k
  rule <k> \and(P:Pattern, \top(), Ps:Patterns) => \and(P, Ps) </k>
  rule <k> \and(.Patterns) => \top() </k>
```

### Ad-hoc rules

```k
  rule <k>
    \implies ( \and ( \implies ( phi , wnext ( phi ) )
                    , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) )
                    , phi
                    , .Patterns
                    )
             , phi
             ) </k>
       <strategy> and-intro => fail ... </strategy>

  rule
     <k>
       \implies ( \and ( \implies ( phi , wnext ( phi ) ) , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) , phi , .Patterns ) , \and ( wnext ( \implies ( phi , wnext ( phi ) ) ) , \and ( wnext ( wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) ) , \and ( wnext ( phi ) , wnext ( \top ( ) ) , .Patterns ) , .Patterns ) , .Patterns ) )
     </k>
     <strategy>
       direct-proof => fail ...
     </strategy>

  rule
    <k>
\implies ( \and ( \implies ( phi , wnext ( phi ) ) , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) , phi , .Patterns ) , \and ( wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) , \and ( wnext ( phi ) , wnext ( \top ( ) ) , .Patterns ) , .Patterns ) ) </k>
  <strategy> direct-proof => success ... </strategy>

  rule
    <k>
\implies ( \and ( \implies ( phi , wnext ( phi ) ) , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) , phi , .Patterns ) , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) ) </k>
    <strategy> direct-proof => success ... </strategy>

  rule
    <k>
\implies ( \and ( \implies ( phi , wnext ( phi ) ) , wnext ( always ( \implies ( phi , wnext ( phi ) ) ) ) , phi , .Patterns ) , \and ( wnext ( phi ) , wnext ( \top ( ) ) , .Patterns ) )
</k>
<strategy> direct-proof => success ... </strategy>

endmodule
````

Driver & Syntax
===============

The driver is responsible for loading prover files into the configuration.

```k
module MATCHING-LOGIC-PROVER-SYNTAX
  imports MATCHING-LOGIC-PROVER-CORE-SYNTAX
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE-SYNTAX
  imports MATCHING-LOGIC-PROVER-LTL-SYNTAX
  imports KORE-SUGAR
  syntax Pgm ::= "claim" Pattern
                 "strategy" Strategy
endmodule
```

```k
module MATCHING-LOGIC-PROVER-DRIVER
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports MATCHING-LOGIC-PROVER-CORE

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
module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-DRIVER
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE
  imports MATCHING-LOGIC-PROVER-LTL
endmodule
```

```k
module SMTLIB2-TEST-DRIVER
  imports SMTLIB2
  imports KORE-SUGAR
  imports KORE-HELPERS

  configuration <k> $PGM:K </k>
```

Implications of the form

```k
  syntax SMTLIB2Script ::= ML2SMTLIB(Pattern) [function]
  rule ML2SMTLIB(\implies(\and(LHS), \and(RHS)))
    => declareVariables(removeDuplicates(getFreeVariables(LHS))) ++SMTLIB2Script
       assertConjunction(LHS) ++SMTLIB2Script
       refuteConjunction(RHS)

  syntax SMTLIB2Script ::= assertConjunction(BasicPatterns) [function]
  rule assertConjunction(BP, BPs) => ( assert BasicPattern2SMTLIB2Term(BP) ) assertConjunction(BPs)
  rule assertConjunction(.Patterns) => .SMTLIB2Script

  syntax SMTLIB2Script ::= refuteConjunction(BasicPatterns) [function]
  rule refuteConjunction(BPS) => ( assert refuteConjunctionBuildDisjunction(BPS) ) .SMTLIB2Script

  syntax SMTLIB2Term ::= refuteConjunctionBuildDisjunction(BasicPatterns) [function]
  rule refuteConjunctionBuildDisjunction(BP, BPs)
    => (or ( not BasicPattern2SMTLIB2Term(BP) )
           refuteConjunctionBuildDisjunction(BPs)
       )
  rule refuteConjunctionBuildDisjunction(.Patterns)
    => true:SMTLIB2Symbol

  syntax SMTLIB2Term ::= BasicPattern2SMTLIB2Term(BasicPattern) [function]
  rule BasicPattern2SMTLIB2Term(\equals(LHS, RHS))
    => ( = BasicPattern2SMTLIB2Term(LHS) BasicPattern2SMTLIB2Term(RHS) )
  rule BasicPattern2SMTLIB2Term(variable(S) { SORT }) => S
  rule BasicPattern2SMTLIB2Term(\not(P)) => ( not BasicPattern2SMTLIB2Term(P) )
  rule BasicPattern2SMTLIB2Term(I:Int) => I
  rule BasicPattern2SMTLIB2Term(emptyset) => emptySet
  rule BasicPattern2SMTLIB2Term(singleton(P1)) => ( singleton BasicPattern2SMTLIB2Term(P1) )
  rule BasicPattern2SMTLIB2Term(gt(P1, P2)) => ( > BasicPattern2SMTLIB2Term(P1) BasicPattern2SMTLIB2Term(P2) )
  rule BasicPattern2SMTLIB2Term(select(P1, P2)) => ( select BasicPattern2SMTLIB2Term(P1) BasicPattern2SMTLIB2Term(P2) )
  rule BasicPattern2SMTLIB2Term(union(P1, P2)) => ( union BasicPattern2SMTLIB2Term(P1) BasicPattern2SMTLIB2Term(P2) )
  rule BasicPattern2SMTLIB2Term(disjoint(P1, P2)) => ( disjoint BasicPattern2SMTLIB2Term(P1) BasicPattern2SMTLIB2Term(P2) )

  syntax SMTLIB2Sort ::= MLSort2SMTLIB2Sort(Sort) [function]
  rule MLSort2SMTLIB2Sort(Int:Sort) => Int:SMTLIB2Sort
  rule MLSort2SMTLIB2Sort(Bool:Sort) => Bool:SMTLIB2Sort
  rule MLSort2SMTLIB2Sort(Set:Sort) => ( Set Int )
  rule MLSort2SMTLIB2Sort(ArrayIntInt) => ( Array Int Int )

  syntax SMTLIB2Script ::= declareVariables(BasicPatterns) [function]
  rule declareVariables( .Patterns ) => .SMTLIB2Script
  rule declareVariables( variable(Name:String) { SORT } , Ps )
    => ( declare-const Name MLSort2SMTLIB2Sort(SORT) )
       declareVariables(Ps)
endmodule
```
