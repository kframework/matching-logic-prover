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

  rule <k> duplicate H as H'
               => loadNamed(H) ~> #nameAs(H')
               ...
       </k>

  syntax KItem ::= #nameAs(AxiomName)

  rule <k> P ~> #nameAs(H') => noop ...</k>
       <local-context> (.Bag =>
         <local-decl> axiom H' : P </local-decl>
         ) ...
       </local-context>

endmodule
```
