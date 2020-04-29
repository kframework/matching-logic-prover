# apply

```
Gamma contains H: \forall X1 PHI1 ->
                  \forall X2 PHI2 -> ... -> \forall Xn . P
Gamma |- PHI1[Theta1]
Gamma |- PHI1[Theta1][Theta2]
...
Gamma |- PHIn[Theta1]...[Thetan]
where P matches Q with substitution Theta1 ... Thetan
--------------------------------------------------------------------
Gamma |- Q

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
         <k> G </k>


  syntax KItem ::= #apply1(Pattern, MatchResult, Strategy)

  rule <strategy>
         #apply1(A, #matchResult(subst: Subst), Strat)
         => #apply2(instantiateAssumptions(Subst, A), Strat, success)
       ...</strategy>

  rule <strategy>
         #apply1(_, #error(_), _) => fail
       ...</strategy>

  syntax KItem ::= #apply2(
                     InstantiateAssumptionsResult,
                     Strategy, Strategy)

  rule <strategy>
         #apply2(#instantiateAssumptionsResult(.Patterns, .Map), _, Result)
         => Result
       ...</strategy>

  rule <strategy>
         #apply2(
           #instantiateAssumptionsResult(P, Ps => Ps, .Map),
           Strat,
           Result => Result & subgoal(P, Strat)
         )
       ...</strategy>

endmodule
```
