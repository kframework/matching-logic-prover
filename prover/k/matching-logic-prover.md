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

  syntax BasicPattern
  syntax BasicPatterns ::= List{BasicPattern, ","}
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

  configuration
    <k> $PGM:ImplicativeForm </k>
    <strategy> search-bound(4) ~> .K </strategy>
    <stateStack> .K </stateStack>
```

Strategy Language
-----------------

```k
  syntax ResultStrategy ::= "noop" | "fail" | "success" | "#hole"
  syntax Strategy ::= ResultStrategy
                    | Strategy     Strategy  [right] // composition
                    > Strategy "|" Strategy  [right] // choice
```

Since strategies do not live in the K cell, we must manually heat and cool:

```k
  rule <strategy> S1 S2 => S1 ~> #hole S2 ... </strategy>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole S2 => S1 S2 ... </strategy>
```

When we encounter a choice we push the contents of <k> cell to a stack, and
attempt the first strategy. If the strategy fails, we reset the <k> cell to the
top element of the stack, and pop from the stack when all choices fail

```k
  syntax KItem ::= "#pop"
  rule <strategy> (S1 | S2) => S1 ~> #hole | S2 ~> #pop ... </strategy>
       <k> GOAL:ImplicativeForm ... </k>
       <stateStack> .K => GOAL ... </stateStack>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole | S2 => S1 | S2 ... </strategy>

  rule <strategy> fail | S2
               => S2
                  ...
       </strategy>
       <k> _ => GOAL </k>
       <stateStack> GOAL:ImplicativeForm ... </stateStack>
```

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
  rule <k>  \implies(LHS, \or(\and(R:Predicate(ARGS))))
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

```k
  rule <k> GOAL </k>
       <strategy> kt => ktAux(getLeftRecursivePredicates(GOAL)) ... </strategy>

  syntax RecursivePredicates ::= List{RecursivePredicate, ","}
  syntax RecursivePredicates ::= getLeftRecursivePredicates(ImplicativeForm) [function]
  rule getLeftRecursivePredicates(_) => .RecursivePredicates

  syntax Strategy ::= ktAux(RecursivePredicates)   [function, klabel(ktAux)]
                    | kt(RecursivePredicate)


  rule ktAux(.RecursivePredicates) => fail
  rule ktAux(LRP:RecursivePredicate, LRPs)
    => kt(LRP) | ktAux(LRPs)
       [owise]
```

Definition of Recursive Predicates
----------------------------------

```k
  syntax DisjunctiveForm ::= "unfold" "(" BasicPattern ")" [function]

  /* lsegleft */
  rule unfold(lsegleft(H,X,Y,F))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   )
             , \and( lsegleft( H
                             , variable("X", !I)
                             , Y
                             , variable("F", !J)
                             )
                   , \not(\equals(X, Y))
                   , \not(\equals(X, 0))
                   , \equals( select(H, X)
                            , variable("X", !I)
                            )
                   , \equals( F
                            , disjointUnion( variable("F", !J)
                                           , singleton(X)
                                           )
                            )
                   )
             )

  /* lsegright */
  rule unfold(lsegright(H,X,Y,F))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   )
             , \and( lsegright( H
                              , X
                              , variable("Y", !I)
                              , variable("F", !J)
                              )
                   , \not(\equals(X, Y))
                   , \not(\equals(X, 0))
                   , \equals(Y, select(H, variable("Y", !I)))
                   , \equals( F
                            , disjointUnion( variable("F", !J)
                                           , singleton(variable("Y", !I))
                                           )
                            )
             )     )

  rule unfold(isEmpty(S)) => \or ( \and ( \equals(S, emptyset) ) )
endmodule
```
