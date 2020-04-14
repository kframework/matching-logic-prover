```
Gamma U {H} |- G where H closed predicate
---------------------
Gamma |- H -> G
```

```k
module STRATEGY-INTROS
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS

  rule <strategy> intros Name => noop ...</strategy>
       <k> \implies(H, G) => G </k>
       <local-context> (.Bag =>
         <local-decl> axiom Name : H </local-decl>
         ) ...
       </local-context>
       requires isClosed(H) andBool isPredicatePattern(H)

endmodule
```
