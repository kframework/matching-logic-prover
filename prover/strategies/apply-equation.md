# apply-equation
```
Gamma contains H: \forall X1 PHI1 ->
                  \forall X2 PHI2 -> ... -> \forall Xn . L = R
Gamma |- PHI1[Theta1]
Gamma |- PHI1[Theta1][Theta2]
...
Gamma |- PHIn[Theta1]...[Thetan]
Gamma |- C[R[Theta1]...[Thetan]]
where P matches L with substitution Theta1 ... Thetan
--------------------------------------------------------------------
Gamma |- C[P]
```

```k
module STRATEGY-APPLY-EQUATION
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports HEATCOOL-SYNTAX
  imports LOAD-NAMED-SYNTAX

  rule <strategy> (.K => loadNamed(Name))
               ~> apply-equation D Name at _ by[_] ...
       </strategy>

  rule <strategy> (P:Pattern ~> apply-equation D _ at Idx by[Ss])
               => #apply-equation1
                  ( hypothesis: P
                  , direction: D
                  , at: Idx
                  , by: Ss
                  )
       ...</strategy>


  syntax KItem ::= "#apply-equation1"
                   "(" "hypothesis:" Pattern
                   "," "direction:" RewriteDirection
                   "," "at:" Int
                   "," "by:" Strategies
                   ")"

  syntax Bool ::=
    "apply-equation.checkShape" "(" Pattern ")" [function]

  rule apply-equation.checkShape(\iff-lfp(_, _)) => true
  rule apply-equation.checkShape(\equals(_, _)) => true
  rule apply-equation.checkShape(\forall{_} P)
       => apply-equation.checkShape(P)
  rule apply-equation.checkShape(\implies(_, P))
       => apply-equation.checkShape(P)
  rule apply-equation.checkShape(_) => false [owise]

  rule <strategy>
         #apply-equation1
           ( hypothesis: H, direction: D, at: Idx, by: Strats)
          => 
         #apply-equation2
         ( from: #if D==K -> #then
                   apply-equation.getLeft(H)
                 #else
                   apply-equation.getRight(H)
                 #fi
         , to: #if D==K -> #then
                   apply-equation.getRight(H)
                 #else
                   apply-equation.getLeft(H)
                 #fi
         , hypothesis: H
         , at: Idx
         , by: Strats
         )
       ...
       </strategy>
       requires apply-equation.checkShape(H)

  syntax Pattern
  ::= "apply-equation.getLeft" "(" Pattern ")" [function]
    | "apply-equation.getRight" "(" Pattern ")" [function]

  rule apply-equation.getLeft(\iff-lfp(L,_)) => L
  rule apply-equation.getRight(\iff-lfp(_,R)) => R
  rule apply-equation.getLeft(\equals(L,_)) => L
  rule apply-equation.getRight(\equals(_,R)) => R
  rule apply-equation.getLeft(\forall{_} P)
       => apply-equation.getLeft(P)
  rule apply-equation.getRight(\forall{_} P)
       => apply-equation.getRight(P)
  rule apply-equation.getLeft(\implies(_,P))
       => apply-equation.getLeft(P)
  rule apply-equation.getRight(\implies(_,P))
       => apply-equation.getRight(P)

  syntax KItem ::= "#apply-equation2"
                   "(" "from:" Pattern
                   "," "to:" Pattern
                   "," "hypothesis:" Pattern
                   "," "at:" Int
                   "," "by:" Strategies
                   ")"

  syntax Patterns ::= getMatchingVariables(Pattern) [function]
  rule getMatchingVariables(\equals(_,_)) => .Patterns
  rule getMatchingVariables(\implies(_, P)) => getMatchingVariables(P)
  rule getMatchingVariables(\forall{Vs} P)
       => Vs ++Patterns getMatchingVariables(P)

  rule <strategy>
        #apply-equation2(from: L, to: R, hypothesis: H, at: Idx, by: Ss)
         =>
        #apply-equation3
        ( hypothesis: H
        , heatResult: heat
                      ( term: T
                      , pattern: L
                      , variables: getMatchingVariables(H)
                      , index: Idx
                      )
        , to: R
        , by: Ss
        )
        ...
      </strategy>
      <claim> T </claim>

  syntax KItem ::= "#apply-equation3"
                   "(" "hypothesis:" Pattern
                   "," "heatResult:" HeatResult
                   "," "to:" Pattern
                   "," "by:" Strategies
                   ")"

  // TODO subgoals from implications
  rule <strategy>
         #apply-equation3
         ( hypothesis: P
         , heatResult: heatResult(Heated, Subst)
         , to: R
         , by: Ss
         )
         => generateSubgoals(P, Subst)
         ~> createSubgoalsWithStrategies(strats: Ss, result: success)
       ...</strategy>
       <claim>
         _ => cool(heated: Heated, term: substMap(R, Subst))
       </claim>

  syntax KItem ::= "createSubgoalsWithStrategies"
                   "(" "strats:" Strategies
                   "," "result:" Strategy
                   ")"
                 | generateSubgoals(Pattern, Map)
                 | subgoalsGenerated(Map, Patterns)
```

Subgoal generation: we start with the conclusion and substitution
from the heatResult, go from the bottom up, use the substitution
to instantiate left sides of implications, and at every \forall
we remove the bound variables from the substitution.
This way we do not apply-equation free variables whose name coincides
with bound ones.

```k

  rule <strategy> generateSubgoals(\equals(_,_), Subst)
               => subgoalsGenerated(Subst, .Patterns)
       ...</strategy>

  rule <strategy> (.K => generateSubgoals(R, Subst))
               ~> generateSubgoals(\implies(L, R), Subst)
       ...</strategy>

  rule <strategy> (subgoalsGenerated(Subst, Ps)
               ~> generateSubgoals(\implies(L, _), _))
               => subgoalsGenerated(
                    Subst,
                   substMap(L, Subst) ++Patterns Ps
                  )
       ...</strategy>


  rule <strategy> (.K => generateSubgoals(P, Subst))
               ~> generateSubgoals(\forall{Vars} P, Subst)
       ...</strategy>

  rule <strategy> (subgoalsGenerated(Subst, Ps)
               ~> generateSubgoals(\forall{Vars} _, _))
               => #if PatternsToSet(Vars) <=Set keys(Subst)
                  #then
                    subgoalsGenerated(
                      removeAll(Subst, PatternsToSet(Vars)),
                      Ps
                    )
                  #else
                    apply-equation.error("Unable to find an instance for variables: ",
                      PatternsToSet(Vars) -Set keys(Subst)
                    )
                  #fi
       ...</strategy>

  syntax KItem ::= "apply-equation.error" "(" String "," Set ")"

  rule <strategy> (subgoalsGenerated(.Map, .Patterns)
               ~> createSubgoalsWithStrategies
                  ( strats: .Strategies
                  , result: R))
               => R
       ...</strategy>

  rule <strategy> subgoalsGenerated(.Map, P,Ps => Ps)
               ~> createSubgoalsWithStrategies
                  ( strats: (S, Ss) => Ss
                  , result: R => R & subgoal(P, S))
       ...</strategy>

endmodule
```
