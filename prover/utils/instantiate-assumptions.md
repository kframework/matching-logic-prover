```k
module INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports MAP
  imports ERROR

  syntax Pattern
  syntax Patterns

  syntax InstantiateAssumptionsResult
    ::= #instantiateAssumptionsResult(Patterns, Map)
      | Error
      | instantiateAssumptions(Map, Pattern) [function]

endmodule

module INSTANTIATE-ASSUMPTIONS-RULES
  imports INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports KORE-HELPERS


  // transforms '\forall x. (P -> (Q -> R))'
  // into: 'R, Q -> R, P -> (Q -> R), \forall x. P -> (Q -> R)'
  syntax Patterns ::= unrollImplicationChain(Pattern) [function]
                    | #unrollImplicationChain(Patterns) [function]

  rule unrollImplicationChain(P)
    => #unrollImplicationChain(P, .Patterns)

  rule #unrollImplicationChain(P, Ps) => P, Ps
       requires \implies(_,_) :/=K P
        andBool \forall{_}_ :/=K P

  rule #unrollImplicationChain(\implies(L, R), Ps)
    => #unrollImplicationChain((R, \implies(L, R), Ps))

  rule #unrollImplicationChain(\forall{Vars} P, Ps)
    => #unrollImplicationChain((P, \forall{Vars} P, Ps))
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
    => #instantiateAssumptions1(Subst, unrollImplicationChain(P))

  rule #instantiateAssumptions1(Subst, Conclusion, Assumptions)
    => #instantiateAssumptions2(.Patterns, Subst, Assumptions)

  rule #instantiateAssumptions2(
         Instantiated::Patterns, Subst::Map, .Patterns)
       => #instantiateAssumptionsResult(Instantiated, Subst)

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
              #error("Unable to find an instance for variables: "
                    ~> PatternsToSet(Vars) -Set keys(Subst))
            #fi



endmodule
```
