```k
requires "smtlib2.k"
requires "substitution.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  imports DOMAINS-SYNTAX
```

Kore Sugar
==========

The following is sugar for a post-sort-erasure first-order horn clause fragment
of kore:

```k
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

  syntax BasicPattern ::= AtomicPattern
                        | "\\top"    "(" ")"
                        | "\\bottom" "(" ")"
                        | "\\equals" "(" BasicPattern "," BasicPattern ")"
                        | "\\not"    "(" BasicPattern ")"

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
                        | Predicate "(" BasicPatterns ")"

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
  imports MATCHING-LOGIC-PROVER-SYNTAX
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
endmodule
```

```k
module MATCHING-LOGIC-PROVER
  imports DOMAINS
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports KORE-HELPERS
  imports SUBSTITUTION
```

TODO: `type="List"` doesn't work for some reason. `type="Bag"` allows too much
non-determinism and affects efficiency.

```k
  configuration
      <prover>
        <goal multiplicity="*" type="Bag">
          <id> 0 </id>
          <parent> -1 </parent>
          <k> $PGM:Pattern </k>
          <strategy> search-bound(4) ~> .K </strategy>
        </goal>
      </prover>
```

Probable strategy for LTL-Ind example: ``

```commented
  configuration
      <prover>
        <goal multiplicity="*" type="Bag">
          <id> 0 </id>
          <parent> -1 </parent>
          <k> $PGM:Pattern </k>
          <strategy> kt-always and-intro and-intro unfold ~> .K </strategy>
        </goal>
      </prover>
```

Strategy Language
=================

The "strategy" language is an imperative language for describing which proof rules
to apply to complete the proof.

`Strategy`s can be sequentially composed via the `;` operator.

```k
   syntax Strategy ::= Strategy ";" Strategy [right]
  rule <strategy> (S ; T) ; U => S ; (T ; U) ... </strategy>

```

Since strategies do not live in the K cell, we must manually heat and cool.
`ResultStrategy`s are strategies that can only be simplified when they are
cooled back into the sequence strategy.

```k
  syntax ResultStrategy ::= "#hole"
  syntax Strategy ::= ResultStrategy
  rule <strategy> S1 ; S2 => S1 ~> #hole ; S2 ... </strategy>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole ; S2 => S1 ; S2 ... </strategy>
```

The `noop` (no operation) strategy is the unit for sequential composition:

```k
  syntax ResultStrategy ::= "noop"
  rule <strategy> noop ; T => T ... </strategy>
```

The `success` and `fail` strategy indicate that a goal has been successfully
proved, or that constructing a proof has failed.

```k
  syntax TerminalStrategy ::= "success" | "fail"
  syntax Strategy ::= TerminalStrategy
  rule <strategy> T:TerminalStrategy ; S => T ... </strategy>
```

TODO: These two cause inifinite loops. Why?

```commented
  rule <strategy> success ~> (REST => .K) </strategy> requires REST =/=K .K
  rule <strategy> fail    ~> (REST => .K) </strategy> requires REST =/=K .K
```

The `goalStrat(Int)` strategy is used to establish a refernce to the result of another
goal. It's argument holds the id of a subgoal. Once that subgoal has completed,
its result is replaced in the parent goal and the subgoal is removed.

```k
  syntax ResultStrategy ::= goalStrat(Int)
  rule <prover>
         <goal> <id> PID </id>
                <strategy> PStrat => replaceStrategyK(PStrat, goalStrat(ID), RStrat) </strategy>
                ...
         </goal>
         ( <goal> <id> ID </id>
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
  syntax ResultStrategy ::= Strategy "&" Strategy [right, format(%1%n%2  %3)]
  rule <prover>
         ( .Bag =>
             <goal>
               <id> !ID:Int </id>
               <parent> PARENT </parent>
               <strategy> S1 </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <strategy> ((S1 & S2) => S2 & goalStrat(!ID)) </strategy>
           <k> GOAL:ImplicativeForm </k>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isResultStrategy(S1))
```

Similarly, there may be a different approaches to finding a proof for a goal.
The `|` strategy lets us try these different approaches, and succeeds if any one
approach succeeds:

```k
  syntax ResultStrategy ::= Strategy "|" Strategy  [right, format(%1%n%2  %3)]

  rule <strategy> S | fail => S ... </strategy>
  rule <strategy> fail | S => S ... </strategy>
  rule <strategy> S | success => success ... </strategy>
  rule <strategy> success | S => success ... </strategy>
  rule <strategy> (S1 | S2) ; S3 => (S1 ; S3) | (S2 ; S3) ... </strategy>

  rule <prover>
         ( .Bag =>
             <goal>
               <id> !ID:Int </id>
               <parent> PARENT </parent>
               <strategy> S1 </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <strategy> (S1 | S2) => (S2 | goalStrat(!ID)) </strategy>
           <k> GOAL:ImplicativeForm </k>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isResultStrategy(S1))
     andBool S2 =/=K fail
```

