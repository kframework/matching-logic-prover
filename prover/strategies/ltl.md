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
//  rule <k> \implies(_ , wnext ( \implies ( phi , wnext ( phi ) ) )) </k>
//       <active> true </active>
//       <strategy> and-intro => fail ... </strategy>

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
