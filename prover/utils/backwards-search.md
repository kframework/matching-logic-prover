```k
module BACKWARDS-SEARCH-SYNTAX
  imports INT-SYNTAX
  imports LIST

  syntax Pattern
  syntax Patterns

  syntax Bool ::= "backwardsSearch"
                  "(" "depths:" List
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

  rule backwardsSearch(depths: Ds, goals: Gs, axioms: As)
    => #backwardsSearch(depths: Ds, goals: Gs, axioms: As, allAxioms: As)

  syntax Bool ::= "#backwardsSearch"
                  "(" "depths:" List
                  "," "goals:" Patterns
                  "," "axioms:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch
       ( depths: ListItem(0) _, goals: G,Gs, axioms: _, allAxioms: _)
       => false

  rule #backwardsSearch
       ( depths: _, goals: G,Gs, axioms: .Patterns, allAxioms: _)
       => false

  rule #backwardsSearch
       ( depths: _, goals: .Patterns, axioms: _, allAxioms: _)
       => true

  // match G against the conclusion of A.
  // R := false
  // if matches{
  //   let R := #backwardsSearch(N-1, Ps++Gs, AAs, AAs)
  // }
  // if (R) return true;
  // #backwardsSearch(N, G,Gs, As, AAs)

  rule #backwardsSearch
       ( depths: ListItem(N) Ds, goals: G,Gs, axioms: A, As, allAxioms: AAs)
       => #if #backwardsSearch.tryAxiom
              (depths: ListItem(N) Ds, goal: G, axiom: A, goals: Gs, allAxioms: AAs)
          #then
            true
          #else
            #backwardsSearch
            (depths: ListItem(N) Ds, goals: G,Gs, axioms: As, allAxioms: AAs)
          #fi
       requires N >Int 0

  syntax Bool ::= "#backwardsSearch.tryAxiom"
                  "(" "depths:" List
                  "," "goal:" Pattern
                  "," "axiom:" Pattern
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom
       ( depths: Ds, goal: G, axiom: A, goals: Gs, allAxioms: AAs)
    => #backwardsSearch.tryAxiom1(
         mr: syntacticMatch(
           terms: G, .Patterns,
           patterns: getConclusion(A), .Patterns,
           variables: getUniversallyQuantifiedVariables(A)
                      ++Patterns getSetVars(A)
         ),
         depths: Ds, axiom: A, goals: Gs, allAxioms: AAs
       )

  syntax Bool ::= "#backwardsSearch.tryAxiom1"
                  "(" "mr:" MatchResult
                  "," "depths:" List
                  "," "axiom:" Pattern
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom1(
         mr: #matchFailure(_),
         depths:_, axiom:_, goals:_, allAxioms:_
       ) => false


  rule #backwardsSearch.tryAxiom1(
         mr: #matchResult(subst: Subst),
         depths: Ds, axiom: Ax, goals: Gs, allAxioms: AAs
       ) => #backwardsSearch.tryAxiom2(
         assumptions: instantiateAssumptions(Subst, Ax),
         depths: Ds, goals: Gs, allAxioms: AAs
       )

  syntax Bool ::= "#backwardsSearch.tryAxiom2"
                  "(" "assumptions:" InstantiateAssumptionsResult
                  "," "depths:" List
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch.tryAxiom2(
         assumptions: error(_), depths: _, goals: _, allAxioms: _
       ) => false

  syntax List ::= repeatElement(KItem, Int) [function]
  rule repeatElement(_, 0) => .List
  rule repeatElement(X, N) => ListItem(X) repeatElement(X, N -Int 1)
       requires N >=Int 1

  rule #backwardsSearch.tryAxiom2(
         assumptions: ok(Ps, _), depths: ListItem(N) Ds, goals: Gs, allAxioms: AAs
       ) => #backwardsSearch(
              depths: repeatElement(N -Int 1, getLength(Ps)) Ds,
              goals: Ps ++Patterns Gs,
              axioms: AAs,
              allAxioms: AAs
            )

endmodule
```
