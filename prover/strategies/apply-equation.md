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
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports VISITOR-SYNTAX
  imports SYNTACTIC-MATCH-SYNTAX

  rule <k> (.K => loadNamed(Name))
               ~> apply-equation D Name at _ by[_] ...
       </k>

  rule <k> (P:Pattern ~> apply-equation D _ at Idx by[Ss])
               => #apply-equation1
                  ( hypothesis: P
                  , direction: D
                  , at: Idx
                  , by: Ss
                  )
       ...</k>


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

  rule <k>
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
       </k>
       requires apply-equation.checkShape(H)

  // Gets LHS or RHS of a conclusion that is an equality.
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

  rule <k>
        #apply-equation2(from: L, to: R, hypothesis: H, at: Idx, by: Ss)
         =>
        #apply-equation3
        ( hypothesis: H
        , heatResult: heat
                      ( term: T
                      , pattern: L
                      , variables: getUniversallyQuantifiedVariables(H)
                                   ++Patterns getSetVariables(H)
                      , index: Idx
                      )
        , to: R
        , by: Ss
        )
        ...
      </k>
      <claim> T </claim>

  syntax KItem ::= "#apply-equation3"
                   "(" "hypothesis:" Pattern
                   "," "heatResult:" HeatResult
                   "," "to:" Pattern
                   "," "by:" Strategies
                   ")"

  rule <k>
         #apply-equation3
         ( hypothesis: P
         , heatResult: heatResult(Heated, Subst)
         , to: R
         , by: Ss
         )
         => instantiateAssumptions(GId, Subst, P)
         ~> createSubgoalsWithStrategies(strats: Ss, result: success)
       ...</k>
       <claim>
         _ => cool(heated: Heated, term: substMap(R, Subst))
       </claim>
       <id> GId </id>

  syntax KItem ::= "createSubgoalsWithStrategies"
                   "(" "strats:" Strategies
                   "," "result:" Strategy
                   ")"

  rule <k> (#instantiateAssumptionsResult(.Patterns, _)
               ~> createSubgoalsWithStrategies
                  ( strats: .Strategies
                  , result: R))
               => R & noop
       ...</k>

  rule <k> #instantiateAssumptionsResult(P,Ps => Ps, _)
               ~> createSubgoalsWithStrategies
                  ( strats: (S, Ss) => Ss
                  , result: R => subgoal(P, S) & R)
       ...</k>

