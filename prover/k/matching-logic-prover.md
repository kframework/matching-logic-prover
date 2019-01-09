```k
requires "smtlib2.k"

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
                        | "disjointUnion" "(" BasicPattern "," BasicPattern ")" // Set, Set
                        | "singleton"     "(" BasicPattern ")"                  // Int
                        | "isMember"      "(" BasicPattern "," BasicPattern ")" // Int, Set
                        | Predicate "(" BasicPatterns ")"

  syntax ConjunctiveForm ::= "\\and"     "(" BasicPatterns ")"
  syntax ConjunctiveForms ::= List{ConjunctiveForm, ","}
  syntax DisjunctiveForm ::= "\\or"      "(" ConjunctiveForms ")"
  syntax ImplicativeForm ::= "\\implies" "(" ConjunctiveForm "," DisjunctiveForm ")"

  syntax Pattern ::= BasicPattern
                   | ConjunctiveForm
                   | DisjunctiveForm
                   | ImplicativeForm

  syntax BasicPatterns ::= ".Patterns"
                         | BasicPattern "," BasicPatterns [klabel(PatternCons), right]
  syntax Patterns      ::= BasicPatterns
                         | Pattern "," Patterns           [klabel(PatternCons), right]

  syntax BasicPatterns ::= BasicPatterns "++BasicPatterns" BasicPatterns [function]
  rule (BP1, BP1s) ++BasicPatterns BP2s => BP1, (BP1s ++BasicPatterns BP2s)
  rule .Patterns ++BasicPatterns BP2s => BP2s
```

```k
  /* examples */
  syntax RecursivePredicate ::= "lsegleft"
                              | "lsegright"
  syntax Predicate ::= "isEmpty"
endmodule

module MATCHING-LOGIC-PROVER
  imports DOMAINS
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports SMTLIB2
```

TODO: `type="List"` work for some reason. `type="Bag"` allows too much
non-determinism and affects efficiency.

```k
  configuration
    <proveOne>
      <proveAll multiplicity="*" type="Bag">
        <goal multiplicity="*" type="Bag">
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
               <strategy> S1 ~> REST </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
           </proveAll>
         )
         <proveAll>
           <goal>
             <strategy> ( (S1 | S2) => S2 ) ~> REST </strategy>
             <k> GOAL:ImplicativeForm </k>
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
               <strategy> S1 ~> REST </strategy>
               <k> GOAL:ImplicativeForm </k>
             </goal>
         )
         <goal>
           <strategy> ((S1 & S2) => S2) ~> REST </strategy>
           <k> GOAL:ImplicativeForm </k>
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

```k
  rule <k>  \implies(LHS, \or(\and(R:Predicate(ARGS), .Patterns)))
         => \implies(LHS, unfold(R:Predicate(ARGS)))
       </k>
       <strategy>  right-unfold => noop ... </strategy>
```

### Direct proof

TODO: Stubbed: Should translate to SMTLIB queries.
Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  syntax Bool ::= checkValid(ImplicativeForm) [function]
  rule checkValid(\implies(P, \or(P))) => true:Bool
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

First, we find all recursive patterns KT can be applied to:

```k
  rule <k> GOAL </k>
       <strategy> kt => ktForEachLRP(getLeftRecursivePredicates(GOAL)) ... </strategy>

  syntax BasicPatterns ::= getLeftRecursivePredicates(ImplicativeForm) [function]
  rule getLeftRecursivePredicates(\implies(\and(LHS), RHS))
    => getRecursivePredicates(LHS)

  syntax BasicPatterns ::= getRecursivePredicates(BasicPatterns)   [function]
  rule getRecursivePredicates(.Patterns) => .Patterns
  rule getRecursivePredicates(R:RecursivePredicate(ARGS), REST)
    => R(ARGS), getRecursivePredicates(REST)
  rule getRecursivePredicates(PATTERN, REST)
    => getRecursivePredicates(REST)
       [owise]

  syntax Strategy ::= ktForEachLRP(BasicPatterns) [function, klabel(ktForEachLRP)]
  rule ktForEachLRP(.Patterns) => fail
  rule ktForEachLRP(LRP, LRPs) => kt(LRP) | ktForEachLRP(LRPs) [owise]

  syntax Strategy ::= kt(BasicPattern) [function, klabel(ktForEachLRP)]
  rule kt(LRP) => ktForEachBody(LRP, unfold(LRP))

  syntax Strategy ::= ktForEachBody(BasicPattern, DisjunctiveForm) [function, klabel(ktForEachLRP)]
  rule ktForEachBody(LRP, \or(.ConjunctiveForms))
    => success
  rule ktForEachBody(LRP, \or(BODY, BODIES))
    => ktOneBody(LRP, BODY) & ktForEachBody(LRP, \or(BODIES))

  syntax Strategy ::= ktOneBody(BasicPattern, ConjunctiveForm)

  syntax BasicPatterns ::= getFreeVariables(Patterns) [function]
  rule getFreeVariables(P, Ps)
    =>                 getFreeVariables(P, .Patterns)
       ++BasicPatterns getFreeVariables(Ps)
    requires Ps =/=K .Patterns
  rule getFreeVariables(X:Variable, .Patterns) => X, .Patterns
  rule getFreeVariables(P:Predicate(ARGS) , .Patterns)   => getFreeVariables(ARGS)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(.Patterns) => .Patterns
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
                            , disjointUnion(variable("F", !J) , singleton(X))
                            )
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
                            , disjointUnion( variable("F", !J)
                                           , singleton(variable("Y", !I))
                                           )
                            )
                   , .Patterns
                   )
             )

  rule unfold(isEmpty(S, .Patterns)) => \or ( \and ( \equals(S, emptyset), .Patterns ) )
endmodule
```
