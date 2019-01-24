```k
requires "smtlib2.k"
requires "substitution.k"
```

Kore Sugar
==========

The following is sugar for a post-sort-erasure first-order horn clause fragment
of kore:

```k
module KORE-SUGAR
  imports DOMAINS-SYNTAX
  syntax Variable ::= variable(String)
                    | variable(String, Int) // Fresh Variables:
                                            // For easy debugging we allow variables to have names.
                                            // The `Int` can be used for generating fresh-variables.
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
                        | "gt"     "(" BasicPattern "," BasicPattern ")" // Int Int

                        // Array{Int, Int}
                        | "select" "(" BasicPattern "," BasicPattern ")"        // Array, Int

                        // Set{Int}
                        | "union"         "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "disjoint"      "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "disjointUnion" "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "singleton"     "(" BasicPattern ")"                  // Int
                        | "isMember"      "(" BasicPattern "," BasicPattern ")" // Int, Set

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
  syntax RecursivePredicate ::= "lsegleft"
                              | "lsegright"
                              | "list"
                              | "bt"
                              | "bst"
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

  syntax BasicPatterns ::= getFreeVariables(Patterns) [function]
  rule getFreeVariables(.Patterns) => .Patterns
  rule getFreeVariables(P, Ps)
    => removeDuplicates(
         getFreeVariables(P, .Patterns) ++BasicPatterns getFreeVariables(Ps))
    requires Ps =/=K .Patterns
  rule getFreeVariables(X:Variable, .Patterns) => X, .Patterns
  rule getFreeVariables(P:Predicate(ARGS) , .Patterns)   => getFreeVariables(ARGS)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)

  rule getFreeVariables(\or(CF, CFs),  .Patterns)
    =>                 getFreeVariables(CF, .Patterns)
       ++BasicPatterns getFreeVariables(\or(CFs), .Patterns)
  rule getFreeVariables(\or(.ConjunctiveForms), .Patterns)
    => .Patterns
```

```k
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
  rule makeFreshSubstitution(variable(S), REST)
    => variable(S) |-> variable(S, !I)
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(variable(S, J), REST)
    => variable(S, J) |-> variable(S, !I)
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
  imports SMTLIB2
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

  syntax Strategy ::= "search-bound" "(" Int ")"
                    | "right-unfold"
                    | "direct-proof"
                    | "kt"
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
               => direct-proof
                | (kt           ; search-bound(N -Int 1))
                | (right-unfold ; search-bound(N -Int 1))
                ...
       </strategy>
    requires N >Int 0
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
  rule checkValid(\implies(P, P)) => true:Bool
  rule checkValid(\implies(_, \and ( .Patterns ))) => true:Bool
  rule checkValid(_) => false:Bool [owise]
```

Some "hard-wire" direct-proof rules.

```k
  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
```

Temp: needed by `lsegleft -> lsegright`

```k
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
                        , gt ( X , 0 )
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
      \implies ( \and ( \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , T )
                      , \equals ( F , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
                      , \equals ( T , Y )
                      , \equals ( F1 , emptyset )
                      , .Patterns )
               , \and ( \not ( \equals ( X , Y ) )
                      , gt ( Y7 , 0 )
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
               , \and ( \equals ( select ( H , X ) , T )
                      , \equals ( F23 , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
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
                         , gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F23 , union ( F2 , singleton ( X ) ) )
                         , disjoint ( F2 , singleton ( X ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)
        ==K                  (F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)

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
                         , lsegright ( H , X , Y3 , F23 , .Patterns )
                         , .Patterns )
                  , \and ( lsegright ( H , X , Y53 , F52 , .Patterns )
                         , \not ( \equals ( X , Y ) )
                         , gt ( Y53 , 0 )
                         , \equals ( Y , select ( H , Y53 ) )
                         , \equals ( F , union ( F52 , singleton ( Y53 ) ) )
                         , disjoint ( F52 , singleton ( Y53 ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)
         ==K                (F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)
```

