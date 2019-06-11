### Direct proof

```k
module STRATEGY-DIRECT-PROOF
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
```

```k
  rule <k> \implies(_, \and ( .Patterns )) </k>
       <strategy> direct-proof => success  ... </strategy>
       <trace> .K => direct-proof ... </trace>
```

```k
  rule <k> \implies(LHS, _) </k>
       <strategy> direct-proof => success  ... </strategy>
       <trace> .K => direct-proof ... </trace>
    requires triviallyUnsatisfiable(LHS)

  syntax Bool ::= triviallyUnsatisfiable(Pattern) [function]
  rule triviallyUnsatisfiable(\equals(X:Int, Y:Int)) => X =/=Int Y
  rule triviallyUnsatisfiable(\and(.Patterns)) => false
  rule triviallyUnsatisfiable(\and(BP, BPs:Patterns))
    =>        triviallyUnsatisfiable(BP)
       orBool triviallyUnsatisfiable(\and(BPs))
  rule triviallyUnsatisfiable(_) => false [owise]
```

```k
  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
  rule <k> \implies( \and(Ps1:Patterns)
                   , P:Pattern
                   )
       </k>
       <strategy> direct-proof => success ... </strategy>
     requires P in Ps1
  rule <k> \implies(_, \top()) </k>
       <strategy> direct-proof => success ... </strategy>

  // TODO: This should use the strategy cell
  rule <strategy> direct-proof => fail ... </strategy>
    [owise]
```

```k
endmodule
```

