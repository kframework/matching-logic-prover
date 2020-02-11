```
Gamma, Phi(t) |- G where functional(t)
---------------------
Gamma, forall x. Phi(x) |- G
```

```k
module STRATEGY-INSTANTIATE-UNIVERSALS
  imports PROVER-CORE
  imports KORE-HELPERS
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy>
         instantiate-universals(in: _, vars: .VariableNames,
           with: .Patterns) => noop ...
       </strategy>

  rule <strategy>
         instantiate-universals(in: H, vars: (V, Vs), with: (T, Ts))
         => instantiate-universal V with T in H
         ~> instantiate-universals(in: H, vars: Vs, with: Ts)
         ...
       </strategy>

  syntax Bool ::= varIsInTopUnivQual(VariableName, Sort, Pattern) [function]

  rule varIsInTopUnivQual(N, S, \forall{N'{S'}, Vs} Phi)
       => #if N ==K N' #then
            S ==K S'
          #else
            varIsInTopUnivQual(N, S, \forall{Vs} Phi)
          #fi

  rule varIsInTopUnivQual(N, S, \forall{.Patterns} Phi)
       => varIsInTopUnivQual(N, S, Phi)

  syntax KItem ::= "instantiate-universal" VariableName
                      "with" Pattern "in" AxiomName

  rule <strategy>
         (.K => "Error: variable " ~> V ~> " is either not universally quantified in toplevel or has a sort other than " ~> getReturnSort(T))
         ~> instantiate-universal V with T in H
         ...
       </strategy>
       <local-decl>
         axiom H : Phi
       </local-decl>
       requires notBool varIsInTopUnivQual(V, getReturnSort(T), Phi)

  rule <strategy>
         (.K => "The term " ~> T ~> "is not known to be functional.")
         ~> instantiate-universal _ with T in H
         ...
       </strategy>
       <id> GId </id>
       requires notBool isFunctional(GId, T)

  rule <strategy>
         instantiate-universal V with T in H
         => .K ...
       </strategy>
       <local-decl>
         axiom H : (Phi => #instantiateUniv(Phi, V, T))
       </local-decl>
       <id> GId </id>
       requires varIsInTopUnivQual(V, getReturnSort(T), Phi)
             andBool isFunctional(GId, T)

  syntax Pattern ::= #instantiateUniv(Pattern, VariableName, Pattern) [function]

  rule #instantiateUniv(\forall{Vs} Phi, V, P)
       => stripEmptyForall(
            #if V in PatternsToVariableNameSet(Vs)
            #then \forall{#removeVar(Vs, V)} casubst(Phi, V, P)
            #else \forall{Vs} #instantiateUniv(Phi, V, P)
            #fi
          )

  syntax Patterns ::= #removeVar(Patterns, VariableName) [function]
  rule #removeVar(.Patterns, _) => .Patterns
  rule #removeVar((V{_},Ps), V) => #removeVar(Ps, V)
  rule #removeVar((P,Ps), V) => P, #removeVar(Ps, V) [owise]

  syntax Pattern ::= stripEmptyForall(Pattern) [function]
  rule stripEmptyForall(\forall{.Patterns} Phi) => Phi
  rule stripEmptyForall(Phi) => Phi [owise]

endmodule
```
