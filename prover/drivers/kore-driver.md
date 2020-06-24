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
  rule imports FILE:String
    => #imports FILE

  rule <k> imports system FILE:String
        => #imports PD +String "/include/" +String FILE
           ...
       </k>
       <prover-dir> PD:String </prover-dir>

  syntax KItem ::= "#imports" String
  rule <k> #imports PATH:String
        => #system("kast --output kore --directory " +String PD +String "/.build/defn/prover-kore"
             +String " '" +String PATH +String "'")
           ...
       </k>
       <prover-dir> PD:String </prover-dir>

  rule <k> #systemResult(0, KAST_STRING, STDERR) => #parseKORE(KAST_STRING):Declarations ... </k>
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

  rule axiom Body => axiom getFreshGlobalAxiomName() : Body

  rule <k> (axiom _: _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>
```

The `claim` Declaration creates a new `<goal>` cell.

```k
  rule <k> claim PATTERN strategy STRAT
        => claim getFreshGlobalAxiomName() : PATTERN strategy STRAT
           ...
       </k>
  rule <k> claim NAME : PATTERN
           strategy STRAT
        => subgoal(NAME, PATTERN, STRAT)
        ~> axiom NAME : PATTERN
           ...
       </k>

  // the rule above generates `success ~> axiom _ : _ ~> Declarations`
  rule <k> (success => .K) ~> D:Declaration ... </k>
  rule <k> (success => .K) ~> D:Declarations ... </k>
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
