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
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX

  rule <strategy> (.K => loadNamed(Name))
               ~> apply(Name, _) ...
       </strategy>

    rule <strategy>
          (A:Pattern ~> apply(_, Strat))
          => #apply1(
               A,
               syntacticMatch(
                 terms: G, .Patterns,
                 patterns: getConclusion(A), .Patterns,
                 variables: getUniversallyQuantifiedVariables(A)
               ),
               Strat
             )
         ...</strategy>
         <claim> G </claim>


  syntax KItem ::= #apply1(Pattern, MatchResult, Strategy)

  rule <strategy>
         #apply1(A, #matchResult(subst: Subst), Strat)
         => #apply2(instantiateAssumptions(Subst, A), Strat, success)
       ...</strategy>

  rule <strategy>
         #apply1(_, #matchFailure(_), _) => fail
       ...</strategy>

  syntax KItem ::= #apply2(
                     InstantiateAssumptionsResult,
                     Strategy, Strategy)

  rule <strategy>
         #apply2(ok(.Patterns, .Map), _, Result) => Result
       ...</strategy>

  rule <strategy>
         #apply2(
           ok(P, Ps => Ps, .Map),
           Strat,
           Result => Result & subgoal(P, Strat)
         )
       ...</strategy>

endmodule
```
