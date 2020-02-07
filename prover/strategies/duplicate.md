# duplicate

This strategy is useful in combination with strategies that modify
the proof context.

```
Gamma, Phi, Phi |- Psi
-----------------
Gamma, Phi |- Psi
```

```k
module STRATEGY-DUPLICATE
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports LOAD-NAMED-SYNTAX

  rule <strategy> duplicate H as H'
               => loadNamed(H) ~> #nameAs(H')
               ...
       </strategy>

  syntax KItem ::= #nameAs(AxiomName)

  rule <strategy> P ~> #nameAs(H') => noop ...</strategy>
       <local-context> (.Bag =>
         <local-decl> axiom H' : P </local-decl>
         ) ...
       </local-context>

endmodule
```
