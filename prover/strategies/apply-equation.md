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

TODO: split this into multiple simpler strategies

```k
module STRATEGY-APPLY-EQUATION
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports HEATCOOL-SYNTAX
  imports LOAD-NAMED-SYNTAX
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX

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
    | "#apply-equation.getLeft" "(" Pattern ")" [function]
    | "apply-equation.getRight" "(" Pattern ")" [function]
    | "#apply-equation.getRight" "(" Pattern ")" [function]

  rule apply-equation.getLeft(P)
    => #apply-equation.getLeft(getConclusion(P))
  rule apply-equation.getRight(P)
    => #apply-equation.getRight(getConclusion(P))

  rule #apply-equation.getLeft(\iff-lfp(L,_)) => L
  rule #apply-equation.getRight(\iff-lfp(_,R)) => R
  rule #apply-equation.getLeft(\equals(L,_)) => L
  rule #apply-equation.getRight(\equals(_,R)) => R

  syntax KItem ::= "#apply-equation2"
                   "(" "from:" Pattern
                   "," "to:" Pattern
                   "," "hypothesis:" Pattern
                   "," "at:" Int
                   "," "by:" Strategies
                   ")"

  rule <strategy>
        #apply-equation2(from: L, to: R, hypothesis: H, at: Idx, by: Ss)
         =>
        #apply-equation3
        ( hypothesis: H
        , heatResult: heat
                      ( term: T
                      , pattern: L
                      , variables: getUniversallyQuantifiedVariables(H)
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

  rule <strategy>
         #apply-equation3
         ( hypothesis: P
         , heatResult: heatResult(Heated, Subst)
         , to: R
         , by: Ss
         )
         => instantiateAssumptions(Subst, P)
         ~> createSubgoalsWithStrategies(strats: Ss, result: success)
       ...</strategy>
       <claim>
         _ => cool(heated: Heated, term: substMap(R, Subst))
       </claim>

  syntax KItem ::= "createSubgoalsWithStrategies"
                   "(" "strats:" Strategies
                   "," "result:" Strategy
                   ")"

  rule <strategy> (ok(.Patterns, .Map)
               ~> createSubgoalsWithStrategies
                  ( strats: .Strategies
                  , result: R))
               => R
       ...</strategy>

  rule <strategy> ok(P,Ps => Ps, .Map)
               ~> createSubgoalsWithStrategies
                  ( strats: (S, Ss) => Ss
                  , result: R => R & subgoal(P, S))
       ...</strategy>

endmodule
```
