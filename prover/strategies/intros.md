```k
module STRATEGY-INTROS
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports KORE-HELPERS

  rule <strategy> intros Name => noop ...</strategy>
       <claim> \implies(H, G) => G </claim>
       <local-context> (.Bag =>
         <local-decl> axiom Name : H </local-decl>
         ) ...
       </local-context>
       requires isClosed(H) andBool isPredicatePattern(H)

endmodule
```
