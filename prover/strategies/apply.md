# apply

```
--------------------------------------------------------------------

```

```k
module STRATEGY-APPLY
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports LOAD-NAMED-SYNTAX
  imports SYNTACTIC-MATCH-SYNTAX

  rule <strategy> (.K => loadNamed(Name))
               ~> apply(Name, _) ...
       </strategy>

    rule <strategy>
          (A:Pattern ~> apply(_, Strat))
          => #apply(
               syntacticMatch(
                 terms: G, .Patterns,
                 patterns: getConclusion(A), .Patterns,
                 variables: getUniversallyQuantifiedVariables(A)
               ),
               Strat
             )
         ...</strategy>
         <claim> G </claim>


  syntax KItem ::= #apply(MatchResult, Strategy)


endmodule
```
