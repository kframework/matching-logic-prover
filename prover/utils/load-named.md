```k
module LOAD-NAMED-SYNTAX
  syntax AxiomOrClaimName

  syntax KItem ::= loadNamed(AxiomOrClaimName)

endmodule

module LOAD-NAMED-RULES
  imports LOAD-NAMED-SYNTAX
  imports PROVER-CORE

  rule <strategy> loadNamed(Name) => P ...</strategy>
       <goal>
         ...
         <id> Name </id>
         <k> P </k>
         <strategy> success </strategy>
         ...
       </goal>

  rule <strategy> loadNamed(Name) => P ...</strategy>
       <declaration> axiom Name : P </declaration>

  rule <strategy> loadNamed(Name) => P ...</strategy>
       <local-decl> axiom Name : P </local-decl>

endmodule
```
