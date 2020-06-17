```
Gamma U {functional f} |- PHI(f()) where f fresh
------------------------------------------------
Gamma |- PHI(x:S)
```

```k
module STRATEGY-REPLACE-EVAR-WITH-FUNC-CONSTANT
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <k>
         replace-evar-with-func-constant V,Vs
         => #rewfc(V,Vs)
       ...</k> 

  rule <k>
         replace-evar-with-func-constant .Variables
         => #rewfc(PatternsToVariables(getFreeVariables(P, .Patterns)))
       ...</k>
       <claim> P </claim>

  syntax Variables ::= PatternsToVariables(Patterns) [function]
  rule PatternsToVariables(.Patterns) => .Variables
  rule PatternsToVariables(V{S}, Vs) => V{S}, PatternsToVariables(Vs)
  rule PatternsToVariables(_, Vs) => PatternsToVariables(Vs) [owise]


  syntax KItem ::= #rewfc(Variables)

  rule <k> #rewfc(.Variables) => noop ...</k>

  rule <k> (.K => #rewfc1(V))
               ~> #rewfc(V,Vs => Vs)
       ...</k>

  syntax KItem ::= #rewfc1(Variable)
                 | #rewfc2(Variable, Symbol)

  rule <k> #rewfc1(N{S} #as V)
               => #rewfc2(V, getFreshSymbol(
                               GId, VariableNameToString(N)))
       ...</k>
       <id> GId </id>
       <claim> P </claim>
       requires V in getFreeVariables(P, .Patterns)

  rule <k> #rewfc2(N{S}, symbol(Sym)) => .K ...</k>
       <id> GId </id>
       <claim> P => subst(P, N{S}, symbol(Sym)(.Patterns)) </claim>
       <local-context> (.Bag =>
         <local-decl> symbol Sym(.Sorts) : S </local-decl>
         <local-decl>
           axiom getFreshAxiomName(GId) : functional(Sym)
         </local-decl>)
         ...
       </local-context>

  rule <k> #rewfc1(V) => "No such free variable"
       ...</k>
       <claim> P </claim>
       requires notBool (V in getFreeVariables(P, .Patterns))

endmodule
```