If-then-else-fi strategy is useful for implementing other strategies:

```k
  syntax Strategy ::= "if" Bool "then" Strategy "else" Strategy "fi" [function]
  rule if true  then S1 else _  fi => S1
  rule if false then _  else S2 fi => S2
```

Strategies for the Horn Clause fragment
---------------------------------------

### Search Bound

```k
  syntax Strategy ::= "search-bound" "(" Int ")"

  rule <strategy> search-bound(0) => fail </strategy>
  rule <strategy> search-bound(N)
               => direct-proof
                | (kt           ; search-bound(N -Int 1))
                | (right-unfold ; search-bound(N -Int 1))
                ...
       </strategy>
    requires N >=Int 0
```

### Right Unfold

Unfold the predicates on the Right hand side into a disjunction of implications.
Note that the resulting goals is stonger than the initial goal (i.e.
`A -> B \/ C` vs `(A -> B) \/ (A -> C)`).

```k
  syntax Strategy ::= "right-unfold"
                    | "right-unfold" "(" DisjunctiveForm ")"
  rule <k>  \implies(LHS, \and(R:Predicate(ARGS), .Patterns)) </k>
       <strategy>  right-unfold => right-unfold(unfold(R(ARGS))) ... </strategy>

  rule <strategy> right-unfold(\or(BODY, BODIES:ConjunctiveForms))
               => right-unfold(\or(BODY, .ConjunctiveForms))
                | right-unfold(\or(BODIES))
       </strategy>
    requires BODIES =/=K .ConjunctiveForms
  rule <k> \implies(LHS, RHS) => \implies(LHS, BODY) ... </k>
       <strategy> right-unfold(\or(BODY, .ConjunctiveForms)) => noop ... </strategy>
  rule <strategy> right-unfold(\or(.ConjunctiveForms)) => success </strategy>
```

### Direct proof

```k
  syntax Strategy ::= "direct-proof"
  rule <k> GOAL </k>
       <strategy> direct-proof
               => if checkValid(GOAL)
                  then success
                  else fail
                  fi
                  ...
       </strategy>
```

TODO: Stubbed: Should translate to SMTLIB queries.
Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  syntax Bool ::= checkValid(ImplicativeForm) [function]
  rule checkValid(\implies(P, P)) => true:Bool
  rule checkValid(_) => false:Bool [owise]
```


### Knaster Tarski

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:
(`ktForEachLRP` corresponds to `lprove_kt_aux`)

```k
  syntax Strategy ::= "kt"
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
  syntax Strategy ::= ktOneLRP(BasicPattern) [function]
  rule ktOneLRP(LRP) => ktForEachBody(LRP, unfold(LRP))
```

(`ktForEachBody` corresponds to `lprove_kt_all_bodies`)

```k
  syntax Strategy ::= ktForEachBody(BasicPattern, DisjunctiveForm)
  rule <strategy> ktForEachBody(LRP, \or(.ConjunctiveForms))
               => success
       </strategy>
  rule <strategy> ktForEachBody(LRP, \or(BODY, BODIES))
               => ktOneBody(LRP, BODY) & ktForEachBody(LRP, \or(BODIES))
       </strategy>
```

(`ktOneBody` corresponds to `lprove_kt_one_body`)

```k
  syntax Strategy ::= ktOneBody(BasicPattern, ConjunctiveForm)                        // LRP, Body
```

(Correspondence breaks down here; Though roughly, ktOneBodyPremises => lprove_kt_all_each_brp
ktOneBodyPremise => lprove_kt_one_brp and the ktOneBodyConcl is split between the two)

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
  rule <strategy> ktBRPResult(PREMISES, CONCL_FRAG) ~> ktBRPCollectResults(BODY, LRP)
               => ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
  rule <strategy> ktGoals(BODY, LRP, (PREMISE, PREMISES), CONCL_FRAG)
               => replaceGoal(PREMISE) & ktGoals(BODY, LRP, PREMISES, CONCL_FRAG)
                  ...
       </strategy>
```

```k
  rule <k> \implies(\and(LHS), RHS) ... </k>
       <strategy> ktGoals(\and(BODY), HEAD:RecursivePredicate(LRP_ARGS), .Patterns, \and(CONCL_FRAGS))
               => replaceGoal(\implies( \and(                (LHS -BasicPatterns (HEAD(LRP_ARGS), .Patterns))
                                             ++BasicPatterns (BODY -BasicPatterns ?BRP_samehead)
                                             ++BasicPatterns CONCL_FRAGS
                                            )
                                      , RHS
                             )        )
                  ...
       </strategy>
     requires ?BRP_samehead ==K filterByConstructor(getRecursivePredicates(BODY), HEAD)
```

