```k
requires "smtlib2.k"

module MATCHING-LOGIC-PROVER-SYNTAX
  imports DOMAINS-SYNTAX

  /* FOL-Horn fragment */
  syntax Var ::= "V_" Int

  syntax AtomicTerm ::= Int | Var | "emptyset"

  syntax Term ::= AtomicTerm
                | Term "+" Term
                | "union" "(" Term "," Term ")"
                | "intersect" "(" Term "," Term ")"
                | Term "#" Term /* F # x means F U {x}, and that x \not\in F */
                | Term "[" Term ":=" Term "]"
                | Term "[" Term "]"
                | "(" Term ")" [bracket]

  syntax Terms ::= List{Term, ","}

  syntax RecursivePredicate
  syntax NonRecursivePredicate

  syntax Atom ::= "true" | "false"
                | Term "=" Term
                | Term "!=" Term
                | Term "<=" Term
                | Term "<" Term
                | "disjoint" "(" Term "," Term ")"
                | Term "in" Term
                | Term "notin" Term
                | NonRecursivePredicate "(" Terms ")"
                | RecursivePredicate "(" Terms ")"
                | "(" Atom ")" [bracket]

  syntax ConjunctionForm ::= Atom
                           | Atom "/\\" ConjunctionForm

  syntax ImplicationForm ::= ConjunctionForm "->" DisjunctionForm

  /* prover infrastructure */
  syntax DisjunctionForm ::= ConjunctionForm
                           | ConjunctionForm "\\/" DisjunctionForm

  /* examples */
  syntax RecursivePredicate ::= "lsegleft"
                              | "lsegright"
                              | "isEmpty"

endmodule

module MATCHING-LOGIC-PROVER
  imports DOMAINS
  imports MATCHING-LOGIC-PROVER-SYNTAX
  imports SMTLIB2

  configuration
    <k> $PGM:ImplicationForm </k>
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
       <k> GOAL:ImplicationForm ... </k>
       <stateStack> .K => GOAL ... </stateStack>
    requires notBool(isResultStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole | S2 => S1 | S2 ... </strategy>

  rule <strategy> fail | S2
               => S2
                  ...
       </strategy>
       <k> _ => GOAL </k>
       <stateStack> GOAL:ImplicationForm ... </stateStack>
```

```k
  syntax Strategy ::= "if" Bool "then" Strategy "else" Strategy "fi" [function]
  rule if true  then S1 else _  fi => S1
  rule if false then _  else S2 fi => S2
```

```k
  rule <strategy> noop S2 => S2 ... </strategy>
```

```k
  rule <strategy> success ~> _ => success </strategy>
```

```k
  syntax Strategy ::= "search-bound" "(" Int ")"
                    | "direct-proof" [token]
                    | "kt"           [token]
                    | "right-unfold" [token]
                    |  "left-unfold" [token]

  rule ( (S T) U ):Strategy => S (T U) [macro]
  rule noop T => T

  rule search-bound(0) => fail
  rule <strategy> search-bound(N)
               => direct-proof
                | kt           search-bound(N -Int 1)
                | right-unfold search-bound(N -Int 1)
       </strategy>
    requires N >=Int 0
```

```k
  rule <k>  ( LHS -> R:RecursivePredicate ( ARGS:Terms ) )
         => ( LHS -> unfold(R:RecursivePredicate ( ARGS:Terms )) )
       </k>
       <strategy>  right-unfold => noop ... </strategy>
```

TODO: Stubbed.
Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  syntax Bool ::= checkValid(ImplicationForm) [function]
  rule checkValid(P -> P) => true:Bool
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

Definition of Recursive Predicates
----------------------------------

```k
  syntax DisjunctionForm ::= "unfold" "(" Atom ")" [function]

  /* lsegleft */
  rule unfold(lsegleft(H,X,Y,F))
       =>    ( X = Y /\ F = emptyset )
          \/ (    lsegleft(H, (V_ !I), Y, (V_ (!J)))
               /\ (X!=Y) /\ (X!=0)
               /\ H[X]=(V_ !I)
               /\ (F=(V_ (!J)) # X)
             )

  /* lsegright */
  rule unfold(lsegright(H,X,Y,F))
       =>    ( X = Y /\ F = emptyset )
          \/ (   lsegright(H,X,(V_ !I),(V_ (!J)))
              /\ (X!=Y) /\ (X!=0)
              /\ H[(V_ !I)]=Y
              /\ (F=(V_ (!J)) # (V_ !I))
             )

  rule unfold(isEmpty(S)) => S = emptyset
endmodule
```
