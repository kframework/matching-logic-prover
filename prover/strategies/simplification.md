These strategies encompass a variety of simplification strategies

```k
module STRATEGY-SIMPLIFICATION
  imports PROVER-CORE
  imports PROVER-HORN-CLAUSE-SYNTAX
  imports KORE-HELPERS
```

### Simplify

Remove trivial clauses from the right-hand-side:

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies(\and(LHS), \and(RHS -BasicPatterns LHS)) ...
       </k>
       <strategy> simplify => noop ... </strategy>
```

### Instantiate Existials

       LHS -> \exists x. x = t(...) /\ REST
    => LHS /\ x = t(...) -> REST

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => #fun( INSTANTIATION => 
                   \implies( \and(LHS ++BasicPatterns INSTANTIATION)
                           , \and(RHS -BasicPatterns INSTANTIATION)
                           )
               )
               ( getAtomForcingInstantiation( RHS
                                            , getFreeVariables(LHS)
                                            , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                            )
               )
       </k>
       <strategy> instantiate-existentials ... </strategy>
       [owise]

  rule <k> \implies(\and(LHS), \and(RHS))
       </k>
       <strategy> instantiate-existentials => noop ... </strategy>
    requires .Patterns
         ==K getAtomForcingInstantiation( RHS
                                        , getFreeVariables(LHS)
                                        , getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS)
                                        )

  syntax BasicPatterns ::= getAtomForcingInstantiation(BasicPatterns, BasicPatterns, BasicPatterns) [function]
  rule getAtomForcingInstantiation((\equals(X:Variable, P), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((\equals(P, X:Variable), Ps), FREE, EXISTENTIAL)
    => \equals(X:Variable, P), .Patterns
    requires X inPatterns EXISTENTIAL
     andBool getFreeVariables(P, .Patterns) -BasicPatterns EXISTENTIAL ==K getFreeVariables(P, .Patterns)
  rule getAtomForcingInstantiation((P, Ps), FREE, EXISTENTIAL)
    => getAtomForcingInstantiation(Ps, FREE, EXISTENTIAL) [owise]
  rule getAtomForcingInstantiation(.Patterns, FREE, EXISTENTIAL)
    => .Patterns
```

### Substitute Equals for equals

```k
  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies( \and(removeTrivialEqualities(LHS[?EQUALITY_SUBST]))
                   , \and(removeTrivialEqualities(RHS[?EQUALITY_SUBST]))
                   ) ...
       </k>
       <strategy> substitute-equals-for-equals ... </strategy>
    requires ?EQUALITY_SUBST ==K makeEqualitySubstitution(LHS)
     andBool ?EQUALITY_SUBST =/=K .Map

  rule <k> \implies(\and(LHS), \and(RHS))
        => \implies( \and(removeTrivialEqualities(LHS[?EQUALITY_SUBST]))
                   , \and(removeTrivialEqualities(RHS[?EQUALITY_SUBST]))
                   ) ...
       </k>
       <strategy> substitute-equals-for-equals ... </strategy>
    requires ?EQUALITY_SUBST ==K makeExistentialSubstitution(RHS, getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS))
     andBool ?EQUALITY_SUBST =/=K .Map

  rule <k> \implies(\and(LHS), \and(RHS)) ... </k>
       <strategy> substitute-equals-for-equals => simplify ... </strategy>
    requires .Map ==K makeEqualitySubstitution(LHS)
     andBool .Map ==K makeExistentialSubstitution(RHS, getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS))

  syntax Map ::= makeEqualitySubstitution(BasicPatterns) [function]
  rule makeEqualitySubstitution(.Patterns) => .Map
  rule makeEqualitySubstitution(\equals(X:Variable, T), Ps) => (X |-> T) .Map
  rule makeEqualitySubstitution(\equals(T, X:Variable), Ps) => (X |-> T) .Map
    requires notBool(isVariable(T))
  rule makeEqualitySubstitution((P, Ps:BasicPatterns)) => makeEqualitySubstitution(Ps) [owise]

  syntax Map ::= makeExistentialSubstitution(BasicPatterns, BasicPatterns) [function]
  rule makeExistentialSubstitution(.Patterns, EVs) => .Map
  rule makeExistentialSubstitution((\equals(X:Variable, T), Ps), EVs) => (X |-> T) .Map
    requires X in EVs
  rule makeExistentialSubstitution((\equals(T, X:Variable), Ps), EVs) => (X |-> T) .Map
    requires X in EVs
     andBool notBool(T in EVs)
  rule makeExistentialSubstitution((P, Ps:BasicPatterns), EVs)
    => makeExistentialSubstitution(Ps, EVs) [owise]

  syntax BasicPatterns ::= removeTrivialEqualities(BasicPatterns) [function]
  rule removeTrivialEqualities(.Patterns) => .Patterns
  rule removeTrivialEqualities(\equals(X, X), Ps) => removeTrivialEqualities(Ps)
  rule removeTrivialEqualities(P, Ps) => P, removeTrivialEqualities(Ps) [owise]
```

```k
endmodule
```