### Knaster Tarski

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:
(`ktForEachLRP` corresponds to `lprove_kt_aux`)

```k
  rule <k> GOAL </k>
       <strategy> kt => ktForEachLRP(getLeftRecursivePredicates(GOAL)) ... </strategy>
  syntax Strategy ::= ktForEachLRP(BasicPatterns)
  rule <strategy> ktForEachLRP(.Patterns)
               => fail
                  ...
       </strategy>
  rule <strategy> ktForEachLRP(LRP, LRPs)
               => ktOneLRP(LRP) | ktForEachLRP(LRPs)
                  ...
       </strategy>
```

(`ktOneLRP` corresponds to `lprove_kt/6`)

```k
  syntax Strategy ::= ktOneLRP(BasicPattern)
  rule <strategy> ktOneLRP(LRP) => ktForEachBody(LRP, unfold(LRP)) ... </strategy>
       <trace> .K => ktOneLRP(LRP) ... </trace>
```

(`ktForEachBody` corresponds to `lprove_kt_all_bodies`)

```k
  syntax Strategy ::= ktForEachBody(BasicPattern, DisjunctiveForm)
  rule <strategy> ktForEachBody(LRP, \or(.ConjunctiveForms))
               => success
                  ...
       </strategy>
  rule <strategy> ktForEachBody(LRP, \or(BODY, BODIES))
               => ktOneBody(LRP, BODY) & ktForEachBody(LRP, \or(BODIES))
                  ...
       </strategy>
```

(`ktOneBody` corresponds to `lprove_kt_one_body`)

```k
  syntax Strategy ::= ktOneBody(BasicPattern, ConjunctiveForm)                        // LRP, Body
```

```k
  syntax KItem ::= ktEachBRP(BasicPattern, ConjunctiveForm, BasicPatterns) // LRP, Body, BRPs
                 | ktOneBRP(BasicPattern, ConjunctiveForm, BasicPattern)   // LRP, Body, BRP
                 | ktBRPResult(Patterns, ConjunctiveForm)
                 | ktBRPCollectResults(ConjunctiveForm, BasicPattern) // Body, LRP
  rule <strategy> ktOneBody(LRP:RecursivePredicate(ARGS), BODY)
               => ktEachBRP(LRP(ARGS), BODY, filterByConstructor(getRecursivePredicates(BODY, .Patterns), LRP))
               ~> ktBRPCollectResults(BODY, LRP(ARGS))
                  ...
       </strategy>
```

