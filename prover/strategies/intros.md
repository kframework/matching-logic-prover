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

  rule <k> intros Name => noop ...</k>
       <claim> \implies(H, G) => G </claim>
       <local-context> (.Bag =>
         <local-decl> axiom Name : H </local-decl>
         ) ...
       </local-context>
       requires isClosed(H) andBool isPredicatePattern(H)

endmodule
```
