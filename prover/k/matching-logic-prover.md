```k
requires "smtlib2.k"
requires "substitution.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  imports DOMAINS-SYNTAX
```

Kore Sugar
----------

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

```k
module KORE-HELPERS
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports MAP

  syntax Bool ::= BasicPattern "in" BasicPatterns [function]
  rule BP in (BP,  BP1s) => true
  rule BP in (BP1, BP1s) => BP in BP1s requires BP =/=K BP1
  rule BP in .Patterns   => false

  syntax BasicPatterns ::= BasicPatterns "++BasicPatterns" BasicPatterns [function]
  rule (BP1, BP1s) ++BasicPatterns BP2s => BP1, (BP1s ++BasicPatterns BP2s)
  rule .Patterns ++BasicPatterns BP2s => BP2s

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
  imports SMTLIB2
```

TODO: `type="List"` doesn't work for some reason. `type="Bag"` allows too much
non-determinism and affects efficiency.

```k
  configuration
    <proveOne>
      <proveAll multiplicity="*" type="Bag">
        <goal multiplicity="*" type="Bag">
          <id> -1 </id>
          <k> $PGM:ImplicativeForm </k>
          <strategy> search-bound(4) ~> .K </strategy>
        </goal>
      </proveAll>
    </proveOne>
```

Strategy Language
-----------------

```k
  syntax ResultStrategy ::= "noop" | "fail" | "#hole"
  syntax Strategy ::= ResultStrategy
                    | "success"
                    | Strategy     Strategy  [right] // composition
                    > Strategy "&" Strategy  [right] // and
                    > Strategy "|" Strategy  [right] // choice
```

Since strategies do not live in the K cell, we must manually heat and cool:

```k
  rule <strategy> S1 S2 => S1 ~> #hole S2 ... </strategy>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole S2 => S1 S2 ... </strategy>
```

`|` splits the current goal set with one copy using each branch of the choice.
TODO: Support multiple goals in `<proveAll>` cell.

```k
  rule <proveOne>
         ( .Bag =>
           <proveAll>
             <goal>
               <id> !ID </id>
               <strategy> S1 ~> REST </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
           </proveAll>
         )
         <proveAll>
           <goal>
             <strategy> ( (S1 | S2) => S2 ) ~> REST </strategy>
             <k> GOAL:ImplicativeForm </k>
             ...
           </goal>
         </proveAll>
         ...
       </proveOne>
    requires notBool(isResultStrategy(S1))
  rule <proveOne>
         <proveAll>
           <goal>
             <strategy> fail </strategy>
             <k> GOAL </k>
             ...
           </goal>
           ...
         </proveAll>
         => .Bag
         ...
       </proveOne>
```

Similarly, when we encounter *and*, we push the contents of <k> cell to a stack, and
attempt the first strategy. If the strategy *succeeds*, we reset the <k> cell to the
top element of the stack, and pop from the stack when any sub-strategy fails.

```k
  rule <proveAll>
         ( .Bag =>
             <goal>
               <id> !ID </id>
               <strategy> S1 ~> REST </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
         )
         <goal>
           <strategy> ((S1 & S2) => S2) ~> REST </strategy>
           <k> GOAL:ImplicativeForm </k>
           ...
         </goal>
         ...
       </proveAll>
```

If a goal succeeds, we clear it:

```k
  rule <proveAll>
         <goal>
           <strategy> success ... </strategy>
           <k> GOAL:ImplicativeForm </k>
           ...
         </goal>
         => .Bag
         ...
       </proveAll>
```

Once all goals in one goal set have succeeded, we can stop processing the other
goal sets:

```k
  rule <proveOne>
         ( <proveAll> <k> _ </k> ... </proveAll> => .Bag)
         <proveAll>
           .Bag
         </proveAll>
         ...
       </proveOne>
```

If-then-else-fi strategy is useful for implementing other strategies:

```k
  syntax Strategy ::= "if" Bool "then" Strategy "else" Strategy "fi" [function]
  rule if true  then S1 else _  fi => S1
  rule if false then _  else S2 fi => S2
```

```k
  syntax Strategy ::= "search-bound" "(" Int ")"
                    | "direct-proof" [token]
                    | "kt"           [token]
                    | "right-unfold" [token]
                    |  "left-unfold" [token]

  rule <strategy> ( (S T) U ):Strategy => S (T U) ... </strategy>
  rule <strategy> fail T => fail                  ... </strategy>
  rule <strategy> noop T => T                     ... </strategy>

  rule <strategy> search-bound(0) => fail </strategy>
  rule <strategy> search-bound(N)
               => direct-proof
                | kt           search-bound(N -Int 1)
                | right-unfold search-bound(N -Int 1)
                ...
       </strategy>
    requires N >=Int 0
```

