Kore Driver
===========

This module is responsible for loading files in the kore syntax into the
configuration.

```k
module DRIVER-KORE
  imports DRIVER-BASE
  imports PROVER-CORE
  imports K-IO
  imports K-REFLECTION
```

Handle each `Declaration` sequentially:

```k
  rule <k> (D:Declaration Ds:Declarations)
        => (D ~> Ds)
           ...
       </k>
  rule <k> .Declarations => .K ... </k>
```

`imports` declaration: Use a system call to `kast` to import additional definitions.

```k
  // K changes directory to "REPODIR/.krun-TIMESTAMP"
  rule <k> imports FILE:String
        => #system("kast --directory ../.build/defn/prover-kore '../" +String FILE +String "'")
           ...
       </k>
  rule <k> #systemResult(0, KAST_STRING, STDERR) => #parseKAST(KAST_STRING) ... </k>
```

Add various standard Kore declarations to the configuration directly:

```k
  rule <k> (symbol _ ( _ ) : _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>

  rule <k> (sort _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>

  rule axiom (P:Pattern) => axiom getFreshGlobalAxiomName() : P

  rule <k> (axiom _: _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>
```

The `claim` Declaration creates a new `<goal>` cell.
We create a subgoal, so that all the reasoning happens
in the subgoal and the claim of the named goal remains intact.

```k
  rule <k> claim PATTERN strategy STRAT
        => claim getFreshClaimName() : PATTERN strategy STRAT
           ...
       </k>
  rule <k> claim NAME : PATTERN
           strategy STRAT
        => subgoal(NAME, PATTERN, subgoal(PATTERN, STRAT))
           ...
       </k>
```

```k
endmodule
```

```k
module DRIVER-KORE-SYNTAX
  imports DRIVER-BASE-SYNTAX
  imports SMTLIB2-SYNTAX
  imports SMTLIB-SL
endmodule
```
