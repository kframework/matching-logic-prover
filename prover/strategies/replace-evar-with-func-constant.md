```
Gamma U {functional f} |- PHI(f()) where f fresh
------------------------------------------------
Gamma |- PHI(x:S)
```

```k
module STRATEGY-REPLACE-EVAR-WITH-FUNC-CONSTANT
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy>
         replace-evar-with-func-constant V,Vs
         => #rewfc(V,Vs)
       ...</strategy> 

  rule <strategy>
         replace-evar-with-func-constant .Patterns
         => #rewfc(getFreeVariables(P, .Patterns))
       ...</strategy>
       <claim> P </claim>

  syntax KItem ::= #rewfc(Patterns)

  rule <strategy> #rewfc(.Patterns) => noop ...</strategy>

  rule <strategy> (.K => #rewfc1(V))
               ~> #rewfc(V,Vs => Vs)
       ...</strategy>

  syntax KItem ::= #rewfc1(Pattern)
                 | #rewfc2(Pattern, Symbol)

  rule <strategy> #rewfc1(N{S} #as V)
               => #rewfc2(V, getFreshSymbol(
                               GId, VariableName2String(N)))
       ...</strategy>
       <id> GId </id>
       <claim> P </claim>
       requires V in getFreeVariables(P, .Patterns)

  rule <strategy> #rewfc2(N{S}, Sym) => .K ...</strategy>
       <id> GId </id>
       <claim> P => subst(P, N{S}, Sym(.Patterns)) </claim>
       <local-context> (.Bag =>
         <local-decl> symbol Sym(.Sorts) : S </local-decl>
         <local-decl>
           axiom getFreshAxiomName(GId) : functional(Sym)
         </local-decl>)
         ...
       </local-context>

  rule <strategy> #rewfc1(V) => "No such free variable"
       ...</strategy>
       <claim> P </claim>
       requires notBool (V in getFreeVariables(P, .Patterns))

endmodule
```
