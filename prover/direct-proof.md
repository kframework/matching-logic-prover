### Direct proof

```k
module STRATEGY-DIRECT-PROOF
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
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
       <trace> .K => direct-proof ... </trace>
```

Returns true if negation is unsatisfiable, false if unknown or satisfiable:

```k
  syntax Bool ::= checkValid(ImplicativeForm) [function]
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

```k
  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
```

```k
endmodule
```

