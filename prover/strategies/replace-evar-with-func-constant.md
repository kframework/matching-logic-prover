```k
module STRATEGY-REPLACE-EVAR-WITH-FUNC-CONSTANT
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <strategy>
         replace-evar-with-func-constant V,Vs
         => #rewfc(V,Vs)
       ...</strategy> 

  rule <strategy>
         replace-evar-with-func-constant .Variables
         => #rewfc(PatternsToVariables(getFreeVariables(P, .Patterns)))
       ...</strategy>
       <claim> P </claim>

  syntax Variables ::= PatternsToVariables(Patterns) [function]
  rule PatternsToVariables(.Patterns) => .Variables
  rule PatternsToVariables(V{S}, Vs) => V{S}, PatternsToVariables(Vs)
  rule PatternsToVariables(_, Vs) => PatternsToVariables(Vs) [owise]


  syntax KItem ::= #rewfc(Variables)

  rule <strategy> #rewfc(.Variables) => noop ...</strategy>

  rule <strategy> (.K => #rewfc1(V))
               ~> #rewfc(V,Vs => Vs)
       ...</strategy>

  syntax KItem ::= #rewfc1(Variable)
                 | #rewfc2(Variable, Symbol)

  rule <strategy> #rewfc1(N{S} #as V)
               => #rewfc2(V, getFreshSymbol(
                               GId, VariableName2String(N)))
       ...</strategy>
       <id> GId </id>
       <claim> P </claim>
       requires V in getFreeVariables(P, .Patterns)

  rule <strategy> #rewfc2(N{S}, Sym) => .K ...</strategy>
       <claim> P => subst(P, N{S}, Sym(.Patterns)) </claim>
       <local-context> (.Bag =>
         <local-decl> symbol Sym(.Sorts) : S </local-decl>)
         ...
       </local-context>

  rule <strategy> #rewfc1(V) => "No such free variable"
       ...</strategy>
       <claim> P </claim>
       requires notBool (V in getFreeVariables(P, .Patterns))

endmodule
```