```k
  rule <strategy> ktEachBRP(LRP, BODY, (BRP_samehead, BRPs_samehead))
               => ktOneBRP(LRP, BODY, BRP_samehead)
               ~> ktEachBRP(LRP, BODY, BRPs_samehead)
                  ...
       </strategy>
  rule <strategy> ktEachBRP(LRP, BODY, .Patterns)
               => ktBRPResult(.Patterns, \and(.Patterns)) ...
       </strategy>

  rule <k> \implies(\and(LHS), \and(RHS)) </k>
       <strategy> ktOneBRP(HEAD:RecursivePredicate(LRP_ARGS), \and(BODY), HEAD(BRP_ARGS))
               => ktBRPResult( (?Premise, .Patterns)
                             , \and(?LHS_UA ++BasicPatterns ?RHS_UAF)
                             )
                  ...
       </strategy>
    requires ?USubst ==K zip(LRP_ARGS, BRP_ARGS)
     andBool ?ASubst ==K makeFreshSubstitution(findAffectedVariablesAux(LRP_ARGS -BasicPatterns BRP_ARGS, LHS ))
     andBool ?LHS_UA  ==K {(LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns))[ ?USubst ][ ?ASubst ]}:>BasicPatterns
     andBool ?Premise ==K \implies( \and( (LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns)) ++BasicPatterns
                                          (BODY -BasicPatterns filterByConstructor(getRecursivePredicates(BODY), HEAD)) // BRPs_diffhead + BCPs
                                        )
                                  , \and(?LHS_UA)
                                  )
     andBool ?UnivVars ==K getFreeVariables(LHS)
     andBool ?ExVARS   ==K getFreeVariables(\and(RHS), .Patterns) -BasicPatterns ?UnivVars
     andBool ?FSubst   ==K makeFreshSubstitution(?ExVARS)
     andBool ?RHS_UAF  ==K {RHS[?USubst][?ASubst][?FSubst]}:>BasicPatterns
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
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktEachBRP(LRP, BODY, BRPs_samehead)
               => ktEachBRP(LRP, BODY, BRPs_samehead) ~> ktBRPResult(PREMISES, CONCL_FRAG)
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

  /* lsegleft */
  rule unfold(lsegleft(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( lsegleft( H
                             , variable("X", !I)
                             , Y
                             , variable("F", !J)
                             , .Patterns
                             )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , \equals( select(H, X)
                            , variable("X", !I)
                            )
                   , \equals( F
                            , union(variable("F", !J) , singleton(X))
                            )
                   , disjoint(variable("F", !J) , singleton(X))
                   , .Patterns
                   )
             )

  /* lsegright */
  rule unfold(lsegright(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( lsegright( H
                              , X
                              , variable("Y", !I)
                              , variable("F", !J)
                              , .Patterns
                              )
                   , \not(\equals(X, Y))
                   , gt(variable("Y", !I), 0)
                   , \equals(Y, select(H, variable("Y", !I)))
                   , \equals( F
                            , union( variable("F", !J)
                                   , singleton(variable("Y", !I))
                                   )
                            )
                   , disjoint( variable("F", !J)
                             , singleton(variable("Y", !I))
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
             , \and( list(H,variable("X", !I),variable("F", !J),.Patterns)
                   , gt(X,0)
                   , \equals( select(H, X)
                            , variable("X", !I))
                   , \equals( F
                            , union( variable("F", !J), singleton(X)))
                   , disjoint(variable("F", !J), singleton(X))
                   , .Patterns
                   )
             )

  /* bt */
  rule unfold(bt(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( bt(H, variable("X", !I1), variable("F", !J1), .Patterns)
                   , bt(H, variable("X", !I2), variable("F", !J2), .Patterns)
                   , gt(X,0)
                   , \equals( variable("X", !I1)
                            , select(H, plus(X, 1)))
                   , \equals( variable("X", !I2)
                            , select(H, plus(X, 2)))
                   , \not(isMember(X, variable("F", !J1)))
                   , \not(isMember(X, variable("F", !J2)))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1)
                                            , variable("F", !J2))))
                   , disjoint(variable("F", !J1), variable("F", !J2))
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
                   , .Patterns
                   )
             , \and( bst( H
                        , variable("X",   !I1)
                        , variable("F",   !J1)
                        , variable("MIN", !K1)
                        , variable("MAX", !L1)
                        , .Patterns
                        )
                   , bst( H
                        , variable("X",   !I2)
                        , variable("F",   !J2)
                        , variable("MIN", !K2)
                        , variable("MAX", !L2)
                        , .Patterns
                        )
                   , gt(X,0)
                   , \equals(select(H, plus(X, 1)), variable("X", !I1))
                   , \equals(select(H, plus(X, 2)), variable("X", !I2))
                   , gt(X, variable("MAX", !K1))
                   , gt(variable("MIN", !L2), X)
                   , \equals(variable("MIN", !L1), MIN)
                   , \equals(variable("MAX", !K2), MAX)
                   , \not(isMember(X, variable("F", !J1)))
                   , \not(isMember(X, variable("F", !J2)))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1)
                                            , variable("F", !J2))))
                   , disjoint(variable("F", !J1), variable("F", !J2))
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

Main Module
===========

```k
module MATCHING-LOGIC-PROVER
  imports MATCHING-LOGIC-PROVER-DRIVER
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE
  imports MATCHING-LOGIC-PROVER-LTL
endmodule
```
