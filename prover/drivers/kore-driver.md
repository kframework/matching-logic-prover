Kore Driver
===========

This module is responsible for loading files in the kore syntax into the
configuration.

```k
module KORE-DRIVER
  imports PROVER-COMMON
  imports PROVER-CORE
  imports K-IO

  syntax Declarations ::= ".Declarations" [klabel(.Declarations)]

  // K changes directory to "REPODIR/.krun-TIMESTAMP"
  rule <k> imports FILE:String
        => #system("kast --directory ../.build/defn/prover-kore '../" +String FILE +String "'")
           ...
       </k>
  rule <k> #systemResult(0, KAST_STRING, STDERR) => #parseKAST(KAST_STRING) ... </k>

  rule <k> (D:Declaration Ds:Declarations)
        => (D ~> Ds)
           ...
       </k>
  rule <k> .Declarations => .K ... </k>

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

  rule <k> (axiom _ #as DECL:Declaration) => .K ... </k>
       <declarations>
         (.Bag => <declaration> DECL </declaration>)
         ...
       </declarations>
  rule <k> claim PATTERN
           strategy STRAT
        => .K
           ...
       </k>
       <goals>
         ( .Bag =>
           <goal>
             <id> root </id>
             <active> true:Bool </active>
             <parent> .K </parent>
             <claim> PATTERN </claim>
             <strategy> STRAT </strategy>
             <trace> .K </trace>
           </goal>
         )
         ...
       </goals>
```

```k
endmodule
```

```k
module PROVER-KORE-SYNTAX
  imports PROVER-COMMON-SYNTAX
  imports SMTLIB2-SYNTAX
  imports SMTLIB-SL
endmodule
```
