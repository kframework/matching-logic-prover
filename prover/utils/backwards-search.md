Performs resolution-style search from conclusions to premises.
At every step, the goal is matched against the conclusions
of axioms and if there is a match, the goal is replaced with
the axiom's premises. The process repeats until no goal remains,
or until the 'timeout' represented by the `depths` parameter.

Consider the following example:
  axioms=[A->C->D, B->C, A, B]
  goals=[D]
The conclusion of the first axiom matches the goal,
so the list of goals becomes:
 goals=[A,C]
Of the new list of goals, the first one is an axiom, so it gets removed:
  goals=[C]
The goal is then matched by the conclusion of the second axiom, so the list of goals becomes:
  goals=[B]
which is then reduced to goals=[], and the procedure returns true.

The parameter 'depths' determines for every goal how long
the chain of implications leading to the goal can be.
In the example above, if we run backwardsSearch with depths=[3],
the list of claims would evolve as follows:
goals=[D], depths=[3]
goals=[A, C], depths=[2, 2]
goals=[C], depths=[2]
goals=[B], depths=[1]
goals=[], depths=[].
(each depths[i] corresponds to goals[i])

If we run the search with depths=[1], the process would stop at
  goals=[B], depths=[0]
and the procedure would return false.

```k
module BACKWARDS-SEARCH-SYNTAX
  imports INT-SYNTAX
  imports LIST

  syntax Pattern
  syntax Patterns
  syntax GoalId

  syntax Bool ::= "backwardsSearch"
                  "(" "goalid:" GoalId
                  "," "depths:" List
                  "," "goals:" Patterns
                  "," "axioms:" Patterns
                  ")" [function]

  syntax Bool ::= isBuiltinAxiom(Pattern) [function]

endmodule

module BACKWARDS-SEARCH-RULES
  imports KORE-HELPERS
  imports INT
  imports SYNTACTIC-MATCH-SYNTAX
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports BACKWARDS-SEARCH-SYNTAX

  rule isBuiltinAxiom(\typeof(_:Int, Int)) => true

  rule backwardsSearch(goalid: GId, depths: Ds, goals: Gs, axioms: As)
    => #backwardsSearch(goalid: GId, depths: Ds, goals: Gs, axioms: As, allAxioms: As)

  syntax Bool ::= "#backwardsSearch"
                  "(" "goalid:" GoalId
                  "," "depths:" List
                  "," "goals:" Patterns
                  "," "axioms:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch
       ( goalid: _, depths: ListItem(0) _, goals: G,Gs, axioms: _, allAxioms: _)
       => false

  rule #backwardsSearch
       ( goalid: _, depths: _, goals: G,Gs, axioms: .Patterns, allAxioms: _)
       => false

  rule #backwardsSearch
       ( goalid: _, depths: _, goals: .Patterns, axioms: _, allAxioms: _)
       => true

  // match G against the conclusion of A.
  // R := false
  // if matches{
  //   let R := #backwardsSearch(N-1, Ps++Gs, AAs, AAs)
  // }
  // if (R) return true;
  // #backwardsSearch(N, G,Gs, As, AAs)

  rule #backwardsSearch
       ( goalid: GId, depths: ListItem(N) Ds, goals: G,Gs, axioms: A, As, allAxioms: AAs)
       => #if #backwardsSearch.tryAxiom
              (goalid: GId, depths: ListItem(N) Ds, goal: G, axiom: A, goals: Gs, allAxioms: AAs)
          #then
            true
          #else
            #backwardsSearch
            (goalid: GId, depths: ListItem(N) Ds, goals: G,Gs, axioms: As, allAxioms: AAs)
          #fi
       requires N >Int 0

  syntax Bool ::= "#backwardsSearch.tryAxiom"
                  "(" "goalid:" GoalId
                  "," "depths:" List
                  "," "goal:" Pattern
                  "," "axiom:" Pattern
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom
       ( goalid: GId, depths: Ds, goal: G, axiom: A, goals: Gs, allAxioms: AAs)
    => #backwardsSearch.tryAxiom1(
         mr: syntacticMatch(
           terms: G, .Patterns,
           patterns: getConclusion(A), .Patterns,
           variables: getUniversallyQuantifiedVariables(A)
                      ++Patterns getSetVars(A)
         ),
         goalid: GId, depths: Ds, axiom: A, goals: Gs, allAxioms: AAs
       )

  syntax Bool ::= "#backwardsSearch.tryAxiom1"
                  "(" "mr:" MatchResult
                  "," "goalid:" GoalId
                  "," "depths:" List
                  "," "axiom:" Pattern
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom1(
         mr: #error(_),
         goalid: _, depths:_, axiom:_, goals:_, allAxioms:_
       ) => false


  rule #backwardsSearch.tryAxiom1(
         mr: #matchResult(subst: Subst),
         goalid: GId, depths: Ds, axiom: Ax, goals: Gs, allAxioms: AAs
       ) => #backwardsSearch.tryAxiom2(
         goalid: GId,
         assumptions: instantiateAssumptions(GId, Subst, Ax),
         depths: Ds, goals: Gs, allAxioms: AAs
       )

  syntax Bool ::= "#backwardsSearch.tryAxiom2"
                  "(" "goalid:" GoalId
                  "," "assumptions:" InstantiateAssumptionsResult
                  "," "depths:" List
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom2(
         goalid: _, assumptions: #error(_), depths: _, goals: _, allAxioms: _
       ) => false

  syntax List ::= repeatElement(KItem, Int) [function]
  rule repeatElement(_, 0) => .List
  rule repeatElement(X, N) => ListItem(X) repeatElement(X, N -Int 1)
       requires N >=Int 1

  rule #backwardsSearch.tryAxiom2(
         goalid: GId, assumptions: #instantiateAssumptionsResult(Ps, _),
         depths: ListItem(N) Ds, goals: Gs, allAxioms: AAs
       ) => #backwardsSearch(
              goalid: GId,
              depths: repeatElement(N -Int 1, getLength(Ps)) Ds,
              goals: Ps ++Patterns Gs,
              axioms: AAs,
              allAxioms: AAs
            )

endmodule
```
