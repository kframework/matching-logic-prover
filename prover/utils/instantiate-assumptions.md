```k
module INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports MAP
  syntax Pattern
  syntax Patterns

  syntax InstantiateAssumptionsResult
    ::= ok(Patterns, Map) | error(K)
      | instantiateAssumptions(Map, Pattern) [function]

endmodule

module INSTANTIATE-ASSUMPTIONS-RULES
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports KORE-HELPERS


  // transforms '\forall x. (P -> (Q -> R))'
  // into: 'R, Q -> R, P -> (Q -> R), \forall x. P -> (Q -> R)'
  syntax Patterns ::= unfoldInsideOut(Pattern) [function]
                    | #unfoldInsideOut(Patterns) [function]

  rule unfoldInsideOut(P)
    => #unfoldInsideOut(P, .Patterns)

  rule #unfoldInsideOut(P, Ps) => P, Ps
       requires \implies(_,_) :/=K P
        andBool \forall{_}_ :/=K P

  rule #unfoldInsideOut(\implies(L, R), Ps)
    => #unfoldInsideOut(R, \implies(L, R), Ps)

  rule #unfoldInsideOut(\forall{Vars} P, Ps)
    => #unfoldInsideOut(P, \forall{Vars} P, Ps)
```

Subgoal generation: we start with the conclusion and substitution,
go from the bottom up, use the substitution
to instantiate left sides of implications, and at every \forall
we remove the bound variables from the substitution.
This way we do not instantiate free variables whose name coincides
with bound ones.

```k
  syntax InstantiateAssumptionsResult
    ::= #instantiateAssumptions1(Map, Patterns) [function]
      | #instantiateAssumptions2(Patterns, Map, Patterns) [function]

  rule instantiateAssumptions(Subst, P)
    => #instantiateAssumptions1(Subst, unfoldInsideOut(P))

  rule #instantiateAssumptions1(Subst, Conclusion, Assumptions)
    => #instantiateAssumptions2(.Patterns, Subst, Assumptions)

  rule #instantiateAssumptions2(
         Instantiated::Patterns, Subst::Map, .Patterns)
       => ok(Instantiated, Subst)

  rule #instantiateAssumptions2(
         Instantiated::Patterns,
         Subst::Map,
         \implies(L, _), Ps
       ) => #instantiateAssumptions2 (
         substMap(L, Subst) ++Patterns Instantiated,
         Subst,
         Ps
       )

  rule #instantiateAssumptions2(
         Instantiated::Patterns,
         Subst::Map,
         \forall{Vars} _, Ps
       ) => #if PatternsToSet(Vars) <=Set keys(Subst)
            #then
              #instantiateAssumptions2(
                Instantiated,
                removeAll(Subst, PatternsToSet(Vars)),
                Ps
              )
            #else
              error("Unable to find an instance for variables: "
                    ~> PatternsToSet(Vars) -Set keys(Subst))
            #fi



endmodule
```
