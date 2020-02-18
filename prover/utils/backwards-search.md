```k
module BACKWARDS-SEARCH-SYNTAX
  imports INT-SYNTAX

  syntax Pattern
  syntax Patterns

  syntax Bool ::= "backwardsSearch"
                  "(" "depth:" Int
                  "," "goals:" Patterns
                  "," "axioms:" Patterns
                  ")" [function]

  syntax Bool ::= isBuiltinAxiom(Pattern) [function]

endmodule

module BACKWARDS-SEARCH-RULES
  imports KORE-HELPERS
  imports INT
  imports BACKWARDS-SEARCH-SYNTAX

  rule isBuiltinAxiom(\typeof(_:Int, S:Symbol)) => true
       requires SymbolToString(S) ==String "Int"

  syntax Bool ::= "#backwardsSearch"
                  "(" "depth:" Int
                  "," "goals:" Patterns
                  "," "axioms:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]

  rule #backwardsSearch
       ( depth: 0, goals: G,Gs, axioms: _, allAxioms: _)
       => false

  rule #backwardsSearch
       ( depth: _, goals: G,Gs, axioms: .Patterns, allAxioms: _)
       => false

  rule #backwardsSearch
       ( depth: _, goals: .Patterns, axioms: _, allAxioms: _)
       => true

  // match G against the conclusion of A.
  // R := false
  // if matches{
  //   let R := #backwardsSearch(N-1, Ps++Gs, AAs, AAs)
  // }
  // if (R) return true;
  // #backwardsSearch(N, G,Gs, As, AAs)

  rule #backwardsSearch
       ( depth: N, goals: G,Gs, axioms: A, As, allAxioms: AAs)
       => #if #backwardsSearch.tryAxiom
              (depth: N, goal: G, axiom: A, goals: Gs, allAxioms: AAs)
          #then
            true
          #else
            #backwardsSearch
            (depth: N, goals: G,Gs, axioms: As, allAxioms: AAs)
          #fi
       requires N >Int 0

  syntax Bool ::= "#backwardsSearch.tryAxiom"
                  "(" "depth:" Int
                  "," "goal:" Pattern
                  "," "axiom:" Pattern
                  "," "goals:" Patterns
                  "," "allAxioms:" Patterns
                  ")" [function]


endmodule
```
