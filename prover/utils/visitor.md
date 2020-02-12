```k
module VISITOR-SORTS

  syntax Pattern

  syntax Visitor
  syntax VisitorResult

endmodule

module VISITOR-SYNTAX
  imports VISITOR-SORTS

  syntax Pattern

  // Recursively traverses given pattern and calls 
  // `visit` for each subpattern.
  syntax VisitorResult ::= visitTopDown(Visitor, Pattern) [function]

  // implementation of given visitor
  syntax VisitorResult ::= visit(Visitor, Pattern) [function]
                         | visitorResult(Visitor, Pattern)

endmodule
```

```k
module VISITOR
  imports VISITOR-SYNTAX
  imports KORE
  imports KORE-HELPERS

  rule visitTopDown(V, P)
    => #visitTopDown(visit(V, P))

  syntax VisitorResult ::= #visitTopDown(VisitorResult) [function]

  // base case
  rule #visitTopDown(visitorResult(_,P) #as VR) => VR
       requires isInt(P)
         orBool isVariable(P)
         orBool isSetVariable(P)
         orBool isSymbol(P)

  // \equals(_, _)
  rule #visitTopDown(visitorResult(V,\equals(P1, P2)))
    => #visitTopDownEq1(visitTopDown(V, P1), P2)

  syntax VisitorResult
         ::= #visitTopDownEq1(VisitorResult, Pattern) [function]

  rule #visitTopDownEq1(visitorResult(V, P1), P2)
    => #visitTopDownEq2(P1, visitTopDown(V, P2))

  syntax VisitorResult
         ::= #visitTopDownEq2(Pattern, VisitorResult) [function]
  rule #visitTopDownEq2(P1, visitorResult(V, P2))
    => visitorResult(V, \equals(P1, P2))

  // \not(_)
  syntax VisitorResult
         ::= #visitTopDownNot(VisitorResult) [function]
  rule #visitTopDown(visitorResult(V, \not(P)))
    => #visitTopDownNot(visitTopDown(V, P))

  rule #visitTopDownNot(visitorResult(V, P))
    => visitorResult(V, \not(P))


  // \and(...)
  rule #visitTopDown(visitorResult(V, \and(.Patterns)) #as VR)
       => VR

  rule #visitTopDown(visitorResult(V, \and(P, Ps)))
    => #visitTopDownAnd(.Patterns, visitTopDown(V, P), Ps)

  syntax VisitorResult
     ::= #visitTopDownAnd(Patterns, VisitorResult, Patterns) [function]

  rule #visitTopDownAnd(
         Ps1 => Ps1 ++Patterns P1,
         visitorResult(V, P1) => visitTopDown(V, P2),
         P2, Ps2 => Ps2
       )

  rule #visitTopDownAnd(
         Ps,
         visitorResult(V, P),
         .Patterns
       ) => visitorResult(V, \and(Ps ++Patterns P))

  // \or(...)
  rule #visitTopDown(visitorResult(V, \or(.Patterns)) #as VR)
       => VR

  rule #visitTopDown(visitorResult(V, \or(P, Ps)))
    => #visitTopDownOr(.Patterns, visitTopDown(V, P), Ps)

  syntax VisitorResult
     ::= #visitTopDownOr(Patterns, VisitorResult, Patterns) [function]

  rule #visitTopDownOr(
         Ps1 => Ps1 ++Patterns P1,
         visitorResult(V, P1) => visitTopDown(V, P2),
         P2, Ps2 => Ps2
       )

  rule #visitTopDownOr(
         Ps,
         visitorResult(V, P),
         .Patterns
       ) => visitorResult(V, \or(Ps ++Patterns P))

  // symbol application
  rule #visitTopDown(visitorResult(V, _:Symbol(.Patterns)) #as VR)
       => VR

  rule #visitTopDown(visitorResult(V, S:Symbol(P, Ps)))
    => #visitTopDownSym(.Patterns, S, visitTopDown(V, P), Ps)

  syntax VisitorResult
     ::= #visitTopDownSym(Patterns, Symbol, VisitorResult, Patterns) [function]

  rule #visitTopDownSym(
         Ps1 => Ps1 ++Patterns P1,
         _,
         visitorResult(V, P1) => visitTopDown(V, P2),
         P2, Ps2 => Ps2
       )

  rule #visitTopDownSym(
         Ps,
         S,
         visitorResult(V, P),
         .Patterns
       ) => visitorResult(V, S(Ps ++Patterns P))


  // \implies(_, _)
  rule #visitTopDown(visitorResult(V,\implies(P1, P2)))
    => #visitTopDownImpl1(visitTopDown(V, P1), P2)

  syntax VisitorResult
         ::= #visitTopDownImpl1(VisitorResult, Pattern) [function]

  rule #visitTopDownImpl1(visitorResult(V, P1), P2)
    => #visitTopDownImpl2(P1, visitTopDown(V, P2))

  syntax VisitorResult
         ::= #visitTopDownImpl2(Pattern, VisitorResult) [function]
  rule #visitTopDownImpl2(P1, visitorResult(V, P2))
    => visitorResult(V, \implies(P1, P2))

  // \exists{_}_
  syntax VisitorResult
         ::= #visitTopDownExists(Patterns, VisitorResult) [function]
  rule #visitTopDown(visitorResult(V, \exists{Vars} P))
    => #visitTopDownExists(Vars, visitTopDown(V, P))

  rule #visitTopDownExists(Vars, visitorResult(V, P))
    => visitorResult(V, \exists{Vars} P)

  // \forall{_}_
  syntax VisitorResult
         ::= #visitTopDownForall(Patterns, VisitorResult) [function]
  rule #visitTopDown(visitorResult(V, \forall{Vars} P))
    => #visitTopDownForall(Vars, visitTopDown(V, P))

  rule #visitTopDownForall(Vars, visitorResult(V, P))
    => visitorResult(V, \forall{Vars} P)

  // \hole()
  rule #visitTopDown(visitorResult(_,\hole()) #as VR) => VR

  // \iff-lfp(_, _)
  rule #visitTopDown(visitorResult(V,\iff-lfp(P1, P2)))
    => #visitTopDownIffLfp1(visitTopDown(V, P1), P2)

  syntax VisitorResult
         ::= #visitTopDownIffLfp1(VisitorResult, Pattern) [function]

  rule #visitTopDownIffLfp1(visitorResult(V, P1), P2)
    => #visitTopDownIffLfp2(P1, visitTopDown(V, P2))

  syntax VisitorResult
         ::= #visitTopDownIffLfp2(Pattern, VisitorResult) [function]
  rule #visitTopDownIffLfp2(P1, visitorResult(V, P2))
    => visitorResult(V, \iff-lfp(P1, P2))

  // \typeof(_, _)
  rule #visitTopDown(visitorResult(V,\typeof(P1, S)))
    => #visitTopDownTypeof1(visitTopDown(V, P1), S)

  syntax VisitorResult
         ::= #visitTopDownTypeof1(VisitorResult, Sort) [function]

  rule #visitTopDownTypeof1(visitorResult(V, P1), S)
    => visitorResult(V, \typeof(P1, S))


```


```k
endmodule // VISITOR
```

An example visitor that counts the lenght of the pattern
```k
module PATTERN-LENGTH-SYNTAX
  imports INT

  syntax Pattern

  syntax Int ::= patternLength(Pattern) [function]

endmodule // PATTERN-LENGTH-SYNTAX

module PATTERN-LENGTH
  imports PATTERN-LENGTH-SYNTAX
  imports VISITOR-SYNTAX

  syntax Visitor ::= patternLengthVisitor(Int)

  syntax Int ::= patternLengthVisitorResult(VisitorResult) [function]

  rule patternLengthVisitorResult(
         visitorResult(
           patternLengthVisitor(N::Int),
           _
         )
       ) => N

  rule patternLength(P)
    => patternLengthVisitorResult(
         visitTopDown(patternLengthVisitor(0), P)
       )

  rule visit(patternLengthVisitor(N::Int), P)
       => visitorResult(patternLengthVisitor(N +Int 1), P)

endmodule
```