```
### Apply equation in context

The strategy `apply-equation(eq: \equals(A,B) #as Eq, idx: Idx, direction: D, at: At)`
rewrites a subpattern of the shape `A=B /\ ... /\ A /\ ...`
to `A=B /\ ... /\ B /\ ...`. The parameter `Idx` determines
which instance of the equality syntactically matching `\equals(A,B)` is used;
the parameter `At` specifies the instance of `A` that is to be rewritten to B.

```
Gamma |- C[... /\ A=B /\ ... /\ B /\ ... ]
------------------------------------------
Gamma |- C[... /\ A=B /\ ... /\ A /\ ... ]
```

```k

  rule <k> apply-equation(eq: \equals(_,_) #as Eq, idx: Idx, direction: D, at: At)
               => noop
       ...</k>
       <claim> C
            => visitorResult.getPattern(
                 visitTopDown(
                   applyEquationInContextVisitor(aeicParams(
                     eq: Eq, idx: Idx, direction: D, at: At
                   )),
                   C
                 )
               )
       </claim>

  syntax KItem ::= "aeicParams" "(" "eq:" Pattern
                                "," "idx:" Int
                                "," "direction:" RewriteDirection
                                "," "at:" Int
                                ")"

  syntax Int ::= "aeicParams.getIndex" "(" KItem ")" [function]
  rule aeicParams.getIndex(aeicParams(eq: _, idx: Idx, direction: _, at: _))
    => Idx

  syntax Visitor ::= applyEquationInContextVisitor(KItem)

  syntax Pattern ::= applyEquationInContextVisitorResult(VisitorResult) [function]

  rule visit(applyEquationInContextVisitor(Params) #as V, P)
    => visitorResult(V, P)
       requires \and(_) :/=K P orBool (aeicParams.getIndex(Params) <Int 0)

  rule visit(applyEquationInContextVisitor(Params), \and(Ps))
    => applyEquationInContextAnd(Params, .Patterns, Ps)
       requires aeicParams.getIndex(Params) >=Int 0

  syntax VisitorResult ::= applyEquationInContextAnd(KItem, Patterns, Patterns) [function]

  rule applyEquationInContextAnd(Params, Ps, .Patterns)
    => visitorResult(applyEquationInContextVisitor(Params), \and(Ps))

  rule applyEquationInContextAnd(
         aeicParams(eq: Eq, idx: Idx, direction: D, at: At) #as Params,
         Ps1, (P, Ps2))
    => applyEquationInContextAnd1(
         Params,
         syntacticMatch(
           terms: (P, .Patterns),
           patterns: (Eq, .Patterns),
           variables: getUniversallyQuantifiedVariables(Eq)
                      ++Patterns getSetVariables(Eq)
         ),
         Ps1, P, Ps2
       )

  syntax VisitorResult ::= applyEquationInContextAnd1(
                             KItem,
                             MatchResult,
                             Patterns,
                             Pattern,
                             Patterns) [function]

  rule applyEquationInContextAnd1(Params, #error(_), Ps1, P, Ps2)
    => applyEquationInContextAnd(Params, Ps1 ++Patterns (P, .Patterns), Ps2)

  rule applyEquationInContextAnd1(
         aeicParams(eq: Eq, idx: Idx, direction: D, at: At) #as Params,
         #matchResult(subst: _),
         Ps1, P, Ps2
       )
    => applyEquationInContextAnd(
         aeicParams(eq: Eq, idx: Idx -Int 1, direction: D, at: At),
         Ps1 ++Patterns (P, .Patterns),
         Ps2
       )
    requires Idx =/=Int 0

  rule applyEquationInContextAnd1(
         aeicParams(eq: Eq, idx: 0, direction: ->, at: At) #as Params,
         #matchResult(subst: _),
         Ps1, P, Ps2
       )
    => applyEquationInContextAnd2(
         Params,
         heat(
           term:      \and(Ps1 ++Patterns Ps2),
           pattern:   apply-equation.getLeft(P),
           variables: .Patterns,
           index:     At
         ),
         apply-equation.getRight(P),
         getLength(Ps1), P
       )

  rule applyEquationInContextAnd1(
         aeicParams(eq: Eq, idx: 0, direction: <-, at: At) #as Params,
         #matchResult(subst: _),
         Ps1, P, Ps2
       )
    => applyEquationInContextAnd2(
         Params,
         heat(
           term:      \and(Ps1 ++Patterns Ps2),
           pattern:   apply-equation.getRight(P),
           variables: .Patterns,
           index:     At
         ),
         apply-equation.getLeft(P),
         getLength(Ps1), P
       )

  syntax VisitorResult ::= applyEquationInContextAnd2(KItem, HeatResult, Pattern, Int, Pattern) [function]

  rule applyEquationInContextAnd2(
         aeicParams(eq: Eq, idx: _, direction: D, at: At),
         heatResult(Heated, _),
         Right,
         Prefix,
         P
       )
    => visitorResult(
         // The only important argument is that idx: -1.
         applyEquationInContextVisitor(aeicParams(eq: Eq, idx: -1, direction: D, at: At)),
         insertToAnd(Prefix, P, cool(heated: Heated, term: Right))
     )

  syntax Pattern ::= insertToAnd(Int, Pattern, Pattern) [function]

  rule insertToAnd(N, P, \and(Ps))
    => \and(insertToPatterns(N, P, Ps))


endmodule
```
