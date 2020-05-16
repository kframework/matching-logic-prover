```k
module LOAD-NAMED-SYNTAX
  syntax AxiomOrClaimName

  syntax KItem ::= loadNamed(AxiomOrClaimName)

endmodule

module LOAD-NAMED-RULES
  imports LOAD-NAMED-SYNTAX
  imports PROVER-CORE

  rule <k> loadNamed(Name) => P ...</k>
       <goal>
         ...
         <id> Name </id>
         <claim> P </claim>
         <k> success </k>
         ...
       </goal>

  rule <k> loadNamed(Name) => P ...</k>
       <declaration> axiom Name : P </declaration>

  rule <k> loadNamed(Name) => P ...</k>
       <local-decl> axiom Name : P </local-decl>

endmodule
```