```k
  syntax Strategy ::= replaceGoal(ImplicativeForm)
  rule <k> _:ImplicativeForm => GOAL ... </k>
       <strategy> replaceGoal(GOAL) => noop ... </strategy>
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

Temporary rule to see results of auxilary functionality needed for implementing KT

```
  rule <k> \implies(\and(LHS), RHS) </k>
       <strategy> ktOneBodyPremise(HEAD:RecursivePredicate(LRP_ARGS), \and(BODY), HEAD(BRP_ARGS))
               =>     variable("LHS_U_i")                ~> \and(LHS)[zip(LRP_ARGS, BRP_ARGS)]
                   ~> variable("Active Vars")            ~> getFreeVariables(LRP_ARGS)
                   ~> variable("universalVs")            ~> getFreeVariables(LHS)
                   ~> variable("existential")            ~> getFreeVariables(RHS, .Patterns) -BasicPatterns getFreeVariables(LHS)
                   ~> variable("PassiveVars")            ~> getFreeVariables(LHS) -BasicPatterns getFreeVariables(LRP_ARGS)
                   ~> variable("Critical Vars")          ~> LRP_ARGS -BasicPatterns BRP_ARGS // TODO: This is incorrect when variables are rearranged.
                   ~> variable("Non-critical Active Vs") ~> getFreeVariables(LRP_ARGS) -BasicPatterns (LRP_ARGS -BasicPatterns BRP_ARGS)
                   ~> variable("Affected variables")
                        ~> findAffectedVariables( LRP_ARGS -BasicPatterns BRP_ARGS
                                                , getFreeVariables(LRP_ARGS) -BasicPatterns (LRP_ARGS -BasicPatterns BRP_ARGS)
                                                , LHS
                                                )
                   ~> makeFreshSubstitution(findAffectedVariablesAux
                                              ( LRP_ARGS -BasicPatterns BRP_ARGS
                                              , LHS
                                              )
                                           )
                   ~> variable("LHS_UA_i")
                        ~> \and(LHS)[zip(LRP_ARGS, BRP_ARGS)]
                                    [makeFreshSubstitution(findAffectedVariablesAux
                                        (LRP_ARGS -BasicPatterns BRP_ARGS , LHS ))
                                    ]

                   ~> variable("Premise_i")
                   ~> \implies( \and( LHS ++BasicPatterns
                                      (BODY -BasicPatterns filterByConstructor(getRecursivePredicates(BODY), HEAD)) // BRPs_diffhead + BCPs
                                    )
                              , \and(LHS)[zip(LRP_ARGS, BRP_ARGS)]
                                [makeFreshSubstitution(findAffectedVariablesAux
                                    (LRP_ARGS -BasicPatterns BRP_ARGS , LHS ))
                                ]
                              )
                  ...
       </strategy>
```

LTL Fragment
------------

### and-intro

```k
  /* |- A -> B /\ C
   * =>
   * |- A -> B
   * |- A -> C
   */
  syntax Strategy ::= "and-intro"
                    | "and-intro" "(" Patterns ")"
  rule <k> \implies(LHS:Pattern, \and(Ps:Patterns)) </k>
       <strategy> and-intro => and-intro(Ps) ... </strategy>

  rule <strategy> and-intro(.Patterns) => success </strategy>
  rule <strategy> and-intro(P:Pattern, Ps:Patterns)
               => and-intro(P, .Patterns) & and-intro(Ps) ... </strategy>
  requires Ps =/=K .Patterns
  rule <k> \implies(LHS:Pattern, RHS:Pattern) => \implies(LHS, P) ... </k>
       <strategy> and-intro(P, .Patterns) => .K ... </strategy>
```

### wnext-and

```k
  /* wnext(P /\ Q) => wnext(P) /\ wnext(Q) */
  rule wnext(\and(.Patterns)) => \top()
  rule wnext(\and(P:Pattern, Ps:Patterns))
    => \and(wnext(P), wnext(\and(Ps)), .Patterns)
```

### kt-always

```k
  /* |- P -> always(Q)
   * =>
   * |- P -> Q /\ wnext(P)
   */
  syntax Strategy ::= "kt-always"

  rule <k> \implies(P:Pattern, always(Q:Pattern))
        => \implies(P, \and(Q, wnext(P), .Patterns)) </k>
  <strategy> kt-always => .K ... </strategy>
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

Definition of Recursive Predicates
==================================

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
                   , gt(X, 0)
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
