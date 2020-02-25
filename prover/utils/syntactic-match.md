```k
module SYNTACTIC-MATCH-SYNTAX
  imports MATCHING-COMMON

  syntax MatchResult ::= "syntacticMatch"
                         "(" "terms:"     Patterns
                         "," "patterns:"  Patterns
                         "," "variables:" Patterns
                         ")" [function]

endmodule

module SYNTACTIC-MATCH-RULES
  imports SYNTACTIC-MATCH-SYNTAX

  rule syntacticMatch
       ( terms:     Ts
       , patterns:  Ps
       , variables: Vars
       ) =>
       #syntacticMatch
       ( terms:     Ts
       , patterns:  Ps
       , variables: Vars
       , subst:     .Map
       )

  syntax MatchResult ::= "#syntacticMatch"
                         "(" "terms:"     Patterns
                         "," "patterns:"  Patterns
                         "," "variables:" Patterns
                         "," "subst:"     Map
                         ")" [function]

  // Base case
  rule #syntacticMatch( terms:     .Patterns
                      , patterns:  .Patterns
                      , variables: Vs
                      , subst:     SUBST
                      )
    => #matchResult(subst: SUBST)

  rule #syntacticMatch( terms:     Ts
                      , patterns:  Ps
                      , variables: Vs
                      , subst:     SUBST
                      )
    => #matchFailure("Mismatch in length of arguments")
    requires (Ts ==K .Patterns orBool Ps ==K .Patterns)
     andBool notBool (Ts ==K .Patterns andBool Ps ==K .Patterns)

  // matching ints
  rule #syntacticMatch( terms:     N:Int, Ts => Ts
                      , patterns:  N:Int, Ps => Ps
                      , variables: _
                      , subst:     _
                      )

  // Non-matching ints
  rule #syntacticMatch( terms:     N:Int, _
                      , patterns:  M:Int, _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("Integers do not match")
    requires N =/=Int M

  // Non-matching ints
  rule #syntacticMatch( terms:     T, _
                      , patterns:  _:Int, _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("Not an integer")
    requires notBool isInt(T)

  // Non-matching constructors
  rule #syntacticMatch( terms:     S1:Symbol(_), _
                      , patterns:  S2:Symbol(_), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("Constructors do not match")
    requires S1 =/=K S2

  // Non-matching constructors
  rule #syntacticMatch( terms:     T, _
                      , patterns:  _:Symbol(_), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("Constructors do not match")
    requires notBool isApplication(T)

  rule #syntacticMatch( terms:     S:Symbol, Ts => Ts
                      , patterns:  S:Symbol, Ps => Ps
                      , variables: _
                      , subst:     _
                      )
    requires S =/=K sep

  // Constructors match: Recurse over arguments
  rule #syntacticMatch( terms:     S:Symbol(T_ARGs), Ts
                            => T_ARGs ++Patterns Ts
                      , patterns:  S:Symbol(P_ARGs), Ps
                            => P_ARGs ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )
    requires S =/=K sep

  // ground variable: mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  P:Variable, _
                      , variables: Vs
                      , subst:     _
                      )
    => #matchFailure("Variable does not match")
    requires T =/=K P
     andBool notBool P in Vs

  // ground variable: identical
  rule #syntacticMatch( terms:     P:Variable, Ts => Ts
                      , patterns:  P:Variable, Ps => Ps
                      , variables: Vs
                      , subst:     _
                      )
    requires notBool P in Vs

  // ground variable: identical
  rule #syntacticMatch( terms:     P:SetVariable, Ts => Ts
                      , patterns:  P:SetVariable, Ps => Ps
                      , variables: Vs
                      , subst:     _
                      )
    requires notBool P in Vs

  // ground variable: non-identical
  rule #syntacticMatch( terms:     T, _
                      , patterns:  P:Variable, _
                      , variables: Vs
                      , subst:     _
                      )
    => #matchFailure( "No valid substitution" )
    requires T =/=K P
     andBool notBool P in Vs
     
  // ground variable: non-identical
  rule #syntacticMatch( terms:     T, _
                      , patterns:  P:SetVariable, _
                      , variables: Vs
                      , subst:     _
                      )
    => #matchFailure( "No valid substitution" )
    requires T =/=K P
     andBool notBool P in Vs

  // free variable: different sorts
  rule #syntacticMatch( terms:     T, _
                      , patterns:  P:Variable, _
                      , variables: Vs
                      , subst:     _
                      )
    => #matchFailure("Variable sort does not match term")
    requires T =/=K P
     andBool P in Vs
     andBool getReturnSort(T) =/=K getReturnSort(P)

  // free variable: extend substitution
  // TODO restrict to functional terms
  rule #syntacticMatch( terms:     T, Ts => Ts
                      , patterns:  P:Variable, Ps
                        => substPatternsMap(Ps, P |-> T)
                      , variables: Vs
                      , subst:     SUBST => ((P |-> T) SUBST)
                      )
    requires T =/=K P
     andBool P in Vs
     andBool getReturnSort(T) ==K getReturnSort(P)

  rule #syntacticMatch( terms:     T, Ts => Ts
                      , patterns:  P:SetVariable, Ps
                        => substPatternsMap(Ps, P |-> T)
                      , variables: Vs
                      , subst:     SUBST => ((P |-> T) SUBST)
                      )
    requires T =/=K P
     andBool P in Vs

  // A lot of repetetive code below.
  // This could be reduced if we had a generic support
  // for notations.

  // \equals(_,_) matched
  rule #syntacticMatch( terms:     \equals(T1, T2), Ts
                               => T1 ++Patterns T2 ++Patterns Ts
                      , patterns:  \equals(P1, P2), Ps
                               => P1 ++Patterns P2 ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \equals(_,_) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \equals(...), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\equals(_,_) does not match")
    requires \equals(...) :/=K T

  // \not(_) matched
  rule #syntacticMatch( terms:     \not(T), Ts
                               => T ++Patterns Ts
                      , patterns:   \not(P), Ps
                               => P ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \not(_) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \not(_), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\not(_) does not match")
    requires \not(...) :/=K T

  // \and(...) matched
  rule #syntacticMatch( terms:     \and(T_ARGS), Ts
                               => T_ARGS ++Patterns Ts
                      , patterns:  \and(P_ARGS), Ps
                               => P_ARGS ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \and(...) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \and(_), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\and(...) does not match")
    requires \and(...) :/=K T

  // \or(...) matched
  rule #syntacticMatch( terms:     \or(T_ARGS), Ts
                               => T_ARGS ++Patterns Ts
                      , patterns:  \or(P_ARGS), Ps
                               => P_ARGS ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \or(_) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:   \or(_), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\or(...) does not match")
    requires \or(...) :/=K T

  // \implies(_,_) matched
  rule #syntacticMatch( terms:     \implies(T1, T2), Ts
                               => T1 ++Patterns T2 ++Patterns Ts
                      , patterns:  \implies(P1, P2), Ps
                               => P1 ++Patterns P2 ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \implies(_,_) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \implies(...), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\implies(_,_) does not match")
    requires \implies(...) :/=K T

  // \exists{_}_ matched
  rule #syntacticMatch( terms:     \exists{TVARS} T, Ts
                      , patterns:  \exists{PVARS} P, Ps
                      , variables: VARS
                      , subst:     SUBST
                      )
       => syntacticMatchForallExists
            ( term:         T
            , pattern:      P
            , termVars:     TVARS
            , patternVars:  PVARS
            , variables:    VARS
            , subst:        SUBST
            , thenTerms:    Ts
            , thenPatterns: Ps
            )


  // \exists{_}_ mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \exists{_} _, _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\exists{_}_ does not match")
    requires \exists{_}_ :/=K T

  // \forall{_}_ matched
  rule #syntacticMatch( terms:     \forall{TVARS} T, Ts
                      , patterns:   \forall{PVARS} P, Ps
                      , variables: VARS
                      , subst:     SUBST
                      )
       => syntacticMatchForallExists
            ( term:         T
            , pattern:      P
            , termVars:     TVARS
            , patternVars:  PVARS
            , variables:    VARS
            , subst:        SUBST
            , thenTerms:    Ts
            , thenPatterns: Ps
            )


  // \exists{_}_ mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \forall{_} _, _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\forall{_}_ does not match")
    requires \forall{_}_ :/=K T

  syntax MatchResult ::= "syntacticMatchForallExists"
                   "(" "term:"         Pattern
                   "," "pattern:"      Pattern
                   "," "termVars:"     Patterns
                   "," "patternVars:"  Patterns
                   "," "variables:"    Patterns
                   "," "subst:"        Map
                   "," "thenTerms:"    Patterns
                   "," "thenPatterns:" Patterns
                   ")" [function]

  rule syntacticMatchForallExists
       ( term:         T
       , pattern:      P
       , termVars:     TVARS
       , patternVars:  PVARS
       , variables:    VARS
       , subst:        SUBST
       , thenTerms:    Ts
       , thenPatterns: Ps
       )
       =>
       #syntacticMatchForallExists
       ( term:         T
       , pattern:      P
       , termVars:     TVARS
       , patternVars:  PVARS
       , variables:    VARS
       , subst:        SUBST
       , thenTerms:    Ts
       , thenPatterns: Ps
       , matchResult:
           #syntacticMatch
           ( terms:     TVARS ++Patterns T
           , patterns:  PVARS ++Patterns P
           , variables: VARS ++Patterns PVARS
           , subst:     removeAll(SUBST, PatternsToSet(PVARS))
           )
       )

  syntax MatchResult ::= "#syntacticMatchForallExists"
                   "(" "term:"         Pattern
                   "," "pattern:"      Pattern
                   "," "termVars:"     Patterns
                   "," "patternVars:"  Patterns
                   "," "variables:"    Patterns
                   "," "subst:"        Map
                   "," "thenTerms:"    Patterns
                   "," "thenPatterns:" Patterns
                   "," "matchResult:"  K
                   ")" [function]

  rule #syntacticMatchForallExists
       ( term:         _
       , pattern:      _
       , termVars:     _
       , patternVars:  _
       , variables:    _
       , subst:        _
       , thenTerms:    _
       , thenPatterns: _
       , matchResult:  #matchFailure(S)
       ) => #matchFailure(
          "Failure matching forall/exists: " +String S)

  rule #syntacticMatchForallExists
       ( term:         _
       , pattern:      _
       , termVars:     _
       , patternVars:  PVARS
       , variables:    VARS
       , subst:        SUBST
       , thenTerms:    Ts
       , thenPatterns: Ps
       , matchResult:  #matchResult(subst: RESULT)
       ) =>
       #syntacticMatch
       ( terms:     Ts
       , patterns:   Ps
       , variables: VARS
       , subst:     updateMap(
                      removeAll(RESULT, PatternsToSet(PVARS)), SUBST)
       )

  // \typeof(_,_) matched
  rule #syntacticMatch( terms:     \typeof(T, S), Ts
                               => T  ++Patterns Ts
                      , patterns:  \typeof(P, S), Ps
                               => P ++Patterns Ps
                      , variables: _
                      , subst:     _
                      )

  // \typeof(_,_) missmatched - different sorts
  rule #syntacticMatch( terms:     \typeof(_, S1), _
                      , patterns:  \typeof(_, S2), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\typeof(_,_) sorts do not match")
    requires S1 =/=K S2


  // \typeof(_,_) mismatched
  rule #syntacticMatch( terms:     T, _
                      , patterns:  \typeof(...), _
                      , variables: _
                      , subst:     _
                      )
    => #matchFailure("\\typeof(_,_) does not match")
    requires \typeof(...) :/=K T



endmodule
```