### Right Unfold

Unfold the predicates on the Right hand side into a disjunction of implications.
Note that the resulting goals is stonger than the initial goal (i.e.
`A -> B \/ C` vs `(A -> B) \/ (A -> C)`).

```k
  syntax Strategy ::= "right-unfold" "(" DisjunctiveForm ")"
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

TODO: Stubbed: Should translate to SMTLIB queries.
Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  syntax Bool ::= checkValid(ImplicativeForm) [function]
  rule checkValid(\implies(P, P)) => true:Bool
  rule checkValid(_) => false:Bool [owise]
```

```k
  rule <k> GOAL </k>
       <strategy> direct-proof
               => if checkValid(GOAL)
                  then success
                  else fail
                  fi
                  ...
       </strategy>
```

### Knaster Tarski

`ktForEachLRP` iterates over the recursive predicates on the LHS of the goal:
(`ktForEachLRP` corresponds to `lprove_kt_aux`)

```k
  rule <k> GOAL </k>
       <strategy> kt => ktForEachLRP(getLeftRecursivePredicates(GOAL)) ... </strategy>
  syntax Strategy ::= ktForEachLRP(BasicPatterns) [function, klabel(ktForEachLRP)]
  rule ktForEachLRP(.Patterns) => fail
  rule ktForEachLRP(LRP, LRPs) => ktOneLRP(LRP) | ktForEachLRP(LRPs) [owise]
```

(`ktOneLRP` corresponds to `lprove_kt/6`)

```k
  syntax Strategy ::= ktOneLRP(BasicPattern) [function]
  rule ktOneLRP(LRP) => ktForEachBody(LRP, unfold(LRP))
```

(`ktForEachBody` corresponds to `lprove_kt_all_bodies`)

```k
  syntax Strategy ::= ktForEachBody(BasicPattern, DisjunctiveForm) [function, klabel(ktForEachLRP)]
  rule ktForEachBody(LRP, \or(.ConjunctiveForms))
    => success
  rule ktForEachBody(LRP, \or(BODY, BODIES))
    => ktOneBody(LRP, BODY) & ktForEachBody(LRP, \or(BODIES))
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
                 | ktBRPResult(ImplicativeForm, ConjunctiveForm)
                 | "ktBRPMarker"
  rule <strategy> ktOneBody(LRP:Predicate(ARGS), BODY)
               => ktEachBRP(LRP(ARGS), BODY, filterByConstructor(getRecursivePredicates(BODY, .Patterns), LRP))
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
               => .K ...
       </strategy>

  rule <k> \implies(\and(LHS), \and(RHS)) </k>
       <strategy> ktOneBRP(HEAD:RecursivePredicate(LRP_ARGS), \and(BODY), HEAD(BRP_ARGS))
               => ktBRPResult( ?Premise
                             , \and(?LHS_UA ++BasicPatterns ?RHS_UAF)
                             )
                  ...
       </strategy>
    requires ?USubst ==K zip(LRP_ARGS, BRP_ARGS)
     andBool ?ASubst ==K makeFreshSubstitution(findAffectedVariablesAux(LRP_ARGS -BasicPatterns BRP_ARGS, LHS ))
     andBool ?LHS_UA  ==K {LHS[ ?USubst ][ ?ASubst ]}:>BasicPatterns
     andBool ?Premise ==K \implies( \and( LHS ++BasicPatterns
                                          (BODY -BasicPatterns filterByConstructor(getRecursivePredicates(BODY), HEAD)) // BRPs_diffhead + BCPs
                                        )
                                  , \and(?LHS_UA)
                                  )
     andBool ?UnivVars ==K getFreeVariables(LHS)
     andBool ?ExVARS   ==K getFreeVariables(\and(RHS), .Patterns) -BasicPatterns ?UnivVars
     andBool ?FSubst   ==K makeFreshSubstitution(?ExVARS)
     andBool ?RHS_UAF  ==K {RHS[?USubst][?ASubst][?FSubst]}:>BasicPatterns

  rule <strategy> ktBRPResult(PREMISE, CONCL_FRAG) ~> ktEachBRP(LRP, BODY, BRPs_samehead)
               => ktEachBRP(LRP, BODY, BRPs_samehead) ~> ktBRPResult(PREMISE, CONCL_FRAG)
                  ...
       </strategy>

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

Definition of Recursive Predicates
----------------------------------

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
                   , \not(\equals(X, 0))
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
                   , \not(\equals(X, 0))
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
                   , \not(\equals(X,0))
                   , \equals( select(H, X)
                            , variable("X", !I))
                   , \equals( F
                            , union( variable("F", !J), singleton(X)))
                   , disjoint(variable("F", !J), singleton(X))
                   , .Patterns
                   )
             )
endmodule
```
