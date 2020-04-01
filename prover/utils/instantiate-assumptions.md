```k
module INSTANTIATE-ASSUMPTIONS-SYNTAX
  imports MAP
  imports ERROR

  syntax Pattern
  syntax Patterns
  syntax GoalId

  syntax InstantiateAssumptionsResult
    ::= #instantiateAssumptionsResult(Patterns, Map)
      | Error
      | instantiateAssumptions(GoalId, Map, Pattern) [function]

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
    ::= #instantiateAssumptions1(GoalId, Map, Patterns) [function]
      | #instantiateAssumptions2(GoalId, Patterns, Map, Patterns) [function]

  rule instantiateAssumptions(GId, Subst, P)
    => #instantiateAssumptions1(GId, Subst, unrollImplicationChain(P))

  rule #instantiateAssumptions1(GId, Subst, Conclusion, Assumptions)
    => #instantiateAssumptions2(GId, .Patterns, Subst, Assumptions)

  rule #instantiateAssumptions2(
         GId, Instantiated::Patterns, Subst::Map, .Patterns)
       => #instantiateAssumptionsResult(Instantiated, Subst)

  rule #instantiateAssumptions2(
         GId,
         Instantiated::Patterns,
         Subst::Map,
         \implies(L, _), Ps
       ) => #instantiateAssumptions2 (
         GId,
         substMap(L, Subst) ++Patterns Instantiated,
         Subst,
         Ps
       )

  rule #instantiateAssumptions2(
         GId,
         Instantiated::Patterns,
         Subst::Map,
         \forall{Vars} _, Ps
       ) => #if PatternsToSet(Vars) <=Set keys(Subst)
            #then
              #instantiateAssumptions2(
                GId,
                functionalObligations(GId, Subst, Vars) ++Patterns Instantiated,
                removeAll(Subst, PatternsToSet(Vars)),
                Ps
              )
            #else
              #error("Unable to find an instance for variables: "
                    ~> PatternsToSet(Vars) -Set keys(Subst))
            #fi


  syntax Patterns ::= functionalObligations(GoalId, Map, Patterns) [function]

  rule functionalObligations(_, _, .Patterns) => .Patterns

  rule functionalObligations(GId, Subst, _:SetVariable, Ps)
    => functionalObligations(GId, Subst, Ps)

  rule functionalObligations(GId, Subst, V{S}, Ps)
    => #if isFunctional(GId, {Subst[V{S}]}:>Pattern)
       #then functionalObligations(GId, Subst, Ps)
       #else \functionalPattern({Subst[V{S}]}:>Pattern),
             functionalObligations(GId, Subst, Ps)
       #fi




endmodule
```
