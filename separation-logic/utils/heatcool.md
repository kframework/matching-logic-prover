```k
module HEATCOOL-SORTS

  syntax HeatError
  syntax HeatResult ::= HeatError

endmodule // HEATCOOL-SORTS

module HEATCOOL-SYNTAX
  imports HEATCOOL-SORTS
  imports INT
  imports MAP

  syntax Pattern
  syntax Patterns

  syntax HeatError ::= heatError()
  syntax HeatResult ::= heatResult(Pattern, Map)
  syntax HeatResult ::= "heat" "(" "term:" Pattern
                               "," "pattern:" Pattern
                               "," "variables:" Patterns
                               "," "index:" Int
                               ")" [function]

  syntax Pattern ::= "cool" "(" "heated:" Pattern
                            "," "term:" Pattern
                            ")" [function]

endmodule // HEATCOOL-SYNTAX

module HEATCOOL-RULES
  imports HEATCOOL-SYNTAX
  imports VISITOR-SYNTAX
  imports MATCHING-FUNCTIONAL
  imports SYNTACTIC-MATCH-SYNTAX
  imports KORE-HELPERS

  syntax Visitor ::= "heatVisitor" "(" "pattern:" Pattern
                                   "," "variables:" Patterns
                                   "," "index:" Int
                                   "," "result:" K
                                   ")"

  rule heat(term: T, pattern: P, variables: Vars, index: N)
    => heatVisitorResult(
         visitTopDown(
           heatVisitor(
             pattern: P,
             variables:Vars,
             index: N,
             result: .K
           ),
           T
         )
       )

  syntax HeatResult ::= heatVisitorResult(VisitorResult) [function]

  // not enough instances of given pattern
  rule heatVisitorResult(
         visitorResult(
           heatVisitor(
             pattern: _,
             variables: _,
             index: N,
             result: _
           ),
           _
         )
       ) => heatError()
       requires N >=Int 0

  // found
  rule heatVisitorResult(
         visitorResult(
           heatVisitor(
             pattern: _,
             variables: _,
             index: N,
             result: M:Map
           ),
           P
         )
       ) => heatResult(P, M)
       requires N <=Int -1

  // Do nothing if already matched enough-times.
  rule visit(
         heatVisitor(
           pattern: _,
           variables: _,
           index: N,
           result: _
         ) #as V,
         T
       ) => visitorResult(V, T)
       requires N <=Int -1

  // continue matching
  rule visit(
         heatVisitor(
           pattern: P,
           variables: Vars,
           index: N,
           result: .K
         ),
         T
       ) => #visitHeatVisitor(
              pattern: P,
              variables: Vars,
              index: N,
              term: T,
              matchResult: syntacticMatch(
                terms: T,
                patterns: P,
                variables: Vars
              )
       )
  requires N >=Int 0

  syntax VisitorResult
         ::= "#visitHeatVisitor"
               "(" "pattern:" Pattern
               "," "variables:" Patterns
               "," "index:" Int
               "," "term:" Pattern
               "," "matchResult:" MatchResult
               ")" [function]

  // no match
  rule #visitHeatVisitor(
         pattern: P,
         variables: Vars,
         index: N,
         term: T,
         matchResult: #error(_)
       ) => visitorResult(
              heatVisitor(
                pattern: P,
                variables: Vars,
                index: N,
                result: .K
              ),
              T
            )
  // match, continue matching
  rule #visitHeatVisitor(
         pattern: P,
         variables: Vars,
         index: N,
         term: T,
         matchResult: #matchResult(subst: _)
       ) => visitorResult(
         heatVisitor(
           pattern: P,
           variables: Vars,
           index: N -Int 1,
           result: .K
         ),
         T
       )
       requires N >=Int 1

  // match -> replace the pattern with hole
  rule #visitHeatVisitor(
         pattern: P,
         variables: Vars,
         index: 0,
         term: T,
         matchResult: #matchResult(subst: S)
       ) => visitorResult(
         heatVisitor(
           pattern: P,
           variables: Vars,
           index: -1,
           result: S
         ),
         \hole()
       )

  // Cooling

  syntax Visitor ::= coolVisitor(Pattern)

  rule cool(heated: P, term: T)
       => coolVisitorResult(
            visitTopDown(
              coolVisitor(T),
              P
            )
          )

  rule visit(coolVisitor(T), P)
       => visitorResult(
            coolVisitor(T),
            #if P ==K \hole() #then T #else P #fi
          )

  syntax Pattern ::= coolVisitorResult(VisitorResult) [function]
  rule coolVisitorResult(visitorResult(coolVisitor(_), P)) => P

endmodule // HEATCOOL-RULES

```
